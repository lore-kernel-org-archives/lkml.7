Return-Path: <SRS0=N68d=SK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D2177C10F13
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Apr 2019 14:19:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AF4AA21473
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Apr 2019 14:19:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726763AbfDHOTy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Apr 2019 10:19:54 -0400
Received: from mx1.redhat.com ([209.132.183.28]:30939 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726349AbfDHOTy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Apr 2019 10:19:54 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id E03DC308FC5E;
        Mon,  8 Apr 2019 14:19:53 +0000 (UTC)
Received: from prarit.bos.redhat.com (prarit-guest.khw1.lab.eng.bos.redhat.com [10.16.200.63])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 5EF9B60472;
        Mon,  8 Apr 2019 14:19:53 +0000 (UTC)
Subject: Re: [PATCH] modules: Only return -EEXIST for modules that have
 finished loading
To:     linux-kernel@vger.kernel.org
Cc:     cavery@redhat.com, Jessica Yu <jeyu@kernel.org>
References: <20190402133916.13513-1-prarit@redhat.com>
From:   Prarit Bhargava <prarit@redhat.com>
Message-ID: <ccfaafb0-870a-8cc0-bf17-f4b1edb59883@redhat.com>
Date:   Mon, 8 Apr 2019 10:19:52 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <20190402133916.13513-1-prarit@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.43]); Mon, 08 Apr 2019 14:19:53 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Jessica?  ping?

P.

On 4/2/19 9:39 AM, Prarit Bhargava wrote:
> Microsoft HyperV disables the X86_FEATURE_SMCA bit on AMD systems, and
> linux guests boot with repeated errors:
> 
> amd64_edac_mod: Unknown symbol amd_unregister_ecc_decoder (err -2)
> amd64_edac_mod: Unknown symbol amd_register_ecc_decoder (err -2)
> amd64_edac_mod: Unknown symbol amd_report_gart_errors (err -2)
> amd64_edac_mod: Unknown symbol amd_unregister_ecc_decoder (err -2)
> amd64_edac_mod: Unknown symbol amd_register_ecc_decoder (err -2)
> amd64_edac_mod: Unknown symbol amd_report_gart_errors (err -2)
> 
> The warnings occur because the module code erroneously returns -EEXIST
> for modules that have failed to load and are in the process of being
> removed from the module list.
> 
> module amd64_edac_mod has a dependency on module edac_mce_amd.  Using
> modules.dep, systemd will load edac_mce_amd for every request of
> amd64_edac_mod.  When the edac_mce_amd module loads, the module has
> state MODULE_STATE_UNFORMED and once the module load fails and the state
> becomes MODULE_STATE_GOING.  Another request for edac_mce_amd module
> executes and add_unformed_module() will erroneously return -EEXIST even
> though the previous instance of edac_mce_amd has MODULE_STATE_GOING.
> Upon receiving -EEXIST, systemd attempts to load amd64_edac_mod, which
> fails because of unknown symbols from edac_mce_amd.
> 
> add_unformed_module() must wait to return for any case other than
> MODULE_STATE_LIVE to prevent a race between multiple loads of
> dependent modules.
> 
> Signed-off-by: Prarit Bhargava <prarit@redhat.com>
> Reported-by: Cathy Avery <cavery@redhat.com>
> Cc: Jessica Yu <jeyu@kernel.org>
> ---
>  kernel/module.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
> 
> diff --git a/kernel/module.c b/kernel/module.c
> index 0b9aa8ab89f0..e8c1de2ab4e1 100644
> --- a/kernel/module.c
> +++ b/kernel/module.c
> @@ -3566,8 +3566,7 @@ static int add_unformed_module(struct module *mod)
>  	mutex_lock(&module_mutex);
>  	old = find_module_all(mod->name, strlen(mod->name), true);
>  	if (old != NULL) {
> -		if (old->state == MODULE_STATE_COMING
> -		    || old->state == MODULE_STATE_UNFORMED) {
> +		if (old->state != MODULE_STATE_LIVE) {
>  			/* Wait in case it fails to load. */
>  			mutex_unlock(&module_mutex);
>  			err = wait_event_interruptible(module_wq,
> 

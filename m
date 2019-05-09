Return-Path: <SRS0=2Nly=TJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	T_DKIMWL_WL_HIGH,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 93DA7C04AB1
	for <linux-kernel@archiver.kernel.org>; Thu,  9 May 2019 13:53:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 653312173B
	for <linux-kernel@archiver.kernel.org>; Thu,  9 May 2019 13:53:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1557410020;
	bh=5bgQ6CHqRJTKqil2SYpOdeiLLfAUR1hz6lrikzEL1R8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=ljb8hxg+x4mOVQ31/hLNJ4fhYNsONobE0ymHxhFn2owq5YlC+i27szondvbD1N7Kp
	 f4Sv3Q3ZikjcTQVu2yizrFRkj73S9ml7jUBH31Q+KLZZAPuDQAfrA46SxFAxbWF9tT
	 zygudinG7OH2qe+RSOmUfxoMVUIRCxG/vy5CTlQw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726650AbfEINxj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 May 2019 09:53:39 -0400
Received: from mail.kernel.org ([198.145.29.99]:42776 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726192AbfEINxj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 May 2019 09:53:39 -0400
Received: from linux-8ccs (ip5f5adeaa.dynamic.kabel-deutschland.de [95.90.222.170])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 46F8120675;
        Thu,  9 May 2019 13:53:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1557410018;
        bh=5bgQ6CHqRJTKqil2SYpOdeiLLfAUR1hz6lrikzEL1R8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=LlWIUdggLWAE6LoVh7f4hVZUYYoNDUd+InUDc8WAv8kUZ6qdyGYx54sIYhSa3EDfZ
         csGB/Xw6OCdoqjS8Id/j4Vk4LxmNNthp/3ib5iqE6MiyTVB5tUv+8PChj8ry4APTHB
         7Dp43vqFTtWzvYv4S18Yl5BeNqaV67n3DrrlEF5k=
Date:   Thu, 9 May 2019 15:53:34 +0200
From:   Jessica Yu <jeyu@kernel.org>
To:     Prarit Bhargava <prarit@redhat.com>
Cc:     linux-kernel@vger.kernel.org,
        Heiko Carstens <heiko.carstens@de.ibm.com>,
        David Arcari <darcari@redhat.com>
Subject: Re: [PATCH v2] modules: Only return -EEXIST for modules that have
 finished loading
Message-ID: <20190509135333.GA9337@linux-8ccs>
References: <20190507145413.16297-1-prarit@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20190507145413.16297-1-prarit@redhat.com>
X-OS:   Linux linux-8ccs 5.1.0-rc1-lp150.12.28-default+ x86_64
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

+++ Prarit Bhargava [07/05/19 10:54 -0400]:
>Heiko, it would still be good to get a test of this patch from you.  I
>tested this here at Red Hat on some System Z machines.  Without the
>modification made here in v2, the systems failed to boot ~10% of the time.
>After the modification I do not see any boot failures.  I also was
>able to reproduce the boot issue with the acpi_cpufreq driver on a very
>large & fast x86 system which had closer to 100% failure rate without
>the changes in v2.  After the modification in v2 the system has rebooted
>all weekend without any issues.
>
>P.
>
>---8<---
>
>Microsoft HyperV disables the X86_FEATURE_SMCA bit on AMD systems, and
>linux guests boot with repeated errors:
>
>amd64_edac_mod: Unknown symbol amd_unregister_ecc_decoder (err -2)
>amd64_edac_mod: Unknown symbol amd_register_ecc_decoder (err -2)
>amd64_edac_mod: Unknown symbol amd_report_gart_errors (err -2)
>amd64_edac_mod: Unknown symbol amd_unregister_ecc_decoder (err -2)
>amd64_edac_mod: Unknown symbol amd_register_ecc_decoder (err -2)
>amd64_edac_mod: Unknown symbol amd_report_gart_errors (err -2)
>
>The warnings occur because the module code erroneously returns -EEXIST
>for modules that have failed to load and are in the process of being
>removed from the module list.
>
>module amd64_edac_mod has a dependency on module edac_mce_amd.  Using
>modules.dep, systemd will load edac_mce_amd for every request of
>amd64_edac_mod.  When the edac_mce_amd module loads, the module has
>state MODULE_STATE_UNFORMED and once the module load fails and the state
>becomes MODULE_STATE_GOING.  Another request for edac_mce_amd module
>executes and add_unformed_module() will erroneously return -EEXIST even
>though the previous instance of edac_mce_amd has MODULE_STATE_GOING.
>Upon receiving -EEXIST, systemd attempts to load amd64_edac_mod, which
>fails because of unknown symbols from edac_mce_amd.
>
>add_unformed_module() must wait to return for any case other than
>MODULE_STATE_LIVE to prevent a race between multiple loads of
>dependent modules.
>
>v2: The initial (old->state != MODULE_STATE_LIVE) change exposed an
>additional issue in the code.  wait_event_interruptible() puts each thread
>to sleep until the a module finishes loading an executes the module_wq
>workqueue.  The result is a long delay during the boot.  Switching to
>wait_event_interruptible_timeout() resolves the sleep problem.
>
>Signed-off-by: Prarit Bhargava <prarit@redhat.com>
>Cc: Jessica Yu <jeyu@kernel.org>
>Cc: Heiko Carstens <heiko.carstens@de.ibm.com>
>Cc: David Arcari <darcari@redhat.com>

Hi Prarit,

Thanks a lot for the revised patch. I'll queue this up right after the
merge window is over.

Thanks!

Jessica

>---
> kernel/module.c | 8 ++++----
> 1 file changed, 4 insertions(+), 4 deletions(-)
>
>diff --git a/kernel/module.c b/kernel/module.c
>index 1c429d8d2d74..6c868aabaf37 100644
>--- a/kernel/module.c
>+++ b/kernel/module.c
>@@ -3568,12 +3568,12 @@ static int add_unformed_module(struct module *mod)
> 	mutex_lock(&module_mutex);
> 	old = find_module_all(mod->name, strlen(mod->name), true);
> 	if (old != NULL) {
>-		if (old->state == MODULE_STATE_COMING
>-		    || old->state == MODULE_STATE_UNFORMED) {
>+		if (old->state != MODULE_STATE_LIVE) {
> 			/* Wait in case it fails to load. */
> 			mutex_unlock(&module_mutex);
>-			err = wait_event_interruptible(module_wq,
>-					       finished_loading(mod->name));
>+			err = wait_event_interruptible_timeout(module_wq,
>+					       finished_loading(mod->name),
>+					       HZ/1000);
> 			if (err)
> 				goto out_unlocked;
> 			goto again;
>-- 
>2.18.1
>

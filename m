Return-Path: <SRS0=CtY/=UD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,T_DKIMWL_WL_HIGH,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 287C4C282CE
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Jun 2019 14:29:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F1E4024999
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Jun 2019 14:29:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1559658577;
	bh=e2U0OXKWp8FRquT8izb7ZbfUMaGwyeAP1fVt/nF96tU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=AZG+GlM5wHNBZJ8CRljRgespQBW109SMtyfxNd5DYaZe0W6xThBf2z2fr49th3qyK
	 nwq98UCpTKbKkKawLS48reG1/7LAoP0/f7zuh/E3ArIulLSQZz9Sh/P8d4KUkrxweU
	 gJEUMYZsDon19oHQeXVfXUGHzqANWhFJlTiCsOUY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727793AbfFDO3g (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Jun 2019 10:29:36 -0400
Received: from mail.kernel.org ([198.145.29.99]:43782 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727665AbfFDO3g (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Jun 2019 10:29:36 -0400
Received: from linux-8ccs (nat.nue.novell.com [195.135.221.2])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 11B592498E;
        Tue,  4 Jun 2019 14:29:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1559658575;
        bh=e2U0OXKWp8FRquT8izb7ZbfUMaGwyeAP1fVt/nF96tU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=z4Z1WHSGWW5naTDdIGeZ8nwbIhCCD7p0bsavlhFkuFAZpp6axT20u8tOGAnJyjDFg
         //wWqa/e2E/APW7+fVpo1zk2xZpZfmtno50ihIaQoUYsbtaW5fhY3jSlWTPhnGifY3
         AmpI34HFfssnAyikSFV54QgoP87Y+ylXVFp1dWhc=
Date:   Tue, 4 Jun 2019 16:29:31 +0200
From:   Jessica Yu <jeyu@kernel.org>
To:     Prarit Bhargava <prarit@redhat.com>
Cc:     linux-kernel@vger.kernel.org, Barret Rhoden <brho@google.com>,
        David Arcari <darcari@redhat.com>,
        Heiko Carstens <heiko.carstens@de.ibm.com>
Subject: Re: [PATCH v3] kernel/module.c: Only return -EEXIST for modules that
 have finished loading
Message-ID: <20190604142931.GA3570@linux-8ccs>
References: <20190529112625.28699-1-prarit@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20190529112625.28699-1-prarit@redhat.com>
X-OS:   Linux linux-8ccs 5.1.0-rc1-lp150.12.28-default+ x86_64
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

+++ Prarit Bhargava [29/05/19 07:26 -0400]:
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
>Signed-off-by: Prarit Bhargava <prarit@redhat.com>
>Signed-off-by: Barret Rhoden <brho@google.com>
>Cc: David Arcari <darcari@redhat.com>
>Cc: Jessica Yu <jeyu@kernel.org>
>Cc: Heiko Carstens <heiko.carstens@de.ibm.com>

Applied. Thanks!

Jessica

>---
> kernel/module.c | 6 ++----
> 1 file changed, 2 insertions(+), 4 deletions(-)
>
>diff --git a/kernel/module.c b/kernel/module.c
>index 6e6712b3aaf5..1e7dcbe527af 100644
>--- a/kernel/module.c
>+++ b/kernel/module.c
>@@ -3397,8 +3397,7 @@ static bool finished_loading(const char *name)
> 	sched_annotate_sleep();
> 	mutex_lock(&module_mutex);
> 	mod = find_module_all(name, strlen(name), true);
>-	ret = !mod || mod->state == MODULE_STATE_LIVE
>-		|| mod->state == MODULE_STATE_GOING;
>+	ret = !mod || mod->state == MODULE_STATE_LIVE;
> 	mutex_unlock(&module_mutex);
>
> 	return ret;
>@@ -3588,8 +3587,7 @@ static int add_unformed_module(struct module *mod)
> 	mutex_lock(&module_mutex);
> 	old = find_module_all(mod->name, strlen(mod->name), true);
> 	if (old != NULL) {
>-		if (old->state == MODULE_STATE_COMING
>-		    || old->state == MODULE_STATE_UNFORMED) {
>+		if (old->state != MODULE_STATE_LIVE) {
> 			/* Wait in case it fails to load. */
> 			mutex_unlock(&module_mutex);
> 			err = wait_event_interruptible(module_wq,
>-- 
>2.21.0
>

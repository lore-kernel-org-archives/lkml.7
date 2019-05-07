Return-Path: <SRS0=RyeP=TH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8D074C004C9
	for <linux-kernel@archiver.kernel.org>; Tue,  7 May 2019 14:54:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 65574205ED
	for <linux-kernel@archiver.kernel.org>; Tue,  7 May 2019 14:54:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726589AbfEGOyQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 May 2019 10:54:16 -0400
Received: from mx1.redhat.com ([209.132.183.28]:35918 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725843AbfEGOyQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 May 2019 10:54:16 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id BABA388305;
        Tue,  7 May 2019 14:54:15 +0000 (UTC)
Received: from prarit.khw1.lab.eng.bos.redhat.com (prarit-guest.khw1.lab.eng.bos.redhat.com [10.16.200.63])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 2818B17ADD;
        Tue,  7 May 2019 14:54:15 +0000 (UTC)
From:   Prarit Bhargava <prarit@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     Prarit Bhargava <prarit@redhat.com>, Jessica Yu <jeyu@kernel.org>,
        Heiko Carstens <heiko.carstens@de.ibm.com>,
        David Arcari <darcari@redhat.com>
Subject: [PATCH v2] modules: Only return -EEXIST for modules that have finished loading
Date:   Tue,  7 May 2019 10:54:13 -0400
Message-Id: <20190507145413.16297-1-prarit@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.28]); Tue, 07 May 2019 14:54:15 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Heiko, it would still be good to get a test of this patch from you.  I
tested this here at Red Hat on some System Z machines.  Without the
modification made here in v2, the systems failed to boot ~10% of the time.
After the modification I do not see any boot failures.  I also was
able to reproduce the boot issue with the acpi_cpufreq driver on a very
large & fast x86 system which had closer to 100% failure rate without
the changes in v2.  After the modification in v2 the system has rebooted
all weekend without any issues.

P.

---8<---

Microsoft HyperV disables the X86_FEATURE_SMCA bit on AMD systems, and
linux guests boot with repeated errors:

amd64_edac_mod: Unknown symbol amd_unregister_ecc_decoder (err -2)
amd64_edac_mod: Unknown symbol amd_register_ecc_decoder (err -2)
amd64_edac_mod: Unknown symbol amd_report_gart_errors (err -2)
amd64_edac_mod: Unknown symbol amd_unregister_ecc_decoder (err -2)
amd64_edac_mod: Unknown symbol amd_register_ecc_decoder (err -2)
amd64_edac_mod: Unknown symbol amd_report_gart_errors (err -2)

The warnings occur because the module code erroneously returns -EEXIST
for modules that have failed to load and are in the process of being
removed from the module list.

module amd64_edac_mod has a dependency on module edac_mce_amd.  Using
modules.dep, systemd will load edac_mce_amd for every request of
amd64_edac_mod.  When the edac_mce_amd module loads, the module has
state MODULE_STATE_UNFORMED and once the module load fails and the state
becomes MODULE_STATE_GOING.  Another request for edac_mce_amd module
executes and add_unformed_module() will erroneously return -EEXIST even
though the previous instance of edac_mce_amd has MODULE_STATE_GOING.
Upon receiving -EEXIST, systemd attempts to load amd64_edac_mod, which
fails because of unknown symbols from edac_mce_amd.

add_unformed_module() must wait to return for any case other than
MODULE_STATE_LIVE to prevent a race between multiple loads of
dependent modules.

v2: The initial (old->state != MODULE_STATE_LIVE) change exposed an
additional issue in the code.  wait_event_interruptible() puts each thread
to sleep until the a module finishes loading an executes the module_wq
workqueue.  The result is a long delay during the boot.  Switching to
wait_event_interruptible_timeout() resolves the sleep problem.

Signed-off-by: Prarit Bhargava <prarit@redhat.com>
Cc: Jessica Yu <jeyu@kernel.org>
Cc: Heiko Carstens <heiko.carstens@de.ibm.com>
Cc: David Arcari <darcari@redhat.com>
---
 kernel/module.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/kernel/module.c b/kernel/module.c
index 1c429d8d2d74..6c868aabaf37 100644
--- a/kernel/module.c
+++ b/kernel/module.c
@@ -3568,12 +3568,12 @@ static int add_unformed_module(struct module *mod)
 	mutex_lock(&module_mutex);
 	old = find_module_all(mod->name, strlen(mod->name), true);
 	if (old != NULL) {
-		if (old->state == MODULE_STATE_COMING
-		    || old->state == MODULE_STATE_UNFORMED) {
+		if (old->state != MODULE_STATE_LIVE) {
 			/* Wait in case it fails to load. */
 			mutex_unlock(&module_mutex);
-			err = wait_event_interruptible(module_wq,
-					       finished_loading(mod->name));
+			err = wait_event_interruptible_timeout(module_wq,
+					       finished_loading(mod->name),
+					       HZ/1000);
 			if (err)
 				goto out_unlocked;
 			goto again;
-- 
2.18.1


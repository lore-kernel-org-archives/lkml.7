Return-Path: <SRS0=cgli=V4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 38C26C32751
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Jul 2019 13:17:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0C57E208E4
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Jul 2019 13:17:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1564579050;
	bh=cF0NqJioENF5goZLqgUeSulLM0pCLtXDe1MVNQ85T3Y=;
	h=From:To:Cc:Subject:Date:List-ID:From;
	b=GD+Seh7vJJ1f5QwRQ2wB0rjTUDWRzXyUHw7JPsopYMmRIBxDYzLFtFIW9ddJUw75b
	 rjpYzBaKnJs2CytwMBSJZ0FxieeeSWA8t92TbsQm3Qb3Jm9ts4ZYkbPgvRf3kgFyFw
	 pq2Ha+/5Ja7Y/UgYVcZ/Fe1l0XUlkjtUanayTDxY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729347AbfGaNR3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 31 Jul 2019 09:17:29 -0400
Received: from mail.kernel.org ([198.145.29.99]:49230 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727403AbfGaNR2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Jul 2019 09:17:28 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E530520693;
        Wed, 31 Jul 2019 13:17:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1564579047;
        bh=cF0NqJioENF5goZLqgUeSulLM0pCLtXDe1MVNQ85T3Y=;
        h=From:To:Cc:Subject:Date:From;
        b=wRTzeAyQ/PW9eoQQfPqQEyxXufqMQSzfAHvoTNhz6kRfVGwj0vAG14YbhAklvcD3p
         7D/FArTDS7WPLvEG82eXDEGLcRYUsfUdDz59pGmoenmhEsHY4+usWKyCFdUrcc69ha
         luLfwmpt9ti/HGr/3siKbpOfskDBhgKsGbWGJw3s=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Mark Brown <broonie@kernel.org>, Takashi Iwai <tiwai@suse.com>
Cc:     linux-kernel@vger.kernel.org, alsa-devel@alsa-project.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        Liam Girdwood <liam.r.girdwood@linux.intel.com>,
        Jie Yang <yang.jie@linux.intel.com>,
        Jaroslav Kysela <perex@perex.cz>
Subject: [PATCH v2 1/3] ASoC: Intel: SoC: skylake: no need to check return value of debugfs_create functions
Date:   Wed, 31 Jul 2019 15:17:14 +0200
Message-Id: <20190731131716.9764-1-gregkh@linuxfoundation.org>
X-Mailer: git-send-email 2.22.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When calling debugfs functions, there is no need to ever check the
return value.  The function can work or not, but the code logic should
never do something different based on this.

Also, if a debugfs call fails, userspace is notified with an error in
the log, so no need to log the error again.

Cc: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Cc: Liam Girdwood <liam.r.girdwood@linux.intel.com>
Cc: Jie Yang <yang.jie@linux.intel.com>
Cc: Mark Brown <broonie@kernel.org>
Cc: Jaroslav Kysela <perex@perex.cz>
Cc: Takashi Iwai <tiwai@suse.com>
Cc: alsa-devel@alsa-project.org
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
v2: rebase on 5.3-rc1
    change Subject line to match the subsystem better
    rework based on debugfs core now reporting errors.

 sound/soc/intel/skylake/skl-debug.c | 28 +++++-----------------------
 1 file changed, 5 insertions(+), 23 deletions(-)

diff --git a/sound/soc/intel/skylake/skl-debug.c b/sound/soc/intel/skylake/skl-debug.c
index b9b4a72a4334..1d6240ad6112 100644
--- a/sound/soc/intel/skylake/skl-debug.c
+++ b/sound/soc/intel/skylake/skl-debug.c
@@ -162,10 +162,8 @@ void skl_debug_init_module(struct skl_debug *d,
 			struct snd_soc_dapm_widget *w,
 			struct skl_module_cfg *mconfig)
 {
-	if (!debugfs_create_file(w->name, 0444,
-				d->modules, mconfig,
-				&mcfg_fops))
-		dev_err(d->dev, "%s: module debugfs init failed\n", w->name);
+	debugfs_create_file(w->name, 0444, d->modules, mconfig,
+			    &mcfg_fops);
 }
 
 static ssize_t fw_softreg_read(struct file *file, char __user *user_buf,
@@ -222,34 +220,18 @@ struct skl_debug *skl_debugfs_init(struct skl *skl)
 		return NULL;
 
 	/* create the debugfs dir with platform component's debugfs as parent */
-	d->fs = debugfs_create_dir("dsp",
-				   skl->component->debugfs_root);
-	if (IS_ERR(d->fs) || !d->fs) {
-		dev_err(&skl->pci->dev, "debugfs root creation failed\n");
-		return NULL;
-	}
+	d->fs = debugfs_create_dir("dsp", skl->component->debugfs_root);
 
 	d->skl = skl;
 	d->dev = &skl->pci->dev;
 
 	/* now create the module dir */
 	d->modules = debugfs_create_dir("modules", d->fs);
-	if (IS_ERR(d->modules) || !d->modules) {
-		dev_err(&skl->pci->dev, "modules debugfs create failed\n");
-		goto err;
-	}
 
-	if (!debugfs_create_file("fw_soft_regs_rd", 0444, d->fs, d,
-				 &soft_regs_ctrl_fops)) {
-		dev_err(d->dev, "fw soft regs control debugfs init failed\n");
-		goto err;
-	}
+	debugfs_create_file("fw_soft_regs_rd", 0444, d->fs, d,
+			    &soft_regs_ctrl_fops);
 
 	return d;
-
-err:
-	debugfs_remove_recursive(d->fs);
-	return NULL;
 }
 
 void skl_debugfs_exit(struct skl *skl)
-- 
2.22.0


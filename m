Return-Path: <SRS0=K9bG=V2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BCC4FC76186
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jul 2019 19:30:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8C472217D9
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jul 2019 19:30:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1564428653;
	bh=cZ7HUEQurZUTQWyxwgwAlvkjhDjErbPofYKk5uukbRQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=AZJDHR+TVyqdZRZmUv7cD9ZveDfyH+2ZD4YtSvEKNDwhf/tYKs+RoYh43qIWDoMnU
	 YJ2/54t06SJuZiUQocuBsHwK1nXcBTD/6YNLQ8uS/A0xWmNGVe5WH9UGy2mbEENEX1
	 nstm2Y5xg8v1sc2S9QhD62Buctx+xVrPg/i4S9XY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728595AbfG2Tar (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Jul 2019 15:30:47 -0400
Received: from mail.kernel.org ([198.145.29.99]:43394 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725894AbfG2Taj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Jul 2019 15:30:39 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 85F7721655;
        Mon, 29 Jul 2019 19:30:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1564428638;
        bh=cZ7HUEQurZUTQWyxwgwAlvkjhDjErbPofYKk5uukbRQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=TDDAPR2INTLmKzUeW58EQOqMOBn8sZt61R/Wg7jRuJT6UiAiE420JxU6eEZ6sctYr
         0ea/6zDg++Yhw1DjQbqo2SZSAVFKPlX+4HOGOzOL6G62F/4iecVYDw7/0gJVo8+LDi
         3HBXWguS85GyH3Em/s2gcNzGcAIr2NGR3JAimkT0=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Mark Brown <broonie@kernel.org>
Subject: [PATCH 4.14 138/293] ASoC: dapm: Adapt for debugfs API change
Date:   Mon, 29 Jul 2019 21:20:29 +0200
Message-Id: <20190729190835.122177618@linuxfoundation.org>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20190729190820.321094988@linuxfoundation.org>
References: <20190729190820.321094988@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Mark Brown <broonie@kernel.org>

commit ceaea851b9ea75f9ea2bbefb53ff0d4b27cd5a6e upstream.

Back in ff9fb72bc07705c (debugfs: return error values, not NULL) the
debugfs APIs were changed to return error pointers rather than NULL
pointers on error, breaking the error checking in ASoC. Update the
code to use IS_ERR() and log the codes that are returned as part of
the error messages.

Fixes: ff9fb72bc07705c (debugfs: return error values, not NULL)
Signed-off-by: Mark Brown <broonie@kernel.org>
Cc: stable@vger.kernel.org
Signed-off-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 sound/soc/soc-dapm.c |   18 ++++++++++--------
 1 file changed, 10 insertions(+), 8 deletions(-)

--- a/sound/soc/soc-dapm.c
+++ b/sound/soc/soc-dapm.c
@@ -2120,23 +2120,25 @@ void snd_soc_dapm_debugfs_init(struct sn
 {
 	struct dentry *d;
 
-	if (!parent)
+	if (!parent || IS_ERR(parent))
 		return;
 
 	dapm->debugfs_dapm = debugfs_create_dir("dapm", parent);
 
-	if (!dapm->debugfs_dapm) {
+	if (IS_ERR(dapm->debugfs_dapm)) {
 		dev_warn(dapm->dev,
-		       "ASoC: Failed to create DAPM debugfs directory\n");
+			 "ASoC: Failed to create DAPM debugfs directory %ld\n",
+			 PTR_ERR(dapm->debugfs_dapm));
 		return;
 	}
 
 	d = debugfs_create_file("bias_level", 0444,
 				dapm->debugfs_dapm, dapm,
 				&dapm_bias_fops);
-	if (!d)
+	if (IS_ERR(d))
 		dev_warn(dapm->dev,
-			 "ASoC: Failed to create bias level debugfs file\n");
+			 "ASoC: Failed to create bias level debugfs file: %ld\n",
+			 PTR_ERR(d));
 }
 
 static void dapm_debugfs_add_widget(struct snd_soc_dapm_widget *w)
@@ -2150,10 +2152,10 @@ static void dapm_debugfs_add_widget(stru
 	d = debugfs_create_file(w->name, 0444,
 				dapm->debugfs_dapm, w,
 				&dapm_widget_power_fops);
-	if (!d)
+	if (IS_ERR(d))
 		dev_warn(w->dapm->dev,
-			"ASoC: Failed to create %s debugfs file\n",
-			w->name);
+			 "ASoC: Failed to create %s debugfs file: %ld\n",
+			 w->name, PTR_ERR(d));
 }
 
 static void dapm_debugfs_cleanup(struct snd_soc_dapm_context *dapm)



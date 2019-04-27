Return-Path: <SRS0=SjSX=S5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DC16BC43219
	for <linux-kernel@archiver.kernel.org>; Sat, 27 Apr 2019 01:56:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9F49E205F4
	for <linux-kernel@archiver.kernel.org>; Sat, 27 Apr 2019 01:56:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1556330203;
	bh=470oLlIabZZTW+nkxF+CvsHfQVSdh00gBBqEzzobfvY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=Cu1AZ5FHzwsGNMRjNQNv/Ud+Fi+H00OjCN+sd4yylr/g9h70O0ttwNICkiRIYoaNl
	 h4YHO0DVpLELKtf0ITuPyF8WYGUBWXOIlS/nJXyL3cMiqIsccOj1eKQNlC/OjXLWZ+
	 7ZFc0HLzY3bVp45YMzJfZ05/5k/0IxkwAJNeE0Cw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727402AbfD0Bix (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 26 Apr 2019 21:38:53 -0400
Received: from mail.kernel.org ([198.145.29.99]:41772 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727348AbfD0Biv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Apr 2019 21:38:51 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id DFA302087C;
        Sat, 27 Apr 2019 01:38:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1556329129;
        bh=470oLlIabZZTW+nkxF+CvsHfQVSdh00gBBqEzzobfvY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=H33tR0Lu+rnn8g0hrdV1/pi0T3GDjlA+YjqaXlgLy4RtP5Z3q0zHtKyDdZx0T/pTg
         8JTWq22uTjEAQVcBW6fFONCNTvYZ+ok4Z99i5Tt7jKW5V/KkOJU7c+VH2d28JAZMjt
         Z82viLuRLfbEZXNnbNVPyGvb+WEfoImN3FAfhZwA=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     KaiChieh Chuang <kaichieh.chuang@mediatek.com>,
        Mark Brown <broonie@kernel.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH AUTOSEL 5.0 10/79] ASoC: dpcm: prevent snd_soc_dpcm use after free
Date:   Fri, 26 Apr 2019 21:37:29 -0400
Message-Id: <20190427013838.6596-10-sashal@kernel.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20190427013838.6596-1-sashal@kernel.org>
References: <20190427013838.6596-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: KaiChieh Chuang <kaichieh.chuang@mediatek.com>

[ Upstream commit a9764869779081e8bf24da07ac040e8f3efcf13a ]

The dpcm get from fe_clients/be_clients
may be free before use

Add a spin lock at snd_soc_card level,
to protect the dpcm instance.
The lock may be used in atomic context, so use spin lock.

Use irq spin lock version,
since the lock may be used in interrupts.

possible race condition between
void dpcm_be_disconnect(
	...
	list_del(&dpcm->list_be);
	list_del(&dpcm->list_fe);
	kfree(dpcm);
	...

and
	for_each_dpcm_fe()
	for_each_dpcm_be*()

race condition example
Thread 1:
    snd_soc_dapm_mixer_update_power()
        -> soc_dpcm_runtime_update()
            -> dpcm_be_disconnect()
                -> kfree(dpcm);
Thread 2:
    dpcm_fe_dai_trigger()
        -> dpcm_be_dai_trigger()
            -> snd_soc_dpcm_can_be_free_stop()
                -> if (dpcm->fe == fe)

Excpetion Scenario:
	two FE link to same BE
	FE1 -> BE
	FE2 ->

	Thread 1: switch of mixer between FE2 -> BE
	Thread 2: pcm_stop FE1

Exception:

Unable to handle kernel paging request at virtual address dead0000000000e0

pc=<> [<ffffff8960e2cd10>] dpcm_be_dai_trigger+0x29c/0x47c
	sound/soc/soc-pcm.c:3226
		if (dpcm->fe == fe)
lr=<> [<ffffff8960e2f694>] dpcm_fe_dai_do_trigger+0x94/0x26c

Backtrace:
[<ffffff89602dba80>] notify_die+0x68/0xb8
[<ffffff896028c7dc>] die+0x118/0x2a8
[<ffffff89602a2f84>] __do_kernel_fault+0x13c/0x14c
[<ffffff89602a27f4>] do_translation_fault+0x64/0xa0
[<ffffff8960280cf8>] do_mem_abort+0x4c/0xd0
[<ffffff8960282ad0>] el1_da+0x24/0x40
[<ffffff8960e2cd10>] dpcm_be_dai_trigger+0x29c/0x47c
[<ffffff8960e2f694>] dpcm_fe_dai_do_trigger+0x94/0x26c
[<ffffff8960e2edec>] dpcm_fe_dai_trigger+0x3c/0x44
[<ffffff8960de5588>] snd_pcm_do_stop+0x50/0x5c
[<ffffff8960dded24>] snd_pcm_action+0xb4/0x13c
[<ffffff8960ddfdb4>] snd_pcm_drop+0xa0/0x128
[<ffffff8960de69bc>] snd_pcm_common_ioctl+0x9d8/0x30f0
[<ffffff8960de1cac>] snd_pcm_ioctl_compat+0x29c/0x2f14
[<ffffff89604c9d60>] compat_SyS_ioctl+0x128/0x244
[<ffffff8960283740>] el0_svc_naked+0x34/0x38
[<ffffffffffffffff>] 0xffffffffffffffff

Signed-off-by: KaiChieh Chuang <kaichieh.chuang@mediatek.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 include/sound/soc.h  |  2 ++
 sound/soc/soc-core.c |  1 +
 sound/soc/soc-pcm.c  | 40 +++++++++++++++++++++++++++++++++-------
 3 files changed, 36 insertions(+), 7 deletions(-)

diff --git a/include/sound/soc.h b/include/sound/soc.h
index e665f111b0d2..fa82d6215328 100644
--- a/include/sound/soc.h
+++ b/include/sound/soc.h
@@ -1043,6 +1043,8 @@ struct snd_soc_card {
 	struct mutex mutex;
 	struct mutex dapm_mutex;
 
+	spinlock_t dpcm_lock;
+
 	bool instantiated;
 	bool topology_shortname_created;
 
diff --git a/sound/soc/soc-core.c b/sound/soc/soc-core.c
index 50617db05c46..416c371fa01a 100644
--- a/sound/soc/soc-core.c
+++ b/sound/soc/soc-core.c
@@ -2790,6 +2790,7 @@ int snd_soc_register_card(struct snd_soc_card *card)
 	card->instantiated = 0;
 	mutex_init(&card->mutex);
 	mutex_init(&card->dapm_mutex);
+	spin_lock_init(&card->dpcm_lock);
 
 	return snd_soc_bind_card(card);
 }
diff --git a/sound/soc/soc-pcm.c b/sound/soc/soc-pcm.c
index 0b6ade426516..4c24b13c1016 100644
--- a/sound/soc/soc-pcm.c
+++ b/sound/soc/soc-pcm.c
@@ -1212,6 +1212,7 @@ static int dpcm_be_connect(struct snd_soc_pcm_runtime *fe,
 		struct snd_soc_pcm_runtime *be, int stream)
 {
 	struct snd_soc_dpcm *dpcm;
+	unsigned long flags;
 
 	/* only add new dpcms */
 	for_each_dpcm_be(fe, stream, dpcm) {
@@ -1227,8 +1228,10 @@ static int dpcm_be_connect(struct snd_soc_pcm_runtime *fe,
 	dpcm->fe = fe;
 	be->dpcm[stream].runtime = fe->dpcm[stream].runtime;
 	dpcm->state = SND_SOC_DPCM_LINK_STATE_NEW;
+	spin_lock_irqsave(&fe->card->dpcm_lock, flags);
 	list_add(&dpcm->list_be, &fe->dpcm[stream].be_clients);
 	list_add(&dpcm->list_fe, &be->dpcm[stream].fe_clients);
+	spin_unlock_irqrestore(&fe->card->dpcm_lock, flags);
 
 	dev_dbg(fe->dev, "connected new DPCM %s path %s %s %s\n",
 			stream ? "capture" : "playback",  fe->dai_link->name,
@@ -1274,6 +1277,7 @@ static void dpcm_be_reparent(struct snd_soc_pcm_runtime *fe,
 void dpcm_be_disconnect(struct snd_soc_pcm_runtime *fe, int stream)
 {
 	struct snd_soc_dpcm *dpcm, *d;
+	unsigned long flags;
 
 	for_each_dpcm_be_safe(fe, stream, dpcm, d) {
 		dev_dbg(fe->dev, "ASoC: BE %s disconnect check for %s\n",
@@ -1293,8 +1297,10 @@ void dpcm_be_disconnect(struct snd_soc_pcm_runtime *fe, int stream)
 #ifdef CONFIG_DEBUG_FS
 		debugfs_remove(dpcm->debugfs_state);
 #endif
+		spin_lock_irqsave(&fe->card->dpcm_lock, flags);
 		list_del(&dpcm->list_be);
 		list_del(&dpcm->list_fe);
+		spin_unlock_irqrestore(&fe->card->dpcm_lock, flags);
 		kfree(dpcm);
 	}
 }
@@ -1546,10 +1552,13 @@ int dpcm_process_paths(struct snd_soc_pcm_runtime *fe,
 void dpcm_clear_pending_state(struct snd_soc_pcm_runtime *fe, int stream)
 {
 	struct snd_soc_dpcm *dpcm;
+	unsigned long flags;
 
+	spin_lock_irqsave(&fe->card->dpcm_lock, flags);
 	for_each_dpcm_be(fe, stream, dpcm)
 		dpcm->be->dpcm[stream].runtime_update =
 						SND_SOC_DPCM_UPDATE_NO;
+	spin_unlock_irqrestore(&fe->card->dpcm_lock, flags);
 }
 
 static void dpcm_be_dai_startup_unwind(struct snd_soc_pcm_runtime *fe,
@@ -2570,6 +2579,7 @@ static int dpcm_run_update_startup(struct snd_soc_pcm_runtime *fe, int stream)
 	struct snd_soc_dpcm *dpcm;
 	enum snd_soc_dpcm_trigger trigger = fe->dai_link->trigger[stream];
 	int ret;
+	unsigned long flags;
 
 	dev_dbg(fe->dev, "ASoC: runtime %s open on FE %s\n",
 			stream ? "capture" : "playback", fe->dai_link->name);
@@ -2639,11 +2649,13 @@ close:
 	dpcm_be_dai_shutdown(fe, stream);
 disconnect:
 	/* disconnect any non started BEs */
+	spin_lock_irqsave(&fe->card->dpcm_lock, flags);
 	for_each_dpcm_be(fe, stream, dpcm) {
 		struct snd_soc_pcm_runtime *be = dpcm->be;
 		if (be->dpcm[stream].state != SND_SOC_DPCM_STATE_START)
 				dpcm->state = SND_SOC_DPCM_LINK_STATE_FREE;
 	}
+	spin_unlock_irqrestore(&fe->card->dpcm_lock, flags);
 
 	return ret;
 }
@@ -3219,7 +3231,10 @@ int snd_soc_dpcm_can_be_free_stop(struct snd_soc_pcm_runtime *fe,
 {
 	struct snd_soc_dpcm *dpcm;
 	int state;
+	int ret = 1;
+	unsigned long flags;
 
+	spin_lock_irqsave(&fe->card->dpcm_lock, flags);
 	for_each_dpcm_fe(be, stream, dpcm) {
 
 		if (dpcm->fe == fe)
@@ -3228,12 +3243,15 @@ int snd_soc_dpcm_can_be_free_stop(struct snd_soc_pcm_runtime *fe,
 		state = dpcm->fe->dpcm[stream].state;
 		if (state == SND_SOC_DPCM_STATE_START ||
 			state == SND_SOC_DPCM_STATE_PAUSED ||
-			state == SND_SOC_DPCM_STATE_SUSPEND)
-			return 0;
+			state == SND_SOC_DPCM_STATE_SUSPEND) {
+			ret = 0;
+			break;
+		}
 	}
+	spin_unlock_irqrestore(&fe->card->dpcm_lock, flags);
 
 	/* it's safe to free/stop this BE DAI */
-	return 1;
+	return ret;
 }
 EXPORT_SYMBOL_GPL(snd_soc_dpcm_can_be_free_stop);
 
@@ -3246,7 +3264,10 @@ int snd_soc_dpcm_can_be_params(struct snd_soc_pcm_runtime *fe,
 {
 	struct snd_soc_dpcm *dpcm;
 	int state;
+	int ret = 1;
+	unsigned long flags;
 
+	spin_lock_irqsave(&fe->card->dpcm_lock, flags);
 	for_each_dpcm_fe(be, stream, dpcm) {
 
 		if (dpcm->fe == fe)
@@ -3256,12 +3277,15 @@ int snd_soc_dpcm_can_be_params(struct snd_soc_pcm_runtime *fe,
 		if (state == SND_SOC_DPCM_STATE_START ||
 			state == SND_SOC_DPCM_STATE_PAUSED ||
 			state == SND_SOC_DPCM_STATE_SUSPEND ||
-			state == SND_SOC_DPCM_STATE_PREPARE)
-			return 0;
+			state == SND_SOC_DPCM_STATE_PREPARE) {
+			ret = 0;
+			break;
+		}
 	}
+	spin_unlock_irqrestore(&fe->card->dpcm_lock, flags);
 
 	/* it's safe to change hw_params */
-	return 1;
+	return ret;
 }
 EXPORT_SYMBOL_GPL(snd_soc_dpcm_can_be_params);
 
@@ -3300,6 +3324,7 @@ static ssize_t dpcm_show_state(struct snd_soc_pcm_runtime *fe,
 	struct snd_pcm_hw_params *params = &fe->dpcm[stream].hw_params;
 	struct snd_soc_dpcm *dpcm;
 	ssize_t offset = 0;
+	unsigned long flags;
 
 	/* FE state */
 	offset += snprintf(buf + offset, size - offset,
@@ -3327,6 +3352,7 @@ static ssize_t dpcm_show_state(struct snd_soc_pcm_runtime *fe,
 		goto out;
 	}
 
+	spin_lock_irqsave(&fe->card->dpcm_lock, flags);
 	for_each_dpcm_be(fe, stream, dpcm) {
 		struct snd_soc_pcm_runtime *be = dpcm->be;
 		params = &dpcm->hw_params;
@@ -3347,7 +3373,7 @@ static ssize_t dpcm_show_state(struct snd_soc_pcm_runtime *fe,
 				params_channels(params),
 				params_rate(params));
 	}
-
+	spin_unlock_irqrestore(&fe->card->dpcm_lock, flags);
 out:
 	return offset;
 }
-- 
2.19.1


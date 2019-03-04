Return-Path: <SRS0=91bA=RH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 021DCC43381
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Mar 2019 20:35:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CD1CC20835
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Mar 2019 20:35:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726481AbfCDUfF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 Mar 2019 15:35:05 -0500
Received: from mout.kundenserver.de ([212.227.17.24]:36229 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726076AbfCDUfF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Mar 2019 15:35:05 -0500
Received: from wuerfel.lan ([109.192.41.194]) by mrelayeu.kundenserver.de
 (mreue108 [212.227.15.145]) with ESMTPA (Nemesis) id
 1Mf0FY-1hTvJJ3PYI-00gV08; Mon, 04 Mar 2019 21:33:39 +0100
From:   Arnd Bergmann <arnd@arndb.de>
To:     Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>
Cc:     Arnd Bergmann <arnd@arndb.de>, Sameer Pujar <spujar@nvidia.com>,
        Mohan Kumar D <mkumard@nvidia.com>,
        Ravindra Lokhande <rlokhande@nvidia.com>,
        Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        alsa-devel@alsa-project.org, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] ALSA: hda/tegra: avoid build error without CONFIG_PM
Date:   Mon,  4 Mar 2019 21:33:25 +0100
Message-Id: <20190304203337.1968705-1-arnd@arndb.de>
X-Mailer: git-send-email 2.20.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:gGK9SLW1WNjwagJZ5WFg+KFg0y7X0g2wg/CrYquepC0s5WUELGF
 o14XabNuJgO/suXkwp7p4K8TMKxHIrI4xDgg4lio6eVcYsmczGOnrevZ6X1DusS+X5o9ZYg
 9+1hZ+MejNu3gcJdVciuuyH2Cgw1dRivtTjVj4zCAAKTXKrG/tfRzjmffH/usklhoebPNho
 RzQpWf2ohVS1a8ShyEL6A==
X-UI-Out-Filterresults: notjunk:1;V03:K0:XvlmZ2uJsrA=:q+bRwaMqf6nyDryl1YymE2
 2nNh3fPQY1VfWN+cdrt5dYqQ4XUMAS0aFe7Bsm/zcoz1zuHLZzWoHD8XEKGZptRhHyWIfuObr
 giyQ6JpPjP99eXqUvhifbmXfdugRkcefJBQTVIOGlDB29gurC9HL6nIVrn9Q+3Mu4JVKvF5AS
 7ROJEet1ZoJBEmLqzpOR89BkPA3HklXb6zwtmPAas5e5BJBCeJj7zbDLWLxBtN1FTuMIfWBU1
 SdLlWkrHZ+b495t8T3Vw5/VGOZfZMzrgWZkVfTiHc+oQkXXAAn0PMEoTgIpoZaEvP8BqPHJs2
 Eg3P+pdHBK+yG421GmuXZFRH9au5/Hv3P5XCU8tOeEHzFRNZAgH4+YaC7CBLhT1Z/RmJMDhVv
 6n5LtLDWuSCgyyHa087e0WLIptyQ/F68Kbd2QOhyQUdVLsuM3+uMdp4A8o2Mq2RoqH3hiOlea
 tLyqoXGhYZJkgvSTu3lB35YxT94K+ltHbS2UL+Xikxhy40aw/unOJc2rfmU24Py8MMKj9XWI7
 tszfIA8VHFQu0cBxMXWpeze7ImHwymlPWQoB9dZHauKPLG/cyXYk/tE2VSsTY6Xt4gHckEUeM
 sGqmRtK0r6vbNjylBVrw2YlzX4rKVk/JQdRfklbk0xULEfHrUpclzXG/ryI9nWCGOwabNIOrt
 dPO+z83WWD8cGasbG5QHhKdJvMPpXNXVGsTYajedUfVNUz3E7bnE909Ua4/8M2KGo2A01B8ML
 SGxIQePQ8kehbi37jDVlgpw9nxvBL7LcM1Bo5w==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The #ifdef protection around the PM functions is wrong, leading to
a failed reference in some configurations:

sound/pci/hda/hda_tegra.c: In function 'hda_tegra_runtime_suspend':
sound/pci/hda/hda_tegra.c:273:2: error: implicit declaration of function 'hda_tegra_disable_clocks'; did you mean 'hda_tegra_enable_clocks'? [-Werror=implicit-function-declaration]

Better remove the #ifdefs entirely and rely on the compiler silently
dropping unused functions marked __maybe_unused.

Fixes: 707e0759f2f4 ("ALSA: hda/tegra: implement runtime suspend/resume")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 sound/pci/hda/hda_tegra.c | 12 ++++--------
 1 file changed, 4 insertions(+), 8 deletions(-)

diff --git a/sound/pci/hda/hda_tegra.c b/sound/pci/hda/hda_tegra.c
index dbd8da5685cb..3d68f9ef7694 100644
--- a/sound/pci/hda/hda_tegra.c
+++ b/sound/pci/hda/hda_tegra.c
@@ -219,7 +219,6 @@ static int hda_tegra_enable_clocks(struct hda_tegra *data)
 	return rc;
 }
 
-#ifdef CONFIG_PM_SLEEP
 static void hda_tegra_disable_clocks(struct hda_tegra *data)
 {
 	clk_disable_unprepare(data->hda2hdmi_clk);
@@ -230,7 +229,7 @@ static void hda_tegra_disable_clocks(struct hda_tegra *data)
 /*
  * power management
  */
-static int hda_tegra_suspend(struct device *dev)
+static int __maybe_unused hda_tegra_suspend(struct device *dev)
 {
 	struct snd_card *card = dev_get_drvdata(dev);
 	int rc;
@@ -243,7 +242,7 @@ static int hda_tegra_suspend(struct device *dev)
 	return 0;
 }
 
-static int hda_tegra_resume(struct device *dev)
+static int __maybe_unused hda_tegra_resume(struct device *dev)
 {
 	struct snd_card *card = dev_get_drvdata(dev);
 	int rc;
@@ -255,10 +254,8 @@ static int hda_tegra_resume(struct device *dev)
 
 	return 0;
 }
-#endif /* CONFIG_PM_SLEEP */
 
-#ifdef CONFIG_PM
-static int hda_tegra_runtime_suspend(struct device *dev)
+static int __maybe_unused hda_tegra_runtime_suspend(struct device *dev)
 {
 	struct snd_card *card = dev_get_drvdata(dev);
 	struct azx *chip = card->private_data;
@@ -275,7 +272,7 @@ static int hda_tegra_runtime_suspend(struct device *dev)
 	return 0;
 }
 
-static int hda_tegra_runtime_resume(struct device *dev)
+static int __maybe_unused hda_tegra_runtime_resume(struct device *dev)
 {
 	struct snd_card *card = dev_get_drvdata(dev);
 	struct azx *chip = card->private_data;
@@ -292,7 +289,6 @@ static int hda_tegra_runtime_resume(struct device *dev)
 
 	return 0;
 }
-#endif /* CONFIG_PM */
 
 static const struct dev_pm_ops hda_tegra_pm = {
 	SET_SYSTEM_SLEEP_PM_OPS(hda_tegra_suspend, hda_tegra_resume)
-- 
2.20.0


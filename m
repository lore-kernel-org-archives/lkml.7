Return-Path: <SRS0=fWiu=Y6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2188DC5DF62
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Nov 2019 06:27:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C928B206DF
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Nov 2019 06:27:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernelci-org.20150623.gappssmtp.com header.i=@kernelci-org.20150623.gappssmtp.com header.b="aTLsOLR8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730992AbfKFG1y (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 Nov 2019 01:27:54 -0500
Received: from mail-wr1-f66.google.com ([209.85.221.66]:40338 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727795AbfKFG1y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Nov 2019 01:27:54 -0500
Received: by mail-wr1-f66.google.com with SMTP id i10so3596114wrs.7
        for <linux-kernel@vger.kernel.org>; Tue, 05 Nov 2019 22:27:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20150623.gappssmtp.com; s=20150623;
        h=message-id:date:mime-version:content-transfer-encoding:subject:to
         :from:cc;
        bh=+f/nil2KcNNXA8az57lhYCTpyXUZt+dq0Bg8utXgN+w=;
        b=aTLsOLR8XKvkP09Cm88Qty3MSj8H0AdpWVfK7IXIBsbyXZvBgtBP7fE1FOUc6HMmQV
         MdbY9lLFK8ghS/SESrC2gtwjiLFkZW9cm10F7kIjxJQc/8/DXNhXGoPJbd+m1B43cqB/
         LuTLCPgNAgUgWQ7USx9FsPP0HxfOba/YnfHGBIvlxLLKomnTSoKaiHZVjkubAMmWZGA9
         4K8Of/X9REoxmRvSKFzqiQptpOvEGBxJysI5PynIHJEJo7+oTbW0Aq+TAO+y9lqROTMg
         NO5dCI0qFrxGS2kwGe9hCQw+HZER/tTUWjhap3zwUWmeOg20mI4m8KUq+REdKHlToXOs
         f7kg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:date:mime-version
         :content-transfer-encoding:subject:to:from:cc;
        bh=+f/nil2KcNNXA8az57lhYCTpyXUZt+dq0Bg8utXgN+w=;
        b=tJAULkyj5VTOGXAgn3JTs/6Dh07//4+fQ4PiWj46Fw2SdLGfOr6nKVXt9SvUfM4+bv
         jn1SnCnPkO9n9TMHvaT88klq8XiaCtJQ+c3CGN7AgHioTYftAazF5dtnXbxqfV+F9isv
         JtXjx6aeu9hd/0h8FJk7TDUwqmj+fVWorewgLaobAyXJxMVnTRZFWmoZW4Oap1hvtLlw
         NU5A/H4mx4jrflDghTf3osgu8h8E0HtqgI5yQQQ88aJ2F7AlCeEL1vAgFLdW6XJazwuc
         TzLgotONSdnDXQgHK39zGywLmNplXgINR2fxphXoB3v0coI/7TTeLRqtGhyuu4ZNYUfo
         zEfg==
X-Gm-Message-State: APjAAAVqSyti5EAPKQy9XTbLGyHr1mSFvGCIN0S08acxCzeZRXaCa1Xr
        6fx4yIg/1gfTJPgIIkb1Ts9Sig==
X-Google-Smtp-Source: APXvYqz6P5q5So52dKSs2wpTTJBgXtQgtXoxAH4VNw3qFZ3E2lGPWwjIbwQBgaJ2j4ai0xiM7MiOMA==
X-Received: by 2002:adf:e386:: with SMTP id e6mr905440wrm.397.1573021671687;
        Tue, 05 Nov 2019 22:27:51 -0800 (PST)
Received: from [148.251.42.114] ([2a01:4f8:201:9271::2])
        by smtp.gmail.com with ESMTPSA id l18sm26812563wrn.48.2019.11.05.22.27.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Nov 2019 22:27:51 -0800 (PST)
Message-ID: <5dc267e7.1c69fb81.496da.9bf1@mx.google.com>
Date:   Tue, 05 Nov 2019 22:27:51 -0800 (PST)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Branch: for-next
X-Kernelci-Lab-Name: lab-baylibre
X-Kernelci-Tree: broonie-sound
X-Kernelci-Report-Type: bisect
X-Kernelci-Kernel: v5.4-rc6-292-gc1efaea10be0
Subject: broonie-sound/for-next boot bisection: v5.4-rc6-292-gc1efaea10be0 on
 sun8i-h3-libretech-all-h3-cc
To:     Mark Brown <broonie@kernel.org>, tomeu.vizoso@collabora.com,
        guillaume.tucker@collabora.com, mgalka@collabora.com,
        Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>,
        Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        broonie@kernel.org,
        Ranjani Sridharan <ranjani.sridharan@linux.intel.com>,
        matthew.hart@linaro.org, khilman@baylibre.com,
        enric.balletbo@collabora.com
From:   "kernelci.org bot" <bot@kernelci.org>
Cc:     Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>,
        alsa-devel@alsa-project.org, Liam Girdwood <lgirdwood@gmail.com>,
        linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

* * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * *
* This automated bisection report was sent to you on the basis  *
* that you may be involved with the breaking commit it has      *
* found.  No manual investigation has been done to verify it,   *
* and the root cause of the problem may be somewhere else.      *
*                                                               *
* If you do send a fix, please include this trailer:            *
*   Reported-by: "kernelci.org bot" <bot@kernelci.org>          *
*                                                               *
* Hope this helps!                                              *
* * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * *

broonie-sound/for-next boot bisection: v5.4-rc6-292-gc1efaea10be0 on sun8i-=
h3-libretech-all-h3-cc

Summary:
  Start:      c1efaea10be0 Merge branch 'asoc-5.5' into asoc-next
  Details:    https://kernelci.org/boot/id/5dc218e159b5142346138dff
  Plain log:  https://storage.kernelci.org//broonie-sound/for-next/v5.4-rc6=
-292-gc1efaea10be0/arm/sunxi_defconfig/gcc-8/lab-baylibre/boot-sun8i-h3-lib=
retech-all-h3-cc.txt
  HTML log:   https://storage.kernelci.org//broonie-sound/for-next/v5.4-rc6=
-292-gc1efaea10be0/arm/sunxi_defconfig/gcc-8/lab-baylibre/boot-sun8i-h3-lib=
retech-all-h3-cc.html
  Result:     ac6a4dd3e9f0 ASoC: soc-core: use snd_soc_lookup_component() a=
t snd_soc_unregister_component()

Checks:
  revert:     PASS
  verify:     PASS

Parameters:
  Tree:       broonie-sound
  URL:        https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound=
.git
  Branch:     for-next
  Target:     sun8i-h3-libretech-all-h3-cc
  CPU arch:   arm
  Lab:        lab-baylibre
  Compiler:   gcc-8
  Config:     sunxi_defconfig
  Test suite: boot

Breaking commit found:

---------------------------------------------------------------------------=
----
commit ac6a4dd3e9f09697ab6a1774d7ab6a34e7ab36fa
Author: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Date:   Tue Nov 5 15:46:51 2019 +0900

    ASoC: soc-core: use snd_soc_lookup_component() at snd_soc_unregister_co=
mponent()
    =

    snd_soc_unregister_component() is now finding component manually,
    but we already have snd_soc_lookup_component() to find component;
    Let's use existing function.
    =

    Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
    Reviewed-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
    Reviewed-by: Ranjani Sridharan <ranjani.sridharan@linux.intel.com>
    Link: https://lore.kernel.org/r/87zhha252c.wl-kuninori.morimoto.gx@rene=
sas.com
    Signed-off-by: Mark Brown <broonie@kernel.org>

diff --git a/sound/soc/soc-core.c b/sound/soc/soc-core.c
index bb0592159414..0ce333669138 100644
--- a/sound/soc/soc-core.c
+++ b/sound/soc/soc-core.c
@@ -2876,29 +2876,19 @@ EXPORT_SYMBOL_GPL(snd_soc_register_component);
  *
  * @dev: The device to unregister
  */
-static int __snd_soc_unregister_component(struct device *dev)
+void snd_soc_unregister_component(struct device *dev)
 {
 	struct snd_soc_component *component;
-	int found =3D 0;
 =

 	mutex_lock(&client_mutex);
-	for_each_component(component) {
-		if (dev !=3D component->dev)
-			continue;
+	while (1) {
+		component =3D snd_soc_lookup_component(dev, NULL);
+		if (!component)
+			break;
 =

 		snd_soc_del_component_unlocked(component);
-		found =3D 1;
-		break;
 	}
 	mutex_unlock(&client_mutex);
-
-	return found;
-}
-
-void snd_soc_unregister_component(struct device *dev)
-{
-	while (__snd_soc_unregister_component(dev))
-		;
 }
 EXPORT_SYMBOL_GPL(snd_soc_unregister_component);
---------------------------------------------------------------------------=
----


Git bisection log:

---------------------------------------------------------------------------=
----
git bisect start
# good: [a99d8080aaf358d5d23581244e5da23b35e340b9] Linux 5.4-rc6
git bisect good a99d8080aaf358d5d23581244e5da23b35e340b9
# bad: [c1efaea10be0d91b6986af5c14cd3482ab160981] Merge branch 'asoc-5.5' i=
nto asoc-next
git bisect bad c1efaea10be0d91b6986af5c14cd3482ab160981
# good: [1092b09708882e3c216f0b9c02e606b3c0942c5b] ASoC: tlv320aic32x4: add=
 a check for devm_clk_get
git bisect good 1092b09708882e3c216f0b9c02e606b3c0942c5b
# good: [f03412b78a947857bbd20899e1423482fba55761] ASoC: rockchip-max98090:=
 Support usage with and without HDMI
git bisect good f03412b78a947857bbd20899e1423482fba55761
# good: [acbf27746ecfa96b290b54cc7f05273482ea128a] ASoC: pcm: update FE/BE =
trigger order based on the command
git bisect good acbf27746ecfa96b290b54cc7f05273482ea128a
# bad: [e443c20593de9f8efd9b2935ed40eb0bbacce30b] ASoC: soc-core: don't cal=
l snd_soc_dapm_new_dai_widgets() at snd_soc_register_dai()
git bisect bad e443c20593de9f8efd9b2935ed40eb0bbacce30b
# good: [b8132657990b5a09ad8e1c9e2c8efc20b5f9372a] ASoC: soc-core: move snd=
_soc_lookup_component()
git bisect good b8132657990b5a09ad8e1c9e2c8efc20b5f9372a
# bad: [ac6a4dd3e9f09697ab6a1774d7ab6a34e7ab36fa] ASoC: soc-core: use snd_s=
oc_lookup_component() at snd_soc_unregister_component()
git bisect bad ac6a4dd3e9f09697ab6a1774d7ab6a34e7ab36fa
# good: [486c7978ff665eb763f70cc9477e0de6326e1c41] ASoC: soc-core: add snd_=
soc_del_component_unlocked()
git bisect good 486c7978ff665eb763f70cc9477e0de6326e1c41
# good: [b18768f56162964f70bbb9119dba59a947d7d577] ASoC: soc-core: remove s=
nd_soc_component_add/del()
git bisect good b18768f56162964f70bbb9119dba59a947d7d577
# first bad commit: [ac6a4dd3e9f09697ab6a1774d7ab6a34e7ab36fa] ASoC: soc-co=
re: use snd_soc_lookup_component() at snd_soc_unregister_component()
---------------------------------------------------------------------------=
----

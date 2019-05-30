Return-Path: <SRS0=Dgga=T6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C9847C28CC0
	for <linux-kernel@archiver.kernel.org>; Thu, 30 May 2019 09:16:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 956D62522E
	for <linux-kernel@archiver.kernel.org>; Thu, 30 May 2019 09:16:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernelci-org.20150623.gappssmtp.com header.i=@kernelci-org.20150623.gappssmtp.com header.b="T/zpFN2m"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727149AbfE3JQZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 May 2019 05:16:25 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:33772 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726720AbfE3JQZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 May 2019 05:16:25 -0400
Received: by mail-wr1-f68.google.com with SMTP id d9so3708510wrx.0
        for <linux-kernel@vger.kernel.org>; Thu, 30 May 2019 02:16:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20150623.gappssmtp.com; s=20150623;
        h=message-id:date:mime-version:content-transfer-encoding:subject:to
         :from:cc;
        bh=I1S45cdBL20CvsZSK3Vkt5vNQs2upcXyMnAlHyCghAk=;
        b=T/zpFN2mPAF3SQ6lAYgD6tKWR5rWJJKb+Vg78eR5EnH6kVWssEFzfrz7I2myTpjEdB
         uRkmZO+NoVexKFmHUeXkljCY5nm83dRV0RLjjrLfznDqneZnA9sWlGMJamwGwHCigzkE
         7+Alug2hguo3mnDp+AwCxnHvvkK15NWLUoixFH0SSYGC8rYghtuVOVtqfqCk5Hm1E9GU
         eBJ8gUfitrYtKDyJA0iUIUvWm3+Ea31uPaBLHH44p/Eta5cZ1lA7r3dUIkKybPRU5Ka3
         BAoMB1z/wGTYzDScpSzI43QCMknpV1PmB5x7nxwTrfXAa6sGKd7kJzpjfOBor6+SWLUV
         7X9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:date:mime-version
         :content-transfer-encoding:subject:to:from:cc;
        bh=I1S45cdBL20CvsZSK3Vkt5vNQs2upcXyMnAlHyCghAk=;
        b=rOC1x3blQ7ehvckfQqnyNq0X4OBRR9wKPnUJPAwvr0WGKTQCLXXXWswbUYTqfgdqhY
         2Dq6zJPtKrdjDaSiHWCWG1DVdbcke1Y3NJpxGEB3Wnc5UHMey1tybpoKIGXKTk0nALe9
         fmzgetSRNlP1nHo10Uu5OGaAEUMbpTG5oc6/4iE2RSfZtwKtZbiYxChrKrJWA2koCZP2
         L93KKCauDB6/ZzBX40zr20BMZTX8eTwvE+GZJ+yKnktUkYgWp8IpqMcJTLAUSs207hOL
         qZyZJZR3yTqIISsWyWhevHGmiP7tW7TX3sfP37CHQUkDqG832EBqdJ51cpVGS3J8vtt9
         7mCQ==
X-Gm-Message-State: APjAAAWm+iw8hBuExUUaFsK9+tq4Lm1Y0Zq6Au8HUqJZQtPgdlPB2Caj
        i2ZLtu0rFYRnq2AdiPwBcw6EIQ==
X-Google-Smtp-Source: APXvYqxPO+aU4NLmBYmMxBYv7zcWu35kkFoFjlVAjNqdxL18t/kYSZuTrJJ9GNOUC02j/lF4ntsIyw==
X-Received: by 2002:adf:cf0c:: with SMTP id o12mr1865157wrj.182.1559207783309;
        Thu, 30 May 2019 02:16:23 -0700 (PDT)
Received: from [148.251.42.114] ([2a01:4f8:201:9271::2])
        by smtp.gmail.com with ESMTPSA id y132sm3504881wmd.35.2019.05.30.02.16.22
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 30 May 2019 02:16:22 -0700 (PDT)
Message-ID: <5cef9f66.1c69fb81.39f30.21e8@mx.google.com>
Date:   Thu, 30 May 2019 02:16:22 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Report-Type: bisect
X-Kernelci-Tree: next
X-Kernelci-Lab-Name: lab-baylibre
X-Kernelci-Branch: master
X-Kernelci-Kernel: next-20190528
Subject: next/master boot bisection: next-20190528 on
 sun8i-h3-libretech-all-h3-cc
To:     Mark Brown <broonie@kernel.org>, tomeu.vizoso@collabora.com,
        guillaume.tucker@collabora.com, mgalka@collabora.com,
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
* Hope this helps!                                              *
* * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * *

next/master boot bisection: next-20190528 on sun8i-h3-libretech-all-h3-cc

Summary:
  Start:      531b0a360899 Add linux-next specific files for 20190528
  Details:    https://kernelci.org/boot/id/5cece0fd59b5144bc47a362b
  Plain log:  https://storage.kernelci.org//next/master/next-20190528/arm/s=
unxi_defconfig/gcc-8/lab-baylibre/boot-sun8i-h3-libretech-all-h3-cc.txt
  HTML log:   https://storage.kernelci.org//next/master/next-20190528/arm/s=
unxi_defconfig/gcc-8/lab-baylibre/boot-sun8i-h3-libretech-all-h3-cc.html
  Result:     34ac3c3eb8f0 ASoC: core: lock client_mutex while removing lin=
k components

Checks:
  revert:     PASS
  verify:     PASS

Parameters:
  Tree:       next
  URL:        git://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next=
.git
  Branch:     master
  Target:     sun8i-h3-libretech-all-h3-cc
  CPU arch:   arm
  Lab:        lab-baylibre
  Compiler:   gcc-8
  Config:     sunxi_defconfig
  Test suite: boot

Breaking commit found:

---------------------------------------------------------------------------=
----
commit 34ac3c3eb8f0c07252ceddf0a22dd240e5c91ccb
Author: Ranjani Sridharan <ranjani.sridharan@linux.intel.com>
Date:   Thu May 23 10:12:01 2019 -0700

    ASoC: core: lock client_mutex while removing link components
    =

    Removing link components results in topology unloading. So,
    acquire the client_mutex before removing components in
    soc_remove_link_components. This will prevent the lockdep warning
    seen when dai links are removed during topology removal.
    =

    Signed-off-by: Ranjani Sridharan <ranjani.sridharan@linux.intel.com>
    Signed-off-by: Mark Brown <broonie@kernel.org>

diff --git a/sound/soc/soc-core.c b/sound/soc/soc-core.c
index 2403bec2fccf..7c9415987ac7 100644
--- a/sound/soc/soc-core.c
+++ b/sound/soc/soc-core.c
@@ -1005,12 +1005,14 @@ static void soc_remove_link_components(struct snd_s=
oc_card *card,
 	struct snd_soc_component *component;
 	struct snd_soc_rtdcom_list *rtdcom;
 =

+	mutex_lock(&client_mutex);
 	for_each_rtdcom(rtd, rtdcom) {
 		component =3D rtdcom->component;
 =

 		if (component->driver->remove_order =3D=3D order)
 			soc_remove_component(component);
 	}
+	mutex_unlock(&client_mutex);
 }
 =

 static void soc_remove_dai_links(struct snd_soc_card *card)
---------------------------------------------------------------------------=
----


Git bisection log:

---------------------------------------------------------------------------=
----
git bisect start
# good: [cd6c84d8f0cdc911df435bb075ba22ce3c605b07] Linux 5.2-rc2
git bisect good cd6c84d8f0cdc911df435bb075ba22ce3c605b07
# bad: [531b0a360899269bd99a38ba9852a8ba46852bcd] Add linux-next specific f=
iles for 20190528
git bisect bad 531b0a360899269bd99a38ba9852a8ba46852bcd
# bad: [0b61d4c3b7d7938ef0014778c328e3f65c0d6d57] Merge remote-tracking bra=
nch 'crypto/master'
git bisect bad 0b61d4c3b7d7938ef0014778c328e3f65c0d6d57
# bad: [6179e21b065dc0f592cd3d9d3676bd64d4278025] Merge remote-tracking bra=
nch 'xtensa/xtensa-for-next'
git bisect bad 6179e21b065dc0f592cd3d9d3676bd64d4278025
# bad: [3e085f66fe7e93575f2a583a3d434415cef2d860] Merge remote-tracking bra=
nch 'amlogic/for-next'
git bisect bad 3e085f66fe7e93575f2a583a3d434415cef2d860
# bad: [b9afa223a3420432bc483d2b43429c88c6a5d0e0] Merge remote-tracking bra=
nch 'staging.current/staging-linus'
git bisect bad b9afa223a3420432bc483d2b43429c88c6a5d0e0
# good: [fc6557648e19dbd207dc815c6e09fc6452f01e63] Merge remote-tracking br=
anch 'bpf/master'
git bisect good fc6557648e19dbd207dc815c6e09fc6452f01e63
# bad: [6c3f2a0e0f236f31b47d63ab7d3f4ec889821d0d] Merge remote-tracking bra=
nch 'spi-fixes/for-linus'
git bisect bad 6c3f2a0e0f236f31b47d63ab7d3f4ec889821d0d
# bad: [20a5f9c8649d74407aa657ce5b76cf8b0bbb17e3] Merge branch 'asoc-5.2' i=
nto asoc-linus
git bisect bad 20a5f9c8649d74407aa657ce5b76cf8b0bbb17e3
# good: [ad6eecbfc01c987e0253371f274c3872042e4350] ASoC: cs42xx8: Add regca=
che mask dirty
git bisect good ad6eecbfc01c987e0253371f274c3872042e4350
# good: [069d037aea98ffa64c26d4b1dc958fb8f39f5c2b] ASoC: simple-card: Fix c=
onfiguration of DAI format
git bisect good 069d037aea98ffa64c26d4b1dc958fb8f39f5c2b
# good: [df9366131a452296d040a7a496d93108f1fc240c] ASoC: Intel: sof-rt5682:=
 fix AMP quirk support
git bisect good df9366131a452296d040a7a496d93108f1fc240c
# bad: [34ac3c3eb8f0c07252ceddf0a22dd240e5c91ccb] ASoC: core: lock client_m=
utex while removing link components
git bisect bad 34ac3c3eb8f0c07252ceddf0a22dd240e5c91ccb
# good: [4819d06292c9b57eabdd6d1603e49a27baf183be] ASoC: simple-card: Resto=
re original configuration of DAI format
git bisect good 4819d06292c9b57eabdd6d1603e49a27baf183be
# first bad commit: [34ac3c3eb8f0c07252ceddf0a22dd240e5c91ccb] ASoC: core: =
lock client_mutex while removing link components
---------------------------------------------------------------------------=
----

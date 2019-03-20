Return-Path: <SRS0=4Jrr=RX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E9FA5C43381
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Mar 2019 18:01:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BEBF921873
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Mar 2019 18:01:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=gmx.net header.i=@gmx.net header.b="g9xJiTNp"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727251AbfCTSBZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Mar 2019 14:01:25 -0400
Received: from mout.gmx.net ([212.227.17.21]:52419 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726438AbfCTSBY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Mar 2019 14:01:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1553104864;
        bh=nUVyKlHl35c8nxOoa32gQoeWkc5dic50c4J2+Vc1wEQ=;
        h=X-UI-Sender-Class:From:To:Cc:Subject:Date:In-Reply-To:References;
        b=g9xJiTNpQvhCALgIrlBYt8CrmScPML+9giZQPSqg8OIqSo07s82iBRvfhlu5aLXZH
         n+DCZ0toO5erO6o3pNy3Rv3/gOXs5a08/sp2yljp0eazzkDgUKK3GfaaSSUpGoLAd6
         gbrDHtQc9q+3fY2u6rv2RdVOqARzb3ouIOi+y0vY=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [93.201.39.37] ([93.201.39.37]) by web-mail.gmx.net
 (3c-app-gmx-bs13.server.lan [172.19.170.65]) (via HTTP); Wed, 20 Mar 2019
 19:01:04 +0100
MIME-Version: 1.0
Message-ID: <trinity-60833541-df5b-44b8-82c7-1ed844f9ab51-1553104864025@3c-app-gmx-bs13>
From:   "Frank Wunderlich" <frank-w@public-files.de>
To:     "Hsin-Yi Wang" <hsinyi@chromium.org>
Cc:     linux-arm-kernel@lists.infradead.org,
        "Philipp Zabel" <p.zabel@pengutronix.de>,
        "David Airlie" <airlied@linux.ie>, linux-kernel@vger.kernel.org,
        dri-devel@lists.freedesktop.org,
        "Matthias Brugger" <matthias.bgg@gmail.com>,
        linux-mediatek@lists.infradead.org,
        "Daniel Vetter" <daniel@ffwll.ch>, "CK Hu" <ck.hu@mediatek.com>
Subject: Aw: [PATCH v2] gpu/drm: mediatek: call mtk_dsi_stop() after
 mtk_drm_crtc_atomic_disable()
Content-Type: text/plain; charset=UTF-8
Date:   Wed, 20 Mar 2019 19:01:04 +0100
Importance: normal
Sensitivity: Normal
In-Reply-To: <20190320071825.20268-1-hsinyi@chromium.org>
References: <20190320071825.20268-1-hsinyi@chromium.org>
X-UI-Message-Type: mail
X-Priority: 3
X-Provags-ID: V03:K1:eeJnWdA8TZZ/sA2wz/iprhtBReAIBg1Wvu5lBcstd5alZEuedRcm64AW7wXAYZ2Kwq1Ok
 eSxWRwFGf6IfwRTnHEEqjhR6QtFZkcB2LzpQ2XrL2tvcgzmnUDQ/HC+LxQas6vTJfsqPZ7kC0euu
 f/2uHzOO7PaAP5T8mMqobKkDFPgl5bLfdq4Qy1dZNK0oERd/Kb5PycFeIXrwz/fwMljxIHQPnTZm
 pOFNCXOjqBFApy+fGtdDNG2sL64TrW3qKCAP/7eyva7p0mDI3e5T4iELJolEdvp/CWaIojbd9Maa
 GI=
X-UI-Out-Filterresults: notjunk:1;V03:K0:i9xwmo6armY=:juJ2E2jHvrNl6yFDYCDMkB
 w92qnu4UhLMbEc2AtbhjcILHkDS0rOc3b3gcr873yWaYWrk3A+VoF5cV1lW5/O1UW8ExoT2Rw
 h7BcYDnwhxykzRvuHchhibvMRdLc3EXhDPJMGyAxBzeZt1zGw0BwDLirVPRU+nWNq2wfB2B/h
 osWf4MZJCCsTE31cpqe7pyuJJefd0iizgPbj4RoiZKIBHvJOzYqPe2TpaPBUrvOVK1Iw4nh3X
 FbbtDf9y9aSO4Sy9SB+lRCUba2xufkz/wD0QgfswYvi0N2RiNKF9DsfnOAXfAZqCTq9a/IuxP
 IUqsz3RmbqC0isLRgFVty1FdLhRyomr1s791y6G5jBIR9UlW9t4tGp7P/1MF1qocaJecHMlTs
 oOUnaAR2vvhQ/QcGYWDNe3lY/NW0+p6wkF5QgeJSVTgDYtozmYu5+cXoSpTeqTc36MrsHM8jf
 uYXhedcftAhsQMeEzIzDsWAoK0TDW7jxC45lRbnuuKj2xNJuTsFeokaPdSfDx8ul07/kczQ/3
 OId1fR9hHsEa61kzbBVn8VMfebfSOj41qgcqRv1aKWRgPA6FC+HRdPruekhcmkAb8dqf0xFKb
 3Y79TsgLqKnBo=
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

i hoped this fixes my warning (maybe have similar cause) on bananapi-r2/mt7623

[    6.872034] WARNING: CPU: 2 PID: 160 at drivers/gpu/drm/drm_atomic_helper.c:1
430 drm_atomic_helper_wait_for_vblanks.part.1+0x2a4/0x2a8
[    6.872038] [CRTC:36:crtc-0] vblank wait timed out

...

[    6.872127] [<c0126e4c>] (__warn) from [<c0126fac>] (warn_slowpath_fmt+0x58/0
x74)
[    6.872136]  r9:00000000 r8:00000001 r7:00000000 r6:00000001 r5:c0d7da9c r4:c
1008c48
[    6.872145] [<c0126f58>] (warn_slowpath_fmt) from [<c05ce65c>] (drm_atomic_helper_wait_for_vblanks.part.1+0x2a4/0x2a8)
[    6.872150]  r3:00000024 r2:c0d7da9c
[    6.872154]  r5:00000000 r4:d991f440
[    6.872164] [<c05ce3b8>] (drm_atomic_helper_wait_for_vblanks.part.1) from [<c05ce684>] (drm_atomic_helper_wait_for_vblanks+0x24/0x28)
[    6.872172]  r10:dae68f28 r9:dae68f38 r8:00000000 r7:d9f759c0 r6:d991ec00 r5:d9f759c0
[    6.872175]  r4:00000005
[    6.872185] [<c05ce660>] (drm_atomic_helper_wait_for_vblanks) from [<c060af04>] (mtk_atomic_complete+0x98/0xc0)
[    6.872194] [<c060ae6c>] (mtk_atomic_complete) from [<c060aff4>] (mtk_atomic_commit+0xc8/0xcc)
[    6.872201]  r7:d9f759c0 r6:dae68e40 r5:d991ec00 r4:00000000
[    6.872211] [<c060af2c>] (mtk_atomic_commit) from [<c05efed0>] (drm_atomic_commit+0x54/0x60)
[    6.872219]  r10:00000002 r9:d9f74eac r8:00000001 r7:d98d5700 r6:d991ec00 r5:d9f759c0
[    6.872223]  r4:00000000 r3:c060af2c
[    6.872234] [<c05efe7c>] (drm_atomic_commit) from [<c05d33b8>] (restore_fbdev_mode_atomic+0x1d4/0x1e4)
[    6.872241]  r7:d98d5700 r6:00000001 r5:d991edb0 r4:d9f759c0
[    6.872251] [<c05d31e4>] (restore_fbdev_mode_atomic) from [<c05d5598>] (restore_fbdev_mode+0x5c/0x194)
[    6.872260]  r10:00000000 r9:d991ecdc r8:d98d57b4 r7:00000000 r6:d98d5700 r5:d98d5700
[    6.872263]  r4:00000000
[    6.872274] [<c05d553c>] (restore_fbdev_mode) from [<c05d7054>] (drm_fb_helper_restore_fbdev_mode_unlocked+0x64/0xb0)
[    6.872282]  r10:00000000 r9:d991ecdc r8:d98d57b4 r7:00000000 r6:c10824c8 r5:d98d5700
[    6.872285]  r4:00000000
[    6.872296] [<c05d6ff0>] (drm_fb_helper_restore_fbdev_mode_unlocked) from [<c05d70e0>] (drm_fb_helper_set_par+0x40/0x64)
[    6.872304]  r9:d991ecdc r8:d991ec8c r7:c0d82d88 r6:d98d57b4 r5:00000000 r4:00000000
[    6.872315] [<c05d70a0>] (drm_fb_helper_set_par) from [<c05d6fa4>] (drm_fb_helper_hotplug_event.part.11+0xb0/0xb8)
[    6.872319]  r5:00000000 r4:d98d5700
[    6.872330] [<c05d6ef4>] (drm_fb_helper_hotplug_event.part.11) from [<c05d72c8>] (drm_fbdev_client_hotplug+0x13c/0x1d8)
[    6.872337]  r7:c0d82d88 r6:d991eca0 r5:d991ec00 r4:d98d5700
[    6.872348] [<c05d718c>] (drm_fbdev_client_hotplug) from [<c0601640>] (drm_client_dev_hotplug+0x84/0xc0)

this crash also happens without fbdev-patch

my codebase: https://github.com/frank-w/BPI-R2-4.14/commits/5.1-hdmi

regards Frank

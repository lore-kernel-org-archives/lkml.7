Return-Path: <SRS0=XcGb=25=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 38619C33C9E
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Jan 2020 11:50:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F344820643
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Jan 2020 11:50:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="BAGd9+Gp"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727444AbgAHLua (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 Jan 2020 06:50:30 -0500
Received: from mailout1.w1.samsung.com ([210.118.77.11]:60931 "EHLO
        mailout1.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726290AbgAHLu3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Jan 2020 06:50:29 -0500
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
        by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20200108115027euoutp013e152c4c6155a8b636d486c0932c1eeb~n5wrKEqWm0444104441euoutp019
        for <linux-kernel@vger.kernel.org>; Wed,  8 Jan 2020 11:50:27 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20200108115027euoutp013e152c4c6155a8b636d486c0932c1eeb~n5wrKEqWm0444104441euoutp019
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1578484227;
        bh=3OyRPuFqCIRdzwH2FYDtdhnfPsBECJGMdvkxFH7m2yU=;
        h=From:To:Cc:Subject:Date:References:From;
        b=BAGd9+GpbtxPozyM4oukg80FyFdXjt5mYG6eW4cftmjYb2L/0Xw4m15L2bNdqjZnu
         //3gnXgfcuDsC1iX+DUBuDDG4xf3DuokfQ5DP6fZP6cIlFl7BbdQEss0dl2vpLmaDH
         ijRa5fPOe/voAuA9UPYvZiQeKI2Ghqx1jK6MzR/w=
Received: from eusmges3new.samsung.com (unknown [203.254.199.245]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTP id
        20200108115027eucas1p2d11eb4dc1d466e7dbd0b1b36075e8d9e~n5wq0UHpk3212532125eucas1p2k;
        Wed,  8 Jan 2020 11:50:27 +0000 (GMT)
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
        eusmges3new.samsung.com (EUCPMTA) with SMTP id C6.03.60698.302C51E5; Wed,  8
        Jan 2020 11:50:27 +0000 (GMT)
Received: from eusmtrp2.samsung.com (unknown [182.198.249.139]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
        20200108115027eucas1p2abcd40e359e993e5b471229b02b69fc3~n5wqaRcR22915229152eucas1p2G;
        Wed,  8 Jan 2020 11:50:27 +0000 (GMT)
Received: from eusmgms2.samsung.com (unknown [182.198.249.180]) by
        eusmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20200108115027eusmtrp28c6e206ae88bd77a88adeee8520cd1e0~n5wqZmVEb1831018310eusmtrp2Z;
        Wed,  8 Jan 2020 11:50:27 +0000 (GMT)
X-AuditID: cbfec7f5-a0fff7000001ed1a-23-5e15c2035f05
Received: from eusmtip1.samsung.com ( [203.254.199.221]) by
        eusmgms2.samsung.com (EUCPMTA) with SMTP id 5E.A4.07950.302C51E5; Wed,  8
        Jan 2020 11:50:27 +0000 (GMT)
Received: from AMDC2765.digital.local (unknown [106.120.51.73]) by
        eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20200108115026eusmtip16de4a492f67213a17e0ad1e60bd5ff50~n5wp4ZlIZ1983219832eusmtip1U;
        Wed,  8 Jan 2020 11:50:26 +0000 (GMT)
From:   Marek Szyprowski <m.szyprowski@samsung.com>
To:     alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
        linux-samsung-soc@vger.kernel.org
Cc:     Marek Szyprowski <m.szyprowski@samsung.com>,
        Mark Brown <broonie@kernel.org>,
        Sylwester Nawrocki <s.nawrocki@samsung.com>,
        Tzung-Bi Shih <tzungbi@google.com>,
        Dylan Reid <dgreid@google.com>,
        Jimmy Cheng-Yi Chiang <cychiang@google.com>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Subject: [PATCH 1/2] ASoC: max98090: fix incorrect helper in
 max98090_dapm_put_enum_double()
Date:   Wed,  8 Jan 2020 12:50:06 +0100
Message-Id: <20200108115007.31095-1-m.szyprowski@samsung.com>
X-Mailer: git-send-email 2.17.1
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFmpmleLIzCtJLcpLzFFi42LZduznOV3mQ6JxBrfXKVpcuXiIyWLjjPWs
        FlMfPmGzOHG4kdmifWYHo8X58xvYLS7vmsNmMeP8PiaLtUfuslscftPOarHn4it2B26PDZ+b
        2DwWbCr12LSqk82jb8sqRo/Pm+QCWKO4bFJSczLLUov07RK4Mrrab7EX/BWsmPWhmamB8Sh/
        FyMnh4SAicTjB7vZuxi5OIQEVjBKLPjbxwjhfGGU6H83ByrzmVHiYvtGNpiWE3c3MUEkljNK
        /DgwgxEkAday8q4KiM0mYCjR9bYLrEFEIEni/ILbzCANzAKXmSRWN/YzgySEBeIk7u9+ANbM
        IqAqcar9H1icV8BW4trXjUwQ2+QlVm84ANYsIfCZTeL09qdQZ7hIbD2zggXCFpZ4dXwLO4Qt
        I/F/53wmiIZmRomH59ayQzg9jBKXmyBulRCwlrhz7hfQJA6gmzQl1u/Shwg7Siy4vAssLCHA
        J3HjrSBImBnInLRtOjNEmFeio00IolpNYtbxdXBrD164xAxhe0jseb6NBRIosRIzz75gncAo
        Nwth1wJGxlWM4qmlxbnpqcXGeanlesWJucWleel6yfm5mxiBSeP0v+NfdzDu+5N0iFGAg1GJ
        h/fHYpE4IdbEsuLK3EOMEhzMSiK8WjpAId6UxMqq1KL8+KLSnNTiQ4zSHCxK4rzGi17GCgmk
        J5akZqemFqQWwWSZODilGhhr1/0Qdt/nnxaxRP6Z9Kfzh0r/5DgrvUo4orD6aedmjm/q95LV
        252uMJtHdK6q0jywrJCr6WLt9tIF3av2iH2bc3RK1sR9HyLX8Ha2zxJPFfATNnz5377+4ZoX
        f1nE9Pk2uEr8ZmS4+DXhw3Q2tqVfFxn9KHnpf+2Zr3NpxrwzTnIv7nIHFm1RYinOSDTUYi4q
        TgQAZc1IfBYDAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrBLMWRmVeSWpSXmKPExsVy+t/xu7rMh0TjDK70slhcuXiIyWLjjPWs
        FlMfPmGzOHG4kdmifWYHo8X58xvYLS7vmsNmMeP8PiaLtUfuslscftPOarHn4it2B26PDZ+b
        2DwWbCr12LSqk82jb8sqRo/Pm+QCWKP0bIryS0tSFTLyi0tslaINLYz0DC0t9IxMLPUMjc1j
        rYxMlfTtbFJSczLLUov07RL0Mrrab7EX/BWsmPWhmamB8Sh/FyMnh4SAicSJu5uYQGwhgaWM
        EneeG0DEZSROTmtghbCFJf5c62LrYuQCqvnEKLH8cycjSIJNwFCi6y1IgpNDRCBF4ueMdYwg
        RcwCN5kkfixezgySEBaIkehe9gJsEouAqsSp9n9gcV4BW4lrXzcyQWyQl1i94QDzBEaeBYwM
        qxhFUkuLc9Nzi430ihNzi0vz0vWS83M3MQJDdduxn1t2MHa9Cz7EKMDBqMTD+2OxSJwQa2JZ
        cWXuIUYJDmYlEV4tHaAQb0piZVVqUX58UWlOavEhRlOg5ROZpUST84FxlFcSb2hqaG5haWhu
        bG5sZqEkztshcDBGSCA9sSQ1OzW1ILUIpo+Jg1OqgXFhsGfksr/i+Un/p7pMUr30jUk1uqv0
        9G8Tt9T/3CVG6yPs7ebys6S05L1YrJqc2Zy26+KieG8JNk+Fjz+rMk7dyXEP7Hh4wufA78dm
        z97fyvL/fUnZ8+ydB2ysN+bxq/UWTuHneT2xagP3g/4jT960Op1vZfl/5o+mS8j+puT5FwQ+
        zfW1S1diKc5INNRiLipOBAD0phjzawIAAA==
X-CMS-MailID: 20200108115027eucas1p2abcd40e359e993e5b471229b02b69fc3
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20200108115027eucas1p2abcd40e359e993e5b471229b02b69fc3
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20200108115027eucas1p2abcd40e359e993e5b471229b02b69fc3
References: <CGME20200108115027eucas1p2abcd40e359e993e5b471229b02b69fc3@eucas1p2.samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit 62d5ae4cafb7 ("ASoC: max98090: save and restore SHDN when changing
sensitive registers") extended the code for handling "LTENL Mux", "LTENR
Mux", "LBENL Mux" and "LBENR Mux" controls by adding a custom
max98090_dapm_put_enum_double() function to them. However that function
used incorrect helper to get its component object. Fix this by using the
proper snd_soc_dapm_* helper.

This fixes the following NULL pointer exception observed on
Exynos4412-based Odroid U3 board:
8<--- cut here ---
Unable to handle kernel NULL pointer dereference at virtual address 000000b0
pgd = (ptrval)
[000000b0] *pgd=00000000
Internal error: Oops: 5 [#1] PREEMPT SMP ARM
Modules linked in:
CPU: 0 PID: 1104 Comm: alsactl Not tainted 5.5.0-rc5-next-20200107 #166
Hardware name: SAMSUNG EXYNOS (Flattened Device Tree)
PC is at __mutex_lock+0x54/0xb18
LR is at ___might_sleep+0x3c/0x2e0
...
Process alsactl (pid: 1104, stack limit = 0x(ptrval))
...
[<c0b49630>] (__mutex_lock) from [<c0b4a110>] (mutex_lock_nested+0x1c/0x24)
[<c0b4a110>] (mutex_lock_nested) from [<c0839b3c>] (max98090_shdn_save+0x1c/0x28)
[<c0839b3c>] (max98090_shdn_save) from [<c083a4f8>] (max98090_dapm_put_enum_double+0x20/0x40)
[<c083a4f8>] (max98090_dapm_put_enum_double) from [<c080d0e8>] (snd_ctl_ioctl+0x190/0xbb8)
[<c080d0e8>] (snd_ctl_ioctl) from [<c02cafec>] (ksys_ioctl+0x470/0xaf8)
[<c02cafec>] (ksys_ioctl) from [<c0101000>] (ret_fast_syscall+0x0/0x28)
...
---[ end trace 0e93f0580f4b9241 ]---

Fixes: 62d5ae4cafb7 ("ASoC: max98090: save and restore SHDN when changing sensitive registers")
Signed-off-by: Marek Szyprowski <m.szyprowski@samsung.com>
---
 sound/soc/codecs/max98090.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/codecs/max98090.c b/sound/soc/codecs/max98090.c
index 4c7b16d557e2..c01ce4a3f86d 100644
--- a/sound/soc/codecs/max98090.c
+++ b/sound/soc/codecs/max98090.c
@@ -82,7 +82,7 @@ static int max98090_dapm_put_enum_double(struct snd_kcontrol *kcontrol,
 	struct snd_ctl_elem_value *ucontrol)
 {
 	struct snd_soc_component *component =
-		snd_soc_kcontrol_component(kcontrol);
+		snd_soc_dapm_kcontrol_component(kcontrol);
 	struct max98090_priv *max98090 =
 		snd_soc_component_get_drvdata(component);
 	int ret;
-- 
2.17.1


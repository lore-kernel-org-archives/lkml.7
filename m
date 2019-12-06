Return-Path: <SRS0=xBSd=Z4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 97EB1C2D0B1
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Dec 2019 12:51:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6E5E0205F4
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Dec 2019 12:51:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="X9D+TJ1j"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726246AbfLFMv0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 6 Dec 2019 07:51:26 -0500
Received: from mailout1.w1.samsung.com ([210.118.77.11]:59249 "EHLO
        mailout1.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726124AbfLFMvZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Dec 2019 07:51:25 -0500
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
        by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20191206125124euoutp014e35b46a47203565241e02b878937f16~dyTdl7kra2068520685euoutp01q
        for <linux-kernel@vger.kernel.org>; Fri,  6 Dec 2019 12:51:24 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20191206125124euoutp014e35b46a47203565241e02b878937f16~dyTdl7kra2068520685euoutp01q
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1575636684;
        bh=wF1Iy7VsoT2dA4yuiPpiriyC0w9NhNDxY4A8+kILiJk=;
        h=From:To:Cc:Subject:Date:References:From;
        b=X9D+TJ1jpuWYWlNh0VcSUHOxpmchQi+awZxcGlzfUNxITsJrm+8goXrkw+qkfwNoK
         N5IN9G8dfyyz+7r4bJAu6PzBaIjdGiraQ4BNGSU5kmBYiMb1lWjrnx+vzJ1KW2q4oY
         vOMUrEKjImTLJkH/78ZmTuwVi8PLG/AbOFmRDwcQ=
Received: from eusmges2new.samsung.com (unknown [203.254.199.244]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTP id
        20191206125124eucas1p1d7f4a644ba4feea13d90848c6bad9607~dyTdO4M7b3207632076eucas1p1i;
        Fri,  6 Dec 2019 12:51:24 +0000 (GMT)
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
        eusmges2new.samsung.com (EUCPMTA) with SMTP id 31.D7.60679.BCE4AED5; Fri,  6
        Dec 2019 12:51:23 +0000 (GMT)
Received: from eusmtrp2.samsung.com (unknown [182.198.249.139]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
        20191206125123eucas1p1c1652484cbccef8d8df37e09affe4e25~dyTc0k1df1825518255eucas1p1d;
        Fri,  6 Dec 2019 12:51:23 +0000 (GMT)
Received: from eusmgms1.samsung.com (unknown [182.198.249.179]) by
        eusmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20191206125123eusmtrp2ffb17d3f3f0243921fd4239724b33edf~dyTcz7C4Y0189301893eusmtrp2I;
        Fri,  6 Dec 2019 12:51:23 +0000 (GMT)
X-AuditID: cbfec7f4-0e5ff7000001ed07-1f-5dea4ecbcf79
Received: from eusmtip2.samsung.com ( [203.254.199.222]) by
        eusmgms1.samsung.com (EUCPMTA) with SMTP id D4.D6.08375.BCE4AED5; Fri,  6
        Dec 2019 12:51:23 +0000 (GMT)
Received: from AMDC2765.digital.local (unknown [106.120.51.73]) by
        eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20191206125123eusmtip2070f004f9a6e9b6c4ef2024ffd34fe94~dyTcVHUsz0588405884eusmtip2K;
        Fri,  6 Dec 2019 12:51:23 +0000 (GMT)
From:   Marek Szyprowski <m.szyprowski@samsung.com>
To:     linux-samsung-soc@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     Marek Szyprowski <m.szyprowski@samsung.com>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Olof Johansson <olof@lixom.net>, Arnd Bergmann <arnd@arndb.de>,
        Kusanagi Kouichi <slash@ac.auone-net.jp>,
        Steven Rostedt <rostedt@goodmis.org>
Subject: [PATCH] arm: multi_v7_config: Restore debugfs support
Date:   Fri,  6 Dec 2019 13:51:12 +0100
Message-Id: <20191206125112.11006-1-m.szyprowski@samsung.com>
X-Mailer: git-send-email 2.17.1
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFuphleLIzCtJLcpLzFFi42LZduznOd3Tfq9iDeZ9Mbf4O+kYu8XGGetZ
        Lc6f38BusenxNVaLy7vmsFnMOL+PyWLtkbvsFqeuf2az2NfxgMni+auzzA5cHisW7WX3+P1r
        EqNHy75b7B6bVnWyeWxeUu9x5UQTq0ffllWMHp83yQVwRHHZpKTmZJalFunbJXBlHPj1h7Hg
        PEdF356rbA2Me9m7GDk5JARMJGbf2sTSxcjFISSwglHiztJrjBDOF0aJ6ZPvsIFUCQl8ZpQ4
        d8kWpmNrz1QmiKLljBK/+r+xw3Us7rrPDFLFJmAo0fW2C6xbRCBbovPxA7CxzAKLmCT+LNwH
        tlxYwE6i8cJaoAYODhYBVYklbypBwrwCthITT81hgtgmL7F6wwFmkF4JgWZ2ieM7/kIlXCSO
        dE5jhrCFJV4d3wL1kIzE/53zmaAaGCUenlvLDuH0MEpcbprBCFFlLXH4+EVWkM3MApoS63fp
        Q4QdJd6+aWUDCUsI8EnceCsIEmYGMidtm84MEeaV6GgTgqhWk5h1fB3c2oMXLkGd4yHR2b6M
        BRJysRJf1m9hn8AoNwth1wJGxlWM4qmlxbnpqcVGeanlesWJucWleel6yfm5mxiBaeT0v+Nf
        djDu+pN0iFGAg1GJh3fG5xexQqyJZcWVuYcYJTiYlUR40/lexgrxpiRWVqUW5ccXleakFh9i
        lOZgURLnNV4ElBJITyxJzU5NLUgtgskycXBKNTBO0VhYfyP1mEPbLNncLct7giTZEkqeiscc
        8D8ZPqN4T+HrXp8vF/5vfKZ6l1e76LPTNN3D7xZPr6swtW9+9SnO4O09/xonwYk2V7WMDK0i
        GX7pPfG8vGzlhl+LptVtmCazIod79QeuuL/zbutO2v9lq+PmB+1ia379Zchb1mnvf5hhJ2M6
        1zc5JZbijERDLeai4kQAXjPhyx8DAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrILMWRmVeSWpSXmKPExsVy+t/xe7qn/V7FGkw8pGjxd9IxdouNM9az
        Wpw/v4HdYtPja6wWl3fNYbOYcX4fk8XaI3fZLU5d/8xmsa/jAZPF81dnmR24PFYs2svu8fvX
        JEaPln232D02repk89i8pN7jyokmVo++LasYPT5vkgvgiNKzKcovLUlVyMgvLrFVija0MNIz
        tLTQMzKx1DM0No+1MjJV0rezSUnNySxLLdK3S9DLOPDrD2PBeY6Kvj1X2RoY97J3MXJySAiY
        SGztmcrUxcjFISSwlFGi5egpqISMxMlpDawQtrDEn2tdbBBFnxglVs/9xAaSYBMwlOh6C5Lg
        4BARyJV4s0wcpIZZYAWTxK1n+8FqhAXsJBovrGUGqWERUJVY8qYSJMwrYCsx8dQcJoj58hKr
        NxxgnsDIs4CRYRWjSGppcW56brGhXnFibnFpXrpecn7uJkZg8G479nPzDsZLG4MPMQpwMCrx
        8M74/CJWiDWxrLgy9xCjBAezkghvOt/LWCHelMTKqtSi/Pii0pzU4kOMpkC7JzJLiSbnAyMr
        ryTe0NTQ3MLS0NzY3NjMQkmct0PgYIyQQHpiSWp2ampBahFMHxMHp1QDo0HLzVflKYarshuW
        uV/Mn+WonvHV3WjJ1PNMpjFhctWBB65ceZBQ+X3R5m0WB6V+e726MbGdn2dWetyCpuObE7W4
        2J7eOsZz/hxf7KQL1zjZ72efSTweve4rdzu/Jl/84yif4knt4fcun772vePvtvlrb0zbL/Vk
        0sXZ23PX+yn4TJio4PvYoUmJpTgj0VCLuag4EQD4BPjIdAIAAA==
X-CMS-MailID: 20191206125123eucas1p1c1652484cbccef8d8df37e09affe4e25
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20191206125123eucas1p1c1652484cbccef8d8df37e09affe4e25
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20191206125123eucas1p1c1652484cbccef8d8df37e09affe4e25
References: <CGME20191206125123eucas1p1c1652484cbccef8d8df37e09affe4e25@eucas1p1.samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit fd7d58f0dbc3 ("ARM: multi_v7_defconfig: renormalize based on recent
additions") removed explicit enable line for CONFIG_DEBUG_FS, because
that feature has been selected by other enabled options: CONFIG_TRACING,
which were enabled by CONFIG_PERF_EVENTS.

In meantime, commit 0e4a459f56c3 ("tracing: Remove unnecessary DEBUG_FS
dependency") removed the dependency between CONFIG_DEBUG_FS and
CONFIG_TRACING, so CONFIG_DEBUG_FS is no longer enabled in default builds.

Enable it again explicitly, as debugfs support is essential for various
automated testing tools.

Signed-off-by: Marek Szyprowski <m.szyprowski@samsung.com>
---
 arch/arm/configs/multi_v7_defconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/configs/multi_v7_defconfig b/arch/arm/configs/multi_v7_defconfig
index 24962d0e71c7..0ffa957f2c94 100644
--- a/arch/arm/configs/multi_v7_defconfig
+++ b/arch/arm/configs/multi_v7_defconfig
@@ -1121,3 +1121,4 @@ CONFIG_CRYPTO_DEV_ROCKCHIP=m
 CONFIG_CMA_SIZE_MBYTES=64
 CONFIG_PRINTK_TIME=y
 CONFIG_MAGIC_SYSRQ=y
+CONFIG_DEBUG_FS=y
-- 
2.17.1


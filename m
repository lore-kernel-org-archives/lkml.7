Return-Path: <SRS0=xBSd=Z4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4CF83C3F68F
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Dec 2019 12:48:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 247AD205F4
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Dec 2019 12:48:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="XEKnfpA2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726321AbfLFMs3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 6 Dec 2019 07:48:29 -0500
Received: from mailout1.w1.samsung.com ([210.118.77.11]:58434 "EHLO
        mailout1.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726140AbfLFMs2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Dec 2019 07:48:28 -0500
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
        by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20191206124827euoutp014c1e9b53f4411cbf58801bb3795c81cc~dyQ4ZO7gq1766517665euoutp01N
        for <linux-kernel@vger.kernel.org>; Fri,  6 Dec 2019 12:48:27 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20191206124827euoutp014c1e9b53f4411cbf58801bb3795c81cc~dyQ4ZO7gq1766517665euoutp01N
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1575636507;
        bh=0mPnHOxifTMNnDk+T8fh9C2CByasDOb3u9TlEkhdvR4=;
        h=From:To:Cc:Subject:Date:References:From;
        b=XEKnfpA2fXDm6f5sVUNBzF7SDyQ1nqBIgq4EY0vg8um2pjYjvIHpvcujsVYUUS+MY
         YT2nVXy5GJkcgdTGuFIUKb7YD4WpX+PgQhz9arZ7Maplnf7kA0L63vK+8NLaNNeNNF
         NjXAN/+5hSBn+z7ELVvB48UA9CXcFWpW0JyQqQWs=
Received: from eusmges2new.samsung.com (unknown [203.254.199.244]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTP id
        20191206124826eucas1p1e6e997b1a7927169c80d7d73249bd548~dyQ4LYOdH0877408774eucas1p1h;
        Fri,  6 Dec 2019 12:48:26 +0000 (GMT)
Received: from eucas1p2.samsung.com ( [182.198.249.207]) by
        eusmges2new.samsung.com (EUCPMTA) with SMTP id 49.77.60679.A1E4AED5; Fri,  6
        Dec 2019 12:48:26 +0000 (GMT)
Received: from eusmtrp2.samsung.com (unknown [182.198.249.139]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
        20191206124826eucas1p246538607df51f2d68bce3b09d974b292~dyQ34_iYE2365523655eucas1p2u;
        Fri,  6 Dec 2019 12:48:26 +0000 (GMT)
Received: from eusmgms1.samsung.com (unknown [182.198.249.179]) by
        eusmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20191206124826eusmtrp2e9ec69db6caf0d03d430b187952856dd~dyQ34Z2LY3235632356eusmtrp25;
        Fri,  6 Dec 2019 12:48:26 +0000 (GMT)
X-AuditID: cbfec7f4-0e5ff7000001ed07-4b-5dea4e1aa5a0
Received: from eusmtip2.samsung.com ( [203.254.199.222]) by
        eusmgms1.samsung.com (EUCPMTA) with SMTP id 91.86.08375.A1E4AED5; Fri,  6
        Dec 2019 12:48:26 +0000 (GMT)
Received: from AMDC2765.digital.local (unknown [106.120.51.73]) by
        eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20191206124825eusmtip216330cd05f244d74a0f3faecf941c28a~dyQ3Xd6RI0676806768eusmtip2B;
        Fri,  6 Dec 2019 12:48:25 +0000 (GMT)
From:   Marek Szyprowski <m.szyprowski@samsung.com>
To:     linux-samsung-soc@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     Marek Szyprowski <m.szyprowski@samsung.com>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Kusanagi Kouichi <slash@ac.auone-net.jp>,
        Steven Rostedt <rostedt@goodmis.org>
Subject: [PATCH v2] arm: exynos_config: Restore debugfs support
Date:   Fri,  6 Dec 2019 13:47:21 +0100
Message-Id: <20191206124721.9025-1-m.szyprowski@samsung.com>
X-Mailer: git-send-email 2.17.1
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrOIsWRmVeSWpSXmKPExsWy7djP87pSfq9iDbY90LXYOGM9q8X58xvY
        LTY9vsZqcXnXHDaLGef3MVmsPXKX3WJfxwMmi+evzjI7cHisWLSX3aNl3y12j02rOtk8Ni+p
        9+jbsorR4/MmuQC2KC6blNSczLLUIn27BK6M8+t/sBTs5qz4ePwlUwPjNI4uRk4OCQETicPX
        rjJ1MXJxCAmsYJRo33SVHcL5wihxZdsbFgjnM6PEjWtH2WFarh/aB9WynFFidtc/FpAEWMuz
        yYkgNpuAoUTX2y42EFtEIFui8/EDRpAGZoFHjBJ/dl5nAkkIC9hL7LuwixHEZhFQlVjRvRQs
        zitgI7Fy5U+obfISqzccYIawn7NJTH4nCmG7SGye+YMJwhaWeHV8C1S9jMT/nfPBrpMQaGaU
        eHhuLTuE08MocblpBiNElbXE4eMXWbsYOYBO0pRYv0sfxJQQcJRYskQZwuSTuPFWEKSYGcic
        tG06M0SYV6KjTQhihprErOPr4LYevHAJ6koPiafrTzBDgiRWomfbfLYJjHKzEFYtYGRcxSie
        Wlqcm55abJSXWq5XnJhbXJqXrpecn7uJEZgcTv87/mUH464/SYcYBTgYlXh4Z3x+ESvEmlhW
        XJl7iFGCg1lJhDed72WsEG9KYmVValF+fFFpTmrxIUZpDhYlcV7jRUApgfTEktTs1NSC1CKY
        LBMHp1QDI0PLcrP1E0veiShZ52gunGXyS/pZQYn3GoYrX/aaBUhd+hFh0v04Vrtsm4cOc8Wy
        bvFpfruma8yUM0jb9FxjmfIfXtYT3HlLWoTniCvdmykWfuWU3Fy3fosV4SvCm76tnjBhg4ST
        bfezrNnb4r6dXr1mWRujFcvR3lVM1wSrXhss2ilXuD6PX4mlOCPRUIu5qDgRADJOk0kKAwAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrLLMWRmVeSWpSXmKPExsVy+t/xe7pSfq9iDdbtFbfYOGM9q8X58xvY
        LTY9vsZqcXnXHDaLGef3MVmsPXKX3WJfxwMmi+evzjI7cHisWLSX3aNl3y12j02rOtk8Ni+p
        9+jbsorR4/MmuQC2KD2bovzSklSFjPziElulaEMLIz1DSws9IxNLPUNj81grI1MlfTublNSc
        zLLUIn27BL2M8+t/sBTs5qz4ePwlUwPjNI4uRk4OCQETieuH9jGB2EICSxklpq7RhojLSJyc
        1sAKYQtL/LnWxdbFyAVU84lR4t7Ey2wgCTYBQ4mutyAJDg4RgVyJN8vEQWqYBZ4wSpxad54R
        pEZYwF5i34VdYDaLgKrEiu6lYMt4BWwkVq78yQ6xQF5i9YYDzBMYeRYwMqxiFEktLc5Nzy02
        1CtOzC0uzUvXS87P3cQIDMptx35u3sF4aWPwIUYBDkYlHt4Zn1/ECrEmlhVX5h5ilOBgVhLh
        Ted7GSvEm5JYWZValB9fVJqTWnyI0RRo+URmKdHkfGDE5JXEG5oamltYGpobmxubWSiJ83YI
        HIwREkhPLEnNTk0tSC2C6WPi4JRqYLRdvzU4NH/fweRlmtv3GFX0THs0Z3Jg+BqO74vP/5Cz
        zHZcvbDmGPvWPyphZRtvGEg3vN+i9Vlw26TXmUl7a+ZOy+L+r2a1T8t75RZZrl9yz6K2mR5W
        TbioEvQxdmvR3a2G4lwdlt+eFcV/FyiWuBO8asfTKEVBu+ajHC/1Tr3pYXf32XTa6K8SS3FG
        oqEWc1FxIgCjTb9tYAIAAA==
X-CMS-MailID: 20191206124826eucas1p246538607df51f2d68bce3b09d974b292
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20191206124826eucas1p246538607df51f2d68bce3b09d974b292
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20191206124826eucas1p246538607df51f2d68bce3b09d974b292
References: <CGME20191206124826eucas1p246538607df51f2d68bce3b09d974b292@eucas1p2.samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit 9f532d26c75c ("ARM: exynos_defconfig: Trim and reorganize with
savedefconfig") removed explicit enable line for CONFIG_DEBUG_FS, because
that feature has been selected by other enabled options: CONFIG_TRACING,
which in turn had been selected by CONFIG_PERF_EVENTS and
CONFIG_PROVE_LOCKING.

In meantime, commit 0e4a459f56c3 ("tracing: Remove unnecessary DEBUG_FS
dependency") removed the dependency between CONFIG_DEBUG_FS and
CONFIG_TRACING, so CONFIG_DEBUG_FS is no longer enabled in default builds.

Enable it again explicitly, as debugfs support is essential for various
automated testing tools.

Signed-off-by: Marek Szyprowski <m.szyprowski@samsung.com>
---
 arch/arm/configs/exynos_defconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/configs/exynos_defconfig b/arch/arm/configs/exynos_defconfig
index dd3e0684f746..3758311bcc27 100644
--- a/arch/arm/configs/exynos_defconfig
+++ b/arch/arm/configs/exynos_defconfig
@@ -350,6 +350,7 @@ CONFIG_PRINTK_TIME=y
 CONFIG_DYNAMIC_DEBUG=y
 CONFIG_DEBUG_INFO=y
 CONFIG_MAGIC_SYSRQ=y
+CONFIG_DEBUG_FS=y
 CONFIG_DEBUG_KERNEL=y
 CONFIG_SOFTLOCKUP_DETECTOR=y
 # CONFIG_DETECT_HUNG_TASK is not set
-- 
2.17.1


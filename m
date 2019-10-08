Return-Path: <SRS0=XKeO=YB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 867B7C4360C
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Oct 2019 10:17:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5FA44206BB
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Oct 2019 10:17:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="nm7OjTKL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730106AbfJHKRY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 8 Oct 2019 06:17:24 -0400
Received: from mailout1.w1.samsung.com ([210.118.77.11]:50719 "EHLO
        mailout1.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729790AbfJHKRY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Oct 2019 06:17:24 -0400
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
        by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20191008101721euoutp018e9aa1af31f071803d1a05054f8b2214~LpJHdmC_t2380023800euoutp01w
        for <linux-kernel@vger.kernel.org>; Tue,  8 Oct 2019 10:17:21 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20191008101721euoutp018e9aa1af31f071803d1a05054f8b2214~LpJHdmC_t2380023800euoutp01w
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1570529841;
        bh=1+wZF/yU9WuHHeCcFGJivWrHNea0iGZi/g3TN9MHMQQ=;
        h=From:To:Cc:Subject:Date:References:From;
        b=nm7OjTKL2jIZ17MS8Abj8htkibYpqdqRN0ySelF9tMGmbhnKj7uv8jA1q4H2s4qqf
         +OvKfqpuJpUkjxUkgyrE3BP9Fmb5kdoBWDhDrfHRuJY5TZ3aPEiovXfd+ZW0T5MpmB
         h7L0pB3Du9khHUApYRoy9dH4pmB94kohYarbSO8k=
Received: from eusmges1new.samsung.com (unknown [203.254.199.242]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTP id
        20191008101721eucas1p1959717783bc3f42f1083c985297e554d~LpJHCsV5Q1445114451eucas1p1D;
        Tue,  8 Oct 2019 10:17:21 +0000 (GMT)
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
        eusmges1new.samsung.com (EUCPMTA) with SMTP id F6.47.04469.0326C9D5; Tue,  8
        Oct 2019 11:17:20 +0100 (BST)
Received: from eusmtrp1.samsung.com (unknown [182.198.249.138]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
        20191008101720eucas1p2e0d1bca6e696848bf689067e05620679~LpJGmXLmf1974719747eucas1p2b;
        Tue,  8 Oct 2019 10:17:20 +0000 (GMT)
Received: from eusmgms1.samsung.com (unknown [182.198.249.179]) by
        eusmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20191008101720eusmtrp1356238c80a62f8bf1e2d8fd7539fd755~LpJGltx-A2547325473eusmtrp1E;
        Tue,  8 Oct 2019 10:17:20 +0000 (GMT)
X-AuditID: cbfec7f2-569ff70000001175-2b-5d9c6230050c
Received: from eusmtip2.samsung.com ( [203.254.199.222]) by
        eusmgms1.samsung.com (EUCPMTA) with SMTP id 11.AE.04166.0326C9D5; Tue,  8
        Oct 2019 11:17:20 +0100 (BST)
Received: from AMDC2765.digital.local (unknown [106.120.51.73]) by
        eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20191008101719eusmtip26fec61e9f7b9e5ce9dfb2afff62043ab~LpJGFA3Rj0176301763eusmtip2L;
        Tue,  8 Oct 2019 10:17:19 +0000 (GMT)
From:   Marek Szyprowski <m.szyprowski@samsung.com>
To:     linux-kernel@vger.kernel.org, Mark Brown <broonie@kernel.org>,
        Dmitry Osipenko <digetx@gmail.com>
Cc:     Marek Szyprowski <m.szyprowski@samsung.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Lucas Stach <l.stach@pengutronix.de>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        linux-samsung-soc@vger.kernel.org
Subject: [PATCH] regulator: core: Skip balancing of the enabled regulators
 in regulator_enable()
Date:   Tue,  8 Oct 2019 12:17:09 +0200
Message-Id: <20191008101709.13827-1-m.szyprowski@samsung.com>
X-Mailer: git-send-email 2.17.1
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrBIsWRmVeSWpSXmKPExsWy7djPc7oGSXNiDZa+s7LYOGM9q8XUh0/Y
        LFZ/fMxocf78BnaLB3NvMll8u9LBZHF51xw2ixnn9zFZrD1yl92B02PnrLvsHptWdbJ59P81
        8OjbsorR4/MmuQDWKC6blNSczLLUIn27BK6Mlg+3WQpOC1bM/fSQsYHxCV8XIyeHhICJxM0P
        z9m6GLk4hARWMEq8+HyPGSQhJPCFUWLBDXaIxGdGib/v1zHCdCy785cFIrGcUaL59QEmCAeo
        41L/OlaQKjYBQ4mut11sILaIQLrE2vdbwYqYBRqYJF5f/gy2Q1ggSWLOqtVgY1kEVCVuLTgO
        1swrYCsxo/EN1Dp5idUbDjCDNEsIPGeT+LV3JwtEwkVide8hVghbWOLV8S3sELaMxOnJPSwQ
        Dc2MEg/PrWWHcHoYJS43zYAaay1x+PhFoG4OoJs0Jdbv0gcxJQQcJVrWpECYfBI33gqCFDMD
        mZO2TWeGCPNKdLQJQcxQk5h1fB3c1oMXLjFD2B4SX37sY4UEY6zEhX0vmCYwys1CWLWAkXEV
        o3hqaXFuemqxYV5quV5xYm5xaV66XnJ+7iZGYHo4/e/4px2MXy8lHWIU4GBU4uEt0J0dK8Sa
        WFZcmXuIUYKDWUmEV27pjFgh3pTEyqrUovz4otKc1OJDjNIcLErivNUMD6KFBNITS1KzU1ML
        UotgskwcnFINjFl5C7+fFrMrLDmTapWx90vCrsm84nsLF1VnMFQ9WPP5qc/p1/vueTxV+PK3
        6lGlgobsl0ma+ywz/L+krrj58ahy049vLM6Lz0//aN5kYr2l5dAfqedlAXXC3Ee0GE63r9ih
        /oZJquC+4juf7YdvhVX1aZhbXdt9LMx29yfZI91iNSeqprxPXKnEUpyRaKjFXFScCACIRwL/
        CwMAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrHLMWRmVeSWpSXmKPExsVy+t/xe7oGSXNiDQ7fkbbYOGM9q8XUh0/Y
        LFZ/fMxocf78BnaLB3NvMll8u9LBZHF51xw2ixnn9zFZrD1yl92B02PnrLvsHptWdbJ59P81
        8OjbsorR4/MmuQDWKD2bovzSklSFjPziElulaEMLIz1DSws9IxNLPUNj81grI1MlfTublNSc
        zLLUIn27BL2Mlg+3WQpOC1bM/fSQsYHxCV8XIyeHhICJxLI7f1lAbCGBpYwSOy8nQsRlJE5O
        a2CFsIUl/lzrYuti5AKq+cQocfXJbiaQBJuAoUTXW5AEJ4eIQKbE+j1NLCBFzAItTBKz/l8A
        SwgLJEjsvzmbEcRmEVCVuLXgONhUXgFbiRmNbxghNshLrN5wgHkCI88CRoZVjCKppcW56bnF
        hnrFibnFpXnpesn5uZsYgWG57djPzTsYL20MPsQowMGoxMNboDs7Vog1say4MvcQowQHs5II
        r9zSGbFCvCmJlVWpRfnxRaU5qcWHGE2Blk9klhJNzgfGTF5JvKGpobmFpaG5sbmxmYWSOG+H
        wMEYIYH0xJLU7NTUgtQimD4mDk6pBsbmrKycucw57czHbBW1t9ucutNr+eHFzqJbLtK1v15/
        nL/1ZMrRtaY/W744S3kv3CZ36gHzjKjs/eVi2/o1Xor4/xe2zVlae3Xi4YwqMTH5G8Fa0+8W
        9ryotTxV/vWH1KPeiz9/NvpeO77a1GB97eGnl05rehlPyFQvkni37oKICdudB6f2T5RXYinO
        SDTUYi4qTgQA/D4bhmECAAA=
X-CMS-MailID: 20191008101720eucas1p2e0d1bca6e696848bf689067e05620679
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20191008101720eucas1p2e0d1bca6e696848bf689067e05620679
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20191008101720eucas1p2e0d1bca6e696848bf689067e05620679
References: <CGME20191008101720eucas1p2e0d1bca6e696848bf689067e05620679@eucas1p2.samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit f8702f9e4aa7 ("regulator: core: Use ww_mutex for regulators
locking"), regardless of the subject, added additional call to
regulator_balance_voltage() during regulator_enable(). This is basically
a good idea, however it causes some issue for the regulators which are
already enabled at boot and are critical for system operation (for example
provides supply to the CPU).

CPUfreq or other drivers typically call regulator_enable() on such
regulators during their probe, although the regulators are already enabled
by bootloader. The mentioned patch however added a call to
regulator_balance_voltage(), what in case of system boot, where no
additional requirements are set yet, typically causes to limit the voltage
to the minimal value defined at regulator constraints. This causes a crash
of the system when voltage on the CPU regulator is set to the lowest
possible value without adjusting the operation frequency. Fix this by
adding a check if regulator is already enabled - if so, then skip the
balancing procedure. The voltage will be balanced later anyway once the
required voltage value is requested.

Fixes: f8702f9e4aa7 ("regulator: core: Use ww_mutex for regulators locking")
Reported-by: "kernelci.org bot" <bot@kernelci.org>
Signed-off-by: Marek Szyprowski <m.szyprowski@samsung.com>
---
This patch fixes enabling coupled requlators on Exynos5800-based Peach-Pi
board done by the following patch:
https://patchwork.kernel.org/patch/11172427/
Once it has been applied, the following issue has been reported:
https://patchwork.kernel.org/patch/11176661/
---
 drivers/regulator/core.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/regulator/core.c b/drivers/regulator/core.c
index afe94470b67f..aca74b83f3bc 100644
--- a/drivers/regulator/core.c
+++ b/drivers/regulator/core.c
@@ -2481,7 +2481,8 @@ static int _regulator_enable(struct regulator *regulator)
 	}
 
 	/* balance only if there are regulators coupled */
-	if (rdev->coupling_desc.n_coupled > 1) {
+	if (rdev->coupling_desc.n_coupled > 1 &&
+	    !_regulator_is_enabled(rdev)) {
 		ret = regulator_balance_voltage(rdev, PM_SUSPEND_ON);
 		if (ret < 0)
 			goto err_disable_supply;
-- 
2.17.1


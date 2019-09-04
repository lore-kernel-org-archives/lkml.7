Return-Path: <SRS0=tMFY=W7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E2FBEC3A5A7
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Sep 2019 08:50:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B87D022DBF
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Sep 2019 08:50:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="mJcssIyA"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729379AbfIDIuG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 4 Sep 2019 04:50:06 -0400
Received: from mailout1.w1.samsung.com ([210.118.77.11]:34196 "EHLO
        mailout1.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728448AbfIDIuF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Sep 2019 04:50:05 -0400
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
        by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20190904085003euoutp01759d4acbb12c2110745359d78fec3e5b~BMBMHTdSj2536725367euoutp01R
        for <linux-kernel@vger.kernel.org>; Wed,  4 Sep 2019 08:50:03 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20190904085003euoutp01759d4acbb12c2110745359d78fec3e5b~BMBMHTdSj2536725367euoutp01R
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1567587003;
        bh=oFELJroshQNF4iZzaTQ4WEiPwJyriiHbT/qS8Y1Zw5w=;
        h=From:To:Cc:Subject:Date:References:From;
        b=mJcssIyA8MtTg4R3iLUkqXq4NIiPnAfcwXh6TUqOLMMSEJqlgfdJ+G0oWq2mF2acL
         IlerBrhjONoiI8k4MIurzJQppOp9k9ouJTSou/F1ch8SMVBvFIldsxpjgCUXU7usZm
         GcDRrCkibl+YyGfkkWRqGKiagFnIDmpvDKi3YCtY=
Received: from eusmges2new.samsung.com (unknown [203.254.199.244]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTP id
        20190904085002eucas1p13375705fd581ff15b671a52fcace2093~BMBLjH07g1184411844eucas1p1P;
        Wed,  4 Sep 2019 08:50:02 +0000 (GMT)
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
        eusmges2new.samsung.com (EUCPMTA) with SMTP id E9.B5.04309.ABA7F6D5; Wed,  4
        Sep 2019 09:50:02 +0100 (BST)
Received: from eusmtrp2.samsung.com (unknown [182.198.249.139]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
        20190904085001eucas1p2b3a120d6206983d47f0084b872042342~BMBKk7EMP2069820698eucas1p2A;
        Wed,  4 Sep 2019 08:50:01 +0000 (GMT)
Received: from eusmgms1.samsung.com (unknown [182.198.249.179]) by
        eusmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20190904085001eusmtrp2dbf6fde957038a388fbc2f28d014a760~BMBKkUx1F0734707347eusmtrp2z;
        Wed,  4 Sep 2019 08:50:01 +0000 (GMT)
X-AuditID: cbfec7f4-ae1ff700000010d5-d0-5d6f7aba6c14
Received: from eusmtip2.samsung.com ( [203.254.199.222]) by
        eusmgms1.samsung.com (EUCPMTA) with SMTP id D3.B1.04166.9BA7F6D5; Wed,  4
        Sep 2019 09:50:01 +0100 (BST)
Received: from AMDC3061.DIGITAL.local (unknown [106.120.51.75]) by
        eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20190904085001eusmtip2984d536707372df5001e4fc75d7719aa~BMBKHgLYI1995319953eusmtip2Y;
        Wed,  4 Sep 2019 08:50:01 +0000 (GMT)
From:   Sylwester Nawrocki <s.nawrocki@samsung.com>
To:     krzk@kernel.org
Cc:     kgene@kernel.org, linux-samsung-soc@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        b.zolnierkie@samsung.com, m.szyprowski@samsung.com,
        Sylwester Nawrocki <s.nawrocki@samsung.com>
Subject: [PATCH] soc: samsung: chipid: Make exynos_chipid_early_init()
 static
Date:   Wed,  4 Sep 2019 10:49:51 +0200
Message-Id: <20190904084951.28971-1-s.nawrocki@samsung.com>
X-Mailer: git-send-email 2.17.1
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrAIsWRmVeSWpSXmKPExsWy7djPc7q7qvJjDT7s07LYOGM9q0X/49fM
        FufPb2C32PT4GqvF5V1z2CxmnN/HZLH2yF12i8Nv2lkdODw2repk89i8pN6jb8sqRo/Pm+QC
        WKK4bFJSczLLUov07RK4Mjrut7EWvGKt+L77NGMDYwNrFyMnh4SAiUTX6mNANheHkMAKRonX
        sy8xQThfGCXe/FrAAuF8ZpToPTOLGaZlx9UVUC3LGSXWTtvLDNdy7PcjdpAqNgFDid6jfYwg
        toiAsMS9pcvZQYqYBR4xSjS1bGcBSQgL+Ev8mrwIzGYRUJU4vOMiE4jNK2AtcfnOcUaIdfIS
        qzccANsgIXCdTeLszaNQp7tInGw8zwZhC0u8Or6FHcKWkfi/cz4TREMzo0TP7tvsEM4ERon7
        xxdAjbWWOHz8ItAkDqCbNCXW79KHCDtKHPx6mAUkLCHAJ3HjrSBImBnInLRtOjNEmFeio00I
        olpF4veq6UwQtpRE95P/LBC2h8S7bVvAzhQSiJX4N62FdQKj3CyEXQsYGVcxiqeWFuempxYb
        5aWW6xUn5haX5qXrJefnbmIEpoPT/45/2cG460/SIUYBDkYlHt4dfnmxQqyJZcWVuYcYJTiY
        lUR4Q/fkxArxpiRWVqUW5ccXleakFh9ilOZgURLnrWZ4EC0kkJ5YkpqdmlqQWgSTZeLglGpg
        XHj1mprZ9t35/3en1K4T7rKN3XGGX22bT3JZy/ctnw1v2AcacJY8v/K+MULnucJCPtMF7xsn
        vDJZc+tMx5NFVTazb3AqC39zV/CJC355z+nZjXVO34P5r2uwVnp9XrZxS+SJiJvqUUynzQVi
        s+e8/vzmZt7TWUbO9QdLtDTM10pKJtyTelCwTImlOCPRUIu5qDgRAMZjjp8DAwAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrMLMWRmVeSWpSXmKPExsVy+t/xe7o7q/JjDfpfmFpsnLGe1aL/8Wtm
        i/PnN7BbbHp8jdXi8q45bBYzzu9jslh75C67xeE37awOHB6bVnWyeWxeUu/Rt2UVo8fnTXIB
        LFF6NkX5pSWpChn5xSW2StGGFkZ6hpYWekYmlnqGxuaxVkamSvp2NimpOZllqUX6dgl6GR33
        21gLXrFWfN99mrGBsYG1i5GTQ0LARGLH1RVANheHkMBSRokvD9exdTFyACWkJOa3KEHUCEv8
        udbFBmILCXxilHh9LQHEZhMwlOg92scIYosA1dxbupwdZA6zwAtGiY7Di5hAEsICvhKP3y8E
        a2YRUJU4vOMiWJxXwFri8p3jjBAL5CVWbzjAPIGRZwEjwypGkdTS4tz03GJDveLE3OLSvHS9
        5PzcTYzAANx27OfmHYyXNgYfYhTgYFTi4d3hlxcrxJpYVlyZe4hRgoNZSYQ3dE9OrBBvSmJl
        VWpRfnxRaU5q8SFGU6DlE5mlRJPzgdGRVxJvaGpobmFpaG5sbmxmoSTO2yFwMEZIID2xJDU7
        NbUgtQimj4mDU6qBsf/epj6V1XqSzFzHV3HcqZK1MNyW6+/V4LizMW/hzKyVs9ma72hyO3VH
        Ki3hFN7eq/GP58GmlKDJlcar6xNDJ3n0LTO7sk1s2o4HHPH61n6bcnjb3k/kO+q4aAufiGtq
        oqmqcvnDHfYXpyeprf1xO4/Zh+0h6+Zsxqkv1pwyPvW2KHVRQamXEktxRqKhFnNRcSIA7u3g
        VlYCAAA=
X-CMS-MailID: 20190904085001eucas1p2b3a120d6206983d47f0084b872042342
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20190904085001eucas1p2b3a120d6206983d47f0084b872042342
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20190904085001eucas1p2b3a120d6206983d47f0084b872042342
References: <CGME20190904085001eucas1p2b3a120d6206983d47f0084b872042342@eucas1p2.samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add missing static qualifier to the chipid initcall function.

Signed-off-by: Sylwester Nawrocki <s.nawrocki@samsung.com>
---
 drivers/soc/samsung/exynos-chipid.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/soc/samsung/exynos-chipid.c b/drivers/soc/samsung/exynos-chipid.c
index c55a47cfe617..25562dd0b206 100644
--- a/drivers/soc/samsung/exynos-chipid.c
+++ b/drivers/soc/samsung/exynos-chipid.c
@@ -45,7 +45,7 @@ static const char * __init product_id_to_soc_id(unsigned int product_id)
 	return NULL;
 }
 
-int __init exynos_chipid_early_init(void)
+static int __init exynos_chipid_early_init(void)
 {
 	struct soc_device_attribute *soc_dev_attr;
 	struct soc_device *soc_dev;
-- 
2.17.1


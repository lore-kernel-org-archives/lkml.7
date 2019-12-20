Return-Path: <SRS0=w7sF=2K=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B3D75C2D0C1
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Dec 2019 00:18:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8868224676
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Dec 2019 00:18:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="hEJQxBmh"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727291AbfLTASJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 19 Dec 2019 19:18:09 -0500
Received: from mailout2.samsung.com ([203.254.224.25]:63824 "EHLO
        mailout2.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727125AbfLTASH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Dec 2019 19:18:07 -0500
Received: from epcas1p3.samsung.com (unknown [182.195.41.47])
        by mailout2.samsung.com (KnoxPortal) with ESMTP id 20191220001804epoutp02f39a3f9850889af38e4e46cebd46d44e~h7DtcCVDB0765807658epoutp02O
        for <linux-kernel@vger.kernel.org>; Fri, 20 Dec 2019 00:18:04 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.samsung.com 20191220001804epoutp02f39a3f9850889af38e4e46cebd46d44e~h7DtcCVDB0765807658epoutp02O
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1576801084;
        bh=/s3dxL0leRBi85ExHunIXP3vYxsxh3UAXcd6sT3XK1M=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=hEJQxBmhkBxWkDyQmTusbBhBGf86AGt454siwSO9ydeyO9N3Xif/3detY6uQ8KRaF
         TeMq240PRzRtUykmkAI3o6dIw/vc0oNLLwtU7dPdFcM5PcPDcAVKQfIhkumWpnzm7Q
         Ik8wXaaIfg1Sksv9O6/I3MHCGAysmpYSrBpEgvbc=
Received: from epsnrtp1.localdomain (unknown [182.195.42.162]) by
        epcas1p3.samsung.com (KnoxPortal) with ESMTP id
        20191220001803epcas1p32ebd9275f7e31e17632c68e25a75f0f7~h7DstLUIE1379413794epcas1p3T;
        Fri, 20 Dec 2019 00:18:03 +0000 (GMT)
Received: from epsmges1p1.samsung.com (unknown [182.195.40.153]) by
        epsnrtp1.localdomain (Postfix) with ESMTP id 47f8Th5SWQzMqYm6; Fri, 20 Dec
        2019 00:18:00 +0000 (GMT)
Received: from epcas1p4.samsung.com ( [182.195.41.48]) by
        epsmges1p1.samsung.com (Symantec Messaging Gateway) with SMTP id
        E5.E5.57028.8331CFD5; Fri, 20 Dec 2019 09:18:00 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
        epcas1p3.samsung.com (KnoxPortal) with ESMTPA id
        20191220001800epcas1p383927f73060e0e9aaad2fd9aaf881b6d~h7Dp1U7hT1359613596epcas1p3Z;
        Fri, 20 Dec 2019 00:18:00 +0000 (GMT)
Received: from epsmgms1p1new.samsung.com (unknown [182.195.42.41]) by
        epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20191220001800epsmtrp119f7e7e296e4bd068e5def73fea14971~h7Dp0aekq1705617056epsmtrp1W;
        Fri, 20 Dec 2019 00:18:00 +0000 (GMT)
X-AuditID: b6c32a35-50bff7000001dec4-17-5dfc13382638
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
        epsmgms1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        02.CA.10238.8331CFD5; Fri, 20 Dec 2019 09:18:00 +0900 (KST)
Received: from localhost.localdomain (unknown [10.113.221.102]) by
        epsmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20191220001800epsmtip15529ed17bdc843f3aeac8dfa45c0bece~h7Dpi_L0H2050220502epsmtip1z;
        Fri, 20 Dec 2019 00:18:00 +0000 (GMT)
From:   Chanwoo Choi <cw00.choi@samsung.com>
To:     robh+dt@kernel.org, krzk@kernel.org, heiko@sntech.de,
        leonard.crestez@nxp.com, lukasz.luba@arm.com
Cc:     mark.rutland@arm.com, a.swigon@samsung.com,
        m.szyprowski@samsung.com, kgene@kernel.org, cw00.choi@samsung.com,
        myungjoo.ham@samsung.com, kyungmin.park@samsung.com,
        linux-pm@vger.kernel.org, linux-samsung-soc@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-rockchip@lists.infradead.org
Subject: [PATCH v2 08/11] PM / devfreq: rk3399_dmc: Replace the deprecated
 'devfreq-events' property
Date:   Fri, 20 Dec 2019 09:24:27 +0900
Message-Id: <20191220002430.11995-9-cw00.choi@samsung.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20191220002430.11995-1-cw00.choi@samsung.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrFJsWRmVeSWpSXmKPExsWy7bCmga6F8J9Yg02HNC3uz2tltLj+5Tmr
        xfwj51gt/j96zWrR//g1s8X58xvYLc42vWG3WHH3I6vFpsfXWC0u75rDZvG59wijxacH/5kt
        Zpzfx2SxsKmF3WLtkbvsFkuvX2SyuN24gs2ide8RdgchjzXz1jB6bFrVyeaxeUm9x8Z3O5g8
        +rasYvTYfm0es8fnTXIB7FHZNhmpiSmpRQqpecn5KZl56bZK3sHxzvGmZgaGuoaWFuZKCnmJ
        uam2Si4+AbpumTlAbygplCXmlAKFAhKLi5X07WyK8ktLUhUy8otLbJVSC1JyCiwL9IoTc4tL
        89L1kvNzrQwNDIxMgQoTsjM+LD3GXHCOo+LYjrusDYxz2LsYOTkkBEwk9vQ1MncxcnEICexg
        lGja9ZgVwvnEKNG+7TArSJWQwDdGiavthjAdC3/PZIMo2sso8eH/Iaj2L4wSPQ/mMIFUsQlo
        Sex/cYMNxBYRyJCY+foy2FhmgY9MEl3b7oIlhAXSJL7e3wtkc3CwCKhKTO83AgnzClhJ/Gyf
        xQqxTV5i9YYDzCA2p4C1xJZnD9lB5kgI/GeT+NK8mA2iyEWi69JXJghbWOLV8S1Qz0lJvOxv
        g7KrJVaePMIG0dzBKLFl/wWoDcYS+5dOZgI5gllAU2L9Ln2IsKLEzt9zGUFsZgE+iXdfe1hB
        SiQEeCU62oQgSpQlLj+4C7VWUmJxeyfUOR4Sfzf/YoIESh+jxLxVBxgnMMrNQtiwgJFxFaNY
        akFxbnpqsWGBIXKUbWIEp1Mt0x2MU875HGIU4GBU4uF1SPsdK8SaWFZcmXuIUYKDWUmE93bH
        z1gh3pTEyqrUovz4otKc1OJDjKbAkJzILCWanA9M9Xkl8YamRsbGxhYmhmamhoZK4rwcPy7G
        CgmkJ5akZqemFqQWwfQxcXBKNTDukMl1X1t46mIBd8aLQwpv7rXnZIW/XyeaphDoVxMpLTol
        ifHzY/sPl89t5C1LqndT0pkufGUr42qvk36dizndpip6SZ78ofBvYbjtD7Vml8fv+J72KIu+
        k7hstInp+EluMwbz2epdXcdP27VNOnKu43GVmUvX7sMOPdxXWna92je7eXZ7zVIlluKMREMt
        5qLiRABqtMr1vQMAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrMLMWRmVeSWpSXmKPExsWy7bCSnK6F8J9Yg5MXBSzuz2tltLj+5Tmr
        xfwj51gt/j96zWrR//g1s8X58xvYLc42vWG3WHH3I6vFpsfXWC0u75rDZvG59wijxacH/5kt
        Zpzfx2SxsKmF3WLtkbvsFkuvX2SyuN24gs2ide8RdgchjzXz1jB6bFrVyeaxeUm9x8Z3O5g8
        +rasYvTYfm0es8fnTXIB7FFcNimpOZllqUX6dglcGR+WHmMuOMdRcWzHXdYGxjnsXYycHBIC
        JhILf89k62Lk4hAS2M0ocfzrWWaIhKTEtItHgWwOIFtY4vDhYoiaT4wS799OYASpYRPQktj/
        4gYbiC0ikCexaeNXZpAiZoH/TBLfTz4AKxIWSJHofbGIDWQQi4CqxPR+I5Awr4CVxM/2WawQ
        u+QlVm84ALaXU8BaYsuzh2DHCQHVvDx/gXUCI98CRoZVjJKpBcW56bnFhgWGeanlesWJucWl
        eel6yfm5mxjBQa+luYPx8pL4Q4wCHIxKPLwOab9jhVgTy4orcw8xSnAwK4nw3u74GSvEm5JY
        WZValB9fVJqTWnyIUZqDRUmc92nesUghgfTEktTs1NSC1CKYLBMHp1QDY8k0WcMrgbc3vjPa
        Pnfzs9dO/3rEDWYUvn3mPDV3gwXvQeXXq/+xslUc2yzPZqa4R/0Po3hjj4jQvOAY6YmmTm8r
        N79/+ZmBw/fPyY3+Ddznti7ayr/YvtX52YXNu50KV84o6m9XbPrzm61PgeEaZ3qQ+HyXUvv9
        v3YYXNJYXp6U8zRBra+yUomlOCPRUIu5qDgRAJNV9QR2AgAA
X-CMS-MailID: 20191220001800epcas1p383927f73060e0e9aaad2fd9aaf881b6d
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: SVC_REQ_APPROVE
CMS-TYPE: 101P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20191220001800epcas1p383927f73060e0e9aaad2fd9aaf881b6d
References: <20191220002430.11995-1-cw00.choi@samsung.com>
        <CGME20191220001800epcas1p383927f73060e0e9aaad2fd9aaf881b6d@epcas1p3.samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Replace the deprecated 'devfreq-events' property with 'rockchip,dfi-device'
property. But, to guarantee the backward-compatibility, keep the support
of 'devfreq-events' property.

Signed-off-by: Chanwoo Choi <cw00.choi@samsung.com>
---
 drivers/devfreq/rk3399_dmc.c | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/drivers/devfreq/rk3399_dmc.c b/drivers/devfreq/rk3399_dmc.c
index e712c8662d2f..2294de13a3dc 100644
--- a/drivers/devfreq/rk3399_dmc.c
+++ b/drivers/devfreq/rk3399_dmc.c
@@ -306,11 +306,14 @@ static int of_get_ddr_timings(struct dram_timing *timing,
 static struct devfreq_event_dev *of_get_edev(struct device_node *np,
 							int index)
 {
-	struct device_node *node = of_parse_phandle(np, "devfreq-events",
+	struct device_node *node = of_parse_phandle(np, "rockchip,dfi-device",
 							index);
 
-	if (!node)
-		return ERR_PTR(-ENODEV);
+	if (!node) {
+		node = of_parse_phandle(np, "devfreq-events", index);
+		if (!node)
+			return ERR_PTR(-ENODEV);
+	}
 	return devfreq_event_get_edev_by_node(node);
 }
 
-- 
2.17.1


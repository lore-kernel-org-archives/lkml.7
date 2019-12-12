Return-Path: <SRS0=kgnc=2C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5C645C43603
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Dec 2019 06:35:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 06B372173E
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Dec 2019 06:35:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=iluvatar.ai header.i=@iluvatar.ai header.b="l2hLsXPw"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728020AbfLLGfu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 12 Dec 2019 01:35:50 -0500
Received: from owa.iluvatar.ai ([103.91.158.24]:16135 "EHLO smg.iluvatar.ai"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726833AbfLLGft (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Dec 2019 01:35:49 -0500
X-AuditID: 0a650161-773ff700000078a3-64-5df1f682f9dc
Received: from owa.iluvatar.ai (s-10-101-1-102.iluvatar.local [10.101.1.102])
        by smg.iluvatar.ai (Symantec Messaging Gateway) with SMTP id 0F.12.30883.286F1FD5; Thu, 12 Dec 2019 16:12:50 +0800 (HKT)
Content-Type: text/plain
DKIM-Signature: v=1; a=rsa-sha256; d=iluvatar.ai; s=key_2018;
        c=relaxed/relaxed; t=1576132552; h=from:subject:to:date:message-id;
        bh=bQNU1+ISLnmcAQKTWM0imtH9R94LiHmPGHx7kJrpDUc=;
        b=l2hLsXPwyyaLpWRR0sx/DRvAmcrLyq3hV7+OzdGvVfnsf0DJ42WHQQzzfvZ1f07xm02LunbEBGi
        TkyovI8yfuIuElCWWidRvrPoiNQYYNMUxRN+BfS/XJ09/qNkpdJ4AsDOFLYFDRDcxWexV3W82dLks
        NM60IWD9UxqT0uHlVio=
Received: from hsj-Precision-5520.iluvatar.local (10.101.199.253) by
 S-10-101-1-102.iluvatar.local (10.101.1.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.1415.2; Thu, 12 Dec 2019 14:35:49 +0800
From:   Huang Shijie <sjhuang@iluvatar.ai>
To:     <jbaron@akamai.com>
CC:     <linux-kernel@vger.kernel.org>, <1537577747@qq.com>,
        Huang Shijie <sjhuang@iluvatar.ai>
Subject: [PATCH v4] lib/dynamic_debug: make better dynamic log output
Date:   Thu, 12 Dec 2019 14:35:32 +0800
Message-ID: <20191212063532.22966-1-sjhuang@iluvatar.ai>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20191209094437.14866-1-sjhuang@iluvatar.ai>
References: <20191209094437.14866-1-sjhuang@iluvatar.ai>
MIME-Version: 1.0
X-Originating-IP: [10.101.199.253]
X-ClientProxiedBy: S-10-101-1-102.iluvatar.local (10.101.1.102) To
 S-10-101-1-102.iluvatar.local (10.101.1.102)
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrMLMWRmVeSWpSXmKPExsXClcqYptv07WOswfE3ehaTrx5gs5ix+Dir
        xeVdc9gcmD0mH1nA7HHr2VpWj8+b5AKYo7hsUlJzMstSi/TtErgybsy6xl7wjb/izr9bbA2M
        73i6GDk5JARMJF6+28rexcjFISRwglHi/8WL7CAJZgEJiYMvXjCDJFgE3jJJ7Dh/jQ0kISTQ
        xiSxcbsCiM0moCEx98RdoCIODhEBcYn3810hemMl5nbtYwaxhQVcJa6sfgDWyiKgKjHj5HlG
        EJtXwEJi+5c97BBHyEus3nAArJ5TwFLi0NU3TBCrLCQuzLvEDFEvKHFy5hMWkFVCAgoSL1Zq
        QbQqSSzZO4sJwi6U+P7yLssERqFZSD6YhaR7ASPTKkb+4tx0vcyc0rLEksQivcTMTYyQkE3c
        wXij86XeIUYBDkYlHl4J34+xQqyJZcWVuYcYJTiYlUR4j7e9ixXiTUmsrEotyo8vKs1JLT7E
        KM3BoiTOK/TvaYyQQHpiSWp2ampBahFMlomDU6qBibmJYfOfKCV+y1qflFOHit79l8s7Hc/5
        vSL99ql1/kvep++fzFC2hGMba/K5+rSU6pb8jIkZp6OtBPUmGn6Q25e344VKYn/Rr27bc6mf
        P29yZsswNb10oNdbyd1rf3Pf6tO/1vI6SYm/Ptcw18vkUKXC2T8FlR6fdiw9FH84coMgT6dP
        S9/WbXutuFvduj6ufl+V+mSfXZv7Sq2z71RFHOtmVZ4252dldi9N3DyLO6OJg11f7tzBPxM8
        lO4uCsxRWZvrv2Lznj0W/CWPZKe+mH5pzr+LkacNNt2aUqOjPMssiu9dZHRorAbHSnHleqmG
        CmMt1/OWqvocj7xDan6xd02QsdJb5HXlTeDRixZKLMUZiYZazEXFiQDTxKs+1gIAAA==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The driver strings, device name and net device name are not changed for
the driver's dynamic log output. But the dynamic_emit_prefix() which contains
the function names may change when the function names are changed.

So the patch makes the better dynamic log output.

Signed-off-by: Huang Shijie <sjhuang@iluvatar.ai>
---
v3 -- > v4:
	remove the duplicated colon.
---
 lib/dynamic_debug.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/lib/dynamic_debug.c b/lib/dynamic_debug.c
index c60409138e13..e375253c0c22 100644
--- a/lib/dynamic_debug.c
+++ b/lib/dynamic_debug.c
@@ -589,9 +589,9 @@ void __dynamic_dev_dbg(struct _ddebug *descriptor,
 	} else {
 		char buf[PREFIX_SIZE];
 
-		dev_printk_emit(LOGLEVEL_DEBUG, dev, "%s%s %s: %pV",
-				dynamic_emit_prefix(descriptor, buf),
+		dev_printk_emit(LOGLEVEL_DEBUG, dev, "%s %s %s %pV",
 				dev_driver_string(dev), dev_name(dev),
+				dynamic_emit_prefix(descriptor, buf),
 				&vaf);
 	}
 
@@ -619,11 +619,11 @@ void __dynamic_netdev_dbg(struct _ddebug *descriptor,
 		char buf[PREFIX_SIZE];
 
 		dev_printk_emit(LOGLEVEL_DEBUG, dev->dev.parent,
-				"%s%s %s %s%s: %pV",
-				dynamic_emit_prefix(descriptor, buf),
+				"%s %s %s %s %s %pV",
 				dev_driver_string(dev->dev.parent),
 				dev_name(dev->dev.parent),
 				netdev_name(dev), netdev_reg_state(dev),
+				dynamic_emit_prefix(descriptor, buf),
 				&vaf);
 	} else if (dev) {
 		printk(KERN_DEBUG "%s%s: %pV", netdev_name(dev),
@@ -655,11 +655,11 @@ void __dynamic_ibdev_dbg(struct _ddebug *descriptor,
 		char buf[PREFIX_SIZE];
 
 		dev_printk_emit(LOGLEVEL_DEBUG, ibdev->dev.parent,
-				"%s%s %s %s: %pV",
-				dynamic_emit_prefix(descriptor, buf),
+				"%s %s %s %s %pV",
 				dev_driver_string(ibdev->dev.parent),
 				dev_name(ibdev->dev.parent),
 				dev_name(&ibdev->dev),
+				dynamic_emit_prefix(descriptor, buf),
 				&vaf);
 	} else if (ibdev) {
 		printk(KERN_DEBUG "%s: %pV", dev_name(&ibdev->dev), &vaf);
-- 
2.17.1


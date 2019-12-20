Return-Path: <SRS0=w7sF=2K=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0766FC43603
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Dec 2019 06:02:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C5E0F227BF
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Dec 2019 06:02:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=iluvatar.ai header.i=@iluvatar.ai header.b="GfM4E8T+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727169AbfLTGCZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 20 Dec 2019 01:02:25 -0500
Received: from owa.iluvatar.ai ([103.91.158.24]:16166 "EHLO smg.iluvatar.ai"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726428AbfLTGCY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Dec 2019 01:02:24 -0500
X-AuditID: 0a650161-773ff700000078a3-4d-5dfc7c0c29cb
Received: from owa.iluvatar.ai (s-10-101-1-102.iluvatar.local [10.101.1.102])
        by smg.iluvatar.ai (Symantec Messaging Gateway) with SMTP id 36.54.30883.C0C7CFD5; Fri, 20 Dec 2019 15:45:16 +0800 (HKT)
Content-Type: text/plain
DKIM-Signature: v=1; a=rsa-sha256; d=iluvatar.ai; s=key_2018;
        c=relaxed/relaxed; t=1576821751; h=from:subject:to:date:message-id;
        bh=E/kfTGrBQBcT2Az00xcJYWmO08Ma30y+BctoVl7P69k=;
        b=GfM4E8T+EIfm1iOmCEX94HEBX6V5/IsS3S7XvbwDuFrTMfSXCsedIS8gDRO3pWYKFvt+SgOwyIA
        UOufA3to8ZuBUNlH1yrCQYsySM+kFiyds3bO3qHsx22OnT9OgF3LUG5prHbXf/LTX2l4b1Qf50lHI
        xpuhI47Oyp40qGWaWSw=
Received: from hsj-OptiPlex-5060.iluvatar.local (10.101.199.253) by
 S-10-101-1-102.iluvatar.local (10.101.1.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.1415.2; Fri, 20 Dec 2019 14:02:29 +0800
From:   Huang Shijie <sjhuang@iluvatar.ai>
To:     <jbaron@akamai.com>
CC:     <linux-kernel@vger.kernel.org>, <1537577747@qq.com>,
        Huang Shijie <sjhuang@iluvatar.ai>
Subject: [PATCH v6] lib/dynamic_debug: make better dynamic log output
Date:   Fri, 20 Dec 2019 14:02:05 +0800
Message-ID: <20191220060205.18543-1-sjhuang@iluvatar.ai>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20191209094437.14866-1-sjhuang@iluvatar.ai>
References: <20191209094437.14866-1-sjhuang@iluvatar.ai>
MIME-Version: 1.0
X-Originating-IP: [10.101.199.253]
X-ClientProxiedBy: S-10-101-1-102.iluvatar.local (10.101.1.102) To
 S-10-101-1-102.iluvatar.local (10.101.1.102)
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrCLMWRmVeSWpSXmKPExsXClcqYpstT8yfWYPtyU4vJVw+wWcxYfJzV
        4vKuOWwOzB6Tjyxg9rj1bC2rx+dNcgHMUVw2Kak5mWWpRfp2CVwZM27NYC94I1CxcNY8tgbG
        s7xdjJwcEgImEr0XtzN3MXJxCAmcYJToOjSHGSTBLCAhcfDFC7AEi8BbJokHE7vYIKpamSTW
        XHzEClLFJqAhMffEXaAqDg4RAXGJ9/NdIZpjJeZ27QMbJCzgKrHv/jJ2EJtFQFXi2OT3YK28
        AhYSE7aeZ4W4Ql5i9YYDYPWcApYSh66+YQKxhYBqLsy7xAxRLyhxcuYTFpBVQgIKEi9WakG0
        Kkks2TuLCcIulPj+8i7LBEahWUhemIWkewEj0ypG/uLcdL3MnNKyxJLEIr3EzE2MkKBN3MF4
        o/Ol3iFGAQ5GJR5ejobfsUKsiWXFlbmHGCU4mJVEeG93/IwV4k1JrKxKLcqPLyrNSS0+xCjN
        waIkziv072mMkEB6YklqdmpqQWoRTJaJg1OqganW50+b23LPYteanR4FhYuY49KaJk/+7nim
        6+oqRgu9ppDwEzssvv457rlJXyGJIVP8xj5vjwWO+hVXy7av+Ov2Liz+Rp/Wvg6F6mUCLyrE
        ertsfp8zrcvv2vBJ2LmGs+XyrgOWrrNOrZvFOu3xTktrQ2sLjmv/eC+JvK081SUvmrhjVfQ/
        K8kj77YvOn1Ctb5h97xinVdTFhw88dWY4dkh2VSBB2WlXyczbD48ufzG7PvnnrzeteFKUH7N
        2a7vT5ht+bMvd7BXLvy0ftN3vkB7uySnJ4dmxxVaRZ/sjlmYmH363MPegLiCysa9DYHvvQ2q
        /GdKGnyIrPAKln5hbH951c2Oc2nzH2TGp4fMW63EUpyRaKjFXFScCADqjHcO1wIAAA==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The driver strings, device name and net device name are not changed for
the driver's dynamic log output. But dynamic_emit_prefix() which contains
the function names may change when the function names are changed.

So the patch makes the better dynamic log output.

And after this patch, the output is the same as the non dynamic debug output
except it may have an optional prefix.

Signed-off-by: Huang Shijie <sjhuang@iluvatar.ai>
---
v5 --> v6:
	Add more comment from Jason Baron.
---
 lib/dynamic_debug.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/lib/dynamic_debug.c b/lib/dynamic_debug.c
index c60409138e13..bfc3b386d603 100644
--- a/lib/dynamic_debug.c
+++ b/lib/dynamic_debug.c
@@ -589,9 +589,9 @@ void __dynamic_dev_dbg(struct _ddebug *descriptor,
 	} else {
 		char buf[PREFIX_SIZE];
 
-		dev_printk_emit(LOGLEVEL_DEBUG, dev, "%s%s %s: %pV",
-				dynamic_emit_prefix(descriptor, buf),
+		dev_printk_emit(LOGLEVEL_DEBUG, dev, "%s %s %s%pV",
 				dev_driver_string(dev), dev_name(dev),
+				dynamic_emit_prefix(descriptor, buf),
 				&vaf);
 	}
 
@@ -619,11 +619,11 @@ void __dynamic_netdev_dbg(struct _ddebug *descriptor,
 		char buf[PREFIX_SIZE];
 
 		dev_printk_emit(LOGLEVEL_DEBUG, dev->dev.parent,
-				"%s%s %s %s%s: %pV",
-				dynamic_emit_prefix(descriptor, buf),
+				"%s %s %s %s %s%pV",
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
+				"%s %s %s %s%pV",
 				dev_driver_string(ibdev->dev.parent),
 				dev_name(ibdev->dev.parent),
 				dev_name(&ibdev->dev),
+				dynamic_emit_prefix(descriptor, buf),
 				&vaf);
 	} else if (ibdev) {
 		printk(KERN_DEBUG "%s: %pV", dev_name(&ibdev->dev), &vaf);
-- 
2.17.1


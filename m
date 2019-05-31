Return-Path: <SRS0=bMiL=T7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0652BC04AB6
	for <linux-kernel@archiver.kernel.org>; Fri, 31 May 2019 08:24:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9B9DC265B4
	for <linux-kernel@archiver.kernel.org>; Fri, 31 May 2019 08:24:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="NeSFVLFt"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726909AbfEaIYQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 31 May 2019 04:24:16 -0400
Received: from mailout3.samsung.com ([203.254.224.33]:47259 "EHLO
        mailout3.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725963AbfEaIYQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 May 2019 04:24:16 -0400
Received: from epcas5p1.samsung.com (unknown [182.195.41.39])
        by mailout3.samsung.com (KnoxPortal) with ESMTP id 20190531082413epoutp033532fad3b74d884369534436552f3414~jtvOJXPEu3231732317epoutp03h
        for <linux-kernel@vger.kernel.org>; Fri, 31 May 2019 08:24:13 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout3.samsung.com 20190531082413epoutp033532fad3b74d884369534436552f3414~jtvOJXPEu3231732317epoutp03h
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1559291053;
        bh=4tYbzE7Ki9DPqfpIW+vy46QOWGXK8VI9QeBr4xi3Kdc=;
        h=From:To:Cc:Subject:Date:References:From;
        b=NeSFVLFtWmrHuqVvzUedgY+lq35XKIiohnKXlpYm0jkD1BdDBXDqOMzyTh+lBGmVV
         fh8T10IiZ+bcPcllVQaBgDTNmBeYls2RQsV1P35PUqIg0DIaVgOomnyhqRhJqyO7BU
         7KIFOb188tBnhRsyB2q99U6q4oQlgf4/+xy8d+Hg=
Received: from epsmges5p1new.samsung.com (unknown [182.195.40.194]) by
        epcas5p4.samsung.com (KnoxPortal) with ESMTP id
        20190531082411epcas5p456a7664a7686cdfdd5019b999357bc1b~jtvMRq4lr1577915779epcas5p4H;
        Fri, 31 May 2019 08:24:11 +0000 (GMT)
Received: from epcas5p4.samsung.com ( [182.195.41.42]) by
        epsmges5p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        11.39.04071.BA4E0FC5; Fri, 31 May 2019 17:24:11 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
        epcas5p3.samsung.com (KnoxPortal) with ESMTPA id
        20190531082344epcas5p394e519d5940ca1642007f7e594e2917c~jtuzIatyX1734317343epcas5p3P;
        Fri, 31 May 2019 08:23:44 +0000 (GMT)
Received: from epsmgms1p2new.samsung.com (unknown [182.195.42.42]) by
        epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20190531082344epsmtrp12741d4f14b627a83abaa2fbd0d7c9516~jtuzFDA8Q1141211412epsmtrp13;
        Fri, 31 May 2019 08:23:44 +0000 (GMT)
X-AuditID: b6c32a49-5b7ff70000000fe7-c1-5cf0e4abd260
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
        epsmgms1p2new.samsung.com (Symantec Messaging Gateway) with SMTP id
        DF.A4.03662.F84E0FC5; Fri, 31 May 2019 17:23:43 +0900 (KST)
Received: from localhost.localdomain (unknown [107.109.224.135]) by
        epsmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20190531082342epsmtip185b96dd89f745f4817e51d9b63b4c7ea~jtuxxsLku1923719237epsmtip1o;
        Fri, 31 May 2019 08:23:42 +0000 (GMT)
From:   Maninder Singh <maninder1.s@samsung.com>
To:     viro@zeniv.linux.org.uk, jens.axboe@oracle.com
Cc:     v.narang@samsung.com, a.sahrawat@samsung.com, pankaj.m@samsung.com,
        linux-kernel@vger.kernel.org,
        Maninder Singh <maninder1.s@samsung.com>
Subject: [PATCH 1/1] splice: Reduce stack usage by reducing structure
 partial_page
Date:   Fri, 31 May 2019 13:53:32 +0530
Message-Id: <1559291012-19269-1-git-send-email-maninder1.s@samsung.com>
X-Mailer: git-send-email 2.7.4
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrLKsWRmVeSWpSXmKPExsWy7bCmlu7qJx9iDJY3s1hc3J1qsa95A6vF
        5V1z2CwOz29jsbj3ZiuTxaGTcxktzv89zurA7vHx6S0Wj74tqxg9Pm+S89j05C1TAEtUjk1G
        amJKapFCal5yfkpmXrqtkndwvHO8qZmBoa6hpYW5kkJeYm6qrZKLT4CuW2YO0AFKCmWJOaVA
        oYDE4mIlfTubovzSklSFjPziElul1IKUnAJDowK94sTc4tK8dL3k/FwrQwMDI1OgyoScjH1z
        J7IWtPBU/F/6l7mBcSVHFyMnh4SAiUTrj3esXYxcHEICuxkl5mx9xgzhfGKUeLN1DzuE841R
        YuuLG8wwLUsO72ODSOxllNj54hWU85VRYurpbWBVbAJ6Eqt27WHpYuTgEBEwkng1mQekhllg
        AqPE/t3zwGqEBUIkPr78BlbDIqAqcW+TFkiYV8Bd4tnn31DL5CRunusEO0lC4CerxNzuvSwQ
        CReJBef/QtnCEq+Ob2GHsKUkXva3sUM0tDNKXJ95jQXCmcIo0fl+JVSVvcSDG0fZQTYzC2hK
        rN+lDxGWlZh6ah0TiM0swCfR+/sJE0ScV2LHPBhbVaLl5gZWCFta4vPHj1BHeEjMbm0Hu1pI
        IFZi45xWtgmMsrMQNixgZFzFKJlaUJybnlpsWmCYl1qOHFWbGMFJS8tzB+Oscz6HGAU4GJV4
        eAUOvo8RYk0sK67MPcQowcGsJMLrfQEoxJuSWFmVWpQfX1Sak1p8iNEUGIITmaVEk/OBCTWv
        JN7Q1MjMzMDSwNTYwsxQSZx3EuvVGCGB9MSS1OzU1ILUIpg+Jg5OqQZGE2t9Vz+LA6/21X7X
        mJYw57T+Bul9nzYdObY+bZOq6N3zP5R8S7PeKK4MOxD/4S9LA9dOrXRNfaZXCrlsB9bt8FXM
        OxYc97PGa3pN9C2DvdveR5qW6rVmqFX8m3Rf7WTQ7dZNK57MW/wlTmr7dIdiExW2p5pyHsu3
        F9y5eW4P8+6OYys332ytVmIpzkg01GIuKk4EAP/E2VlwAwAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFmpjluLIzCtJLcpLzFFi42LZdlhJTrf/yYcYg78PLC0u7k612Ne8gdXi
        8q45bBaH57exWNx7s5XJ4tDJuYwW5/8eZ3Vg9/j49BaLR9+WVYwenzfJeWx68pYpgCWKyyYl
        NSezLLVI3y6BK2Pf3ImsBS08Ff+X/mVuYFzJ0cXIySEhYCKx5PA+ti5GLg4hgd2MEjPvTmSB
        SEhL/Pz3HsoWllj57zk7RNFnRombR+aCJdgE9CRW7doDZosATfqzeysTSBGzwDRGiT0LDjCB
        JIQFgiTetX5j7GLk4GARUJW4t0kLJMwr4C7x7PNvZogFchI3z3UyT2DkWcDIsIpRMrWgODc9
        t9iwwCgvtVyvODG3uDQvXS85P3cTIzh0tLR2MJ44EX+IUYCDUYmHV+Dg+xgh1sSy4srcQ4wS
        HMxKIrzeF4BCvCmJlVWpRfnxRaU5qcWHGKU5WJTEeeXzj0UKCaQnlqRmp6YWpBbBZJk4OKUa
        GBVn2hhnH7bprD0us2m5vPalyl2fqnXepm7SYXe+u3yJyU3VI6mGiju8Vj1oeFfnf6gzhuvB
        1tRTSZIJu4XbnJ6wTnzirXV52g/ZqU8X7Lp8VVye2/AfZ/rXlGliChtLDgj0ZRu8NdsucOL5
        NrkNUc38cr5JvaHh+kuUtjDN3mjltsr64fG2eCWW4oxEQy3mouJEAORBwrkZAgAA
X-CMS-MailID: 20190531082344epcas5p394e519d5940ca1642007f7e594e2917c
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: REQ_APPROVE
CMS-TYPE: 105P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20190531082344epcas5p394e519d5940ca1642007f7e594e2917c
References: <CGME20190531082344epcas5p394e519d5940ca1642007f7e594e2917c@epcas5p3.samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

u16 can be used to store Page offset and page len for partial page
for page size upto 65K. page size is fixed at compilation time so
size of partial page can be reduced to reduce stack usage of functions
using partial_page structure on stack.

<subbuf_splice_actor>:
       e16d42f4        strd    r4, [sp, #-36]! ; 0xffffffdc
...
       e24ddf4d        sub     sp, sp, #308    ; 0x134

<tracing_splice_read_pipe>:
       e16d42f4        strd    r4, [sp, #-36]! ; 0xffffffdc
...
       e24ddf53        sub     sp, sp, #332    ; 0x14c

After:
======
<subbuf_splice_actor>:                                           
       e16d42f4        strd    r4, [sp, #-36]! ; 0xffffffdc      
...            
       e24dd0f4        sub     sp, sp, #244    ; 0xf4  

<tracing_splice_read_pipe>:
       e16d42f4        strd    r4, [sp, #-36]! ; 0xffffffdc
...
       e24ddf45        sub     sp, sp, #276    ; 0x114

Tested on ARM.

Signed-off-by: Vaneet Narang <v.narang@samsung.com>
Signed-off-by: Maninder Singh <maninder1.s@samsung.com>
---
 include/linux/splice.h | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/include/linux/splice.h b/include/linux/splice.h
index 74b4911..d2b1814 100644
--- a/include/linux/splice.h
+++ b/include/linux/splice.h
@@ -45,8 +45,13 @@ struct splice_desc {
 };
 
 struct partial_page {
+#if PAGE_SHIFT < 16
+	unsigned short offset;
+	unsigned short len;
+#else
 	unsigned int offset;
 	unsigned int len;
+#endif
 	unsigned long private;
 };
 
-- 
2.7.4


Return-Path: <SRS0=nVcb=SO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 53FA5C10F0E
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Apr 2019 11:59:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E7D4C2082E
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Apr 2019 11:58:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="LnNH4U2G"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727171AbfDLL67 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 12 Apr 2019 07:58:59 -0400
Received: from mailout1.w1.samsung.com ([210.118.77.11]:38237 "EHLO
        mailout1.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726682AbfDLL66 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Apr 2019 07:58:58 -0400
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
        by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20190412115856euoutp0163c2fe752c52d960fbf213f5d533eb2a~UuDt13sJI0271002710euoutp012
        for <linux-kernel@vger.kernel.org>; Fri, 12 Apr 2019 11:58:56 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20190412115856euoutp0163c2fe752c52d960fbf213f5d533eb2a~UuDt13sJI0271002710euoutp012
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1555070336;
        bh=4RJVNzFk5m1VmvsSOQqIIjbbcVoeLkWSzJSwXZjy3Qo=;
        h=To:From:Subject:Date:References:From;
        b=LnNH4U2GUATjaViXw3Ch5gQVzZNIvwgXdVVzZN5z5IJs0pwsvEw1MoGpxC+VmoQ2q
         cDr5H9HH3QBvtNVRu0FG3djq/vABsLxo7g4VDtI9WEtWXJoME/7ILqgZ2Q//80Q8dt
         hDxtQblBAn2CusnUsg4jpZg0C49UWinTlcGIItWc=
Received: from eusmges3new.samsung.com (unknown [203.254.199.245]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTP id
        20190412115856eucas1p138ee00647490ec7a5e677de161050aa8~UuDthgNfm0512005120eucas1p1l;
        Fri, 12 Apr 2019 11:58:56 +0000 (GMT)
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
        eusmges3new.samsung.com (EUCPMTA) with SMTP id F8.67.04325.08D70BC5; Fri, 12
        Apr 2019 12:58:56 +0100 (BST)
Received: from eusmtrp2.samsung.com (unknown [182.198.249.139]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
        20190412115855eucas1p13b364b5e815ccd338ceb74577d116b14~UuDsqwlW_1049110491eucas1p1b;
        Fri, 12 Apr 2019 11:58:55 +0000 (GMT)
Received: from eusmgms1.samsung.com (unknown [182.198.249.179]) by
        eusmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20190412115855eusmtrp2e3e43d49a9e4fdc951c7fc8c1b79ce21~UuDsqVIj21965319653eusmtrp2F;
        Fri, 12 Apr 2019 11:58:55 +0000 (GMT)
X-AuditID: cbfec7f5-b75ff700000010e5-8f-5cb07d809b3a
Received: from eusmtip1.samsung.com ( [203.254.199.221]) by
        eusmgms1.samsung.com (EUCPMTA) with SMTP id 3F.C1.04146.F7D70BC5; Fri, 12
        Apr 2019 12:58:55 +0100 (BST)
Received: from [106.120.51.71] (unknown [106.120.51.71]) by
        eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20190412115855eusmtip1ca96a3ecac69fec21de36a1e4be01e4a~UuDsen07l1616316163eusmtip1k;
        Fri, 12 Apr 2019 11:58:55 +0000 (GMT)
To:     linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org
From:   Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Subject: [PATCH] video: fbdev: da8xx-fb: add COMPILE_TEST support
Message-ID: <5eba3c36-bc65-74ae-cc7c-cc45ee06ccfe@samsung.com>
Date:   Fri, 12 Apr 2019 13:58:54 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:45.0) Gecko/20100101
        Thunderbird/45.3.0
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrPIsWRmVeSWpSXmKPExsWy7djPc7oNtRtiDO7d4LC48vU9m8WJvg+s
        Fpd3zWFzYPa4332cyePzJrkApigum5TUnMyy1CJ9uwSujPZpr1kKtrJVfJ7exNjAeIi1i5GT
        Q0LAROLaqp9sXYxcHEICKxglVjV8ZoJwvjBK3N93ixHC+cwosfXjKbiWreuPQ7UsZ5TYuegp
        M4TzllHi4PJ3YFUiAgkSK6bPYASx2QSsJCa2rwKyOTiEBRwlDlyIBwnzCthJtExYzgZiswio
        Sqz+cI8FpERUIEKi/4w6RImgxMmZT1hAbGYBeYntb+eArZIQOMIm8XrLLiaIg1wkjnzoZoGw
        hSVeHd/CDmHLSPzfOZ8JomEdo8TfjhdQ3dsZJZZP/scGUWUtcfj4RVaQzcwCmhLrd+lDhB0l
        2i7tYQcJSwjwSdx4KwhxBJ/EpG3TmSHCvBIdbUIQ1WoSG5ZtYINZ27VzJTOE7SHx+e5ssLiQ
        QKzE4ou32Scwys9C8tosJK/NQrhhASPzKkbx1NLi3PTUYuO81HK94sTc4tK8dL3k/NxNjMBk
        cPrf8a87GPf9STrEKMDBqMTDu8F5fYwQa2JZcWXuIUYJDmYlEd4QFqAQb0piZVVqUX58UWlO
        avEhRmkOFiVx3mqGB9FCAumJJanZqakFqUUwWSYOTqkGxhbHlZr+GtnXG6w+v3HsMt6guOOQ
        S5WVtpXzohO/zk67/GnmE+t5hbcTVundK7La8Stmrfa65w6pRi7PEm/K53xpzFv7Ku6Nyuvm
        /zEKvrs31zLe9L62SK/wyOLVa49c4//arSHIalTEeOaiKePh1wJWB/ynW316zLvror5+3aRr
        u1x7dS79W6TEUpyRaKjFXFScCACiBlDOAgMAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrDLMWRmVeSWpSXmKPExsVy+t/xu7r1tRtiDLa+U7a48vU9m8WJvg+s
        Fpd3zWFzYPa4332cyePzJrkApig9m6L80pJUhYz84hJbpWhDCyM9Q0sLPSMTSz1DY/NYKyNT
        JX07m5TUnMyy1CJ9uwS9jPZpr1kKtrJVfJ7exNjAeIi1i5GTQ0LARGLr+uNsXYxcHEICSxkl
        tlw5zNjFyAGUkJE4vr4MokZY4s+1Lqia14wS7yZfZANJiAgkSDx9PR/MZhOwkpjYvgqsV1jA
        UeLAhXiQMK+AnUTLhOVgJSwCqhKrP9xjAbFFBSIkbj3sYIGoEZQ4OfMJmM0soC7xZ94lZghb
        XmL72znMExj5ZiEpm4WkbBaSsgWMzKsYRVJLi3PTc4sN9YoTc4tL89L1kvNzNzECQ3bbsZ+b
        dzBe2hh8iFGAg1GJhzfAan2MEGtiWXFl7iFGCQ5mJRHeEBagEG9KYmVValF+fFFpTmrxIUZT
        oMMnMkuJJucD4ymvJN7Q1NDcwtLQ3Njc2MxCSZz3vEFllJBAemJJanZqakFqEUwfEwenVAPj
        1Dav/vKrqVW/Gj5Ne3cvQWHqjuwAp5DD9ze/l5WuTD/2t9NtSWLWt6RZc/hLGkMb/itHSmzQ
        PZBW4NK8eavb/pqsHdcM2rLe3XhvsyW4fAVvj2vH//i7kvGzqm5fWlF7ZJ3Bmg/iix6qWbYZ
        dcXd3bkgTNns8bHm4x909ZdxaUsduKuzba+6EktxRqKhFnNRcSIAkJKEeW8CAAA=
X-CMS-MailID: 20190412115855eucas1p13b364b5e815ccd338ceb74577d116b14
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20190412115855eucas1p13b364b5e815ccd338ceb74577d116b14
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20190412115855eucas1p13b364b5e815ccd338ceb74577d116b14
References: <CGME20190412115855eucas1p13b364b5e815ccd338ceb74577d116b14@eucas1p1.samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add COMPILE_TEST support to da8xx-fb driver for better compile
testing coverage.

Signed-off-by: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
---
 drivers/video/fbdev/Kconfig |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

Index: b/drivers/video/fbdev/Kconfig
===================================================================
--- a/drivers/video/fbdev/Kconfig	2019-04-12 13:40:48.246274115 +0200
+++ b/drivers/video/fbdev/Kconfig	2019-04-12 13:55:50.694296842 +0200
@@ -2058,7 +2058,7 @@ config FB_SH7760
 
 config FB_DA8XX
 	tristate "DA8xx/OMAP-L1xx/AM335x Framebuffer support"
-	depends on FB && (ARCH_DAVINCI_DA8XX || SOC_AM33XX)
+	depends on FB && (ARCH_DAVINCI_DA8XX || SOC_AM33XX || COMPILE_TEST)
 	select FB_CFB_FILLRECT
 	select FB_CFB_COPYAREA
 	select FB_CFB_IMAGEBLIT

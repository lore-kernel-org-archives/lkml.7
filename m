Return-Path: <SRS0=Ecng=WJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4C08BC433FF
	for <linux-kernel@archiver.kernel.org>; Tue, 13 Aug 2019 10:54:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E84F32067D
	for <linux-kernel@archiver.kernel.org>; Tue, 13 Aug 2019 10:54:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="tqnsUgP0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728272AbfHMKyD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 13 Aug 2019 06:54:03 -0400
Received: from mailout2.w1.samsung.com ([210.118.77.12]:54938 "EHLO
        mailout2.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726298AbfHMKyD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Aug 2019 06:54:03 -0400
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
        by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20190813105400euoutp0277900ac5dd53adeb3930279abb393851~6dhIwS-lE0916809168euoutp02P
        for <linux-kernel@vger.kernel.org>; Tue, 13 Aug 2019 10:54:00 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20190813105400euoutp0277900ac5dd53adeb3930279abb393851~6dhIwS-lE0916809168euoutp02P
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1565693640;
        bh=aDFPtneXHeVobCb1CMDp3QUHNNU2kziXVEXsVFserU0=;
        h=From:To:Cc:Subject:Date:References:From;
        b=tqnsUgP050mjqSksicM3yknaqcDCMvA46u61J9BvflwhJR3jkU0oMvdaFryyGenjg
         /oTF85rN/DGEp5t5dTp2a2tfjsx3pN80VrYrxDCFNT4VMMZPcOpWTCZIaICa3Mt8Wg
         Z9aHHE2SJbyWNakLgRwWRzu4tU7K+XHrN+P7qRQc=
Received: from eusmges2new.samsung.com (unknown [203.254.199.244]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTP id
        20190813105400eucas1p2edac71742c8bd13353f5c295a5cf9150~6dhIO7lsL3060430604eucas1p2X;
        Tue, 13 Aug 2019 10:54:00 +0000 (GMT)
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
        eusmges2new.samsung.com (EUCPMTA) with SMTP id 96.30.04309.8C6925D5; Tue, 13
        Aug 2019 11:54:00 +0100 (BST)
Received: from eusmtrp2.samsung.com (unknown [182.198.249.139]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
        20190813105359eucas1p2c4fecf74be23d3e7739a61c55050bc89~6dhHM0Fn32856828568eucas1p2r;
        Tue, 13 Aug 2019 10:53:59 +0000 (GMT)
Received: from eusmgms2.samsung.com (unknown [182.198.249.180]) by
        eusmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20190813105359eusmtrp234ae32169119983abd201c921d2e4f6f~6dhG9NEqx2908429084eusmtrp2g;
        Tue, 13 Aug 2019 10:53:59 +0000 (GMT)
X-AuditID: cbfec7f4-ae1ff700000010d5-54-5d5296c8e64e
Received: from eusmtip1.samsung.com ( [203.254.199.221]) by
        eusmgms2.samsung.com (EUCPMTA) with SMTP id CB.A6.04117.6C6925D5; Tue, 13
        Aug 2019 11:53:58 +0100 (BST)
Received: from AMDC3555.DIGITAL.local (unknown [106.120.51.67]) by
        eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20190813105358eusmtip15612398bdf76ce66e17014d3a900833a~6dhGkX-CB1328413284eusmtip1c;
        Tue, 13 Aug 2019 10:53:58 +0000 (GMT)
From:   =?UTF-8?q?Artur=20=C5=9Awigo=C5=84?= <a.swigon@partner.samsung.com>
To:     devel@lists.orangefs.org, linux-kernel@vger.kernel.org
Cc:     hubcap@omnibond.com, martin@omnibond.com
Subject: [PATCH] orangefs: Add octal zero prefix
Date:   Tue, 13 Aug 2019 12:53:37 +0200
Message-Id: <20190813105337.3065-1-a.swigon@partner.samsung.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprJKsWRmVeSWpSXmKPExsWy7djPc7onpgXFGrw+xmJx6NhWdov9m6cw
        WbTf7WOyuLxrDpvFz7UrWSxOrv/P7MDm0TD1FpvHr9t3WD0OvtvD5NG3ZRWjx+dNcgGsUVw2
        Kak5mWWpRfp2CVwZC14dYyx4xlqx7cMVtgbGZyxdjJwcEgImEu+ftgDZXBxCAisYJSafnAPl
        fGGU2PZtMZTzmVHixtkpTDAtK5sOskIkljNKLG4+zQjX8uHWa2aQKjYBT4meiTtYQWwRASuJ
        z7+/gtnMAjoS+24cALOFBQwkPr+5AzaVRUBV4sTNR2wgNq+Ag8S9I+egDpSXWL3hADNEXFDi
        5MwnLBBz5CWat85mBlksIfCfTeJa302oBheJw41/2CFsYYlXx7dA2TIS/3fOh3qhWOLpzvus
        EM0NjBKblh1hhkhYSxw+fhEowQG0QVNi/S59iLCjxMH/15hBwhICfBI33gpC3MAnMWnbdKgw
        r0RHmxCEqSWx4Hc0RKOERNPqa1CzPSQeXlrGCGILCcRKvP+9gWUCo8IsJI/NQvLYLIQTFjAy
        r2IUTy0tzk1PLTbKSy3XK07MLS7NS9dLzs/dxAhMMKf/Hf+yg3HXn6RDjAIcjEo8vBUJgbFC
        rIllxZW5hxglOJiVRHgvmQTFCvGmJFZWpRblxxeV5qQWH2KU5mBREuetZngQLSSQnliSmp2a
        WpBaBJNl4uCUamBkvP38a+ws5RMJbm1HDzfp3cyaLLb4LKdmuZ34ikBz66v83F99L8vJT9v7
        zMFAS1dixrFiideZJXeP5T32+7+tc6t9+ZN27o08BWpf7i45s1TsphIrc5FE+usT7/lsX9QY
        zAo4afHac7JQYN/mZZu+ff90csHDjIwMxa/ctY0mUTzT5v+8dmqGEktxRqKhFnNRcSIAA6et
        siwDAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFmplkeLIzCtJLcpLzFFi42I5/e/4Xd1j04JiDT5OtbY4dGwru8X+zVOY
        LNrv9jFZXN41h83i59qVLBYn1/9ndmDzaJh6i83j1+07rB4H3+1h8ujbsorR4/MmuQDWKD2b
        ovzSklSFjPziElulaEMLIz1DSws9IxNLPUNj81grI1MlfTublNSczLLUIn27BL2MBa+OMRY8
        Y63Y9uEKWwPjM5YuRk4OCQETiZVNB1m7GLk4hASWMkpMb5nJBpGQkPi4/gYrhC0s8edaFxtE
        0SdGiVkTO5lAEmwCnhI9E3cAFXFwiAjYSDybXg8SZhbQkzg5ezlYr7CAgcTnN3fAylkEVCVO
        3HwENp9XwEHi3pFzUEfIS6zecIAZIi4ocXLmExaQkcwC6hLr5wlBjJSXaN46m3kCI/8sJFWz
        EKpmIalawMi8ilEktbQ4Nz232EivODG3uDQvXS85P3cTIzAKth37uWUHY9e74EOMAhyMSjy8
        FQmBsUKsiWXFlbmHGCU4mJVEeC+ZBMUK8aYkVlalFuXHF5XmpBYfYjQFemEis5Rocj4wQvNK
        4g1NDc0tLA3Njc2NzSyUxHk7BA7GCAmkJ5akZqemFqQWwfQxcXBKNTA2Lld+dfffw297hGOf
        cb3VOPcljj01aUZibuA2nvmZcSVMvcvryiZtialOCpUssO3R+nDt65X9CVH3/x3/5MGyTftO
        6nLemgW9Sx8bP5fIjH2gmmI8dQlriI3sGmHVgNaToq5Kns/6JLgnZyUXrfrVnLAmdarIc7/7
        FZV3tk5YtKng+LyC6L9KLMUZiYZazEXFiQACCjYTmAIAAA==
X-CMS-MailID: 20190813105359eucas1p2c4fecf74be23d3e7739a61c55050bc89
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20190813105359eucas1p2c4fecf74be23d3e7739a61c55050bc89
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20190813105359eucas1p2c4fecf74be23d3e7739a61c55050bc89
References: <CGME20190813105359eucas1p2c4fecf74be23d3e7739a61c55050bc89@eucas1p2.samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch adds a missing zero to mode 755 specification required to
express it in octal numeral system.

Reported-by: Łukasz Wrochna <l.wrochna@samsung.com>
Signed-off-by: Artur Świgoń <a.swigon@partner.samsung.com>
---
 fs/orangefs/namei.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/orangefs/namei.c b/fs/orangefs/namei.c
index 1dd710e5f376..3e7cf3d0a494 100644
--- a/fs/orangefs/namei.c
+++ b/fs/orangefs/namei.c
@@ -224,7 +224,7 @@ static int orangefs_symlink(struct inode *dir,
 	struct orangefs_object_kref ref;
 	struct inode *inode;
 	struct iattr iattr;
-	int mode = 755;
+	int mode = 0755;
 	int ret;
 
 	gossip_debug(GOSSIP_NAME_DEBUG, "%s: called\n", __func__);
-- 
2.17.1


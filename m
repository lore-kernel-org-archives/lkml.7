Return-Path: <SRS0=TKbG=UN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8026FC31E44
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Jun 2019 10:44:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0C441208CA
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Jun 2019 10:44:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="Ae1H5KsQ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727197AbfFNKn6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Jun 2019 06:43:58 -0400
Received: from mailout2.w1.samsung.com ([210.118.77.12]:42559 "EHLO
        mailout2.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726873AbfFNKn6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Jun 2019 06:43:58 -0400
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
        by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20190614104356euoutp0236a21edef4fec4241a6f85711d121c5b~oCrNulpBO1196611966euoutp02P
        for <linux-kernel@vger.kernel.org>; Fri, 14 Jun 2019 10:43:56 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20190614104356euoutp0236a21edef4fec4241a6f85711d121c5b~oCrNulpBO1196611966euoutp02P
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1560509036;
        bh=Zl7VnI5bsj4BuaNyNNSUeOVR4pqArffBJEh0eJbRbws=;
        h=To:Cc:From:Subject:Date:References:From;
        b=Ae1H5KsQQy+rjpQC3oXOlZ+Knk4zza9lc3lwkZLGm/7ikJQDgHtbwc68M4hPrztoV
         5/9FrpF0R5LfHEmSbpL/xKp9f0xHwxkHj0Ag8ce1K+ZqtTK8UeizwyPbKsFCzWVwBP
         PwvubvsZmNQhLEqozi7lIvS4wRSQDFzf3Z16cFyQ=
Received: from eusmges2new.samsung.com (unknown [203.254.199.244]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTP id
        20190614104355eucas1p217c5dacecfec33cfdbd7887519d2a78a~oCrNGFicf1341513415eucas1p2Y;
        Fri, 14 Jun 2019 10:43:55 +0000 (GMT)
Received: from eucas1p2.samsung.com ( [182.198.249.207]) by
        eusmges2new.samsung.com (EUCPMTA) with SMTP id C1.B6.04377.B6A730D5; Fri, 14
        Jun 2019 11:43:55 +0100 (BST)
Received: from eusmtrp2.samsung.com (unknown [182.198.249.139]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
        20190614104355eucas1p236ecb70b6d48f37508f3837cee49b19f~oCrMSQjgh1341513415eucas1p2W;
        Fri, 14 Jun 2019 10:43:55 +0000 (GMT)
Received: from eusmgms1.samsung.com (unknown [182.198.249.179]) by
        eusmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20190614104354eusmtrp276153a14cefbc37a839d65795e31ef03~oCrMCznpo1815618156eusmtrp2v;
        Fri, 14 Jun 2019 10:43:54 +0000 (GMT)
X-AuditID: cbfec7f4-12dff70000001119-70-5d037a6bf500
Received: from eusmtip1.samsung.com ( [203.254.199.221]) by
        eusmgms1.samsung.com (EUCPMTA) with SMTP id F3.C6.04146.A6A730D5; Fri, 14
        Jun 2019 11:43:54 +0100 (BST)
Received: from [106.120.51.71] (unknown [106.120.51.71]) by
        eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20190614104354eusmtip1e5cff7dccf3f6757a4b7145d8b5ae8e8~oCrL0oNKa1678516785eusmtip1h;
        Fri, 14 Jun 2019 10:43:54 +0000 (GMT)
To:     linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org
Cc:     Stephen Rothwell <sfr@canb.auug.org.au>
From:   Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Subject: [PATCH] video: fbdev: pvr2fb: fix build warning when compiling as
 module
Message-ID: <2376f0a7-2511-b52d-c0d1-9162382f8693@samsung.com>
Date:   Fri, 14 Jun 2019 12:43:56 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
        Thunderbird/60.6.1
MIME-Version: 1.0
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprEKsWRmVeSWpSXmKPExsWy7djP87rZVcyxBte2aFlc+fqezeJE3wdW
        i8u75rBZbN17ld2BxaPxxg02j/vdx5k8Pm+SC2CO4rJJSc3JLEst0rdL4Mp4Nv8Za8EM9orz
        0xwbGH+zdjFyckgImEj8WPWaqYuRi0NIYAWjxMmXbxghnC+MEm2vdjJDOJ8ZJc7vusUG03Kr
        7whUy3JGiQUHtrNAOG8ZJbqfn2MHqRIRSJBYMX0GI4jNLKAt0fv2PTOIzSZgJTGxfRVYXFgg
        WGLHv0awQ3gF7CS+XW8Ds1kEVCWWbz/HAmKLCkRI3D+2AapGUOLkzCcsEDPFJW49mc8EYctL
        bH87B+xUCYHPbBJ/ni5jhDjVReLr3MssELawxKvjW9ghbBmJ/zvnM0E0rGOU+NvxAqp7O6PE
        8sn/oB61ljh8/CLQag6gFZoS63fpQ4QdJQ5v/cgGEpYQ4JO48VYQ4gg+iUnbpjNDhHklOtqE
        IKrVJDYs28AGs7Zr50pmCNtDYkbzCqYJjIqzkLw2C8lrs5C8NgvhhgWMLKsYxVNLi3PTU4uN
        8lLL9YoTc4tL89L1kvNzNzECU8rpf8e/7GDc9SfpEKMAB6MSD+8BK6ZYIdbEsuLK3EOMEhzM
        SiK886yZY4V4UxIrq1KL8uOLSnNSiw8xSnOwKInzVjM8iBYSSE8sSc1OTS1ILYLJMnFwSjUw
        rrp3fR2rvvlkSevDqhlVqY9OfdIw+LRpbd9V+2kHrk3cc8ZL9un7vk/Pdn6/1rd1a6Semuz2
        +BqLWx4lnJ+4q6Ll5x1PM3656mP2iWaLrnt7GapC8g4k/ZgWoLI0wsDz4I0T+Tukvlo5Zrpb
        VUfZx8aviX4ay2w70dv2aH1tCf+Fg0HS1ek5SizFGYmGWsxFxYkApOjzlyUDAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFupikeLIzCtJLcpLzFFi42I5/e/4Xd2sKuZYg70vjSyufH3PZnGi7wOr
        xeVdc9gstu69yu7A4tF44wabx/3u40wenzfJBTBH6dkU5ZeWpCpk5BeX2CpFG1oY6RlaWugZ
        mVjqGRqbx1oZmSrp29mkpOZklqUW6dsl6GU8m/+MtWAGe8X5aY4NjL9Zuxg5OSQETCRu9R1h
        6mLk4hASWMoo8WXiIbYuRg6ghIzE8fVlEDXCEn+udbFB1LxmlFh0+z0bSEJEIEHi6ev5YDaz
        gLZE79v3zCA2m4CVxMT2VYwgtrBAsMSOf41gy3gF7CS+XW8Ds1kEVCWWbz/HAmKLCkRInHm/
        ggWiRlDi5MwnLBAz1SX+zLvEDGGLS9x6Mp8JwpaX2P52DvMERoFZSFpmIWmZhaRlFpKWBYws
        qxhFUkuLc9Nziw31ihNzi0vz0vWS83M3MQLjYduxn5t3MF7aGHyIUYCDUYmH94AVU6wQa2JZ
        cWXuIUYJDmYlEd551syxQrwpiZVVqUX58UWlOanFhxhNgR6ayCwlmpwPjNW8knhDU0NzC0tD
        c2NzYzMLJXHeDoGDMUIC6YklqdmpqQWpRTB9TBycUg2MRhVfHBUuTVK57xH3W9rR61jrP+bU
        A+ey9x7Ty2NPdtLY/F/T8+oVa009bT3j1XcmvQrRkfwfcl3NSzlpDU+keuij8pe8bL0J+1Qn
        V+WfFFyiE2S9V+H+gktX9t65vmz25p9P+TY99P3Jdd9h16Xd7pI+5xiVv0yKuB+wu/tYpV/Q
        /otMP6KNlFiKMxINtZiLihMBpVOgjZ0CAAA=
X-CMS-MailID: 20190614104355eucas1p236ecb70b6d48f37508f3837cee49b19f
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20190614104355eucas1p236ecb70b6d48f37508f3837cee49b19f
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20190614104355eucas1p236ecb70b6d48f37508f3837cee49b19f
References: <CGME20190614104355eucas1p236ecb70b6d48f37508f3837cee49b19f@eucas1p2.samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add missing #ifndef MODULE around pvr2_get_param_val().

Fixes: 0f5a5712ad1e ("video: fbdev: pvr2fb: add COMPILE_TEST support")
Reported-by: Stephen Rothwell <sfr@canb.auug.org.au>
Signed-off-by: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
---
 drivers/video/fbdev/pvr2fb.c |    2 ++
 1 file changed, 2 insertions(+)

Index: b/drivers/video/fbdev/pvr2fb.c
===================================================================
--- a/drivers/video/fbdev/pvr2fb.c
+++ b/drivers/video/fbdev/pvr2fb.c
@@ -722,6 +722,7 @@ static struct fb_ops pvr2fb_ops = {
 	.fb_imageblit	= cfb_imageblit,
 };
 
+#ifndef MODULE
 static int pvr2_get_param_val(const struct pvr2_params *p, const char *s,
 			      int size)
 {
@@ -733,6 +734,7 @@ static int pvr2_get_param_val(const stru
 	}
 	return -1;
 }
+#endif
 
 static char *pvr2_get_param_name(const struct pvr2_params *p, int val,
 			  int size)

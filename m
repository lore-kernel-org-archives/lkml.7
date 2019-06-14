Return-Path: <SRS0=TKbG=UN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 30A7EC31E4B
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Jun 2019 14:47:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 044A42133D
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Jun 2019 14:47:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="UNVz0eKI"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728990AbfFNOri (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Jun 2019 10:47:38 -0400
Received: from mailout1.w1.samsung.com ([210.118.77.11]:44297 "EHLO
        mailout1.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728233AbfFNOri (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Jun 2019 10:47:38 -0400
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
        by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20190614144736euoutp0174e16fa3161083ec70fe5c628fba1640~oF-9xpi4j3148231482euoutp01i
        for <linux-kernel@vger.kernel.org>; Fri, 14 Jun 2019 14:47:36 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20190614144736euoutp0174e16fa3161083ec70fe5c628fba1640~oF-9xpi4j3148231482euoutp01i
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1560523656;
        bh=vg+p7zFanCSl59yGXY1FnQrt4BBpQ9tRwbXks+s9a6E=;
        h=From:Subject:To:Cc:Date:References:From;
        b=UNVz0eKIrTACreITW2rj3dlOXmVE6+9N+ayNEIL0zRXBtVbdUBuzNrCCHzpnIwb4l
         MR+y/J9htxNEAxZBb5Gb+vIesBrGxX0FxXMHQYlvEYLKuiJl+IYO+aa7ia8UUoCGr7
         KXdd8DCT2axob+TE/2EsHP5MT9wcgHIqQxarqHXA=
Received: from eusmges3new.samsung.com (unknown [203.254.199.245]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTP id
        20190614144736eucas1p1ebd03828cac1313ee6e22643239db5b8~oF-9aNJpH0266602666eucas1p1j;
        Fri, 14 Jun 2019 14:47:36 +0000 (GMT)
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
        eusmges3new.samsung.com (EUCPMTA) with SMTP id 52.86.04325.883B30D5; Fri, 14
        Jun 2019 15:47:36 +0100 (BST)
Received: from eusmtrp1.samsung.com (unknown [182.198.249.138]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
        20190614144735eucas1p2f71313b752ae4ea841ddd4ea502fd79f~oF-8OTpdS2290822908eucas1p2k;
        Fri, 14 Jun 2019 14:47:35 +0000 (GMT)
Received: from eusmgms2.samsung.com (unknown [182.198.249.180]) by
        eusmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20190614144734eusmtrp1a401b19e4b67fc9ef5457d24e0ff6682~oF-7_0lfM2548325483eusmtrp1E;
        Fri, 14 Jun 2019 14:47:34 +0000 (GMT)
X-AuditID: cbfec7f5-b75ff700000010e5-66-5d03b3889aec
Received: from eusmtip2.samsung.com ( [203.254.199.222]) by
        eusmgms2.samsung.com (EUCPMTA) with SMTP id AC.8E.04140.683B30D5; Fri, 14
        Jun 2019 15:47:34 +0100 (BST)
Received: from [106.120.51.71] (unknown [106.120.51.71]) by
        eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20190614144734eusmtip2c8392ac0206644617e2e70c76871a259~oF-7tv3032993929939eusmtip2L;
        Fri, 14 Jun 2019 14:47:34 +0000 (GMT)
From:   Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Subject: [PATCH 1/3] video: fbdev: s3c-fb: return -ENOMEM on
 framebuffer_alloc() failure
To:     linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org
Cc:     Jingoo Han <jingoohan1@gmail.com>
Message-ID: <bbf32fbc-b4bc-39fc-e8dd-db9f0cd0d83f@samsung.com>
Date:   Fri, 14 Jun 2019 16:47:34 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
        Thunderbird/60.6.1
MIME-Version: 1.0
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Brightmail-Tracker: H4sIAAAAAAAAA02Sa0hTcRjG++9cdhxOjlPxxS7SKKEgrQwaGVIRNPCLHxSjMDfzMJduyua8
        ZKAk6FpDM1PntJyBOVe0ecHLCsMlHktUIrFIRDMpzWbBFBHU8niU/PZ7n/d9+D8P/ClMUkmE
        UWptDqPTKjOlpAjvGlwbPWHswJJPvvGRsvGV36TMvlwnlA2V/yFkH90N5AVc3mudEsqn77MC
        ua/9UDx2TXQ+jclU5zK6qFiFKN3Y3SrM7iPyBx6zeDEawU3IjwL6DLTUWAQmJKIktB1BrbNs
        Z1hG8KmexfjBh6B5cZXYtVQ8txD8ogXB+JBXwC0ktBfBWE04xyR9DirLHMiEKCqIvgauhQxO
        DqYVYK+1II4x+ii4S5q3WUzHgmd2UsgxvqU/Wq3GOA6hr8L0oIvgbwLhXd0czntD4ctco4Dn
        cOj2NmwHBdpHQuNs5063y1Be3yTkOQh+sp07fACGq8w4b3iJYMM4v+PuRtBStUnyVzHwlv1A
        cA0w+hg43VG8fBGWNqeEnAx0AHz2BvIhAuBhVy3Gy2Iwlkr46whwPXORu8+aelsxnuXQMe/E
        H6DD1j3VrHuqWfdUs/7PYEO4A4UyBr1GxeijtUxepF6p0Ru0qsibWZp2tPVRhjfZlR7Ut57q
        QTSFpP5iSzmWLCGUufoCjQcBhUmDxU9itiRxmrLgNqPLStEZMhm9B+2ncGmouHDfzHUJrVLm
        MBkMk83odrcCyi+sGJ0eYWxrE4ljVRG5hTaz/BtbNGUH/2F5/UycOUTnmPAZ7rgX816bl1S3
        nCn9P0ZLD4YUxh1JHWhKYBon4zHN35LWpwsJN5IS2QrrWXVPwK/qpOT8MUaxflc87pPP9H9v
        iO63NSM6o9IX9X6jbbXI+1Vhv/LK0fZitq1UfemeFNenK08dx3R65T+PgPCNJAMAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFupikeLIzCtJLcpLzFFi42I5/e/4Pd22zcyxBtPW6Vtc+fqezWLFl5ns
        Fif6PrBaXN41h82BxWPnrLvsHve7jzN5fN4kF8AcpWdTlF9akqqQkV9cYqsUbWhhpGdoaaFn
        ZGKpZ2hsHmtlZKqkb2eTkpqTWZZapG+XoJfRsX0le8E+1oojc4+zNDCeZeli5OSQEDCR6F89
        g7WLkYtDSGApo0TDqXfMXYwcQAkZiePryyBqhCX+XOtig6h5zShxovk5K0iCTcBKYmL7KkaQ
        emGBKIkNL7NBwiICCRJPX89nA7GZBVQldjUvZQSxeQXsJA49us0OYrMAxad8n8oMYosKREic
        eb+CBaJGUOLkzCcsEL3qEn/mXWKGsMUlbj2ZzwRhy0tsfzuHeQKjwCwkLbOQtMxC0jILScsC
        RpZVjCKppcW56bnFRnrFibnFpXnpesn5uZsYgfGw7djPLTsYu94FH2IU4GBU4uGd0cccK8Sa
        WFZcmXuIUYKDWUmEd541UIg3JbGyKrUoP76oNCe1+BCjKdBDE5mlRJPzgbGaVxJvaGpobmFp
        aG5sbmxmoSTO2yFwMEZIID2xJDU7NbUgtQimj4mDU6qB8eSMKcIh3GHvioXm78zy3cx5+VdY
        2gaN9MJN5w/zpr8QTrouWqFqbO5dXjmn9Nw+9tXablUT1sulONcs6C791fB9k8rrL4eljr5q
        kNI4Pz1Wb0e95vZrjq+DD13VnHh5vlbEGTWzpZ8r3HbvsLvY7rec/8aVjhd+62pYe+ZkiN9V
        e1y85I9brhJLcUaioRZzUXEiABylbRydAgAA
X-CMS-MailID: 20190614144735eucas1p2f71313b752ae4ea841ddd4ea502fd79f
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20190614144735eucas1p2f71313b752ae4ea841ddd4ea502fd79f
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20190614144735eucas1p2f71313b752ae4ea841ddd4ea502fd79f
References: <CGME20190614144735eucas1p2f71313b752ae4ea841ddd4ea502fd79f@eucas1p2.samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix error code from -ENOENT to -ENOMEM.

Cc: Jingoo Han <jingoohan1@gmail.com>
Signed-off-by: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
---
 drivers/video/fbdev/s3c-fb.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

Index: b/drivers/video/fbdev/s3c-fb.c
===================================================================
--- a/drivers/video/fbdev/s3c-fb.c
+++ b/drivers/video/fbdev/s3c-fb.c
@@ -1191,7 +1191,7 @@ static int s3c_fb_probe_win(struct s3c_f
 				   palette_size * sizeof(u32), sfb->dev);
 	if (!fbinfo) {
 		dev_err(sfb->dev, "failed to allocate framebuffer\n");
-		return -ENOENT;
+		return -ENOMEM;
 	}
 
 	windata = sfb->pdata->win[win_no];

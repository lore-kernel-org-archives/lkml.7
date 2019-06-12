Return-Path: <SRS0=n7Fw=UL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2493DC31E44
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Jun 2019 01:17:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 000A120874
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Jun 2019 01:17:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PmVQmVsO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2408302AbfFLBRJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Jun 2019 21:17:09 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:44080 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2404906AbfFLBRG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Jun 2019 21:17:06 -0400
Received: by mail-pf1-f193.google.com with SMTP id t16so8542324pfe.11
        for <linux-kernel@vger.kernel.org>; Tue, 11 Jun 2019 18:17:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=/4mZhjz2dkfafdy2bqfClO5VTqYAkHEFd5uOF7sABt0=;
        b=PmVQmVsONHga6z7L+7IIh6Vn/kPjgNT39RFZMidKSw3Pgd/4JDPThUO75CI9v/y44p
         CecZm6fAk7kAc/6KJJ2TC/0a2uH5FikGxfqcCFyimpHf/N9hXZ1ErtF870SdTKdGIwM2
         BY07MsFVyL9kUD155wafDB6U621Vj+775KUvYStLxHoNpiZULS67vpHLWfo8CoZEx2Jm
         jhmb15UNv70f9hPKn7B9FLK0adghG3I/eJVS4tsA+fn+Cg6xwPL8ORyr87boMRkPg5cf
         FdDkHxtnXxH5asbRveQGAFLr5nPthyykU2pHMDlKujuK/iZbRsTHykR9f4KBamyhsP9C
         Qoww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=/4mZhjz2dkfafdy2bqfClO5VTqYAkHEFd5uOF7sABt0=;
        b=Rm2qsApAtlMsRHL3ws9ktc4J6aH2G5AAqoHg2xaXPups2iUjsnpQnDwJrNYjkjFavl
         anGAOaLJ1V77lJMgoxME0bGYThhcSfEmjbivWiA5jat+rrThKO13GLTaANKS/diMwD7s
         ZcwCb6tGwt7IeIQqBb7Ou7nqsIwwJEfHfcVtABY7h+6sG6BPHqfZuiKfNWTkkMRrv17l
         g5rE+B2ZUSycN8+QEO/+W/w7+u7E0OKsCXXqrmzswh10NT7yk3Js0X0bnI/i8LX6yr7g
         GGUGDvMexrowepLXtXrPvG1yMBTwa7L5ULk2WjDU2yD7BnxrZGnV8gOFm1ClYWGpl2Dg
         ZhUg==
X-Gm-Message-State: APjAAAVWeSTrAwxZg8EJZmO26ftdib2RwnF/chR4SeKlH2YNCu1QTNeH
        0qmjTc793heyT30o0mUZggA=
X-Google-Smtp-Source: APXvYqx8w3UNZJYyEfyesl8GJz44ySL1V6YwpvRUhn3tlhK/Vom10lrDEoqmya0nS0qFRQcHkUOFAA==
X-Received: by 2002:a17:90a:290b:: with SMTP id g11mr29801294pjd.122.1560302225650;
        Tue, 11 Jun 2019 18:17:05 -0700 (PDT)
Received: from mappy.world.mentorg.com (c-107-3-185-39.hsd1.ca.comcast.net. [107.3.185.39])
        by smtp.gmail.com with ESMTPSA id y22sm13257015pgj.38.2019.06.11.18.17.04
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 11 Jun 2019 18:17:05 -0700 (PDT)
From:   Steve Longerbeam <slongerbeam@gmail.com>
To:     Philipp Zabel <p.zabel@pengutronix.de>
Cc:     Steve Longerbeam <slongerbeam@gmail.com>,
        dri-devel@lists.freedesktop.org (open list:DRM DRIVERS FOR FREESCALE
        IMX), linux-kernel@vger.kernel.org (open list)
Subject: [PATCH 2/3] gpu: ipu-v3: image-convert: Fix input bytesperline for packed formats
Date:   Tue, 11 Jun 2019 18:16:56 -0700
Message-Id: <20190612011657.12119-2-slongerbeam@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190612011657.12119-1-slongerbeam@gmail.com>
References: <20190612011657.12119-1-slongerbeam@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The input bytesperline calculation for packed pixel formats was
incorrect. The min/max clamping values must be multiplied by the
packed bits-per-pixel. This was causing corrupted converted images
when the input format was RGB4 (probably also other input packed
formats).

Fixes: d966e23d61a2c ("gpu: ipu-v3: image-convert: fix bytesperline
adjustment")

Reported-by: Harsha Manjula Mallikarjun <Harsha.ManjulaMallikarjun@in.bosch.com>
Suggested-by: Harsha Manjula Mallikarjun <Harsha.ManjulaMallikarjun@in.bosch.com>
Signed-off-by: Steve Longerbeam <slongerbeam@gmail.com>
---
 drivers/gpu/ipu-v3/ipu-image-convert.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/ipu-v3/ipu-image-convert.c b/drivers/gpu/ipu-v3/ipu-image-convert.c
index 36eb4c77ad91..4dfdbd1adf0d 100644
--- a/drivers/gpu/ipu-v3/ipu-image-convert.c
+++ b/drivers/gpu/ipu-v3/ipu-image-convert.c
@@ -1933,7 +1933,9 @@ void ipu_image_convert_adjust(struct ipu_image *in, struct ipu_image *out,
 		clamp_align(in->pix.width, 2 << w_align_in, MAX_W,
 			    w_align_in) :
 		clamp_align((in->pix.width * infmt->bpp) >> 3,
-			    2 << w_align_in, MAX_W, w_align_in);
+			    ((2 << w_align_in) * infmt->bpp) >> 3,
+			    (MAX_W * infmt->bpp) >> 3,
+			    w_align_in);
 	in->pix.sizeimage = infmt->planar ?
 		(in->pix.height * in->pix.bytesperline * infmt->bpp) >> 3 :
 		in->pix.height * in->pix.bytesperline;
-- 
2.17.1


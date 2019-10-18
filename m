Return-Path: <SRS0=6OEZ=YL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D60ADCA9ECF
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Oct 2019 05:06:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AB423222C5
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Oct 2019 05:06:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=umn.edu header.i=@umn.edu header.b="bdTw0Peu"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2504242AbfJRFGP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 18 Oct 2019 01:06:15 -0400
Received: from mta-p5.oit.umn.edu ([134.84.196.205]:58382 "EHLO
        mta-p5.oit.umn.edu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2504094AbfJRFFW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Oct 2019 01:05:22 -0400
Received: from localhost (unknown [127.0.0.1])
        by mta-p5.oit.umn.edu (Postfix) with ESMTP id 6C8F5C7D
        for <linux-kernel@vger.kernel.org>; Fri, 18 Oct 2019 04:47:07 +0000 (UTC)
X-Virus-Scanned: amavisd-new at umn.edu
Received: from mta-p5.oit.umn.edu ([127.0.0.1])
        by localhost (mta-p5.oit.umn.edu [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id UbelHPT3ywrw for <linux-kernel@vger.kernel.org>;
        Thu, 17 Oct 2019 23:47:07 -0500 (CDT)
Received: from mail-io1-f71.google.com (mail-io1-f71.google.com [209.85.166.71])
        (using TLSv1.2 with cipher AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mta-p5.oit.umn.edu (Postfix) with ESMTPS id 442B1C7E
        for <linux-kernel@vger.kernel.org>; Thu, 17 Oct 2019 23:47:07 -0500 (CDT)
Received: by mail-io1-f71.google.com with SMTP id r5so7122849iop.2
        for <linux-kernel@vger.kernel.org>; Thu, 17 Oct 2019 21:47:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=umn.edu; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=EUxpZ3T7vF3Kc+2RT08v4EEjAUSgYRvb0sha4nlMD8s=;
        b=bdTw0PeubzcFLX1DriNm0Yl8F6jO9UQoufbrtSDEs2MigRgqIOl6EgA0X//E19MR66
         XpcdNRPB7qQNjzC43YxSWiD+KXoP8weegm1HXd7uoxT+1wgQ9KiBhqajAmyu8pEyt+fH
         qkvk2dC0jbqXNKfd71ZkAnX1/hNKlEHhYQaOkcRslt/U5CG7CZkuukajp9Au3eF39qDP
         IwRkhylUXdMbDkN5jqdMIUmSzuYH9W3wQ3cniFfx1nhZDFZlBDqyp61SR0djcWU0Xa8h
         q1xO07n9Kf4GAytT3Et9g44q/7pV5QhhZ/7v8uUpvS7dcD5R2ovx/hygqf0lz2X81X/i
         GnZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=EUxpZ3T7vF3Kc+2RT08v4EEjAUSgYRvb0sha4nlMD8s=;
        b=d1Jh56jHtTKNm6RfBqwgjaCBUgl7S40z1Byqq3/eCqY8AysTOlmXzPLCDt/llzOqIy
         IrI5LIg/uj9uNaBpWaKDxizP2LP2ssncTSTfZQyc2dhdOcS2xjZftafCxvrVkpOba+4r
         LsT9BS8jc39EMoN4KUtGqf15m5M+kjfHJ9BmEEVBKcTIc6j8+w3p9P8wy45SP9EcmlWH
         PLajEGb8C8pIldGNEe/0fhcnf7SbK0JZphitmMtLXr+AQ3JZEpAw60E3Y/N9OLqLsEQx
         Z+n0NiI6FrPZzFi4eTa2Ew92H+U6WOTwHEWocmeTQ+omC1944mqsNHyPh3VEPS5DAmrq
         ITMg==
X-Gm-Message-State: APjAAAWMWlpmKpX68qmIuYadE+uJ6E82ykXAsut4bm+p+d65SiRZ2kYD
        R2vNKQuFHewm4vVt9cl/58PojRftCT3sWZA6rD8oORPwcWRc52++3JSTlGTH/v3RkK+P+rLCQuG
        acRN9pebzqS2dwtnR7Eddo2oRe9JS
X-Received: by 2002:a5d:8b8b:: with SMTP id p11mr6820748iol.2.1571374026858;
        Thu, 17 Oct 2019 21:47:06 -0700 (PDT)
X-Google-Smtp-Source: APXvYqzRFDJCsdCcPC5eb4L2SDx6043c6Gt8bq+dQz12A8oxvmQA4iLvhp+dkRZ6xTeypxz8f1Vy/g==
X-Received: by 2002:a5d:8b8b:: with SMTP id p11mr6820730iol.2.1571374026580;
        Thu, 17 Oct 2019 21:47:06 -0700 (PDT)
Received: from bee.dtc.umn.edu (cs-bee-u.cs.umn.edu. [128.101.106.63])
        by smtp.gmail.com with ESMTPSA id j2sm1968315ile.24.2019.10.17.21.47.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Oct 2019 21:47:05 -0700 (PDT)
From:   Kangjie Lu <kjlu@umn.edu>
To:     kjlu@umn.edu
Cc:     Ramesh Shanmugasundaram <ramesh.shanmugasundaram@bp.renesas.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        linux-media@vger.kernel.org, linux-renesas-soc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] media: rcar_drif: fix a memory disclosure
Date:   Thu, 17 Oct 2019 23:47:00 -0500
Message-Id: <20191018044701.4786-1-kjlu@umn.edu>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

"f->fmt.sdr.reserved" is uninitialized. As other peer drivers
like msi2500 and airspy do, the fix initializes it to avoid
memory disclosures.

Signed-off-by: Kangjie Lu <kjlu@umn.edu>
---
 drivers/media/platform/rcar_drif.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/media/platform/rcar_drif.c b/drivers/media/platform/rcar_drif.c
index 608e5217ccd5..0f267a237b42 100644
--- a/drivers/media/platform/rcar_drif.c
+++ b/drivers/media/platform/rcar_drif.c
@@ -912,6 +912,7 @@ static int rcar_drif_g_fmt_sdr_cap(struct file *file, void *priv,
 {
 	struct rcar_drif_sdr *sdr = video_drvdata(file);
 
+	memset(f->fmt.sdr.reserved, 0, sizeof(f->fmt.sdr.reserved));
 	f->fmt.sdr.pixelformat = sdr->fmt->pixelformat;
 	f->fmt.sdr.buffersize = sdr->fmt->buffersize;
 
-- 
2.17.1


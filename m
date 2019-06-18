Return-Path: <SRS0=h0iA=UR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 21F8BC31E5B
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Jun 2019 17:33:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EE118205F4
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Jun 2019 17:33:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nP9AQBSF"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729963AbfFRRdM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Jun 2019 13:33:12 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:41983 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728572AbfFRRdM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Jun 2019 13:33:12 -0400
Received: by mail-pg1-f194.google.com with SMTP id 83so8050290pgg.8
        for <linux-kernel@vger.kernel.org>; Tue, 18 Jun 2019 10:33:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=+2YaykVn++bx3Y+KHfNzRgksUkYd1b1acyBCPmK1ESg=;
        b=nP9AQBSFgnWkiOmTl5JuSjlUIjru21cKetedkVCknU4uibtUwP8x3JBiF+KIaUmF9i
         MWD6RVEFFdb5jDE+htDOk8e6og5Zmse54tZaqA8IHb4BFz3VlJoFyi0tzcaU2my3XO4D
         Gfu4u3ZklbxntrED5I0pvVQYoARSj3MScZpEQre325s9DLcXh8SUSy16XAn9rvKRTABh
         m4cElPAUa+T0t5p4uMGhErlTMBjHfgVBt/BR5tOQKiTFW+WcvZQHy1LtaUwUZcfnpEPi
         THeUpF3Eelz+9+3p7Mp76VSdJ3fdhTLBJccKS+bHNy8upBr+MOJZHKLr+pyMyafTO/Ak
         r6ow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=+2YaykVn++bx3Y+KHfNzRgksUkYd1b1acyBCPmK1ESg=;
        b=ucflYMxl3Vh5Vt6Vd0JBejkrkgMV6kIY0wNWrf9rYIwQ7h4J6HU+vj03IHlQxr4pVJ
         VVHotsxXNrlZY4ScGy1EThs2urUCYHoE3qevT6jgw2H2kGzfVs+c7lFOUcgKc0ctvDJ6
         /FgyawltW2/VdCdBa06WDadBLG5hlRxIrrvIqt8rgPFyPJeeq9U3ZKmtECDJCTMjh1Jw
         zVD1WzHkIfiu1KhvPz2jdjat24bx7ykG8lnMAcH9hxijZFqEzHaS/hcRpXlJXDhqZNWL
         iowgeg+pfjcAK7XT4wAgxZndNIOAyF/vCR7ZJaesQZdNEh4qZ8Nj9uuynALv68PlZ1LK
         oQQQ==
X-Gm-Message-State: APjAAAWhcnOUQdOkAwrVy0kjCu05oxofGfMWmQDkQbsAsARewK4tv4Qe
        NE2lCWREIWvbE7DIBJ68+Cg=
X-Google-Smtp-Source: APXvYqyBsqmtBMnp7Z7YAXsHQY8QimuRAZp2vUDpUXc0RAHt+cIJtpblpYxaO3236O5oZKHs9zp0yA==
X-Received: by 2002:a62:8643:: with SMTP id x64mr87048095pfd.7.1560879191390;
        Tue, 18 Jun 2019 10:33:11 -0700 (PDT)
Received: from hari-Inspiron-1545 ([183.83.92.187])
        by smtp.gmail.com with ESMTPSA id 14sm17529219pfj.36.2019.06.18.10.33.07
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 18 Jun 2019 10:33:10 -0700 (PDT)
Date:   Tue, 18 Jun 2019 23:03:05 +0530
From:   Hariprasad Kelam <hariprasad.kelam@gmail.com>
To:     Larry Finger <Larry.Finger@lwfinger.net>,
        Florian Schilhabel <florian.c.schilhabel@googlemail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Julia Lawall <julia.lawall@lip6.fr>,
        Michael Straube <straube.linux@gmail.com>,
        Hariprasad Kelam <hariprasad.kelam@gmail.com>,
        Dafna Hirschfeld <dafna3@gmail.com>,
        devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org
Subject: [PATCH] staging: rtl8712: rtl87x_io : make use of kzalloc
Message-ID: <20190618173305.GA4776@hari-Inspiron-1545>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

kmalloc followed by memset can be replaced with kzalloc.

Signed-off-by: Hariprasad Kelam <hariprasad.kelam@gmail.com>
---
 drivers/staging/rtl8712/rtl871x_io.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/staging/rtl8712/rtl871x_io.c b/drivers/staging/rtl8712/rtl871x_io.c
index 17dafef..87024d6 100644
--- a/drivers/staging/rtl8712/rtl871x_io.c
+++ b/drivers/staging/rtl8712/rtl871x_io.c
@@ -107,13 +107,11 @@ uint r8712_alloc_io_queue(struct _adapter *adapter)
 	INIT_LIST_HEAD(&pio_queue->processing);
 	INIT_LIST_HEAD(&pio_queue->pending);
 	spin_lock_init(&pio_queue->lock);
-	pio_queue->pallocated_free_ioreqs_buf = kmalloc(NUM_IOREQ *
+	pio_queue->pallocated_free_ioreqs_buf = kzalloc(NUM_IOREQ *
 						(sizeof(struct io_req)) + 4,
 						GFP_ATOMIC);
 	if ((pio_queue->pallocated_free_ioreqs_buf) == NULL)
 		goto alloc_io_queue_fail;
-	memset(pio_queue->pallocated_free_ioreqs_buf, 0,
-			(NUM_IOREQ * (sizeof(struct io_req)) + 4));
 	pio_queue->free_ioreqs_buf = pio_queue->pallocated_free_ioreqs_buf + 4
 			- ((addr_t)(pio_queue->pallocated_free_ioreqs_buf)
 			& 3);
-- 
2.7.4


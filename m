Return-Path: <SRS0=bFUY=XM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E9CA4C49ED7
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Sep 2019 02:41:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B4E2420678
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Sep 2019 02:41:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gqEihpAo"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391858AbfIQCl5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 16 Sep 2019 22:41:57 -0400
Received: from mail-io1-f68.google.com ([209.85.166.68]:37826 "EHLO
        mail-io1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728470AbfIQCl5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Sep 2019 22:41:57 -0400
Received: by mail-io1-f68.google.com with SMTP id b19so3979933iob.4
        for <linux-kernel@vger.kernel.org>; Mon, 16 Sep 2019 19:41:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=ss7NWhljJYCkM9LFwXECsWgnSJXgTz+aKfYf6bs657s=;
        b=gqEihpAoxO+fPlD5ckhmMq29Dph4wQduoUWvxbRRK7TxoKEryBNHBX7st3hyzofkan
         WHXyUfelGrrlUGdV4oI3LwRTHJ2hh8lbUbzwA11Byr2AUuBWafthilX6kQ3BPEkCfLL2
         ZXijasVIrd7kJlfsbAHWTOcMa01nTfIbFLQIFsYynQbpMiYJIdE+W3UyS3ANbDzJl6ce
         3yZmIspuapr/QpT03rHoRt5+Fv/m5oXuRXqmQrVx/L+n+af1AjmXwtaDifEXlLcbbTu1
         2LXbacHTi/HHcHoUeMXOwAxn7Jx18xlDDIremUTgqs4kktTnALXJgfUFmNNoyeXfN4m4
         p/Gw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=ss7NWhljJYCkM9LFwXECsWgnSJXgTz+aKfYf6bs657s=;
        b=MKnpd9o0brFMz7wfo7oYsBmuNQEJ8J+apK33tejwkS9vfEwgoxSvCM7kqoUpyEZMez
         78Ht5wY+QgnRIA6oqCOL6M2yz7ORV9FCJqEbL6Fj2qSHaJob1LO6ER2e9bpOPptzi+B7
         tCnGJP141rEC9pjstHqBI6NGURvZrMxf4KKmV46IrMr/NQz2qgdeEDAVHDBbrPVMv7el
         VkoNU9QpbWgXsMXho3waH62rya9JNptgT71uAwn9MuOeGlmtuUWrLsEXdVP9zYr1nde4
         uz7ZlWqWKzltJaywNV8owE9nMv+i1fpyVZvkIVPm+3cb34zGAL0J1NxnCnFYyk9pC6N1
         rpLg==
X-Gm-Message-State: APjAAAVXmghFKnSh+5xRiE02wBMYHNPczpqfC2LuN6+7DoqHVEDd2GlM
        xQOsfyc1tCj3d0tH9puZwp4=
X-Google-Smtp-Source: APXvYqy74GjJuYyEd6PdtWT6m1Q6F/eY8ON7hlzdfpbCCh5rYV0cZV20BUFdrQ4nUqBAfhgKESnxjQ==
X-Received: by 2002:a05:6638:1f2:: with SMTP id t18mr1571972jaq.67.1568688116532;
        Mon, 16 Sep 2019 19:41:56 -0700 (PDT)
Received: from cs-dulles.cs.umn.edu (cs-dulles.cs.umn.edu. [128.101.35.54])
        by smtp.googlemail.com with ESMTPSA id l19sm618065iok.14.2019.09.16.19.41.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Sep 2019 19:41:55 -0700 (PDT)
From:   Navid Emamdoost <navid.emamdoost@gmail.com>
Cc:     emamd001@umn.edu, smccaman@umn.edu, kjlu@umn.edu,
        Navid Emamdoost <navid.emamdoost@gmail.com>,
        Ian Abbott <abbotti@mev.co.uk>,
        H Hartley Sweeten <hsweeten@visionengravers.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org
Subject: [PATCH] staging: comedi: drivers: prevent memory leak
Date:   Mon, 16 Sep 2019 21:41:43 -0500
Message-Id: <20190917024147.26290-1-navid.emamdoost@gmail.com>
X-Mailer: git-send-email 2.17.1
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In das1800_attach, the buffer allocated via kmalloc_array needs to be
released if an error happens.

Signed-off-by: Navid Emamdoost <navid.emamdoost@gmail.com>
---
 drivers/staging/comedi/drivers/das1800.c | 12 +++++++++---
 1 file changed, 9 insertions(+), 3 deletions(-)

diff --git a/drivers/staging/comedi/drivers/das1800.c b/drivers/staging/comedi/drivers/das1800.c
index f16aa7e9f4f3..5f2d5f7a6229 100644
--- a/drivers/staging/comedi/drivers/das1800.c
+++ b/drivers/staging/comedi/drivers/das1800.c
@@ -1237,12 +1237,16 @@ static int das1800_attach(struct comedi_device *dev,
 
 	dev->pacer = comedi_8254_init(dev->iobase + DAS1800_COUNTER,
 				      I8254_OSC_BASE_5MHZ, I8254_IO8, 0);
-	if (!dev->pacer)
+	if (!dev->pacer) {
+		kfree(devpriv->fifo_buf);
 		return -ENOMEM;
+	}
 
 	ret = comedi_alloc_subdevices(dev, 4);
-	if (ret)
+	if (ret) {
+		kfree(devpriv->fifo_buf);
 		return ret;
+	}
 
 	/*
 	 * Analog Input subdevice
@@ -1290,8 +1294,10 @@ static int das1800_attach(struct comedi_device *dev,
 		s->insn_write	= das1800_ao_insn_write;
 
 		ret = comedi_alloc_subdev_readback(s);
-		if (ret)
+		if (ret) {
+			kfree(devpriv->fifo_buf);
 			return ret;
+		}
 
 		/* initialize all channels to 0V */
 		for (i = 0; i < s->n_chan; i++) {
-- 
2.17.1


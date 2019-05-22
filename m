Return-Path: <SRS0=sxVn=TW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 648B1C072B5
	for <linux-kernel@archiver.kernel.org>; Wed, 22 May 2019 01:40:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3863A21479
	for <linux-kernel@archiver.kernel.org>; Wed, 22 May 2019 01:40:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lV5LVIby"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728127AbfEVBkU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 21 May 2019 21:40:20 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:42331 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726466AbfEVBkU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 May 2019 21:40:20 -0400
Received: by mail-pf1-f193.google.com with SMTP id 13so396909pfw.9
        for <linux-kernel@vger.kernel.org>; Tue, 21 May 2019 18:40:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=5CBN5GRDwJJmiW4ujQ4j8MkE9ryYC+5kRL/X54PqKsM=;
        b=lV5LVIbyNnZqNs7lWVt3EsuiM1CcKliXdywv9AQ2JP1Ooeo7y6Ch+a4SKUQi3ScZO2
         gVUiHVvPmE8qo1KCzwZ+HGYLD49l/D6LRsJxWXTV6LO8Xi7O+v69ycAM/rC26vSQB9zl
         GzmUiX70pAaaMyv6DfZFOH8KY+sosNAkt9VoVZ0UU2pp89xfc3YA+HwQiO9Ccfs6RUYH
         msUpV1ZcsHElT5ps25TSwbm3hzYkjTyEcrazrxGWRfT+StS1pyCN+BvJ+Shm/AdVCvch
         n3/adOj7kg2nmgAkdGaQxgH0zogSrTE3kv0dck3MwmW8kUgGD6RAAn2aYBsXFpC1fQp4
         ndgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=5CBN5GRDwJJmiW4ujQ4j8MkE9ryYC+5kRL/X54PqKsM=;
        b=cFH442UPe1o3pvubzhXCV52ddCGC5TjOe8HPYb2giVhJD8bY98ChXP693ckqQShTAF
         CwuewaqMaH4X9359ktQdiC/9DVO4Ci2uDkjL//a1c6Rlrt/DKtmFPnCZ87KcPtvAo3nw
         ZFPW0v1G/Jc8VYNuRXJm+ncgsIhfVnlYZU/q3EEiCOLsqGPhbIkrviXQ6dppEp9WugUX
         sg15aef36L/iGkSvM+yrv4far4RKuEhOzKnrbuPfmtXEBqyZ5VTg3CwyPXt/IDdB5aXd
         yMsnMlpfQDTzorQS3F31OzzLDXpcbkmReeTffGPUJ9onzyVI5K+ItGlztfNpjPoAIP37
         Jwsg==
X-Gm-Message-State: APjAAAXDZebNf2ZbkTI6JvnpdhMfYKvwF61Y/+PWuqTHzp+hE/PgdNoK
        BoC2EhlyVn4w/peCWiKQ0cW2Rohzgkw=
X-Google-Smtp-Source: APXvYqz9ixSRIE/gHn86++ZNZ+N8dqc0ilrj19blcxSExgRKNnaGL8090v85Ragbt14x5gwPT8YIDw==
X-Received: by 2002:a63:8bc9:: with SMTP id j192mr86339409pge.212.1558489219565;
        Tue, 21 May 2019 18:40:19 -0700 (PDT)
Received: from zhanggen-UX430UQ ([66.42.35.75])
        by smtp.gmail.com with ESMTPSA id f186sm31952144pfb.5.2019.05.21.18.40.17
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 21 May 2019 18:40:19 -0700 (PDT)
Date:   Wed, 22 May 2019 09:40:06 +0800
From:   Gen Zhang <blackgod016574@gmail.com>
To:     jslaby@suse.com
Cc:     linux-kernel@vger.kernel.org
Subject: [PATCH] tty_io: Fix a missing-check bug in drivers/tty/tty_io.c
Message-ID: <20190522014006.GB4093@zhanggen-UX430UQ>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In alloc_tty_struct(), tty->dev is assigned by tty_get_device(). And it
calls class_find_device(). And class_find_device() may return NULL.
And tty->dev is dereferenced in the following codes. When 
tty_get_device() returns NULL, dereferencing this tty->dev null pointer
may cause the kernel go wrong. Thus we should check tty->dev.
Further, if tty_get_device() returns NULL, we should free tty and 
return NULL.

Signed-off-by: Gen Zhang <blackgod016574@gmail.com>

---
diff --git a/drivers/tty/tty_io.c b/drivers/tty/tty_io.c
index 033ac7e..1444b59 100644
--- a/drivers/tty/tty_io.c
+++ b/drivers/tty/tty_io.c
@@ -3008,6 +3008,10 @@ struct tty_struct *alloc_tty_struct(struct tty_driver *driver, int idx)
 	tty->index = idx;
 	tty_line_name(driver, idx, tty->name);
 	tty->dev = tty_get_device(tty);
+	if (!tty->dev) {
+		kfree(tty);
+		return NULL;
+	}
 
 	return tty;
 }

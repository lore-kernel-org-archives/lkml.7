Return-Path: <SRS0=n7Fw=UL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B5540C31E46
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Jun 2019 13:15:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 893DA20874
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Jun 2019 13:15:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LWspt71x"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729216AbfFLNPS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Jun 2019 09:15:18 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:55177 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727102AbfFLNPS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Jun 2019 09:15:18 -0400
Received: by mail-wm1-f66.google.com with SMTP id g135so6546641wme.4
        for <linux-kernel@vger.kernel.org>; Wed, 12 Jun 2019 06:15:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=S7gYL9MQAqJJl42POKnYTZhA1fNy6NXQksgxdieePNA=;
        b=LWspt71xGTH7IU6YaesxzKNTXMxJrT5V08RvFUpfFnryMaqw+T/Db3y6fqI2+Naid6
         310c3UzFccv9bwithR8Oo9kjjfngvUMiW7vOs3NNcunBkW7ZCq0YDBbBuPoO+OUiOsYu
         zB33EA4oa2t3FlBFBg2RvzGoro0GsAd0ufZQJqcghPef7E9Ja+0VrMYmPEBsuCVHYbq3
         wyfkzdp3BQtVpE97oWNSR5cz/CsLfkNr6xi7RYwnPaGrkt9TskRD9+XS4eTqHcEZFNGN
         0tZylGo5SuJQG6D06xk79TGAF2dwvxQmdBHfpjCd0lO8ZK0RnRn+jrdzJCsWZAsz2Tyr
         UYDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=S7gYL9MQAqJJl42POKnYTZhA1fNy6NXQksgxdieePNA=;
        b=VEXGcoReWCp63cY/XbIEPlxx1DVRyhIzgfgc3EKjpyJljUM0bcqTSB8pRyE29gFbLG
         d2R5n5TaKFrWCnwpqsCtlNLgLwYrSX12k1z7idOI5NjxVJoXBn83QAlNeMQ+CpNLOe7x
         9ybHdyItSfmyzW/DRnvyR4b6LGJWqN1xolykUHdUDJNunbTh5283dXHJQMX89kBlKIQF
         Zjgsyd+ZtXfRag4B9EPf0KEXok1SJWzYpJnHHGQIOfSbjTyVFjmVZGsVoO13Wkb9avQi
         /UAddSV/QOWH9L/lC1TWqEWcwFN5LUtFpUzmINBA593T0Z6HLWD7x0qzx50+d4THw+sX
         XCOg==
X-Gm-Message-State: APjAAAWQNqWKqthJjBjKchyTVd60TpVkaUx3yThQ3t1HifwtwoTeiOuW
        zer+cW8+Cg/lfGwOmvSa8BQ=
X-Google-Smtp-Source: APXvYqyEP13n7RdpO5eBZFd0ZdefsiZ1UibvDNuyKXI+3BnwsBfUlnzCL98lEmQTW3xT9KlNeiiYdQ==
X-Received: by 2002:a1c:ef10:: with SMTP id n16mr20120978wmh.134.1560345316503;
        Wed, 12 Jun 2019 06:15:16 -0700 (PDT)
Received: from zhanggen-UX430UQ ([108.61.173.19])
        by smtp.gmail.com with ESMTPSA id c4sm4640654wmf.43.2019.06.12.06.15.12
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 12 Jun 2019 06:15:15 -0700 (PDT)
Date:   Wed, 12 Jun 2019 21:15:06 +0800
From:   Gen Zhang <blackgod016574@gmail.com>
To:     gregkh@linuxfoundation.org, nico@fluxnic.net, kilobyte@angband.pl,
        textshell@uchuujin.de, mpatocka@redhat.com, daniel.vetter@ffwll.ch
Cc:     linux-kernel@vger.kernel.org
Subject: [PATCH v4] vt: fix a missing-check bug in con_init()
Message-ID: <20190612131506.GA3526@zhanggen-UX430UQ>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In function con_init(), the pointer variable vc_cons[currcons].d, vc and 
vc->vc_screenbuf is allocated by kzalloc(). However, kzalloc() returns 
NULL when fails. Therefore, we should check the return value and handle 
the error.

Signed-off-by: Gen Zhang <blackgod016574@gmail.com>
---
diff --git a/drivers/tty/vt/vt.c b/drivers/tty/vt/vt.c
index 5c0ca1c..dc40e29 100644
--- a/drivers/tty/vt/vt.c
+++ b/drivers/tty/vt/vt.c
@@ -3357,10 +3357,14 @@ static int __init con_init(void)
 
 	for (currcons = 0; currcons < MIN_NR_CONSOLES; currcons++) {
 		vc_cons[currcons].d = vc = kzalloc(sizeof(struct vc_data), GFP_NOWAIT);
+		if (!vc)
+			goto vc_err;
 		INIT_WORK(&vc_cons[currcons].SAK_work, vc_SAK);
 		tty_port_init(&vc->port);
 		visual_init(vc, currcons, 1);
 		vc->vc_screenbuf = kzalloc(vc->vc_screenbuf_size, GFP_NOWAIT);
+		if (!vc->vc_screenbuf)
+			goto vc_screenbuf_err;
 		vc_init(vc, vc->vc_rows, vc->vc_cols,
 			currcons || !vc->vc_sw->con_save_screen);
 	}
@@ -3382,6 +3386,16 @@ static int __init con_init(void)
 	register_console(&vt_console_driver);
 #endif
 	return 0;
+vc_err:
+	while (currcons > 0) {
+		currcons--;
+		kfree(vc_cons[currcons].d->vc_screenbuf);
+vc_screenbuf_err:
+		kfree(vc_cons[currcons].d);
+		vc_cons[currcons].d = NULL;
+	}
+	console_unlock();
+	return -ENOMEM;
 }
 console_initcall(con_init);
 

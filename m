Return-Path: <SRS0=5wok=UM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 810D2C31E45
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Jun 2019 18:08:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 599FE2082C
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Jun 2019 18:08:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lkNSco6W"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727673AbfFMSIt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Jun 2019 14:08:49 -0400
Received: from mail-qk1-f194.google.com ([209.85.222.194]:46599 "EHLO
        mail-qk1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725889AbfFMSIs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Jun 2019 14:08:48 -0400
Received: by mail-qk1-f194.google.com with SMTP id x18so1376526qkn.13;
        Thu, 13 Jun 2019 11:08:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition
         :content-transfer-encoding:user-agent;
        bh=3kGjncHEa+1hj8pVAS2QYJhy10HRs8gc3k/Mu4YAYEg=;
        b=lkNSco6WLsjp43FwYMm4Ybw+cVp9vAjQKA9v0sBeoL+GEIZmKlLOUg0kuemw7Jmwnk
         hqASHRofr3/aswXFG6GcmrLnHI+XmH+uD7z9lky3e6YBzdo16WIrDROCnIQKs01yP6cZ
         rfQqG9qpkBNJEw5oLAOCoihsEtg4zbny0KI+XhJZFL04enpZX9uQFMr8i62HxAJ+SqyL
         X59UnmMBbDWJKfQS6KvqUtfqM+yWXIbQj4EQwt+kqPacd/ZcAYtXbBFrbHuLycRjMGqW
         mpWQeZosmyTY2BCkM0d3VnMXAPMZDGIbMppxlNUJDg5JSXvE0efblabbgE/TLtMHSc8R
         YXPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:content-transfer-encoding:user-agent;
        bh=3kGjncHEa+1hj8pVAS2QYJhy10HRs8gc3k/Mu4YAYEg=;
        b=Ga/OagyTCyrr+vF/1YQOilbfnPXv357A+z1u71So2pTo66XshfZD18u0+qSsacKyxD
         s7Su/6HBNCREzBT527WG3lG15nOacuPTdE4zAFjb1fk7WH2iR9juAiYCx8ZcjpD6DL2u
         6B+fJY9G0bT0cKJ255IsIE/SZhDwxYzObHkgtsHBvENdxjzp620pFl4OC1UNGS7ordl/
         TOBC2aOwxGtEDbM1FG/2D82RWpru5z62O+wW8x6wuGohXX7uITREkBUgjPmp20mMqKxS
         4PInkcnS8SPgjFZoc1jSSQSH5KHuCv8OzdBbUeGHDZv+gEbMOo0LBl84AXJLH9Q8NA9r
         Bj3w==
X-Gm-Message-State: APjAAAWnsCy3fZR0PiRVEIIUFqBuPbw2urJzmxGtUoaCDwvmwqLvTOOw
        vfqVCtEEp/5YsaQSqOWQqGAa2jkIbLk=
X-Google-Smtp-Source: APXvYqz41cfju1M/g0EwYpoFHIiePcXL5EERaXHOXgIKNujb3IGt0NI6B0aKHjMxAPOLogePob4TsA==
X-Received: by 2002:a37:a10b:: with SMTP id k11mr74414123qke.76.1560449327548;
        Thu, 13 Jun 2019 11:08:47 -0700 (PDT)
Received: from debie ([2804:431:f704:c7eb:af:a4f9:dcbb:96b3])
        by smtp.gmail.com with ESMTPSA id l88sm136719qte.33.2019.06.13.11.08.45
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 13 Jun 2019 11:08:47 -0700 (PDT)
Date:   Thu, 13 Jun 2019 15:08:24 -0300
From:   Charles <18oliveira.charles@gmail.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jslaby@suse.com>
Cc:     linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org,
        rodrigosiqueiramelo@gmail.com
Subject: [PATCH] serial: sh-sci: fix uninitialized variable warning
Message-ID: <20190613180824.6ajwjelzr5fmjnie@debie>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Avoid following compiler warning on uninitialized variable

In file included from ./include/linux/rwsem.h:16:0,
                 from ./include/linux/notifier.h:15,
                 from ./include/linux/clk.h:17,
                 from drivers/tty/serial/sh-sci.c:24:
drivers/tty/serial/sh-sci.c: In function ‘sci_dma_rx_submit’:
./include/linux/spinlock.h:288:3: warning: ‘flags’ may be used
uninitialized in this function [-Wmaybe-uninitialized]
   _raw_spin_unlock_irqrestore(lock, flags); \
   ^~~~~~~~~~~~~~~~~~~~~~~~~~~
drivers/tty/serial/sh-sci.c:1353:16: note: ‘flags’ was declared here
  unsigned long flags;
                ^~~~~

Signed-off-by: Charles Oliveira <18oliveira.charles@gmail.com>
---
 drivers/tty/serial/sh-sci.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/tty/serial/sh-sci.c b/drivers/tty/serial/sh-sci.c
index abc705716aa0..a6af73eaec11 100644
--- a/drivers/tty/serial/sh-sci.c
+++ b/drivers/tty/serial/sh-sci.c
@@ -1350,7 +1350,7 @@ static int sci_dma_rx_submit(struct sci_port *s, bool port_lock_held)
 {
 	struct dma_chan *chan = s->chan_rx;
 	struct uart_port *port = &s->port;
-	unsigned long flags;
+	unsigned long uninitialized_var(flags);
 	int i;
 
 	for (i = 0; i < 2; i++) {
-- 
2.11.0


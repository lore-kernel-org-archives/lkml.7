Return-Path: <SRS0=HfRD=XN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 84DA6C4CEC9
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Sep 2019 07:52:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 492772067B
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Sep 2019 07:52:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aFvEYfUY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727945AbfIRHw6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 18 Sep 2019 03:52:58 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:33980 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726884AbfIRHw5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Sep 2019 03:52:57 -0400
Received: by mail-pg1-f196.google.com with SMTP id n9so3543709pgc.1
        for <linux-kernel@vger.kernel.org>; Wed, 18 Sep 2019 00:52:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=OFMv8oG+xJl0s95XIt476Zcp61WCeqOs8Ct7pjgyi68=;
        b=aFvEYfUYio4tPj+X7kT6bGV8+iyV0Uvifo5KNU2axYnLrD0m9LtN5QEIFkmFkmkzwE
         iUO9icTCgUjDtXDnkAEzwTym3CSZu27psiw3VNGPoDCWEVwiJgXwyyuRJYw/76U72LNn
         78t70xpcd9QvJ9Rd654ovKwEJ7htD8Dz1f5fONi8miO4OwQCBuwfgAPXohH9u5HLyV5/
         LVwQ9BrTovL2pz+w57dInU7qkMk/ftvtCYtYpzWVribB/uMMcHktQB53znp8nPSvZSj6
         qEnd/+10vRYKXmeoE2P+LI1Iyu+4azI/IUYxJHdSd4HNAmqT0i8mH47GMh813WejrjgN
         X89g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=OFMv8oG+xJl0s95XIt476Zcp61WCeqOs8Ct7pjgyi68=;
        b=qOHfXr0WS+jQxArZDjL3QBJf/7MKEagJGQwQgbDCYc2vTjIG5GUGWSaNpROJlGGa26
         vimZurv6MxwEyYCMJrm/KuiF17gNshtcbyrFupme+qMjAu4hmiVOaEB7gpPAdJ3JBfB/
         EDqAHZqPlcordiUcN3Km71KoAY5YKAYUs/r359pAbWrDyUaafqa/TgqBf6mmrB77WOP+
         GxN/YO9rJ182olky2HLi2z2T0SrCRAjUwa0y9zagQHvekwVny6jWCWBDae62NQF6kdZE
         Pt7r2FCIuyIFACLLi1Jn1GAxnaA4tCyD9psz0Ntl/1RrSiW9mQoZJ/IMY1B9F0wKvuId
         DWAQ==
X-Gm-Message-State: APjAAAVlSbk8IGY4kHt1743x74pDuhyP36gHy0oOCRCf5bzM2u7Ytrox
        GrgN158IexuHqaPCAV1ZkeE=
X-Google-Smtp-Source: APXvYqwNSvkvi00utyumD/MjvVes92Mt/igV7T/qNfaQ3EPXt/7ihqTDVHTrfEZRWYydsZ5gi4v8JQ==
X-Received: by 2002:a63:205:: with SMTP id 5mr2667437pgc.77.1568793176897;
        Wed, 18 Sep 2019 00:52:56 -0700 (PDT)
Received: from localhost ([175.223.34.14])
        by smtp.gmail.com with ESMTPSA id v68sm6772440pfv.47.2019.09.18.00.52.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Sep 2019 00:52:55 -0700 (PDT)
Date:   Wed, 18 Sep 2019 16:52:52 +0900
From:   Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>
To:     Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= 
        <u.kleine-koenig@pengutronix.de>
Cc:     Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>,
        Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>,
        Steven Rostedt <rostedt@goodmis.org>,
        Petr Mladek <pmladek@suse.com>, linux-kernel@vger.kernel.org,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>
Subject: Re: Regression in dbdda842fe96 ("printk: Add console owner and
 waiter logic to load balance console writes") [Was: Regression in
 fd5f7cde1b85 ("...")]
Message-ID: <20190918075252.GA30808@jagdpanzerIV>
References: <20190917141034.gvjg7bgylqbbxyv7@pengutronix.de>
 <20190918013032.GA2895@jagdpanzerIV>
 <20190918071158.rtw45jch2roa2wum@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20190918071158.rtw45jch2roa2wum@pengutronix.de>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On (09/18/19 09:11), Uwe Kleine-König wrote:
> I rechecked and indeed fd5f7cde1b85's parent has the problem, too, so I
> did a mistake during my bisection :-|
> 
> Redoing the bisection (a bit quicker this time) points to
> 
> dbdda842fe96 ("printk: Add console owner and waiter logic to load balance console writes")
> 
> Sorry for the confusion.

No worries!

[..]
> > So I'd say that lockdep is correct, but there are several hacks which
> > prevent actual deadlock.
> 
> Just to make sure, I got you right: With the way lockdep works it is
> right to assume there is a problem, but in fact there isn't?

I'd probably say so... Unless I'm missing something.

sysrq-over-serial is handled from the serial driver's IRQ handler,
under serial driver's port->lock. sysrq handling calls printk(), which
takes console_sem/owner and re-enters the serial driver via ->write()
callback.

So lockdep sees a reverse locking pattern: port->lock goes before
console_sem/owner, which is not the usual order.

> This is IMHO unfortunate because such false positives reduces the
> usefulness of lockdep considerably. :-|

I agree.

port->sysrq state is global to uart port. IOW, if CPUA sets port->sysrq
then all printk->write() paths (from any other CPU) become lockless.

This makes me wonder is we really need to hold port->lock for
uart_handle_sysrq_char(). I sort of doubt it...

Can you try the following patch? It's against linux-next, I guess
you can backport to your kernel.

The basic idea is to handle sysrq out of port->lock.

I didn't test it all (not even sure if it compiles).

---
 drivers/tty/serial/imx.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/tty/serial/imx.c b/drivers/tty/serial/imx.c
index 87c58f9f6390..f0dd807b52df 100644
--- a/drivers/tty/serial/imx.c
+++ b/drivers/tty/serial/imx.c
@@ -731,9 +731,9 @@ static irqreturn_t imx_uart_rxint(int irq, void *dev_id)
 	struct imx_port *sport = dev_id;
 	unsigned int rx, flg, ignored = 0;
 	struct tty_port *port = &sport->port.state->port;
+	unsigned long flags;
 
-	spin_lock(&sport->port.lock);
-
+	uart_port_lock_irqsave(&sport->port, flags);
 	while (imx_uart_readl(sport, USR2) & USR2_RDR) {
 		u32 usr2;
 
@@ -749,8 +749,8 @@ static irqreturn_t imx_uart_rxint(int irq, void *dev_id)
 				continue;
 		}
 
-		if (uart_handle_sysrq_char(&sport->port, (unsigned char)rx))
-			continue;
+		if (uart_prepare_sysrq_char(&sport->port, (unsigned char)rx))
+			break;
 
 		if (unlikely(rx & URXD_ERR)) {
 			if (rx & URXD_BRK)
@@ -792,7 +792,7 @@ static irqreturn_t imx_uart_rxint(int irq, void *dev_id)
 	}
 
 out:
-	spin_unlock(&sport->port.lock);
+	uart_unlock_and_check_sysrq(&sport->port, flags);
 	tty_flip_buffer_push(port);
 	return IRQ_HANDLED;
 }

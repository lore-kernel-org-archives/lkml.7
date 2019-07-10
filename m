Return-Path: <SRS0=5O2B=VH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 100E0C73C7C
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Jul 2019 08:39:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D83F920838
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Jul 2019 08:39:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dC0DVa8s"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727480AbfGJIjP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 10 Jul 2019 04:39:15 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:41674 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726580AbfGJIjO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Jul 2019 04:39:14 -0400
Received: by mail-pg1-f195.google.com with SMTP id q4so886418pgj.8
        for <linux-kernel@vger.kernel.org>; Wed, 10 Jul 2019 01:39:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=pDH7B9JV7C1+j8bzUPJzvYa8vHvqfsvMkQY40vMTT2E=;
        b=dC0DVa8s4uPMIerS3jEz1BoKBw9Nl4ribmnPxWuOOq11wDoawm3YV42F1mqzszbgCy
         +cBWmnqhUXAu2pDeXTF5I8ySWrO9MYrbuBUO5ycw9yZgVKq2FxI89np3e73XlVRrSPwV
         6lKocXINvBzk7ejy0cuSHEeKiIzTyWr64hPm1KbV62xbPRxa5iS746ZSRHgJpzswZM6I
         mm7ihAQGbZ7aTlq+rODGz59lNQLL7DW34oxNcNgn0ancvgOkF1M/zOcYgZB8C3ip3Ogj
         mvkLaiP3FYHTIb5uMdMrKLH6nmEk6vK+aiPzAIRC+wacaCKZv+0hOWJCNihubZJ3kmrI
         j7rw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=pDH7B9JV7C1+j8bzUPJzvYa8vHvqfsvMkQY40vMTT2E=;
        b=Q7WCP551/OQDL3RV9klI+7MDN5Ew01IMYGtX1D31fB0/EWjfg9esJ3tD2vxN7u8q9A
         QN805NghMxlw7gmawYE7sJ2WlPjmBKcgCKjzy8eh/6hrOv8mpCpE5uH675/n+knZsOzH
         CrIf6fx6E0G+gOJ9EHrCSXb4OlKMWjZNQVTgGz8RuypxfQOkcX1M6OMTl0N1ND26CAPa
         bJypoKdigWXOhVpaSVHpLICNR7td+WoPtdy92295S/FnNibgSnC7XjXKTY+N8UNnm2Ka
         V93PloEey6WdWzsbJc8xOg5MghQTBkdZ57hOTkeCyyu8QO15aotWleCEvGS/7uBTCz+8
         mz9w==
X-Gm-Message-State: APjAAAX9Q5IoStSN128f1S1uBgAHmmIuhgHiypnhAx3kQj3dODc3vubU
        +9JOls3h4VBE2b2VfdlyN2c=
X-Google-Smtp-Source: APXvYqxuuWrQGQ3skykQRgJy3oO9wNjs+SBZKkN00454vCcqyzatODq7nfB28gMCdJ2ZC5VyRcc9FQ==
X-Received: by 2002:a63:5202:: with SMTP id g2mr35631864pgb.386.1562747953881;
        Wed, 10 Jul 2019 01:39:13 -0700 (PDT)
Received: from localhost ([175.223.19.33])
        by smtp.gmail.com with ESMTPSA id i9sm1440760pgo.46.2019.07.10.01.39.12
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Wed, 10 Jul 2019 01:39:13 -0700 (PDT)
Date:   Wed, 10 Jul 2019 17:39:10 +0900
From:   Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>
To:     Petr Mladek <pmladek@suse.com>
Cc:     Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>,
        Vincent Whitchurch <vincent.whitchurch@axis.com>,
        Vincent Whitchurch <rabinv@axis.com>,
        sergey.senozhatsky@gmail.com, rostedt@goodmis.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] printk: Do not lose last line in kmsg dump
Message-ID: <20190710083910.GA12600@jagdpanzerIV>
References: <20190709081042.31551-1-vincent.whitchurch@axis.com>
 <20190709101230.GA16909@jagdpanzerIV>
 <20190709142939.luqhbd6x6bzdkydr@pathway.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190709142939.luqhbd6x6bzdkydr@pathway.suse.cz>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On (07/09/19 16:29), Petr Mladek wrote:
> 
> Anyway, if nobody vetoes the patch, I would schedule it for 5.4.
> We are already in the merge window and it deserves some testing
> in linux-next.
> 

I don't really want to veto it, but I'm not comfortable with fixing
off-by-one error by introducing another off-by-one error. The former
one leads to a missing message, the latter one to memory corruption.
Given that Vincent did find the code which does `buf[len] = 0x00'
[kudos to Vincent] let's have a better solution here. Otherwise, the
patch can make it to -stable via AUTOSEL machinery and then "we have
a problem".

Objections?

	-ss

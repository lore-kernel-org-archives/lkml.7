Return-Path: <SRS0=8QAT=T3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 649BDC04AB3
	for <linux-kernel@archiver.kernel.org>; Mon, 27 May 2019 21:33:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3799C20673
	for <linux-kernel@archiver.kernel.org>; Mon, 27 May 2019 21:33:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=networkplumber-org.20150623.gappssmtp.com header.i=@networkplumber-org.20150623.gappssmtp.com header.b="K66sq1g9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727470AbfE0Vdo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 27 May 2019 17:33:44 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:35439 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727148AbfE0Vdo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 May 2019 17:33:44 -0400
Received: by mail-pg1-f195.google.com with SMTP id t1so9671548pgc.2
        for <linux-kernel@vger.kernel.org>; Mon, 27 May 2019 14:33:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=networkplumber-org.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Oo+l5dqkenGdaWu5V62xv5Lwp20lmcm25QvuJlksiyg=;
        b=K66sq1g9D55mvXRtxUkh1xDtvyutqANxXOtarmXY0BgX/H8oQ+OxF7NOCR58HPxeIK
         ll6xospYcoEFnMvSU8rKEQ8xNr8z2fwS4AB2gNmtt5to/bhdUhm/tYKFK8zrZqklnkG1
         zE4d1OjyXokFdYIMkiCRW8Bx2y3TBOUqLcosxBtXDlotOWv83FvBN86p8WKpTgPTJgmZ
         yL46t4JVbkhsk3E/jsCJiHUiFULntMzvPYQn6xzabqpWQ5eJTTWQYzw+5WIS+yAAuhzJ
         ZfPAoTIpseLvqvNQd4BFcSy+x9eI9Az7wgW4lLLNi8/S6808H5+GH4r7Wy0X5bstAnql
         ob2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Oo+l5dqkenGdaWu5V62xv5Lwp20lmcm25QvuJlksiyg=;
        b=Tczb3fixvHEmG0CquFmylD4t6NbnmHYbM48Sry1zS5jeBSlQVJsR+mfebSKQNJ7cYl
         aT16G93cORuQLX5Z/P/wbzUAl4m3FAGrkthHrggq7itJpkrQXvHARu28rpsi+UFhKs4o
         YaHFNqaLAGw1Aht6OrOpYvf2WIBbci4cIjFr3ih3hJbrBZTw2qbL4RFC+XAEUEoXm2Ve
         L+RCNltjsj+omS1cg1I9FQog6PeKd88wY3w2BegEghAruw0KfZZuoxZ1phDo0SC9bE5G
         bL0Y178e5hx18AjX89u2Ln97mh9woDdP2erTXm35VjIyePJjJfsPyKvSuUnHwG2nKL+C
         owrw==
X-Gm-Message-State: APjAAAXr1GaSIY8aXBjRL+X6Iou9CmdmcOZNWcLDdZl5xl7afx/t0kW/
        8wSVqDATA2HGlgDvgVrwS3r9R7hXW0c=
X-Google-Smtp-Source: APXvYqy6VHSdG7D68oKgu2XolV7MZP2j5r1mc1V5yG8kO+OqfxWg9XXnKpOGkmf3/pf+vYeorF01FA==
X-Received: by 2002:a17:90a:cf12:: with SMTP id h18mr1035180pju.77.1558992823303;
        Mon, 27 May 2019 14:33:43 -0700 (PDT)
Received: from hermes.lan (204-195-22-127.wavecable.com. [204.195.22.127])
        by smtp.gmail.com with ESMTPSA id z6sm23727363pfr.135.2019.05.27.14.33.42
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 27 May 2019 14:33:43 -0700 (PDT)
Date:   Mon, 27 May 2019 14:33:41 -0700
From:   Stephen Hemminger <stephen@networkplumber.org>
To:     "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Cc:     "David S. Miller" <davem@davemloft.net>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next] macvlan: Replace strncpy() by strscpy()
Message-ID: <20190527143341.1dbc04c8@hermes.lan>
In-Reply-To: <e354f8c2-37d2-e76f-872f-853741f2a258@embeddedor.com>
References: <20190527183855.GA32553@embeddedor>
        <20190527142026.3a07831f@hermes.lan>
        <e354f8c2-37d2-e76f-872f-853741f2a258@embeddedor.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 27 May 2019 16:28:05 -0500
"Gustavo A. R. Silva" <gustavo@embeddedor.com> wrote:

> On 5/27/19 4:20 PM, Stephen Hemminger wrote:
> > On Mon, 27 May 2019 13:38:55 -0500
> > "Gustavo A. R. Silva" <gustavo@embeddedor.com> wrote:
> >   
> >> The strncpy() function is being deprecated. Replace it by the safer
> >> strscpy() and fix the following Coverity warning:
> >>
> >> "Calling strncpy with a maximum size argument of 16 bytes on destination
> >> array ifrr.ifr_ifrn.ifrn_name of size 16 bytes might leave the destination
> >> string unterminated."
> >>
> >> Notice that, unlike strncpy(), strscpy() always null-terminates the
> >> destination string.
> >>
> >> Addresses-Coverity-ID: 1445537 ("Buffer not null terminated")
> >> Signed-off-by: Gustavo A. R. Silva <gustavo@embeddedor.com>
> >> ---
> >>  drivers/net/macvlan.c | 2 +-
> >>  1 file changed, 1 insertion(+), 1 deletion(-)
> >>
> >> diff --git a/drivers/net/macvlan.c b/drivers/net/macvlan.c
> >> index 61550122b563..0ccabde8e9c9 100644
> >> --- a/drivers/net/macvlan.c
> >> +++ b/drivers/net/macvlan.c
> >> @@ -831,7 +831,7 @@ static int macvlan_do_ioctl(struct net_device *dev, struct ifreq *ifr, int cmd)
> >>  	struct ifreq ifrr;
> >>  	int err = -EOPNOTSUPP;
> >>  
> >> -	strncpy(ifrr.ifr_name, real_dev->name, IFNAMSIZ);
> >> +	strscpy(ifrr.ifr_name, real_dev->name, IFNAMSIZ);
> >>  	ifrr.ifr_ifru = ifr->ifr_ifru;
> >>  
> >>  	switch (cmd) {  
> > 
> > Why not use strlcpy like all the other places IFNAMSIZ is copied?
> >   
> 
> strlcpy() is also being deprecated.

Are you going to fix all these:
$ git grep strlcpy | grep IFNAMSIZ| wc -l
47

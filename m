Return-Path: <SRS0=BZT9=SS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 406CCC10F14
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Apr 2019 22:38:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0F3592173C
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Apr 2019 22:38:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="G7quaF9O"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730651AbfDPWiR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Apr 2019 18:38:17 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:39666 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727057AbfDPWiQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Apr 2019 18:38:16 -0400
Received: by mail-pg1-f195.google.com with SMTP id k3so11024651pga.6;
        Tue, 16 Apr 2019 15:38:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=QxSN67SXScLmDP0J1JVz4/1JGDwIPnYWLQpjdrMc9cI=;
        b=G7quaF9Oc+vHKanhtI8tIEugHYcerXY6K8UHdqOcZKSmsP8J2t7YWm6wv1pXbYnsIM
         l1PgY6cEsIm+c2AthhHL1bn7xCskC7YOooNLyV34BvgpoLVXwnSUnYnTflg2Jt+DkJ7o
         9JrWHmNG8KJZWzj34gby67uZ+hgqC0LhQr26bQpwjj5RFs1XGAOuV7pKqPasjrchrFpA
         1pOoyycLTdVgCwG/dSuX4dzW53FbZHypz8lQVXffmWFHcW1xBfagvAhCkil+f/ooDhps
         OEyBl0ZzOEXIKLjFo1EeZp+ywCChIokCgRYZ54LDwwC8mLyKXsgWF5KHCgswkaZzPOYe
         AtjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=QxSN67SXScLmDP0J1JVz4/1JGDwIPnYWLQpjdrMc9cI=;
        b=LIkN2i1NEa71ZMTtXnWwdnUOJ9t2zzKOxjodXDfrYPO/qma8OV3mH0BBa7xtFlR5eJ
         LFO+yQMUBf581TG3P23yyxe/GSmohnntM0x1jL0cK9nozlLzBOgG4DgoFFgZsy230s9O
         ZoWH9te5Ut8NpwbJU+Fp8LocoFzQRu25wyfnWJnjBKchS/0hhj95cRllPgm9Fi6XBNBK
         KKPZyhadLkr+gSM0c4KqwKMSX6BCSVQ8WdIhEssSYapb1i+T7nttHC6GQ5I4bt8PlnFV
         5QkGqXmHjaQoBGTIqABGLn25/4hr0EZ3Qd9bYbVNTG/nFefPQxL67aJzSOpBqORr7LkE
         DSng==
X-Gm-Message-State: APjAAAXgX/dgcAtS+wa3U7WVJC3aSg3WH5I6YRxCM67+JayYSqcFkxTD
        8h/FEgUdmj8ATPQRPl9GSk4=
X-Google-Smtp-Source: APXvYqxzorWp2DWloPs4BE7hxkrGAmdXU/UaBFzT650uIc4YLOR9hzCdZ+JnQDf8KUxvdugW8GCPKA==
X-Received: by 2002:a63:28f:: with SMTP id 137mr78243290pgc.377.1555454295869;
        Tue, 16 Apr 2019 15:38:15 -0700 (PDT)
Received: from localhost ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id k1sm73509534pfc.83.2019.04.16.15.38.14
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 16 Apr 2019 15:38:14 -0700 (PDT)
Date:   Tue, 16 Apr 2019 15:38:13 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     Wolfram Sang <wsa@the-dreams.de>
Cc:     Jerry Hoemann <jerry.hoemann@hpe.com>,
        Wolfram Sang <wsa+renesas@sang-engineering.com>,
        linux-watchdog@vger.kernel.org, linux-renesas-soc@vger.kernel.org,
        Wim Van Sebroeck <wim@linux-watchdog.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 06/16] watchdog: hpwdt: drop warning after calling
 watchdog_init_timeout
Message-ID: <20190416223813.GA744@roeck-us.net>
References: <20190416102515.12269-1-wsa+renesas@sang-engineering.com>
 <20190416102515.12269-7-wsa+renesas@sang-engineering.com>
 <20190416203431.GA20072@anatevka>
 <20190416204814.GA26442@roeck-us.net>
 <20190416205533.GB8268@kunai>
 <20190416212046.GC26442@roeck-us.net>
 <20190416221702.GC8268@kunai>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190416221702.GC8268@kunai>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 17, 2019 at 12:17:02AM +0200, Wolfram Sang wrote:
> On Tue, Apr 16, 2019 at 02:20:46PM -0700, Guenter Roeck wrote:
> > On Tue, Apr 16, 2019 at 10:55:33PM +0200, Wolfram Sang wrote:
> > > 
> > > > That is indeed a problem: the pointer will be NULL if there is no parent
> > > > device (such as in softdog.c). Otherwise it should never be NULL.
> > > 
> > > Okay, this spoils my err_dev solution. So, we probably go this route
> > > then:
> > > 
> > > 	pr_<errlvl>("watchdog%d: <err_msg>\n", wdd->id);
> > > 
> > 
> > I don't like it because it doesn't show the driver name, and watchdog%d
> > can change with each reboot. How about something like this ?
> > 
> > static void pr_wdt_err(struct watchdog_device *wdd, char *text, int err)
> > {
> > 	if (wdd->parent)
> > 		dev_err(wdd->parent, "%s: %d\n", text, err);
> > 	else
> > 		pr_err("%s: %s: %d\n", wdd->info->identity, text, err);
> > }
> > 
> > We could then use the same mechanism to generate error messages for
> > watchdog_register_device().
> 
> 'text' is a constant string then. Supporting a format string will make
> this much more complicated. Yet, printing out the wrong timeout is
> useful, I think.
> 
> What about:
> 
> 	dev_str = wdd->parent ? dev_name(wdd->parent) : wdd->info->identity;
> 	pr_<errlvl>("%s: <errstr>\n", dev_str, ...);
> 
Yes, that works as well. Note that it will actually print something like
"watchdog: <device>: ..." due to the pr_fmt() at the top of watchdog_core.c.
I guess that should be ok.

Guenter

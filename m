Return-Path: <SRS0=SZ1Q=SM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3A4D8C282CE
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Apr 2019 19:54:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 08DFA20830
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Apr 2019 19:54:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="N9vk8EAm"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726691AbfDJTyN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 10 Apr 2019 15:54:13 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:43973 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726038AbfDJTyM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Apr 2019 15:54:12 -0400
Received: by mail-pg1-f193.google.com with SMTP id z9so2158632pgu.10;
        Wed, 10 Apr 2019 12:54:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=8RnvvGONpc1znN6tehKhO4srMrP2MiULHwMPLq6oZTE=;
        b=N9vk8EAmD7Lq+Rmyo9UfsJtulMoudjAc9zcmCkwKRu51lIX3pBludaGgbGZmgg+2bJ
         2fwBWiz2JP1d9dn19m6kxjv76TVXpL2byYF0AjBh5oWlDz4p6xtB0iB2GGE1f8EIZOFJ
         S+xeTL7FYZvHkzWP3U5i03bm3a5+eCLI4cuTiQllBKqz6smT6VcQ8K3G0s2zudxa5d4e
         lJLtqkEQWgrr47s7E+MvUd4r+xIDtejv9fnKek5XAYgdiCpc/UyoLBGSae+hP6b42kxk
         i17dwBca6hRYdX4JTCvlGLSJZUBwvbuphsTFPKZXh/jqEwtblSyiRDXytJAms3b1KEc4
         mA8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=8RnvvGONpc1znN6tehKhO4srMrP2MiULHwMPLq6oZTE=;
        b=KS2JsOa0BD8E9y0TgrIBWgmAr6+N5g28cwDPrrFStlxpBV8NLV3kAZSM+TCHgRlbzh
         Ys5MRUd/m1b0yazgXBS5dOXAGOQBB5f5v2ifo9X2qfeyUJw4oNW3Dh7NVNHHdKK4mxch
         3HjMsTqZH5RRRU+326hMVGfvR48mhoQGWcwH4LvuqEiNbBOFdEQkr76XS4ZipDjXf7YJ
         UZcd5YZw+KmHAjuHgwr4dsOEl/Ki0ilsXkCyz8myyDRI8glNhc2bE213fM9HqGHFVCmw
         TkZIRZQGsoVkrQf6z0eJ37586ZiBXWMQfThpHpmZyp82dC6XTtI8M6glBcsGS+F2jR0y
         7qkg==
X-Gm-Message-State: APjAAAX7jbnImE5eiGVOAhjT3MWWKACFXO0WZdOhCksmw2JIMK7y/AoI
        6gYbPQXFQicCZuiv1o5lM74=
X-Google-Smtp-Source: APXvYqweur5wRpapP3bRtRMnxyIZKEWEmQwZkPIDfxoHJol76UL5wwcDVaJKLVUj9huSUteYoNjXoQ==
X-Received: by 2002:a63:2b4c:: with SMTP id r73mr43673385pgr.181.1554926051864;
        Wed, 10 Apr 2019 12:54:11 -0700 (PDT)
Received: from localhost ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id 143sm71833340pge.50.2019.04.10.12.54.10
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 10 Apr 2019 12:54:10 -0700 (PDT)
Date:   Wed, 10 Apr 2019 12:54:09 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     Joe Perches <joe@perches.com>
Cc:     Wim Van Sebroeck <wim@linux-watchdog.org>,
        linux-watchdog@vger.kernel.org, linux-kernel@vger.kernel.org,
        Matthias Brugger <matthias.bgg@gmail.com>
Subject: Re: [PATCH 18/22] watchdog: mt7621_wdt: Use 'dev' instead of
 dereferencing it repeatedly
Message-ID: <20190410195409.GA29802@roeck-us.net>
References: <1554913683-25454-1-git-send-email-linux@roeck-us.net>
 <1554913683-25454-19-git-send-email-linux@roeck-us.net>
 <e76117d45b1b1caff6bce8d28506e683694d6a79.camel@perches.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e76117d45b1b1caff6bce8d28506e683694d6a79.camel@perches.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 10, 2019 at 11:46:24AM -0700, Joe Perches wrote:
> On Wed, 2019-04-10 at 09:27 -0700, Guenter Roeck wrote:
> > Introduce local variable 'struct device *dev' and use it instead of
> > dereferencing it repeatedly.
> > 
> > The conversion was done automatically with coccinelle using the
> > following semantic patches. The semantic patches and the scripts
> > used to generate this commit log are available at
> > https://github.com/groeck/coccinelle-patches
> 
> Interesting collection.  It would be useful to specify which
> particular script generated or enabled this patch.
> 

It is pdev-addvar.cocci, rule 'new'. deref.cocci wasn't used for the
watchdog patches. The script to apply the various rules is watchdog/make.sh.

Pointing to the actual scripts used is a good idea. I'll see if I can add
this for subsequent series. After all, the commit log is also auto-generated,
so this should be straightforward.

> Just scanning briefly, it might have been this one:
> https://github.com/groeck/coccinelle-patches/blob/master/common/deref.cocci
> But it looks like some manual bit might have been required too.

Not for this one. There were a couple of situations where I had to manually
split long lines to avoid checkpatch warnings, and I manually updated a few
of the commit logs, but not in this patch.

> 
> And trivially:
> 
> > diff --git a/drivers/watchdog/mt7621_wdt.c b/drivers/watchdog/mt7621_wdt.c
> []
> > @@ -133,18 +133,19 @@ static struct watchdog_device mt7621_wdt_dev = {
> []
> >  	watchdog_init_timeout(&mt7621_wdt_dev, mt7621_wdt_dev.max_timeout,
> > -			      &pdev->dev);
> > +			      dev);
> 
> This could be on one line.
> 
Coccinelle isn't perfect. The rule doesn't modify the entire argument list,
only the last argument, so coccinelle missed that it could have merged the
two lines into one.

A checkpatch rule suggesting that multiple extension lines can be merged
might be useful to help finding such situations. Just a thought.

Thanks,
Guenter

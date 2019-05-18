Return-Path: <SRS0=//ty=TS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2900AC04AB4
	for <linux-kernel@archiver.kernel.org>; Sat, 18 May 2019 03:37:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D97B120578
	for <linux-kernel@archiver.kernel.org>; Sat, 18 May 2019 03:37:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="q822CBw5"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728046AbfERD2v (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 17 May 2019 23:28:51 -0400
Received: from mail-qt1-f193.google.com ([209.85.160.193]:46275 "EHLO
        mail-qt1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727309AbfERD2u (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 May 2019 23:28:50 -0400
Received: by mail-qt1-f193.google.com with SMTP id z19so10258078qtz.13
        for <linux-kernel@vger.kernel.org>; Fri, 17 May 2019 20:28:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=4k2RPAOIwlNWvBVTtEJ5zltXK23wBhV48PCCQgLPHiE=;
        b=q822CBw5a/+uAweK0KVid8+RUmQbym/QH2YlJyz3TB7J9Ct9aXpor0aw6lOejEn8CG
         gmwZ93Alq+BkoYvq9gTdYNFtSzy/7Soqx08UT3ck8IeOSp34MXg+nwPGuyT9B7qclLFp
         lRf7OgLnq0tMmJOdOyOEA8zKXx6QYpCNSrq7iV49/MJxp6cs/M49JsxCiZA01ZfZNrif
         8Se80cmUQ0cdho2HpA5FsFt6cTaMx4OM2uepgHYXTIvixxSfvaXy+eFCGHq0CYa8WUPI
         YEfRct2O+zSyIqu+Gj07k4aIymn8YpZ2x79u1MKrViQdefXNSqzSrHxpztobHKbIj9Mt
         +yDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=4k2RPAOIwlNWvBVTtEJ5zltXK23wBhV48PCCQgLPHiE=;
        b=MvKkkSuXCxGtX05X/T9FJ6Mzw26vR4VV4kv/OIRNK8lFgMjs9q3dNXNrRagoORCvmE
         aIVWs8hQ9EIOfPhj3Cjh05NmRegMQ6mYHdQQe9zwz2cu8LPnGr+5Z9ejjhFYx+UMNrdk
         Y68S+wRjL4Z9/s+vHiktfvfvsXIMvvN1Yr9WKrXjcO70FTtWfib9bi1bfGGFEB0h75zG
         Jy13xvQqUhHl0V8m3oXv+IjvzKQXJWHlPyIb+cejK9+0FNqWsDj8Z+QN+DCZmobkeQGg
         xNuFZKLBdpArXwH7W2k1YVQX/6y4s6ohsydTRTfTEDjBRncDVgF30Udnz3POLfUdVfXp
         +iPQ==
X-Gm-Message-State: APjAAAUEfMxzFcpUDXGSumscdqRCCAt5YEUYfrqNs6MBIfY9YBfArfXf
        NE+9ZjR7pwP9Siz3Cvxs8RXtqEYS2UI=
X-Google-Smtp-Source: APXvYqyRgcGoQefGiJDfG+qLVgABXquiY4xbWUkDfbSL0uV3O1PXPrRJPd27K7B+6f2z9EBGqr1FvQ==
X-Received: by 2002:a0c:acba:: with SMTP id m55mr11365004qvc.52.1558150129539;
        Fri, 17 May 2019 20:28:49 -0700 (PDT)
Received: from arch-01.home (c-73-132-202-198.hsd1.dc.comcast.net. [73.132.202.198])
        by smtp.gmail.com with ESMTPSA id x8sm6320857qtc.96.2019.05.17.20.28.48
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 17 May 2019 20:28:49 -0700 (PDT)
Date:   Sat, 18 May 2019 03:28:39 +0000
From:   Geordan Neukum <gneukum1@gmail.com>
To:     Joe Perches <joe@perches.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 4/5] staging: kpc2000: kpc_i2c: use %s with __func__
 identifier in log messages
Message-ID: <20190518032838.GA12809@arch-01.home>
References: <cover.1558146549.git.gneukum1@gmail.com>
 <ffd66b415e67f6b03483a6ee57b7b3dc0bab388f.1558146549.git.gneukum1@gmail.com>
 <9e30f140e314f03057a2941f4d091d8965391c17.camel@perches.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9e30f140e314f03057a2941f4d091d8965391c17.camel@perches.com>
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 17, 2019 at 07:58:19PM -0700, Joe Perches wrote:
> On Sat, 2019-05-18 at 02:29 +0000, Geordan Neukum wrote:
> > Throughout i2c_driver.c, there are instances where the log strings
> > contain the function's name hardcoded into the string. Instead, use the
> > printk conversion specifier '%s' with the __func__ preprocessor
> > identifier to more maintainably print the function's name.
>
> Might as well remove all of these and use the
> builtin ftrace function tracing mechanism instead.
>
> > diff --git a/drivers/staging/kpc2000/kpc_i2c/i2c_driver.c b/drivers/staging/kpc2000/kpc_i2c/i2c_driver.c
> []
> > @@ -142,7 +142,7 @@ static int i801_check_pre(struct i2c_device *priv)
> >  {
> >  	int status;
> >
> > -	dev_dbg(&priv->adapter.dev, "i801_check_pre\n");
> > +	dev_dbg(&priv->adapter.dev, "%s\n", __func__);
>
> etc...
>
Joe/All,

Acknowledged. I apologize for the inconvenience there -- I was
unfamiliar with that API until receiving your email. I'll hold on
additional uploads until other reviewers have had time to take a
look, but I do plan on leveraging the ftrace API instead of just
using __func__ and %s in my printk strings in the upcoming 'v2'
patchset.

Thanks for your feedback,
Geordan

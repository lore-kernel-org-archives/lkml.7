Return-Path: <SRS0=BZT9=SS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B4AA5C10F14
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Apr 2019 21:20:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 87E0D20821
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Apr 2019 21:20:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="k1OoNL9h"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730490AbfDPVUt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Apr 2019 17:20:49 -0400
Received: from mail-pl1-f193.google.com ([209.85.214.193]:38791 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728277AbfDPVUs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Apr 2019 17:20:48 -0400
Received: by mail-pl1-f193.google.com with SMTP id f36so10956960plb.5;
        Tue, 16 Apr 2019 14:20:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=x0SVpgkEJogEYU/LrEiNpS8peT+ejZT0nMW6St9JdL4=;
        b=k1OoNL9h3uJDQxMuRJaemy77Dw8/Kd4qzot3xkAeluDhbkXnH1PwssNpmW7pz07ibA
         sRqPySGW7/uSaqCjIIb+E2ulfQbih//EUb0GbsH3rBLbNwtEnlaK6oErG3++lo4tXQi0
         7G0xeA7Wh571bpT0q49Qde+KlY7R7SXAcAFgP07KMCp5RHMk0Pi9otX+CKbTR+3XXzhs
         izsl6RozZq8UVzXDkuX8a0tPi4MIFJJY651J9qRAxr2ycqqUEDsPFvX04gAGfZsegjgA
         /rApuk8yJ1YdZFyG5QLzE4rzE5CUENyVB4kJCjVcqKXY/h/1u/Qyc5zfNp8YTka2FV9m
         BUhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=x0SVpgkEJogEYU/LrEiNpS8peT+ejZT0nMW6St9JdL4=;
        b=Hsapgg2hQDKDuIkG3qHrOac6sWn1t/ZA4DUI73J/7cRgqSjef8fq2o43fkjTeSUtyO
         pjba/70T1VSOff0T6Y+RuozpygcVdvkzd5WQGG88jwWnLYxkfiB/zB21HmbRlf5Zn9XT
         JR6d6fA1yK3a5s7yXmJINXryqsBMg3PMNvsUK68l6Xajgbnvx2lzX/RQH7nN2Ej5rZOV
         SJA4W/NSgJwoueChWKbZ6uKnu168l5u4HXePTkVEaZPtiLlHOr6QipXsOGnPAPzRwSpJ
         uQhJNhmjIVwLFP7SBHMU+loQYzmE3qpeG5qQcE1ev0nKYPLiTpIZWykwAZel03CaHOFO
         wjDg==
X-Gm-Message-State: APjAAAUW4I4M9TjM4LbuJmtEBJcRfA103Pjs1diez9PHgwN2Wrj3KNoq
        X14zjjfNua9tfJMM2SA57W2/yrv2
X-Google-Smtp-Source: APXvYqyRKamzDgGb0QXZPGKhGdwP+nnanSKZeMdXTfjWdf/A6NcdXpAjFrN+zz0n9omzngEROVqbqQ==
X-Received: by 2002:a17:902:2e01:: with SMTP id q1mr23484319plb.221.1555449648204;
        Tue, 16 Apr 2019 14:20:48 -0700 (PDT)
Received: from localhost ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id d20sm79122774pfo.77.2019.04.16.14.20.47
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 16 Apr 2019 14:20:47 -0700 (PDT)
Date:   Tue, 16 Apr 2019 14:20:46 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     Wolfram Sang <wsa@the-dreams.de>
Cc:     Jerry Hoemann <jerry.hoemann@hpe.com>,
        Wolfram Sang <wsa+renesas@sang-engineering.com>,
        linux-watchdog@vger.kernel.org, linux-renesas-soc@vger.kernel.org,
        Wim Van Sebroeck <wim@linux-watchdog.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 06/16] watchdog: hpwdt: drop warning after calling
 watchdog_init_timeout
Message-ID: <20190416212046.GC26442@roeck-us.net>
References: <20190416102515.12269-1-wsa+renesas@sang-engineering.com>
 <20190416102515.12269-7-wsa+renesas@sang-engineering.com>
 <20190416203431.GA20072@anatevka>
 <20190416204814.GA26442@roeck-us.net>
 <20190416205533.GB8268@kunai>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190416205533.GB8268@kunai>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 16, 2019 at 10:55:33PM +0200, Wolfram Sang wrote:
> 
> > That is indeed a problem: the pointer will be NULL if there is no parent
> > device (such as in softdog.c). Otherwise it should never be NULL.
> 
> Okay, this spoils my err_dev solution. So, we probably go this route
> then:
> 
> 	pr_<errlvl>("watchdog%d: <err_msg>\n", wdd->id);
> 

I don't like it because it doesn't show the driver name, and watchdog%d
can change with each reboot. How about something like this ?

static void pr_wdt_err(struct watchdog_device *wdd, char *text, int err)
{
	if (wdd->parent)
		dev_err(wdd->parent, "%s: %d\n", text, err);
	else
		pr_err("%s: %s: %d\n", wdd->info->identity, text, err);
}

We could then use the same mechanism to generate error messages for
watchdog_register_device().

Guenter

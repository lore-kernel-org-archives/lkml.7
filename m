Return-Path: <SRS0=n7Fw=UL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B3521C31E46
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Jun 2019 08:36:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 895532063F
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Jun 2019 08:36:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RgqTRH6Y"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405539AbfFLIgs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Jun 2019 04:36:48 -0400
Received: from mail-pf1-f179.google.com ([209.85.210.179]:46477 "EHLO
        mail-pf1-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727027AbfFLIgs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Jun 2019 04:36:48 -0400
Received: by mail-pf1-f179.google.com with SMTP id 81so9209909pfy.13
        for <linux-kernel@vger.kernel.org>; Wed, 12 Jun 2019 01:36:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=8D1H9g9GFlDAss1Xnkrc39q7LIlBQcRGRBG+sL7YE+8=;
        b=RgqTRH6YlgD0ehcaP2t9921mgwMTGy0dMyAIYO334+o/hCfcrYwM9VU/JuXUrLJGKr
         qWT1RCDAicYs1zLhcPqE93E01O+swZZKRoI2mNGKq7c8KCH+4++5jViDywzBwJiyVhNr
         6vkfXVe1IPObhQcBumxID6Gx+QWLM/6NOIqMQmcNyEy7FvOJTwRwVCsJRX+FDsSzAtGH
         tb0r5m3UhefZy/L4H+AwUZxNd+mZKR7CFHM6hnYKjZcdThYtZOm8ohRRJpxUC/3VhUOx
         6sk+WmIQv9VXjKtwOBn3vHvNaSfS87sjv0mGvQS2ym4frKsKOTsGo0c/r0z7pLBMt+/j
         3a1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=8D1H9g9GFlDAss1Xnkrc39q7LIlBQcRGRBG+sL7YE+8=;
        b=dwOmcVnsRfrTKuKPz3No+z+RzaTWVvtDQ/lMygUXDA3Sdq3tx+Q8JaG0SvgPJ8RKni
         Yk6pOYyM5j4u2em+e3bYix+dXdtUw0JN4gODb5Q12TFXA2VVHEmJHFicIPho/5pc+VK+
         /RPKeFH1Gq7nrEvlkqkdNrdmfop5uZmBio2yR0QNMG+wNLKSwbqR1mUFlvOVxqshBj30
         SAl0ALNLIcwhMteUOv4QWOUhBRrrxwwBnewKEBAFCkY9gdro1Pi/xz8k0ZdRlEPNttr6
         0ewap4c1+qibGM312NElZe60UfC0HaW94tBKtDPs22TIw8cG1BGhJwbdO6b2502xiu21
         es/w==
X-Gm-Message-State: APjAAAVqsvoV/biYPqomAodGArhtBOCXnpGdeIP5sL2D/E0TstSd90or
        HEN2TW7DSPRrFIjRvhhstPk=
X-Google-Smtp-Source: APXvYqyogKFHc9PXyY1nt+pPC0hhqK4zNvLOmK+YUKnbR74u2S3xRVOg9Tu5agL7aepUJrsZ+gK+lw==
X-Received: by 2002:a17:90a:1b0c:: with SMTP id q12mr31843718pjq.76.1560328607531;
        Wed, 12 Jun 2019 01:36:47 -0700 (PDT)
Received: from localhost ([110.70.55.193])
        by smtp.gmail.com with ESMTPSA id r11sm15330567pgs.39.2019.06.12.01.36.45
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Wed, 12 Jun 2019 01:36:46 -0700 (PDT)
Date:   Wed, 12 Jun 2019 17:36:43 +0900
From:   Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>
To:     Petr Mladek <pmladek@suse.com>
Cc:     Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>,
        Dmitry Safonov <dima@arista.com>, linux-kernel@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jslaby@suse.com>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
Subject: Re: [RFC] printk/sysrq: Don't play with console_loglevel
Message-ID: <20190612083643.GA7722@jagdpanzerIV>
References: <20190528002412.1625-1-dima@arista.com>
 <20190528041500.GB26865@jagdpanzerIV>
 <20190528044619.GA3429@jagdpanzerIV>
 <20190528134227.xyb3622gjwu52q4r@pathway.suse.cz>
 <20190603065153.GA13072@jagdpanzerIV>
 <20190606071039.txqczrjlntrljlrx@pathway.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190606071039.txqczrjlntrljlrx@pathway.suse.cz>
User-Agent: Mutt/1.12.0 (2019-05-25)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On (06/06/19 09:10), Petr Mladek wrote:
> > > > > > Provide KERN_UNSUPPRESSED printk() annotation for such legacy places.
> > > > > > Make sysrq print the headers unsuppressed instead of changing
> > > > > > console_loglevel.
> > > 
> > > I like this idea. console_loglevel is temporary manipulated only
> > > when some messages should or should never appear on the console.
> > > Storing this information in the message flags would help
> > > to solve all the related races.
> > 
> > I don't really like the whole system-wide console_loglevel manipulation
> > thing,
> 
> Just to be sure. I wanted to say that I like the idea with
> KERN_UNSUPRESSED. So, I think that we are on the same page.

I understand. All I wanted to say is that KERN_UNSUPRESSED is
per-message, while the most interesting (and actually broken)
cases, IMHO, are per-context, IOW things like this one

	console_loglevel = NEW
	foo()
	  dump_stack()
	     printk
	     ...
	     printk
	console_loglevel = OLD

KERN_UNSUPRESSED does not help here. We probably can't convert
dump_stack() to KERN_UNSUPRESSED.

[..]
> Now, KERN_EMERG might alarm some monitor of console output. It might
> trigger unwanted reaction (forced reboot?) of the monitoring system
> even when sysrq was not called in emergency situation.
> 
> I am sure that we need to care about such monitors. I have to
> think more about it.

Sure.

	-ss

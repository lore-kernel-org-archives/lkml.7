Return-Path: <SRS0=SA5R=SA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 84CBDC43381
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Mar 2019 16:51:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4F7AB218D3
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Mar 2019 16:51:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="i2WEi6uH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729822AbfC2Qvp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 29 Mar 2019 12:51:45 -0400
Received: from mail-oi1-f194.google.com ([209.85.167.194]:38432 "EHLO
        mail-oi1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728977AbfC2Qvo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Mar 2019 12:51:44 -0400
Received: by mail-oi1-f194.google.com with SMTP id w137so2190815oiw.5;
        Fri, 29 Mar 2019 09:51:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:reply-to:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=N1HCigfA8bQHvJ/BGlEGTuP3vkUjfhaoQn+F89AQ34M=;
        b=i2WEi6uHY5m6gssBWupSUY66gXWQs8xsF8Kz4jMWmI6x+y3iLiTGkl6/3R7t/xAY6i
         njr1lp3+GQvrI/Utt93iFFLr9I0o0Sk+3MTqzn7+QaSZFs/5JGACSkMngPCb/SLd0s8g
         MtOEyYpudDQayUXc+jv4E2Q8/8PM8SYv667ukw0IfHrwlMNYFZuMkHaYY3Fcq/Bmk9sG
         FajdNklnWRjGoulivNM4AsJdtccMtYMRGamPqyyocJHg8l4lt96OdtgqHHOKaUWnxNQD
         EH6mOaFKZ5vDuhVox6lMXTccyoicONbIPrJWNMFuoSQcas2sgbMKHci7l4dgi45AIWem
         erZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :reply-to:references:mime-version:content-disposition:in-reply-to
         :user-agent;
        bh=N1HCigfA8bQHvJ/BGlEGTuP3vkUjfhaoQn+F89AQ34M=;
        b=NmBizlicA1AQzDNGpI04OqnLtccVzyoC/2WAaBjfpw7lMje/34DDAoSXRwllkpCQSp
         EM/xYsQsUVrJLh+MU3jO4L0orzbBWxv0jUCqeKuaCOVuqFN1hm5ZESEn7+3WANF3WRWA
         kKv0K/c2SlT3hrK1RDmKWGFYct1yYCVpfihRRme0H53NxoMBTGL6thNRlzArISt6sUcH
         4xyai8hQouBtzSxX7Wrdj7xeP9Aa66SeubsbV9Fs992ZPoe6/r76z7LkMvonWHoIQyqp
         HAnZcHQ9rHnt96tjHbIcCmi0DAVDf2aY0LXynxOtFHUjuz3r5+IfnhpmG3Ql8siP0gJC
         Ao1w==
X-Gm-Message-State: APjAAAW1M7y0awrEMHwOX807NCarxp4URtcSOFpbhzyys7Hnz7mQfkwj
        lIg69NGMvV7erMM8ygSnAz3pim0=
X-Google-Smtp-Source: APXvYqxI3mP5WxwqW9kp53XWCg+T9Wdk5qTE/pdg7j2rI2YcCrakUmQEEqYjEtgYRKzYQEFcIHAm9Q==
X-Received: by 2002:aca:df05:: with SMTP id w5mr4258485oig.150.1553878303469;
        Fri, 29 Mar 2019 09:51:43 -0700 (PDT)
Received: from serve.minyard.net (serve.minyard.net. [2001:470:b8f6:1b::1])
        by smtp.gmail.com with ESMTPSA id 101sm1117739otl.76.2019.03.29.09.51.42
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 29 Mar 2019 09:51:42 -0700 (PDT)
Received: from minyard.net (75-108-126-199.enidcmtk01.res.dyn.suddenlink.net [75.108.126.199])
        by serve.minyard.net (Postfix) with ESMTPSA id E7CEF18003A;
        Fri, 29 Mar 2019 16:51:41 +0000 (UTC)
Date:   Fri, 29 Mar 2019 11:51:40 -0500
From:   Corey Minyard <minyard@acm.org>
To:     "H. Peter Anvin" <hpa@zytor.com>
Cc:     Randy Dunlap <rdunlap@infradead.org>, cminyard@mvista.com,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] tty/serial: Add a serial port simulator
Message-ID: <20190329165140.GD31733@minyard.net>
Reply-To: minyard@acm.org
References: <20190305171231.22133-1-minyard@acm.org>
 <eea0ad95-8344-371a-1dd0-58c8366a355b@infradead.org>
 <20190306015149.GD4290@minyard.net>
 <041e137e-0b9d-04f9-255d-b1f402b23c17@infradead.org>
 <447407be-0f49-f29d-6e81-bf4ed0a6e56b@zytor.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <447407be-0f49-f29d-6e81-bf4ed0a6e56b@zytor.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 28, 2019 at 12:39:12PM -0700, H. Peter Anvin wrote:
> Dumb question: this is basically a pty on steroids. Wouldn't this be
> better done by enhancing the pty devices?

I did look at that, but it would be pretty invasive to pty.  There's
no modem control stuff, none of the other special serial ioctls.  And
the locking in this driver is fairly strange because you have two
serial ports looking at each other's data for modem control.  But
that might not be a big deal.

Adding the speed simulation to ptys would also be really strange.
That's not a deal-breaker, I suppose, but it's not much of a serial
port simulation without it.

-corey

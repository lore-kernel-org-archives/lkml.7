Return-Path: <SRS0=rNeM=SR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1250DC10F0E
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Apr 2019 17:39:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B7E982073F
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Apr 2019 17:39:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="boag/pJV"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728095AbfDORjj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Apr 2019 13:39:39 -0400
Received: from mail-ot1-f68.google.com ([209.85.210.68]:34253 "EHLO
        mail-ot1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727835AbfDORjj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Apr 2019 13:39:39 -0400
Received: by mail-ot1-f68.google.com with SMTP id k21so15211967otf.1
        for <linux-kernel@vger.kernel.org>; Mon, 15 Apr 2019 10:39:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:reply-to:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=pYUneuXemRtWxW8zOSyr8WfRHS3jkf7zIGvmOCWCSDM=;
        b=boag/pJVVchnd0v5Xv49in3aQJ1PKN+igr3j9TEJ56wfUHLG/NVhvpBKqX1bZ5GyLT
         FELL68dpGZkuiVtKrXwr9/0r3Poy6/Z1ukM5ZA3LKRmxNg1rb0QoBVkG2JnIctD5+fWK
         sIoubD90Ke4Qi9we0lNRx+y1OyXhSa1ECsgurUUuFfEBxcdbXkbPNVROPWj3ERAfMNVV
         mzVC4WsXrTqEPo7VJP5Ha7JYLsH2kx1ZGzhcVL+h1pLvl8H2a2tA4i3Ok2xLGfdDc///
         wZBfXD6w1sa7tFXIDUah1HJaHYzMVw4v6kOdY2z/THHEaszbnY4OFp+IkKwza5pwn9Lf
         GFlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :reply-to:references:mime-version:content-disposition
         :content-transfer-encoding:in-reply-to:user-agent;
        bh=pYUneuXemRtWxW8zOSyr8WfRHS3jkf7zIGvmOCWCSDM=;
        b=s6ptOWnqZgQSgxLo9hOx7FSBmDOm2h3eP90k4OkMT2jAPHagMw0lbeepQHMU3EeYdl
         P132aUEUWt98J7e4HCKsxsRAjBdjL2823driy0kZY2jNt56A7+Vw3kP7q7exrLhYm0Q9
         CNN9YMXe/6sA2jbQx/CzeVTsx4dudtBANswNDjbjJSAP5eWgHMUYPr385KELCWdJJEUj
         5XALSlmktiEKlCphNuCMSeJfaBFP1/Hh/CS7HbbMjztRg2awW4mUc/rmuZY2NFcv/zMt
         9k/pyJwDCubcyQEyNip9zGOc8a+5Kcj9jOR1CBmt8IGE/HVZ04MjJ73sSl2OJilFfGtQ
         WcZg==
X-Gm-Message-State: APjAAAXL/zZu0UiEixUUV6EyRYnkj0BuSKomOpvLsAr+wgAZmAStKc91
        YRsqugiCbuV30lvyoV/NRT28ADM=
X-Google-Smtp-Source: APXvYqwI395p/MXfE8E16wnvXBMYKcJffqQlpcsfqVjsDe+vSmr2gmpj6Ie0DR81me68gqaWrvCTSw==
X-Received: by 2002:a9d:e8f:: with SMTP id 15mr47767116otj.148.1555349977925;
        Mon, 15 Apr 2019 10:39:37 -0700 (PDT)
Received: from serve.minyard.net ([47.184.134.43])
        by smtp.gmail.com with ESMTPSA id h68sm20376469otb.1.2019.04.15.10.39.37
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 15 Apr 2019 10:39:37 -0700 (PDT)
Received: from minyard.net (unknown [IPv6:2001:470:b8f6:1b:d5e:aa5a:44d8:6907])
        by serve.minyard.net (Postfix) with ESMTPSA id B71E818003A;
        Mon, 15 Apr 2019 17:39:36 +0000 (UTC)
Date:   Mon, 15 Apr 2019 12:39:35 -0500
From:   Corey Minyard <minyard@acm.org>
To:     Christoph Hellwig <hch@infradead.org>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        openipmi-developer@lists.sourceforge.net,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ipmi: avoid atomic_inc in exit function
Message-ID: <20190415173935.GE4121@minyard.net>
Reply-To: minyard@acm.org
References: <20190415155509.3565087-1-arnd@arndb.de>
 <20190415164022.GA32090@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20190415164022.GA32090@infradead.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 15, 2019 at 09:40:22AM -0700, Christoph Hellwig wrote:
> On Mon, Apr 15, 2019 at 05:55:00PM +0200, Arnd Bergmann wrote:
> > This causes a link failure on ARM in certain configurations,
> > when we reference each atomic operation from .alt.smp.init in
> > order to patch out atomics on non-SMP systems:
> > 
> > `.exit.text' referenced in section `.alt.smp.init' of drivers/char/ipmi/ipmi_msghandler.o: defined in discarded section `.exit.text' of drivers/char/ipmi/ipmi_msghandler.o
> > 
> > In this case, we can trivially replace the atomic_inc() with
> > an atomic_set() that has the same effect and does not require
> > a fixup.
> 
> I'd rather fіx the arm section management.  Using atomic in exit
> routines is perfectly valid, and it would seem odd to forbid it.

That was my first thought, too.  It's kind of hard to believe that
the IPMI driver is the only thing that does an atomic_inc() in the
exit code.

-corey

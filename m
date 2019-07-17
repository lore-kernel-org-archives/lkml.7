Return-Path: <SRS0=Ncac=VO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9DA7BC76192
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Jul 2019 17:12:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7879621852
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Jul 2019 17:12:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="Trvb+2uN"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729190AbfGQRMT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Jul 2019 13:12:19 -0400
Received: from mail-qt1-f195.google.com ([209.85.160.195]:42702 "EHLO
        mail-qt1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727385AbfGQRMS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Jul 2019 13:12:18 -0400
Received: by mail-qt1-f195.google.com with SMTP id h18so24128708qtm.9
        for <linux-kernel@vger.kernel.org>; Wed, 17 Jul 2019 10:12:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=uAyGJcxa2faLDz1zX3L+P9YEdREk6KdL2GiO7sRiFjw=;
        b=Trvb+2uNj8vUbkEDC3SxTfLCURptQdoVKewLFrm6bk4jdt1cokRy738aVJ4XYmbgD+
         92Rez/4Po6ykm+mwW4H9lcRVbz/bdZLJ2r5ndntgzbvpotRndpSTq7cVWnGV5YSMnx2X
         STt4ARBuT9edfepQWgh456AuI6rUiua8N9b43Owwed484efiXh53kNaWGNyPOuqc7Myb
         lGG38nU4hDH1vKxu5NTcYG6GknjLZbHAMd3n+ULBpgxK6V/Zd0Jds/jJTMUKGQRfv8aV
         54sYco2Vagjp8d238KCbmTo/Ura8lLPnGyAiR5M3anbFENJLsArucdJau+g9y2oVsAU9
         Izww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=uAyGJcxa2faLDz1zX3L+P9YEdREk6KdL2GiO7sRiFjw=;
        b=Q5Lw6RdzDX+8XWCrBTXuiP+6sRZLzdE09X3ysDr5HsMY26sUgcUcgBns3YEKuX2YqW
         65LdyooShTqsnoJbslI5QGKhNPxr9+lN12UsGo8FZIQaqQ1IY8pz6iHYTEKBEMJMJ+wb
         ZhWJQFopgTp0YFIl8a4SfY/c0kXps4WkE9DVkbxqG+4YylQ7emrDzTbcfCeg6OU20EMA
         +OxInUpFaloeNeh25qeCWpdV1cFXLWQ9uaWIOfImtM9TBNXN8MqcAJcWTK7ngKKHzMTT
         9btuqObkzp0NSQRuFecc34PhKPQ+5S/VDNFRAcCWZ/AMbVA4cpTY2CaT3IZ+jJ7wa+5X
         ZWbA==
X-Gm-Message-State: APjAAAWhcLlpMFQZ9R3ByETr5Vc+BFCgAXXIfAeUNwDyD0wwZSS0Jl5o
        2E9yIwjpsX51YhaJhs+Ka0N8DQ==
X-Google-Smtp-Source: APXvYqxSNZusUeIhA/bqMoyaHlDfaJ2nmzyv/KRTgT11+OmhlLB8ElQiMzjoCvSSZkAdDzdww5gBxg==
X-Received: by 2002:ac8:3233:: with SMTP id x48mr29415342qta.159.1563383537619;
        Wed, 17 Jul 2019 10:12:17 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-156-34-55-100.dhcp-dynamic.fibreop.ns.bellaliant.net. [156.34.55.100])
        by smtp.gmail.com with ESMTPSA id s127sm11093085qkd.107.2019.07.17.10.12.17
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 17 Jul 2019 10:12:17 -0700 (PDT)
Received: from jgg by mlx.ziepe.ca with local (Exim 4.90_1)
        (envelope-from <jgg@ziepe.ca>)
        id 1hnnTU-0006Lc-Is; Wed, 17 Jul 2019 14:12:16 -0300
Date:   Wed, 17 Jul 2019 14:12:16 -0300
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Stephen Boyd <swboyd@chromium.org>
Cc:     Alexander Steffen <Alexander.Steffen@infineon.com>,
        Peter Huewe <peterhuewe@gmx.de>,
        Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>,
        Andrey Pronin <apronin@chromium.org>,
        linux-kernel@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-integrity@vger.kernel.org,
        Duncan Laurie <dlaurie@chromium.org>,
        Guenter Roeck <groeck@chromium.org>
Subject: Re: [PATCH v2 5/6] tpm: add driver for cr50 on SPI
Message-ID: <20190717171216.GK12119@ziepe.ca>
References: <20190716224518.62556-1-swboyd@chromium.org>
 <20190716224518.62556-6-swboyd@chromium.org>
 <f824e3ab-ae2f-8c2f-549a-16569b10966e@infineon.com>
 <20190717122558.GF12119@ziepe.ca>
 <5d2f51a7.1c69fb81.6495.fbe8@mx.google.com>
 <20190717165628.GJ12119@ziepe.ca>
 <5d2f5570.1c69fb81.f3832.3c3f@mx.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5d2f5570.1c69fb81.f3832.3c3f@mx.google.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 17, 2019 at 10:05:52AM -0700, Stephen Boyd wrote:
> Quoting Jason Gunthorpe (2019-07-17 09:56:28)
> > On Wed, Jul 17, 2019 at 09:49:42AM -0700, Stephen Boyd wrote:
> > > Quoting Jason Gunthorpe (2019-07-17 05:25:58)
> > > > On Wed, Jul 17, 2019 at 02:00:06PM +0200, Alexander Steffen wrote:
> > > > > On 17.07.2019 00:45, Stephen Boyd wrote:
> > > > 
> > > > But overall, it might be better to just double link the little helper:
> > > > 
> > > > obj-$(CONFIG_TCG_CR50_SPI) += cr50.o cr50_spi.o
> > > > obj-$(CONFIG_TCG_CR50_I2C) += cr50.o cr50_i2c.o
> > > > 
> > > > As we don't actually ever expect to load both modules into the same
> > > > system
> > > > 
> > > 
> > > Sometimes we have both drivers built-in. To maintain the tiny space
> > > savings I'd prefer to just leave this as helpless and tristate.
> > 
> > If it is builtin you only get one copy of cr50.o anyhow. The only
> > differences is for modules, then the two modules will both be a bit
> > bigger instead of a 3rd module being created
> > 
> 
> Yes. The space savings comes from having the extra module 'cr50.ko' that
> holds almost nothing at all when the two drivers are modules.

I'm not sure it is an actual savings, there is alot of minimum
overhead and alignment to have a module in the first place.

Jason
 

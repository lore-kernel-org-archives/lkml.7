Return-Path: <SRS0=7x1k=SF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E9B96C4360F
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Apr 2019 03:41:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AC50D2084C
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Apr 2019 03:41:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Rqw5Vuw+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726792AbfDCDk7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Apr 2019 23:40:59 -0400
Received: from mail-pl1-f193.google.com ([209.85.214.193]:45996 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726130AbfDCDk7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Apr 2019 23:40:59 -0400
Received: by mail-pl1-f193.google.com with SMTP id bf11so7296486plb.12
        for <linux-kernel@vger.kernel.org>; Tue, 02 Apr 2019 20:40:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=Vn/0hwguf3dlfjRRJn0Oj0bBNMPlvLxEoVxCIUUPEx0=;
        b=Rqw5Vuw+l62nhcn8LnSBIYnmcAw3XlnCpuiM7bl4lOZMBZqITJf5cOaP9Ic2a83iP2
         gkZO7LKxQG97wyGiTFDCGc929Bb3K3Y6KIT+KclH+CDe3cLfvReRA2peI/qyb6P50Wc7
         fPNjDHTOuAzQn8gwgnWzu6UAbGeu9ctqBBjQ1MbEatnY7LIONuPMhkHuZoMmKYzJOqaV
         vzSltnyrZvbdwqtI3L7svzFRJwGWXd48KglO7F0RtLO8jZtB9/QQA+Tl9VUULrckr9LK
         W7MpMa6Gi1OwpzQfVUtpUMTOb/hNhRe0JdTdqMw7Lw42YxceMD/DY0g/7KvVps4DsPIc
         MVWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=Vn/0hwguf3dlfjRRJn0Oj0bBNMPlvLxEoVxCIUUPEx0=;
        b=C4nCSevVyZo3aTW7kchOQVYKQMa2WZ07cgm7DUrpK87+4dmiMNarLUHHbePGvnzIMp
         QrReIT59aC23E6oYQSJk4jfISoCCVwDoQrSpa1gXiAt4RUyTCjRFqu3F2CDzX1aolAiQ
         Gj3wcq+0zvZVXil62HjppESOeXHL+6iEii4hU/RB4Ntsjh61clr8i6fdQJWuCj0Cb5gF
         6rWJPvgvsj41ICEXYuDNOf2yiSG3Btpyn+HCZSLRAT/SYgGWcf77hZmw7JOqcCjjxXJd
         n49Dlpmzu41dR5p8SbwmG0zNGTwJgyNChCNHswOsJlZU9BvabYOE9K5EMEWzKlogcrV4
         2VGw==
X-Gm-Message-State: APjAAAV6Ff8+sDDSR6pC6zzmmAis4Hfkl74Q/G1SBtCW/MLWu+C2xwLd
        ctqG5F4B9loIam7jmtDu8NrtUGI7/vwJ7Q==
X-Google-Smtp-Source: APXvYqxwE30yKIL3+tkgi2YLApVFhS68oV0UPCgYRsDGHl/wYEAHcE7XfCP5/42TNklxknLzLn3C/w==
X-Received: by 2002:a17:902:2bc9:: with SMTP id l67mr74206811plb.102.1554262858501;
        Tue, 02 Apr 2019 20:40:58 -0700 (PDT)
Received: from dell ([147.50.13.10])
        by smtp.gmail.com with ESMTPSA id e4sm13025234pfh.146.2019.04.02.20.40.56
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 02 Apr 2019 20:40:57 -0700 (PDT)
Date:   Wed, 3 Apr 2019 04:40:53 +0100
From:   Lee Jones <lee.jones@linaro.org>
To:     Morris Ku =?utf-8?B?5Y+k5paH5L+K?= <morris_ku@sunix.com>
Cc:     linux-kernel@vger.kernel.org
Subject: Re: [PATCH 4/4] Add support for SUNIX Multi-I/O board
Message-ID: <20190403034053.GJ4187@dell>
References: <20190319120835.3840-1-saumah@gmail.com>
 <20190402062601.GX4187@dell>
 <HK2PR03MB45295EF1E814CE40BDFB798995560@HK2PR03MB4529.apcprd03.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <HK2PR03MB45295EF1E814CE40BDFB798995560@HK2PR03MB4529.apcprd03.prod.outlook.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Please do not drop the list from your recipients.

On Tue, 02 Apr 2019, Morris Ku 古文俊 wrote:

> Hello , Lee ,
> 
> 
> Sunix multi-io card is a composite device,
> contains serial and parallel port , before we
> trying to place the driver in the /drivers/char,
> but maintainer suggests go to /driver/mfd,so we move to here.
> this driver is special,it supports more than one interface,
> so we combine to a single driver.

The MFD subsystem is designed to register child devices.  MFD drivers
do not contain any true functionality themselves.  If this device does
multiple things, you can split the functionality into their relevant
subsystems and register each of them from here.

There are 10's of examples available.  Please take a look around some
of the existing drivers to see how their functionality is split.

> On Tue, 19 Mar 2019, Morris Ku wrote:
> 
> > Driver for SUNIX Multi-I/O card.Based on parport_pc.c, ppdev.c
> > and lp.c by Linus Torvalds, Theodore Ts'o.
> 
> Parallel port drivers should live in 'drivers/parport' and
> 'drivers/char'.  LP drivers should live in 'drivers/char'.
> 
> Please them there.
> 
> > Signed-off-by: Morris Ku <saumah@gmail.com>
> > ---
> >  mfd/sunix/snx_ieee1284.c     | 144 +++++++
> >  mfd/sunix/snx_ieee1284_ops.c | 258 +++++++++++++
> >  mfd/sunix/snx_lp.c           | 717 +++++++++++++++++++++++++++++++++++
> >  mfd/sunix/snx_lp.h           | 119 ++++++
> >  mfd/sunix/snx_parallel.c     | 397 +++++++++++++++++++
> >  mfd/sunix/snx_ppdev.c        | 454 ++++++++++++++++++++++
> >  mfd/sunix/snx_ppdev.h        |  15 +
> >  mfd/sunix/snx_share.c        | 629 ++++++++++++++++++++++++++++++
> >  8 files changed, 2733 insertions(+)
> >  create mode 100644 mfd/sunix/snx_ieee1284.c
> >  create mode 100644 mfd/sunix/snx_ieee1284_ops.c
> >  create mode 100644 mfd/sunix/snx_lp.c
> >  create mode 100644 mfd/sunix/snx_lp.h
> >  create mode 100644 mfd/sunix/snx_parallel.c
> >  create mode 100644 mfd/sunix/snx_ppdev.c
> >  create mode 100644 mfd/sunix/snx_ppdev.h
> >  create mode 100644 mfd/sunix/snx_share.c
> 

-- 
Lee Jones [李琼斯]
Linaro Services Technical Lead
Linaro.org │ Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog

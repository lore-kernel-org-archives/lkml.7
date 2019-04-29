Return-Path: <SRS0=c0gK=S7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7C5A3C43219
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Apr 2019 17:08:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 450C320675
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Apr 2019 17:08:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lixom-net.20150623.gappssmtp.com header.i=@lixom-net.20150623.gappssmtp.com header.b="0bHW5AZL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728893AbfD2RIL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Apr 2019 13:08:11 -0400
Received: from mail-lj1-f195.google.com ([209.85.208.195]:32883 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728825AbfD2RIK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Apr 2019 13:08:10 -0400
Received: by mail-lj1-f195.google.com with SMTP id f23so10116289ljc.0
        for <linux-kernel@vger.kernel.org>; Mon, 29 Apr 2019 10:08:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lixom-net.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=zy1ZS8ulMtFMg+xrXQSuG8tddrlOp8I6pRjuYcFgB6Q=;
        b=0bHW5AZLT82AmnNrU4T39kTTQRWvld2M59GqqrGav4xpXB/fwMn++vk3QI0E/Nei/e
         bzB5n4CqDIuvJPh/0gDm7QExicaSz4s0GCkRKB6k+f/yIVR/7RE2DWZ9Id4Erf2LUQTe
         ePHayxatb/Upr6CMgEiPnunDYfzhB4wJu2MxPgEUUANl096R/p9BZ35rqSZp5Zti1sVc
         9F/sC9kauTiax5lRnGNDC7NyJ2uSNOo04eijqona9stJwEIt2sM+n17iX3uby2V3sdKs
         0ZXdU2vvIjVS4KLclSxfUjDiNHhGysY4Bq6BYoAkAtCkjcHydRyUI5zo86CqLGnCJPcN
         HPXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=zy1ZS8ulMtFMg+xrXQSuG8tddrlOp8I6pRjuYcFgB6Q=;
        b=QfuNSV6/z3RRZK0PvBTXOrg3CSbCLMCn9tHtId62UIEGGb7BnXCRY97NPjHIYWilhm
         0VpHbwByRR1/MAtu7XE/6vnLM6IU2ywH24EWyjgls/cqMKjWMzwB3fmgV6iua1rc4N0W
         z/us4+FnucE4OO5BWXVgcFlyn4KMn8xrDcCe4LoWw5DNHJ/V2Z4+26OyR0JKIukK5aW5
         my4haZEjQMblJVfts7C+Bvq7T0LHXx2ZBBNrupq7EL3LELq4gPubNTX+AfWA4n3kgg3G
         JwE4luX1DSQ3DW6yHTZIChuTDbBKTLiC0S4AKbZV4a80ghzdmE/huaowknKlVNvRB7C0
         Q2Lg==
X-Gm-Message-State: APjAAAXch/4BFvuqJ6+zjYl5P7L5gOqkHhZSn8vBDDITPkVfI3dD2MJ7
        F01i4hn+0AsRqiUHgdVXRx1uiA==
X-Google-Smtp-Source: APXvYqxNCs6DbQu37ZInG0rcBLjzcvest/ipCGkv0dyIbljMc3Tt2hEnU8TkkujXFMd+T0/DBrD/pg==
X-Received: by 2002:a2e:8905:: with SMTP id d5mr30146595lji.59.1556557688315;
        Mon, 29 Apr 2019 10:08:08 -0700 (PDT)
Received: from localhost (h85-30-9-151.cust.a3fiber.se. [85.30.9.151])
        by smtp.gmail.com with ESMTPSA id v141sm7367069lfa.52.2019.04.29.10.08.06
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 29 Apr 2019 10:08:06 -0700 (PDT)
Date:   Mon, 29 Apr 2019 09:51:37 -0700
From:   Olof Johansson <olof@lixom.net>
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     Patrick Venture <venture@google.com>,
        Arnd Bergmann <arnd@arndb.de>, Joel Stanley <joel@jms.id.au>,
        Andrew Jeffery <andrew@aj.id.au>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>,
        linux-aspeed@lists.ozlabs.org, arm-soc <arm@kernel.org>,
        soc@kernel.org
Subject: Re: [PATCH v2] soc: add aspeed folder and misc drivers
Message-ID: <20190429165137.mwj4ehhwerunbef4@localhost>
References: <20190423142629.120717-1-venture@google.com>
 <CAO=notzjzpt0WHfJEWXMGgkoJU8UiLnqZnrGrPs-dRH5GNdJyQ@mail.gmail.com>
 <CAO=notz9QVoqKLrhJ3kx9FHja5+Mh68f36O36+1ewLG+SanmOA@mail.gmail.com>
 <20190425172549.GA12376@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190425172549.GA12376@kroah.com>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 25, 2019 at 07:25:49PM +0200, Greg KH wrote:
> On Tue, Apr 23, 2019 at 08:28:14AM -0700, Patrick Venture wrote:
> > On Tue, Apr 23, 2019 at 8:22 AM Patrick Venture <venture@google.com> wrote:
> > >
> > > On Tue, Apr 23, 2019 at 7:26 AM Patrick Venture <venture@google.com> wrote:
> > > >
> > > > Create a SoC folder for the ASPEED parts and place the misc drivers
> > > > currently present into this folder.  These drivers are not generic part
> > > > drivers, but rather only apply to the ASPEED SoCs.
> > > >
> > > > Signed-off-by: Patrick Venture <venture@google.com>
> > >
> > > Accidentally lost the Acked-by when re-sending this patchset as I
> > > didn't see it on v1 before re-sending v2 to the larger audience.
> > 
> > Since there was a change between v1 and v2, Arnd, I'd appreciate you
> > Ack this version of the patchset since it changes when the soc/aspeed
> > Makefile is followed.
> 
> I have no objection for moving stuff out of drivers/misc/ so the SOC
> maintainers are free to take this.
> 
> Acked-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

I'm totally confused. This is the second "PATCH v2" of this patch that I came
across, I already applied the first.

Patrick: Follow up with incremental patch in case there's any difference.
Meanwhile, please keep in mind that you're adding a lot of work for people when
you respin patches without following up on the previous version. Thanks!


-Olof

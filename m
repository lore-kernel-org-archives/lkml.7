Return-Path: <SRS0=B1dt=RW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 97469C43381
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Mar 2019 12:44:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5CFDC20685
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Mar 2019 12:44:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1552999448;
	bh=yy+NjBQpVl1nbxJ5l+cho0MSdRL0pZ6dR3SV7dmiiro=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=LptI/Rn1dqnzyS1Imr7aINhvYl249A98cRiWKW7jJC+2ZZmc+si6XlgPG2KbS+J7t
	 ae95pAaWMBsr+vpxaX04JGTUgczZMIyrTmzqZNBfWSU5NhQmwLuPeIyp3abY/Z5dgX
	 PYdwwHHuRREWTPWPXWAc1iyI2WrHnUFHMQUwDaJg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726969AbfCSMoG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Mar 2019 08:44:06 -0400
Received: from mail-lf1-f66.google.com ([209.85.167.66]:38627 "EHLO
        mail-lf1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726053AbfCSMoG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Mar 2019 08:44:06 -0400
Received: by mail-lf1-f66.google.com with SMTP id a6so11912953lfl.5;
        Tue, 19 Mar 2019 05:44:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=FcULlnaHiC6hq6LKuqWjCzK3UvY6QxCaEvk/2142440=;
        b=uInCrmJU2Qk75nRuag7tzuPlbVR1dynQSvRBZY7t4MdIY/ZhWorNZ3O/YgBqeUf2sS
         Q3ZRMN/1yV6evE8j6G6ondrxy/Qm/L2SJO3FNtyHdbz64SSi4q6o2xc2riVjooicIVZv
         pdrXQR8ObV9aIpL0DeMH1JzAnDJ+2Pg9fI1ysqU3/ALova/NRj01jdYGd+sXoySboFMF
         6ulMveqpja3DycDZIgFbB0sWYhK2xFwsJZvgKOUFX+hC0UliL0xTwLIWH1kh0A/iCUoY
         s/wnzgWRj4qcXR9DcIeXpVS3QCusbrYnNBdVUdZVaPh6foma3Qbo3QiQTDIJ/nmW3ryf
         mLUg==
X-Gm-Message-State: APjAAAU702eqjJ6wiVHla7G5cae5ikEIx5BW0A6zEWpKuDc/fcYP7Vf4
        bqUWxNTfdWt/Zg/PQB+DbaI=
X-Google-Smtp-Source: APXvYqzeW3HN/EHhyB0IjakA6kUdrtLBOcc6j1HIeBawt9p2OZV6nmqxdkcHRuTTWFsaUuMccpX5+A==
X-Received: by 2002:ac2:424e:: with SMTP id m14mr10516575lfl.4.1552999443976;
        Tue, 19 Mar 2019 05:44:03 -0700 (PDT)
Received: from xi.terra (c-74bee655.07-184-6d6c6d4.bbcust.telenor.se. [85.230.190.116])
        by smtp.gmail.com with ESMTPSA id y22sm2760695ljh.12.2019.03.19.05.44.02
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 19 Mar 2019 05:44:03 -0700 (PDT)
Received: from johan by xi.terra with local (Exim 4.91)
        (envelope-from <johan@kernel.org>)
        id 1h6E62-0001XE-Mj; Tue, 19 Mar 2019 13:43:58 +0100
Date:   Tue, 19 Mar 2019 13:43:58 +0100
From:   Johan Hovold <johan@kernel.org>
To:     =?iso-8859-1?Q?M=E5ns_Rullg=E5rd?= <mans@mansr.com>
Cc:     Johan Hovold <johan@kernel.org>,
        =?iso-8859-1?Q?Bj=F8rn?= Mork <bjorn@mork.no>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] USB: serial: option: set driver_info for SIM5218 and
 compatibles
Message-ID: <20190319124358.GK6124@localhost>
References: <20190226170710.12709-1-mans@mansr.com>
 <20190227083342.GJ4747@localhost>
 <yw1xpnrdv3z7.fsf@mansr.com>
 <20190227131315.GO4747@localhost>
 <yw1xlg21uwrp.fsf@mansr.com>
 <20190319102840.GI6124@localhost>
 <yw1xd0mn16ev.fsf@mansr.com>
 <20190319110819.GB3178@localhost>
 <yw1x8sxb125q.fsf@mansr.com>
 <20190319122719.GC3178@localhost>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20190319122719.GC3178@localhost>
User-Agent: Mutt/1.11.3 (2019-02-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 19, 2019 at 01:27:19PM +0100, Johan Hovold wrote:
> On Tue, Mar 19, 2019 at 12:25:53PM +0000, Måns Rullgård wrote:
> > Johan Hovold <johan@kernel.org> writes:
> > 
> > > On Tue, Mar 19, 2019 at 10:54:00AM +0000, Måns Rullgård wrote:
> > >> Johan Hovold <johan@kernel.org> writes:
> > >
> > >> >> Regardless, setting the NCTRL flag should be harmless.
> > >> >
> > >> > Well, there are devices that depend on getting these requests, at least
> > >> > for the QMI interface. But we can always revert if anyone complains.
> > >> 
> > >> The QMI interface doesn't even pretend to be a uart.  The other ones do,
> > >> but there isn't actually any real uart behind them.  For instance, it
> > >> doesn't matter what baud rate one sets.
> > >
> > > Sure, but some devices still require "DTR" to be set for the QMI
> > > interface, so there not being any real uart is no guarantee that there
> > > is no firmware that expects these calls.
> > 
> > Now I'm thoroughly confused.  The QMI interface has a completely
> > separate driver that creates a network device (if I'm reading the code
> > correctly).
> 
> I was just giving an example of firmware sometimes doing unexpected
> things.

See 93725149794d ("net: qmi_wwan: MDM9x30 specific power management")
for some background.

Johan

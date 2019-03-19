Return-Path: <SRS0=B1dt=RW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 881B1C43381
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Mar 2019 12:27:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 552AE20857
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Mar 2019 12:27:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1552998449;
	bh=c3cERwzCcVr70RgnYD77NPFJRdMdJkuOJ35NCD3PgqA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=m6EV776iMR9d9Bowf6NKw7c9WY7YUv/C8xOwxie+VImI7eAJp3NZSlKlYUI5WoCba
	 LQZdaHf7tEUmDJTyPai5iWKQIXOaXq6xYdQp1JOiMgsA9NOtJMwGlfBhreb9qyxcOO
	 5U02jGRZH6DaAZnhR33PYgMcxZUtowaARp0nhNKg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727471AbfCSM11 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Mar 2019 08:27:27 -0400
Received: from mail-lj1-f194.google.com ([209.85.208.194]:41791 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726349AbfCSM11 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Mar 2019 08:27:27 -0400
Received: by mail-lj1-f194.google.com with SMTP id z25so17150862ljk.8;
        Tue, 19 Mar 2019 05:27:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=EOtxV1S7nsSR1tDpxM1gZ37uDNTaL9C8dUZd7AjgiQk=;
        b=YUC1n1Tx8tUXypU328eS4uweXeZnLqs8lUNdOJoWvyoDmLahUaXcuCUV88TIngRgdZ
         YUqjZF8WRjsPnDK+b9IlJ9DXj2qoLHScCRixO+8aahCUwnEuImqZt5Yavi8r1LIfr+j1
         gpP2+YeOi4lC6OTvzf5YEdXW5JhCGAIAHvBndzhQlua6wwPa+iIEDJl/F5dmDcbVCitO
         MnqXExu9OJ2Sq4NA79enCk4U2W6F9jwsDq7tsq+oS3t0c6KgYBOizBeW6pCe5m9698/Q
         ShYIkbRP6jH2xPH/0ZrrUudHrujMRxpw7rZTXFMPeRSQ5QrAiNXRKzGbGs7dgxNngpn6
         7yHw==
X-Gm-Message-State: APjAAAWu0F1k1V9gwfXaKpcbME5zx8rStVBD/lmjZTnqmMu0glUlT6w7
        pu923ePP+L1rCXsu1HYJgKs=
X-Google-Smtp-Source: APXvYqzoQ7FAfYHbda7bgSvTEysC5dXJHfcZcPH7gGBLdus4lxlnWhRYkUUe+YQasmDYavBPXXuNuA==
X-Received: by 2002:a2e:5cc1:: with SMTP id q184mr13514671ljb.123.1552998445242;
        Tue, 19 Mar 2019 05:27:25 -0700 (PDT)
Received: from xi.terra (c-74bee655.07-184-6d6c6d4.bbcust.telenor.se. [85.230.190.116])
        by smtp.gmail.com with ESMTPSA id q17sm2337703lfb.13.2019.03.19.05.27.24
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 19 Mar 2019 05:27:24 -0700 (PDT)
Received: from johan by xi.terra with local (Exim 4.91)
        (envelope-from <johan@kernel.org>)
        id 1h6Dpv-0001Rf-F1; Tue, 19 Mar 2019 13:27:20 +0100
Date:   Tue, 19 Mar 2019 13:27:19 +0100
From:   Johan Hovold <johan@kernel.org>
To:     =?iso-8859-1?Q?M=E5ns_Rullg=E5rd?= <mans@mansr.com>
Cc:     Johan Hovold <johan@kernel.org>,
        =?iso-8859-1?Q?Bj=F8rn?= Mork <bjorn@mork.no>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] USB: serial: option: set driver_info for SIM5218 and
 compatibles
Message-ID: <20190319122719.GC3178@localhost>
References: <20190226170710.12709-1-mans@mansr.com>
 <20190227083342.GJ4747@localhost>
 <yw1xpnrdv3z7.fsf@mansr.com>
 <20190227131315.GO4747@localhost>
 <yw1xlg21uwrp.fsf@mansr.com>
 <20190319102840.GI6124@localhost>
 <yw1xd0mn16ev.fsf@mansr.com>
 <20190319110819.GB3178@localhost>
 <yw1x8sxb125q.fsf@mansr.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <yw1x8sxb125q.fsf@mansr.com>
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 19, 2019 at 12:25:53PM +0000, Måns Rullgård wrote:
> Johan Hovold <johan@kernel.org> writes:
> 
> > On Tue, Mar 19, 2019 at 10:54:00AM +0000, Måns Rullgård wrote:
> >> Johan Hovold <johan@kernel.org> writes:
> >
> >> >> Regardless, setting the NCTRL flag should be harmless.
> >> >
> >> > Well, there are devices that depend on getting these requests, at least
> >> > for the QMI interface. But we can always revert if anyone complains.
> >> 
> >> The QMI interface doesn't even pretend to be a uart.  The other ones do,
> >> but there isn't actually any real uart behind them.  For instance, it
> >> doesn't matter what baud rate one sets.
> >
> > Sure, but some devices still require "DTR" to be set for the QMI
> > interface, so there not being any real uart is no guarantee that there
> > is no firmware that expects these calls.
> 
> Now I'm thoroughly confused.  The QMI interface has a completely
> separate driver that creates a network device (if I'm reading the code
> correctly).

I was just giving an example of firmware sometimes doing unexpected
things.

Johan

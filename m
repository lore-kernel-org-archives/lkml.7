Return-Path: <SRS0=B1dt=RW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D8877C43381
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Mar 2019 11:08:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 98D2920857
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Mar 2019 11:08:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1552993708;
	bh=UuyGva1xXd6X9Pz9TBMJgUNeqND5yoGv6dRLG0KlbLY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=s1swvtXv5RGeq69wg0iol2qzdSiii5N92yiSvOiG47QxK/zK3Fv8vN2RuglF0Pssw
	 SrEYNXKLbwApjXWidcMx7glcksbGZfebyzLk20P5Wm9s6Bt06O9BzQ5msRVS83g8vs
	 QpgjplIog/J4Y2ocp1zxpRFLMjrntImXpAZROB4k=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727618AbfCSLI1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Mar 2019 07:08:27 -0400
Received: from mail-lf1-f66.google.com ([209.85.167.66]:41909 "EHLO
        mail-lf1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726573AbfCSLI0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Mar 2019 07:08:26 -0400
Received: by mail-lf1-f66.google.com with SMTP id 10so14067224lfr.8;
        Tue, 19 Mar 2019 04:08:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=nfNx76vxw5o8cvcXHmGlsBwNAKsYgzGyz/rzkq8VcPY=;
        b=rMWBadvOLF48YP6LuEcypWMxT42E7pdDZHtF7SjyRCFTzFniaARd541XQSlOs6kkSX
         z/9CbR2syp07Mpn+NFn//haU5MGWMIab3cKxE+ojMlqjd5oWnWE9Ucxm3KNhEuMQRv93
         3ruipanSF7c5r6XLjMHs0jnevE8FdDQOzT3NCQhLJuzu5RZX89Afp1fm4XE7FRuCI2pz
         xM5N1V27HzxPIYL1OvgXjyRIVu6IsRZXl4Jdok6HTsYyPb8kavSBS/n9ugKOTCptwNJb
         M1DbLRL1r3QZrzGFiLyDXWnDEx6l2Qmv2VEhrlufHbU/NX5bMs6MsKmU6Bhc1hlCsXr1
         hEVw==
X-Gm-Message-State: APjAAAVg14tu9RLoN9bZrgtc7GnrD2OEhtWrBLMzCGq7SZVE3tN9aSft
        D0WH6VxJiK3tVN6BlXz6l/PKWjgm
X-Google-Smtp-Source: APXvYqxYdFK16GVM3ag8QNToy/KR9H8ruifm0URA8AlT7LrjjPKzbGNqO27SJs52eIZBibuR6Ej8+w==
X-Received: by 2002:a19:4c41:: with SMTP id z62mr12708071lfa.9.1552993704585;
        Tue, 19 Mar 2019 04:08:24 -0700 (PDT)
Received: from xi.terra (c-74bee655.07-184-6d6c6d4.bbcust.telenor.se. [85.230.190.116])
        by smtp.gmail.com with ESMTPSA id b15sm2748635ljj.70.2019.03.19.04.08.23
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 19 Mar 2019 04:08:23 -0700 (PDT)
Received: from johan by xi.terra with local (Exim 4.91)
        (envelope-from <johan@kernel.org>)
        id 1h6CbT-00010H-9i; Tue, 19 Mar 2019 12:08:19 +0100
Date:   Tue, 19 Mar 2019 12:08:19 +0100
From:   Johan Hovold <johan@kernel.org>
To:     =?iso-8859-1?Q?M=E5ns_Rullg=E5rd?= <mans@mansr.com>
Cc:     Johan Hovold <johan@kernel.org>,
        =?iso-8859-1?Q?Bj=F8rn?= Mork <bjorn@mork.no>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] USB: serial: option: set driver_info for SIM5218 and
 compatibles
Message-ID: <20190319110819.GB3178@localhost>
References: <20190226170710.12709-1-mans@mansr.com>
 <20190227083342.GJ4747@localhost>
 <yw1xpnrdv3z7.fsf@mansr.com>
 <20190227131315.GO4747@localhost>
 <yw1xlg21uwrp.fsf@mansr.com>
 <20190319102840.GI6124@localhost>
 <yw1xd0mn16ev.fsf@mansr.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <yw1xd0mn16ev.fsf@mansr.com>
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 19, 2019 at 10:54:00AM +0000, Måns Rullgård wrote:
> Johan Hovold <johan@kernel.org> writes:

> >> Regardless, setting the NCTRL flag should be harmless.
> >
> > Well, there are devices that depend on getting these requests, at least
> > for the QMI interface. But we can always revert if anyone complains.
> 
> The QMI interface doesn't even pretend to be a uart.  The other ones do,
> but there isn't actually any real uart behind them.  For instance, it
> doesn't matter what baud rate one sets.

Sure, but some devices still require "DTR" to be set for the QMI
interface, so there not being any real uart is no guarantee that there
is no firmware that expects these calls.

Johan

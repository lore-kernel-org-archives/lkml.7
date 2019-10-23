Return-Path: <SRS0=OaAC=YQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9EF66CA9EB6
	for <linux-kernel@archiver.kernel.org>; Wed, 23 Oct 2019 09:21:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 70D49214B2
	for <linux-kernel@archiver.kernel.org>; Wed, 23 Oct 2019 09:21:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1571822492;
	bh=Py2KmsQ35ZHIsjUTwsSFTEwaMBYyJtiCuUp5/4OKo+k=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=f+lCMvS1KZe4TcT7KkQ91P1ys5/+EzD3erJSc93+uIZGUre1iesI3lPNd0TY6r4kb
	 5l0sR42YCWpJ3NYRo4jQ43HRta72YBlG+wMwWGyLV+lG0g51VM6ccMu6Q9fTjZIzS3
	 UaKYRhNdHGKeMuDZR3baE2TFoDSUyIHePzHUDztM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2403811AbfJWJVb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 23 Oct 2019 05:21:31 -0400
Received: from mail-lj1-f195.google.com ([209.85.208.195]:43301 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2403786AbfJWJVb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Oct 2019 05:21:31 -0400
Received: by mail-lj1-f195.google.com with SMTP id n14so20262254ljj.10;
        Wed, 23 Oct 2019 02:21:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=oAvWf32cs9nydEjxKcrdLBkn5BfVkF2VrtJUIsWSQls=;
        b=GAiHyGsKAprh+2N4XSIToa2+Cm0WohiLhno9Elv/CtXR1HgVff7/ojUYp3TPdlYVHF
         1j1tsgOaFOiltzOSy4gwQlXqSSXNlE7ZcebU+NJZlvBqcQK2oS+/qFdHFE90ZrsPD1od
         LvGU62/CLbsa1yPlPhVw2H820m3IIp+7sMMCyxJ0M/yjnxyG5bSF/gzk+ViW266hGG/l
         J1a6uZgpmZhwiqjUc7f1UioWu9QyrxxXn8cLtGBBQO5Hm4lEBJfq3arhVVQBBvvUYMEH
         qysq+zK7fD79/n3+rqIwpUrNM7g5K63uRCkz5hBQQ8ZZuHx8friZY52OzYQPDEPvOdNX
         tNIQ==
X-Gm-Message-State: APjAAAXoXWDppKK1cU68Ym4i9/EH9FogStKBV8TkMOOTfT0seouuykQj
        KCPOPq0pu52viRUlLPPajQc=
X-Google-Smtp-Source: APXvYqxgMg0dn2c4IzAoL+dPByBlECYdx47si7GdCCbNRf1KcqRIJa5XFGwh/ZMEaLpkKr4+aLUDpQ==
X-Received: by 2002:a2e:b537:: with SMTP id z23mr1737863ljm.129.1571822488955;
        Wed, 23 Oct 2019 02:21:28 -0700 (PDT)
Received: from xi.terra (c-51f1e055.07-184-6d6c6d4.bbcust.telenor.se. [85.224.241.81])
        by smtp.gmail.com with ESMTPSA id w30sm9483060lfn.82.2019.10.23.02.21.27
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 23 Oct 2019 02:21:27 -0700 (PDT)
Received: from johan by xi.terra with local (Exim 4.92.2)
        (envelope-from <johan@kernel.org>)
        id 1iNCps-0006XJ-Go; Wed, 23 Oct 2019 11:21:44 +0200
Date:   Wed, 23 Oct 2019 11:21:44 +0200
From:   Johan Hovold <johan@kernel.org>
To:     "Ji-Ze Hong (Peter Hong)" <hpeter@gmail.com>
Cc:     johan@kernel.org, gregkh@linuxfoundation.org,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        peter_hong@fintek.com.tw,
        "Ji-Ze Hong (Peter Hong)" <hpeter+linux_kernel@gmail.com>
Subject: Re: [PATCH V2 0/7] Add Fintek F81534A series usb-to-serial driver
Message-ID: <20191023092144.GR24768@localhost>
References: <20190923022449.10952-1-hpeter+linux_kernel@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190923022449.10952-1-hpeter+linux_kernel@gmail.com>
User-Agent: Mutt/1.12.2 (2019-09-21)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 23, 2019 at 10:24:42AM +0800, Ji-Ze Hong (Peter Hong) wrote:
> The Fintek F81532A/534A/535/536 is USB-to-2/4/8/12 serial ports device
> and the serial port is default disabled when plugin computer.
> 
> The part number is a bit same with F81532/534, but F81534A series UART
> core is enhanced from F81232, not F81532/534.  
> 
> The IC is contains devices as following:
> 	1. HUB (all devices is connected with this hub)
> 	2. GPIO/Control device. (enable serial port and control all GPIOs)
> 	3. serial port 1 to x (2/4/8/12)
> 
> It's most same with F81232, the UART device is difference as follow:
> 	1. TX/RX bulk size is 128/512bytes
> 	2. RX bulk layout change:
> 		F81232: [LSR(1Byte)+DATA(1Byte)][LSR(1Byte)+DATA(1Byte)]...
> 		F81534A:[LEN][Data.....][LSR]
> 
> We'll try to do some code refacting before add F81534A series.

Make sure to always provide a changelog when sending an updated series
(either here for the entire series or below the --- line in the
individual patches).

What has changed since v1?

> Ji-Ze Hong (Peter Hong) (7):
>   USB: serial: f81232: Extract LSR handler
>   USB: serial: f81232: Add tx_empty function
>   USB: serial: f81232: Use devm_kzalloc
>   USB: serial: f81232: Add F81534A support
>   USB: serial: f81232: Set F81534A serial port with RS232 mode
>   USB: serial: f81232: Add generator for F81534A
>   USB: serial: f81232: Add gpiolib to GPIO device
> 
>  drivers/usb/serial/f81232.c | 604 ++++++++++++++++++++++++++++++++++--
>  1 file changed, 570 insertions(+), 34 deletions(-)

Johan

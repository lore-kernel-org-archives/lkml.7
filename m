Return-Path: <SRS0=XcGb=25=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 43467C33CA2
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Jan 2020 14:45:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1A5482053B
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Jan 2020 14:45:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1578494756;
	bh=+YPIVDK8gKVcneAy0zEyAq0LIP7PGGLTkUsSyo5PmXE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=mzam2fNNvJfpMod5d3tFGHnWxmOPpeXc0MXvxh6lB28epFMJUI2ZjQAnMWBB6sGh2
	 fCsspeMyD/SOEX2znjbPVGPM1UnDpsu33uFst+5d4z3Ui9d+nfvJzJum71K4sN+tSS
	 oUB5crztsOmesFXfrCJhB5taqv5qHgVkyzuDpo7A=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728541AbgAHOpz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 Jan 2020 09:45:55 -0500
Received: from mail-lj1-f194.google.com ([209.85.208.194]:36956 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726697AbgAHOpz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Jan 2020 09:45:55 -0500
Received: by mail-lj1-f194.google.com with SMTP id o13so3597061ljg.4;
        Wed, 08 Jan 2020 06:45:53 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=c+kKmDJHi7cB9OTqpdYGSI2iBAodqU59kVDu+/v1OuE=;
        b=M4oG7U0a0zA34RF/C9NACDrbR0FAJf7uhJPxClf1vM4kPCOyYOsuivuN2XrUBLShWE
         PRF0gPseN5xNNY/8Wjp1uJERrW3Li+tuYWr1aWv0ZKY684Lxb3n+iz5GIm8M1werw3Xw
         aA2jCSHlRMTMwYQ23mEMdbsNEpGvKCkr19oJzkuF8We0A4SIlntOpwlChooT9JRQZ6XF
         l4yA+XTUKs1fw4rzoTFNpNaykGZBIgwB/M/2v6C2q1bMmW944sH4bhfxiRFvH0BXlg2g
         5jiPxniJ8p2l4l41CY4sq/AnA1MXaLj9V2Y5vk+oL8RVtxrwzLbTtdd/CPTfDM0pwAT2
         2KZQ==
X-Gm-Message-State: APjAAAVhRqNCuFCsf5ckDQ0Uvb2HethSGWbEBoWqVvudSHg32rjnbXzW
        ZnNF7dKNn5+DLzCk2F3K3t8=
X-Google-Smtp-Source: APXvYqzXpGwW54vY+BpaKhSw0eGm8pnVpqeRJ6SGF2RtZLq/HhdbuIOEWZnf+LZDEm6wtClweyDFyg==
X-Received: by 2002:a2e:880a:: with SMTP id x10mr3070313ljh.211.1578494752687;
        Wed, 08 Jan 2020 06:45:52 -0800 (PST)
Received: from xi.terra (c-14b8e655.07-184-6d6c6d4.bbcust.telenor.se. [85.230.184.20])
        by smtp.gmail.com with ESMTPSA id y8sm1386428lji.56.2020.01.08.06.45.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Jan 2020 06:45:51 -0800 (PST)
Received: from johan by xi.terra with local (Exim 4.92.3)
        (envelope-from <johan@kernel.org>)
        id 1ipCau-0001Hu-Sx; Wed, 08 Jan 2020 15:46:00 +0100
Date:   Wed, 8 Jan 2020 15:46:00 +0100
From:   Johan Hovold <johan@kernel.org>
To:     "Ji-Ze Hong (Peter Hong)" <hpeter@gmail.com>
Cc:     Johan Hovold <johan@kernel.org>, gregkh@linuxfoundation.org,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        peter_hong@fintek.com.tw,
        "Ji-Ze Hong (Peter Hong)" <hpeter+linux_kernel@gmail.com>
Subject: Re: [PATCH V2 7/7] USB: serial: f81232: Add gpiolib to GPIO device
Message-ID: <20200108144600.GK30908@localhost>
References: <20190923022449.10952-1-hpeter+linux_kernel@gmail.com>
 <20190923022449.10952-8-hpeter+linux_kernel@gmail.com>
 <20191023122208.GW24768@localhost>
 <ef91b42d-e81d-ecdd-c688-0cb3f0b94906@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ef91b42d-e81d-ecdd-c688-0cb3f0b94906@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 30, 2019 at 10:00:12AM +0800, Ji-Ze Hong (Peter Hong) wrote:
> Hi Johan,
> 
> Johan Hovold 於 2019/10/23 下午 08:22 寫道:
> > On Mon, Sep 23, 2019 at 10:24:49AM +0800, Ji-Ze Hong (Peter Hong) wrote:
> >> The Fintek F81534A series contains 3 GPIOs per UART and The max GPIOs
> >> is 12x3 = 36 GPIOs and this patch will implements GPIO device as a
> >> gpiochip to control all GPIO pins even transforms to transceiver pins.
> > 
> > Depending to your answer to my question whether these pins are truly
> > general purpose or not, this may not be the right interface.
> 
> Our F81534A series contains F81532A/534A/535/536. For the following link
> of F81534A pin-out:
> 	https://imgur.com/a/AZHqQ1N
> 
> We had 2 type about GPIO pins, MODEx_y & GPIOxx. All MODEx_y & GPIOxx
> are GPIOs and can be controlled by GPIO device, but they had some
> difference about usage.
> 	MODEx_y:
> 		1. 3 pins(x: 0/1/2) can be access by UART port y.
> 		2. Used to control UART's transceiver normally, but it
> 		   also can be configure as GPIO when UART disabled by
> 		   H/W (DTR strap to GND).
> 	GPIOxx:
> 		1. Access only by GPIO device.
> 
> The series patch only support RS233 mode for all serial port, So we'll
> direct set all MODEx_y to (0/0/1) for our demo board for default. If
> user really want to use the pin, we had provide the gpiolib with GPIO
> device, but we'll recommend user to use GPIOxy first.

Do you mean that you'd need to register a separate gpio chip per port in
order to expose an interface for changing the MODEx_y pins for an
enabled UART? Or can you do that through the "global" gpio device?

> Is any suggest about this ? Could I maintain this for this series patch?

I understood from your other mail that the gpio device would not be able
to control the pins of an enabled port. In either case, I think you need
to refuse a request for a pin that's already in use by the corresponding
port.

Also is there a way to determine the number of available pins by
detecting the chip/package type? I'm assuming not all 36 pins are always
accessible?

> >> +	status = devm_gpiochip_add_data(&intf->dev, &priv->chip, priv);
> >> +	if (status) {
> >> +		dev_err(&intf->dev, "failed to register gpiochip: %d\n",
> >> +				status);
> >> +		return status;
> >> +	}
> > 
> > Have you tried disconnecting the device with gpios requested? This used
> > to break gpiolib, but was fixed. Just want to make sure it hasn't
> > regressed.
> 
> I had try export GPIOs and detach the F81534A in kernel 5.0.0, it seems
> no problem. Is any link about this issue for me to do more test ?

Then it's hopefully fine. Thanks for verifying.

Johan

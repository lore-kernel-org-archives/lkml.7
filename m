Return-Path: <SRS0=a4+J=26=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 37E7AC33C9E
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Jan 2020 02:43:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 082492070E
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Jan 2020 02:43:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Jy21N5M1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727960AbgAICnv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 Jan 2020 21:43:51 -0500
Received: from mail-pf1-f196.google.com ([209.85.210.196]:39426 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727884AbgAICnu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Jan 2020 21:43:50 -0500
Received: by mail-pf1-f196.google.com with SMTP id q10so2601997pfs.6;
        Wed, 08 Jan 2020 18:43:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=RhY8GTZhfaP75ugnG9uBkRt3jDLbfbf7XwKJDnHpA9g=;
        b=Jy21N5M1F7zTvapQPSsyY98ki9Gnih+f9EhbCGKrt1iBrY3BAmOHsEbt4eqdxlR7Im
         /bM99l2z64BFfp6GUik7nNmnzGI+VCc/jUMwkO6Go0wt2ChVqEmeKizmYPUk9wZzZDII
         zQSXomeQauss0DNPLOudoLFK3XsWk2wgxtfigpiUjwXcEO+m9Hm1Y7Aod2uIjyJ3JPcm
         y/FQuwHgeM/L2Yh8PtvY2b7/U2vciMDFTs0n+FosJjUCLsWgQuArKfAHPxciv8dtwwCo
         QUQmalVqCHibfjpvSJStnCEOO+IlgGXhszwUCGkCh5QeWQhs8vmRT1aNmEwdwep/UknP
         BADg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=RhY8GTZhfaP75ugnG9uBkRt3jDLbfbf7XwKJDnHpA9g=;
        b=D60BgHKqPCQZRJjcLFXG0VKm79O8uK1vdxjNcxwnujgop47/FCnDHh/yGRmLrBi/T8
         STFylw09UFLO9mbqVRBdxSMsZuxav0KBAHuex1yYBoaj5xKaOPxWQkf5OF2uSRcbVVGr
         X7/zGzJ4eaAkQUyIWAmIZW/k/9s5qU80z57vAikPjhhKJ1GL+r1TcdKzHMaNecghCM2N
         IgXInOB1KmrjHvNuuVebJGy2qoZ3+V7STJ73sxiTnzhAhkiR+Po7w4UY1Fzed8VR7duh
         GQmBW6927UKJWU5+/705DzHHz+N3EcMGdohzsTXBUS/1wMwJvHr7GEv2pJL2xRjvOkC2
         xJ2g==
X-Gm-Message-State: APjAAAWajUHThxphDaCjZpiRbCBYK6wYQDEQHZVZWoSujO+Uw0JbRCAC
        Tz8S/ScSI7qVFl3Kc7dySw0=
X-Google-Smtp-Source: APXvYqyPlo6A/2anGMn9odETNKUmUN3DtimATDHq05U8OR2czkMBBNhG97e69o3fBqO48PRYc6inrg==
X-Received: by 2002:aa7:8e13:: with SMTP id c19mr8741487pfr.227.1578537830015;
        Wed, 08 Jan 2020 18:43:50 -0800 (PST)
Received: from [192.168.1.60] (59-120-186-245.HINET-IP.hinet.net. [59.120.186.245])
        by smtp.gmail.com with ESMTPSA id r2sm4876361pgv.16.2020.01.08.18.43.47
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 08 Jan 2020 18:43:49 -0800 (PST)
Subject: Re: [PATCH V2 7/7] USB: serial: f81232: Add gpiolib to GPIO device
To:     Johan Hovold <johan@kernel.org>
Cc:     gregkh@linuxfoundation.org, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org, peter_hong@fintek.com.tw,
        "Ji-Ze Hong (Peter Hong)" <hpeter+linux_kernel@gmail.com>
References: <20190923022449.10952-1-hpeter+linux_kernel@gmail.com>
 <20190923022449.10952-8-hpeter+linux_kernel@gmail.com>
 <20191023122208.GW24768@localhost>
 <ef91b42d-e81d-ecdd-c688-0cb3f0b94906@gmail.com>
 <20200108144600.GK30908@localhost>
From:   "Ji-Ze Hong (Peter Hong)" <hpeter@gmail.com>
Message-ID: <2908e99e-ae4e-9385-92af-58381aa119a9@gmail.com>
Date:   Thu, 9 Jan 2020 10:43:48 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.1
MIME-Version: 1.0
In-Reply-To: <20200108144600.GK30908@localhost>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Johan,

Johan Hovold 於 2020/1/8 下午 10:46 寫道:
> On Wed, Oct 30, 2019 at 10:00:12AM +0800, Ji-Ze Hong (Peter Hong) wrote:

>> We had 2 type about GPIO pins, MODEx_y & GPIOxx. All MODEx_y & GPIOxx
>> are GPIOs and can be controlled by GPIO device, but they had some
>> difference about usage.
>> 	MODEx_y:
>> 		1. 3 pins(x: 0/1/2) can be access by UART port y.
>> 		2. Used to control UART's transceiver normally, but it
>> 		   also can be configure as GPIO when UART disabled by
>> 		   H/W (DTR strap to GND).
>> 	GPIOxx:
>> 		1. Access only by GPIO device.
>>
>> The series patch only support RS233 mode for all serial port, So we'll
>> direct set all MODEx_y to (0/0/1) for our demo board for default. If
>> user really want to use the pin, we had provide the gpiolib with GPIO
>> device, but we'll recommend user to use GPIOxy first.
> 
> Do you mean that you'd need to register a separate gpio chip per port in
> order to expose an interface for changing the MODEx_y pins for an
> enabled UART? Or can you do that through the "global" gpio device?

No, I still implement the gpiolib in GPIO Device. Sorry for bad
describe.

>> Is any suggest about this ? Could I maintain this for this series patch?
> 
> I understood from your other mail that the gpio device would not be able
> to control the pins of an enabled port. In either case, I think you need
> to refuse a request for a pin that's already in use by the corresponding
> port.

OK, I'll change the code as previous mail as following:

I can read the UART enable state from GPIO Device, so I can do when the
GPIO is associated with UART enabled, change it as output only otherwise
can be set to input/output.

> Also is there a way to determine the number of available pins by
> detecting the chip/package type? I'm assuming not all 36 pins are always
> accessible?

Yes, we had register to get package type, I'll add UART enable & package
type to determinate final GPIO pin out.

-- 
With Best Regards,
Peter Hong

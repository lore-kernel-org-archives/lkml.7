Return-Path: <SRS0=vU+5=XP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8B1EDC4CEC9
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Sep 2019 20:15:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5DBA8217F5
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Sep 2019 20:15:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KXKI5iR+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728844AbfITUPP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 20 Sep 2019 16:15:15 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:35946 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725842AbfITUPP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Sep 2019 16:15:15 -0400
Received: by mail-wr1-f65.google.com with SMTP id y19so8030093wrd.3;
        Fri, 20 Sep 2019 13:15:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=YmwvldoBPWC/WT/RXbjQtuTjZqYBNPW2mhbUP/g7mkk=;
        b=KXKI5iR+QlI/KdDF+TIMTQSlIAEIU2NwdpjFNc77gTncHwCvgnKDhePDMeIjIZE21o
         fk7io/Zq82vh7JgzlX7ZEaben9WMf+nAuHjT3Kcf5JbG8OeNxKDLguEe/SForVK9sxJN
         eKjU2vhPKI14DwZoFCvVEEfjdKrB0Al82TRTLedoaxeFX9V9S5he7TT7P5/HEpcX8hhI
         3FPCkC75lqUP/F06P9hAFD+dMVV2J38iSSaGjASUVGzZx4LMax+pjJWk8FmWBIUMlXDN
         zwyumFFjA/Of7xc3IQnBgohzEsoEh1RwmIKet7Xwdp+c2+BRqZbMle2gp17fMmw8HC/2
         D+uw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=YmwvldoBPWC/WT/RXbjQtuTjZqYBNPW2mhbUP/g7mkk=;
        b=M5Tv3HC6LRQo+eFHrSNhtIyFbmEzfN0IFYWWxAhW0jmjcursKm/ZUjzFlSBCby4r9J
         7VFD8iBU23vsuiyoZj0cWXKMZhtXKQ4Tv+4X2N2GmqomFhnMDn/Moloz4QrRRZlFJT9k
         8AIoAQysTI18AXkEoi9qU/JGyW3zF/jO6Xio+3SAQMmJpI1XatHIAjRDbdwsng3uxrOx
         93xSiX03SJWHdYOzIOPK9GBCk/qbX0jvLfNngK4IykXBiZ21tsjnLlAmJb3bK+xM5Cxl
         tmeUqc8HvXgvERmc8AzaAk3RgECVEsAp0DJkTxoTEKg9pvp6N68foKaZrDDFu25zRxMP
         kI8A==
X-Gm-Message-State: APjAAAXSE9OIGN0I7fcGZXe7iauv8fX7/eFjQZNBdt8ITrX1Do9Ntifl
        0pFSP7NwaKDO0BNc5Z5SNn1jy/wr
X-Google-Smtp-Source: APXvYqx6+sdaU70hXxlIPqhW+U3FE2jByAg2cQMt0HBe9NU57j4N0yDakGpC6HOgeDCGa0SnXE2Ouw==
X-Received: by 2002:adf:f406:: with SMTP id g6mr12752046wro.325.1569010512960;
        Fri, 20 Sep 2019 13:15:12 -0700 (PDT)
Received: from [192.168.2.202] (pD9E5A855.dip0.t-ipconnect.de. [217.229.168.85])
        by smtp.gmail.com with ESMTPSA id w22sm2121846wmc.16.2019.09.20.13.15.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 20 Sep 2019 13:15:12 -0700 (PDT)
Subject: Re: [PATCH] serdev: Add ACPI devices by ResourceSource field
To:     Hans de Goede <hdegoede@redhat.com>
Cc:     Rob Herring <robh@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jslaby@suse.com>, Johan Hovold <johan@kernel.org>,
        "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Len Brown <lenb@kernel.org>, linux-serial@vger.kernel.org,
        linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20190919195624.1140941-1-luzmaximilian@gmail.com>
 <79c9533f-882d-f2b2-b6f3-b94fa49b4367@redhat.com>
From:   Maximilian Luz <luzmaximilian@gmail.com>
Message-ID: <d5e07b37-c295-91d0-30b4-b12065d2d302@gmail.com>
Date:   Fri, 20 Sep 2019 22:15:10 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.0
MIME-Version: 1.0
In-Reply-To: <79c9533f-882d-f2b2-b6f3-b94fa49b4367@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 9/20/19 10:50 AM, Hans de Goede wrote:
> Also I will give this a test-run on some of the existing devices
> which rely on the instantiation of serdev devices for ACPI
> devices which are childs of the uart device.

Thank you for testing! Will get to your other mail shortly.

> Given the above I think you may want to also limit your patch to
> only instantiate a "struct device" for the first UARTSerialBusV2
> in an ACPI "Device()"'s  .

Right, I will change this for a v2 once the issue revealed by your
testing has been resolved.

> I hope this sheds some clarity on the (muddy) situation wrt
> I2cSerialBusV2 handling.

Thank you again, this has definitely helped clear things up for me and
your write-up is much appreciated!

Maximilian

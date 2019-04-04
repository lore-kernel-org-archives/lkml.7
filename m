Return-Path: <SRS0=oHH8=SG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7E17EC4360F
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Apr 2019 19:19:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3B930206B7
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Apr 2019 19:19:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lUE3HzS6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730153AbfDDTTE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Apr 2019 15:19:04 -0400
Received: from mail-lj1-f193.google.com ([209.85.208.193]:38913 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729287AbfDDTTD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Apr 2019 15:19:03 -0400
Received: by mail-lj1-f193.google.com with SMTP id l7so3096034ljg.6;
        Thu, 04 Apr 2019 12:19:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=IOcByKgWkhNPR7VGqye1hdXmhaO5+cKt2JnMSjliStI=;
        b=lUE3HzS6Gh9JCIfihkLjYlWAjoUVf1Djs4maEAdvd2yExT9R2dJJTySk0e3kX1PIQz
         GIYB0NKdaDTEA9XArFAzBuVhr3THQauYFs1KjcWbNx5ww7+AA/sPD+p9Msey8rr/4bNe
         RYSOEsB+cvwLYOfrIUcc5v8hOcpsGKvDOfhtlMXMNLkrkLD6xVg/hyQkYT3igRO3EGI5
         d4OiAycQ2q1HAkV8UEwei1D/6K9ww80bpYv59Zvgsk10edG780tAk2wjTgKTOa/QvUGZ
         QIcHbhx92pdITBSzhLL/YrF/bJbWY3IGY75iiZrnCtod7W+9CRN67VPyusDzwXm4ZzDJ
         LW5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=IOcByKgWkhNPR7VGqye1hdXmhaO5+cKt2JnMSjliStI=;
        b=g0IroZOCboR3kkkCf1K27s/7tThliD9PjNh09ZG+RQPtUpFozjFpQzfnJU/mGYhgkE
         B9wzZFCachDOTXmrq8Iw5/px3DTUM8eb/3VjEzmcN1RahbmK1AZ4wJPBuW6zoQKJ84EZ
         RA/dZAZduldkc8DulH2jF1s+cOv17cBnA1p0bQ7eAVuK1opImm7a8DHnN+JRWMkjeUsm
         5QxlCCovatfqEuR4r9lZYUcMEimBDOzX61hNsy56Y51BVusC+x87O9Lmfd3tIXYMOBXx
         DAwF0DbOcEgpR/XiS+NaZypZ++dINrhVGOb+Jdb95HZWuYSSx2wWZ3P8r1kJlGd2iaTQ
         +X0A==
X-Gm-Message-State: APjAAAWWVwX0aa/4gyj7vB9Owr2wLx/bCDgh3lGTcarx/rEZrUqpxS3T
        JkOt+CBlSwmZMdylwAu5OTQjxaaD
X-Google-Smtp-Source: APXvYqzbQIxW/l43kV6IHoFqCJt/Eg2iY9MLPZoGQKKr0P3BRmyhLAIj2bjan8UtEiCJg4s3IWQkZA==
X-Received: by 2002:a2e:91d2:: with SMTP id u18mr4691653ljg.161.1554405541582;
        Thu, 04 Apr 2019 12:19:01 -0700 (PDT)
Received: from [192.168.1.19] (dkj99.neoplus.adsl.tpnet.pl. [83.24.13.99])
        by smtp.gmail.com with ESMTPSA id 1sm4155164ljw.56.2019.04.04.12.18.59
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 04 Apr 2019 12:19:00 -0700 (PDT)
Subject: Re: [PATCH v3 00/25] Add generic support for composing LED class
 device name
To:     Pavel Machek <pavel@ucw.cz>
Cc:     linux-leds@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, robh@kernel.org
References: <20190331175501.23471-1-jacek.anaszewski@gmail.com>
 <20190404132157.GB6124@xo-6d-61-c0.localdomain>
From:   Jacek Anaszewski <jacek.anaszewski@gmail.com>
Message-ID: <c1ebb90a-2474-d279-0600-0f6707a7b1a6@gmail.com>
Date:   Thu, 4 Apr 2019 21:18:58 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190404132157.GB6124@xo-6d-61-c0.localdomain>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Pavel,

On 4/4/19 3:21 PM, Pavel Machek wrote:
> Hi!
> 
> I have not yet gone through the series in great detail.
> 
> This will change the userland ABI, right? Now, I understand that old ABI is bad, but
> will it break someone's code?

It will not break anyone since the generic support for composing
LED names is used only if struct init_data is provided. Otherwise
led_cdev->name property is taken as is for the LED class device name.

Moreover, it is safe to switch many of existing DT (or fwnode in
general) based drivers to using generic mechanism.
If the DT provides label property it will be concatenated with the
led_hw_name provided by the driver. The problem would be only with
the drivers whose bindings erroneously require devicename section
in the label. They will need to be left intact.

-- 
Best regards,
Jacek Anaszewski

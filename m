Return-Path: <SRS0=hRvo=UZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 86F4DC4646B
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Jun 2019 05:49:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 58A13208E3
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Jun 2019 05:49:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BguRsox6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726667AbfFZFtg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Jun 2019 01:49:36 -0400
Received: from mail-yb1-f193.google.com ([209.85.219.193]:37498 "EHLO
        mail-yb1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725790AbfFZFtg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Jun 2019 01:49:36 -0400
Received: by mail-yb1-f193.google.com with SMTP id p201so405133ybg.4;
        Tue, 25 Jun 2019 22:49:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=FLRyyUyuqTKbfuiIxj3YsbjK74R9lyj03vqxwLtsrQA=;
        b=BguRsox6h/qJV4eeNuftnjwImpoOBaTMM+ZxODhqBau2qM0uqSm3DbQhxrF+09eatF
         yEujr0vRThsycLh+ocSTu6M+2l1lDStjThzWGIWJo4joANPDqr6xxPJu1Fr27bl3Bf0u
         511zsXeswlJWII9yjG7ewy+pdNUXdsEG6iquXU3Y+2VNZnKFjrqeNHvY+T+rJ9icGMZY
         NDFbakjdcW2I2+1dCnNRYVtpmJ59RbX+mgG/Xqh9x8ORjMEpSyq+kDES+rsgILFih8Gt
         srdVNSrwT+q/Alxpi4bhZ/gh8w39Pv1SqrViab0mgdxdm4SXQV7iqF658d3r5hKv/Cyq
         dkVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=FLRyyUyuqTKbfuiIxj3YsbjK74R9lyj03vqxwLtsrQA=;
        b=tPy3vac01WcElU3QxOSC7nx7ndPxFQm7R/O1VIAgh6Y1M6Rddck94OE4Bg1ZjoMBst
         B5jeHsw/BvhgUsymtJjiZz2zmoogItaip/zMqvcHfceFUzCeWdGaUuE/mZpCBOSVIfTN
         5y+ackupt13E8O10XaEjLmWhw8PbGNcPVY2by4T8s+KcukaNunF0/L/UyUqlFI1DQMeI
         MscadTjyBVUbEDYTbweKRXjeDvFiLEerQC3ukSiraSM5WUBQTLDBw5m+quzYOLWNIX/o
         hhGpK9HzOYRYt2+ZWeO3LdAzBls6SI+3kzQ7bYY3AQzGTFyB2P60QNVICG1bAeFAX7V0
         Q1TQ==
X-Gm-Message-State: APjAAAUDH4sXG9J4LNIYYj+vuw4YmZFY61OM12Y3JZRL9cAetqXqESLN
        McJZOVCY49Qr4knOn5oaEVY=
X-Google-Smtp-Source: APXvYqxB5EKk0BXWRFX4VoMgn+lBpogZBtaCwNZ5pmK2sYGd/RHlDbpCU+tLYl3lG7Tt5x5yKBbEQQ==
X-Received: by 2002:a25:1f09:: with SMTP id f9mr1507101ybf.184.1561528175767;
        Tue, 25 Jun 2019 22:49:35 -0700 (PDT)
Received: from [192.168.43.210] (mobile-166-172-58-106.mycingular.net. [166.172.58.106])
        by smtp.gmail.com with ESMTPSA id 135sm1623784ywk.46.2019.06.25.22.49.33
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 25 Jun 2019 22:49:35 -0700 (PDT)
Subject: Re: [RESEND PATCH v1 0/5] Solve postboot supplier cleanup and
 optimize probe ordering
To:     Sandeep Patil <sspatil@android.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Saravana Kannan <saravanak@google.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        David Collins <collinsd@codeaurora.org>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel-team@android.com
References: <20190604003218.241354-1-saravanak@google.com>
 <20190624223707.GH203031@google.com> <20190625035313.GA13239@kroah.com>
 <20190626043052.GF212690@google.com>
From:   Frank Rowand <frowand.list@gmail.com>
Message-ID: <f9ddae55-91b3-27b2-0919-579f4d895e99@gmail.com>
Date:   Tue, 25 Jun 2019 22:49:32 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.1
MIME-Version: 1.0
In-Reply-To: <20190626043052.GF212690@google.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 6/25/19 9:30 PM, Sandeep Patil wrote:
> On Tue, Jun 25, 2019 at 11:53:13AM +0800, Greg Kroah-Hartman wrote:
>> On Mon, Jun 24, 2019 at 03:37:07PM -0700, Sandeep Patil wrote:
>>> We are trying to make sure that all (most) drivers in an Aarch64 system can
>>> be kernel modules for Android, like any other desktop system for
>>> example. There are a number of problems we need to fix before that happens
>>> ofcourse.
>>
>> I will argue that this is NOT an android-specific issue.  If the goal of
>> creating an arm64 kernel that will "just work" for a wide range of
>> hardware configurations without rebuilding is going to happen, we need
>> to solve this problem with DT.  This goal was one of the original wishes
>> of the arm64 development effort, let's not loose sight of it as
>> obviously, this is not working properly just yet.
> 
> I believe the proposed solution in this patch series is just that. I am not
> sure what the alternatives are. The alternative suggested was to reuse

Look at the responses from myself and from Rob to patch 0.  No one responded
to our comments.

-Frank


> pre-existing dt-bindings for dependency based probe re-ordering and resolution.
> 
> However, it seems we had no way to *really* check if these dependencies are
> the real. So, a device may or may not actually depend on the other device for
> probe / initialization when the dependency is mentioned in it's dt node. From
> DT's point of view, there is no way to tell this ..
> 
> I don't know how this is handled in x86. With DT, I don't see how we can do
> this unless DT dependencies are _really_ tied with runtime dependencies (The
> cycles would have been apparent if that was the case.
> 
> Honestly, the "depends-on" property suggested here just piles on to the
> existing state. So, it is somewhat doubling the exiting bindings. It says,
> you must use depends-on property to define probe / initialization dependency.
> The existing bindings like 'clock', 'interrupt', '*-supply' do not enforce
> that right now, so you will have device nodes that have these bindings right
> now but don't necessarily need them for successful probe for example.
> 
>>
>> It just seems that Android is the first one to actually try and
>> implement that goal :)
> 
> I guess :)
> 
> - ssp
> 
>>
>> thanks,
>>
>> greg k-h
> 


Return-Path: <SRS0=95/N=R6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9D2A0C43381
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Mar 2019 15:26:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 430BB2082F
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Mar 2019 15:26:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=rasmusvillemoes.dk header.i=@rasmusvillemoes.dk header.b="Zxml6/nf"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729091AbfC0P0b (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Mar 2019 11:26:31 -0400
Received: from mail-lj1-f196.google.com ([209.85.208.196]:38943 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726208AbfC0P0b (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Mar 2019 11:26:31 -0400
Received: by mail-lj1-f196.google.com with SMTP id l7so14773129ljg.6
        for <linux-kernel@vger.kernel.org>; Wed, 27 Mar 2019 08:26:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rasmusvillemoes.dk; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=5UmcYm7E7lwE/YOuO+szfo50S0UxDcJvs6IDRrUFBHM=;
        b=Zxml6/nf97vRwe4yxGF+FSpksx4hDF4019bE/5mGpP6fgaUpe1TUgbOSzIPjTfWoIj
         AQoJ1foCwdY4Adt2XexYNNIYB4jpPWKtOVNN8GAXrrgmAGVblrVGBt005Oqawj7JjGUw
         8417igX5K03Q5GtvO86BU8vmM6wzt5eY+8pfM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=5UmcYm7E7lwE/YOuO+szfo50S0UxDcJvs6IDRrUFBHM=;
        b=V870JujsCFtmhOQDEDqyeq0TDLLB1hMAqYkwpbeP4jVOD7c69LUWZKe8SaP65oSZGA
         gFqKIW3OaK18fBTdMHWIfq2lAHZLwbRROfa0Uk7keUpAoDgTav43rt99pWr7eqvFtS/y
         Je3xw9Lrv2v526S1PCqsacJeW0wHJyJlQn4M0m67KhTajwOVqAXE52F1dzxNXgGLAf9V
         X7ZIDBybUiNKpgXj4piDPpWxc0npBoMhPhdHcyvD1af2dRXgzK80SV9QKcQEHzPfMb6K
         88Vm4YltoaT9xQikBv6ZyK+0vMJO8XS6VTDks8WSg+JgtqbRpc6bGeN39nju8bwm/kvX
         uhzQ==
X-Gm-Message-State: APjAAAXdHYZpvULPYDrVQkgvRn1bg5uaNzeSO0ttRfZnX+3aey8YVn1k
        YF6cAeqDVn329JfzkFqc7gWERA==
X-Google-Smtp-Source: APXvYqw+E0DpEhY00tRjTGb1AMw3wAPn5x11dyhgKSaWfyo1r5M3y0U84Dddb5xl3b3U4X5hIznR7w==
X-Received: by 2002:a2e:2a03:: with SMTP id q3mr4767840ljq.56.1553700389319;
        Wed, 27 Mar 2019 08:26:29 -0700 (PDT)
Received: from [172.16.11.26] ([81.216.59.226])
        by smtp.gmail.com with ESMTPSA id m23sm4761330ljh.93.2019.03.27.08.26.27
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 27 Mar 2019 08:26:28 -0700 (PDT)
Subject: Re: [PATCH v2 1/6] leds: netdev trigger: use memcpy in
 device_name_store
To:     Jacek Anaszewski <jacek.anaszewski@gmail.com>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Pavel Machek <pavel@ucw.cz>,
        =?UTF-8?Q?Uwe_Kleine-K=c3=b6nig?= <u.kleine-koenig@pengutronix.de>
Cc:     LKML <linux-kernel@vger.kernel.org>, linux-leds@vger.kernel.org
References: <20190313202615.22883-1-linux@rasmusvillemoes.dk>
 <20190314140619.3309-1-linux@rasmusvillemoes.dk>
 <20190314140619.3309-2-linux@rasmusvillemoes.dk>
 <987c3e60-edb3-44f0-be28-434c70bb8659@gmail.com>
From:   Rasmus Villemoes <linux@rasmusvillemoes.dk>
Message-ID: <d1fccd75-c48b-d585-1170-1c1b76e1e098@rasmusvillemoes.dk>
Date:   Wed, 27 Mar 2019 16:26:27 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.1
MIME-Version: 1.0
In-Reply-To: <987c3e60-edb3-44f0-be28-434c70bb8659@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 26/03/2019 20.53, Jacek Anaszewski wrote:
> Hi Rasmus,
> 
> Thank you for the patch.
> 
> On 3/14/19 3:06 PM, Rasmus Villemoes wrote:
>> If userspace doesn't end the input with a newline (which can easily
>> happen if the write happens from a C program that does write(fd,
>> iface, strlen(iface))), we may end up including garbage from a
>> previous, longer value in the device_name. For example
>>
>> # cat device_name
>>
>> # printf 'eth12' > device_name
>> # cat device_name
>> eth12
>> # printf 'eth3' > device_name
>> # cat device_name
>> eth32
>>
> 
> Added tag:
> 
> Fixes: 06f502f57d0d ("leds: trigger: Introduce a NETDEV trigger")
> 
> and applied to the fixes-for-5.1-rc3 branch.
> 

You're stripping lines beginning with #. This is the commit in -next:


commit 09466021a80c926aa7de68e5162bdfea2a117483
Author: Rasmus Villemoes <linux@rasmusvillemoes.dk>
Date:   Thu Mar 14 15:06:14 2019 +0100

    leds: netdev trigger: use memcpy in device_name_store

    If userspace doesn't end the input with a newline (which can easily
    happen if the write happens from a C program that does write(fd,
    iface, strlen(iface))), we may end up including garbage from a
    previous, longer value in the device_name. For example

    eth12
    eth32

which is entirely useless and confusing. Please fix this before it
actually hits mainline. And you may want to look into "git commit
--cleanup" and/or "git config commit.cleanup" (scissors is much better
than the default strip).

Rasmus

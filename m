Return-Path: <SRS0=RThv=TD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 226E9C43219
	for <linux-kernel@archiver.kernel.org>; Fri,  3 May 2019 00:43:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E4C012070B
	for <linux-kernel@archiver.kernel.org>; Fri,  3 May 2019 00:43:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="cpu43YKL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726511AbfECAnt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 May 2019 20:43:49 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:37082 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726394AbfECAnt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 May 2019 20:43:49 -0400
Received: by mail-wm1-f65.google.com with SMTP id y5so4775681wma.2
        for <linux-kernel@vger.kernel.org>; Thu, 02 May 2019 17:43:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=myqIn515BB3f58w8OwJRJxm+z/mHW0WAwWCUgmrjD7U=;
        b=cpu43YKLMwTXhjgwRfrihkbOivI3VN9nYhaOnWRLhd15tRTJzIqvvTCxTNkhdnXErp
         QfX2ntrlbnRFzzt/3ePwHx1Jy9nR9W8mvhKiNHiCdLyHkCW9NLCC1AuZMz9fBV8Cf0Mw
         w0zA10ZIv2AbDTonHboFbZyPGYJFwd4pm+dMP+1us/ZD7oYBNb9aKIhWmLuRnQ65xhPi
         eF9b8SVxJvUioGTPUot5LyZqwo6ko5k0yApdK3MFSub1ra6cSy3yNQQyYQNgfsNXYqgB
         3tQ1p8ukJsRQ8RuV60hsfiECrbg64hls5QGepIVt+An39GJsERPX8CCFb1kCXTJ+QUG5
         kzyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=myqIn515BB3f58w8OwJRJxm+z/mHW0WAwWCUgmrjD7U=;
        b=HeaijW2ClKj/DULNBIQkVT6EZwSBZX0JdjCDLvfetL3dobWRx1sNnVdTlC83qc/foV
         BMi220vBJmJq3t5QJ9Wba63kGzEL1WKwmMdLLiOVLlRYeHohJSeYVXLPC7KqqTpXToWh
         2X28iXi9MYoof12xRB21VlmVoaY914v7Tz/l72/5MMR/GaYgvZfgnGn7a09rTJZfIlQK
         3jsi9sY2Wyierr9dZKNr1puyu1R7iHXZzoE6atM2/qD6mpA59c421HKI6P9VF5VgaCQo
         O/FO6oQn+9HpO7TcfU2fxx7QojOV4SgPwr5QjGYIpbk5zr8+amsUckje4uioSDLBp38R
         ZtdQ==
X-Gm-Message-State: APjAAAUHRDqfV1xflG9hw+ly+cMAE3DcKF/02nYIQkHFrcfNcA45uVag
        wfRKPG54vhAR4Es4578GxpE8omJUgto=
X-Google-Smtp-Source: APXvYqxqEQdWRm4JGw4KOoxTaJnwPXCkcju28W434oFS73+R0mhPyU9sv26+q+vHOt4h3+8zhoatQA==
X-Received: by 2002:a1c:68c3:: with SMTP id d186mr4032664wmc.56.1556844226509;
        Thu, 02 May 2019 17:43:46 -0700 (PDT)
Received: from [192.168.0.41] (223.235.129.77.rev.sfr.net. [77.129.235.223])
        by smtp.googlemail.com with ESMTPSA id a11sm527618wmm.35.2019.05.02.17.43.45
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 02 May 2019 17:43:45 -0700 (PDT)
Subject: Re: linux-next: Tree for May 2
To:     Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     Nathan Chancellor <natechancellor@gmail.com>,
        Anders Roxell <anders.roxell@linaro.org>,
        maxime.ripard@bootlin.com, andre.przywara@arm.com,
        samuel@sholland.org,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <20190502201028.707453d8@canb.auug.org.au>
 <CADYN=9LHJpDyvA=3wkcqdS5f3kahD0vdXFY415k8UmLHMDzL+Q@mail.gmail.com>
 <20190502190845.GA19485@archlinux-i9>
 <0a28f5b8-296a-451c-c2f4-c0057833fb00@linaro.org>
 <20190503080331.0ccc2419@canb.auug.org.au>
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
Message-ID: <991a8520-5bb9-a4cd-8dc0-38ac2f76571d@linaro.org>
Date:   Fri, 3 May 2019 02:43:44 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190503080331.0ccc2419@canb.auug.org.au>
Content-Type: text/plain; charset=UTF-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 03/05/2019 00:03, Stephen Rothwell wrote:
> Hi Daniel,
> 
> On Thu, 2 May 2019 22:09:49 +0200 Daniel Lezcano <daniel.lezcano@linaro.org> wrote:
>>
>> Yes, I picked the patch and it was merged it via the tip tree [1] as
>> requested by Marc Zyngier [2] and notified [3].
>>
>> In any case, this patch should have go through my tree initially, so if
>> it is found somewhere else that's wrong.
>>
>> I did a respin of my branch and pushed it again in case there was
>> something wrong from it.
> 
> The patch ("clocksource/drivers/arch_timer: Workaround for Allwinner
> A64 timer instability") was merged into v5.1-rc1 via the tip tree as
> you say, however the version of your clockevents tree in yesterday's
> linux-next was based on v5.0-rc1 and contained the patch again ...
> 
> Today's should be better.

Oh, ok. As I updated the branch today before having this merge conflict
I thought the problem was coming from somewhere else. Thanks for the update.



-- 
 <http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog


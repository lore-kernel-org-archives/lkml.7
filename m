Return-Path: <SRS0=NhyN=SP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1D8E1C10F11
	for <linux-kernel@archiver.kernel.org>; Sat, 13 Apr 2019 12:39:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C91B120818
	for <linux-kernel@archiver.kernel.org>; Sat, 13 Apr 2019 12:39:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=rajagiritech-edu-in.20150623.gappssmtp.com header.i=@rajagiritech-edu-in.20150623.gappssmtp.com header.b="tXDwLwwb"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727057AbfDMMjl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 13 Apr 2019 08:39:41 -0400
Received: from mail-pl1-f195.google.com ([209.85.214.195]:45845 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726207AbfDMMjk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 13 Apr 2019 08:39:40 -0400
Received: by mail-pl1-f195.google.com with SMTP id bf11so6381920plb.12
        for <linux-kernel@vger.kernel.org>; Sat, 13 Apr 2019 05:39:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rajagiritech-edu-in.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=9qUNfIj1zZXjHAJxneToEQSn8UoaPFAC1koUwQNNxEk=;
        b=tXDwLwwbcCFznqaHSuSVEw40fpaKECsOLJ7+azmWb0IstTJjZIpv0yIBkkiD9fGW9s
         L7hiN8Zs7JUOTgvJnUyKZ3pVOP3Cn/iflBpPq4udRJMZRQndVCr5oqmjYwVN4toi1/4q
         /GBrpTM8/0+GzUdQlCX+ZbCYHSM9f4vWPbXcYXV+DXm37icIqpPDCuLqfNAT3KhQnKAT
         x+vdBqvigkQXmFiFaB3CCyGWV8z4lNCg+RqcSfLw1hZdb7BqS1AsnwyrnGiH8FuYNalj
         vwLGvMe5kpep9GVJXOazLX0tBPO7Nk4SljmrbP1QHUJmbGwBeeXKG+5nhdq+x/aBAVsf
         POnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=9qUNfIj1zZXjHAJxneToEQSn8UoaPFAC1koUwQNNxEk=;
        b=me3qdSBDfRMFOSoXmYYmWyMLWCrscsTRfp1ZvtgmN45LT1Q+wHW/imUfAo+z4crUCm
         PDzoe9YalHzo/Cguz5GHWNwYuII598KmEnuQyTX3rMNFE2DxlMy2/hmGNS7f7Z99aTZT
         fI6ZC8eXdiPnBi6G9ZEYg6KtpHgBaLMQnKWibaeMq62Ula49jgd1z3/RCUj6iybTt5H5
         UVUdQT+bFxhWmBxa4fa5yOkO7uVTidI7qI8vkLXxrfn5WWazXgj6QZP4DNSBKo9T7iCT
         ohTlcQ+8cnS5Sl/ZX+h+DNTHp9MqIvjJrMSnF7Keunq8CNfJ30lLoF65KLooSgVuZPpR
         nEXA==
X-Gm-Message-State: APjAAAWwCYqaLnCE9RMulXDRvG8IomJC91teX3wJ9Y1W2JH1TBJCIJZ/
        nbZVRIbUZPmW8RiWMGsU3J/7kqkvxFtpQAosrJgp4w==
X-Google-Smtp-Source: APXvYqzhKXdiULaS2mDPq7CuoGVq1XQ37IgL+IqRrc2VL+3EAnN8ukwSlYYN9Qm7o7/iomss+cQC7Fe7eMgkST0XRyo=
X-Received: by 2002:a17:902:2702:: with SMTP id c2mr44535520plb.37.1555159179157;
 Sat, 13 Apr 2019 05:39:39 -0700 (PDT)
MIME-Version: 1.0
References: <20190405163126.7278-1-jeffrin@rajagiritech.edu.in> <20190405164746.pfc6wxj4nrynjma4@breakpoint.cc>
In-Reply-To: <20190405164746.pfc6wxj4nrynjma4@breakpoint.cc>
From:   Jeffrin Thalakkottoor <jeffrin@rajagiritech.edu.in>
Date:   Sat, 13 Apr 2019 18:09:02 +0530
Message-ID: <CAG=yYwnN37OoL1DSN8qPeKWhzVJOcUFtR-7Q9fVT5AULk5S54w@mail.gmail.com>
Subject: Re: [PATCH] selftests : netfilter: Wrote a error and exit code for a
 command which needed veth kernel module.
To:     Shuah Khan <shuah@kernel.org>
Cc:     Florian Westphal <fw@strlen.de>, linu-kselftest@vger.kernel.org,
        pablo@netfilter.org, lkml <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Shuah,

did you get the mail related stuff below ?

On Fri, Apr 5, 2019 at 10:17 PM Florian Westphal <fw@strlen.de> wrote:
>
> Jeffrin Jose T <jeffrin@rajagiritech.edu.in> wrote:
> > A test for  the basic NAT functionality uses ip command which
> > needs veth device.There is a condition where the kernel support
> > for veth is not compiled into the kernel and the test script
> > breaks.This patch contains code for reasonable error display
> > and correct code exit.
>
> Looks good to me, thanks for following up on this.
>
> Acked-by: Florian Westphal <fw@strlen.de>



-- 
software engineer
rajagiri school of engineering and technology

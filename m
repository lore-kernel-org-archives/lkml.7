Return-Path: <SRS0=lq4r=TU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 99D30C04AAF
	for <linux-kernel@archiver.kernel.org>; Mon, 20 May 2019 09:26:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 765F720675
	for <linux-kernel@archiver.kernel.org>; Mon, 20 May 2019 09:26:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732055AbfETJ0C (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 May 2019 05:26:02 -0400
Received: from mail-qt1-f194.google.com ([209.85.160.194]:33406 "EHLO
        mail-qt1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729357AbfETJ0C (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 May 2019 05:26:02 -0400
Received: by mail-qt1-f194.google.com with SMTP id m32so15500633qtf.0
        for <linux-kernel@vger.kernel.org>; Mon, 20 May 2019 02:26:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=JctNbqwCh+WC0TVQRye/r7+oJO/aUarkrBr7ivkC6/o=;
        b=VsHtOE34lK+CD3AvPJbCXC2icSOevCjgzq5TLXYAsakpociB+DrMJ5T3yViXyOCm8/
         3u271aT3PrT8PK9SNgH52EbxWB9BXNmxmaZMiuNARAUSwbK97n5e5eIsBh6HGJKTf0e0
         aaXA4nFEd+yTVCJ599Pu9FbOPpZehw+CufVc05VKDGJcS58n8H5Z73WziXN0Y1Wb0FHG
         BHcycNfqlCvrUR9b6IXK70lqSP49i5DQlFqrADSwJIp6qu57JpJAJkYpEZ+pwrltSrLA
         MdKlOGbiDoWXM62F9Pt24WGYu1LJv+ZIMi0eWIC+7iZukTkZYT8l2IU+kfxUpAKq4Nz/
         NSTw==
X-Gm-Message-State: APjAAAX6Ogc9ABIvpZstO54nSOlTf6N96vaROaXBPO23C9767ObNE6mC
        Z72qOUtwYrFSy9jxI/tGF69Mfy0xSdxT3RsX+yw=
X-Google-Smtp-Source: APXvYqwWFFg8iqO2pEVzmzHeh6gtzK9wwts/yfXyepEIpCbzxiWfMYaKQvMwkrVVdXXkTDdMOIVNSTGBZM3SRS/EUh0=
X-Received: by 2002:ac8:6750:: with SMTP id n16mr39381624qtp.142.1558344361121;
 Mon, 20 May 2019 02:26:01 -0700 (PDT)
MIME-Version: 1.0
References: <20190512012508.10608-1-elder@linaro.org> <20190512012508.10608-10-elder@linaro.org>
 <CAK8P3a0eYWN6mMwft5OSu8wQQo=kWh5safGFFNkDCELZJyiMmQ@mail.gmail.com>
 <14a040b6-8187-3fbc-754d-2e267d587858@linaro.org> <CAK8P3a37bPRZTHZcrg8KrYRLAhCr9pk8v4yuo_wSyUONs2OysQ@mail.gmail.com>
 <4a34d381-d31d-ea49-d6d3-3c4f632958e3@linaro.org> <dcd648f2-5305-04dd-8997-be87a9961fd9@linaro.org>
In-Reply-To: <dcd648f2-5305-04dd-8997-be87a9961fd9@linaro.org>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Mon, 20 May 2019 11:25:44 +0200
Message-ID: <CAK8P3a0FfSvTF8kkQ8pyKFNX9-fSXvtEyMBYTjtM+VOPxMPkWg@mail.gmail.com>
Subject: Re: [PATCH 09/18] soc: qcom: ipa: GSI transactions
To:     Alex Elder <elder@linaro.org>
Cc:     David Miller <davem@davemloft.net>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Ilias Apalodimas <ilias.apalodimas@linaro.org>,
        syadagir@codeaurora.org, mjavid@codeaurora.org,
        evgreen@chromium.org, Ben Chan <benchan@google.com>,
        Eric Caruso <ejcaruso@google.com>, abhishek.esse@gmail.com,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, May 19, 2019 at 7:11 PM Alex Elder <elder@linaro.org> wrote:
> On 5/17/19 1:44 PM, Alex Elder wrote:
> > On 5/17/19 1:33 PM, Arnd Bergmann wrote:
> >> On Fri, May 17, 2019 at 8:08 PM Alex Elder <elder@linaro.org>
>
> So it seems that I must *not* apply a volatile qualifier,
> because doing so restricts the compiler from making the
> single instruction optimization.

Right, I guess that makes sense.

> If I've missed something and you have another suggestion for
> me to try let me know and I'll try it.

A memcpy() might do the right thing as well. Another idea would
be a cast to __int128 like

#ifdef CONFIG_ARCH_SUPPORTS_INT128
typedef __int128 tre128_t;
#else
typedef struct { __u64 a; __u64 b; } tre128_t;
#else

static inline void set_tre(struct gsi_tre *dest_tre, struct gs_tre *src_tre)
{
     *(volatile tre128_t *)dest_tre = *(tre128_t *)src_tre;
}

      Arnd

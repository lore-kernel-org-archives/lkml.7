Return-Path: <SRS0=lq4r=TU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4E9D9C04AAC
	for <linux-kernel@archiver.kernel.org>; Mon, 20 May 2019 14:43:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2C8412054F
	for <linux-kernel@archiver.kernel.org>; Mon, 20 May 2019 14:43:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2403899AbfETOnU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 May 2019 10:43:20 -0400
Received: from mail-qt1-f193.google.com ([209.85.160.193]:44116 "EHLO
        mail-qt1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732661AbfETOnT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 May 2019 10:43:19 -0400
Received: by mail-qt1-f193.google.com with SMTP id f24so16542089qtk.11
        for <linux-kernel@vger.kernel.org>; Mon, 20 May 2019 07:43:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=wVbH8yFCTvDnL4KvntlUkLZ6kVZPj088jURz/EO5+k4=;
        b=RnCtlZtqhejz/PN6bQXV1AHUFK3Ct2n7zo4GVCQLqJ6+yAFTcmmbg19EfJGv4kAfGw
         0V+XFARQPVnCOxrGOuJGlrTqgBTXQEA4uB+x21rVPn1e5vjc6lRqKclcvc4b1wbJCVSD
         ze8YKas5z/ctrxCLzMcB3HXdeHpa0SsPPjfXCvOOMprBihrsfhg7dGUlY3zmg/a4bdTy
         1AD9sXIMOhUPlbHiEDl7pMGlRr+DbYJbKgarZLvXjm4Nd9vBIirCFahemorkTUgYCt++
         upyfuWS5BqdsYUPNhsdFMkGHqZ3CU3UL7ghUv0MyswtsVLz2aZZrR7VWag/z7oDkumQb
         BuJQ==
X-Gm-Message-State: APjAAAVgtterkLlqIcSXQY9Zw9Em5zuP0MYc2ESZ0mtjEmfiePl94LAP
        Zo6LE64YELjJ2/GpDJF+AQ7T26oNTSTgCxkddnc=
X-Google-Smtp-Source: APXvYqzeQ/JsUpL3OqXOSLdEPvWsH4Ws8y0TmLbiOXXUjuxdurnq83izX4qvEWQ6qvlwqSzU8jQ0BJFvab6PfubqtyQ=
X-Received: by 2002:ac8:1c51:: with SMTP id j17mr62734037qtk.7.1558363398695;
 Mon, 20 May 2019 07:43:18 -0700 (PDT)
MIME-Version: 1.0
References: <20190512012508.10608-1-elder@linaro.org> <20190512012508.10608-10-elder@linaro.org>
 <CAK8P3a0eYWN6mMwft5OSu8wQQo=kWh5safGFFNkDCELZJyiMmQ@mail.gmail.com>
 <14a040b6-8187-3fbc-754d-2e267d587858@linaro.org> <CAK8P3a37bPRZTHZcrg8KrYRLAhCr9pk8v4yuo_wSyUONs2OysQ@mail.gmail.com>
 <4a34d381-d31d-ea49-d6d3-3c4f632958e3@linaro.org> <dcd648f2-5305-04dd-8997-be87a9961fd9@linaro.org>
 <CAK8P3a0FfSvTF8kkQ8pyKFNX9-fSXvtEyMBYTjtM+VOPxMPkWg@mail.gmail.com> <d3d4670f-eb8b-7dcf-f91a-1ec1d4d96f67@linaro.org>
In-Reply-To: <d3d4670f-eb8b-7dcf-f91a-1ec1d4d96f67@linaro.org>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Mon, 20 May 2019 16:43:02 +0200
Message-ID: <CAK8P3a12+3a-p2pNuQrJu01dOJJuCoQ4ttt=Y0g97wTtBmQO5w@mail.gmail.com>
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

On Mon, May 20, 2019 at 2:50 PM Alex Elder <elder@linaro.org> wrote:
>
> On 5/20/19 4:25 AM, Arnd Bergmann wrote:
> > On Sun, May 19, 2019 at 7:11 PM Alex Elder <elder@linaro.org> wrote:
> >> On 5/17/19 1:44 PM, Alex Elder wrote:
> >>> On 5/17/19 1:33 PM, Arnd Bergmann wrote:
> >>>> On Fri, May 17, 2019 at 8:08 PM Alex Elder <elder@linaro.org>
> >>
> >> So it seems that I must *not* apply a volatile qualifier,
> >> because doing so restricts the compiler from making the
> >> single instruction optimization.
> >
> > Right, I guess that makes sense.
> >
> >> If I've missed something and you have another suggestion for
> >> me to try let me know and I'll try it.
> >
> > A memcpy() might do the right thing as well. Another idea would
>
> I find memcpy() does the right thing.
>
> > be a cast to __int128 like
>
> I find that my environment supports 128 bit integers.  But...
>
> > #ifdef CONFIG_ARCH_SUPPORTS_INT128
> > typedef __int128 tre128_t;
> > #else
> > typedef struct { __u64 a; __u64 b; } tre128_t;
> > #else
> >
> > static inline void set_tre(struct gsi_tre *dest_tre, struct gs_tre *src_tre)
> > {
> >      *(volatile tre128_t *)dest_tre = *(tre128_t *)src_tre;
> > }
> ...this produces two 8-bit assignments.  Could it be because
> it's implemented as two 64-bit values?  I think so.  Dropping
> the volatile qualifier produces a single "stp" instruction.

I have no idea how two 8-bit assignments could do that,
it sounds like a serious gcc bug, unless you mean two
8-byte assignments, which would be within the range
of expected behavior. If it's actually 8-bit stores, please
open a bug against gcc with a minimized test case.

> The only other thing I thought I could do to encourage
> the compiler to do the right thing is define the type (or
> variables) to have 128-bit alignment.  And doing that for
> the original simple assignment didn't change the (desirable)
> outcome, but I don't think it's really necessary in this
> case, considering the single instruction uses two 64-bit
> registers.
>
> I'm going to leave it as it was originally; it's the simplest:
>         *dest_tre = tre;
>
> I added a comment about structuring the code this way with
> the intention of getting the single instruction.  If a different
> compiler produces different result.

Ok, that's probably the best we can do then.

      Arnd

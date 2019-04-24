Return-Path: <SRS0=L2S5=S2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 596E1C10F11
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 19:06:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 27F9520835
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 19:06:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="IlO/27Bi"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388616AbfDXTGK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Apr 2019 15:06:10 -0400
Received: from mail-vs1-f65.google.com ([209.85.217.65]:43155 "EHLO
        mail-vs1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728079AbfDXTGJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Apr 2019 15:06:09 -0400
Received: by mail-vs1-f65.google.com with SMTP id t23so11042572vso.10
        for <linux-kernel@vger.kernel.org>; Wed, 24 Apr 2019 12:06:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=BYlYZIp9lVnO/LNggOaWNdZ4LmpCU45Xr9GtlfTw+Ig=;
        b=IlO/27Bi20zcbrxsGvdgGo/fRy3nfNfBe0ISD3MwMQI/5k+Hgc0336YP0WN9cVlC4h
         LPsefUpAgeUnh5I1oREBOpqsvdcyzcnsRteVn8YdE1BquO2SadyY+SeKCTq9+IYHdQ73
         27nhRDP+rPwW7brWevnpQRWY2N5bVOUk8mKKs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=BYlYZIp9lVnO/LNggOaWNdZ4LmpCU45Xr9GtlfTw+Ig=;
        b=flvENPOSquiTazxB3CI5psWr6nwraiKg+XhLnWBTbrbPNAYzTFMYtjyLowngofbq0D
         gm4qlLgF6lrGGN0DRpQVUAjhfoO7jKrJEW9KZBgx1qH/iUSnLrhbiXT1qH9/nNr1pRmj
         o3EuO/4BEACLK6fDgz1qQH5djYhaV+ccSXleRn2G0dH7v9DBuWbzYoqq56yOFbih2o7t
         1MlI5ZiuNwKDWb0RYgoVVXprss+hacfoFmxUSqYqJ9yWZvDn/7MHv6V0ov9PtsGY2ml2
         wMbMckiHihdutKTNaiFQxPFXBZFuPXN4h2r3LYnXcPrv1LwfjPalv2N5StY13DwDloZd
         YXRQ==
X-Gm-Message-State: APjAAAVJXFvNwa53rrpcqO05i6zR9yL3YVlYTk04Xd9XYyoYxTe4ns6G
        qrJUrJ5J5NbcYP5w3tzTBtR+EI6By1Q=
X-Google-Smtp-Source: APXvYqyUcasQnS8XsAgCdQOmxUz0dZ2gsNUJdrtl7pa80eVicOTU3No4QHNuvhf7Xzek9RLS0G98AQ==
X-Received: by 2002:a05:6102:398:: with SMTP id m24mr18526851vsq.23.1556132768014;
        Wed, 24 Apr 2019 12:06:08 -0700 (PDT)
Received: from mail-vs1-f50.google.com (mail-vs1-f50.google.com. [209.85.217.50])
        by smtp.gmail.com with ESMTPSA id r3sm14977651vkr.18.2019.04.24.12.06.06
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
        Wed, 24 Apr 2019 12:06:07 -0700 (PDT)
Received: by mail-vs1-f50.google.com with SMTP id f22so11054438vso.7
        for <linux-kernel@vger.kernel.org>; Wed, 24 Apr 2019 12:06:06 -0700 (PDT)
X-Received: by 2002:a67:eecb:: with SMTP id o11mr18354214vsp.66.1556132766437;
 Wed, 24 Apr 2019 12:06:06 -0700 (PDT)
MIME-Version: 1.0
References: <20190320222831.8243-1-mcgrof@kernel.org> <CAGXu5jK1oaEXYEKM45Ai3bPELTEF=aO0-OSSnpcnOdWtQf2+cw@mail.gmail.com>
 <a57954c3-d343-aae3-69a8-7166df8d5042@sandeen.net>
In-Reply-To: <a57954c3-d343-aae3-69a8-7166df8d5042@sandeen.net>
From:   Kees Cook <keescook@chromium.org>
Date:   Wed, 24 Apr 2019 12:05:54 -0700
X-Gmail-Original-Message-ID: <CAGXu5j+rkR3DsKUVdm+-tTqjoQ38tNMe1bGdxiDRgrcKX3j9HA@mail.gmail.com>
Message-ID: <CAGXu5j+rkR3DsKUVdm+-tTqjoQ38tNMe1bGdxiDRgrcKX3j9HA@mail.gmail.com>
Subject: Re: [PATCH 0/6] sysctl: add pending proc_do_large_bitmap fix
To:     Eric Sandeen <sandeen@sandeen.net>
Cc:     Luis Chamberlain <mcgrof@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Eric Sandeen <sandeen@redhat.com>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 24, 2019 at 10:42 AM Eric Sandeen <sandeen@sandeen.net> wrote:
>
> On 3/21/19 11:42 AM, Kees Cook wrote:
> > On Wed, Mar 20, 2019 at 3:28 PM Luis Chamberlain <mcgrof@kernel.org> wrote:
> >>
> >> Andrew, Kees,
> >>
> >> Eric sent a fix out for proc_do_large_bitmap() last month for when
> >> using a large input buffer. After patch review a test case for the issue
> >> was built and submitted. I noticed there were a few issues with the
> >> tests, but instead of just asking Eric to address them I've taken
> >> care of them and ammended the commit where necessary. There's a
> >> few issues he reported which I also address and fix in this series.
> >>
> >> Since we *do* expect users of these scripts to also use them on older
> >> kernels, I've also addressed not breaking calling the script for them,
> >> and gives us an easy way to easily extend our tests cases for future
> >> kernels as well.
> >>
> >> Before anyone considers these for stable as minor fixes, I'd recommend
> >> we also address the discrepancy on the read side of things: modify the
> >> test script to use diff against the target file instead of using the
> >> temp file.
> >>
> >> Eric Sandeen (2):
> >>   test_sysctl: add proc_do_large_bitmap() test case
> >>   sysctl: Fix proc_do_large_bitmap for large input buffers
> >>
> >> Luis Chamberlain (4):
> >>   test_sysctl: remove superfluous test_reqs()
> >>   test_sysctl: load module before testing for it
> >>   test_sysctl: ignore diff output on verify_diff_w()
> >>   test_sysctl: allow graceful use on older kernels
> >
> > Thanks for collecting and updating these!
> >
> > Acked-by: Kees Cook <keescook@chromium.org>
> >
> > Andrew, can you carry these?
>
> Ping?  This seems to have never made it off the list into anybody's
> tree.

Andrew, do you want me to send this to you again, or carry separately?

-Kees

-- 
Kees Cook

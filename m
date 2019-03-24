Return-Path: <SRS0=2kAr=R3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 48EC2C43381
	for <linux-kernel@archiver.kernel.org>; Sun, 24 Mar 2019 17:42:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 124FC2148D
	for <linux-kernel@archiver.kernel.org>; Sun, 24 Mar 2019 17:42:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="qFisYY0C"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728763AbfCXRmt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 24 Mar 2019 13:42:49 -0400
Received: from mail-it1-f196.google.com ([209.85.166.196]:51938 "EHLO
        mail-it1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727137AbfCXRms (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 24 Mar 2019 13:42:48 -0400
Received: by mail-it1-f196.google.com with SMTP id e24so10778559itl.1
        for <linux-kernel@vger.kernel.org>; Sun, 24 Mar 2019 10:42:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=yLAL4+6dl8R2Ovqh+2KUQWAySN+l1xbcIEXy3JgRznw=;
        b=qFisYY0CSACUAwLAEKSUI7Q1Bx8vonrkE2BPsuNL9+xOmYnn0YwyTEkTIsFLBFnlTl
         3ezjq0vR17wva2/zLw1hZ6xAeUdbmUvQe2c3KS4VhDOYqIoqMx4qKlK/3MkIYYJ6HyiV
         EOVUOhE9w9xVNs70z/JNYqhHJ/dZWuFKmgbPuQ7BUZ+SBnGaOeZng/BvxeWBAgSBXanp
         ohc62cOBzweHDj0QJGUeC3BtY6zAre2e0apj96pJmp27Bm7m0LX2sWaEHmeZEpI72ouw
         7hY3i5lMKjQvvDMLyJRqHA68GPNQ6uljghWKpdj0PQae9tDasnVcEezX3BH1Y2vkLBKf
         HoZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=yLAL4+6dl8R2Ovqh+2KUQWAySN+l1xbcIEXy3JgRznw=;
        b=W6qEDPYigSjPIdgVtDpLvYzeS97wegt9mtGFWLkdev9u1F5NaQz/ovl4FGQcRSpubN
         Z7FWKVQTry/ZfHdAtKUk2vBt8B9UUgKZaRt2/ZntsqTSdkfcQEE6H2bM9U2AMrCb3Gzf
         kdO6JPMtACbRfS80EDpbPZEnAs8cjQ45bi8NTStIPPtL6r4Y4dyUrMmRVqBlhATuY3EZ
         HUoypVYWDz0cLVL2AEQiGPiEmO4R49qyhlnue6E0l3/eqex4rmXOVTJUHgRFAeRhXJOf
         OSScCDqFbJIUdQ4Ju2ecsk6PULdE0oDeEWeFpEPiBRsKk+C6Ex/6R7GKIR5SrFqSXcyG
         p7Rw==
X-Gm-Message-State: APjAAAXMaLy5e1gmQRBuCkHxuG/jtCiaFSYeZ6rMOgoyylcWALlTs2ht
        xd2XW0cbOBa6dYvmWnuIx+uwdqFL9GZLcESvpB/08w==
X-Google-Smtp-Source: APXvYqyAQjx6suXewzvEWRY7Bo3zqmjcnu7USB4p80OAGhdk8kPG1mG7JrDwVk69wEkxq0a2T90SoGX0gVWqF0otGyQ=
X-Received: by 2002:a24:2251:: with SMTP id o78mr6153674ito.134.1553449367497;
 Sun, 24 Mar 2019 10:42:47 -0700 (PDT)
MIME-Version: 1.0
References: <20190225065044.11023-1-vaishali.thakkar@linaro.org>
 <20190225065044.11023-5-vaishali.thakkar@linaro.org> <155138953788.16805.6820097041346672619@swboyd.mtv.corp.google.com>
 <CANNG1HWDc-PraBwG=8TBcfJSFFe+X+k6oVhOqyU=i5fAjpuoLw@mail.gmail.com>
 <155257912871.20095.1653828341120157988@swboyd.mtv.corp.google.com>
 <CANNG1HV0Ai9oeUr55uk+wAf456vDn1qiYmeXYc3=rkpqhdoM4g@mail.gmail.com> <155329931528.20095.6505466693897029315@swboyd.mtv.corp.google.com>
In-Reply-To: <155329931528.20095.6505466693897029315@swboyd.mtv.corp.google.com>
From:   Vaishali Thakkar <vaishali.thakkar@linaro.org>
Date:   Sun, 24 Mar 2019 23:12:36 +0530
Message-ID: <CANNG1HUCvL3=mtitvDZ3fOtt3u5oK7kr=9Nftov71aOsUn3nXA@mail.gmail.com>
Subject: Re: [PATCH v4 4/5] soc: qcom: socinfo: Expose custom attributes
To:     Stephen Boyd <swboyd@chromium.org>
Cc:     Andy Gross <andy.gross@linaro.org>,
        David Brown <david.brown@linaro.org>,
        Greg KH <gregkh@linuxfoundation.org>,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        rafael@kernel.org, Bjorn Andersson <bjorn.andersson@linaro.org>,
        Vinod Koul <vkoul@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 23 Mar 2019 at 05:31, Stephen Boyd <swboyd@chromium.org> wrote:
>
> Quoting Vaishali Thakkar (2019-03-20 22:51:20)
> > On Thu, 14 Mar 2019 at 21:28, Stephen Boyd <swboyd@chromium.org> wrote:
> > >
> > > Quoting Vaishali Thakkar (2019-03-14 04:25:16)
> > > > On Fri, 1 Mar 2019 at 03:02, Stephen Boyd <swboyd@chromium.org> wrote:
> > >
> > > >
> > > > In the case of converting it to cpu native during probe, I'll need to
> > > > declare an extra struct with u32 being the parsed version for it to be
> > > > correct. Wouldn't it add extra overhead?
> > >
> > > Yes it would be some small extra overhead that could be allocated on the
> > > kernel's heap. What's the maximum size? A hundred bytes or so?
> > >
> > > I don't see much of a problem with this approach. It simplifies the
> > > patch series because nothing new is introduced in debugfs core and the
> > > endian conversion is done once in one place instead of being scattered
> > > throughout the code. Sounds like a good improvement to me.
> > >
> >
> > Yes, it's true that this approach is better than introducing new endian
> > functions in debugfs core but we should also keep in mind that this is
> > applicable only for 4 use cases. For other usecases, we want to print
> > string and hex values. So, I would either need new debugfs core
> > functions for the same. I tried introducing debugfs_create_str for string
> > values but we're ending up with introducing bunch of other helpers in
> > the core as simple_attr_read expects integer values. Similarly, for hex
> > values , I can't use debugfs_create_u32 as defined attributes in the
> > core has unsigned int as a specifier, will need to introduce some extra
> > helpers over there again.
>
> I imagine there are other uses of printing a string and hex value in
> debugfs. There's debugfs_create_x32() and debugfs_create_x64() for the
> hex value printing part (if you want that format). There's also

Ok.

> debugfs_create_devm_seqfile() which may work to print a string from some
> struct member. I'm not sure why you're using simple_attr_read(). Where
> does that become important?

DEFINE_DEBUGFS_ATTRIBUTE has simple_attr helpers which
expects int value. So, in the case of a string it requires to implement
similar macro and separate helpers for the same.

> >
> > Also, in case of keeping all other cases as it is, it'll look quite
> > asymmetric to use debugfs u32 function in init and using local macros
> > for other cases. I can have DEBUGFS_UINT_ADD like wrapper
> > macro for debugfs_create_u32 but again not sure if doing
> > all of this looks better than what we have at the moment as just having
> > 3 local macros covering our all cases without having lot of duplicated
> > code.
> >
> >  Let me know if about your opinion on the same. Thanks.
>
> My opinion is still that it would be best to push things that aren't SoC
> specific into the debugfs core and try to use as much from the core as
> possible. There doesn't seem to be anything very SoC specific here so
> I'm lost why this isn't doable.

Yes, that's true. We don't have much of SoC specific code here.

>

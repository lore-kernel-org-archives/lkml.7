Return-Path: <SRS0=q9dy=R2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1DEB1C4360F
	for <linux-kernel@archiver.kernel.org>; Sat, 23 Mar 2019 00:02:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DD953213F2
	for <linux-kernel@archiver.kernel.org>; Sat, 23 Mar 2019 00:01:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="Ib6dPN7t"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727413AbfCWAB6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Mar 2019 20:01:58 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:39440 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727068AbfCWAB5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Mar 2019 20:01:57 -0400
Received: by mail-pf1-f194.google.com with SMTP id i17so2556170pfo.6
        for <linux-kernel@vger.kernel.org>; Fri, 22 Mar 2019 17:01:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:content-transfer-encoding:in-reply-to:references:from
         :subject:cc:to:message-id:user-agent:date;
        bh=5yje7H5rdAOWpxB6jcxNx+cxLE7/VM5yKZAESv5Wx+M=;
        b=Ib6dPN7tY/BXOd6LMUXEvJkkQDu4d/zpB6bVt+pbKCJ1R263uiTP/kkshMTHgxL/j+
         pfmuiw2JBkj8WkjO7wyAUzF8LOkdh/ZHY9gMwCkh2kTcwXYjObyMXIMvtEA2HDnwxEFe
         MzRZFcpWA1MDNaCLdMGyO1ATWTETKsgYTp1PE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:content-transfer-encoding
         :in-reply-to:references:from:subject:cc:to:message-id:user-agent
         :date;
        bh=5yje7H5rdAOWpxB6jcxNx+cxLE7/VM5yKZAESv5Wx+M=;
        b=YjbWe9djzRD0zaOkqkMzTdHW8ES6G6UoBOYyokRvcIDWRcGfl62DQVuPLEI3Q1jUgU
         j4wLK6VEBA9izUL0fkzmrAWpS4DUswVfPVESD9BHk8XCwJoNWUzuNr5Pu9Vwb+fwXJ+Y
         wDpT/ba9NNIfO1FuoRIzoBqk3apd+g+Va6zWrl2254h81hv9/M8vfz7GSRlzYjCt1EI9
         Fs+0blnZHih1CwjbYAZOqpTmj0sAxSp1s5FzMXxQlkD1wfyRqWmJ+PREeqR4Aj8YDJ00
         d5kwoEhhklOaEfTuYwKf3FOB308xHGqT5QAji11eFoqRhK6+XJToXi2wtcPClD3kLmrk
         sYmw==
X-Gm-Message-State: APjAAAWfbPnXOqh9Xl5KOA1/N44AsKtd1fru7tYFkcisRTnUJ8ZBuiVY
        FvgM0Fl3S0y5KOqBReHMZ8OwKQ==
X-Google-Smtp-Source: APXvYqwuFSrdFCriHHnOvn13w06G8aMMbQKooDfBeu2/5FPN9b3+zjlQe+FplE97HuJNzvzIW4IddQ==
X-Received: by 2002:a63:8548:: with SMTP id u69mr11494045pgd.85.1553299317167;
        Fri, 22 Mar 2019 17:01:57 -0700 (PDT)
Received: from localhost ([2620:15c:202:1:fa53:7765:582b:82b9])
        by smtp.gmail.com with ESMTPSA id 17sm1777527pgz.52.2019.03.22.17.01.56
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 22 Mar 2019 17:01:56 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <CANNG1HV0Ai9oeUr55uk+wAf456vDn1qiYmeXYc3=rkpqhdoM4g@mail.gmail.com>
References: <20190225065044.11023-1-vaishali.thakkar@linaro.org> <20190225065044.11023-5-vaishali.thakkar@linaro.org> <155138953788.16805.6820097041346672619@swboyd.mtv.corp.google.com> <CANNG1HWDc-PraBwG=8TBcfJSFFe+X+k6oVhOqyU=i5fAjpuoLw@mail.gmail.com> <155257912871.20095.1653828341120157988@swboyd.mtv.corp.google.com> <CANNG1HV0Ai9oeUr55uk+wAf456vDn1qiYmeXYc3=rkpqhdoM4g@mail.gmail.com>
From:   Stephen Boyd <swboyd@chromium.org>
Subject: Re: [PATCH v4 4/5] soc: qcom: socinfo: Expose custom attributes
Cc:     Andy Gross <andy.gross@linaro.org>,
        David Brown <david.brown@linaro.org>,
        Greg KH <gregkh@linuxfoundation.org>,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        rafael@kernel.org, Bjorn Andersson <bjorn.andersson@linaro.org>,
        Vinod Koul <vkoul@kernel.org>
To:     Vaishali Thakkar <vaishali.thakkar@linaro.org>
Message-ID: <155329931528.20095.6505466693897029315@swboyd.mtv.corp.google.com>
User-Agent: alot/0.8
Date:   Fri, 22 Mar 2019 17:01:55 -0700
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Vaishali Thakkar (2019-03-20 22:51:20)
> On Thu, 14 Mar 2019 at 21:28, Stephen Boyd <swboyd@chromium.org> wrote:
> >
> > Quoting Vaishali Thakkar (2019-03-14 04:25:16)
> > > On Fri, 1 Mar 2019 at 03:02, Stephen Boyd <swboyd@chromium.org> wrote:
> >
> > >
> > > In the case of converting it to cpu native during probe, I'll need to
> > > declare an extra struct with u32 being the parsed version for it to be
> > > correct. Wouldn't it add extra overhead?
> >
> > Yes it would be some small extra overhead that could be allocated on the
> > kernel's heap. What's the maximum size? A hundred bytes or so?
> >
> > I don't see much of a problem with this approach. It simplifies the
> > patch series because nothing new is introduced in debugfs core and the
> > endian conversion is done once in one place instead of being scattered
> > throughout the code. Sounds like a good improvement to me.
> >
>=20
> Yes, it's true that this approach is better than introducing new endian
> functions in debugfs core but we should also keep in mind that this is
> applicable only for 4 use cases. For other usecases, we want to print
> string and hex values. So, I would either need new debugfs core
> functions for the same. I tried introducing debugfs_create_str for string
> values but we're ending up with introducing bunch of other helpers in
> the core as simple_attr_read expects integer values. Similarly, for hex
> values , I can't use debugfs_create_u32 as defined attributes in the
> core has unsigned int as a specifier, will need to introduce some extra
> helpers over there again.

I imagine there are other uses of printing a string and hex value in
debugfs. There's debugfs_create_x32() and debugfs_create_x64() for the
hex value printing part (if you want that format). There's also
debugfs_create_devm_seqfile() which may work to print a string from some
struct member. I'm not sure why you're using simple_attr_read(). Where
does that become important?

>=20
> Also, in case of keeping all other cases as it is, it'll look quite
> asymmetric to use debugfs u32 function in init and using local macros
> for other cases. I can have DEBUGFS_UINT_ADD like wrapper
> macro for debugfs_create_u32 but again not sure if doing
> all of this looks better than what we have at the moment as just having
> 3 local macros covering our all cases without having lot of duplicated
> code.
>=20
>  Let me know if about your opinion on the same. Thanks.

My opinion is still that it would be best to push things that aren't SoC
specific into the debugfs core and try to use as much from the core as
possible. There doesn't seem to be anything very SoC specific here so
I'm lost why this isn't doable.


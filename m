Return-Path: <SRS0=BZT9=SS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 34B3BC10F13
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Apr 2019 09:29:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EEB3D2086A
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Apr 2019 09:29:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="VnwFN9Tv"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729122AbfDPJ3G (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Apr 2019 05:29:06 -0400
Received: from mail-ua1-f68.google.com ([209.85.222.68]:39977 "EHLO
        mail-ua1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728230AbfDPJ3F (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Apr 2019 05:29:05 -0400
Received: by mail-ua1-f68.google.com with SMTP id b8so6487036uaq.7
        for <linux-kernel@vger.kernel.org>; Tue, 16 Apr 2019 02:29:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=dhcboL+Tv6bldB/w0lutB+kgOQAT1H7WFSgvZ9qwEQM=;
        b=VnwFN9Tvg1XRMBCLftvF7GHCqFqhlYeH7MslusvQdUqByeYk7b0WwMiuHID4j1H0pr
         cekYBP1r/dGDnV0Qzlgqbds+fvZK1Zi5rE4UiH3Ci0zQM/cMP03+6mlhbmpAUjbhnYtN
         vfqBqhHhcE4i1nsK9dX+J5Bd5TzCuu6DkdmJya6yJIEn8bBR8YI+Fd8pMkpv1ZpmBWCZ
         7qhivot8xKsFrB44UHOymhNXxcpXl1Fu0uYua/iJjjTGjoocBRBI3AkBsOA1zt/4RxWj
         PvWYc+Ad0bwOOQaBEV6X2dA2SMKkXEiMTeFD9csvBZ2o3cX412+oFrUTLamViqb7oq0R
         OsYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=dhcboL+Tv6bldB/w0lutB+kgOQAT1H7WFSgvZ9qwEQM=;
        b=FSNA3CNM+VtvduRZAvXs9HmYiZxsA/QmjimTVIyeR/ksFrTbWfuZYMcfo8zVp+Fcog
         jzten8uIxMrsv5idUUrSDoJvVnRRkZlAzZwewPQQ7SH+hyveu9YZ23wB3D1CZcF1vw6B
         GSjQB3npS/7PW6hyiqzYqSXss4HUPNp1b1HzZVHeItmH+RYEEiBtVQSAkEJC9R5i6V0+
         MGyIB7T6RtSAPEUJhxpwuzFXlUThtGuFu+QpDJ+nUdQoMtZ8KL8S/xMsyyGdLKXaZlHT
         wBEtPTDeZ4t6dut2ZEHKRRJt3J2AeBw6ZVhB2d0xEFS8hG/LZVSecJ57NW7YW84xnaaE
         AiPA==
X-Gm-Message-State: APjAAAVNLXg5Yi1DbBhv5QyaoHfTkn1rGTkhM+m4VKEzHVvFtNRZEiHd
        Vxdb8AW+MauUV+XO/91iW3yJVfkijMcYX4nj5G5AoQBq
X-Google-Smtp-Source: APXvYqxN3YbulrrpcNzAqBD53pLoseE/OkLXt0OsZZvr+lWCmzNFvOfOswZapUbbMLG1+DqiznWNcQSLJE1v65GJSVE=
X-Received: by 2002:ab0:6947:: with SMTP id c7mr18906780uas.51.1555406943901;
 Tue, 16 Apr 2019 02:29:03 -0700 (PDT)
MIME-Version: 1.0
References: <20190412093434.GA24516@amd> <CAPDyKFo2cZOqyCqBaZJzReaWfMenn6zgHcpCpf+XfegwqwNKxQ@mail.gmail.com>
 <20190416080024.GD14538@amd>
In-Reply-To: <20190416080024.GD14538@amd>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Tue, 16 Apr 2019 11:28:27 +0200
Message-ID: <CAPDyKFp-tNhxM=RSsb3eqJhHMSV4ZMo2Chag5NFAK-d1Oi_j4g@mail.gmail.com>
Subject: Re: [PATCH] Fix warning and undefined behavior in mmc voltage handling
To:     Pavel Machek <pavel@ucw.cz>
Cc:     kernel list <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@osdl.org>,
        Trivial patch monkey <trivial@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 16 Apr 2019 at 10:00, Pavel Machek <pavel@ucw.cz> wrote:
>
> On Tue 2019-04-16 09:48:51, Ulf Hansson wrote:
> > On Fri, 12 Apr 2019 at 11:34, Pavel Machek <pavel@ucw.cz> wrote:
> > >
> > > !voltage_ranges is tested for too late, allowing warning and undefined
> > > behavior. Fix that.
> > >
> > > Signed-off-by: Pavel Machek <pavel@ucw.cz>
> >
> > Pavel, thanks for your patch.
> >
> > Would you mind re-posting to linux-mmc so I can get it into the
> > patchtracker. Please also change the prefix of the header to "mmc:
> > core:".
>
> Done.

Thanks!

>
> > > Plus I guess author should add parenthesis in the expression. a / b /
> > > c is _not_ common idiom.
>
> Can you do something about the a / b / c situation?

Sure.

>
> > > -       num_ranges = num_ranges / sizeof(*voltage_ranges) / 2;
> > > +       num_ranges = num_ranges / sizeof(*voltage_ranges) / 2;
>
> I guess it is:
>        num_ranges = (num_ranges / sizeof(*voltage_ranges)) / 2;

Just send a patch on top, then I will apply it.

Kind regards
Uffe

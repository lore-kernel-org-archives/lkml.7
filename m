Return-Path: <SRS0=WcLH=XI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E613EC49ED7
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Sep 2019 10:36:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B4CE1208C0
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Sep 2019 10:36:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Qhf0AlR2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729471AbfIMKga (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 13 Sep 2019 06:36:30 -0400
Received: from mail-ed1-f65.google.com ([209.85.208.65]:35484 "EHLO
        mail-ed1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729400AbfIMKg3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Sep 2019 06:36:29 -0400
Received: by mail-ed1-f65.google.com with SMTP id f24so8999181edv.2
        for <linux-kernel@vger.kernel.org>; Fri, 13 Sep 2019 03:36:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=yoMobX+cp8FzXhuE26Q5iqWmU4wBMrUuYv1hKskRd6A=;
        b=Qhf0AlR2j+FSqbhmp1Fj7EAQaLxKBhepyLfpUOIiUsmhXO9jqJKrzDITuLM1MUNeW0
         o/Tr3cee7IuwSejgIE4VBlFMQZWKuD+IxbnM6d3J7XHVfEIXViexzt7DbrOhyqfgwGKo
         eacId+Cr4sT3sTtp1nTEB8pKIY9YsR9FW7lObVWVdb/+wLDlQf4qvXM6UL0Fb90voIO5
         uEx3E42KI9odugb/0Zl5vuqW+F1Pr875+M5rRDUpqqhe6hnGOA90vIpkgAYDW83fE0WV
         QmI1rG7t8BDos/V12GrP2PfN4qIupRWA40DfkwMiB/9Q0hJ1UY3imPN32L80fhhtup2q
         X+aw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=yoMobX+cp8FzXhuE26Q5iqWmU4wBMrUuYv1hKskRd6A=;
        b=ONxGNp33L0K/4AD+xuN9sVlweJA5lbfi9eyDmpZ3NLpbVELFOt0q6jdUzotDNFBAqy
         0N2z3LywiZlidW7d5XBBwb9xrk65HWv/OBiQNn1rluqBgCGJ6Unav+x97SqsenLLHfXv
         3touXByHWQv5DLtVlysgfe/txeGpZmANc6TeT0hCR9Aod+HNdl3DbeUsBd3stBQyAWHi
         3JuAFgifZg0eLph5LwBA3z/LCU5i+AlZlTxUSa0UVciikAXzOBHwJ+cgUDc8TJv3y9lC
         9k2RNNkfBMyQhL0YhqMdSpu0HH+4+1YQ58KJ9vRBZzKy8E0/MNX/6dLecV52qcQCeQTD
         /9eA==
X-Gm-Message-State: APjAAAUbqWlSu4Hn13NrZ2QQmoz80XDX7lg/J8b3x2adSNeFLDX61gtE
        clrNWH+db4YIOM4M/OlVtrzsC+uRpgb4DV9DKx1ebQ==
X-Google-Smtp-Source: APXvYqwPsnLfPQsWRGtRzHOng4f3SNonXdca+U/1zyNzOoIoq5wS6PXilOsiEpbAp7R0tF/s1gfw/IIzuqRmdfb84fk=
X-Received: by 2002:a17:906:b34a:: with SMTP id cd10mr38860564ejb.300.1568370987905;
 Fri, 13 Sep 2019 03:36:27 -0700 (PDT)
MIME-Version: 1.0
References: <20190906203054.26725-1-jorge.ramirez-ortiz@linaro.org>
 <4231aab1-c538-a14f-cea1-ceb28781c7bb@roeck-us.net> <CAMZdPi-P_AopbbyJEWDbnm7X8MtxTzs=MN13+UFndL2OK5VReg@mail.gmail.com>
 <20190911175453.GA31612@roeck-us.net>
In-Reply-To: <20190911175453.GA31612@roeck-us.net>
From:   Loic Poulain <loic.poulain@linaro.org>
Date:   Fri, 13 Sep 2019 12:36:55 +0200
Message-ID: <CAMZdPi_jFTYXbyqXZDBVuqCnXEWK29R8qnHa5KMoUDRwNOaLsA@mail.gmail.com>
Subject: Re: [PATCH 1/2] watchdog: pm8916_wdt: fix pretimeout registration flow
To:     Guenter Roeck <linux@roeck-us.net>
Cc:     Jorge Ramirez-Ortiz <jorge.ramirez-ortiz@linaro.org>,
        wim@linux-watchdog.org, linux-watchdog@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Bjorn Andersson <bjorn.andersson@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 11 Sep 2019 at 19:54, Guenter Roeck <linux@roeck-us.net> wrote:
>
> On Wed, Sep 11, 2019 at 10:04:12AM +0200, Loic Poulain wrote:
> > Hi Guenter, Jorge,
> >
> > On Mon, 9 Sep 2019 at 00:50, Guenter Roeck <linux@roeck-us.net> wrote:
> >
> > > On 9/6/19 1:30 PM, Jorge Ramirez-Ortiz wrote:
> > > > When an IRQ is present in the dts, the probe function shall fail if
> > > > the interrupt can not be registered.
> > > >
> > >
> > > The author intended differently, and did not want registration to fail
> > > in this situation, following the logic that it is better to have a
> > > standard watchdog without pretimeout than no watchdog at all.
> > >
> >
> > Indeed, but I tend to agree with this change since it aligns behavior with
> > other
> > watchdog drivers and I assume there is a serious issue if request_irq fails.
> > I suggest adding a dev_err message in such case.
> >
> > Copying the author; I am not inclined to accept such a change without
> > > input from the driver author.
> > >
> > > Similar, for the deferred probe, we'll need to know from the driver author
> > > if this is a concern. In general it is, but there are cases where
> > > -EPROBE_DEFFER is never returned in practice (eg for some SoC watchdog
> > > drivers).
> > >
> >
> > The IRQ controller is the SPMI bus parent node whose driver (MFD_SPMI_PMIC)
> > is a direct dependency of pm8916_wdt. I'm not sure in which scenario this
> > could
> > happen.
> >
> Not sure what the action item is. Accept the patch as-is (Reviewed-by
> appreciated), or resubmit without the -EPROBE_DEFER check ?

Reviewed-by: Loic Poulain <loic.poulain@linaro.org>

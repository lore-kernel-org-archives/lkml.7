Return-Path: <SRS0=jko7=2A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 124FCC43603
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Dec 2019 13:10:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CDF9C20652
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Dec 2019 13:10:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20150623.gappssmtp.com header.i=@bgdev-pl.20150623.gappssmtp.com header.b="nyeoSfCe"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727606AbfLJNK1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 10 Dec 2019 08:10:27 -0500
Received: from mail-il1-f194.google.com ([209.85.166.194]:33816 "EHLO
        mail-il1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727335AbfLJNK1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Dec 2019 08:10:27 -0500
Received: by mail-il1-f194.google.com with SMTP id w13so16073843ilo.1
        for <linux-kernel@vger.kernel.org>; Tue, 10 Dec 2019 05:10:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=l+05vsU6JBlrF6rH+4GZoXh5ai/6FJcvj9HM6RQS+EA=;
        b=nyeoSfCeqR+U8HPHRn5+C1zf0OPEynWbJ3yxz2n8pAFHu12kkwZuZcVFXiIGlOXb3P
         Z9bc/BNL6t95kM+mH4I5Wes1pqOxRKkfxPWnj6KzizYiSkDAGvbyRI4Xj9DlVNvcROxz
         Qcg+bXKMsrrhnPV8oi3GaGr/RqJrIgTc93x80YBrJwQVzKrYmfxoBd+3Fq3BdJAjDujt
         LrC3eS81wROBfRk+6YVEP0yoaCE+HPodJoIUUrpT0A+EvD0n7qVzE2CFqeFOgY2CrAgy
         4TSkHcDB4lmgl61GuIYoHNSok1PFDILIeWwJUHBz1Qh5QI+qfHcVeCLmWXDrtFpFXq8W
         GSaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=l+05vsU6JBlrF6rH+4GZoXh5ai/6FJcvj9HM6RQS+EA=;
        b=qfXw6Oho2c75Tb+WG9YNv42MkDtZBbhScmTWpChMc4NQ8JOudUqUMBs6rO+IjzWZuJ
         8ERgyUo7yi5Tb4brOJ80AeDNv5DqljAxSbMm2IOOd4aadlxH0WX8RNsWaqypTDXTwnkV
         x2BmTZfq6ENAdyRSUka4AcT14H8JjWGjGWs4OTJTUpC8zE59Buy/GiCrUcaXKvURrI6j
         Yist7bFvYcQoU29pQvWOL6zLzj9zkHmka+T91hxCbmT85wEwSkSZyLLs2JJYmZxUVmHq
         w6JbaBFCF4ZvoEYqMpLq3aP5pc3ecPK2aGmktlwilLwmvDAp1NrJHe0ZeMOJGlMtZ9WI
         FoFw==
X-Gm-Message-State: APjAAAWDabURyA2BRCoLxvYk2GfFUcXLitoIwkfIk0Ws1oWvndrOKD7x
        i0fFiCPwU5kUiMc0mU6IyRpzUp/4twYOFhIqV0nkiQ==
X-Google-Smtp-Source: APXvYqyV0ZAE622hfASWF4Qg98eyfFBd2e3mzPXiWGI3mtKegNJLs8WKreD2rjbyFBwpQbEK5BZw++uFXt1f12RT8M8=
X-Received: by 2002:a92:1e0a:: with SMTP id e10mr2508663ile.40.1575983426772;
 Tue, 10 Dec 2019 05:10:26 -0800 (PST)
MIME-Version: 1.0
References: <20191210100725.11005-1-brgl@bgdev.pl> <20191210121227.GB6110@sirena.org.uk>
 <CAMRc=MftOnQVAUjOz=UGV-S2HKPpiucQp98xYTdxgt7d8obCMg@mail.gmail.com> <20191210130244.GE6110@sirena.org.uk>
In-Reply-To: <20191210130244.GE6110@sirena.org.uk>
From:   Bartosz Golaszewski <brgl@bgdev.pl>
Date:   Tue, 10 Dec 2019 14:10:15 +0100
Message-ID: <CAMRc=MenTgffszv4NsbCKRhH0TcRPSTLbeP3BttW9fmFBjLdCA@mail.gmail.com>
Subject: Re: [PATCH] regulator: max77650: add of_match table
To:     Mark Brown <broonie@kernel.org>
Cc:     Liam Girdwood <lgirdwood@gmail.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

wt., 10 gru 2019 o 14:02 Mark Brown <broonie@kernel.org> napisa=C5=82(a):
>
> On Tue, Dec 10, 2019 at 01:51:38PM +0100, Bartosz Golaszewski wrote:
> > wt., 10 gru 2019 o 13:12 Mark Brown <broonie@kernel.org> napisa=C5=82(a=
):
>
> > > Why would we need to use a compatible string in a child node to load =
the
> > > regulator driver, surely we can just register a platform device in th=
e
> > > MFD?
>
> > The device is registered all right from MFD code, but the module won't
> > be loaded automatically from user-space even with the right
> > MODULE_ALIAS() for sub-nodes unless we define the
> > MODULE_DEVICE_TABLE().
>
> This seems to work fine for other drivers and the platform bus has to be
> usable on systems that don't use DT so that doesn't sound right.  Which
> MODULE_ALIAS() are you using exactly?
>

MODULE_ALIAS("platform:max77650-regulator");

> > Besides: the DT bindings define the compatible for sub-nodes already.
> > We should probably conform to that.
>
> I would say that's a mistake and should be fixed, this particular way of
> loading the regulators is a Linux implementation detail.

Fixed by removing this from the bindings?

Bartosz

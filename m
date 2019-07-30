Return-Path: <SRS0=Iew4=V3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 403A5C433FF
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jul 2019 11:21:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1350320693
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jul 2019 11:21:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Cv1cQIoK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729477AbfG3LU6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 30 Jul 2019 07:20:58 -0400
Received: from mail-ed1-f66.google.com ([209.85.208.66]:41996 "EHLO
        mail-ed1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726870AbfG3LU6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Jul 2019 07:20:58 -0400
Received: by mail-ed1-f66.google.com with SMTP id v15so62243708eds.9
        for <linux-kernel@vger.kernel.org>; Tue, 30 Jul 2019 04:20:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=HuK0NMbHIeL5R+Lo0vRZLhccdEIiNCzuWozzwqDVd8w=;
        b=Cv1cQIoKy6X6DttMsBcZfqs4es6CuyH7Zes6l42IuR4Fd3iseO+41GWkeU32pnJ2I/
         dg1rnI6SCQ8UQ9s0v4xSEU+qlnQX96GFTQ5vQdaQB3mjnIZsBXNCcx1DNCZTTZciQ3AA
         W6VVkorVtxW7hL5iPhpSIx0IfX6NrfeBUwy51Cx2LxonGE443LtQ+CSkDuXSdXma7erU
         n/TSZ3CbXk2Gd6OMq5u/83p3KF600YhCYKt6IkFyl3iA0s+FjKaonC5SGC/DrK/rxQhc
         DbrjTv/SyFTgMZ7/IDW6hmIswaWAZD250Xl4CC4v9Es+J4E+opM/yCPh0k0e5+UgxCot
         EWjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=HuK0NMbHIeL5R+Lo0vRZLhccdEIiNCzuWozzwqDVd8w=;
        b=czWMubiZ7hnzhcXp4TAEhJhy58aBSAf0lrYlS5d706a9J4dFbP3ltv8ZveoG+xvngK
         AEeiLbsNkYY+uour9W5LyGxSHeYF3e2fkT+9HHga296WViYIP97RHquwuDMZZ/C9gCZV
         ZTABAwBzbEFLC+LdEoQsH0pZwtEy0i6AH6kwHoHtNCIEwx+aO2iAtezgx9mIdPaWGTAn
         15MHPRQQ+NmELFexnzJvzmmxZCjTlFwGVh3/NTa74ppH3lwsbL03lYINrFMDmTFi1gQy
         ctlD6eDpe5hht978Or/1J/rSwiStTK+A0D+GP/IqW5xoiw1k9kLNDQAtnNcJ55hmIZrL
         MvEQ==
X-Gm-Message-State: APjAAAVVhIz/yIrN8M9kmCoN3BzgxMMxSq0Obs1expKjs327y+Pa7XRY
        91X7cFv5IWdcjB3oc8QO7w7MbhIh6spZaQIk+h4=
X-Google-Smtp-Source: APXvYqzgck29Wek0Q637GHCS3mnzpJyXc5pFJERINHwDs/+cdQllN7bSXJ18MnogG/COgn93hHQFHxQ6gwYMA9pO5UQ=
X-Received: by 2002:a17:906:78c7:: with SMTP id r7mr90317796ejn.147.1564485657187;
 Tue, 30 Jul 2019 04:20:57 -0700 (PDT)
MIME-Version: 1.0
References: <20190729151435.9498-1-hslester96@gmail.com> <alpine.DEB.2.21.1907301113580.1738@nanos.tec.linutronix.de>
 <CANhBUQ2L71Q2j_iOUaHW7qk0BS6wwMBwmtd8N4S5mNLYHr4Dhw@mail.gmail.com> <708d8d79-6464-fbd3-6a62-853c29b32cc3@kernel.org>
In-Reply-To: <708d8d79-6464-fbd3-6a62-853c29b32cc3@kernel.org>
From:   Chuhong Yuan <hslester96@gmail.com>
Date:   Tue, 30 Jul 2019 19:20:47 +0800
Message-ID: <CANhBUQ0uWu5yt3jXWxgH1a-i2vuHpkxwPbQ4PZdpPoi+LJ+P1Q@mail.gmail.com>
Subject: Re: [PATCH 05/12] genirq/debugfs: Replace strncmp with str_has_prefix
To:     Marc Zyngier <maz@kernel.org>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Marc Zyngier <maz@kernel.org> =E4=BA=8E2019=E5=B9=B47=E6=9C=8830=E6=97=A5=
=E5=91=A8=E4=BA=8C =E4=B8=8B=E5=8D=887:13=E5=86=99=E9=81=93=EF=BC=9A
>
> On 30/07/2019 11:58, Chuhong Yuan wrote:
> > Thomas Gleixner <tglx@linutronix.de> =E4=BA=8E2019=E5=B9=B47=E6=9C=8830=
=E6=97=A5=E5=91=A8=E4=BA=8C =E4=B8=8B=E5=8D=885:17=E5=86=99=E9=81=93=EF=BC=
=9A
> >>
> >> On Mon, 29 Jul 2019, Chuhong Yuan wrote:
> >>
> >>> strncmp(str, const, len) is error-prone.
> >>> We had better use newly introduced
> >>> str_has_prefix() instead of it.
> >>
> >> Can you please provide a proper explanation why the below strncmp() is
> >> error prone?
> >>
> >
> > If the size is less than 7, for example, 2, then even if buf is "tr", t=
he
> > result will still be true. This is an error.
> > strncmp(str, const, len) is error-prone mainly because the len is easy
> > to be wrong.
> >
> >> Just running a script and copying some boiler plate changelog saying
> >> 'strncmp() is error prone' does not cut it.
> >>
> >>> -     if (!strncmp(buf, "trigger", size)) {
> >>> +     if (str_has_prefix(buf, "trigger")) {
> >>
> >> Especially when the resulting code is not equivalent.
> >>
> >
> > I think here the semantic is the comparison should only return true
> > when buf is "trigger".
>
> Not quite. It will satisfy the condition for 't', 'tr', 'trig',
> 'trigger', and of course 'triggerthissillyinterruptwhichImdebugging'.
>
> I agree that the semantic is a bit bizarre and maybe not quite expected,
> but still... You seem to be changing the semantic without any
> justification other than "this is safer".
>

I am sorry about that... It is my fault.
I will improve my script and avoid such mistakes.
Thanks for your correction.

Regards,
Chuhong

> Thanks,
>
>         M.
> --
> Jazz is not dead, it just smells funny...

Return-Path: <SRS0=NWWL=SU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A9F2BC10F0E
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Apr 2019 13:54:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7F69420643
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Apr 2019 13:54:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389030AbfDRNyb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Apr 2019 09:54:31 -0400
Received: from mail-ot1-f65.google.com ([209.85.210.65]:45231 "EHLO
        mail-ot1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728074AbfDRNya (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Apr 2019 09:54:30 -0400
Received: by mail-ot1-f65.google.com with SMTP id e5so1738882otk.12
        for <linux-kernel@vger.kernel.org>; Thu, 18 Apr 2019 06:54:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=U5d7FWyo3nBz5oSQdSEgCnf1oCh1t3mYGk0DDdpCjgw=;
        b=dZMKh+kl/kbP8dIGWN7k08Ff+m9wE1gPQhDPO2GI4WSdHSBPwJcbwIhQvfmO7IXduL
         h5U/udpOq5ObVdA9nfJA6ts6McRVOd/33IpAQmXTrvATMc7mXMxTcrqNDX039iUyJhI3
         m5Wsf6iK+nr/kOSwZQ2Miopy5WE4feeJLaAxfKmG2Gwp5zuZ6Mx4K65BfSwmTRLT4DcC
         Ox6D7Bykkzimck38/zJEPMo7atg/+uynGmK8DbiMBUqC1OesQKJuFY6Hjo+pZEkgVDcO
         ch+4+WtiEiCRf1wB5Py30rjKXFM3Nucgq/vRVBMzzaCQSw+7NkPzDN5E5j2ZZLwIY8mo
         1k8A==
X-Gm-Message-State: APjAAAUkuu4bEDfU05lO+q8JHNAOfOaJb6NQ/J97CAY25XihAXA/wBQ9
        xnyELbs22icVmeZPkIkM3R2j5tfwQYCZi9wAGiG7Aw==
X-Google-Smtp-Source: APXvYqz3sWuI9BFRQc9kLKrdHmlj8snAeunATphCZx58vTawISM/xdz4/EM0g/snoUMaUmzKqvDonDlMlke8rQeFvRQ=
X-Received: by 2002:a9d:5cca:: with SMTP id r10mr39994648oti.21.1555595670209;
 Thu, 18 Apr 2019 06:54:30 -0700 (PDT)
MIME-Version: 1.0
References: <20190417084833.7401-1-mlichvar@redhat.com> <CAFqZXNu_pc1BEGZJb=3Ez58uN+BfoECpSm2yVqv1MMx7iTLfRw@mail.gmail.com>
 <20190418080710.GE5984@localhost> <alpine.DEB.2.21.1904181106150.3174@nanos.tec.linutronix.de>
In-Reply-To: <alpine.DEB.2.21.1904181106150.3174@nanos.tec.linutronix.de>
From:   Ondrej Mosnacek <omosnace@redhat.com>
Date:   Thu, 18 Apr 2019 15:54:19 +0200
Message-ID: <CAFqZXNvr8UqTdAjPKUnCT98nCkSKMBVDycQ=fkkqk1AkCHoCzw@mail.gmail.com>
Subject: Re: [PATCH] ntp: Allow TAI-UTC offset to be set to zero
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     Miroslav Lichvar <mlichvar@redhat.com>,
        Linux kernel mailing list <linux-kernel@vger.kernel.org>,
        John Stultz <john.stultz@linaro.org>,
        Richard Cochran <richardcochran@gmail.com>,
        Prarit Bhargava <prarit@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 18, 2019 at 11:07 AM Thomas Gleixner <tglx@linutronix.de> wrote:
> On Thu, 18 Apr 2019, Miroslav Lichvar wrote:
> > On Wed, Apr 17, 2019 at 11:00:23AM +0200, Ondrej Mosnacek wrote:
> > > On Wed, Apr 17, 2019 at 10:48 AM Miroslav Lichvar <mlichvar@redhat.com> wrote:
> > > > Change the ADJ_TAI check to accept zero as a valid TAI-UTC offset in
> > > > order to allow setting it back to the initial value.
> >
> > > Thanks for sending the patch! Maybe you (or the committer) could
> > > consider adding:
> > >
> > > Fixes: 153b5d054ac2 ("ntp: support for TAI")
> >
> > To me the change looks more like an extension of the API, rather than
> > a bug fix, so I'd leave that up to the committer.
>
> I don't see why we need to backport that all the way, but I'm happy to add
> the tag if there is some really good reason.

OK, I can live without it, it's just that it kind of breaks the tests
for the recent time auditing patches [1] (I try to reset to previous
values when triggering events). I worked around it for now by
resetting the value to 1 when original value was 0... I don't know if
it can lead to some issues or not, but it would be nice if I could
reset to the actual original value...

[1] https://github.com/linux-audit/audit-testsuite/pull/82/files#diff-555d96083b536100d9b7e3eea56feadbR76

-- 
Ondrej Mosnacek <omosnace at redhat dot com>
Software Engineer, Security Technologies
Red Hat, Inc.

Return-Path: <SRS0=nCuq=XH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 84F97C4CEC6
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Sep 2019 22:58:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5536920856
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Sep 2019 22:58:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="lQCZxf2w"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727504AbfILW63 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 12 Sep 2019 18:58:29 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:44253 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726099AbfILW63 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Sep 2019 18:58:29 -0400
Received: by mail-pf1-f196.google.com with SMTP id q21so16868811pfn.11
        for <linux-kernel@vger.kernel.org>; Thu, 12 Sep 2019 15:58:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=QtcuvnqG4r2YqI4zyIzKkMUs7uL0jyuefwghC3YKW8k=;
        b=lQCZxf2wWj/TD7i+zM4x52/vcGK5ifsJjrjavtQIbd5PmjztGeExGDQxomnWHrphOB
         D/b/4Xm2CTnyaPHy4dZUJ3v7HBtU4EwyETt2D2kuo5QIp0uH52f7JYTDWDsLOI/ra7wo
         y2ug9CJE1vVyWHHyERvCW1WG/VwSFT0QTlVjDmHRrNl6zJ84sUCcXEkrKgWQpbt3/vtH
         bap3kGRCKwkycQUg8DMdT2aCQwUuPvJc7KvoQGGxEbD1nusDY2UowCwEy8SjbrSV+l8Y
         38Yy7ebxD1Kjv9rfsY98KICrdYKwehq1d+xx++tGhXaZog4YEDqokAuJ6C+q3tyKeHmw
         V66w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=QtcuvnqG4r2YqI4zyIzKkMUs7uL0jyuefwghC3YKW8k=;
        b=dducNfZq/vc3RQ0ePrTQzlzlH2GE7pYtV1eO+VfPOZhf884SWptcavs3+HGa6suRY1
         rFNsJaYNn1BuIj/qJtQwVxk45kFaiTBRVxNZTG+1Z6R+LQIgZhzQhXOBZJpKlb9Xau5G
         SvyCa0+lHJufPgDZGDR2XbUY1p7q8zzIFggP+3KqAvH2KZJLqOoSEqHgVdtflk7AvK6C
         uTdsatkMzvzp3jQk8tuLeyZgtWQrvSllbYlxKgCUemtQ9gyks+fajMg0NxFzDq/h7SJb
         9YhG5aSYaK9uTbbQOBBqGtEUUMPw2HmqS1anHXJudMZtczeF4wp8ZDVM0BnmTKB0z192
         Yxcw==
X-Gm-Message-State: APjAAAV4IPCDe9qjnLU9JD7u8o1Wat883c0WN/qgyDY8PNmABNCAF28l
        cRBcZtZTeGWEM46+RASlT4sLEm4yDrvvdGPIkK2uLw==
X-Google-Smtp-Source: APXvYqz6gVZGXvJhjhSW8JaLlu8jIhADm3zroXYMALeDqhcHJ4OAuXRJ56yt3mguafQUipBgMbVaMEZ3Jt2n9yKXuPE=
X-Received: by 2002:a62:5fc1:: with SMTP id t184mr19502919pfb.84.1568329108004;
 Thu, 12 Sep 2019 15:58:28 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1568256705.git.joe@perches.com> <x498sqtvclx.fsf@segfault.boston.devel.redhat.com>
 <CANiq72kTsf=0rEufDMo7BzMNv1dqc5=ws7fSd=H_e=cpHR24Kg@mail.gmail.com>
 <4df0a07ec8f1391acfa987ecef184a50e7831000.camel@perches.com> <CANiq72mgbepmw=G5pM7iSRf-Eob7AHFzLw=76uFivpNGtccyKw@mail.gmail.com>
In-Reply-To: <CANiq72mgbepmw=G5pM7iSRf-Eob7AHFzLw=76uFivpNGtccyKw@mail.gmail.com>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Thu, 12 Sep 2019 15:58:16 -0700
Message-ID: <CAKwvOd=OrAzUb0+c0jkR1OLCcjXh+QnrCHhk39+p3Fv2unBxjQ@mail.gmail.com>
Subject: Re: [PATCH 00/13] nvdimm: Use more common kernel coding style
To:     Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Cc:     Joe Perches <joe@perches.com>, Jeff Moyer <jmoyer@redhat.com>,
        Dan Williams <dan.j.williams@intel.com>,
        linux-nvdimm <linux-nvdimm@lists.01.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Dan Carpenter <dan.carpenter@oracle.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 12, 2019 at 2:58 PM Miguel Ojeda
<miguel.ojeda.sandonis@gmail.com> wrote:
>
> On Thu, Sep 12, 2019 at 11:08 PM Joe Perches <joe@perches.com> wrote:
> >
> > Please name the major projects and then point to their
> > .clang-format equivalents.
> >
> > Also note the size/scope/complexity of the major projects.
>
> Mozilla, WebKit, LLVM and Microsoft. They have their style distributed
> with the official clang-format, not sure if they enforce it.
>
> Same for Chromium/Chrome, but it looks like they indeed enforce it:
>
>   "A checkout should give you clang-format to automatically format C++
> code. By policy, Clang's formatting of code should always be accepted
> in code reviews."
>
> I would bet other Google projects do so as well (since Chandler
> Carruth has been giving talks about clang-format for 7+ years). Nick?

So Google3 (the internal monorepo that Android, Chromium, ChromiumOS,
Fuchsia are not a part of) is pretty sweet.  You cannot even post code
unless the linter has been run on it (presubmit hook), which for our
~350 millions LoC of C++ is clang-format.  If you bypass local
presubmit hooks, our code review tool ("critique") won't let you
submit code that fails lint presubmit checks.  I suspect the initial
conversion was probably committed by bots.

>
> I hope those are major enough. There is also precedent in other
> languages (e.g. Java, C#, Rust).

Yep! Other people coming to C/C++ from these languages find the
discussion about tabs vs spaces to be highly entertaining!  When you
have an automated code formatter and an agreed upon coding style (and
hopefully enforcement), you save so much time from avoided bikesheds!
Don't like the codebase's coding style?  Then write the code how you
like and just run the formatter when you're done (might not help with
conventions though, maybe that's where checkpatch.pl can shine).
Done! No more wasted time on what color to paint the bikeshed!
-- 
Thanks,
~Nick Desaulniers

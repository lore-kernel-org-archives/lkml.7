Return-Path: <SRS0=8sqo=RS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 32201C43381
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Mar 2019 17:33:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 014EB218D3
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Mar 2019 17:33:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=intel-com.20150623.gappssmtp.com header.i=@intel-com.20150623.gappssmtp.com header.b="UZ/EUy5U"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729866AbfCORdy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 Mar 2019 13:33:54 -0400
Received: from mail-oi1-f196.google.com ([209.85.167.196]:42926 "EHLO
        mail-oi1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727075AbfCORdy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Mar 2019 13:33:54 -0400
Received: by mail-oi1-f196.google.com with SMTP id m4so7963973oim.9
        for <linux-kernel@vger.kernel.org>; Fri, 15 Mar 2019 10:33:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=KbOPCLGH615rzHUJ58dlndK4nolZ2OflZPgnP6NqsWc=;
        b=UZ/EUy5Upo9VPqGw6mzjs/HX3bsCxRl6Q1QwlY+UPQS1NYfI3Ssh5KtVm5yps/0APD
         I9wur5s5LRgFE2oMVJVh2oJUcZjjJfdtrN6jvCsnGfNJNuQneS3+v8yylqoSK7ej/9mt
         hhMuRP9sDxWYsS17phPcuOO46l7QrcDA6I8k0cV/4K+6R0vqQ+PSbRtAMiZvm5FERdeJ
         Ro6e8pmoqf/NtZEq2PxjuKhOwQ6WwOUi9Xexw5Ems+jxIS3sn07q4UAvgkbL42PbjefE
         k+5qbEBC1zqzNfOVjR6JCByhM0oNSRiUbVMatHHEc6PWD9tK/321E5QtxTDt3F+FNsJB
         rYQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=KbOPCLGH615rzHUJ58dlndK4nolZ2OflZPgnP6NqsWc=;
        b=tvK2Z8fvMrbB74UtQe3LDAsfyGe8mxdEOHd5OSlNk4kyeivwhtL5/otdmZiljXNXVc
         rCh9ey3YG+H4PcgQhqoxc/tZx+hdTsvMyjGfG8Y1f1y8TGBUjnrfTdx8eNi0FmzKuQ9I
         ESsH6wWzQoHkkO8JWCG15yo8h1rY0QOz8KrX+nI9u1SJ2vOkBUSPW8S3+f4euaJSrK5F
         429YP0A/qHuXRERkw6uNDzsqRB+VSraJV8zVtAAKm1Lj65wtc7xNhKWkLsbacc93qe8Y
         wXJseFApIWNtUbNwEQaGzbDRNfwTBCeRy41rC3PMl7/MYseQCKSDTYJDqxxdMB1Sl+6A
         Tnow==
X-Gm-Message-State: APjAAAV3lPC0bacLIMUwYmuqf60p/UanVaK2YP8l99lZj7DdriyCPaQT
        o+83XIeoW0vHcR90iYOGMfHNDIyjy6KSMfc76kwnoQ==
X-Google-Smtp-Source: APXvYqzTpDg/na3VtIyOako/c4bGiTvqvf5i8gtF287Ago1Xz7ZKyg00WEzH0Jg30fjR8evDl6LdTMDv19Kji+AcjXg=
X-Received: by 2002:aca:df57:: with SMTP id w84mr2379057oig.105.1552671232790;
 Fri, 15 Mar 2019 10:33:52 -0700 (PDT)
MIME-Version: 1.0
References: <CAPcyv4he0q_FdqqiXarp0bXjcggs8QZX8Od560E2iFxzCU3Qag@mail.gmail.com>
 <CAHk-=wjvmwD_0=CRQtNs5RBh8oJwrriXDn+XNWOU=wk8OyQ5ew@mail.gmail.com>
 <CAPcyv4hafLUr2rKdLG+3SHXyWaa0d_2g8AKKZRf2mKPW+3DUSA@mail.gmail.com>
 <CAHk-=wiTM93XKaFqUOR7q7133wvzNS8Kj777EZ9E8S99NbZhAA@mail.gmail.com>
 <CAPcyv4hMZMuSEtUkKqL067f4cWPGivzn9mCtv3gZsJG2qUOYvg@mail.gmail.com> <CAHk-=wgnJd_qY1wGc0KcoGrNz3Mp9-8mQFMDLoTXvEMVtAxyZQ@mail.gmail.com>
In-Reply-To: <CAHk-=wgnJd_qY1wGc0KcoGrNz3Mp9-8mQFMDLoTXvEMVtAxyZQ@mail.gmail.com>
From:   Dan Williams <dan.j.williams@intel.com>
Date:   Fri, 15 Mar 2019 10:33:41 -0700
Message-ID: <CAPcyv4iUxDj26_6neOVEg7b6_2SLHKpohv9o6jv95R_RhV1S-g@mail.gmail.com>
Subject: Re: [GIT PULL] device-dax for 5.1: PMEM as RAM
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-nvdimm <linux-nvdimm@lists.01.org>,
        Linux MM <linux-mm@kvack.org>,
        Dave Hansen <dave.hansen@intel.com>,
        "Luck, Tony" <tony.luck@intel.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 11, 2019 at 5:08 PM Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> On Mon, Mar 11, 2019 at 8:37 AM Dan Williams <dan.j.williams@intel.com> wrote:
> >
> > Another feature the userspace tooling can support for the PMEM as RAM
> > case is the ability to complete an Address Range Scrub of the range
> > before it is added to the core-mm. I.e at least ensure that previously
> > encountered poison is eliminated.
>
> Ok, so this at least makes sense as an argument to me.
>
> In the "PMEM as filesystem" part, the errors have long-term history,
> while in "PMEM as RAM" the memory may be physically the same thing,
> but it doesn't have the history and as such may not be prone to
> long-term errors the same way.
>
> So that validly argues that yes, when used as RAM, the likelihood for
> errors is much lower because they don't accumulate the same way.

Hi Linus,

The question about a new enumeration mechanism for this has been
raised, but I don't expect a response before the merge window closes.
While it percolates, how do you want to proceed in the meantime?

The kernel could export it's knowledge of the situation in
/sys/devices/system/cpu/vulnerabilities?

Otherwise, the exposure can be reduced in the volatile-RAM case by
scanning for and clearing errors before it is onlined as RAM. The
userspace tooling for that can be in place before v5.1-final. There's
also runtime notifications of errors via acpi_nfit_uc_error_notify()
from background scrubbers on the DIMM devices. With that mechanism the
kernel could proactively clear newly discovered poison in the volatile
case, but that would be additional development more suitable for v5.2.

I understand the concern, and the need to highlight this issue by
tapping the brakes on feature development, but I don't see PMEM as RAM
making the situation worse when the exposure is also there via DAX in
the PMEM case. Volatile-RAM is arguably a safer use case since it's
possible to repair pages where the persistent case needs active
application coordination.

Please take another look at merging this for v5.1, or otherwise let me
know what software changes you'd like to see to move this forward. I'm
also open to the idea of just teaching memcpy_mcsafe() to use rep; mov
as if it was always recoverable and relying on the error being mapped
out after reboot if it was not recoverable. At reboot the driver gets
notification of physical addresses that caused a previous crash so
that software can avoid a future consumption.

git://git.kernel.org/pub/scm/linux/kernel/git/nvdimm/nvdimm tags/devdax-for-5.1

Return-Path: <SRS0=FrXW=TP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DC673C04E87
	for <linux-kernel@archiver.kernel.org>; Wed, 15 May 2019 20:26:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AA4712084E
	for <linux-kernel@archiver.kernel.org>; Wed, 15 May 2019 20:26:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=intel-com.20150623.gappssmtp.com header.i=@intel-com.20150623.gappssmtp.com header.b="SAIOuCey"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727486AbfEOU03 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 15 May 2019 16:26:29 -0400
Received: from mail-oi1-f193.google.com ([209.85.167.193]:40817 "EHLO
        mail-oi1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726170AbfEOU02 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 May 2019 16:26:28 -0400
Received: by mail-oi1-f193.google.com with SMTP id r136so793187oie.7
        for <linux-kernel@vger.kernel.org>; Wed, 15 May 2019 13:26:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=CNowSPd6xUM0oSrW52wC5X6N9h9RHW9ouHTqZZOyPB4=;
        b=SAIOuCey/H4PDGjItNH6MJbpdQ6eVphhRbi02FoQ/YOnoYGxaydqsOYiVIAO/t3q68
         0i+LFQ13vsz1bj8cCiXxLi+GMY0PpVS/n4Tnm/fMII2aHygPYzSJnwoWDtPiIo9XVU4B
         UF+xwmZUZQ0W+oJace3RMwVkn3Iuq8GIugGZdBu4qRRMMPgZWHzuG5COUhU0vp87nTs/
         FG1JFG1PtJ3RikGbUfL/NJErfucnwOSQDnoR242LrP2jVHyNv6FXHEZUgTRCbyr9ydcG
         Lyzzv47sX90bEqpeR7WfOo7msFCsrbGa0h1IuogufITOeuGE2XDwd6+gyOeGA8Z7o+W9
         OqGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=CNowSPd6xUM0oSrW52wC5X6N9h9RHW9ouHTqZZOyPB4=;
        b=XdmoeTX3V1Ekl4HBDlGCDq5F37LatvqDo0KE7Z3bOAh1PEeE+lGo/nSe76XfNpBFAo
         0P4VdyGz8XIyGvI2pnUbn8F2gc4lLZvPA44xTrr2oraDba8iXmihBNlTESH9EWiGvvDv
         eHr3CY+Qd8iT5b+5crwcf/jSnTjPAeeoXE0ma2kh0WQ6WrZ7gF4QlSBGHMnBH3nkYbJE
         kb43rzltU3GzhZAdR9Fda4v3shqLcq7k44h8RZB93dwbrkv87gZgD3Dd6/8JeL68/fJa
         ELJP6Yza5ekSWJCLojb5cWag0RHsrX4W6ap4a1xeE1XQchW+yuBWe5YKehp0vhtO0dvK
         PWcQ==
X-Gm-Message-State: APjAAAUOpZbme9M4WmoXHUkwrGeF7asFyrXGFBU3FUc7aqhLITOLvBMQ
        jypuAPerYpAmS5pxfQVrhJjvB4V2/Hlf849FqqPjgg==
X-Google-Smtp-Source: APXvYqx3oc7K1TBy0FDWKi5FhWmRYToljSQrlPDbQpttbtlguEoDEhZRGEYR3NAHlPXP6/3HQG4xvypvNp6sEKcLSAk=
X-Received: by 2002:aca:4208:: with SMTP id p8mr8481558oia.105.1557951987781;
 Wed, 15 May 2019 13:26:27 -0700 (PDT)
MIME-Version: 1.0
References: <CAPcyv4he0q_FdqqiXarp0bXjcggs8QZX8Od560E2iFxzCU3Qag@mail.gmail.com>
 <CAHk-=wjvmwD_0=CRQtNs5RBh8oJwrriXDn+XNWOU=wk8OyQ5ew@mail.gmail.com>
 <CAPcyv4hafLUr2rKdLG+3SHXyWaa0d_2g8AKKZRf2mKPW+3DUSA@mail.gmail.com>
 <CAHk-=wiTM93XKaFqUOR7q7133wvzNS8Kj777EZ9E8S99NbZhAA@mail.gmail.com>
 <CAPcyv4hMZMuSEtUkKqL067f4cWPGivzn9mCtv3gZsJG2qUOYvg@mail.gmail.com> <CAHk-=wgnJd_qY1wGc0KcoGrNz3Mp9-8mQFMDLoTXvEMVtAxyZQ@mail.gmail.com>
In-Reply-To: <CAHk-=wgnJd_qY1wGc0KcoGrNz3Mp9-8mQFMDLoTXvEMVtAxyZQ@mail.gmail.com>
From:   Dan Williams <dan.j.williams@intel.com>
Date:   Wed, 15 May 2019 13:26:16 -0700
Message-ID: <CAPcyv4g+reM9y+CiGXpxBYMQZ-Yh4LuXDi2530FR0zt3o6J8Hg@mail.gmail.com>
Subject: Re: [GIT PULL] device-dax for 5.1: PMEM as RAM
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-nvdimm <linux-nvdimm@lists.01.org>,
        Linux MM <linux-mm@kvack.org>,
        Dave Hansen <dave.hansen@intel.com>,
        "Luck, Tony" <tony.luck@intel.com>,
        Vishal L Verma <vishal.l.verma@intel.com>
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

In case anyone is looking for the above mentioned tooling for use with
the v5.1 kernel, Vishal has released ndctl-v65 with the new
"clear-errors" command [1].

[1]: https://pmem.io/ndctl/ndctl-clear-errors.html

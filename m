Return-Path: <SRS0=nCuq=XH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A0A70C4CEC6
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Sep 2019 21:58:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 75AE320830
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Sep 2019 21:58:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PGW6zE4w"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729193AbfILV6m (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 12 Sep 2019 17:58:42 -0400
Received: from mail-lf1-f68.google.com ([209.85.167.68]:39929 "EHLO
        mail-lf1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727041AbfILV6m (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Sep 2019 17:58:42 -0400
Received: by mail-lf1-f68.google.com with SMTP id u26so2843601lfg.6
        for <linux-kernel@vger.kernel.org>; Thu, 12 Sep 2019 14:58:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=yN64USJBHKxsfREIuBd8D01a5UImJnKtWKpzPkFiizg=;
        b=PGW6zE4wNxxbjukTtRMTx8QNmVGcBEm2hLEbRkWw3oXK9nosmOY/buL4Xg57qP7S6J
         hRKk5uMe62EFQnvCvGdpsQIO5VfARhpFMvQBS9xjkfCFbqRsSvDw8KqqDB15n+yYeLBn
         zPxoy5clxY4UDz73h1hZC/niCSMsEOmI6A5RJaept57woKtYBCfsKB5hBWKo4ZbgQrWw
         EB20B8PyGGMZr6eYzQkz5kJ9NI6NBrd1D9O0D29B1H94HFsPeO14NBzRgYFMpa8+6fXq
         zJk3j/7eXO93uB2VhFrcsr0AwzLy+U0ZI1QJ6qUYEUcccgf0rmiNtji2b9kK7Sq1AnvZ
         jG/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=yN64USJBHKxsfREIuBd8D01a5UImJnKtWKpzPkFiizg=;
        b=lKepfD8f7TapO011JxArzNbKSmvLjsaPUemZdVs7h1i4qETMK6tQoJZWwS4U880tHY
         vKifRDYKxPdx8MtoaMPSsUqVaTBluasL07BOnJEystuIyNOB5R0QYMuN64y3xzIqTisf
         DDc4MiuzrvY2Jc8GxTZPFqWv1tDes7ZzG5w/UMhqEEtCWU6XOC9bfw69BAjlfjKHt4v7
         9J5hjHRFxz1s6sMhPGmjzFTkXSl/C7ITLcSmGIiXrKATuIb2bnpeBKvwjfedzNFfOoBw
         GuW2lt8yRUzNkPSqyIG6j2JMmnk6jFEf0ioVYfxSFg6rtPuuFRcgGdmPc/pUYqfahScG
         k2WQ==
X-Gm-Message-State: APjAAAWrIwKhmxQ8k4whjzsOLex/HlQguWeT3zXCWuFvED4OrqU5DJfu
        K1O6UBKBbUvKMnYYskK2bX+U0jLsmFef8p2BYFY=
X-Google-Smtp-Source: APXvYqx/qjsJazNB675gWGR/Z07snhq12vp75Kg6Qq3NQ2rBGj/WnqBglk8w5SZZbbo9fLzY24rbLzt+aQGVznyXfUU=
X-Received: by 2002:a19:428f:: with SMTP id p137mr29623982lfa.149.1568325518795;
 Thu, 12 Sep 2019 14:58:38 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1568256705.git.joe@perches.com> <x498sqtvclx.fsf@segfault.boston.devel.redhat.com>
 <CANiq72kTsf=0rEufDMo7BzMNv1dqc5=ws7fSd=H_e=cpHR24Kg@mail.gmail.com> <4df0a07ec8f1391acfa987ecef184a50e7831000.camel@perches.com>
In-Reply-To: <4df0a07ec8f1391acfa987ecef184a50e7831000.camel@perches.com>
From:   Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date:   Thu, 12 Sep 2019 23:58:27 +0200
Message-ID: <CANiq72mgbepmw=G5pM7iSRf-Eob7AHFzLw=76uFivpNGtccyKw@mail.gmail.com>
Subject: Re: [PATCH 00/13] nvdimm: Use more common kernel coding style
To:     Joe Perches <joe@perches.com>,
        Nick Desaulniers <ndesaulniers@google.com>
Cc:     Jeff Moyer <jmoyer@redhat.com>,
        Dan Williams <dan.j.williams@intel.com>,
        linux-nvdimm <linux-nvdimm@lists.01.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Dan Carpenter <dan.carpenter@oracle.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 12, 2019 at 11:08 PM Joe Perches <joe@perches.com> wrote:
>
> Please name the major projects and then point to their
> .clang-format equivalents.
>
> Also note the size/scope/complexity of the major projects.

Mozilla, WebKit, LLVM and Microsoft. They have their style distributed
with the official clang-format, not sure if they enforce it.

Same for Chromium/Chrome, but it looks like they indeed enforce it:

  "A checkout should give you clang-format to automatically format C++
code. By policy, Clang's formatting of code should always be accepted
in code reviews."

I would bet other Google projects do so as well (since Chandler
Carruth has been giving talks about clang-format for 7+ years). Nick?

I hope those are major enough. There is also precedent in other
languages (e.g. Java, C#, Rust).

> I used the latest one, and quite a bit of the conversion
> was unpleasant to read.

It would be good to see particularly bad snippets to see if we can do
something about them (and, if needed, try to improve clang-format to
support whatever we need).

Did you tweak the parameters with the new ones? I am preparing an RFC
patch for an updated .clang-format configuration that improves quite a
bit the results w.r.t. to the current one (and allows for some leeway
on the developer's side, which helps prevent some cases too).

> Marking sections _no_auto_format_ isn't really a
> good solution is it?

I am thinking about special tables that are hand-crafted or very
complex macros. For those, yes, I think it is a fine solution. That is
why clang-format has that feature to begin with, and you can see an
example in Mozilla's style guide which points here:

  https://github.com/mozilla/gecko-dev/blob/master/xpcom/io/nsEscape.cpp#L22

Cheers,
Miguel

Return-Path: <SRS0=nCuq=XH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 367A4C4CEC8
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Sep 2019 23:01:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0D28F20684
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Sep 2019 23:01:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="tPvXqEzH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727215AbfILXBG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 12 Sep 2019 19:01:06 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:41757 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726032AbfILXBG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Sep 2019 19:01:06 -0400
Received: by mail-pg1-f193.google.com with SMTP id x15so14231277pgg.8
        for <linux-kernel@vger.kernel.org>; Thu, 12 Sep 2019 16:01:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=D9dYUr5fMgUHKFTaUbiggMwqfm0d4ExFNXTKQwvsDKQ=;
        b=tPvXqEzHwKpENKEwHi+Skg0ISMB7ZFeB0yn6fEGDuRS61LxsjWdYrvLH7BObaVO3QB
         HsxMdXR+4aWWSfV+ANxcz0Bo0o3+m1Wv1IeRZJ5ymFd5GGiMrSTqBjgZv9EPPdkoVJoE
         nsaxTy4G3QnB9ClFNIRybTH9QlrNg8MIH4HJi8Gn1ORBp28GWQy/T1ZOBztKGGQNSQSA
         ZBmziZ1luIwLyXBh+aJj+Tq+k2YA2w1JufIQ425tRqxHmpOft3Fbk/nIN7Prdjv2GtT2
         eUCpew0OAlYYRdqQ9LTbf1aHAnRjHKtThgj8M46igFVG7H7c4gheoHjP36DfQhsOIKgA
         1F3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=D9dYUr5fMgUHKFTaUbiggMwqfm0d4ExFNXTKQwvsDKQ=;
        b=OSdMmNPODsQOCFC0C8rZAEcc2nno7gXX0fBfmZcfXgthdXRtOZU++IQNc996sX9kyL
         y4jz8KupsIdon6m30BKqe6WU76XTxYnLHUzpZureHmrBebArs8mJEXTB0HOPkhKa8WBp
         YiUL1jWjZ8dnFZrtRBoCY3v/qKDnLrw+BfQ6VpytsTwE76cSp7CozyMygQThXMFZhqqJ
         7NAB9OCMKugvD8oV+rUmO5EV+1w/337qk9sFJzFI2dfgSXMeqWpC6pmwPBavAXViRHi/
         7E8X2gRNbGNPrZREjys+StfYyQfEM29cFNDPZrbxLzCwTfF0WyY4hkzhx4hQGx31wjRc
         0/rA==
X-Gm-Message-State: APjAAAUXnaqI0qPfKz7DHexN6gKgvnfaiifB8hlsWo7UuAzszhQw0RLK
        fX1xMqVo5OHpPckmFA4y22mvyGUkvkX3/fR/ExwHFw==
X-Google-Smtp-Source: APXvYqxKPqcf3nesXiRdlItW9fzTGtoWDpjNQ9SjjFM/YxRP0tFmd4/ksEvcvMhaZFyTL+zMR5XBadhwoqkrNWZwEyE=
X-Received: by 2002:a63:6193:: with SMTP id v141mr41159638pgb.263.1568329264856;
 Thu, 12 Sep 2019 16:01:04 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1568256705.git.joe@perches.com> <x498sqtvclx.fsf@segfault.boston.devel.redhat.com>
 <CANiq72kTsf=0rEufDMo7BzMNv1dqc5=ws7fSd=H_e=cpHR24Kg@mail.gmail.com>
 <4df0a07ec8f1391acfa987ecef184a50e7831000.camel@perches.com>
 <CANiq72mgbepmw=G5pM7iSRf-Eob7AHFzLw=76uFivpNGtccyKw@mail.gmail.com> <4f759f8c4f4d59fd60008e833334e29b0da0869c.camel@perches.com>
In-Reply-To: <4f759f8c4f4d59fd60008e833334e29b0da0869c.camel@perches.com>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Thu, 12 Sep 2019 16:00:53 -0700
Message-ID: <CAKwvOd=S911qkQtN31JkusS==NXZMnEwrUOGN3Gp6B7GTzYe2A@mail.gmail.com>
Subject: Re: [PATCH 00/13] nvdimm: Use more common kernel coding style
To:     Joe Perches <joe@perches.com>
Cc:     Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>,
        Jeff Moyer <jmoyer@redhat.com>,
        Dan Williams <dan.j.williams@intel.com>,
        linux-nvdimm <linux-nvdimm@lists.01.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Dan Carpenter <dan.carpenter@oracle.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 12, 2019 at 3:38 PM Joe Perches <joe@perches.com> wrote:
>
> On Thu, 2019-09-12 at 23:58 +0200, Miguel Ojeda wrote:
> > On Thu, Sep 12, 2019 at 11:08 PM Joe Perches <joe@perches.com> wrote:
> > > Please name the major projects and then point to their
> > > .clang-format equivalents.
> > >
> > > Also note the size/scope/complexity of the major projects.
> >
> > Mozilla, WebKit, LLVM and Microsoft. They have their style distributed
> > with the official clang-format, not sure if they enforce it.
>
> At least for LLVM, it appears not.

I acknowledge the irony you present, but that's because there's no
enforcement on the LLVM side.  I frequently forget to run:
$ git-clang-format HEAD~

If you have automated systems that help encourage (ie. force) the use
of the formatter, this helps.

Consider the fact that not all kernel developers run checkpatch.pl.
Is that a deficiency in checkpatch.pl, or the lack of enforcement in
kernel developers' workflows?
-- 
Thanks,
~Nick Desaulniers

Return-Path: <SRS0=wo+8=V5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F0075C433FF
	for <linux-kernel@archiver.kernel.org>; Thu,  1 Aug 2019 16:34:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BD03D20679
	for <linux-kernel@archiver.kernel.org>; Thu,  1 Aug 2019 16:34:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="OA94mFnK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733012AbfHAQee (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 1 Aug 2019 12:34:34 -0400
Received: from mail-vs1-f65.google.com ([209.85.217.65]:41787 "EHLO
        mail-vs1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727024AbfHAQee (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Aug 2019 12:34:34 -0400
Received: by mail-vs1-f65.google.com with SMTP id 2so49264497vso.8
        for <linux-kernel@vger.kernel.org>; Thu, 01 Aug 2019 09:34:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=dvRoX0NEsQk9uexjhPZ3WYNGs4rNhG1WU3C5nGaJfJM=;
        b=OA94mFnKu9MN40x5ZP19/Na2xaPAb2ScvmDnDhcfY2prbEDzeCDna+MwcFseo3nnf5
         1AUcDpimJVSG1wT8fJosG0BZnnSuvapIZ53206Su4kgn5QQmaxAvbnNbW1l2qDcUSf7S
         g1CCg6WhlKunjGWiR+ByOfg5e/renIOsnueh69l9UYU9kzwbl+y/0wFgo7RZe9BpcWQf
         y4NlE7WvT9g6JByabW9SWTk6ge4/LEx9IlMEx8x8h0CEwzdytxY4S23QstL7jNj7dZbT
         yHei/SyFU3x0wlV9kg/i7T6d1yO8NHrdI7yzGaWIgDYZfPY1l7ma8qkaYpdrU7paRQLU
         dqHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=dvRoX0NEsQk9uexjhPZ3WYNGs4rNhG1WU3C5nGaJfJM=;
        b=E/9qbnu2bEEE0JpS426zJdVG+OuolrNdS77KWQFGto9psW5qPBHcAgnev1fiF06/J3
         Yw4qoVBfpkJedx/0tcv9Yh0kzafxSU84Ws7lfio/R1mb8ca0NuH+S765zKhJIfNF3iiJ
         rOiPtNV9cztglEncffzb6i73zNNt+OOBfinl7c5VJBvssuOcD33RiCfedvICmg1UJDRn
         j4P0B6xkeE4olaayqY6RkUKPn2q9KzB8eDGWjq60ILHY8b7jseFByXSh+lkoReGMzU7u
         dgKtrF4kynMHEk2JUT0IeB67jFa2kDd7zL9fALc3BEju4KA/Zgk84C8Yw+icQ/CCi7Yy
         52Ew==
X-Gm-Message-State: APjAAAVX0TL8snmWVQuh+BKrcq1YljYAHpp7E20WNo0bSnXZENMRBK7h
        uD/SWumJa2U2huf4UTgwyvHjkBUaQ76njfeU0TW63w==
X-Google-Smtp-Source: APXvYqydtcOkpu3k1CXQGjTrhaIKC2YliA7J9eX1NcSUJxl4798q/t6LuS+fW/3LemXGtS34w27lPgBhk1ooXMDOtVg=
X-Received: by 2002:a67:a44b:: with SMTP id p11mr78053893vsh.237.1564677272877;
 Thu, 01 Aug 2019 09:34:32 -0700 (PDT)
MIME-Version: 1.0
References: <20190731050549.GA20809@kroah.com> <20190731212933.23673-1-kaleshsingh@google.com>
 <20190801061941.GB4338@kroah.com>
In-Reply-To: <20190801061941.GB4338@kroah.com>
From:   Kalesh Singh <kaleshsingh@google.com>
Date:   Thu, 1 Aug 2019 09:34:22 -0700
Message-ID: <CAC_TJvdUReRL-Xqq-sSOZ6w1FpEA=Uzys22Mami1USrErnkw+Q@mail.gmail.com>
Subject: Re: [PATCH v2] PM/sleep: Expose suspend stats in sysfs
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     rjw@rjwysocki.net, Tri Vo <trong@google.com>, trong@android.com,
        Sandeep Patil <sspatil@google.com>,
        Hridya Valsaraju <hridya@google.com>, kernel-team@android.com,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 31, 2019 at 11:19 PM Greg KH <gregkh@linuxfoundation.org> wrote:
>
> On Wed, Jul 31, 2019 at 02:29:33PM -0700, Kalesh Singh wrote:
> > Userspace can get suspend stats from the suspend stats debugfs node.
> > Since debugfs doesn't have stable ABI, expose suspend stats in
> > sysfs under /sys/power/suspend_stats.
> >
> > Signed-off-by: Kalesh Singh <kaleshsingh@google.com>
> > ---
> > Changes in v2:
> >   - Added separate show functions for last_failed_* stats, as per Greg
> >   - Updated ABI Documentation
>
> This is nice, I didn't even know some of these were in the debugfs
> entries, so this should be more helpful to people.
>
> Reviewed-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

Thanks for the review Greg :)

Return-Path: <SRS0=iR9I=YX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4D63BCA9EC6
	for <linux-kernel@archiver.kernel.org>; Wed, 30 Oct 2019 16:36:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 149BA218DE
	for <linux-kernel@archiver.kernel.org>; Wed, 30 Oct 2019 16:36:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="TP1mC0gL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726706AbfJ3QgB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 30 Oct 2019 12:36:01 -0400
Received: from mail-pl1-f193.google.com ([209.85.214.193]:38270 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726261AbfJ3QgB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Oct 2019 12:36:01 -0400
Received: by mail-pl1-f193.google.com with SMTP id w8so1229667plq.5
        for <linux-kernel@vger.kernel.org>; Wed, 30 Oct 2019 09:36:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=6F55+54+eU8QzDjEOXqTDVs2Ok1yox6C3hLmR+t3oZM=;
        b=TP1mC0gLnHHHVfKFAZsLiSJm6cfVt7RCHpHMKMy1P6iz5El9WzTs6CPypDWYj+lbBA
         c397v0UUs7AuZ0aNOi1vg5XFvPVmY4Adm8GGwTfrMVRxY2AliI83rMNHUaMkCb7F3cOl
         OCUOfADoOj6UN/wgSbMIWCLgSeJMLtdGqV22fHSpBaBOmvMcZhtAtu8GJmndvyaBna2e
         Fu/nEwZic+B0n1xmz9bngOmmsLayhotdv/AijNTp49BNtBflcemDa69o562VCj3fTwY4
         umGEGwXV4pMe74CBAyjXDJuiYagYka6smdKOcXfoTWChixsdjekYhQhNtbBIqtVCzEFt
         zmAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=6F55+54+eU8QzDjEOXqTDVs2Ok1yox6C3hLmR+t3oZM=;
        b=l/iLBqrZX5nzbC5uXSndgdukWdyX/0qlktPndJipHeZRey0rguwn/oF01P/61WaNWL
         A3ppdc2w5XsCC4K3X4uuG/p608orm8HYsAp25zv/bP39rNuCb4Db6+8xpWLnorkQuq6S
         ZFBgXqFkw1pkvK8HQejLGGrRvTTqZN9Ng6PLwZFjqsCvtV0FJV887YVGgHtbab1I5TOF
         xus2Dc+RU6E4q6CY6y3mIpUBsoeKlTeECBEhEYN3DFeCoxTgpijBqDIwWEQZ0eLuHlr7
         X0jJysNwCGqTPotoov6WTi70+l6cKNyq7J43uGYfzyGm+DjqjFQZcYT+G6V/mrBI4nnJ
         QPVA==
X-Gm-Message-State: APjAAAVn30ScLGAbvMev042jzxMRRfjj6Hg2JUoSv/c6bU+vEaeyDThV
        uJmDF5qF15Akz8xV0emc0/j2K5BkEffielz3iC5n1w==
X-Google-Smtp-Source: APXvYqz/XrmygQKOZIZMirbxCR595GwMGW3lSvzbOMljT8nFXLLU/3fTEEpDU6SCw+BYZiuwvhLi0vmy7C2+JQ37VTU=
X-Received: by 2002:a17:902:b685:: with SMTP id c5mr915542pls.297.1572453359938;
 Wed, 30 Oct 2019 09:35:59 -0700 (PDT)
MIME-Version: 1.0
References: <20191024224631.118656-1-davidgow@google.com> <0cb1d948-0da3-eb0f-c58f-ae3a785dd0dd@kernel.org>
 <CABVgOSmCHbGjZBjeWSbPEZbJw22SaBQnoO77xxNzN_ugAwzNiQ@mail.gmail.com>
 <20191030104217.GA18421@kadam> <42a8270d-ed6f-d29f-5e71-7b76a074b63e@kernel.org>
In-Reply-To: <42a8270d-ed6f-d29f-5e71-7b76a074b63e@kernel.org>
From:   Brendan Higgins <brendanhiggins@google.com>
Date:   Wed, 30 Oct 2019 09:35:48 -0700
Message-ID: <CAFd5g47OZ8x9=etJUj4Sgsw38VQb0j=omOUsubc7+pb2rJi0bQ@mail.gmail.com>
Subject: Re: [PATCH linux-kselftest/test v6] lib/list-test: add a test for the
 'list' doubly linked list
To:     shuah <shuah@kernel.org>
Cc:     Dan Carpenter <dan.carpenter@oracle.com>,
        David Gow <davidgow@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Kees Cook <keescook@chromium.org>,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>,
        KUnit Development <kunit-dev@googlegroups.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 30, 2019 at 9:27 AM shuah <shuah@kernel.org> wrote:
>
> On 10/30/19 4:42 AM, Dan Carpenter wrote:
> > On Wed, Oct 30, 2019 at 01:02:11AM -0700, David Gow wrote:
> >>> ERROR: that open brace { should be on the previous line
> >>> #869: FILE: lib/list-test.c:680:
> >>> +static void list_test_list_for_each_entry_reverse(struct kunit *test)
> >>> +{
> >>>
> >>>
> >>> I am seeing these error and warns. As per our hallway conversation, the
> >>> "for_each*" in the test naming is tripping up checkpatch.pl
> >>>
> >>> For now you can change the name a bit to not trip checkpatch and maybe
> >>> explore fixing checkpatch to differentiate between function names
> >>> with "for_each" in them vs. the actual for_each usages in the code.
> >>
> >> Thanks, Shuah.
> >>
> >> Yes, the problem here is that checkpatch.pl believes that anything
> >> with "for_each" in its name must be a loop, so expects that the open
> >> brace is placed on the same line as for a for loop.
> >>
> >> Longer term, I think it'd be nicer, naming-wise, to fix or work around
> >> this issue in checkpatch.pl itself, as that'd allow the tests to
> >> continue to follow a naming pattern of "list_test_[x]", where [x] is
> >> the name of the function/macro being tested. Of course, short of
> >> trying to fit a whole C parser in checkpatch.pl, that's going to
> >> involve some compromises as well.
> >
> > Just make it a black list of the 5 most common for_each macros.
> >
>
> How does black listing work in the context of checkpatch.pl?
>
> >>
> >> In the meantime, I'm sending out v7 which replaces "for_each" with
> >> "for__each" (adding the extra underscore), so that checkpatch is
> >> happy.
>
> This change is required just to quiet checkpatch and I am not happy
> about asking for this change. At the same time, I am concerned about
> git hooks failing on this patch.
>
> >
> > It's better to ignore checkpatch and other scripts when they are wrong.
> > (unless the warning message inspires you to make the code more readable
> > for humans).
> >
>
> It gets confusing when to ignore and when not to. It takes work to
> figure out and it is subjective.
>
> It would be great if we can consistently rely on a tool that is used as
> a criteria for patches to accept patches.

Agreed. I can see the point of not wanting to write an exception into
checkpatch for every exception of it's general rules; however, it
would be nice if there was a way to maybe have a special comment or
something that could turn off a checkpatch error. That way, a
checkpatch error/warning always means some action should be taken, and
if a rule is being ignored, there is always documentation as to why.

Otherwise, I don't feel strongly about this.

Cheers

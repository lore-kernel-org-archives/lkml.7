Return-Path: <SRS0=camR=ZD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BA199C43331
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Nov 2019 10:29:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 862C8214DB
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Nov 2019 10:29:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="qhhB8Klj"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727069AbfKKK3C (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Nov 2019 05:29:02 -0500
Received: from mail-qk1-f195.google.com ([209.85.222.195]:45893 "EHLO
        mail-qk1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726810AbfKKK3C (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Nov 2019 05:29:02 -0500
Received: by mail-qk1-f195.google.com with SMTP id q70so10664617qke.12
        for <linux-kernel@vger.kernel.org>; Mon, 11 Nov 2019 02:29:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=neDYQCtvWG6GFLAme/V0Z/I/G6+bUaaHqT/zW9Z6Xws=;
        b=qhhB8Kljn7x47tZP6LMxBFrevO8A3qPIsX/IrEO+xjXdyoG+d/WmadVZ+WqSylArCp
         2dQfJJlBgrQlZ+0C8iAqUaLeauPQ6hUP/8wgBuK1pcBMgHcrL8LdFLEgxX+qfyVVMPMR
         WSYWJ635h2fYRFdYCwHOEovyGAXrsVSV+wqprNu4J8Ss01G+/+9TBSRu+4nMYQks84Ve
         CJLfa4RzkN5ldNZbCtI71AyPy/yAK7B7B2eVmnYrdUMP0v+Uwo3ULhLABMIYbgsgSBOJ
         siVOaCwwalZJdRrzLp+fdnqALBBftwzZwTR78ZPhY2UHHiHoboajfuvkzaSmPzbe7S24
         t6YQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=neDYQCtvWG6GFLAme/V0Z/I/G6+bUaaHqT/zW9Z6Xws=;
        b=NViuFcXwN/grRN3wZzPSIKorWByklNUA+uqEz/egS3vIJFDZRELY3rQnGjB4cLbl9p
         fB64LjCJz9zZCXkVLbdsqPYSgYQA+wQHs+/YSXanHSpa22Leb2CIrDNwx0dWZtQYYr22
         eYen2Rz8VX5DWCjK7LA/HgRGjav9Czbw7E7jd38Kr9pwWFOKwktrYDxrWXq+jxtWw+x/
         EOyV244PALCxFI6yFaDtBKwr9npHGHgi53qOuKciRovBduxT51ID/7BDKsV7CZlyz4Br
         L/5okVgauNwhBfSXTSc8VaAW/800t6jKkoinaig9YLZrw+TJGy1upa9CiWj3nvxPne4X
         X5pA==
X-Gm-Message-State: APjAAAWtKtUoxna8P9A6hcHvUkjC5GCFh+MYRaJ/qUvNVRO0CLSjpop0
        uLm5n/zErDlMpbbdOBjgbdhFIf6HCigOiKFewV09kqsqRw0=
X-Google-Smtp-Source: APXvYqy/nyfp+GQeHSfInpIwAhjuAclF3Inv8QGDz8ZXi4t0RJsu/giKvtvOR4wCf+5u0xuFp9+OI5w+cUsLuXatlJk=
X-Received: by 2002:a05:620a:1127:: with SMTP id p7mr5660664qkk.250.1573468140848;
 Mon, 11 Nov 2019 02:29:00 -0800 (PST)
MIME-Version: 1.0
References: <20191031084944.GA21077@redhat.com>
In-Reply-To: <20191031084944.GA21077@redhat.com>
From:   Dmitry Vyukov <dvyukov@google.com>
Date:   Mon, 11 Nov 2019 11:28:49 +0100
Message-ID: <CACT4Y+Y6CSG7fzOV7BTx3JQ8SKGy8iPyUggGUUv8A0JRhpkU7g@mail.gmail.com>
Subject: Re: syzkaller for uffd-wp
To:     Andrea Arcangeli <aarcange@redhat.com>
Cc:     Peter Xu <peterx@redhat.com>, Peter Shier <pshier@google.com>,
        syzkaller <syzkaller@googlegroups.com>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 31, 2019 at 9:49 AM Andrea Arcangeli <aarcange@redhat.com> wrote:
>
> Hi Dmitry,
>
> would it be possible to grill the uffd-wp patchset with syzkaller?
> It'd be nice if we can detect bugs before it gets merged.
>
> Peter posted it upstream, but we can provide a kernel git tree to
> pull. To fuzzy you likely need to add the new UFFD_WP feature flag and
> registration options to the fuzzer.
>
> Thanks,
> Andrea

+syzkaller, linux-fsdevel

[getting through backlog after OSS/ELC/LSS]

Hi Andrea,

I won't have time for this in the near future unfortunately.
But if you (or anybody on the lists)  are interested in providing
better testing for uffd, we have docs on how to extend syzkaller:
https://github.com/google/syzkaller/blob/master/docs/syscall_descriptions.md#describing-new-system-calls
You may also look at the past changes adding new syscall descriptions
and we have help provided on the syzkaller@ mailing list.
Generally, the core syzkaller team (<1 person overall) can't become
experts and describe thousands of subsystems in a dozen of OSes.

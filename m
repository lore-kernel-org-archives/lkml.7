Return-Path: <SRS0=bo2+=SE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 32A47C43381
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Apr 2019 02:55:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E64D52087C
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Apr 2019 02:55:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="S80rgrKK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728840AbfDBCzD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Apr 2019 22:55:03 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:38535 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728196AbfDBCzD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Apr 2019 22:55:03 -0400
Received: by mail-pf1-f196.google.com with SMTP id 10so5572025pfo.5
        for <linux-kernel@vger.kernel.org>; Mon, 01 Apr 2019 19:55:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=2YJv0TU4reqr1XesjZUu85dr59wYQQ2sU3iSxRPA0nA=;
        b=S80rgrKKnKgYNCbvkSPiIuDGpRPXZ5PcLNMr8oY8XBSSnzoUNg1wh2K+j+SDx3D6KZ
         y67KJ3vRFSFhU+8rxZmJARzpzjtyYmpOfNMZzwrKFM8kmu5QoK4AF2gvXHa2J93wwbND
         n+XLuFEc2J2TB2zeVCsLAxbLrt8LQsBtlRvByqaEkDdoa8uLwU/SA+mthltHW/KCb6go
         Od8a8pSd2glFkZKmpeErd3GtbSACJEiQ9tgBl0w2NRg3bLHDJ2QVOIYuhh35nAtUtV1j
         KOoVF0U0HQnV76bItRJ4RPzcrDsRoux2U9ue1+vdxGVWpKSTFD8hXNmzdeGzQDYsB2/g
         ALqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=2YJv0TU4reqr1XesjZUu85dr59wYQQ2sU3iSxRPA0nA=;
        b=pwmZsDavsa981/CTY0K9P4W4r9WNKBMHL+s8DzPvHuuLwY4/uJarwnJoDngKqSuoEx
         L9mgfEQ4bMUwPAzVXppuI7mhxDOci8l8SvSqhh73zPGoLqszNz2EF4cXnX79EhncFdQu
         ZqdClQZcuZ7MfSpfmJUqToLqYs1h7QhDhHngywkanmTvjEisr0iUMQvX1WAwt1lciy0j
         KCMhCT3BIVs9baV8hXvpeytWsPReFHhH9LYkOOZgrcZ6hjQVye5PDXmKk3VYEP9ZJCHc
         I/HPyFCJrrNPkcw/lKTjVStz7TwqHkzpu5EuvP53+7Kx8KBtbZEHq2z4mU+YMSjWqwqu
         YqOA==
X-Gm-Message-State: APjAAAUGqhyc/zVoq45gXVxIitEeL1sbv6Qr12xafmqJNNzfkfx3YnO7
        xBGo4Ij72MCs3L5mLlP9rWsJQHrLoA9IJYp1FmCbjA==
X-Google-Smtp-Source: APXvYqzCV5fvCjc8AQ2luhPjV0wd8ML4qhCjaMK9ahShMpCfz9YWDN4+7uPlOM+kDxTJd2fLOu9sX6RlX3SqvdiC70E=
X-Received: by 2002:a63:7444:: with SMTP id e4mr46157276pgn.261.1554173701838;
 Mon, 01 Apr 2019 19:55:01 -0700 (PDT)
MIME-Version: 1.0
References: <eea3ce6a-732b-5c1d-9975-eddaeee21cf5@infradead.org>
 <20190329181839.139301-1-ndesaulniers@google.com> <83226cfb-afa7-0174-896c-d9f7a6193cf4@infradead.org>
 <CANA+-vAcW0VfAZmZWi84s1pQQ+tFx8VyzYsWi5_gj7vHT3Ao6Q@mail.gmail.com>
In-Reply-To: <CANA+-vAcW0VfAZmZWi84s1pQQ+tFx8VyzYsWi5_gj7vHT3Ao6Q@mail.gmail.com>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Tue, 2 Apr 2019 09:54:50 +0700
Message-ID: <CAKwvOd=PstHEm_Vxtx_SGanKhAJSjoQiCb3kgCVeK4peUF2k-g@mail.gmail.com>
Subject: Re: [PATCH v2] gcov: fix when CONFIG_MODULES is not set
To:     Tri Vo <trong@android.com>
Cc:     Randy Dunlap <rdunlap@infradead.org>,
        Peter Oberparleiter <oberpar@linux.ibm.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Greg Hackmann <ghackmann@android.com>,
        Linux Memory Management List <linux-mm@kvack.org>,
        kbuild-all@01.org, kbuild test robot <lkp@intel.com>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Mar 31, 2019 at 6:57 AM Tri Vo <trong@android.com> wrote:
>
> On Fri, Mar 29, 2019 at 1:53 PM Randy Dunlap <rdunlap@infradead.org> wrote:
> >
> > On 3/29/19 11:18 AM, Nick Desaulniers wrote:
> > > Fixes commit 8c3d220cb6b5 ("gcov: clang support")
> >
> > There is a certain format for Fixes: and that's not quite it. :(

Looks like the format is:
Fixes: <first 12 characters of commit sha> ("<first line of commit>")
so:
Fixes: 8c3d220cb6b5 ("gcov: clang support")

We should update:
https://www.kernel.org/doc/html/v5.0/process/stable-kernel-rules.html
to include this information.

> Thanks for taking a look at this Nick! I believe same fix should be
> applied to kernel/gcov/clang.c. I'll send out an updated version later
> today.

All yours, happy to review.

-- 
Thanks,
~Nick Desaulniers

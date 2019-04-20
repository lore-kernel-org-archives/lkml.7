Return-Path: <SRS0=ruH4=SW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C3488C282E1
	for <linux-kernel@archiver.kernel.org>; Sat, 20 Apr 2019 03:08:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 83F8D208C0
	for <linux-kernel@archiver.kernel.org>; Sat, 20 Apr 2019 03:08:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=umn.edu header.i=@umn.edu header.b="QN1SD40H"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727504AbfDTDIr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 19 Apr 2019 23:08:47 -0400
Received: from mta-p4.oit.umn.edu ([134.84.196.204]:55720 "EHLO
        mta-p4.oit.umn.edu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725858AbfDTDIq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Apr 2019 23:08:46 -0400
Received: from localhost (localhost [127.0.0.1])
        by mta-p4.oit.umn.edu (Postfix) with ESMTP id 50E52A47
        for <linux-kernel@vger.kernel.org>; Sat, 20 Apr 2019 03:08:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=umn.edu; h=
        content-type:content-type:subject:subject:message-id:date:date
        :from:from:in-reply-to:references:mime-version:received:received
        :received; s=20160920; t=1555729725; x=1557544126; bh=FyO9SkKc0K
        ZdryFE/meHvxbeKd4PewE0fzY9JSJdgwQ=; b=QN1SD40H4M/u/6nMJvuXGfj9qo
        DV1U9BCVnHzqie7jsU2RalJAhgyn/U7yTxW+yuTpk3kXzqr7OP/eyVOxOeCJUABn
        8aqULXiU21nK5FJu61ZtFH6Un6xbKwnX0W4Yl1/C1me9VAsVO7unCzZNSRMa0Oss
        K/ARd+F0VdLyw1RLc+zJWlE9fahyj6vod9PrGEdjcrHgKiwxRpopAf99Yfa8HrTm
        G57ANxALMRtwvXkL073LL3Y/GtLuY0/JyToFlZ6ZlZfvb7LjqRA9oXlPHeVglXLZ
        hcxxtHo+HkLkVPFQCcOujSYTuyTvKlMHjpTa3LUBjJV+gQf9xjrZku7BOiPg==
X-Virus-Scanned: amavisd-new at umn.edu
Received: from mta-p4.oit.umn.edu ([127.0.0.1])
        by localhost (mta-p4.oit.umn.edu [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id 9PIibCpnM61z for <linux-kernel@vger.kernel.org>;
        Fri, 19 Apr 2019 22:08:45 -0500 (CDT)
Received: from mail-it1-f179.google.com (mail-it1-f179.google.com [209.85.166.179])
        (using TLSv1 with cipher AES128-SHA (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: wang6495)
        by mta-p4.oit.umn.edu (Postfix) with ESMTPSA id 2873FA31
        for <linux-kernel@vger.kernel.org>; Fri, 19 Apr 2019 22:08:45 -0500 (CDT)
Received: by mail-it1-f179.google.com with SMTP id a190so10884168ite.4
        for <linux-kernel@vger.kernel.org>; Fri, 19 Apr 2019 20:08:45 -0700 (PDT)
X-Gm-Message-State: APjAAAXRalVBRtY9LuCw7OPzkXtp/YI6xuR55eVuT0isSp2LTzmIXZvN
        Bx8uv3eqELxEUmYGtoCIM+uAj1sdsrzmYEzUYxs=
X-Google-Smtp-Source: APXvYqzBs5pKRkV+jxdqIb8m2raSH38BDl7bnUYwwhwf5lpDdVeBFA1x5OI01OfPOx+xtrGOKZCY/x49nAlCAPr3+ug=
X-Received: by 2002:a02:1006:: with SMTP id 6mr5267131jay.47.1555729724961;
 Fri, 19 Apr 2019 20:08:44 -0700 (PDT)
MIME-Version: 1.0
References: <1555726979-15633-1-git-send-email-wang6495@umn.edu> <20190419223718.17fa8246@oasis.local.home>
In-Reply-To: <20190419223718.17fa8246@oasis.local.home>
From:   Wenwen Wang <wang6495@umn.edu>
Date:   Fri, 19 Apr 2019 22:08:08 -0500
X-Gmail-Original-Message-ID: <CAAa=b7dnrz5Pz5hMUc29VHJb9ucFkWArd2sbsCUO+POfuFXFhA@mail.gmail.com>
Message-ID: <CAAa=b7dnrz5Pz5hMUc29VHJb9ucFkWArd2sbsCUO+POfuFXFhA@mail.gmail.com>
Subject: Re: [PATCH] tracing: Fix a memory leak bug
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     Ingo Molnar <mingo@redhat.com>,
        open list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 19, 2019 at 9:37 PM Steven Rostedt <rostedt@goodmis.org> wrote:
>
> On Fri, 19 Apr 2019 21:22:59 -0500
> Wenwen Wang <wang6495@umn.edu> wrote:
>
> > In trace_pid_write(), the buffer for trace parser is allocated through
> > kmalloc() in trace_parser_get_init(). Later on, after the buffer is used,
> > it is then freed through kfree() in trace_parser_put(). However, it is
> > possible that trace_pid_write() is terminated due to unexpected errors,
> > e.g., ENOMEM. In that case, the allocated buffer will not be freed, which
> > is a memory leak bug.
> >
> > To fix this issue, free the allocated buffer when an error is encountered.
>
> Thanks for the patch. Did you find this through manual inspection,
> running KASAN or via one of the static analyzers?

Thanks for your question, Steve. It was based on a prototype of a
research project, which aims to statically detect memory leak bugs in
operating system kernels.

Wenwen

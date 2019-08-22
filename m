Return-Path: <SRS0=/WLL=WS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9AD52C3A5A1
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Aug 2019 20:10:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6E26421848
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Aug 2019 20:10:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="k+P8YtlA"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392795AbfHVUKv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 22 Aug 2019 16:10:51 -0400
Received: from mail-ua1-f66.google.com ([209.85.222.66]:45461 "EHLO
        mail-ua1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388453AbfHVUKv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Aug 2019 16:10:51 -0400
Received: by mail-ua1-f66.google.com with SMTP id w7so2439291uao.12
        for <linux-kernel@vger.kernel.org>; Thu, 22 Aug 2019 13:10:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=RZqoQbOf4zkZDFdaVNZEkUCJ//n9bEGb3Yhu+Zzx41M=;
        b=k+P8YtlA1ApmcGbTff68psOOylvM4LkDknvXY1D32vTQEiLrTd4AaL/LIbZl4ctGXk
         Ahm+qeTbLaDuoS0unujJos/Yqr1TufWPSWlXeNQIf0QSJFg2o25uLVT6C1Kh1UbaM8Q7
         E9AsnbcSFMmzdOEXAy6aiuP8DYXaekq1VXxtEfkTO1FktJbkV+LLlIa8IjOKfLtW+3e4
         jgqFdsiaEqrFP9u9SHtcn82AlxUStaWekeG0VZy7Usw/1ot+gnkvGgvc06nDbdbuH1RE
         Vloyw1QETGYZhh4P+fSXRZBpR7GLQ96n0MBJ3bD9/iOCi9ZyJl3y1RmYbqe8k28TItEW
         ML0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=RZqoQbOf4zkZDFdaVNZEkUCJ//n9bEGb3Yhu+Zzx41M=;
        b=eZd8fpbnwX1hAJTR0Sh1Jh8CePeU56ThtXQKpuPq2Zdfu1036fq25GnC0qGdgE1GD2
         T7nVntWHUELc4bgr1u1nhofN1V+YnsiS0YFyb5vUYgL44wDqPBrMgnnyURwzRqJ/rmrx
         9FbKVB+5iQjVpmADJ/QCTEU+vAwbUjdy4onfhVurTKqfsTeAxv4Q/WgTcbkKjf/5meYN
         1r8E/TC+PcILwo7epWqOELB94jbx+rqc1veqH6SXSn449J/Wp4jAEhsqMRRLigAdIxMW
         YNYdy+wnU0GILEs/WgdainEJxgw0QLEw3RyWSUmV3Axt3dZ5maaDahponpsRJMooBDLe
         VCVg==
X-Gm-Message-State: APjAAAUJdTzZ/80E96ucOYp3kI2ScebrdsxnS9LUmLaRtHmHCXYe99uD
        lZjlLb/MMS3duZnml3zStRODw94Lhi4wKyG3MfEmFw==
X-Google-Smtp-Source: APXvYqwya/ob48MMQIGdcpxmml0g0+UtfduMU/15T9p5Qxphj5ivhED24u7UDhOCXVTyMRX4eh94GsBQw9z/VezuXuc=
X-Received: by 2002:ab0:45e7:: with SMTP id u94mr923927uau.47.1566504649512;
 Thu, 22 Aug 2019 13:10:49 -0700 (PDT)
MIME-Version: 1.0
References: <20190813224620.31005-1-dave@stgolabs.net> <20190813224620.31005-2-dave@stgolabs.net>
 <20190821215707.GA99147@google.com> <20190822044936.qusm5zgjdf6n5fds@linux-r8p5>
 <20190822181701.zhfdkjbwjh56i3ax@linux-r8p5>
In-Reply-To: <20190822181701.zhfdkjbwjh56i3ax@linux-r8p5>
From:   Michel Lespinasse <walken@google.com>
Date:   Thu, 22 Aug 2019 13:10:37 -0700
Message-ID: <CANN689E+xsZWOKFBuv1pkpXO-i4i=Yhg3ebnD++ujz7yfDqwuQ@mail.gmail.com>
Subject: Re: [PATCH 1/3] x86,mm/pat: Use generic interval trees
To:     Davidlohr Bueso <dave@stgolabs.net>
Cc:     Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Andrew Morton <akpm@linux-foundation.org>, x86@kernel.org,
        LKML <linux-kernel@vger.kernel.org>,
        Davidlohr Bueso <dbueso@suse.de>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

I think vma_interval_tree is a bit of a mixed bag, but mostly leans
towards using half closed intervals.

Right now vma_last_pgoff() has to do -1 because of the interval tree
using closed intervals. Similarly, rmap_walk_file(), which I consider
to be the main user of the vma_interval_tree, also has to do -1 when
computing pgoff_end because of the interval tree closed intervals. So,
I think overall vma_interval_tree would also more naturally use
half-open intervals.

But, that's not a 100% thing for vma_interval_tree, as it also has
uses that do stabbing queries (in arch specific code, in hugetlb
cases, and in dax code).

On Thu, Aug 22, 2019 at 11:17 AM Davidlohr Bueso <dave@stgolabs.net> wrote:
>
> >On Wed, 21 Aug 2019, Michel Lespinasse wrote:
> >>As I had commented some time ago, I wish the interval trees used [start,end)
> >>intervals instead of [start,last] - it would be a better fit for basically
> >>all of the current interval tree users.
>
> So the vma_interval_tree (which is a pretty important user) tends to break this
> pattern, as most lookups are [a,a]. We would have to update most of the
> vma_interval_tree_foreach calls, for example, to now do [a,a+1[ such that we
> don't break things. Some cases for the anon_vma_tree as well (ie memory-failure).
>
> I'm not sure anymore it's worth going down this path as we end up exchanging one
> hack for another (and the vma_interval_tree is a pretty big user); but I'm sure
> you're aware of this and thus disagree.
>
> Thanks,
> Davidlohr



-- 
Michel "Walken" Lespinasse
A program is never fully debugged until the last user dies.

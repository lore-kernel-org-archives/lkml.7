Return-Path: <SRS0=DLm5=TA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A7D7FC04AA8
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Apr 2019 03:32:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7703F20835
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Apr 2019 03:32:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="DDDpEVSR"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730034AbfD3Dcz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Apr 2019 23:32:55 -0400
Received: from mail-yw1-f68.google.com ([209.85.161.68]:42777 "EHLO
        mail-yw1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729986AbfD3Dcy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Apr 2019 23:32:54 -0400
Received: by mail-yw1-f68.google.com with SMTP id y131so4883667ywa.9
        for <linux-kernel@vger.kernel.org>; Mon, 29 Apr 2019 20:32:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=dWEKtGsRIMq4v+NhZemcUNWB8/vTGODLsuHGIZCvLns=;
        b=DDDpEVSRE8oPO+cOinkkQ7lINMkV8y8Sp8Tp7Uttz0QF6r5bQ6+/3ePMNmPLDpz7rI
         KPala0XBYAmQ3SePPZ40hYTg86geNQPy2Grc0K4z4RE6whwqluCHezd1NGgB6rfucnUg
         hV0HXKuk9r2hCL9OuhfjFrDv44ufG3YiG18/uldGmxv/21HyO0kCQVr3yLGsWLB7fOC3
         SkopmmTFkLYAnVdS9QIFL6GJf2lX9LAxqwQPzB+5TwzDX+vkYdax3NVP1fpz6XxoBOlo
         7+1lZvseE7ID/p1TWU21NN5jMaEzewo6ONCu/nBDNYNpYsDUS9LKTnK702xr83iKOnNl
         XqIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=dWEKtGsRIMq4v+NhZemcUNWB8/vTGODLsuHGIZCvLns=;
        b=WPLX3hKaeHnU5t0u4ahiDldHctLSOGFvs5KFSDBgPHTHwKUj/q2w8cJlhLJr5SPCh9
         tcFkarDNqxlc8MRh/jzVK1JUMYO0L0VokKBPh5l+08qoCRdUsgNp6G0pElVfWtDFRoA4
         xVEAA5Y0TMENeD34tu9e4dMGa+UZAMhjZsqsslF6PLUBDz8Lt6FS7aY5VrOHuIbYn4uP
         kPbeunnSHilehQTuJO1OSWB6NccpI6A0RphNi/bmZn7YyXY7o36K7+40zMGCGEVRthUr
         hzAdUzRG8J6G2vRbTcGjMkIxItOdXNVA5GZtogn9YzMnFqdjTp/xM30CHZKHa2E15ZRY
         efdA==
X-Gm-Message-State: APjAAAU45hsO5AijB6x+ZU9/1eV9O0liyfHNXQZEbp/tX63N+4OT69lq
        w5wSVICefYb5E4R/njHblCmaAPoUDpdKN3bcEnYLjA==
X-Google-Smtp-Source: APXvYqxiTSC6H3uYqE0DoAstpjwFGHHohchbO4x8XQqIAb6J5UkRzE8VEEfSYh/QD37Z8jEdNZRckmYBonsmWkkAg2k=
X-Received: by 2002:a25:f507:: with SMTP id a7mr52256523ybe.164.1556595173714;
 Mon, 29 Apr 2019 20:32:53 -0700 (PDT)
MIME-Version: 1.0
References: <20190429171332.152992-1-shakeelb@google.com> <20190429171332.152992-2-shakeelb@google.com>
 <20190429214123.GA3715@dhcp22.suse.cz>
In-Reply-To: <20190429214123.GA3715@dhcp22.suse.cz>
From:   Shakeel Butt <shakeelb@google.com>
Date:   Mon, 29 Apr 2019 23:32:42 -0400
Message-ID: <CALvZod5uXOQfeq9_03T5dv104tWwuukL0+vEAVhk-v1_A=skQQ@mail.gmail.com>
Subject: Re: [PATCH 2/2] memcg, fsnotify: no oom-kill for remote memcg charging
To:     Michal Hocko <mhocko@kernel.org>
Cc:     Johannes Weiner <hannes@cmpxchg.org>,
        Vladimir Davydov <vdavydov.dev@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Roman Gushchin <guro@fb.com>, Jan Kara <jack@suse.cz>,
        Amir Goldstein <amir73il@gmail.com>,
        Linux MM <linux-mm@kvack.org>,
        Cgroups <cgroups@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 29, 2019 at 5:41 PM Michal Hocko <mhocko@kernel.org> wrote:
>
> On Mon 29-04-19 10:13:32, Shakeel Butt wrote:
> [...]
> >       /*
> >        * For queues with unlimited length lost events are not expected and
> >        * can possibly have security implications. Avoid losing events when
> >        * memory is short.
> > +      *
> > +      * Note: __GFP_NOFAIL takes precedence over __GFP_RETRY_MAYFAIL.
> >        */
>
> No, I there is no rule like that. Combining the two is undefined
> currently and I do not think we want to legitimize it. What does it even
> mean?
>

Actually the code is doing that but I agree this is not documented and
weird. I will fix this.

Shakeel

Return-Path: <SRS0=AMXA=TQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B01D0C04AAF
	for <linux-kernel@archiver.kernel.org>; Thu, 16 May 2019 16:10:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8A059206BF
	for <linux-kernel@archiver.kernel.org>; Thu, 16 May 2019 16:10:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726950AbfEPQKc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 May 2019 12:10:32 -0400
Received: from mail-lj1-f193.google.com ([209.85.208.193]:38663 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726715AbfEPQKb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 May 2019 12:10:31 -0400
Received: by mail-lj1-f193.google.com with SMTP id 14so3630927ljj.5
        for <linux-kernel@vger.kernel.org>; Thu, 16 May 2019 09:10:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=OJVoHOdwqPmtIGZYRe7rwFLvOITb6Eou9scimDVik8g=;
        b=dV4/6MupAgfjY2tWrMxFL/fmiWgWYkadfaMKTM3RVBQXGr9FOfkmELt/aaa+suJoRc
         tzmmPmdlZybhjy8YkQeT1ciELvzwOkvXnEEMe0bU8fWjX6y8KEv/Jk3AC4QMXrVb421b
         /lRWv9ZbSMLerfo34/+czyP17+DA21C0BgDLMnMq5NzA4uTnw1DfJVHtxitsvBieWKAq
         MlBPFyaMCca0K7cBFDsCnX4Z/0KWoFqHTbr+BOMgGQbbaIr5OMid+3+v4YbpogM/Uz5E
         ZCtul84McQ86Ynk435XpfETMmqNesdeuz6qnDOWJKjqJEEVy+N7x/vMpJYdFWTIh+7bY
         BJAQ==
X-Gm-Message-State: APjAAAX69enwJ6DKHz5pvXj2YgLK/QB3hhmd9F2KlgRWKfnLcRS6adVM
        ES1cNWdc1HoIM0h1T4wgcsMwHQYeERtXq0zkiqDPTA==
X-Google-Smtp-Source: APXvYqytsMIKpyzg6Sr7Ma0RrX3P9yIKHhEzTRRSX0gI9JlTBX9wZXbT94dI4qFs37peKTqIzS8XBfKzh47Ff2ccEeY=
X-Received: by 2002:a2e:2b81:: with SMTP id r1mr22861818ljr.138.1558023029982;
 Thu, 16 May 2019 09:10:29 -0700 (PDT)
MIME-Version: 1.0
References: <20190430180111.10688-1-mcroce@redhat.com> <CAGXu5jJG1D6YvTaSY3hpB8_APmwe=rGn8FkyAfCGuQZ3O2j1Yg@mail.gmail.com>
In-Reply-To: <CAGXu5jJG1D6YvTaSY3hpB8_APmwe=rGn8FkyAfCGuQZ3O2j1Yg@mail.gmail.com>
From:   Matteo Croce <mcroce@redhat.com>
Date:   Thu, 16 May 2019 18:09:53 +0200
Message-ID: <CAGnkfhyjmpPAjQFpm-w3v0kMWTKRHTq5v6w0m9KScN2a7bMgeg@mail.gmail.com>
Subject: Re: [PATCH v5] proc/sysctl: add shared variables for range check
To:     Kees Cook <keescook@chromium.org>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        Matthew Wilcox <willy@infradead.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 30, 2019 at 8:14 PM Kees Cook <keescook@chromium.org> wrote:
>
> On Tue, Apr 30, 2019 at 11:01 AM Matteo Croce <mcroce@redhat.com> wrote:
> >
> > In the sysctl code the proc_dointvec_minmax() function is often used to
> > validate the user supplied value between an allowed range. This function
> > uses the extra1 and extra2 members from struct ctl_table as minimum and
> > maximum allowed value.
> >
[...]
> >
> > Signed-off-by: Matteo Croce <mcroce@redhat.com>
>
> Acked-by: Kees Cook <keescook@chromium.org>
>
> --
> Kees Cook

Hi all,

just a ping about this patch. Any tought, suggestion, concern or criticism?

Regards,
-- 
Matteo Croce
per aspera ad upstream

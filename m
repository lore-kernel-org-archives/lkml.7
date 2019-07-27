Return-Path: <SRS0=tJqY=VY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 69D78C433FF
	for <linux-kernel@archiver.kernel.org>; Sat, 27 Jul 2019 17:25:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 47183208E4
	for <linux-kernel@archiver.kernel.org>; Sat, 27 Jul 2019 17:25:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="t5kSA4pk"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387870AbfG0RZQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 27 Jul 2019 13:25:16 -0400
Received: from mail-ot1-f67.google.com ([209.85.210.67]:42939 "EHLO
        mail-ot1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387665AbfG0RZP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 27 Jul 2019 13:25:15 -0400
Received: by mail-ot1-f67.google.com with SMTP id l15so58486421otn.9
        for <linux-kernel@vger.kernel.org>; Sat, 27 Jul 2019 10:25:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=GnqU0JRhrXBsiEdVfrpxRYhB+jhyBUboMzh3dp1tPvc=;
        b=t5kSA4pkhco77TShAAaMPIl1DAEIo8hLSMUCCmpXXj9Z8l3AEbxPPtTPHlV27fOVCe
         +QJQV64yQyneiJ4QqJPMJz3diUQwGaL4/cpogzyHUCg0Sw1VfPAdf7kqhvMlLEZveam+
         7DsthIZxv3KZwo3AhW5msgxhNpyk+tXDIzqCHi2JE2v400wzBomRYOUxc+EhGPpTrFLM
         hPMyRRpACoOCg/4w0nvsFNxcp9eX0nTVgXYoCqc0bj25txMqcBi0X59HZZ4tV5F26AZY
         1NDtFdARA+3mlYVIDc5P1pBt/GoLferKZo6H5ZRD+8DssJMi5hiMQP7iV4cWC6Z0GW7e
         2JAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=GnqU0JRhrXBsiEdVfrpxRYhB+jhyBUboMzh3dp1tPvc=;
        b=WbtlVzRalnjgkoWQO06d4qwyS9oEidaD+BccU+XjrSY9Tisd6xGKmmo+CYNEUxA47w
         cy0evQ5gv/tEknsFqLQCLmYLofkzy2CYEs8kaFEs7IzW6CoD3USh1OkSdqKbpsaVLx6b
         lXGOjWmfQ5uPTf3Rw71SkyKh0FYgzf4nVyL7cV7WHZKvBBSHY+AWyGfL3t9LAaC40Daw
         j9anRsKnnW/0ZOKArN4qCt9pJqRdZa9QQVHwj5q3hpJwT4y+7rbDAF3nbWjkNB4Atqs7
         4k95g4pxmiR6KZQKJk0cuBOnSGQuVLoWpHf8EK7zLZ77IDRlwI4fpP51yzt8GABTjuIl
         eIZA==
X-Gm-Message-State: APjAAAWc6pIsXh7ud9V7LojM9z4LvUPg3IpSRMApomXl0AWoFVb3ri+U
        sgmQfNZ3gvg/Umn1ibdHQO1gqpf8oyjqJi8oNbg=
X-Google-Smtp-Source: APXvYqzgh59g+ACIfiw2qGNQLkF6F1GlClI1XRgmH1D5Yjm7nb8sSCqgU3QzmV3GAkGYA4zf8O3vnAkHF2nB2QLUeKs=
X-Received: by 2002:a9d:460d:: with SMTP id y13mr53509367ote.368.1564248314917;
 Sat, 27 Jul 2019 10:25:14 -0700 (PDT)
MIME-Version: 1.0
References: <20190725184253.21160-1-lpf.vector@gmail.com> <1564080768.11067.22.camel@lca.pw>
 <CAD7_sbEXQt0oHuD01BXdW2_=G4h8U8ogHVt0N1Yez2ajFJkShw@mail.gmail.com> <20190726071219.GC6142@dhcp22.suse.cz>
In-Reply-To: <20190726071219.GC6142@dhcp22.suse.cz>
From:   Pengfei Li <lpf.vector@gmail.com>
Date:   Sun, 28 Jul 2019 01:25:02 +0800
Message-ID: <CAD7_sbF7JMbxBF1ZRQKxW-U9S-tEOhneumjGXT3YADEfYCGKYw@mail.gmail.com>
Subject: Re: [PATCH 00/10] make "order" unsigned int
To:     Michal Hocko <mhocko@kernel.org>
Cc:     Qian Cai <cai@lca.pw>, Andrew Morton <akpm@linux-foundation.org>,
        Mel Gorman <mgorman@techsingularity.net>, vbabka@suse.cz,
        aryabinin@virtuozzo.com, osalvador@suse.de, rostedt@goodmis.org,
        mingo@redhat.com, pavel.tatashin@microsoft.com, rppt@linux.ibm.com,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 26, 2019 at 3:12 PM Michal Hocko <mhocko@kernel.org> wrote:
>

Thank you for your comments.

> On Fri 26-07-19 07:48:36, Pengfei Li wrote:
> [...]
> > For the benefit, "order" may be negative, which is confusing and weird.
>
> order = -1 has a special meaning.
>

Yes. But I mean -1 can be replaced by any number greater than
MAX_ORDER - 1 and there is no reason to be negative.

> > There is no good reason not to do this since it can be avoided.
>
> "This is good because we can do it" doesn't really sound like a
> convincing argument to me. I would understand if this reduced a
> generated code, made an overall code readability much better or
> something along those lines. Also we only use MAX_ORDER range of values
> so I could argue that a smaller data type (e.g. short) should be
> sufficient for this data type.
>

I resend an email to interpret the meaning of my commit, and I would be
very grateful if you post some comments on this.

> Please note that _any_ change, alebit seemingly small, can introduce a
> subtle bug. Also each patch requires a man power to review so you have
> to understand that "just because we can" is not a strong motivation for
> people to spend their time on such a patch.

Sincerely thank you, I will keep these in mind.

> --
> Michal Hocko
> SUSE Labs

--
Pengfei

Return-Path: <SRS0=GkzU=Y7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=0.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,FROM_LOCAL_NOVOWEL,
	HEADER_FROM_DIFFERENT_DOMAINS,HK_RANDOM_FROM,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B55E3FA372C
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Nov 2019 00:22:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 822A7206DF
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Nov 2019 00:22:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EDoDOczY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728025AbfKGAWE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 Nov 2019 19:22:04 -0500
Received: from mail-yw1-f68.google.com ([209.85.161.68]:34430 "EHLO
        mail-yw1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727228AbfKGAWE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Nov 2019 19:22:04 -0500
Received: by mail-yw1-f68.google.com with SMTP id y18so25170ywk.1
        for <linux-kernel@vger.kernel.org>; Wed, 06 Nov 2019 16:22:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=IoBKiF8gKZ9/YDxTbalV/OjHsBLCzrm1vO49Me9eDAI=;
        b=EDoDOczYRYd4+XNT+wFjozTXCFmMi8WfCp99vh5Y6lxe35MMRziQr69H7Ln1xuu4Hj
         N+esKa18r9/P8Zexe9oAdTuMWOtWl2t/Pu31Tpgv+iSSwjIJm0LcpkwuzZ3fPpD2Axvs
         Jy7mhaVl5EDe7AuktWs1agsAQlW0LVm2+g/CkIiF9KZT9S+5OkNgbrnqkhd9cREnafKt
         vZfNdZosd7c7o4ZAaehQnl8UIrrLEL3wHpAIdsggYgzM8stayD20TUSSUV85YvXa7Sn0
         1PJ3EpWioqkNTqfmCNUiRis3fhGlPwsjXk/BtUDRGXNVY8A1CElFPqgams6RyVT9XlKY
         ClmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=IoBKiF8gKZ9/YDxTbalV/OjHsBLCzrm1vO49Me9eDAI=;
        b=DFZn4AGktgrvg8ACdZr+HQXyi6Z5bd2l1rTMrLDX0YS7tOVVyXAdvZA9P5vCV8avZV
         dvLvNZ6QjLbWAEe6VsW7lFzagcPR4xpxsf+C3QfNly9+vwA7+11Q+wQpzyIWD1Fn2GlK
         lIV+NchLHsmecC2+CTzhPhz1MKPwUvGnNz/mlMq9YAcnNWoy7AFmUD/KtdHDsdYqWI3K
         luaYwzhJ4k3eJqyqcYJveUqJ2LGnnPWMikMR+jpNF1oX+Gvs7HRyA7payx/IigPIqDwk
         JkqheOnEzM61u3sGRmVAdAHH8moa5y2aOUlKtk2dO743vlwBZI25l+slSqKRsnzhJ5R1
         C68Q==
X-Gm-Message-State: APjAAAVKY9c2l3xd6rIJyN1Ag4IfcLbu6HYUto/W/Fvp8RxBC9HBDgex
        Q1wlnh704UEP78sAlX3ucEuVEdOgKVQs2uM5Z/U=
X-Google-Smtp-Source: APXvYqyvX1NrX3ydfgyd4RGYuuWRxDsJYwAtqNxFwCWks7zkHFlIpNFvBvqii1uenGKfhv+H3DdrBFoQsL4aYFTWlT8=
X-Received: by 2002:a81:8415:: with SMTP id u21mr268081ywf.129.1573086122063;
 Wed, 06 Nov 2019 16:22:02 -0800 (PST)
MIME-Version: 1.0
References: <20191106181617.1832-1-jcmvbkbc@gmail.com> <a9e2f6b65d4c098ab027ea849120d3cf61858e67.camel@perches.com>
In-Reply-To: <a9e2f6b65d4c098ab027ea849120d3cf61858e67.camel@perches.com>
From:   Max Filippov <jcmvbkbc@gmail.com>
Date:   Wed, 6 Nov 2019 16:21:51 -0800
Message-ID: <CAMo8BfLmcCOAinyjB3iEuOF36TYBig=724=s9b6EKr3LzwF5QQ@mail.gmail.com>
Subject: Re: [PATCH] xtensa: improve stack dumping
To:     Joe Perches <joe@perches.com>
Cc:     "open list:TENSILICA XTENSA PORT (xtensa)" 
        <linux-xtensa@linux-xtensa.org>, Chris Zankel <chris@zankel.net>,
        LKML <linux-kernel@vger.kernel.org>,
        Dmitry Safonov <dima@arista.com>,
        Petr Mladek <pmladek@suse.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 6, 2019 at 2:34 PM Joe Perches <joe@perches.com> wrote:
> > @@ -512,10 +510,12 @@ void show_stack(struct task_struct *task, unsigned long *sp)
> >       for (i = 0; i < kstack_depth_to_print; i++) {
> >               if (kstack_end(sp))
> >                       break;
> > -             pr_cont(" %08lx", *sp++);
> > +             sprintf(buf + (i % 8) * 9, " %08lx", *sp++);
> >               if (i % 8 == 7)
> > -                     pr_cont("\n");
> > +                     pr_info("%s\n", buf);
> >       }
> > +     if (i % 8)
> > +             pr_info("%s\n", buf);
>
> Could this be done using hex_dump_to_buffer
> by precalculating kstack_end ?

I've got this, but it doesn't look very attractive to me:

void show_stack(struct task_struct *task, unsigned long *sp)
{
        unsigned long *stack;
        int len;

        if (!sp)
                sp = stack_pointer(task);
        stack = sp;

        len = min((-(unsigned long)stack) & (THREAD_SIZE - 4),
                  kstack_depth_to_print * 4ul);

        pr_info("Stack:\n");

        for (; len > 0; len -= 32) {
                char buf[9 * 8 + 1];

                hex_dump_to_buffer(sp, min(len, 32), 32, 4,
                                   buf, sizeof(buf), false);
                pr_info(" %08lx:  %s\n", (unsigned long)sp, buf);
                sp += 8;
        }
        show_trace(task, stack);
}

-- 
Thanks.
-- Max

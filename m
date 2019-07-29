Return-Path: <SRS0=K9bG=V2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5E162C76186
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jul 2019 19:18:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2C1E42073F
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jul 2019 19:18:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JRwGlQTb"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729343AbfG2TSK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Jul 2019 15:18:10 -0400
Received: from mail-io1-f68.google.com ([209.85.166.68]:36330 "EHLO
        mail-io1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729315AbfG2TSK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Jul 2019 15:18:10 -0400
Received: by mail-io1-f68.google.com with SMTP id o9so18949813iom.3
        for <linux-kernel@vger.kernel.org>; Mon, 29 Jul 2019 12:18:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=fkNhqmWyxRYv5Kdfb5HpWhEVzT1gnAMwAelRd/BmI88=;
        b=JRwGlQTbHXYqHAf8W32La/6QQeE5VTgq2DtbFa/+2ygIuaZI7jENRSdi5GU9I11yqm
         C7CybBUDK4Rb5/31p8FYbL9luLdLCLLJ/+80tCnvSxVHp5a9rhlT/sfaHb4pyNqCUk9g
         MfHaxe22qMlof1s8ExD5ILbRslPUcPi6NJJXX3yZlZ6/FlIXMENgk+QoohcfAY2infu4
         8SY5z0MTBqbpI5B65gd3f/kBXBe2WV3Zlpu9RGYcsGiBOrWFboCMS+DH9cvDlP448X/j
         rL8BZg3qtalU8KG8IkFRer/qIlBPdTcYgkaxvXqhOzaXrNO/r4Bx6enkWweTtxaXoja5
         1G4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=fkNhqmWyxRYv5Kdfb5HpWhEVzT1gnAMwAelRd/BmI88=;
        b=hcBHo0RcUuoLTds7L24B0kOGbkptNvROgdJYlABqCIDmji2GT0lMgkw9CukAI6sX6b
         9oqVeVlyry6FpYHTHKfwAFQmDkeXwVDnizADFWwk9ndDUFKSVCn68C0kNCRG0oHxBAnZ
         PPlHpP/YsSfuhPdKxxgsFsNe6NQM9Q2CLDoJtU2HNEt5IqjZLnq1F7bjjwn5BhRygigW
         zYGQCmNkKVq7NZQmW9m/i3odDz7rDFLJw4zpYb6WtgJ70//+INXUPhdJ+08vsKnlVoDZ
         heyVJ/NQYVdaU83IbXplpyc6uI83YCwZpLW2YDuBHKOL6plfMnDz1zif74riD8DYRNOl
         LMyQ==
X-Gm-Message-State: APjAAAWcga2umPbBqaqb9Xj7bh+fHC2Jt3oN1uCSiqMUC5m2RzHIFjjn
        PJJmWCcN5w0lWt8Fp+cQMQ5c9uEV2zv16Hwycq0=
X-Google-Smtp-Source: APXvYqw8HF/0j9zalspb+6UnLzunuTJNOIWoe/Ex7/Lsq0Lh+rYXBuLRdD0RRoKNSDg6amjVgEYC8TKYU7Q8x/jHbUY=
X-Received: by 2002:a5e:de0d:: with SMTP id e13mr3557196iok.144.1564427889720;
 Mon, 29 Jul 2019 12:18:09 -0700 (PDT)
MIME-Version: 1.0
References: <20190729163355.4530-1-areber@redhat.com> <CAJwJo6Z5qHThG5wECSn+jiS0iM3smuXA1OS96Gho1HL-gD=RKQ@mail.gmail.com>
In-Reply-To: <CAJwJo6Z5qHThG5wECSn+jiS0iM3smuXA1OS96Gho1HL-gD=RKQ@mail.gmail.com>
From:   Dmitry Safonov <0x7f454c46@gmail.com>
Date:   Mon, 29 Jul 2019 20:17:58 +0100
Message-ID: <CAJwJo6baR_w_sE8Qtr4Le9KTLWx0Qzi99qmoTm+6hd1j1UkmFA@mail.gmail.com>
Subject: Re: [PATCH 1/2] fork: extend clone3() to support CLONE_SET_TID
To:     Adrian Reber <areber@redhat.com>
Cc:     Christian Brauner <christian@brauner.io>,
        Eric Biederman <ebiederm@xmission.com>,
        Pavel Emelianov <xemul@virtuozzo.com>,
        Jann Horn <jannh@google.com>,
        open list <linux-kernel@vger.kernel.org>,
        Oleg Nesterov <oleg@redhat.com>,
        Andrei Vagin <avagin@gmail.com>,
        Mike Rapoport <rppt@linux.ibm.com>,
        Radostin Stoyanov <rstoyanov1@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 29 Jul 2019 at 20:12, Dmitry Safonov <0x7f454c46@gmail.com> wrote:
>
> On Mon, 29 Jul 2019 at 17:52, Adrian Reber <areber@redhat.com> wrote:
> [..]
> > --- a/include/uapi/linux/sched.h
> > +++ b/include/uapi/linux/sched.h
> > @@ -32,6 +32,7 @@
> >  #define CLONE_NEWPID           0x20000000      /* New pid namespace */
> >  #define CLONE_NEWNET           0x40000000      /* New network namespace */
> >  #define CLONE_IO               0x80000000      /* Clone io context */
> > +#define CLONE_SET_TID          0x100000000ULL  /* set if the desired TID is set in set_tid */
> >
> >  /*
> >   * Arguments for the clone3 syscall
> > @@ -45,6 +46,7 @@ struct clone_args {
> >         __aligned_u64 stack;
> >         __aligned_u64 stack_size;
> >         __aligned_u64 tls;
> > +       __aligned_u64 set_tid;
> >  };
> >
>
> I don't see a change to
> :    if (unlikely(size < sizeof(struct clone_args)))
> :        return -EINVAL;
>
> That seems backwards-incompatible, but I may miss some part..

On the other hand, clone3() was merged in v5.3 window, so probably,
it doesn't matter.

-- 
             Dmitry

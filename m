Return-Path: <SRS0=K9bG=V2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B91FBC76186
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jul 2019 20:10:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5F929205F4
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jul 2019 20:10:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=brauner.io header.i=@brauner.io header.b="JPljb8ZT"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388061AbfG2Td6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Jul 2019 15:33:58 -0400
Received: from mail-io1-f65.google.com ([209.85.166.65]:36358 "EHLO
        mail-io1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387892AbfG2Tdx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Jul 2019 15:33:53 -0400
Received: by mail-io1-f65.google.com with SMTP id o9so19054806iom.3
        for <linux-kernel@vger.kernel.org>; Mon, 29 Jul 2019 12:33:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=brauner.io; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=LLxn7C9aC5wuodbKHEOV6mkYITys5cF1PQfnyuR0FjI=;
        b=JPljb8ZTyaVb8h4Bz4OJBKZhLNaT6av3N0ZgV0E/ky43qADdbSBt98vbCOUKbI11pC
         HEizJCNey/IubUXtKezPS1EbSH6NSZEr9kV+Zb8Xpyocg45dThxNyvtslPdnYTjx5v4k
         zldwju6QUAX2SYTda4ERbi5mbE5KsBp11LgqP8NXIFFMpPVgsWFZlcYsa8jHahiQGifh
         TWwX/HdoXNkdTW1xXfarPSShdWEsf7w5nMmwno4aMZVtLU2AnGWpj8j7YmvMvqefG9mi
         bptkFuW6yivA6aevgFjxNhKICMDih547P/5zPm3pRtrJZ1nr49vWlKHQ2c0tbeZpUNMg
         BmYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=LLxn7C9aC5wuodbKHEOV6mkYITys5cF1PQfnyuR0FjI=;
        b=Vc/Pya5kpx16bkQa2MK6seryodGYQCAvhKD6ywVOpgpqWyecsj8fRrPirxpF5Cwghn
         f3/sFSi4zaeewDukrsbgKatmQ4NBwQ8p1uB3FcQMXNv5XFSbB2y+rRLEwqqHDERwL9V6
         cuiqomEQm1JpUSXKMP3nLOaPMc4dYhPf4oo0CuGBdw/4RiPHI8U23YeDsKpu1EvCdAOU
         hcIhv6a1S/283dQbYQVb5TqqN6M6VgJPW3pWL2Vx23NyZq+/m6D30oFxh7ZWWyT1GSsW
         hGe6Z4B8kD1YXSokyRIMmMEYITPGFCCJJX+VvUkiErDkpB/22scfDTR7k6E2ggcqO7EI
         lvqQ==
X-Gm-Message-State: APjAAAVj0JCzM3jLGVdKiedkChkGTFfGnz89T3vhw/YU9KjET4sZsuE4
        VtjY99eNm7+XF5inp7lq9sY=
X-Google-Smtp-Source: APXvYqxTJRKvff2VQ2AbO/A2hHFCWdKiEgIw3/LPhUvFbJn1sc9MbAcMf20K3siEvKJKXPFmDpeNSg==
X-Received: by 2002:a02:cb4b:: with SMTP id k11mr114182524jap.109.1564428832072;
        Mon, 29 Jul 2019 12:33:52 -0700 (PDT)
Received: from brauner.io ([162.223.5.124])
        by smtp.gmail.com with ESMTPSA id h8sm56813084ioq.61.2019.07.29.12.33.50
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Mon, 29 Jul 2019 12:33:51 -0700 (PDT)
Date:   Mon, 29 Jul 2019 21:33:50 +0200
From:   Christian Brauner <christian@brauner.io>
To:     Dmitry Safonov <0x7f454c46@gmail.com>
Cc:     Adrian Reber <areber@redhat.com>,
        Eric Biederman <ebiederm@xmission.com>,
        Pavel Emelianov <xemul@virtuozzo.com>,
        Jann Horn <jannh@google.com>,
        open list <linux-kernel@vger.kernel.org>,
        Oleg Nesterov <oleg@redhat.com>,
        Andrei Vagin <avagin@gmail.com>,
        Mike Rapoport <rppt@linux.ibm.com>,
        Radostin Stoyanov <rstoyanov1@gmail.com>
Subject: Re: [PATCH 1/2] fork: extend clone3() to support CLONE_SET_TID
Message-ID: <20190729193349.d5b6aivfx7w4plwq@brauner.io>
References: <20190729163355.4530-1-areber@redhat.com>
 <CAJwJo6Z5qHThG5wECSn+jiS0iM3smuXA1OS96Gho1HL-gD=RKQ@mail.gmail.com>
 <CAJwJo6baR_w_sE8Qtr4Le9KTLWx0Qzi99qmoTm+6hd1j1UkmFA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAJwJo6baR_w_sE8Qtr4Le9KTLWx0Qzi99qmoTm+6hd1j1UkmFA@mail.gmail.com>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 29, 2019 at 08:17:58PM +0100, Dmitry Safonov wrote:
> On Mon, 29 Jul 2019 at 20:12, Dmitry Safonov <0x7f454c46@gmail.com> wrote:
> >
> > On Mon, 29 Jul 2019 at 17:52, Adrian Reber <areber@redhat.com> wrote:
> > [..]
> > > --- a/include/uapi/linux/sched.h
> > > +++ b/include/uapi/linux/sched.h
> > > @@ -32,6 +32,7 @@
> > >  #define CLONE_NEWPID           0x20000000      /* New pid namespace */
> > >  #define CLONE_NEWNET           0x40000000      /* New network namespace */
> > >  #define CLONE_IO               0x80000000      /* Clone io context */
> > > +#define CLONE_SET_TID          0x100000000ULL  /* set if the desired TID is set in set_tid */
> > >
> > >  /*
> > >   * Arguments for the clone3 syscall
> > > @@ -45,6 +46,7 @@ struct clone_args {
> > >         __aligned_u64 stack;
> > >         __aligned_u64 stack_size;
> > >         __aligned_u64 tls;
> > > +       __aligned_u64 set_tid;
> > >  };
> > >
> >
> > I don't see a change to
> > :    if (unlikely(size < sizeof(struct clone_args)))
> > :        return -EINVAL;
> >
> > That seems backwards-incompatible, but I may miss some part..
> 
> On the other hand, clone3() was merged in v5.3 window, so probably,
> it doesn't matter.

It would matter. Even if this were to be accepted and preferred over the
existing /proc/sys/kernel/ns_last_pid interface the earliest point in
time I'd consider this for would be 5.4. So I think this would need to
be changed. :)

Christian

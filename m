Return-Path: <SRS0=TxL2=YH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 139D1ECE587
	for <linux-kernel@archiver.kernel.org>; Mon, 14 Oct 2019 09:32:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DDEC320659
	for <linux-kernel@archiver.kernel.org>; Mon, 14 Oct 2019 09:32:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="NO3t0VB0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730945AbfJNJcJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 14 Oct 2019 05:32:09 -0400
Received: from mail-oi1-f194.google.com ([209.85.167.194]:45603 "EHLO
        mail-oi1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730766AbfJNJcJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Oct 2019 05:32:09 -0400
Received: by mail-oi1-f194.google.com with SMTP id o205so13166361oib.12
        for <linux-kernel@vger.kernel.org>; Mon, 14 Oct 2019 02:32:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=6jj0LWwH0UFM3yMv+6fFI2lCptwbKbPuAlHLCa4o8Ig=;
        b=NO3t0VB09BjOrJIJjTivWi5amIrIxMpEZHxW8JEMb7N33MHXcv2aUag32CQYCcUUZ9
         TXOAKv95c2Il0Lepkm7etvCMnBAFcixRuzsaO3Elhy5zGvuL2xr5BBYDQJyd5ssczCQi
         5ir4r96u7LL4WEoovLW3Pgq8MLXqS9SMUP87tzhVCZPHY9DeDE3PMfxr/0t9YYs9wkEU
         y2DqQ/KfgC1tN7ljkGGHGiZtWkUEL9osHuc+zwl/pfgSZdAv/s/HfWVgBS8JsGsRtixa
         f1sd4T8c63v5FMTZMshOYphoAFyln5CRWyAwUh2PfdVKKJhGhH7MFE8FLFecl7JsFnwM
         h0tg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=6jj0LWwH0UFM3yMv+6fFI2lCptwbKbPuAlHLCa4o8Ig=;
        b=DnQH5w8N+qChJ5t9TkRFV8cpxBpInLPrrff53i8t9iXwI2b0kRbi5lQuTVY6SB+4lY
         XfcjBzL07G83rSyfmorNvHRwJ/5uoeoaTYln3YE9MOh8ckMjwHCT5h3u9TpMr/b9XcmV
         z44b7PP+TQlZ1egFMAflGOvWsVm6iZPudueFQik81Od5DO9MChANinxEbg1QT8S55QOw
         mdhk+AE9Uzg6NmeHKG7NamvlJBWnYjZ06DiDR/h6p/d/IwfcrEzxs1BNYguTMNtvgfMf
         aTfeWwMhoyoZpmITZuXBVK0XOvnP73vYZ3zknqDAopW/iha1rE5kvE55qhgU8ADAzBjO
         U8CA==
X-Gm-Message-State: APjAAAXjmn3T1eCdvro+95pq5p65NSNy632HIbRt7J+fK1aiX6849TrM
        LpQSC81Sd9q2H7lG2O/YlFnD+GT8SPzGX33PdjyR6g==
X-Google-Smtp-Source: APXvYqxRKShhWlAHrBWW8AcT8K9wqgTiCGHYZ3NkSoXSBgR+9wF9VJwmTWZrYvxCdQsGGuXlq7/dpsZkhsl9lpRkn+U=
X-Received: by 2002:aca:f492:: with SMTP id s140mr499222oih.83.1571045528182;
 Mon, 14 Oct 2019 02:32:08 -0700 (PDT)
MIME-Version: 1.0
References: <000001d5824d$c8b2a060$5a17e120$@codeaurora.org>
 <CACT4Y+aAicvQ1FYyOVbhJy62F4U6R_PXr+myNghFh8PZixfYLQ@mail.gmail.com>
 <CANpmjNOx7fuLLBasdEgnOCJepeufY4zo_FijsoSg0hfVgN7Ong@mail.gmail.com> <002801d58271$f5d01db0$e1705910$@codeaurora.org>
In-Reply-To: <002801d58271$f5d01db0$e1705910$@codeaurora.org>
From:   Marco Elver <elver@google.com>
Date:   Mon, 14 Oct 2019 11:31:56 +0200
Message-ID: <CANpmjNPVK00wsrpcVPFjudpqE-4-AVnZY0Pk-WMXTtqZTMXoOw@mail.gmail.com>
Subject: Re: KCSAN Support on ARM64 Kernel
To:     sgrover@codeaurora.org
Cc:     Dmitry Vyukov <dvyukov@google.com>,
        kasan-dev <kasan-dev@googlegroups.com>,
        LKML <linux-kernel@vger.kernel.org>,
        "Paul E. McKenney" <paulmck@linux.ibm.com>,
        Will Deacon <willdeacon@google.com>,
        Andrea Parri <parri.andrea@gmail.com>,
        Alan Stern <stern@rowland.harvard.edu>,
        Mark Rutland <mark.rutland@arm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Sachin,

My plan was to send patches upstream within the month.

Thanks,
-- Marco

On Mon, 14 Oct 2019 at 11:30, <sgrover@codeaurora.org> wrote:
>
> Hi Marco,
>
> When can we expect upstream of KCSAN on kernel mainline. Any timeline?
>
> Regards,
> Sachin Grover
>
> -----Original Message-----
> From: Marco Elver <elver@google.com>
> Sent: Monday, 14 October, 2019 2:40 PM
> To: Dmitry Vyukov <dvyukov@google.com>
> Cc: sgrover@codeaurora.org; kasan-dev <kasan-dev@googlegroups.com>; LKML =
<linux-kernel@vger.kernel.org>; Paul E. McKenney <paulmck@linux.ibm.com>; W=
ill Deacon <willdeacon@google.com>; Andrea Parri <parri.andrea@gmail.com>; =
Alan Stern <stern@rowland.harvard.edu>; Mark Rutland <mark.rutland@arm.com>
> Subject: Re: KCSAN Support on ARM64 Kernel
>
> On Mon, 14 Oct 2019 at 10:40, Dmitry Vyukov <dvyukov@google.com> wrote:
> >
> > On Mon, Oct 14, 2019 at 7:11 AM <sgrover@codeaurora.org> wrote:
> > >
> > > Hi Dmitry,
> > >
> > > I am from Qualcomm Linux Security Team, just going through KCSAN and =
found that there was a thread for arm64 support (https://lkml.org/lkml/2019=
/9/20/804).
> > >
> > > Can you please tell me if KCSAN is supported on ARM64 now? Can I just=
 rebase the KCSAN branch on top of our let=E2=80=99s say android mainline k=
ernel, enable the config and run syzkaller on that for finding race conditi=
ons?
> > >
> > > It would be very helpful if you reply, we want to setup this for find=
ing issues on our proprietary modules that are not part of kernel mainline.
> > >
> > > Regards,
> > >
> > > Sachin Grover
> >
> > +more people re KCSAN on ARM64
>
> KCSAN does not yet have ARM64 support. Once it's upstream, I would expect=
 that Mark's patches (from repo linked in LKML thread) will just cleanly ap=
ply to enable ARM64 support.
>
> Thanks,
> -- Marco
>

Return-Path: <SRS0=NvuC=VQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 54C2CC7618F
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Jul 2019 16:53:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 273832186A
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Jul 2019 16:53:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=brauner.io header.i=@brauner.io header.b="J0SvgNFh"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730468AbfGSQxy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 19 Jul 2019 12:53:54 -0400
Received: from mail-ot1-f65.google.com ([209.85.210.65]:43238 "EHLO
        mail-ot1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727717AbfGSQxy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Jul 2019 12:53:54 -0400
Received: by mail-ot1-f65.google.com with SMTP id j11so9180828otp.10
        for <linux-kernel@vger.kernel.org>; Fri, 19 Jul 2019 09:53:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=brauner.io; s=google;
        h=date:user-agent:in-reply-to:references:mime-version
         :content-transfer-encoding:subject:to:cc:from:message-id;
        bh=W6Id2apSO0w+oDefY5998IEGsU/bQYe3SdY14bHlNAI=;
        b=J0SvgNFhOGDy8g8QY/w1QwAYPSBe0785So5Ef8PCu0eG8fvW2Yjspbp76HCDseoPYy
         xAzoRaSj4CtH8k348QGLoBdiSQztIyUZS/QYzoJ4oRK9LFmWkaknioQt0cXmVRw2eG2h
         qqkc1PHLXNZxR5d2Fu2MCzeK2ANmvicuaZtcr+NEd54BQZc41C/Ik64X1VUjhgpCnXum
         OwZ1399Rwg0XjnxV6mgn0o48sUN8dHUtW6y9fVW6MHMxnwycBG2FUk0Q0rwr8OZUkbKh
         uETwqhcw7Dy2RjgoK3D0PTH6WDPW/IE9Axo1YvGTt5595OXwWiqskQvIrPu5sysvRekU
         MnhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:user-agent:in-reply-to:references
         :mime-version:content-transfer-encoding:subject:to:cc:from
         :message-id;
        bh=W6Id2apSO0w+oDefY5998IEGsU/bQYe3SdY14bHlNAI=;
        b=czZn2aSyqkaQKcS8oxIr2rnoAsn9yrH1/nbyHAZbuBtAYvrLsoeVDWW7rO1leMNCLE
         rPFTAXGeNPQStxqhn9b1HtDdj9P1OsCwYiM9Vu4g2btUQObhq53rNxrwniEhph0Mut9i
         MQwhOwY+bU7l8rqnKgTwzhhypnT+P/wsyIVK/Y5RSl/y3noKgXY/ptSvAtOKdae3YDib
         06HRxMviq3CgmPra1Ykri5w8nhr2KztwCxaMGK33DQncFix9WfVN0zSb+NHyqwhhploK
         JJtcfvPT8mx4vd2LN+KWfBE/eoDTM/mV4EqI8bQJ6u2ayFfH3V5zKKnca4TlDkV9uiaq
         AAsw==
X-Gm-Message-State: APjAAAUkE5dgpPigU96CdvwRX4uJ1CbIAyMo4DU+hADljHVDQ+FQNmYF
        8Ed9Nm8lbkr1vP2Wp5ik1oI=
X-Google-Smtp-Source: APXvYqxgiZ+oFBTjcTdnWdGZxD5geWB90IDB3Fm5dAm4Lj/cQbTKevyk7+7fNixz82rNIpEzEaklmA==
X-Received: by 2002:a9d:4c8b:: with SMTP id m11mr17441400otf.293.1563555233209;
        Fri, 19 Jul 2019 09:53:53 -0700 (PDT)
Received: from [26.82.125.95] ([208.54.86.221])
        by smtp.gmail.com with ESMTPSA id b2sm10783966otf.48.2019.07.19.09.53.51
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 19 Jul 2019 09:53:52 -0700 (PDT)
Date:   Fri, 19 Jul 2019 18:53:46 +0200
User-Agent: K-9 Mail for Android
In-Reply-To: <CAJWu+orxkFyoTTmFJs23FD0PKX-NetF4kVVLXnWkyLdCU2_cYQ@mail.gmail.com>
References: <20190717172100.261204-1-joel@joelfernandes.org> <20190719161404.GA24170@redhat.com> <20190719162726.u5fi5k3tqove6hgn@brauner.io> <CAJWu+orxkFyoTTmFJs23FD0PKX-NetF4kVVLXnWkyLdCU2_cYQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH RFC v1] pidfd: fix a race in setting exit_state for pidfd polling
To:     Joel Fernandes <joelaf@google.com>
CC:     Oleg Nesterov <oleg@redhat.com>,
        "Joel Fernandes (Google)" <joel@joelfernandes.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Suren Baghdasaryan <surenb@google.com>,
        "Cc: Android Kernel" <kernel-team@android.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        Tejun Heo <tj@kernel.org>
From:   Christian Brauner <christian@brauner.io>
Message-ID: <28DEE709-0BD6-4915-B9AB-0ACCC7C02111@brauner.io>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On July 19, 2019 6:51:20 PM GMT+02:00, Joel Fernandes <joelaf@google=2Ecom>=
 wrote:
>On Fri, Jul 19, 2019 at 12:27 PM Christian Brauner
><christian@brauner=2Eio> wrote:
>>
>> On Fri, Jul 19, 2019 at 06:14:05PM +0200, Oleg Nesterov wrote:
>> > it seems that I missed something else=2E=2E=2E
>> >
>> > On 07/17, Joel Fernandes (Google) wrote:
>> > >
>> > > @@ -1156,10 +1157,11 @@ static int wait_task_zombie(struct
>wait_opts *wo, struct task_struct *p)
>> > >             ptrace_unlink(p);
>> > >
>> > >             /* If parent wants a zombie, don't release it now */
>> > > -           state =3D EXIT_ZOMBIE;
>> > > +           p->exit_state =3D EXIT_ZOMBIE;
>> > >             if (do_notify_parent(p, p->exit_signal))
>> > > -                   state =3D EXIT_DEAD;
>> > > -           p->exit_state =3D state;
>> > > +                   p->exit_state =3D EXIT_DEAD;
>> > > +
>> > > +           state =3D p->exit_state;
>> > >             write_unlock_irq(&tasklist_lock);
>> >
>> > why do you think we also need to change wait_task_zombie() ?
>> >
>> > pidfd_poll() only needs the exit_state !=3D 0 check, we know that it
>> > is not zero at this point=2E Why do we need to change exit_state
>before
>> > do_notify_parent() ?
>>
>> Oh, because of?:
>>
>>         /*
>>          * Move the task's state to DEAD/TRACE, only one thread can
>do this=2E
>>          */
>>         state =3D (ptrace_reparented(p) && thread_group_leader(p)) ?
>>                 EXIT_TRACE : EXIT_DEAD;
>>         if (cmpxchg(&p->exit_state, EXIT_ZOMBIE, state) !=3D
>EXIT_ZOMBIE)
>>                 return 0;
>>
>> So exit_state will definitely be set in this scenario=2E Good point=2E
>>
>
>Agreed=2E Christian, do you mind dropping this hunk from the patch or do
>you want me to resend the patch with the hunk dropped?

Yeah, no problem=2E :)

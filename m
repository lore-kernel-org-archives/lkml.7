Return-Path: <SRS0=G/Om=ZT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 06097C432C0
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Nov 2019 15:26:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C80D02053B
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Nov 2019 15:26:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=joelfernandes.org header.i=@joelfernandes.org header.b="pnkn80E8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727113AbfK0P0K (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Nov 2019 10:26:10 -0500
Received: from mail-qk1-f193.google.com ([209.85.222.193]:36603 "EHLO
        mail-qk1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726514AbfK0P0J (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Nov 2019 10:26:09 -0500
Received: by mail-qk1-f193.google.com with SMTP id v19so191609qkv.3
        for <linux-kernel@vger.kernel.org>; Wed, 27 Nov 2019 07:26:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=m8XASQ33ScpPMW9Lk7i08lqftHVIhhUvhoQmKMQABbc=;
        b=pnkn80E8scR8OP9K1ql6Itvkl8+SnCbu+Dqzoa7buKcqDvIJ6fvN5RXHrEvAbbuP/B
         Z3xNb8VsfHx+ctarmuV2zL9XA52orUWS1O5afOFFBp+k6vFL5pVCuY2NFjUVhMtRjvIQ
         VdZUDb0gXj1V85KUfEtxHsPp/0+24jOlIUDfs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=m8XASQ33ScpPMW9Lk7i08lqftHVIhhUvhoQmKMQABbc=;
        b=tHoF8saDQ21Ab/YWD0BTYQBRKWploEyHrhl56UPC9MKmzbH67rU/Vl7649lwJONYBG
         U+IZ4ndRXLa5s/lEUzCvyXse9Q7szABnJbf/c0JGIFzYwBjWzWVJL/4xHWhLM8zIgJu5
         eeQiIIstD5HNcZ/RRczkyPNE+z4khO20i/4Zq3w9H08uFx30H5g2ZyFDPj9svcBqgika
         2LuZ65YEWYT55OKOk5LzK4sBgFNws2AkGqwTg6csDMVtF51ViYFLPBxuX1A+ZT9IeFbg
         0jH4rARYyKBXYupxhuav53h0S08AtkLuQkquyJ//KzbK4FQwGX9rjjQ+vf3ICyY2wC1Q
         ukMg==
X-Gm-Message-State: APjAAAUX+hUv6W3BghT2mV780X2f59Y1RBtz3Kwdgzk/id1jqyrDjfBZ
        lm2EtkArxw7dwKHx+3A4JPwf80ZhnX/tLdZ/lkEY/w==
X-Google-Smtp-Source: APXvYqxmt7EJm6XHe3c8cZCXvjViANZ57FQDXdBpxpmjlh/GOMdASfyOe+aRvHafsySiNAzQc11Jy+o+X72q47vcr88=
X-Received: by 2002:ae9:c219:: with SMTP id j25mr4939170qkg.470.1574868368530;
 Wed, 27 Nov 2019 07:26:08 -0800 (PST)
MIME-Version: 1.0
References: <20191126172723.GA12759@workstation-kernel-dev>
 <20191127022925.GB157739@google.com> <20191127052827.GA9782@workstation-portable>
In-Reply-To: <20191127052827.GA9782@workstation-portable>
From:   Joel Fernandes <joel@joelfernandes.org>
Date:   Wed, 27 Nov 2019 10:25:57 -0500
Message-ID: <CAEXW_YS=eDhmv+MaKLoRTCcPknscxqfHa2TyrjAEXpug1g67jw@mail.gmail.com>
Subject: Re: [PATCH] kernel: audit.c: Add __rcu notation to RCU pointer
To:     Amol Grover <frextrite@gmail.com>
Cc:     Paul Moore <paul@paul-moore.com>, Eric Paris <eparis@redhat.com>,
        linux-kernel-mentees@lists.linuxfoundation.org,
        Shuah Khan <skhan@linuxfoundation.org>, linux-audit@redhat.com,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 27, 2019 at 12:29 AM Amol Grover <frextrite@gmail.com> wrote:
>
> On Tue, Nov 26, 2019 at 09:29:25PM -0500, Joel Fernandes wrote:
> > On Tue, Nov 26, 2019 at 10:57:23PM +0530, Amol Grover wrote:
> > > add __rcu notation to RCU protected global pointer auditd_conn
> > >
> > > Fixes multiple instances of sparse error:
> > > error: incompatible types in comparison expression
> > > (different address spaces)
> > >
> > > Signed-off-by: Amol Grover <frextrite@gmail.com>
> > > ---
> > >  kernel/audit.c | 6 ++++--
> > >  1 file changed, 4 insertions(+), 2 deletions(-)
> > >
> > > diff --git a/kernel/audit.c b/kernel/audit.c
> > > index da8dc0db5bd3..30e7fc9b8da2 100644
> > > --- a/kernel/audit.c
> > > +++ b/kernel/audit.c
> > > @@ -102,12 +102,14 @@ struct audit_net {
> > >   * This struct is RCU protected; you must either hold the RCU lock for reading
> > >   * or the associated spinlock for writing.
> > >   */
> > > -static struct auditd_connection {
> > > +struct auditd_connection {
> > >     struct pid *pid;
> > >     u32 portid;
> > >     struct net *net;
> > >     struct rcu_head rcu;
> > > -} *auditd_conn = NULL;
> > > +};
> > > +static struct auditd_connection __rcu *auditd_conn;
> > > +RCU_INIT_POINTER(auditd_conn);
> >
> > Looks like this causes a build error. Always please build test your patches
> > in the very least. And I also did not understand how RCU_INIT_POINTER can
> > even be used outside of a function. In C, executable code cannot be outside
> > functions.
> >
> > Is doing the following not sufficient to fix the sparse issue?
> >
> > thanks,
> >
> >  - Joel
> >
> > ---8<-----------------------
> >
> > diff --git a/kernel/audit.c b/kernel/audit.c
> > index 49b6049b26ac..c5d4b5a2dea1 100644
> > --- a/kernel/audit.c
> > +++ b/kernel/audit.c
> > @@ -108,8 +108,8 @@ struct auditd_connection {
> >       struct net *net;
> >       struct rcu_head rcu;
> >  };
> > -static struct auditd_connection __rcu *auditd_conn;
> > -RCU_INIT_POINTER(auditd_conn);
> > +static struct auditd_connection __rcu *auditd_conn = NULL;
>
> I ran a quick checkpatch and it gave me this error:
> ERROR: do not initialise statics to NULL
>
> So in order to fix it I decided to INIT the pointer (and failed)

Well, try to understand the checkpatch error then, and do the right thing :)

- Joel

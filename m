Return-Path: <SRS0=QHyQ=ZU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8D5C1C432C0
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Nov 2019 15:10:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5B62C21775
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Nov 2019 15:10:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="c5OxcfVn"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726742AbfK1PK3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Nov 2019 10:10:29 -0500
Received: from mail-pj1-f67.google.com ([209.85.216.67]:32975 "EHLO
        mail-pj1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726556AbfK1PK3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Nov 2019 10:10:29 -0500
Received: by mail-pj1-f67.google.com with SMTP id r67so4258704pjb.0
        for <linux-kernel@vger.kernel.org>; Thu, 28 Nov 2019 07:10:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=Z2wU0E4d5s4/xK+13SW3DrjkiCtDxj7UMABJh83nudE=;
        b=c5OxcfVnBC5jamcSyxumsTvrFr88egXS4P+lN9zZWdpMu20m2zTLB7/E7qq0dW0BCd
         ScKf5xCamGQcz1nrfUmvavZYIKleOViPPnPD7AC+IvW5Uvw9nXn+8gpUb86p5QPrnpMR
         ixtnjJa9JEMmfJqXb9zrboDnEKM89dQncRUXaPP1mSqOuXtjP5mGOJIy/Kg/UsTEHHWk
         iegOzPLNe8CBS0Jb2x5yM5wQ/KEMz2j7zgdAf01PhNM63MW2M6vPVDEG/oibIorRUsX2
         ek+QpNVbMhMA8UMotnlY8cEhHxGFJTR4IxYTQXw5oSIoYdpX7kc0JZxuspkGjfq2XVx5
         kXng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=Z2wU0E4d5s4/xK+13SW3DrjkiCtDxj7UMABJh83nudE=;
        b=L0sSrxzjEZU8yIOysFVs3iNcvBt7TY+qZbP7akITz4BRSPZkyEWRPTj2F1sABfd66k
         fmb32RiLFowQJB8C2pVz4Jr5hMP2xg6yaSEUJIIbr+nAjilO6Gic2KSs+Olkly7YcPRw
         cl28jbhthk2TL6qQ04EsS9Jzlh4A706ngH049awVxWJAtG6BgXrV+qf/SllqcGwgR0ug
         vpEAaQgyWoH+N0Y6iwYScR6Dly7hZGqQL4YzRH59tb7JIuOXZaFftZoXuiSGCnS3prM6
         sfIAQgXMXItDngpA/b4VWTBPQbGFF0E2bWvkyt8Buk6cC8jWmwx3lYfBWBzdJgjrw7+x
         qadQ==
X-Gm-Message-State: APjAAAV16p2/4SzBFhIQgCt18wX0HCj24vmvOpcasck2926hOs4Q7tFL
        SU4XBGvv87AL8O2CqeHT/Bk=
X-Google-Smtp-Source: APXvYqyt+El6kPSt8sRjEBFZGlMkpGpdZo0+rg0M5e9jkdIU+Clr5DkO7mBNGSWNbn3kjaK8qooU+g==
X-Received: by 2002:a17:902:142:: with SMTP id 60mr10314206plb.38.1574953828543;
        Thu, 28 Nov 2019 07:10:28 -0800 (PST)
Received: from workstation-portable ([139.5.253.4])
        by smtp.gmail.com with ESMTPSA id h9sm8756948pfo.139.2019.11.28.07.10.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 Nov 2019 07:10:27 -0800 (PST)
Date:   Thu, 28 Nov 2019 20:39:49 +0530
From:   Amol Grover <frextrite@gmail.com>
To:     Joel Fernandes <joel@joelfernandes.org>
Cc:     Paul Moore <paul@paul-moore.com>, Eric Paris <eparis@redhat.com>,
        linux-kernel-mentees@lists.linuxfoundation.org,
        Shuah Khan <skhan@linuxfoundation.org>, linux-audit@redhat.com,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] kernel: audit.c: Add __rcu notation to RCU pointer
Message-ID: <20191128150949.GA30181@workstation-portable>
References: <20191126172723.GA12759@workstation-kernel-dev>
 <20191127022925.GB157739@google.com>
 <20191127052827.GA9782@workstation-portable>
 <CAEXW_YS=eDhmv+MaKLoRTCcPknscxqfHa2TyrjAEXpug1g67jw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAEXW_YS=eDhmv+MaKLoRTCcPknscxqfHa2TyrjAEXpug1g67jw@mail.gmail.com>
User-Agent: Mutt/1.12.2 (2019-09-21)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 27, 2019 at 10:25:57AM -0500, Joel Fernandes wrote:
> On Wed, Nov 27, 2019 at 12:29 AM Amol Grover <frextrite@gmail.com> wrote:
> >
> > On Tue, Nov 26, 2019 at 09:29:25PM -0500, Joel Fernandes wrote:
> > > On Tue, Nov 26, 2019 at 10:57:23PM +0530, Amol Grover wrote:
> > > > add __rcu notation to RCU protected global pointer auditd_conn
> > > >
> > > > Fixes multiple instances of sparse error:
> > > > error: incompatible types in comparison expression
> > > > (different address spaces)
> > > >
> > > > Signed-off-by: Amol Grover <frextrite@gmail.com>
> > > > ---
> > > >  kernel/audit.c | 6 ++++--
> > > >  1 file changed, 4 insertions(+), 2 deletions(-)
> > > >
> > > > diff --git a/kernel/audit.c b/kernel/audit.c
> > > > index da8dc0db5bd3..30e7fc9b8da2 100644
> > > > --- a/kernel/audit.c
> > > > +++ b/kernel/audit.c
> > > > @@ -102,12 +102,14 @@ struct audit_net {
> > > >   * This struct is RCU protected; you must either hold the RCU lock for reading
> > > >   * or the associated spinlock for writing.
> > > >   */
> > > > -static struct auditd_connection {
> > > > +struct auditd_connection {
> > > >     struct pid *pid;
> > > >     u32 portid;
> > > >     struct net *net;
> > > >     struct rcu_head rcu;
> > > > -} *auditd_conn = NULL;
> > > > +};
> > > > +static struct auditd_connection __rcu *auditd_conn;
> > > > +RCU_INIT_POINTER(auditd_conn);
> > >
> > > Looks like this causes a build error. Always please build test your patches
> > > in the very least. And I also did not understand how RCU_INIT_POINTER can
> > > even be used outside of a function. In C, executable code cannot be outside
> > > functions.
> > >
> > > Is doing the following not sufficient to fix the sparse issue?
> > >
> > > thanks,
> > >
> > >  - Joel
> > >
> > > ---8<-----------------------
> > >
> > > diff --git a/kernel/audit.c b/kernel/audit.c
> > > index 49b6049b26ac..c5d4b5a2dea1 100644
> > > --- a/kernel/audit.c
> > > +++ b/kernel/audit.c
> > > @@ -108,8 +108,8 @@ struct auditd_connection {
> > >       struct net *net;
> > >       struct rcu_head rcu;
> > >  };
> > > -static struct auditd_connection __rcu *auditd_conn;
> > > -RCU_INIT_POINTER(auditd_conn);
> > > +static struct auditd_connection __rcu *auditd_conn = NULL;
> >
> > I ran a quick checkpatch and it gave me this error:
> > ERROR: do not initialise statics to NULL
> >
> > So in order to fix it I decided to INIT the pointer (and failed)
> 
> Well, try to understand the checkpatch error then, and do the right thing :)

I read-up a few articles about this. I think I've understood the problem. I'm
sending in the ammended patch now. Sorry for this. Won't happen again.

Thanks
Amol

> 
> - Joel

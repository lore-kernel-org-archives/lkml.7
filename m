Return-Path: <SRS0=95/N=R6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SIGNED_OFF_BY,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2B56FC4360F
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Mar 2019 22:14:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EC84F2070B
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Mar 2019 22:14:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore-com.20150623.gappssmtp.com header.i=@paul-moore-com.20150623.gappssmtp.com header.b="06Bh2pTw"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727762AbfC0WOj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Mar 2019 18:14:39 -0400
Received: from mail-lj1-f195.google.com ([209.85.208.195]:33007 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726102AbfC0WOi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Mar 2019 18:14:38 -0400
Received: by mail-lj1-f195.google.com with SMTP id f23so15867733ljc.0
        for <linux-kernel@vger.kernel.org>; Wed, 27 Mar 2019 15:14:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=SsRGAQ7sJFAbYvV3GBI8Nbjp7rSZFjGzVO6KmG1CsfQ=;
        b=06Bh2pTww9SeR3OZRDoe/rWJyAoIYX2qQEJKdTMSK6HaMSiWKQF6xqBbrBAc0VybQ1
         ivdi3ZgiroM9TTLtAIf+2xZoyuWdjRfQHJOrZoYfCQdrsUx1o96FMlMNa0J/AAK+XspN
         taIuOn/AqmSDvWl7b3R4VqwLRdCZMYcqqmmVLyJxYLg8/k0x715gxg/1UIBv8HDsI9ta
         pYHESFAUTVvU2i5Yc0nIDqMDMpWmdYG/t6ZCOYfosrc5wu+pbVzYCWY098orvxXHGlrn
         iaH60AO8CPKG2Y2AC7mt2x3yN7/yMDW1l/vSrxiqKQAJaRyZOG3wLQ1AajyNzHEqgeZW
         /vtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=SsRGAQ7sJFAbYvV3GBI8Nbjp7rSZFjGzVO6KmG1CsfQ=;
        b=i4UPWnEqed9REC5BNMrIBLVzZXUQLnCWRbA4QDX6MG7Vrf3IfMUzxchklpDIPzW00I
         bpRZ+4sY/gx6E1Sei5pT0G7L6lZEQEaqKmScY4Nl+btkVt4jfUlGqDu4W5PvJ2WOQGWh
         69CPPkibMjfcLCVLPqdNPBosUtAbq868ynFXTfgK+cRSP1qgUFqEVckUWyeq+ixLTCL7
         TktyE8tVDXAugB/IW8bSg1O83ZnLYvXDwc3aDrUnoMwqV7x1QeyQu5xUrizGWYH4cHu4
         M9x1WDqvlS9+IB15Msj+B83hJ24S6IHQsgbrCDROo3zdqgcU136Z/YUFxSp035yIeOL6
         MuvA==
X-Gm-Message-State: APjAAAXHkYq8TcLbdWpIvh4c5tv4WSDIj+g1H/ax89Mvz+U3TuoWbb5t
        zNYZHP5nIAnARaenb7lOev2an18ANAUYwpc6Z7Yt
X-Google-Smtp-Source: APXvYqyIUmp7WHxf9CvVSs+NqwpyWyAp1viAd7CvRJX3B2hlxcsIrzeABF7cqFbtimBWZ78hqH4Hkv8XGvzpUGSjGnw=
X-Received: by 2002:a2e:500d:: with SMTP id e13mr21128699ljb.169.1553724876420;
 Wed, 27 Mar 2019 15:14:36 -0700 (PDT)
MIME-Version: 1.0
References: <087489b21e50bcda65c6af3e038394d5bfe09e00.1553626080.git.rgb@redhat.com>
 <1553632830.4233.3.camel@linux.ibm.com> <CAHC9VhS1e0+1t=ZUsKoJcFvO+JdewL4uqwO4dqw=tOOZdJbLYA@mail.gmail.com>
 <1553699048.4154.1.camel@linux.ibm.com>
In-Reply-To: <1553699048.4154.1.camel@linux.ibm.com>
From:   Paul Moore <paul@paul-moore.com>
Date:   Wed, 27 Mar 2019 18:14:25 -0400
Message-ID: <CAHC9VhRYHu8EcHEOc-6FSnbNRVE+9TmMziRidA7KtbzoZdv9Ow@mail.gmail.com>
Subject: Re: [PATCH ghak109 V2] audit: link integrity evm_write_xattrs record
 to syscall event
To:     Mimi Zohar <zohar@linux.ibm.com>,
        Richard Guy Briggs <rgb@redhat.com>
Cc:     linux-integrity@vger.kernel.org,
        linux-security-module@vger.kernel.org,
        Linux-Audit Mailing List <linux-audit@redhat.com>,
        LKML <linux-kernel@vger.kernel.org>, sgrubb@redhat.com,
        omosnace@redhat.com, Eric Paris <eparis@parisplace.org>,
        Serge Hallyn <serge@hallyn.com>, mjg59@google.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 27, 2019 at 11:05 AM Mimi Zohar <zohar@linux.ibm.com> wrote:
> On Tue, 2019-03-26 at 19:58 -0400, Paul Moore wrote:
> > On Tue, Mar 26, 2019 at 4:40 PM Mimi Zohar <zohar@linux.ibm.com> wrote:
> > >
> > > Hi Richard, Paul,
> > >
> > > On Tue, 2019-03-26 at 14:49 -0400, Richard Guy Briggs wrote:
> > > > In commit fa516b66a1bf ("EVM: Allow runtime modification of the set of
> > > > verified xattrs"), the call to audit_log_start() is missing a context to
> > > > link it to an audit event. Since this event is in user context, add
> > > > the process' syscall context to the record.
> > > >
> > > > In addition, the orphaned keyword "locked" appears in the record.
> > > > Normalize this by changing it to logging the locking string "." as any
> > > > other user input in the "xattr=" field.
> > > >
> > > > Please see the github issue
> > > > https://github.com/linux-audit/audit-kernel/issues/109
> > > >
> > > > Signed-off-by: Richard Guy Briggs <rgb@redhat.com>
> > >
> > > Acked-by: Mimi Zohar <zohar@linux.ibm.com>
> > >
> > > Paul, were you planning on upstreaming this patch?
> >
> > Yep, unless you would rather do it?
>
> No, that's fine. Thanks!

Merged into audit/next, thanks all.

-- 
paul moore
www.paul-moore.com

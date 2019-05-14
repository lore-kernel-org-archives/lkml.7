Return-Path: <SRS0=uOpN=TO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 40A9CC04AB4
	for <linux-kernel@archiver.kernel.org>; Tue, 14 May 2019 22:13:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 061DC20881
	for <linux-kernel@archiver.kernel.org>; Tue, 14 May 2019 22:13:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="ULnWl7Re"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726283AbfENWND (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 May 2019 18:13:03 -0400
Received: from mail-vs1-f54.google.com ([209.85.217.54]:43933 "EHLO
        mail-vs1-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726148AbfENWNC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 May 2019 18:13:02 -0400
Received: by mail-vs1-f54.google.com with SMTP id d128so355522vsc.10
        for <linux-kernel@vger.kernel.org>; Tue, 14 May 2019 15:13:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=wVIzeix7iLELUYXl5m49E5wdhPumzJ5vp2cjgvebQJQ=;
        b=ULnWl7ReV9rhaVd9pYIsvgg33E+PGKtMfc+ur2c8hcDVjhewK0cqzVQ/57ij9VsgjQ
         5Y69oZ7Mzh9fQPFmr2uXOzsFsmL/k9mCx144O+AehmgtTh59VxK83LKZqOWIeKnin8wQ
         0IIZse0BJQXufZcusH2jn6JvGYIO8IsvjbGNE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=wVIzeix7iLELUYXl5m49E5wdhPumzJ5vp2cjgvebQJQ=;
        b=ibbIFx56Fx2ZJzdOvYsQody+lflnBZ3oI3iJg8xEN6NXSQvRFAlMSJibZUSWYQzH9S
         MZRKLmu8+7MR6fGuh4Pp76MtsBb5r+V748BIk834WPtd9FUtvuxwGF4j3mOYATVIfN1W
         p17NVtKTQYieWOWRv+h5Rg24/R44j5cIjU+AkybM2FUtSR3bcRvczCmKvLHyEQne5jYj
         8B86m+mm2ROWDxZSOU5HKdP/AdnxQAq+270jWGvMNe6Sz4+Y1qHrnN8Bh3nevJJqG2R4
         cVIUKcX5kSe+syy4LBkc3w+UVeduA6lRYbdroGThDG+xuvZHwNcLidoxUEz7IKHPBrji
         i7iw==
X-Gm-Message-State: APjAAAV1p2OlKXD7agNWTsnWZJbUhRWo0D+xlq2TyqHyOdmfh/CBYEFQ
        lXUQChEvdm2MvMHW42MDVs52S15Wskw=
X-Google-Smtp-Source: APXvYqzl6n/t4vlNlz7TiorWlld7g4reEQ7+5ufJfDNTfNQPuYGiRxr+5QsEkB8YNG+mpEalSMxkPg==
X-Received: by 2002:a67:7ac9:: with SMTP id v192mr19336729vsc.100.1557871981559;
        Tue, 14 May 2019 15:13:01 -0700 (PDT)
Received: from mail-vs1-f45.google.com (mail-vs1-f45.google.com. [209.85.217.45])
        by smtp.gmail.com with ESMTPSA id e76sm69036vke.54.2019.05.14.15.13.00
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
        Tue, 14 May 2019 15:13:00 -0700 (PDT)
Received: by mail-vs1-f45.google.com with SMTP id o10so349867vsp.12
        for <linux-kernel@vger.kernel.org>; Tue, 14 May 2019 15:13:00 -0700 (PDT)
X-Received: by 2002:a67:b348:: with SMTP id b8mr10745210vsm.144.1557871980393;
 Tue, 14 May 2019 15:13:00 -0700 (PDT)
MIME-Version: 1.0
References: <CAD=FV=VOAjgdrvkK8YKPP-8zqwPpo39rA43JH2BCeYLB0UkgAQ@mail.gmail.com>
 <20190513171519.GA26166@redhat.com> <CAD=FV=X7GDNoJVvRgBTDoVkf9UYA69B-rTY2G3888w=9iS=RtQ@mail.gmail.com>
 <20190514172938.GA31835@redhat.com>
In-Reply-To: <20190514172938.GA31835@redhat.com>
From:   Doug Anderson <dianders@chromium.org>
Date:   Tue, 14 May 2019 15:12:48 -0700
X-Gmail-Original-Message-ID: <CAD=FV=VTn7OKOG03YDTjzDPJMYD7ar+HdswHb=VUHm_yp=8vMg@mail.gmail.com>
Message-ID: <CAD=FV=VTn7OKOG03YDTjzDPJMYD7ar+HdswHb=VUHm_yp=8vMg@mail.gmail.com>
Subject: Re: Problems caused by dm crypt: use WQ_HIGHPRI for the IO and crypt workqueues
To:     Mike Snitzer <snitzer@redhat.com>
Cc:     Tim Murray <timmurray@google.com>,
        Guenter Roeck <groeck@chromium.org>,
        Enric Balletbo i Serra <enric.balletbo@collabora.com>,
        Vito Caputo <vcaputo@pengaru.com>,
        LKML <linux-kernel@vger.kernel.org>, dm-devel@redhat.com,
        Tejun Heo <tj@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Tue, May 14, 2019 at 10:29 AM Mike Snitzer <snitzer@redhat.com> wrote:

> > tl;dr: High priority (even without CPU_INTENSIVE) definitely causes
> > interference with my high priority work starving it for > 8 ms, but
> > dm-crypt isn't unique here--loopback devices also have problems.
>
> Well I read it all ;)
>
> I don't have a commit 37a186225a0c, the original commit in querstion is
> a1b89132dc4 right?

commit 37a186225a0c ("platform/chrome: cros_ec_spi: Transfer messages
at high priority") is only really relevant to my particular test case
of using cros_ec to reproduce the problem.


> But I think we need a deeper understanding from workqueue maintainers on
> what the right way forward is here.  I cc'd Tejun in my previous reply
> but IIRC he no longer looks after the workqueue code.
>
> I think it'd be good for you to work with the original author of commit
> a1b89132dc4 (Tim, on cc) to see if you can reach consensus on what works
> for both of your requirements.

Basically what I decided in the end was that the workqueue code didn't
offer enough flexibility in terms of priorities.  To get realtime
priority I needed to fallback to using kthread_create_worker() to
create my worker.  Presumably if you want something nicer than the
"min_nice" priority you get with the high priority workqueue flag then
you'd have to do something similar (but moving in the opposite
direction).


> Given 7 above, if your new "cros_ec at realtime" series fixes it.. ship
> it?

Yeah, that's the plan.  Right now I have
<https://lkml.kernel.org/r/20190514183935.143463-2-dianders@chromium.org>
but Guenter pointed out some embarrassing bugs in my patch so I'll
post up a v4 tomorrow.  I pointed to a Chrome OS review that has a
preview of my v4 if you for some reason can't wait.  That can be found
at <https://crrev.com/c/1612165>.


-Doug

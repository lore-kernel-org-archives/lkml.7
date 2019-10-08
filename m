Return-Path: <SRS0=XKeO=YB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 14233ECE58C
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Oct 2019 18:47:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DBB8A21835
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Oct 2019 18:47:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Emybee+3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729895AbfJHSr0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 8 Oct 2019 14:47:26 -0400
Received: from mail-lf1-f67.google.com ([209.85.167.67]:41025 "EHLO
        mail-lf1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726098AbfJHSr0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Oct 2019 14:47:26 -0400
Received: by mail-lf1-f67.google.com with SMTP id r2so12751157lfn.8
        for <linux-kernel@vger.kernel.org>; Tue, 08 Oct 2019 11:47:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=NqVCRA8DXcJbueCkNXpXj55U/sPwUJi86T0AFdK851g=;
        b=Emybee+3RFAUwAW/L2KKsoVCidti/TvHDnVzPjg0lUeAwKfvemlBcNmdI57+NwrH93
         F8w3wC6Xb32v6bugBgFX3TBSXsCgjWFinj+7hJlanBzf7WEP0vFubbZB7hDN3zGC9RBV
         7vHxJx6VHJOfTu0j7kbRMQasGPVl0HnU4gL1y+cRqWH/nB4LkAHm73VDZaJjSVIvo48p
         rpwMvVM+MF7pfa16xLOojyTL1jn3/GwwKu4ZN3Vn2tqSv8DlPJvY3NM9aM8ATtjw+NSI
         pkaqguQsc2zrPolAx6LlPeLM+l15DOup95mAAM/aSZSmKYPTmlJOyb4f+IrLx2zIVBpd
         Fx2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=NqVCRA8DXcJbueCkNXpXj55U/sPwUJi86T0AFdK851g=;
        b=mIPqmh/uf2TJlhlzda08o3E1pkyJ6jMG0b6WOk8d4M/1sAAcicHKGC+8YZ5fR+JFKn
         5qPebGpat9wEfeo/R5gHN6sRyxSxWDGBM4sRdN9MdsGTq1KGnavMEyS2Rn3hxNhRTahB
         qG6jbvae50fAodz/nZhZH4KcyFYIZXKeTz8ioj2tiEMSxhRMD2HJHd62c28Gx7h/ws0v
         husIDsE5+itDuUYt7dxmszNXhxCwYB20bq1uLtFGkRbkCHr9CTAGoQkOCsynUK+owHVI
         EVDbj4EqkkanOj8SZkLdGa4rv6BUoonFIc8vh1gRo0NDpVu//QLN79riIVZh0bV4oGh6
         3NwA==
X-Gm-Message-State: APjAAAVHTZK/KY+JnVhg5HshTco0J+cNsM8g0u6GNO/LeFIce12F4mt8
        sRyCXqBzxeVuGf7kXGKR64eUaZm0CuX5ObMgFQogzg==
X-Google-Smtp-Source: APXvYqytolLSF0r3yep4If7phWlR+1MwoRx2hz0qGu2SEFqK4bNiHQ601qXE3T5cRwePaDDbc6xYqFCCUvMu34mbhyQ=
X-Received: by 2002:ac2:59c2:: with SMTP id x2mr19473718lfn.125.1570560444146;
 Tue, 08 Oct 2019 11:47:24 -0700 (PDT)
MIME-Version: 1.0
References: <1568878421-12301-1-git-send-email-vincent.guittot@linaro.org>
 <1568878421-12301-5-git-send-email-vincent.guittot@linaro.org> <20191008175537.GC22902@worktop.programming.kicks-ass.net>
In-Reply-To: <20191008175537.GC22902@worktop.programming.kicks-ass.net>
From:   Vincent Guittot <vincent.guittot@linaro.org>
Date:   Tue, 8 Oct 2019 20:47:12 +0200
Message-ID: <CAKfTPtAMEdcpX=h1sNaM-S9R7xB7ZPp5UZGdm_8pBWMYzeB+VA@mail.gmail.com>
Subject: Re: [PATCH v3 04/10] sched/fair: rework load_balance
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     linux-kernel <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@redhat.com>, Phil Auld <pauld@redhat.com>,
        Valentin Schneider <valentin.schneider@arm.com>,
        Srikar Dronamraju <srikar@linux.vnet.ibm.com>,
        Quentin Perret <quentin.perret@arm.com>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Morten Rasmussen <Morten.Rasmussen@arm.com>,
        Hillf Danton <hdanton@sina.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 8 Oct 2019 at 19:55, Peter Zijlstra <peterz@infradead.org> wrote:
>
> On Thu, Sep 19, 2019 at 09:33:35AM +0200, Vincent Guittot wrote:
> > +     if (busiest->group_type == group_asym_packing) {
> > +             /*
> > +              * In case of asym capacity, we will try to migrate all load to
> > +              * the preferred CPU.
> > +              */
> > +             env->balance_type = migrate_load;
> >               env->imbalance = busiest->group_load;
> >               return;
> >       }
>
> I was a bit surprised with this; I sorta expected a migrate_task,1 here.

I have just kept current mechanism

>
> The asym_packing thing has always been a nr_running issue to me. If
> there is something to run, we should run on as many siblings/cores as
> possible, but preferably the 'highest' ranked siblings/cores.

I can probably set the number of running task to migrate instead of the load
>

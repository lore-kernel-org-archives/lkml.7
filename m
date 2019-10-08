Return-Path: <SRS0=XKeO=YB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 00B3DC4360C
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Oct 2019 18:45:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C90B6206C0
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Oct 2019 18:45:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="x/cCaZXl"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729771AbfJHSp0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 8 Oct 2019 14:45:26 -0400
Received: from mail-lj1-f194.google.com ([209.85.208.194]:44702 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726098AbfJHSp0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Oct 2019 14:45:26 -0400
Received: by mail-lj1-f194.google.com with SMTP id m13so18656761ljj.11
        for <linux-kernel@vger.kernel.org>; Tue, 08 Oct 2019 11:45:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=qfuM+eOrfkjY3X5vdG1L/3iSehedGNPzsEMXo/fl1Hs=;
        b=x/cCaZXlC//XNrYXPZnfr80qisOKMZMVwbO1hNPgpVxeRN5oUwYVPUeGEo8UMHz8UQ
         0HX5OSJ9TqTP4l2dtQJqVXJx+9TD+OaOEGLU7gKgROLqadJaT6TsSX/L/7//1Yb8V2bR
         0k98m0Q9Bd5ttF4R05XZgHWx4t44li1DdI8LyrZl82cJiiXryA7PA+ZsCTqQWwS2NW/w
         heIeaU0vG2FU3Vm8JO0avB5HIwD9XJLlhuP1WeCxOR+en+1VJroRKkxB/TsDSRmJSFRh
         B/whC+YMw6uTl53LwYkRfwSKomYVg2OSJqDTWCb04dzVFnL52uzMs3QQzSdKgsr3qhGl
         jvuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=qfuM+eOrfkjY3X5vdG1L/3iSehedGNPzsEMXo/fl1Hs=;
        b=mwiQL6aiL/vNy5mnNUl3+vJEVfnb9+VCFAbQsHdpvPGWq07gkl72ccrIu36C7grfM0
         eFKdxbcRm1eLH7uSJfR8lfEFyecsyikQxSiRuKd0YOkdLqDNrRZPjadpxnD/k3QyhEDU
         OwTVzc6cG/pFsDwAA/Bwhw9Jip3j0IRpAkwz1XhPlet0Ttq2xtXX5Of2o7VGAuANJ8hc
         T1hmJe/WGNb3V5Nu/MDEprvHQhkzCkaEJVkCOA99w4t2IegA7pxnBjojMDlkhlC0Mg1w
         JI4Xl9AONiJ/axO8Pe1twPV65891JDJf11VfDpvkWv+UfMfE7chXQWAvM99tpzYjaTu8
         zRZQ==
X-Gm-Message-State: APjAAAVByeDu/vaddaKeqRNvIyZhSDqYDlqv0ElpxzZTM20i3QIutcSD
        XNfoevygXRlURUe0PLEKOqzpp+oImIzFbAZi+ta/mA==
X-Google-Smtp-Source: APXvYqzF8GNyIxixEVMPLtfOR5UU3dmLQNgq1g59BBwDCB2AdpAwOZCF77uwxq0JzNBcTRet552JBED6lTXTPMQ6rIE=
X-Received: by 2002:a2e:5bdd:: with SMTP id m90mr22896723lje.193.1570560323997;
 Tue, 08 Oct 2019 11:45:23 -0700 (PDT)
MIME-Version: 1.0
References: <1568878421-12301-1-git-send-email-vincent.guittot@linaro.org>
 <1568878421-12301-5-git-send-email-vincent.guittot@linaro.org>
 <c752dd1a-731e-aae3-6a2c-aecf88901ac0@arm.com> <CAKfTPtBQNJfNmBqpuaefsLzsTrGxJ=2bTs+tRdbOAa9J3eKuVw@mail.gmail.com>
 <31cac0c1-98e4-c70e-e156-51a70813beff@arm.com> <20191008141642.GQ2294@hirez.programming.kicks-ass.net>
 <b4e29e48-a97c-67e5-a284-6ddc13222c5b@arm.com> <20191008153002.GA21999@linaro.org>
 <20191008173910.GB22902@worktop.programming.kicks-ass.net>
In-Reply-To: <20191008173910.GB22902@worktop.programming.kicks-ass.net>
From:   Vincent Guittot <vincent.guittot@linaro.org>
Date:   Tue, 8 Oct 2019 20:45:11 +0200
Message-ID: <CAKfTPtB+UKLzOtt9dujGJtZBXB9jr-fm-C5xxkDCCDtGVwj78Q@mail.gmail.com>
Subject: Re: [PATCH v3 04/10] sched/fair: rework load_balance
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Valentin Schneider <valentin.schneider@arm.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@redhat.com>, Phil Auld <pauld@redhat.com>,
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

On Tue, 8 Oct 2019 at 19:39, Peter Zijlstra <peterz@infradead.org> wrote:
>
> On Tue, Oct 08, 2019 at 05:30:02PM +0200, Vincent Guittot wrote:
>
> > This is how I plan to get ride of the problem:
> > +             if (busiest->group_weight == 1 || sds->prefer_sibling) {
> > +                     unsigned int nr_diff = busiest->sum_h_nr_running;
> > +                     /*
> > +                      * When prefer sibling, evenly spread running tasks on
> > +                      * groups.
> > +                      */
> > +                     env->migration_type = migrate_task;
> > +                     lsub_positive(&nr_diff, local->sum_h_nr_running);
> > +                     env->imbalance = nr_diff >> 1;
> > +                     return;
> > +             }
>
> I'm thinking the max_t(long, 0, ...); variant reads a lot simpler and
> really _should_ work given that -fno-strict-overflow / -fwrapv mandates
> 2s complement.

Another point that I have overlooked is that sum_h_nr_running is
unsigned int whereas imbalance is long

In fact, (long) (unsigned long A - unsigned long B) >> 1 works correctly
but
(long) (unsigned int A - unsigned int B) >> 1 doesn't

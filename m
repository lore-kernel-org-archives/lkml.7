Return-Path: <SRS0=kjqD=WY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9FC56C3A5A1
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Aug 2019 16:34:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6FB2E20679
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Aug 2019 16:34:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="OvWB6hea"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726618AbfH1Qey (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 28 Aug 2019 12:34:54 -0400
Received: from mail-lj1-f196.google.com ([209.85.208.196]:45631 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726395AbfH1Qey (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Aug 2019 12:34:54 -0400
Received: by mail-lj1-f196.google.com with SMTP id l1so109631lji.12
        for <linux-kernel@vger.kernel.org>; Wed, 28 Aug 2019 09:34:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=2WikD6MgwOlBlXQW6aH35TxJPpLI3f3fOf3yGffcmaQ=;
        b=OvWB6heaLwNtKXCs0DjkbQm1xLGk216junIeJOZ/9/weaeCznaX8C9Ei5+2azbq6od
         82xB58qDDK8VmC5ZTjqTisMSicLowGORtR6hXTYqdieUwDRxQBAUs9ZrKwIWv+3dWF8/
         28wTR2pyvgqa5RdOu4atZ/sRPeLzW82pmJl6gBXP3zcDYRjvmYU833vOws4tyZR9Luty
         Mofo/Ao3KNHLZULleC7/erJniDW4Df0bs1WhfKQ4P8g2Xi7G3j7ODGE7F6WQBN8xOWo/
         nbQ/qT6tF5MUvQ+QM/iJev99iQoumvLyQBanjcP/8hV5TBHqwv8y+vUB1YO7eWGOCT6s
         jONA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=2WikD6MgwOlBlXQW6aH35TxJPpLI3f3fOf3yGffcmaQ=;
        b=Z6z41aeKupUtK0WhOcmntw5irRaC6ZzV4hQ4pX9QMbgBykG1a1ZCDCl/pwawpxIZed
         9yw3ZPilkLH89+zTWAdruVUg/Y85Zl5ctIfJXt00Aj02CzMwaPozOBVd6klSNmWbFu9N
         r/r54BHFJV+NWfvhVoxOFwiXL/r+6/oQnOYhmylIqSFS4hRrZmZwPpHWEa8ee4WkhzPO
         GZu/bA9YLcdcPYXSLIacvExVQEBwRN01sKlczMt+GFeAm4WxGRjjfpaxEnpAaHOMulxn
         Xfh46o27GOGg6TfxwI/c9qSb8+po/Zs0ep6AZPVqK/K49Cs6Ays8BpXpEYb7FFKklOGW
         ANDg==
X-Gm-Message-State: APjAAAVp8hj4IUatA1zS8wjaCTq04n011DhoAcjUEpZtbMR7/J36qi4o
        WpRD9vhDAp3EMwRLRdm2TiblwrA31778aqKj2Sqkzw==
X-Google-Smtp-Source: APXvYqw2V+WZEl/LlbjZ1qUA01WeWSDBZy24hA+Ex1pwK4iSXA8cmeKdFlx+93mKYOFjWbdsBFM4zXWipZp9NhCAumE=
X-Received: by 2002:a2e:970e:: with SMTP id r14mr2501550lji.204.1567010092005;
 Wed, 28 Aug 2019 09:34:52 -0700 (PDT)
MIME-Version: 1.0
References: <20190822021740.15554-1-riel@surriel.com> <20190822021740.15554-7-riel@surriel.com>
 <CAKfTPtCsuz7DN-NkmbMpLyNG=CqbAeONV8JpCVQmSCsd387eNQ@mail.gmail.com> <552e6a1b7fc5656874e19d9e9cf2553b60e8796e.camel@surriel.com>
In-Reply-To: <552e6a1b7fc5656874e19d9e9cf2553b60e8796e.camel@surriel.com>
From:   Vincent Guittot <vincent.guittot@linaro.org>
Date:   Wed, 28 Aug 2019 18:34:40 +0200
Message-ID: <CAKfTPtBgNUN7YWtt=z0kpWypeEqy=R6Ss-Ne93UB-4g_yiMkYQ@mail.gmail.com>
Subject: Re: [PATCH 06/15] sched,cfs: use explicit cfs_rq of parent se helper
To:     Rik van Riel <riel@surriel.com>
Cc:     linux-kernel <linux-kernel@vger.kernel.org>,
        Kernel Team <kernel-team@fb.com>, Paul Turner <pjt@google.com>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Morten Rasmussen <morten.rasmussen@arm.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Mel Gorman <mgorman@techsingularity.net>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 28 Aug 2019 at 17:28, Rik van Riel <riel@surriel.com> wrote:
>
> On Wed, 2019-08-28 at 15:53 +0200, Vincent Guittot wrote:
> > On Thu, 22 Aug 2019 at 04:18, Rik van Riel <riel@surriel.com> wrote:
> > > Use an explicit "cfs_rq of parent sched_entity" helper in a few
> > > strategic places, where cfs_rq_of(se) may no longer point at the
> >
> > The only case is the sched_entity of a task which will point to root
> > cfs, isn't it ?
>
> True. I am more than open to ideas to simplify this
> part of the code, hopefully in some way that makes
> it easier to read.

my question was mainly informative to make sure that i didn't miss a corner case

>
> --
> All Rights Reversed.

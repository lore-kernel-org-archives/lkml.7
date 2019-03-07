Return-Path: <SRS0=uyI7=RK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3BF57C43381
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Mar 2019 19:28:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0E03720851
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Mar 2019 19:28:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="RgKW/5A6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726777AbfCGT2k (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 Mar 2019 14:28:40 -0500
Received: from mail-vs1-f66.google.com ([209.85.217.66]:43489 "EHLO
        mail-vs1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726207AbfCGT2k (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Mar 2019 14:28:40 -0500
Received: by mail-vs1-f66.google.com with SMTP id i15so5213417vsd.10
        for <linux-kernel@vger.kernel.org>; Thu, 07 Mar 2019 11:28:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Po4Y3LvF/PyatrV7fJdN+mqG0B1DU+Pvrq+pWZeUIu4=;
        b=RgKW/5A6CtqC0jLByDN2rcr142CY0ZO78VWewTWA0nT0OUix/0nDysC/cNzJFtM7aP
         bYgfPO1KWczQI+MpvA3ByYzZVig8Az6xZ/OJ5Opkws0yW2nUUjh5MfIWdwE6RKpUmh6V
         KYqZfB3i334RI27kJ82Cg6xqL+MG3ZzaJRKSSfq8I0wUdWUslCa18piYeQGVm01WNuuj
         Jm8GfaQXVRqwkwdtaeadOI6Je/15Gw5RnlsZ8ilslzxo6k6zqfzc1uTDD2ao9K4YTVwK
         bzinl64yI66RJhXpiY6oTbJKSKU8vAs4aF8xSdUc0rKcsdjAXveBvnZcnOiXgCw4UdkW
         G+Xw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Po4Y3LvF/PyatrV7fJdN+mqG0B1DU+Pvrq+pWZeUIu4=;
        b=eUCEXwqj4p4W0iyOR6LcL0nUDTfARrHcRAvTbcVL6kuZeK2FNCsLJdfzqq6l7HqmpI
         ePsg53FwcWtNHVBNQ6btV4G3Src//vo5YIbWyzhtEwNzS2tqNGIM34vDaY9JnXomiTgJ
         tc19o7c1xiInz5WPA4LRbvEAbmZzCum3kbIU1t0Kp0EJytwiuCFG4Hs/H0Hrn7AuD4u2
         pBVr2Hjx4eHliWEPodW3L0pMUl1624PtmgorDzJ40dMsX1Pzd97sPP8pKYdwVTxX+fxu
         /fsT8C2Eoqv9YRp3NrF0QdJYTlfvJ3AVh/XDO/qHvpf3+7yEtilalwuhAR0r6b76EQaM
         rEoA==
X-Gm-Message-State: APjAAAWiXmRX6csbAQmv63+BJ494lCvWlDD8tYdCvoGAWzaiNIwjrWd0
        GJg0JAcqfytpy9Yw5rWSnK3ZAYgvT0B5q6bAcK593Q==
X-Google-Smtp-Source: APXvYqxNdLQpABXfYOm09ZsIBgEjHin7aJjIosWPj2jvoPMDmis3MwD5fY5nQ0RTg5kBU5w5FHTgEJFaxpW8hi+01L8=
X-Received: by 2002:a67:ff07:: with SMTP id v7mr7890235vsp.231.1551986918283;
 Thu, 07 Mar 2019 11:28:38 -0800 (PST)
MIME-Version: 1.0
References: <20190307185233.225521-1-eranian@google.com> <20190307190330.GA2443@redhat.com>
 <20190307190939.GB2482@worktop.programming.kicks-ass.net> <20190307192639.GC32240@kernel.org>
In-Reply-To: <20190307192639.GC32240@kernel.org>
From:   Stephane Eranian <eranian@google.com>
Date:   Thu, 7 Mar 2019 11:28:26 -0800
Message-ID: <CABPqkBTXAfYr4XkeFfUWBg9ygW2abWxmH79y9E-DbqLofS+mjw@mail.gmail.com>
Subject: Re: [PATCH] perf/core: restore mmap record type correctly
To:     Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Andi Kleen <ak@linux.intel.com>,
        Kan Liang <kan.liang@intel.com>,
        Ingo Molnar <mingo@kernel.org>, Jiri Olsa <jolsa@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 7, 2019 at 11:26 AM Arnaldo Carvalho de Melo
<arnaldo.melo@gmail.com> wrote:
>
> Em Thu, Mar 07, 2019 at 08:09:39PM +0100, Peter Zijlstra escreveu:
> > On Thu, Mar 07, 2019 at 04:03:30PM -0300, Arnaldo Carvalho de Melo wrote:
> > > Em Thu, Mar 07, 2019 at 10:52:33AM -0800, Stephane Eranian escreveu:
> > > > On mmap(), perf_events generates a RECORD_MMAP record and then checks
> > > > which events are interested in this record. There are currently 2 versions
> > > > of mmap records: RECORD_MMAP and RECORD_MMAP2. MMAP2 is larger. The event
> > > > configuration controls which version the user level tool accepts. If the
> > > > event->attr.mmap2=1 field then MMAP2 record is returned. The
> > > > perf_event_mmap_output() takes care of this. It checks attr->mmap2 and corrects
> > > > the record fields before putting it in the sampling buffer of the event.
> > > > At the end the function restores the modified MMAP record fields.
>
> > > > The problem is that the function restores the size but not the
> > > > type. Thus, if a subsequent event only accepts MMAP type, then it would
> > > > instead receive an MMAP2 record with a size of MMAP record.
>
> > > > This patch fixes the problem by restoring the record type on exit.
>
> > > Right, simple enough, bug fixed, Peter, I'm taking this one, ok?
>
> > Acked-by: Peter Zijlstra (Intel) <peterz@infradead.org>
>
> BTW, added:
>
>     Fixes: 13d7a2410fa6 ("perf: Add attr->mmap2 attribute to an event")
>
> For the stable guys to pick this up. Please try to add the fixes tag in
> the future.

Ok, thanks.

>
>
> Thanks,
>
> - Arnaldo

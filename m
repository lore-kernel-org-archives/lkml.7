Return-Path: <SRS0=7lyw=2D=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=0.3 required=3.0 tests=DATE_IN_PAST_03_06,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E8913C80D5C
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Dec 2019 20:41:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2EDBE2477D
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Dec 2019 20:41:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728921AbfLMTtR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 13 Dec 2019 14:49:17 -0500
Received: from mail-il1-f196.google.com ([209.85.166.196]:40591 "EHLO
        mail-il1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728767AbfLMTtR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Dec 2019 14:49:17 -0500
Received: by mail-il1-f196.google.com with SMTP id b15so401485ila.7
        for <linux-kernel@vger.kernel.org>; Fri, 13 Dec 2019 11:49:16 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ffeKAr9FEt+BapD0eGCkVotSx0EHlVWv8VkSOyObR5M=;
        b=C5SouFGpsVKnbh0S4yMDABScxYaaSIsQkILp35pmvaRhRZVBKfeZAxTAXzXdoEax+m
         KEdjLXD0/RQ+XxFWtO1/3rOVEc7XArwfFL2wAFcXt++2bxp0SbpQOP1SpH3KZvwPoIjk
         eRLU9rm0KrNK7+4/x3iCYlNLSnqpg53ZPjSnu9tVbzi3mEVAPsCf/hLlWC4A0Xt0H3xk
         5B8Y/V6VtzQ3q1pIDlonk9rKiuLJbn9Pl+MrtwFYmAFrw0tcedChroAj45rKTZFPJEY+
         XoyHsYI/7L07vSOkMEDHgGLlp6OyJOsr3gUUt7zj2stCD26fpz2MUmMrif8qiNxA41iI
         iNLw==
X-Gm-Message-State: APjAAAVigfEh5JCsZPvsrFHKrUC6cETq3QfE6tmLFfHls9K6FWXGJx5g
        ohSrYI+RjsRCofydwAlmPr9MZVglFn/uZP9D8As=
X-Google-Smtp-Source: APXvYqxEM5/FUQCGFw+CEJangWhJWu5VrEQMkYBZKKGon1PnfNjsz2DSikOipOG0l8z7phgHb1FBIZHxaZ8vR3866lM=
X-Received: by 2002:a92:bf08:: with SMTP id z8mr929365ilh.11.1576266556325;
 Fri, 13 Dec 2019 11:49:16 -0800 (PST)
MIME-Version: 1.0
References: <20191212145346.5026-1-emaste@freefall.freebsd.org> <20191212180213.GI13965@kernel.org>
In-Reply-To: <20191212180213.GI13965@kernel.org>
From:   Ed Maste <emaste@freebsd.org>
Date:   Fri, 13 Dec 2019 11:02:51 -0500
Message-ID: <CAPyFy2A5+ftfNFUKZeV=dx-3TMkupnL_oJhR6Pu0JOuKUjOBMA@mail.gmail.com>
Subject: Re: [PATCH] perf list: remove name from L1D_RO_EXCL_WRITES description
To:     Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>
Cc:     linux-kernel@vger.kernel.org,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Nick Hu <nickhu@andestech.com>,
        Greentime Hu <green.hu@gmail.com>,
        Vincent Chen <deanbo422@gmail.com>,
        Thomas Richter <tmricht@linux.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 12 Dec 2019 at 13:02, Arnaldo Carvalho de Melo
<arnaldo.melo@gmail.com> wrote:
>
> Em Thu, Dec 12, 2019 at 02:53:46PM +0000, Ed Maste escreveu:
> > From: Ed Maste <emaste@freebsd.org>
> >
> > In 7fcfa9a2d9 an unintended prefix "Counter:18 Name:" was removed from
> > the description for L1D_RO_EXCL_WRITES, but the extra name remained in
> > the description.  Remove it too.
>
> Also trivially correct, applied and added a Fixes tag with that cset
> (7fcfa9a2d9).
>
> - Arnaldo

Thank you, and sorry that these came not as a set. Each time I thought
I had only one change to submit and then found another nit shortly
after I sent the previous.

There is one more related change that hasn't been picked up yet (and
that I seem to have missed adding you on CC), with subject
[PATCH] perf vendor events s390: Fix commas so PMU event files are valid JSON

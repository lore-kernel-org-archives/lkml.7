Return-Path: <SRS0=uyI7=RK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C12C4C43381
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Mar 2019 19:26:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8A39B20840
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Mar 2019 19:26:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kSrli250"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726597AbfCGT0q (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 Mar 2019 14:26:46 -0500
Received: from mail-qt1-f194.google.com ([209.85.160.194]:33035 "EHLO
        mail-qt1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726207AbfCGT0p (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Mar 2019 14:26:45 -0500
Received: by mail-qt1-f194.google.com with SMTP id z39so18508802qtz.0
        for <linux-kernel@vger.kernel.org>; Thu, 07 Mar 2019 11:26:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=1ECZL/6jNpXi4CYh4Zb34bs84OJAMpygWEY4WobMUoU=;
        b=kSrli250pDd2qRsUiiFqvjcGP5odUalygKEeW16TNAypPQBEyd0+auB6zFB7zOw6l3
         dO7TsUL8jkeqQd11Q0+bm3bCfQr/L7pFx6iC+cBl+fvwyazLQ3kdpfigtIem1IFjYEAH
         jEbY1UEHgSFRpsNQ50CeoAyeWSQNQColujClyaThn4QyQmb3cJxhW7K6x54+pwjH3IIt
         c2PP6XjUmUTh85DuUkM9mcyycYB7yhjVSOJw2XKP5DVQ0LttoZIsRFWvhBYgzcqqzQxJ
         yBUEkk3dx3fLsz8RvjdVeFnA0TtrDjixxyca4hi8qhR7pwPYyHf7PaSdX+ju/Rcudqgx
         C7TQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=1ECZL/6jNpXi4CYh4Zb34bs84OJAMpygWEY4WobMUoU=;
        b=YNfKg7Y333K82ZZX82ho8UTscU4drbtWkuXYP8c8wix68Cckp3HfsqowDuunbgx3+y
         s5hVJbTVOiZQG9DCNP/uRSnE5m2RoFYGwVrgXUZ0JrOMDx8+eg1fgMROaCRiOk6QQIg7
         kcXLkmRGAKTa1OFkl6gJGUUcJPyKTSNGhlpUpC54gY90vc/qrwHpgto8138gjoubgcxQ
         8UidUHc0YbyAtD5mc5wrRMXFvXnVKe/MgGkZm0Gd71JhxpT4IqKt+1ebbyPwS0MmBLKx
         mVcKGS46mX4mOWxs0gksYTDgo248BTfYfqd6xEnXb97nJxURESxByvK/F8ol3E0DQxYz
         ofww==
X-Gm-Message-State: APjAAAVlbkTxtxCRVjIw92c5cY6hN/BIS5L+f+CuI3joBrqF1kZTzlWG
        M0w7bCKtC7Q/fJPy6QwWbN0f3A/46cQ=
X-Google-Smtp-Source: APXvYqyyG5EFed6BTMWjiJWk7i/uP5D3rQSb2ZUCYoPtwkvQ1PRlN/2G8kQUyauS/ZfQfEmeXLnbuA==
X-Received: by 2002:ac8:3718:: with SMTP id o24mr11609105qtb.2.1551986803879;
        Thu, 07 Mar 2019 11:26:43 -0800 (PST)
Received: from quaco.ghostprotocols.net ([190.15.121.82])
        by smtp.gmail.com with ESMTPSA id w1sm3232806qtc.75.2019.03.07.11.26.42
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 07 Mar 2019 11:26:43 -0800 (PST)
From:   Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>
X-Google-Original-From: Arnaldo Carvalho de Melo <acme@kernel.org>
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id BC3434039C; Thu,  7 Mar 2019 16:26:39 -0300 (-03)
Date:   Thu, 7 Mar 2019 16:26:39 -0300
To:     Stephane Eranian <eranian@google.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Andi Kleen <ak@linux.intel.com>,
        Kan Liang <kan.liang@intel.com>,
        Ingo Molnar <mingo@kernel.org>, Jiri Olsa <jolsa@kernel.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] perf/core: restore mmap record type correctly
Message-ID: <20190307192639.GC32240@kernel.org>
References: <20190307185233.225521-1-eranian@google.com>
 <20190307190330.GA2443@redhat.com>
 <20190307190939.GB2482@worktop.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190307190939.GB2482@worktop.programming.kicks-ass.net>
X-Url:  http://acmel.wordpress.com
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Thu, Mar 07, 2019 at 08:09:39PM +0100, Peter Zijlstra escreveu:
> On Thu, Mar 07, 2019 at 04:03:30PM -0300, Arnaldo Carvalho de Melo wrote:
> > Em Thu, Mar 07, 2019 at 10:52:33AM -0800, Stephane Eranian escreveu:
> > > On mmap(), perf_events generates a RECORD_MMAP record and then checks
> > > which events are interested in this record. There are currently 2 versions
> > > of mmap records: RECORD_MMAP and RECORD_MMAP2. MMAP2 is larger. The event
> > > configuration controls which version the user level tool accepts. If the
> > > event->attr.mmap2=1 field then MMAP2 record is returned. The
> > > perf_event_mmap_output() takes care of this. It checks attr->mmap2 and corrects
> > > the record fields before putting it in the sampling buffer of the event.
> > > At the end the function restores the modified MMAP record fields.

> > > The problem is that the function restores the size but not the
> > > type. Thus, if a subsequent event only accepts MMAP type, then it would
> > > instead receive an MMAP2 record with a size of MMAP record.

> > > This patch fixes the problem by restoring the record type on exit.

> > Right, simple enough, bug fixed, Peter, I'm taking this one, ok?
 
> Acked-by: Peter Zijlstra (Intel) <peterz@infradead.org>

BTW, added:

    Fixes: 13d7a2410fa6 ("perf: Add attr->mmap2 attribute to an event")

For the stable guys to pick this up. Please try to add the fixes tag in
the future.

Thanks,

- Arnaldo

Return-Path: <SRS0=uyI7=RK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2960CC43381
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Mar 2019 19:09:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E73E420675
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Mar 2019 19:09:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="dcODIuvO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726734AbfCGTJ5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 Mar 2019 14:09:57 -0500
Received: from merlin.infradead.org ([205.233.59.134]:55734 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726536AbfCGTJx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Mar 2019 14:09:53 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=mxFlzTNt3wJiRaEad4nwKcFwdG2EvyPx7miWRqpY+lY=; b=dcODIuvO1gM+8iDwQPBYpKQqX
        ihXzhuX2dgRjoE16OnDOi1kobh796TZx6SyX2RVY5FN8lLrunxMZIqMU91ZdsP7mHrGIXmVH6hEnW
        ItSQEyTeAtTjyZ8lHmk0WpXL3Z13z51EGLB/8CAG8/VstMvxRZKQZD++n1kyT+nbJcBDtsbnPM4DE
        d+XXE7yxhT512scbREIZBwwWE7Pw1qvaAF75NVJJt63Hirl8oqTIaioA9ERz/IZj3waIOZIcE7Kv9
        svRn30bqR6Cx1+gmW/XXLdTEV/U/iZTIYG0WJ/M2QLjErp0ipNtkJY/ygeASheAfEBTzHvC3SfHr2
        NUZG+iBow==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=worktop.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1h1yOj-0000l6-PR; Thu, 07 Mar 2019 19:09:42 +0000
Received: by worktop.programming.kicks-ass.net (Postfix, from userid 1000)
        id D59049837F2; Thu,  7 Mar 2019 20:09:39 +0100 (CET)
Date:   Thu, 7 Mar 2019 20:09:39 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Arnaldo Carvalho de Melo <acme@redhat.com>
Cc:     Stephane Eranian <eranian@google.com>,
        linux-kernel@vger.kernel.org, ak@linux.intel.com,
        kan.liang@intel.com, mingo@elte.hu, jolsa@redhat.com,
        acme@kernel.org
Subject: Re: [PATCH] perf/core: restore mmap record type correctly
Message-ID: <20190307190939.GB2482@worktop.programming.kicks-ass.net>
References: <20190307185233.225521-1-eranian@google.com>
 <20190307190330.GA2443@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190307190330.GA2443@redhat.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 07, 2019 at 04:03:30PM -0300, Arnaldo Carvalho de Melo wrote:
> Em Thu, Mar 07, 2019 at 10:52:33AM -0800, Stephane Eranian escreveu:
> > On mmap(), perf_events generates a RECORD_MMAP record and then checks
> > which events are interested in this record. There are currently 2 versions
> > of mmap records: RECORD_MMAP and RECORD_MMAP2. MMAP2 is larger. The event
> > configuration controls which version the user level tool accepts. If the
> > event->attr.mmap2=1 field then MMAP2 record is returned. The
> > perf_event_mmap_output() takes care of this. It checks attr->mmap2 and corrects
> > the record fields before putting it in the sampling buffer of the event.
> > At the end the function restores the modified MMAP record fields.
> > 
> > The problem is that the function restores the size but not the
> > type. Thus, if a subsequent event only accepts MMAP type, then it would
> > instead receive an MMAP2 record with a size of MMAP record.
> > 
> > This patch fixes the problem by restoring the record type on exit.
> 
> Right, simple enough, bug fixed, Peter, I'm taking this one, ok?

Acked-by: Peter Zijlstra (Intel) <peterz@infradead.org>

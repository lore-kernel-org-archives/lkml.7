Return-Path: <SRS0=GgR0=RR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A44B1C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Mar 2019 09:01:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 762C72184E
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Mar 2019 09:01:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727297AbfCNJBb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Mar 2019 05:01:31 -0400
Received: from mx1.redhat.com ([209.132.183.28]:47718 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726284AbfCNJBa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Mar 2019 05:01:30 -0400
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 8E714C02490E;
        Thu, 14 Mar 2019 09:01:30 +0000 (UTC)
Received: from krava (unknown [10.43.17.124])
        by smtp.corp.redhat.com (Postfix) with SMTP id D2C4E60F87;
        Thu, 14 Mar 2019 09:01:28 +0000 (UTC)
Date:   Thu, 14 Mar 2019 10:01:28 +0100
From:   Jiri Olsa <jolsa@redhat.com>
To:     Alexey Budankov <alexey.budankov@linux.intel.com>
Cc:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Andi Kleen <ak@linux.intel.com>,
        linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v7 10/12] perf report: implement record trace
 decompression
Message-ID: <20190314090128.GA4406@krava>
References: <5f3a8326-58a0-816e-ad61-31c111232c7a@linux.intel.com>
 <54b3c3c8-2b7e-e7ba-d55e-d15cc5983ced@linux.intel.com>
 <20190313143719.GF6676@krava>
 <fee1ca34-eaa4-75c4-60bb-72a7b18fdd1a@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <fee1ca34-eaa4-75c4-60bb-72a7b18fdd1a@linux.intel.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.32]); Thu, 14 Mar 2019 09:01:30 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 13, 2019 at 06:55:29PM +0300, Alexey Budankov wrote:
> 
> On 13.03.2019 17:37, Jiri Olsa wrote:
> > On Tue, Mar 12, 2019 at 08:36:18AM +0300, Alexey Budankov wrote:
> > 
> > SBIP
> > 
> >> +#ifdef HAVE_ZSTD_SUPPORT
> >> +static int perf_session__process_compressed_event(struct perf_session *session,
> >> +					union perf_event *event, u64 file_offset)
> >> +{
> >> +	void *src;
> >> +	size_t decomp_size, src_size;
> >> +	u64 decomp_last_rem = 0;
> >> +	size_t decomp_len = session->header.env.comp_mmap_len;
> >> +	struct decomp *decomp, *decomp_last = session->decomp_last;
> >> +
> >> +	decomp = mmap(NULL, sizeof(struct decomp) + decomp_len, PROT_READ|PROT_WRITE,
> >> +		      MAP_ANONYMOUS|MAP_PRIVATE, -1, 0);
> >> +	if (decomp == MAP_FAILED) {
> >> +		pr_err("Couldn't allocate memory for decompression\n");
> >> +		return -1;
> >> +	}
> > 
> > ok, I see the need to keep this decomp around, we need the event
> > to be there the whole time, like the mmap for the standard events
> > 
> > we know the total uncompressed size when record is done, right?
> > could we save it in the COMPRESSED feature and alloc all the
> > needed uncompressed data in single mmap?
> 
> It can be not that good idea. The required contiguous memory 
> region can be really huge to be allocated. Plain malloc()'s are 
> also not good. I was observing OOM in perf report process when 
> loading traces of several GiBs. So smaller, page size granularity,
> linked memory regions performed the best in my experiments.

ok

jirka

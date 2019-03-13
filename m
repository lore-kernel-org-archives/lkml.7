Return-Path: <SRS0=dUEL=RQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 34897C43381
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Mar 2019 14:36:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0871B2147C
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Mar 2019 14:36:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726688AbfCMOgy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Mar 2019 10:36:54 -0400
Received: from mx1.redhat.com ([209.132.183.28]:29524 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725856AbfCMOgx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Mar 2019 10:36:53 -0400
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id C0836C066448;
        Wed, 13 Mar 2019 14:36:53 +0000 (UTC)
Received: from krava (unknown [10.43.17.124])
        by smtp.corp.redhat.com (Postfix) with SMTP id 18B3760FD6;
        Wed, 13 Mar 2019 14:36:51 +0000 (UTC)
Date:   Wed, 13 Mar 2019 15:36:51 +0100
From:   Jiri Olsa <jolsa@redhat.com>
To:     Alexey Budankov <alexey.budankov@linux.intel.com>
Cc:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Andi Kleen <ak@linux.intel.com>,
        linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v7 08/12] perf record: implement compression for AIO
 trace streaming
Message-ID: <20190313143651.GA6676@krava>
References: <5f3a8326-58a0-816e-ad61-31c111232c7a@linux.intel.com>
 <618f7b8b-015b-d67e-9ef4-dc7aa0d2cd62@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <618f7b8b-015b-d67e-9ef4-dc7aa0d2cd62@linux.intel.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.31]); Wed, 13 Mar 2019 14:36:53 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 12, 2019 at 08:30:13AM +0300, Alexey Budankov wrote:

SNIP

> -
> -	md->prev = head;
> -	perf_mmap__consume(md);
> -
> -	rc = push(to, &md->aio.cblocks[idx], md->aio.data[idx], size0 + size, *off);
> -	if (!rc) {
> -		*off += size0 + size;
> -	} else {
> -		/*
> -		 * Decrement md->refcount back if aio write
> -		 * operation failed to start.
> -		 */
> -		perf_mmap__put(md);
> -	}
> -
> -	return rc;
> -}
>  #else /* !HAVE_AIO_SUPPORT */
>  static int perf_mmap__aio_enabled(struct perf_mmap *map __maybe_unused)
>  {
> @@ -566,7 +492,7 @@ int perf_mmap__push(struct perf_mmap *md, void *to,
>  
>  	rc = perf_mmap__read_init(md);
>  	if (rc < 0)
> -		return (rc == -EAGAIN) ? 0 : -1;
> +		return (rc == -EAGAIN) ? 1 : -1;

hum, should this be in part of this one?

  perf record: implement -f,--mmap-flush=<threshold> option


jirka

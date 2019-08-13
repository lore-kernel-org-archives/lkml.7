Return-Path: <SRS0=Ecng=WJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C0CCBC433FF
	for <linux-kernel@archiver.kernel.org>; Tue, 13 Aug 2019 15:33:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 93B9620644
	for <linux-kernel@archiver.kernel.org>; Tue, 13 Aug 2019 15:33:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729128AbfHMPde (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 13 Aug 2019 11:33:34 -0400
Received: from mx1.redhat.com ([209.132.183.28]:38416 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728226AbfHMPde (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Aug 2019 11:33:34 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 2E3A730832DC;
        Tue, 13 Aug 2019 15:33:34 +0000 (UTC)
Received: from sandy.ghostprotocols.net (ovpn-112-35.phx2.redhat.com [10.3.112.35])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id A735F80FD6;
        Tue, 13 Aug 2019 15:33:33 +0000 (UTC)
Received: by sandy.ghostprotocols.net (Postfix, from userid 1000)
        id CAE4411E7; Tue, 13 Aug 2019 12:33:30 -0300 (BRT)
Date:   Tue, 13 Aug 2019 12:33:30 -0300
From:   Arnaldo Carvalho de Melo <acme@redhat.com>
To:     Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc:     Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Ingo Molnar <mingo@redhat.com>, linux-kernel@vger.kernel.org,
        Adrian Hunter <adrian.hunter@intel.com>, acme@kernel.org
Subject: Re: [PATCH v1] perf record: Add an option to take an AUX snapshot on
 exit
Message-ID: <20190813153330.GF2142@redhat.com>
References: <20190806144101.62892-1-alexander.shishkin@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190806144101.62892-1-alexander.shishkin@linux.intel.com>
X-Url:  http://acmel.wordpress.com
User-Agent: Mutt/1.5.20 (2009-12-10)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.44]); Tue, 13 Aug 2019 15:33:34 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Tue, Aug 06, 2019 at 05:41:01PM +0300, Alexander Shishkin escreveu:
> It is sometimes useful to generate a snapshot when perf record exits;
> I've been using a wrapper script around the workload that would do a
> killall -USR2 perf when the workload exits.
> 
> @@ -654,7 +670,7 @@ int record__auxtrace_mmap_read(struct record *rec __maybe_unused,
>  }
>  
>  static inline
> -void record__read_auxtrace_snapshot(struct record *rec __maybe_unused)
> +void record__read_auxtrace_snapshot(struct record *rec __maybe_unused, bool on_exit)

You forgot to add the __maybe_unused for the on_exit and later for the
'rec' in record__auxtrace_snapshot_exit, which causes the build to fail
when auxtrace isn't being built, I've fixed those.

- Arnaldo

>  {
>  }
>  
> @@ -664,6 +680,12 @@ int auxtrace_record__snapshot_start(struct auxtrace_record *itr __maybe_unused)
>  	return 0;
>  }
>  
> +static inline
> +int record__auxtrace_snapshot_exit(struct record *rec)
> +{
> +	return 0;
> +}
> +
>  static int record__auxtrace_init(struct record *rec __maybe_unused)
>  {
>  	return 0;
> @@ -1536,7 +1558,7 @@ static int __cmd_record(struct record *rec, int argc, const char **argv)

Return-Path: <SRS0=wAGj=US=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 98EC1C31E49
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Jun 2019 12:31:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6FFF92147A
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Jun 2019 12:31:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1560947498;
	bh=zYSek47GtRxIiyiTqpLwRIT0/soRvhGEvD4P78UzuQw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=1TvTa+8fQbHoVCAVk1A9QKbGsi4++yKSPb3f86Ea5gszmVsVqDprK5J571J5hhzCl
	 /pKR+UZZ8WjoskCpPdXbH5Sqpdk3ggMtNG5VSmtDETtyp7C+LXyBu2qh9NB5RytD5I
	 cro6a4IIM9+wuUV47wpV7JXmyGhweH72jcjQUQIs=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732028AbfFSMbh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Jun 2019 08:31:37 -0400
Received: from mail.kernel.org ([198.145.29.99]:58524 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731999AbfFSMbc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Jun 2019 08:31:32 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7683421655;
        Wed, 19 Jun 2019 12:31:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1560947491;
        bh=zYSek47GtRxIiyiTqpLwRIT0/soRvhGEvD4P78UzuQw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=FLJRZqKfP9LmIP/EJ7sG7OmLlB7qDHKBHV9DTDHTnEvBy67DUYJjeIm7Tstzia2uk
         s0hi8spx8K9FpufwIP5atMokVINriGXENZd2PH/X5AbP4FCvpETXXF2MT7LPVF2ifw
         y7o2c54pnFsYazeirvm6XGW9Z/ZY3IZiyYg6wQJQ=
Date:   Wed, 19 Jun 2019 14:31:28 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     "Rantala, Tommi T. (Nokia - FI/Espoo)" <tommi.t.rantala@nokia.com>
Cc:     "stable@vger.kernel.org" <stable@vger.kernel.org>,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 4.14] perf machine: Guard against NULL in machine__exit()
Message-ID: <20190619123128.GA23334@kroah.com>
References: <20190619120030.6099-1-tommi.t.rantala@nokia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190619120030.6099-1-tommi.t.rantala@nokia.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 19, 2019 at 12:00:46PM +0000, Rantala, Tommi T. (Nokia - FI/Espoo) wrote:
> From: Arnaldo Carvalho de Melo <acme@redhat.com>
> 
> commit 4a2233b194c77ae1ea8304cb7c00b551de4313f0 upstream.
> 
> A recent fix for 'perf trace' introduced a bug where
> machine__exit(trace->host) could be called while trace->host was still
> NULL, so make this more robust by guarding against NULL, just like
> free() does.
> 
> The problem happens, for instance, when !root users try to run 'perf
> trace':
> 
>   [acme@jouet linux]$ trace
>   Error:	No permissions to read /sys/kernel/debug/tracing/events/raw_syscalls/sys_(enter|exit)
>   Hint:	Try 'sudo mount -o remount,mode=755 /sys/kernel/debug/tracing'
> 
>   perf: Segmentation fault
>   Obtained 7 stack frames.
>   [0x4f1b2e]
>   /lib64/libc.so.6(+0x3671f) [0x7f43a1dd971f]
>   [0x4f3fec]
>   [0x47468b]
>   [0x42a2db]
>   /lib64/libc.so.6(__libc_start_main+0xe9) [0x7f43a1dc3509]
>   [0x42a6c9]
>   Segmentation fault (core dumped)
>   [acme@jouet linux]$
> 
> Cc: Adrian Hunter <adrian.hunter@intel.com>
> Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
> Cc: Andrei Vagin <avagin@openvz.org>
> Cc: David Ahern <dsahern@gmail.com>
> Cc: Jiri Olsa <jolsa@kernel.org>
> Cc: Namhyung Kim <namhyung@kernel.org>
> Cc: Peter Zijlstra <peterz@infradead.org>
> Cc: Vasily Averin <vvs@virtuozzo.com>
> Cc: Wang Nan <wangnan0@huawei.com>
> Fixes: 33974a414ce2 ("perf trace: Call machine__exit() at exit")
> Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
> Signed-off-by: Tommi Rantala <tommi.t.rantala@nokia.com>
> ---
>  tools/perf/util/machine.c | 3 +++
>  1 file changed, 3 insertions(+)

Now applied, thanks.

greg k-h

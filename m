Return-Path: <SRS0=91bA=RH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 59812C43381
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Mar 2019 14:48:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2F0E220815
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Mar 2019 14:48:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726990AbfCDOsO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 Mar 2019 09:48:14 -0500
Received: from mx1.redhat.com ([209.132.183.28]:33860 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726111AbfCDOsO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Mar 2019 09:48:14 -0500
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 2345D7F7B2;
        Mon,  4 Mar 2019 14:48:14 +0000 (UTC)
Received: from krava (unknown [10.43.17.112])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 8880560145;
        Mon,  4 Mar 2019 14:48:12 +0000 (UTC)
Date:   Mon, 4 Mar 2019 15:48:12 +0100
From:   Jiri Olsa <jolsa@redhat.com>
To:     Andi Kleen <andi@firstfloor.org>
Cc:     acme@kernel.org, jolsa@kernel.org,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
        Andi Kleen <ak@linux.intel.com>
Subject: Re: [PATCH v3 10/11] perf tools report: Implement browsing of
 individual samples
Message-ID: <20190304144812.GG30476@krava>
References: <20190228183550.14126-1-andi@firstfloor.org>
 <20190228183550.14126-11-andi@firstfloor.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20190228183550.14126-11-andi@firstfloor.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.28]); Mon, 04 Mar 2019 14:48:14 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 28, 2019 at 10:35:49AM -0800, Andi Kleen wrote:
> From: Andi Kleen <ak@linux.intel.com>
> 
> Now report can show whole time periods with perf script,
> but the user still has to find individual samples of interest
> manually.
> 
> It would be expensive and complicated to search for the
> right samples in the whole perf file. Typically users
> only need to look at a small number of samples for useful
> analysis.
> 
> Also the full scripts tend to show samples of all CPUs and all
> threads mixed up, which can be very confusing on larger systems.
> 
> Add a new --samples option to save a small random number of samples
> per hist entry
> 
> Use a reservoir sample technique to select a representatve
> number of samples.
> 
> Then allow browsing the samples using perf script
> as part of the hist entry context menu. This automatically
> adds the right filters, so only the thread or cpu of the sample
> is displayed. Then we use less' search functionality
> to directly jump the to the time stamp of the selected
> sample.

when I choose:

148156.305096328: CPU 0 tid 16402                                                                                                                                                                                  ▒

I'm getting:

 sched-messaging 16402 [000] 148156.305096328:     886205 cycles:ppp:  ffffffff93a001ad syscall_return_via_sysret+0xbc ([kernel.kallsyms])
 sched-messaging 16402 [000] 148156.305344526:     887134 cycles:ppp:  ffffffff933f8c7d avc_has_perm+0xcd ([kernel.kallsyms])
 sched-messaging 16402 [000] 148156.305594286:     888614 cycles:ppp:  ffffffff93208a02 stackleak_erase+0xa2 ([kernel.kallsyms])
 sched-messaging 16402 [000] 148156.305843034:     888750 cycles:ppp:  ffffffff93986d30 _raw_spin_lock+0x10 ([kernel.kallsyms])
 sched-messaging 16402 [000] 148156.306091824:     889265 cycles:ppp:  ffffffff932c623e __vfs_write+0xbe ([kernel.kallsyms])
 sched-messaging 16402 [000] 148156.306340739:     889802 cycles:ppp:  ffffffff937eaee4 skb_set_owner_w+0x54 ([kernel.kallsyms])
 sched-messaging 16402 [000] 148156.306590950:     890449 cycles:ppp:  ffffffff93291e33 __kmalloc_node_track_caller+0xc3 ([kernel.kallsyms])
 sched-messaging 16402 [000] 148156.306840144:     890348 cycles:ppp:  ffffffff932089a9 stackleak_erase+0x49 ([kernel.kallsyms])
 sched-messaging 16402 [000] 148156.307089348:     890707 cycles:ppp:  ffffffff932e60e6 __fget_light+0x46 ([kernel.kallsyms])
 sched-messaging 16402 [000] 148156.307338691:     891063 cycles:ppp:  ffffffff938ed2a3 unix_stream_sendmsg+0x213 ([kernel.kallsyms])
 sched-messaging 16402 [001] 148156.323855201:     916081 cycles:ppp:  ffffffff93208a05 stackleak_erase+0xa5 ([kernel.kallsyms])
 sched-messaging 16402 [001] 148156.324104737:     916330 cycles:ppp:  ffffffff93986d30 _raw_spin_lock+0x10 ([kernel.kallsyms])
 sched-messaging 16402 [001] 148156.324354188:     916467 cycles:ppp:  ffffffff9324192f kmalloc_slab+0x4f ([kernel.kallsyms])
 systemd-journal   882 [005] 148156.373698788: PERF_RECORD_FORK(882:16422):(882:882)
 systemd-journal   882 [005] 148156.373718699: PERF_RECORD_FORK(882:16423):(882:882)
 journal-offline 16422 [002] 148156.373720344: PERF_RECORD_COMM: journal-offline:882/16422
 journal-offline 16423 [005] 148156.373766480: PERF_RECORD_COMM: journal-offline:882/16423
 journal-offline 16423 [005] 148156.385947319: PERF_RECORD_EXIT(882:16423):(882:16423)
 systemd-journal   882 [002] 148156.386052146: PERF_RECORD_FORK(882:16424):(882:882)
 journal-offline 16424 [001] 148156.386069865: PERF_RECORD_COMM: journal-offline:882/16424
 journal-offline 16422 [002] 148156.386132447: PERF_RECORD_EXIT(882:16422):(882:16422)
 journal-offline 16424 [001] 148156.389171176: PERF_RECORD_EXIT(882:16424):(882:16424)
 systemd-journal   882 [002] 148156.389263406: PERF_RECORD_FORK(882:16425):(882:882)


some other cpus and threads mixed in

jirka

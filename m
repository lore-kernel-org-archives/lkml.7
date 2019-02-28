Return-Path: <SRS0=g5d9=RD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8AE43C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Feb 2019 11:28:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 61C6F2171F
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Feb 2019 11:28:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732557AbfB1L2m (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Feb 2019 06:28:42 -0500
Received: from mx1.redhat.com ([209.132.183.28]:43276 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726027AbfB1L2m (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Feb 2019 06:28:42 -0500
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id F016B4CE87;
        Thu, 28 Feb 2019 11:28:41 +0000 (UTC)
Received: from krava (unknown [10.43.17.18])
        by smtp.corp.redhat.com (Postfix) with SMTP id AF8A2620AD;
        Thu, 28 Feb 2019 11:28:39 +0000 (UTC)
Date:   Thu, 28 Feb 2019 12:28:38 +0100
From:   Jiri Olsa <jolsa@redhat.com>
To:     Wei Li <liwei391@huawei.com>
Cc:     jolsa@kernel.org, alexander.shishkin@linux.intel.com,
        dsahern@gmail.com, namhyung@kernel.org, peterz@infradead.org,
        acme@redhat.com, linux-kernel@vger.kernel.org,
        kim.phillips@arm.com, guohanjun@huawei.com, huawei.libin@huawei.com
Subject: Re: [PATCH] perf machine: Update kernel map address and re-order
 properly
Message-ID: <20190228112838.GC18636@krava>
References: <20190228092003.34071-1-liwei391@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190228092003.34071-1-liwei391@huawei.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.30]); Thu, 28 Feb 2019 11:28:42 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 28, 2019 at 05:20:03PM +0800, Wei Li wrote:
> Since commit 1fb87b8e9599 ("perf machine: Don't search for active kernel
> start in __machine__create_kernel_maps"), the __machine__create_kernel_maps()
> just create a map what start and end are both zero. Though the address will be
> updated later, the order of map in the rbtree may be incorrect.
> 
> The commit ee05d21791db ("perf machine: Set main kernel end address properly")
> fixed the logic in machine__create_kernel_maps(), but it's still wrong in
> function machine__process_kernel_mmap_event().
> 
> To reproduce this issue, we need an environment which the module address
> is before the kernel text segment. I tested it on an aarch64 machine with
> kernel 4.19.25:

so that was the missing piece.. nice

> 
> [root@localhost hulk]# grep _stext /proc/kallsyms 
> ffff000008081000 T _stext
> [root@localhost hulk]# grep _etext /proc/kallsyms 
> ffff000009780000 R _etext
> [root@localhost hulk]# tail /proc/modules 
> hisi_sas_v2_hw 77824 0 - Live 0xffff00000191d000
> nvme_core 126976 7 nvme, Live 0xffff0000018b6000
> mdio 20480 1 ixgbe, Live 0xffff0000018ab000
> hisi_sas_main 106496 1 hisi_sas_v2_hw, Live 0xffff000001861000
> hns_mdio 20480 2 - Live 0xffff000001822000
> hnae 28672 3 hns_dsaf,hns_enet_drv, Live 0xffff000001815000
> dm_mirror 40960 0 - Live 0xffff000001804000
> dm_region_hash 32768 1 dm_mirror, Live 0xffff0000017f5000
> dm_log 32768 2 dm_mirror,dm_region_hash, Live 0xffff0000017e7000
> dm_mod 315392 17 dm_mirror,dm_log, Live 0xffff000001780000
> [root@localhost hulk]# 
> 
> Before fix:
> 
> [root@localhost bin]# perf record sleep 3
> [ perf record: Woken up 1 times to write data ]
> [ perf record: Captured and wrote 0.011 MB perf.data (9 samples) ]
> [root@localhost bin]# perf buildid-list -i perf.data 
> 4c4e46c971ca935f781e603a09b52a92e8bdfee8 [vdso]
> [root@localhost bin]# perf buildid-list -i perf.data -H
> 0000000000000000000000000000000000000000 /proc/kcore
> [root@localhost bin]# 
> 
> After fix:
> 
> [root@localhost tools]# ./perf/perf record sleep 3
> [ perf record: Woken up 1 times to write data ]
> [ perf record: Captured and wrote 0.011 MB perf.data (9 samples) ]
> [root@localhost tools]# ./perf/perf buildid-list -i perf.data 
> 28a6c690262896dbd1b5e1011ed81623e6db0610 [kernel.kallsyms]
> 106c14ce6e4acea3453e484dc604d66666f08a2f [vdso]
> [root@localhost tools]# ./perf/perf buildid-list -i perf.data -H
> 28a6c690262896dbd1b5e1011ed81623e6db0610 /proc/kcore
> 
> Signed-off-by: Wei Li <liwei391@huawei.com>

Acked-by: Jiri Olsa <jolsa@kernel.org>

good catch, thanks
jirka

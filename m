Return-Path: <SRS0=4nbc=R5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 30888C43381
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Mar 2019 18:20:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0C05520823
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Mar 2019 18:20:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732535AbfCZST6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Mar 2019 14:19:58 -0400
Received: from mx1.redhat.com ([209.132.183.28]:33958 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732064AbfCZST6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Mar 2019 14:19:58 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 9ADDF3086226;
        Tue, 26 Mar 2019 18:19:57 +0000 (UTC)
Received: from sandy.ghostprotocols.net (ovpn-112-27.phx2.redhat.com [10.3.112.27])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id F084E18948;
        Tue, 26 Mar 2019 18:19:56 +0000 (UTC)
Received: by sandy.ghostprotocols.net (Postfix, from userid 1000)
        id A7C6655CF; Tue, 26 Mar 2019 15:19:53 -0300 (BRT)
Date:   Tue, 26 Mar 2019 15:19:53 -0300
From:   Arnaldo Carvalho de Melo <acme@redhat.com>
To:     Namhyung Kim <namhyung@kernel.org>
Cc:     "liwei (GF)" <liwei391@huawei.com>, Jiri Olsa <jolsa@redhat.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        David Ahern <dsahern@gmail.com>,
        Peter Zijlstra <peterz@infradead.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Kim Phillips <kim.phillips@arm.com>, guohanjun@huawei.com,
        Li Bin <huawei.libin@huawei.com>
Subject: Re: [PATCH] perf machine: Update kernel map address and re-order
 properly
Message-ID: <20190326181953.GD2132@redhat.com>
References: <20190228092003.34071-1-liwei391@huawei.com>
 <20190228112838.GC18636@krava>
 <16b9191e-c444-8bdc-d23b-c4267440b3f2@huawei.com>
 <CAM9d7cjkp-NKVg9ktm6OkVn_tkrnHEP=_7muBHu1k-stxwYdOQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAM9d7cjkp-NKVg9ktm6OkVn_tkrnHEP=_7muBHu1k-stxwYdOQ@mail.gmail.com>
X-Url:  http://acmel.wordpress.com
User-Agent: Mutt/1.5.20 (2009-12-10)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.42]); Tue, 26 Mar 2019 18:19:57 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Tue, Mar 26, 2019 at 11:03:14PM +0900, Namhyung Kim escreveu:
> Hello,
> 
> On Tue, Mar 26, 2019 at 6:12 PM liwei (GF) <liwei391@huawei.com> wrote:
> >
> > Hi Arnaldo,
> >
> > Please shoot a glance at this modification, i think this issue is influential.
> >
> > On 2019/2/28 19:28, Jiri Olsa Wrote:
> > > On Thu, Feb 28, 2019 at 05:20:03PM +0800, Wei Li wrote:
> > >> Since commit 1fb87b8e9599 ("perf machine: Don't search for active kernel
> > >> start in __machine__create_kernel_maps"), the __machine__create_kernel_maps()
> > >> just create a map what start and end are both zero. Though the address will be
> > >> updated later, the order of map in the rbtree may be incorrect.
> > >>
> > >> The commit ee05d21791db ("perf machine: Set main kernel end address properly")
> > >> fixed the logic in machine__create_kernel_maps(), but it's still wrong in
> > >> function machine__process_kernel_mmap_event().
> > >>
> > >> To reproduce this issue, we need an environment which the module address
> > >> is before the kernel text segment. I tested it on an aarch64 machine with
> > >> kernel 4.19.25:
> > >
> > > so that was the missing piece.. nice
> > >
> > >>
> > >> [root@localhost hulk]# grep _stext /proc/kallsyms
> > >> ffff000008081000 T _stext
> > >> [root@localhost hulk]# grep _etext /proc/kallsyms
> > >> ffff000009780000 R _etext
> > >> [root@localhost hulk]# tail /proc/modules
> > >> hisi_sas_v2_hw 77824 0 - Live 0xffff00000191d000
> > >> nvme_core 126976 7 nvme, Live 0xffff0000018b6000
> > >> mdio 20480 1 ixgbe, Live 0xffff0000018ab000
> > >> hisi_sas_main 106496 1 hisi_sas_v2_hw, Live 0xffff000001861000
> > >> hns_mdio 20480 2 - Live 0xffff000001822000
> > >> hnae 28672 3 hns_dsaf,hns_enet_drv, Live 0xffff000001815000
> > >> dm_mirror 40960 0 - Live 0xffff000001804000
> > >> dm_region_hash 32768 1 dm_mirror, Live 0xffff0000017f5000
> > >> dm_log 32768 2 dm_mirror,dm_region_hash, Live 0xffff0000017e7000
> > >> dm_mod 315392 17 dm_mirror,dm_log, Live 0xffff000001780000
> > >> [root@localhost hulk]#
> > >>
> > >> Before fix:
> > >>
> > >> [root@localhost bin]# perf record sleep 3
> > >> [ perf record: Woken up 1 times to write data ]
> > >> [ perf record: Captured and wrote 0.011 MB perf.data (9 samples) ]
> > >> [root@localhost bin]# perf buildid-list -i perf.data
> > >> 4c4e46c971ca935f781e603a09b52a92e8bdfee8 [vdso]
> > >> [root@localhost bin]# perf buildid-list -i perf.data -H
> > >> 0000000000000000000000000000000000000000 /proc/kcore
> > >> [root@localhost bin]#
> > >>
> > >> After fix:
> > >>
> > >> [root@localhost tools]# ./perf/perf record sleep 3
> > >> [ perf record: Woken up 1 times to write data ]
> > >> [ perf record: Captured and wrote 0.011 MB perf.data (9 samples) ]
> > >> [root@localhost tools]# ./perf/perf buildid-list -i perf.data
> > >> 28a6c690262896dbd1b5e1011ed81623e6db0610 [kernel.kallsyms]
> > >> 106c14ce6e4acea3453e484dc604d66666f08a2f [vdso]
> > >> [root@localhost tools]# ./perf/perf buildid-list -i perf.data -H
> > >> 28a6c690262896dbd1b5e1011ed81623e6db0610 /proc/kcore
> > >>
> > >> Signed-off-by: Wei Li <liwei391@huawei.com>
> > >
> > > Acked-by: Jiri Olsa <jolsa@kernel.org>
> 
> Acked-by: Namhyung Kim <namhyung@kernel.org>

Thanks, applied to perf/urgent.

- Arnaldo

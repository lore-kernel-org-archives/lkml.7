Return-Path: <SRS0=4nbc=R5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D839EC43381
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Mar 2019 14:03:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A50C420823
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Mar 2019 14:03:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1553609008;
	bh=Odd+0IKPmCKxnklI88+mt/ff8LmHuhiTSXLSlVvyj+0=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=y0qaIb9TXZWa37yhQmTb0vJbwrbEq+YvfM9NedfijKKC375olkHx/7nvMCC5WV0Jf
	 2YfRHuK5FoQwrLkVBfTGuaHGPZTIONIOks+VNV+q6pVZQI0c0tiY1JWaQ9cKZmq5/i
	 ujlbzr4Iey2wmz8foXO0U5dG510VR92JGb9fnHjY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731573AbfCZOD1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Mar 2019 10:03:27 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:46925 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726270AbfCZOD1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Mar 2019 10:03:27 -0400
Received: by mail-wr1-f65.google.com with SMTP id o1so14467188wrs.13
        for <linux-kernel@vger.kernel.org>; Tue, 26 Mar 2019 07:03:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Odd+0IKPmCKxnklI88+mt/ff8LmHuhiTSXLSlVvyj+0=;
        b=hBGWAHj7RSrkBKe5SnEdsM0J9WDsy6flIuGV3EKZtq5wvrRgUtXn9g7yqw3njpmk1G
         UdXIpuVB/OimITr45txvOxG/4+0u/BjeMkT5YgaTnMs6EMG0tHMFmdCIGh2xEcK7v0u5
         AQX8MEQXC4zUITLT0E5SNqrUa1HVVOrVewKsnqZ80hdjIQFVnx5hSv0/lH4Xx+WSEaRM
         YGtGmE2zE/3QGdmPjaMDXqemjHwp975yV8pkiFQ1O1lP8UAxyvkm+Rz9CEIDiX7ktvfG
         DDXlYT8MPQbkREi8ER7BsBKT//Fu5SYMczSyCeFfHm6lsVi3gfwkLn5/cJvcQW6xp5PW
         u1RQ==
X-Gm-Message-State: APjAAAW89kTE/nfkL2zvPCzbWEshMBA8lgw6DooSjcq6CHDqb7rnYcY2
        vTp4E7A+g3XNxIKOWU9P/oSd+Sa+irNRTLER2Rc=
X-Google-Smtp-Source: APXvYqw8W5I26l+bsSbAMSLAVxtSxK3aLixhHjUiDMqolsobxJSEeEKlFk94caidi4+zE1RZbqWjLsNu0vVv6Tg20aA=
X-Received: by 2002:a05:6000:1250:: with SMTP id j16mr19052418wrx.135.1553609004904;
 Tue, 26 Mar 2019 07:03:24 -0700 (PDT)
MIME-Version: 1.0
References: <20190228092003.34071-1-liwei391@huawei.com> <20190228112838.GC18636@krava>
 <16b9191e-c444-8bdc-d23b-c4267440b3f2@huawei.com>
In-Reply-To: <16b9191e-c444-8bdc-d23b-c4267440b3f2@huawei.com>
From:   Namhyung Kim <namhyung@kernel.org>
Date:   Tue, 26 Mar 2019 23:03:14 +0900
Message-ID: <CAM9d7cjkp-NKVg9ktm6OkVn_tkrnHEP=_7muBHu1k-stxwYdOQ@mail.gmail.com>
Subject: Re: [PATCH] perf machine: Update kernel map address and re-order properly
To:     "liwei (GF)" <liwei391@huawei.com>
Cc:     Arnaldo Carvalho de Melo <acme@redhat.com>,
        Jiri Olsa <jolsa@redhat.com>, Jiri Olsa <jolsa@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        David Ahern <dsahern@gmail.com>,
        Peter Zijlstra <peterz@infradead.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Kim Phillips <kim.phillips@arm.com>, guohanjun@huawei.com,
        Li Bin <huawei.libin@huawei.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

On Tue, Mar 26, 2019 at 6:12 PM liwei (GF) <liwei391@huawei.com> wrote:
>
> Hi Arnaldo,
>
> Please shoot a glance at this modification, i think this issue is influential.
>
> On 2019/2/28 19:28, Jiri Olsa Wrote:
> > On Thu, Feb 28, 2019 at 05:20:03PM +0800, Wei Li wrote:
> >> Since commit 1fb87b8e9599 ("perf machine: Don't search for active kernel
> >> start in __machine__create_kernel_maps"), the __machine__create_kernel_maps()
> >> just create a map what start and end are both zero. Though the address will be
> >> updated later, the order of map in the rbtree may be incorrect.
> >>
> >> The commit ee05d21791db ("perf machine: Set main kernel end address properly")
> >> fixed the logic in machine__create_kernel_maps(), but it's still wrong in
> >> function machine__process_kernel_mmap_event().
> >>
> >> To reproduce this issue, we need an environment which the module address
> >> is before the kernel text segment. I tested it on an aarch64 machine with
> >> kernel 4.19.25:
> >
> > so that was the missing piece.. nice
> >
> >>
> >> [root@localhost hulk]# grep _stext /proc/kallsyms
> >> ffff000008081000 T _stext
> >> [root@localhost hulk]# grep _etext /proc/kallsyms
> >> ffff000009780000 R _etext
> >> [root@localhost hulk]# tail /proc/modules
> >> hisi_sas_v2_hw 77824 0 - Live 0xffff00000191d000
> >> nvme_core 126976 7 nvme, Live 0xffff0000018b6000
> >> mdio 20480 1 ixgbe, Live 0xffff0000018ab000
> >> hisi_sas_main 106496 1 hisi_sas_v2_hw, Live 0xffff000001861000
> >> hns_mdio 20480 2 - Live 0xffff000001822000
> >> hnae 28672 3 hns_dsaf,hns_enet_drv, Live 0xffff000001815000
> >> dm_mirror 40960 0 - Live 0xffff000001804000
> >> dm_region_hash 32768 1 dm_mirror, Live 0xffff0000017f5000
> >> dm_log 32768 2 dm_mirror,dm_region_hash, Live 0xffff0000017e7000
> >> dm_mod 315392 17 dm_mirror,dm_log, Live 0xffff000001780000
> >> [root@localhost hulk]#
> >>
> >> Before fix:
> >>
> >> [root@localhost bin]# perf record sleep 3
> >> [ perf record: Woken up 1 times to write data ]
> >> [ perf record: Captured and wrote 0.011 MB perf.data (9 samples) ]
> >> [root@localhost bin]# perf buildid-list -i perf.data
> >> 4c4e46c971ca935f781e603a09b52a92e8bdfee8 [vdso]
> >> [root@localhost bin]# perf buildid-list -i perf.data -H
> >> 0000000000000000000000000000000000000000 /proc/kcore
> >> [root@localhost bin]#
> >>
> >> After fix:
> >>
> >> [root@localhost tools]# ./perf/perf record sleep 3
> >> [ perf record: Woken up 1 times to write data ]
> >> [ perf record: Captured and wrote 0.011 MB perf.data (9 samples) ]
> >> [root@localhost tools]# ./perf/perf buildid-list -i perf.data
> >> 28a6c690262896dbd1b5e1011ed81623e6db0610 [kernel.kallsyms]
> >> 106c14ce6e4acea3453e484dc604d66666f08a2f [vdso]
> >> [root@localhost tools]# ./perf/perf buildid-list -i perf.data -H
> >> 28a6c690262896dbd1b5e1011ed81623e6db0610 /proc/kcore
> >>
> >> Signed-off-by: Wei Li <liwei391@huawei.com>
> >
> > Acked-by: Jiri Olsa <jolsa@kernel.org>

Acked-by: Namhyung Kim <namhyung@kernel.org>

Thanks,
Namhyung

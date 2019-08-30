Return-Path: <SRS0=2mSC=W2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0CFC3C3A59B
	for <linux-kernel@archiver.kernel.org>; Fri, 30 Aug 2019 18:23:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4427E2342E
	for <linux-kernel@archiver.kernel.org>; Fri, 30 Aug 2019 18:23:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QvgDmj26"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728007AbfH3SXD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 30 Aug 2019 14:23:03 -0400
Received: from mail-qt1-f193.google.com ([209.85.160.193]:37082 "EHLO
        mail-qt1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727304AbfH3SXC (ORCPT
        <rfc822;Linux-kernel@vger.kernel.org>);
        Fri, 30 Aug 2019 14:23:02 -0400
Received: by mail-qt1-f193.google.com with SMTP id y26so8629153qto.4
        for <Linux-kernel@vger.kernel.org>; Fri, 30 Aug 2019 11:22:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=piMcDRPDqf97lQFX9eTMM2keG0YqRi+Q2v+kHVgmgMo=;
        b=QvgDmj26GZFd8LcnW//Wd0pte3+ncu7qXtcUvr0DtFYNMUsKDNuczBJpAiJmqvcHT5
         C8owcKM5rWXx1oftbqWMnDA91R5KwByrBoLkDg2KBvIPOh87r5mh8mLbKTVJCpHd3mxN
         G7hbjtUj8Hr7nOjTM0U/3LZREmm6MuMteg6df574SARvmQQ85YsBpjfysm3gPNtV14/K
         R74BAdFm2wbcnb9sRFmhZhBYgN5OicVfIzBXurQjKguOMa+ILpJICMrXskCB/2gMO0VU
         ZY5m6jzWwOHDURwrYiFPElOTa3QUx0/TlgdonjWwtr/NyLnwu3UHXDpsh/D4sFaNa84D
         33Uw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=piMcDRPDqf97lQFX9eTMM2keG0YqRi+Q2v+kHVgmgMo=;
        b=dFkw3C8yGuhFEMLEMlFyKUb0E0JkjEaP0IfwMtqIz4K+KC1NGEzf6KGK50lXh+Xom5
         ejXCG1PseZAPc/EmStdPi81mp0uYvLkViw+Zk/xo80byAsXHMDIwTJsm3vl1tIDiHKxz
         vC31kHlrtC2kNeYRMbC9IOaz38xXTk1Gv2snvuKSa6RRRjKoGANBHFvNU3CVxHYV8ZQv
         Q/NLTY24E/KLldHUeBx5075Y2OJXnuQGHQ9A+/TYtl+zo5rm1XQlL59HAomAik8QzA0d
         +uzmsMzc9/bCuNe6KVRrf/gBJe1WqK77pHjdbodLE15j/imTptVXEzaVTsxrkm6ZqRzg
         iCyg==
X-Gm-Message-State: APjAAAWfXN0cX+DAQULd2sidaeIBXMvLaEKC8dMmlSwhUNmFSoglVDP1
        rD2XDUzVtxQJrDsKUwsmS10=
X-Google-Smtp-Source: APXvYqygMmwYl/Z42oqU66nDdfX2J/VRnOIcvjS9rTEqnYCksKgUdF393LJpPGugDiHAx/+rX0daPQ==
X-Received: by 2002:ac8:51cd:: with SMTP id d13mr16533222qtn.358.1567189377901;
        Fri, 30 Aug 2019 11:22:57 -0700 (PDT)
Received: from quaco.ghostprotocols.net (179-240-168-86.3g.claro.net.br. [179.240.168.86])
        by smtp.gmail.com with ESMTPSA id v62sm3392301qkc.76.2019.08.30.11.22.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Aug 2019 11:22:56 -0700 (PDT)
From:   Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>
X-Google-Original-From: Arnaldo Carvalho de Melo <acme@kernel.org>
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 8F64041146; Fri, 30 Aug 2019 15:22:42 -0300 (-03)
Date:   Fri, 30 Aug 2019 15:22:42 -0300
To:     Jin Yao <yao.jin@linux.intel.com>
Cc:     jolsa@kernel.org, peterz@infradead.org, mingo@redhat.com,
        alexander.shishkin@linux.intel.com, Linux-kernel@vger.kernel.org,
        ak@linux.intel.com, kan.liang@intel.com, yao.jin@intel.com,
        Haiyan Song <haiyanx.song@intel.com>
Subject: Re: [PATCH v1 2/4] perf vendor events intel: Update cascadelakex
 uncore events to v1.04
Message-ID: <20190830182242.GF28011@kernel.org>
References: <20190828055932.8269-1-yao.jin@linux.intel.com>
 <20190828055932.8269-3-yao.jin@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20190828055932.8269-3-yao.jin@linux.intel.com>
X-Url:  http://acmel.wordpress.com
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Wed, Aug 28, 2019 at 01:59:30PM +0800, Jin Yao escreveu:
> From: Haiyan Song <haiyanx.song@intel.com>

Not applying, please check, will apply the other 3 patches in the
series, next time please try to collect some Acked-by in advance.

- Arnaldo
=20
> Signed-off-by: Haiyan Song <haiyanx.song@intel.com>
> ---
>  .../arch/x86/cascadelakex/uncore-memory.json  |  191 ++
>  .../arch/x86/cascadelakex/uncore-other.json   | 1809 ++++++++++++++++-
>  2 files changed, 1971 insertions(+), 29 deletions(-)
>=20
> diff --git a/tools/perf/pmu-events/arch/x86/cascadelakex/uncore-memory.js=
on b/tools/perf/pmu-events/arch/x86/cascadelakex/uncore-memory.json
> index 22df833fe032..3fb5cdce842f 100644
> --- a/tools/perf/pmu-events/arch/x86/cascadelakex/uncore-memory.json
> +++ b/tools/perf/pmu-events/arch/x86/cascadelakex/uncore-memory.json
> @@ -73,6 +73,22 @@
>          "UMask": "0x8",
>          "Unit": "iMC"
>      },
> +    {
> +        "BriefDescription": "Write requests allocated in the PMM Write P=
ending Queue for Intel Optane DC persistent memory",
> +        "Counter": "0,1,2,3",
> +        "EventCode": "0xE3",
> +        "EventName": "UNC_M_PMM_RPQ_INSERTS",
> +        "PerPkg": "1",
> +        "Unit": "iMC"
> +    },
> +    {
> +        "BriefDescription": "Write requests allocated in the PMM Write P=
ending Queue for Intel Optane DC persistent memory",
> +        "Counter": "0,1,2,3",
> +        "EventCode": "0xE7",
> +        "EventName": "UNC_M_PMM_WPQ_INSERTS",
> +        "PerPkg": "1",
> +        "Unit": "iMC"
> +    },
>      {
>          "BriefDescription": "Intel Optane DC persistent memory bandwidth=
 read (MB/sec). Derived from unc_m_pmm_rpq_inserts",
>          "Counter": "0,1,2,3",
> @@ -102,6 +118,15 @@
>          "ScaleUnit": "6.103515625E-5MB/sec",
>          "Unit": "iMC"
>      },
> +    {
> +        "BriefDescription": "Read Pending Queue Occupancy of all read re=
quests for Intel Optane DC persistent memory",
> +        "Counter": "0,1,2,3",
> +        "EventCode": "0xE0",
> +        "EventName": "UNC_M_PMM_RPQ_OCCUPANCY.ALL",
> +        "PerPkg": "1",
> +        "UMask": "0x1",
> +        "Unit": "iMC"
> +    },
>      {
>          "BriefDescription": "Intel Optane DC persistent memory read late=
ncy (ns). Derived from unc_m_pmm_rpq_occupancy.all",
>          "Counter": "0,1,2,3",
> @@ -113,5 +138,171 @@
>          "ScaleUnit": "6000000000ns",
>          "UMask": "0x1",
>          "Unit": "iMC"
> +    },
> +    {
> +        "BriefDescription": "DRAM Page Activate commands sent due to a w=
rite request",
> +        "Counter": "0,1,2,3",
> +        "EventCode": "0x1",
> +        "EventName": "UNC_M_ACT_COUNT.WR",
> +        "PerPkg": "1",
> +        "PublicDescription": "Counts DRAM Page Activate commands sent on=
 this channel due to a write request to the iMC (Memory Controller).  Activ=
ate commands are issued to open up a page on the DRAM devices so that it ca=
n be read or written to with a CAS (Column Access Select) command.",
> +        "UMask": "0x2",
> +        "Unit": "iMC"
> +    },
> +    {
> +        "BriefDescription": "All DRAM CAS Commands issued",
> +        "Counter": "0,1,2,3",
> +        "EventCode": "0x4",
> +        "EventName": "UNC_M_CAS_COUNT.ALL",
> +        "PerPkg": "1",
> +        "PublicDescription": "Counts all CAS (Column Address Select) com=
mands issued to DRAM per memory channel.  CAS commands are issued to specif=
y the address to read or write on DRAM, so this event increments for every =
read and write. This event counts whether AutoPrecharge (which closes the D=
RAM Page automatically after a read/write) is enabled or not.",
> +        "UMask": "0xF",
> +        "Unit": "iMC"
> +    },
> +    {
> +        "BriefDescription": "All DRAM Read CAS Commands issued (does not=
 include underfills)",
> +        "Counter": "0,1,2,3",
> +        "EventCode": "0x4",
> +        "EventName": "UNC_M_CAS_COUNT.RD_REG",
> +        "PerPkg": "1",
> +        "PublicDescription": "Counts CAS (Column Access Select) regular =
read commands issued to DRAM on a per channel basis.  CAS commands are issu=
ed to specify the address to read or write on DRAM, and this event incremen=
ts for every regular read.  This event only counts regular reads and does n=
ot includes underfill reads due to partial write requests.  This event coun=
ts whether AutoPrecharge (which closes the DRAM Page automatically after a =
read/write)  is enabled or not.",
> +        "UMask": "0x1",
> +        "Unit": "iMC"
> +    },
> +    {
> +        "BriefDescription": "DRAM Underfill Read CAS Commands issued",
> +        "Counter": "0,1,2,3",
> +        "EventCode": "0x4",
> +        "EventName": "UNC_M_CAS_COUNT.RD_UNDERFILL",
> +        "PerPkg": "1",
> +        "PublicDescription": "Counts CAS (Column Access Select) underfil=
l read commands issued to DRAM due to a partial write, on a per channel bas=
is.  CAS commands are issued to specify the address to read or write on DRA=
M, and this command counts underfill reads.  Partial writes must be complet=
ed by first reading in the underfill from DRAM and then merging in the part=
ial write data before writing the full line back to DRAM. This event will g=
enerally count about the same as the number of partial writes, but may be s=
lightly less because of partials hitting in the WPQ (due to a previous writ=
e request).",
> +        "UMask": "0x2",
> +        "Unit": "iMC"
> +    },
> +    {
> +        "BriefDescription": "DRAM CAS (Column Address Strobe) Commands.;=
 DRAM WR_CAS (w/ and w/out auto-pre) in Write Major Mode",
> +        "Counter": "0,1,2,3",
> +        "EventCode": "0x4",
> +        "EventName": "UNC_M_CAS_COUNT.WR_WMM",
> +        "PerPkg": "1",
> +        "PublicDescription": "Counts the total number or DRAM Write CAS =
commands issued on this channel while in Write-Major-Mode.",
> +        "UMask": "0x4",
> +        "Unit": "iMC"
> +    },
> +    {
> +        "BriefDescription": "All commands for Intel Optane DC persistent=
 memory",
> +        "Counter": "0,1,2,3",
> +        "EventCode": "0xEA",
> +        "EventName": "UNC_M_PMM_CMD1.ALL",
> +        "PerPkg": "1",
> +        "PublicDescription": "All commands for Intel Optane DC persisten=
t memory",
> +        "UMask": "0x1",
> +        "Unit": "iMC"
> +    },
> +    {
> +        "BriefDescription": "Regular reads(RPQ) commands for Intel Optan=
e DC persistent memory",
> +        "Counter": "0,1,2,3",
> +        "EventCode": "0xEA",
> +        "EventName": "UNC_M_PMM_CMD1.RD",
> +        "PerPkg": "1",
> +        "PublicDescription": "All Reads - RPQ or Ufill",
> +        "UMask": "0x2",
> +        "Unit": "iMC"
> +    },
> +    {
> +        "BriefDescription": "Underfill read commands for Intel Optane DC=
 persistent memory",
> +        "Counter": "0,1,2,3",
> +        "EventCode": "0xEA",
> +        "EventName": "UNC_M_PMM_CMD1.UFILL_RD",
> +        "PerPkg": "1",
> +        "PublicDescription": "Underfill reads",
> +        "UMask": "0x8",
> +        "Unit": "iMC"
> +    },
> +    {
> +        "BriefDescription": "Write commands for Intel Optane DC persiste=
nt memory",
> +        "Counter": "0,1,2,3",
> +        "EventCode": "0xEA",
> +        "EventName": "UNC_M_PMM_CMD1.WR",
> +        "PerPkg": "1",
> +        "PublicDescription": "Writes",
> +        "UMask": "0x4",
> +        "Unit": "iMC"
> +    },
> +    {
> +        "BriefDescription": "Write Pending Queue Occupancy of all write =
requests for Intel Optane DC persistent memory",
> +        "Counter": "0,1,2,3",
> +        "EventCode": "0xE4",
> +        "EventName": "UNC_M_PMM_WPQ_OCCUPANCY.ALL",
> +        "PerPkg": "1",
> +        "PublicDescription": "Write Pending Queue Occupancy of all write=
 requests for Intel Optane DC persistent memory",
> +        "UMask": "0x1",
> +        "Unit": "iMC"
> +    },
> +    {
> +        "BriefDescription": "Read Pending Queue Allocations",
> +        "Counter": "0,1,2,3",
> +        "EventCode": "0x10",
> +        "EventName": "UNC_M_RPQ_INSERTS",
> +        "PerPkg": "1",
> +        "PublicDescription": "Counts the number of read requests allocat=
ed into the Read Pending Queue (RPQ).  This queue is used to schedule reads=
 out to the memory controller and to track the requests.  Requests allocate=
 into the RPQ soon after they enter the memory controller, and need credits=
 for an entry in this buffer before being sent from the CHA to the iMC.  Th=
e requests deallocate after the read CAS command has been issued to DRAM.  =
This event counts both Isochronous and non-Isochronous requests which were =
issued to the RPQ.",
> +        "Unit": "iMC"
> +    },
> +    {
> +        "BriefDescription": "Read Pending Queue Occupancy",
> +        "Counter": "0,1,2,3",
> +        "EventCode": "0x80",
> +        "EventName": "UNC_M_RPQ_OCCUPANCY",
> +        "PerPkg": "1",
> +        "PublicDescription": "Counts the number of entries in the Read P=
ending Queue (RPQ) at each cycle.  This can then be used to calculate both =
the average occupancy of the queue (in conjunction with the number of cycle=
s not empty) and the average latency in the queue (in conjunction with the =
number of allocations).  The RPQ is used to schedule reads out to the memor=
y controller and to track the requests.  Requests allocate into the RPQ soo=
n after they enter the memory controller, and need credits for an entry in =
this buffer before being sent from the CHA to the iMC. They deallocate from=
 the RPQ after the CAS command has been issued to memory.",
> +        "Unit": "iMC"
> +    },
> +    {
> +        "BriefDescription": "All hits to Near Memory(DRAM cache) in Memo=
ry Mode",
> +        "Counter": "0,1,2,3",
> +        "EventCode": "0xD3",
> +        "EventName": "UNC_M_TAGCHK.HIT",
> +        "PerPkg": "1",
> +        "PublicDescription": "Tag Check; Hit",
> +        "UMask": "0x1",
> +        "Unit": "iMC"
> +    },
> +    {
> +        "BriefDescription": "All Clean line misses to Near Memory(DRAM c=
ache) in Memory Mode",
> +        "Counter": "0,1,2,3",
> +        "EventCode": "0xD3",
> +        "EventName": "UNC_M_TAGCHK.MISS_CLEAN",
> +        "PerPkg": "1",
> +        "PublicDescription": "Tag Check; Clean",
> +        "UMask": "0x2",
> +        "Unit": "iMC"
> +    },
> +    {
> +        "BriefDescription": "All dirty line misses to Near Memory(DRAM c=
ache) in Memory Mode",
> +        "Counter": "0,1,2,3",
> +        "EventCode": "0xD3",
> +        "EventName": "UNC_M_TAGCHK.MISS_DIRTY",
> +        "PerPkg": "1",
> +        "PublicDescription": "Tag Check; Dirty",
> +        "UMask": "0x4",
> +        "Unit": "iMC"
> +    },
> +    {
> +        "BriefDescription": "Write Pending Queue Allocations",
> +        "Counter": "0,1,2,3",
> +        "EventCode": "0x20",
> +        "EventName": "UNC_M_WPQ_INSERTS",
> +        "PerPkg": "1",
> +        "PublicDescription": "Counts the number of writes requests alloc=
ated into the Write Pending Queue (WPQ).  The WPQ is used to schedule write=
s out to the memory controller and to track the requests.  Requests allocat=
e into the WPQ soon after they enter the memory controller, and need credit=
s for an entry in this buffer before being sent from the CHA to the iMC (Me=
mory Controller).  The write requests deallocate after being issued to DRAM=
=2E  Write requests themselves are able to complete (from the perspective o=
f the rest of the system) as soon they have 'posted' to the iMC.",
> +        "Unit": "iMC"
> +    },
> +    {
> +        "BriefDescription": "Write Pending Queue Occupancy",
> +        "Counter": "0,1,2,3",
> +        "EventCode": "0x81",
> +        "EventName": "UNC_M_WPQ_OCCUPANCY",
> +        "PerPkg": "1",
> +        "PublicDescription": "Counts the number of entries in the Write =
Pending Queue (WPQ) at each cycle.  This can then be used to calculate both=
 the average queue occupancy (in conjunction with the number of cycles not =
empty) and the average latency (in conjunction with the number of allocatio=
ns).  The WPQ is used to schedule writes out to the memory controller and t=
o track the requests.  Requests allocate into the WPQ soon after they enter=
 the memory controller, and need credits for an entry in this buffer before=
 being sent from the CHA to the iMC (memory controller).  They deallocate a=
fter being issued to DRAM.  Write requests themselves are able to complete =
(from the perspective of the rest of the system) as soon they have 'posted'=
 to the iMC.  This is not to be confused with actually performing the write=
 to DRAM.  Therefore, the average latency for this queue is actually not us=
eful for deconstruction intermediate write latencies.  So, we provide filte=
ring based on if the requ
>  est has posted or not.  By using the 'not posted' filter, we can track h=
ow long writes spent in the iMC before completions were sent to the HA.  Th=
e 'posted' filter, on the other hand, provides information about how much q=
ueueing is actually happenning in the iMC for writes before they are actual=
ly issued to memory.  High average occupancies will generally coincide with=
 high write major mode counts. Is there a filter of sorts???",
> +        "Unit": "iMC"
>      }
>  ]
> diff --git a/tools/perf/pmu-events/arch/x86/cascadelakex/uncore-other.jso=
n b/tools/perf/pmu-events/arch/x86/cascadelakex/uncore-other.json
> index cab355872dff..c14276f9021d 100644
> --- a/tools/perf/pmu-events/arch/x86/cascadelakex/uncore-other.json
> +++ b/tools/perf/pmu-events/arch/x86/cascadelakex/uncore-other.json
> @@ -119,7 +119,7 @@
>          "EventName": "UPI_DATA_BANDWIDTH_TX",
>          "PerPkg": "1",
>          "ScaleUnit": "7.11E-06Bytes",
> -        "UMask": "0x0F",
> +        "UMask": "0xf",
>          "Unit": "UPI LL"
>      },
>      {
> @@ -152,20 +152,6 @@
>          "UMask": "0x01",
>          "Unit": "IIO"
>      },
> -    {
> -        "BriefDescription": "PCI Express bandwidth writing at IIO, part =
0",
> -        "Counter": "0,1",
> -        "EventCode": "0x83",
> -        "EventName": "UNC_IIO_DATA_REQ_OF_CPU.MEM_WRITE.PART0",
> -        "FCMask": "0x07",
> -        "MetricExpr": "UNC_IIO_DATA_REQ_OF_CPU.MEM_WRITE.PART0 +UNC_IIO_=
DATA_REQ_OF_CPU.MEM_WRITE.PART1 +UNC_IIO_DATA_REQ_OF_CPU.MEM_WRITE.PART2 +U=
NC_IIO_DATA_REQ_OF_CPU.MEM_WRITE.PART3",
> -        "MetricName": "LLC_MISSES.PCIE_WRITE",
> -        "PerPkg": "1",
> -        "PortMask": "0x01",
> -        "ScaleUnit": "4Bytes",
> -        "UMask": "0x01",
> -        "Unit": "IIO"
> -    },
>      {
>          "BriefDescription": "PCI Express bandwidth writing at IIO, part =
1",
>          "Counter": "0,1",
> @@ -202,20 +188,6 @@
>          "UMask": "0x01",
>          "Unit": "IIO"
>      },
> -    {
> -        "BriefDescription": "PCI Express bandwidth reading at IIO, part =
0",
> -        "Counter": "0,1",
> -        "EventCode": "0x83",
> -        "EventName": "UNC_IIO_DATA_REQ_OF_CPU.MEM_READ.PART0",
> -        "FCMask": "0x07",
> -        "MetricExpr": "UNC_IIO_DATA_REQ_OF_CPU.MEM_READ.PART0 + UNC_IIO_=
DATA_REQ_OF_CPU.MEM_READ.PART1 + UNC_IIO_DATA_REQ_OF_CPU.MEM_READ.PART2 + U=
NC_IIO_DATA_REQ_OF_CPU.MEM_READ.PART3",
> -        "MetricName": "LLC_MISSES.PCIE_READ",
> -        "PerPkg": "1",
> -        "PortMask": "0x01",
> -        "ScaleUnit": "4Bytes",
> -        "UMask": "0x04",
> -        "Unit": "IIO"
> -    },
>      {
>          "BriefDescription": "PCI Express bandwidth reading at IIO, part =
1",
>          "Counter": "0,1",
> @@ -251,5 +223,1784 @@
>          "ScaleUnit": "4Bytes",
>          "UMask": "0x04",
>          "Unit": "IIO"
> +    },
> +    {
> +        "BriefDescription": "Core Cross Snoops Issued; Multiple Core Req=
uests",
> +        "Counter": "0,1,2,3",
> +        "EventCode": "0x33",
> +        "EventName": "UNC_CHA_CORE_SNP.CORE_GTONE",
> +        "PerPkg": "1",
> +        "PublicDescription": "Counts the number of transactions that tri=
gger a configurable number of cross snoops.  Cores are snooped if the trans=
action looks up the cache and determines that it is necessary based on the =
operation type and what CoreValid bits are set.  For example, if 2 CV bits =
are set on a data read, the cores must have the data in S state so it is no=
t necessary to snoop them.  However, if only 1 CV bit is set the core my ha=
ve modified the data.  If the transaction was an RFO, it would need to inva=
lidate the lines.  This event can be filtered based on who triggered the in=
itial snoop(s).",
> +        "UMask": "0x42",
> +        "Unit": "CHA"
> +    },
> +    {
> +        "BriefDescription": "Core Cross Snoops Issued; Multiple Eviction=
",
> +        "Counter": "0,1,2,3",
> +        "EventCode": "0x33",
> +        "EventName": "UNC_CHA_CORE_SNP.EVICT_GTONE",
> +        "PerPkg": "1",
> +        "PublicDescription": "Counts the number of transactions that tri=
gger a configurable number of cross snoops.  Cores are snooped if the trans=
action looks up the cache and determines that it is necessary based on the =
operation type and what CoreValid bits are set.  For example, if 2 CV bits =
are set on a data read, the cores must have the data in S state so it is no=
t necessary to snoop them.  However, if only 1 CV bit is set the core my ha=
ve modified the data.  If the transaction was an RFO, it would need to inva=
lidate the lines.  This event can be filtered based on who triggered the in=
itial snoop(s).",
> +        "UMask": "0x82",
> +        "Unit": "CHA"
> +    },
> +    {
> +        "BriefDescription": "Multi-socket cacheline Directory state look=
ups; Snoop Not Needed",
> +        "Counter": "0,1,2,3",
> +        "EventCode": "0x53",
> +        "EventName": "UNC_CHA_DIR_LOOKUP.NO_SNP",
> +        "PerPkg": "1",
> +        "PublicDescription": "Counts transactions that looked into the m=
ulti-socket cacheline Directory state, and therefore did not send a snoop b=
ecause the Directory indicated it was not needed",
> +        "UMask": "0x02",
> +        "Unit": "CHA"
> +    },
> +    {
> +        "BriefDescription": "Multi-socket cacheline Directory state look=
ups; Snoop Needed",
> +        "Counter": "0,1,2,3",
> +        "EventCode": "0x53",
> +        "EventName": "UNC_CHA_DIR_LOOKUP.SNP",
> +        "PerPkg": "1",
> +        "PublicDescription": "Counts  transactions that looked into the =
multi-socket cacheline Directory state, and sent one or more snoops, becaus=
e the Directory indicated it was needed",
> +        "UMask": "0x01",
> +        "Unit": "CHA"
> +    },
> +    {
> +        "BriefDescription": "Multi-socket cacheline Directory state upda=
tes; Directory Updated memory write from the HA pipe",
> +        "Counter": "0,1,2,3",
> +        "EventCode": "0x54",
> +        "EventName": "UNC_CHA_DIR_UPDATE.HA",
> +        "PerPkg": "1",
> +        "PublicDescription": "Counts only multi-socket cacheline Directo=
ry state updates memory writes issued from the HA pipe. This does not inclu=
de memory write requests which are for I (Invalid) or E (Exclusive) cacheli=
nes.",
> +        "UMask": "0x01",
> +        "Unit": "CHA"
> +    },
> +    {
> +        "BriefDescription": "Multi-socket cacheline Directory state upda=
tes; Directory Updated memory write from TOR pipe",
> +        "Counter": "0,1,2,3",
> +        "EventCode": "0x54",
> +        "EventName": "UNC_CHA_DIR_UPDATE.TOR",
> +        "PerPkg": "1",
> +        "PublicDescription": "Counts only multi-socket cacheline Directo=
ry state updates due to memory writes issued from the TOR pipe which are th=
e result of remote transaction hitting the SF/LLC and returning data Core2C=
ore. This does not include memory write requests which are for I (Invalid) =
or E (Exclusive) cachelines.",
> +        "UMask": "0x02",
> +        "Unit": "CHA"
> +    },
> +    {
> +        "BriefDescription": "FaST wire asserted; Horizontal",
> +        "Counter": "0,1,2,3",
> +        "EventCode": "0xA5",
> +        "EventName": "UNC_CHA_FAST_ASSERTED.HORZ",
> +        "PerPkg": "1",
> +        "PublicDescription": "Counts the number of cycles either the loc=
al or incoming distress signals are asserted.  Incoming distress includes u=
p, dn and across.",
> +        "UMask": "0x02",
> +        "Unit": "CHA"
> +    },
> +    {
> +        "BriefDescription": "Read request from a remote socket which hit=
 in the HitMe Cache to a line In the E state",
> +        "Counter": "0,1,2,3",
> +        "EventCode": "0x5F",
> +        "EventName": "UNC_CHA_HITME_HIT.EX_RDS",
> +        "PerPkg": "1",
> +        "PublicDescription": "Counts read requests from a remote socket =
which hit in the HitME cache (used to cache the multi-socket Directory stat=
e) to a line in the E(Exclusive) state.  This includes the following read o=
pcodes (RdCode, RdData, RdDataMigratory, RdCur, RdInv*, Inv*)",
> +        "UMask": "0x01",
> +        "Unit": "CHA"
> +    },
> +    {
> +        "BriefDescription": "Normal priority reads issued to the memory =
controller from the CHA",
> +        "Counter": "0,1,2,3",
> +        "EventCode": "0x59",
> +        "EventName": "UNC_CHA_IMC_READS_COUNT.NORMAL",
> +        "PerPkg": "1",
> +        "PublicDescription": "Counts when a normal (Non-Isochronous) rea=
d is issued to any of the memory controller channels from the CHA.",
> +        "UMask": "0x01",
> +        "Unit": "CHA"
> +    },
> +    {
> +        "BriefDescription": "CHA to iMC Full Line Writes Issued; Full Li=
ne Non-ISOCH",
> +        "Counter": "0,1,2,3",
> +        "EventCode": "0x5B",
> +        "EventName": "UNC_CHA_IMC_WRITES_COUNT.FULL",
> +        "PerPkg": "1",
> +        "PublicDescription": "Counts when a normal (Non-Isochronous) ful=
l line write is issued from the CHA to the any of the memory controller cha=
nnels.",
> +        "UMask": "0x01",
> +        "Unit": "CHA"
> +    },
> +    {
> +        "BriefDescription": "Lines Victimized; Lines in E state",
> +        "Counter": "0,1,2,3",
> +        "EventCode": "0x37",
> +        "EventName": "UNC_CHA_LLC_VICTIMS.TOTAL_E",
> +        "PerPkg": "1",
> +        "PublicDescription": "Counts the number of lines that were victi=
mized on a fill.  This can be filtered by the state that the line was in.",
> +        "UMask": "0x02",
> +        "Unit": "CHA"
> +    },
> +    {
> +        "BriefDescription": "Lines Victimized; Lines in F State",
> +        "Counter": "0,1,2,3",
> +        "EventCode": "0x37",
> +        "EventName": "UNC_CHA_LLC_VICTIMS.TOTAL_F",
> +        "PerPkg": "1",
> +        "PublicDescription": "Counts the number of lines that were victi=
mized on a fill.  This can be filtered by the state that the line was in.",
> +        "UMask": "0x08",
> +        "Unit": "CHA"
> +    },
> +    {
> +        "BriefDescription": "Lines Victimized; Lines in M state",
> +        "Counter": "0,1,2,3",
> +        "EventCode": "0x37",
> +        "EventName": "UNC_CHA_LLC_VICTIMS.TOTAL_M",
> +        "PerPkg": "1",
> +        "PublicDescription": "Counts the number of lines that were victi=
mized on a fill.  This can be filtered by the state that the line was in.",
> +        "UMask": "0x01",
> +        "Unit": "CHA"
> +    },
> +    {
> +        "BriefDescription": "Lines Victimized; Lines in S State",
> +        "Counter": "0,1,2,3",
> +        "EventCode": "0x37",
> +        "EventName": "UNC_CHA_LLC_VICTIMS.TOTAL_S",
> +        "PerPkg": "1",
> +        "PublicDescription": "Counts the number of lines that were victi=
mized on a fill.  This can be filtered by the state that the line was in.",
> +        "UMask": "0x04",
> +        "Unit": "CHA"
> +    },
> +    {
> +        "BriefDescription": "Number of times that an RFO hit in S state.=
",
> +        "Counter": "0,1,2,3",
> +        "EventCode": "0x39",
> +        "EventName": "UNC_CHA_MISC.RFO_HIT_S",
> +        "PerPkg": "1",
> +        "PublicDescription": "Counts when a RFO (the Read for Ownership =
issued before a  write) request hit a cacheline in the S (Shared) state.",
> +        "UMask": "0x08",
> +        "Unit": "CHA"
> +    },
> +    {
> +        "BriefDescription": "Local requests for exclusive ownership of a=
 cache line  without receiving data",
> +        "Counter": "0,1,2,3",
> +        "EventCode": "0x50",
> +        "EventName": "UNC_CHA_REQUESTS.INVITOE_LOCAL",
> +        "PerPkg": "1",
> +        "PublicDescription": "Counts the total number of requests coming=
 from a unit on this socket for exclusive ownership of a cache line without=
 receiving data (INVITOE) to the CHA.",
> +        "UMask": "0x10",
> +        "Unit": "CHA"
> +    },
> +    {
> +        "BriefDescription": "Local requests for exclusive ownership of a=
 cache line without receiving data",
> +        "Counter": "0,1,2,3",
> +        "EventCode": "0x50",
> +        "EventName": "UNC_CHA_REQUESTS.INVITOE_REMOTE",
> +        "PerPkg": "1",
> +        "PublicDescription": "Counts the total number of requests coming=
 from a remote socket for exclusive ownership of a cache line without recei=
ving data (INVITOE) to the CHA.",
> +        "UMask": "0x20",
> +        "Unit": "CHA"
> +    },
> +    {
> +        "BriefDescription": "Ingress (from CMS) Allocations; IRQ",
> +        "Counter": "0,1,2,3",
> +        "EventCode": "0x13",
> +        "EventName": "UNC_CHA_RxC_INSERTS.IRQ",
> +        "PerPkg": "1",
> +        "PublicDescription": "Counts number of allocations per cycle int=
o the specified Ingress queue.",
> +        "UMask": "0x01",
> +        "Unit": "CHA"
> +    },
> +    {
> +        "BriefDescription": "Ingress (from CMS) Request Queue Rejects; P=
hyAddr Match",
> +        "Counter": "0,1,2,3",
> +        "EventCode": "0x19",
> +        "EventName": "UNC_CHA_RxC_IRQ1_REJECT.PA_MATCH",
> +        "PerPkg": "1",
> +        "PublicDescription": "Ingress (from CMS) Request Queue Rejects; =
PhyAddr Match",
> +        "UMask": "0x80",
> +        "Unit": "CHA"
> +    },
> +    {
> +        "BriefDescription": "Ingress (from CMS) Occupancy; IRQ",
> +        "EventCode": "0x11",
> +        "EventName": "UNC_CHA_RxC_OCCUPANCY.IRQ",
> +        "PerPkg": "1",
> +        "PublicDescription": "Counts number of entries in the specified =
Ingress queue in each cycle.",
> +        "UMask": "0x01",
> +        "Unit": "CHA"
> +    },
> +    {
> +        "BriefDescription": "Snoop filter capacity evictions for E-state=
 entries.",
> +        "Counter": "0,1,2,3",
> +        "EventCode": "0x3D",
> +        "EventName": "UNC_CHA_SF_EVICTION.E_STATE",
> +        "PerPkg": "1",
> +        "PublicDescription": "Counts snoop filter capacity evictions for=
 entries tracking exclusive lines in the cores cache. Snoop filter capacity=
 evictions occur when the snoop filter is full and evicts an existing entry=
 to track a new entry. Does not count clean evictions such as when a cores =
cache replaces a tracked cacheline with a new cacheline.",
> +        "UMask": "0x02",
> +        "Unit": "CHA"
> +    },
> +    {
> +        "BriefDescription": "Snoop filter capacity evictions for M-state=
 entries.",
> +        "Counter": "0,1,2,3",
> +        "EventCode": "0x3D",
> +        "EventName": "UNC_CHA_SF_EVICTION.M_STATE",
> +        "PerPkg": "1",
> +        "PublicDescription": "Counts snoop filter capacity evictions for=
 entries tracking modified lines in the cores cache. Snoop filter capacity =
evictions occur when the snoop filter is full and evicts an existing entry =
to track a new entry. Does not count clean evictions such as when a cores c=
ache replaces a tracked cacheline with a new cacheline.",
> +        "UMask": "0x01",
> +        "Unit": "CHA"
> +    },
> +    {
> +        "BriefDescription": "Snoop filter capacity evictions for S-state=
 entries.",
> +        "Counter": "0,1,2,3",
> +        "EventCode": "0x3D",
> +        "EventName": "UNC_CHA_SF_EVICTION.S_STATE",
> +        "PerPkg": "1",
> +        "PublicDescription": "Counts snoop filter capacity evictions for=
 entries tracking shared lines in the cores cache. Snoop filter capacity ev=
ictions occur when the snoop filter is full and evicts an existing entry to=
 track a new entry. Does not count clean evictions such as when a cores cac=
he replaces a tracked cacheline with a new cacheline.",
> +        "UMask": "0x04",
> +        "Unit": "CHA"
> +    },
> +    {
> +        "BriefDescription": "RspCnflct* Snoop Responses Received",
> +        "Counter": "0,1,2,3",
> +        "EventCode": "0x5C",
> +        "EventName": "UNC_CHA_SNOOP_RESP.RSPCNFLCTS",
> +        "PerPkg": "1",
> +        "PublicDescription": "Counts when a a transaction with the opcod=
e type RspCnflct* Snoop Response was received. This is returned when a snoo=
p finds an existing outstanding transaction in a remote caching agent. This=
 triggers conflict resolution hardware. This covers both the opcode RspCnfl=
ct and RspCnflctWbI.",
> +        "UMask": "0x40",
> +        "Unit": "CHA"
> +    },
> +    {
> +        "BriefDescription": "RspI Snoop Responses Received",
> +        "Counter": "0,1,2,3",
> +        "EventCode": "0x5C",
> +        "EventName": "UNC_CHA_SNOOP_RESP.RSPI",
> +        "PerPkg": "1",
> +        "PublicDescription": "Counts when a transaction with the opcode =
type RspI Snoop Response was received which indicates the remote cache does=
 not have the data, or when the remote cache silently evicts data (such as =
when an RFO: the Read for Ownership issued before a write hits non-modified=
 data).",
> +        "UMask": "0x01",
> +        "Unit": "CHA"
> +    },
> +    {
> +        "BriefDescription": "RspIFwd Snoop Responses Received",
> +        "Counter": "0,1,2,3",
> +        "EventCode": "0x5C",
> +        "EventName": "UNC_CHA_SNOOP_RESP.RSPIFWD",
> +        "PerPkg": "1",
> +        "PublicDescription": "Counts when a a transaction with the opcod=
e type RspIFwd Snoop Response was received which indicates a remote caching=
 agent forwarded the data and the requesting agent is able to acquire the d=
ata in E (Exclusive) or M (modified) states.  This is commonly returned wit=
h RFO (the Read for Ownership issued before a write) transactions.  The sno=
op could have either been to a cacheline in the M,E,F (Modified, Exclusive =
or Forward)  states.",
> +        "UMask": "0x04",
> +        "Unit": "CHA"
> +    },
> +    {
> +        "BriefDescription": "RspSFwd Snoop Responses Received",
> +        "Counter": "0,1,2,3",
> +        "EventCode": "0x5C",
> +        "EventName": "UNC_CHA_SNOOP_RESP.RSPSFWD",
> +        "PerPkg": "1",
> +        "PublicDescription": "Counts when a a transaction with the opcod=
e type RspSFwd Snoop Response was received which indicates a remote caching=
 agent forwarded the data but held on to its current copy.  This is common =
for data and code reads that hit in a remote socket in E (Exclusive) or F (=
Forward) state.",
> +        "UMask": "0x08",
> +        "Unit": "CHA"
> +    },
> +    {
> +        "BriefDescription": "Rsp*Fwd*WB Snoop Responses Received",
> +        "Counter": "0,1,2,3",
> +        "EventCode": "0x5C",
> +        "EventName": "UNC_CHA_SNOOP_RESP.RSP_FWD_WB",
> +        "PerPkg": "1",
> +        "PublicDescription": "Counts when a transaction with the opcode =
type Rsp*Fwd*WB Snoop Response was received which indicates the data was wr=
itten back to it's home socket, and the cacheline was forwarded to the requ=
estor socket.  This snoop response is only used in >=3D 4 socket systems.  =
It is used when a snoop HITM's in a remote caching agent and it directly fo=
rwards data to a requestor, and simultaneously returns data to it's home so=
cket to be written back to memory.",
> +        "UMask": "0x20",
> +        "Unit": "CHA"
> +    },
> +    {
> +        "BriefDescription": "Rsp*WB Snoop Responses Received",
> +        "Counter": "0,1,2,3",
> +        "EventCode": "0x5C",
> +        "EventName": "UNC_CHA_SNOOP_RESP.RSP_WBWB",
> +        "PerPkg": "1",
> +        "PublicDescription": "Counts when a transaction with the opcode =
type Rsp*WB Snoop Response was received which indicates which indicates the=
 data was written back to it's home.  This is returned when a non-RFO reque=
st hits a cacheline in the Modified state. The Cache can either downgrade t=
he cacheline to a S (Shared) or I (Invalid) state depending on how the syst=
em has been configured.  This reponse will also be sent when a cache reques=
ts E (Exclusive) ownership of a cache line without receiving data, because =
the cache must acquire ownership.",
> +        "UMask": "0x10",
> +        "Unit": "CHA"
> +    },
> +    {
> +        "Counter": "0,1,2,3",
> +        "EventCode": "0x35",
> +        "EventName": "UNC_CHA_TOR_INSERTS.IA_HIT_CRD",
> +        "Filter": "config1=3D0x40233",
> +        "PerPkg": "1",
> +        "UMask": "0x11",
> +        "Unit": "CHA"
> +    },
> +    {
> +        "Counter": "0,1,2,3",
> +        "EventCode": "0x35",
> +        "EventName": "UNC_CHA_TOR_INSERTS.IA_HIT_DRD",
> +        "Filter": "config1=3D0x40433",
> +        "PerPkg": "1",
> +        "UMask": "0x11",
> +        "Unit": "CHA"
> +    },
> +    {
> +        "Counter": "0,1,2,3",
> +        "EventCode": "0x35",
> +        "EventName": "UNC_CHA_TOR_INSERTS.IA_HIT_LlcPrefCRD",
> +        "Filter": "config1=3D0x4b233",
> +        "PerPkg": "1",
> +        "UMask": "0x11",
> +        "Unit": "CHA"
> +    },
> +    {
> +        "Counter": "0,1,2,3",
> +        "EventCode": "0x35",
> +        "EventName": "UNC_CHA_TOR_INSERTS.IA_HIT_LlcPrefDRD",
> +        "Filter": "config1=3D0x4b433",
> +        "PerPkg": "1",
> +        "UMask": "0x11",
> +        "Unit": "CHA"
> +    },
> +    {
> +        "Counter": "0,1,2,3",
> +        "EventCode": "0x35",
> +        "EventName": "UNC_CHA_TOR_INSERTS.IA_HIT_LlcPrefRFO",
> +        "Filter": "config1=3D0x4b033",
> +        "PerPkg": "1",
> +        "UMask": "0x11",
> +        "Unit": "CHA"
> +    },
> +    {
> +        "Counter": "0,1,2,3",
> +        "EventCode": "0x35",
> +        "EventName": "UNC_CHA_TOR_INSERTS.IA_HIT_RFO",
> +        "Filter": "config1=3D0x40033",
> +        "PerPkg": "1",
> +        "UMask": "0x11",
> +        "Unit": "CHA"
> +    },
> +    {
> +        "Counter": "0,1,2,3",
> +        "EventCode": "0x35",
> +        "EventName": "UNC_CHA_TOR_INSERTS.IA_MISS_CRD",
> +        "Filter": "config1=3D0x40233",
> +        "PerPkg": "1",
> +        "UMask": "0x21",
> +        "Unit": "CHA"
> +    },
> +    {
> +        "Counter": "0,1,2,3",
> +        "EventCode": "0x35",
> +        "EventName": "UNC_CHA_TOR_INSERTS.IA_MISS_DRD",
> +        "Filter": "config1=3D0x40433",
> +        "PerPkg": "1",
> +        "UMask": "0x21",
> +        "Unit": "CHA"
> +    },
> +    {
> +        "Counter": "0,1,2,3",
> +        "EventCode": "0x35",
> +        "EventName": "UNC_CHA_TOR_INSERTS.IA_MISS_LlcPrefCRD",
> +        "Filter": "config1=3D0x4b233",
> +        "PerPkg": "1",
> +        "UMask": "0x21",
> +        "Unit": "CHA"
> +    },
> +    {
> +        "Counter": "0,1,2,3",
> +        "EventCode": "0x35",
> +        "EventName": "UNC_CHA_TOR_INSERTS.IA_MISS_LlcPrefDRD",
> +        "Filter": "config1=3D0x4b433",
> +        "PerPkg": "1",
> +        "UMask": "0x21",
> +        "Unit": "CHA"
> +    },
> +    {
> +        "Counter": "0,1,2,3",
> +        "EventCode": "0x35",
> +        "EventName": "UNC_CHA_TOR_INSERTS.IA_MISS_LlcPrefRFO",
> +        "Filter": "config1=3D0x4b033",
> +        "PerPkg": "1",
> +        "UMask": "0x21",
> +        "Unit": "CHA"
> +    },
> +    {
> +        "Counter": "0,1,2,3",
> +        "EventCode": "0x35",
> +        "EventName": "UNC_CHA_TOR_INSERTS.IA_MISS_RFO",
> +        "Filter": "config1=3D0x40033",
> +        "PerPkg": "1",
> +        "UMask": "0x21",
> +        "Unit": "CHA"
> +    },
> +    {
> +        "EventCode": "0x36",
> +        "EventName": "UNC_CHA_TOR_OCCUPANCY.IA_HIT_CRD",
> +        "Filter": "config1=3D0x40233",
> +        "PerPkg": "1",
> +        "UMask": "0x11",
> +        "Unit": "CHA"
> +    },
> +    {
> +        "EventCode": "0x36",
> +        "EventName": "UNC_CHA_TOR_OCCUPANCY.IA_HIT_DRD",
> +        "Filter": "config1=3D0x40433",
> +        "PerPkg": "1",
> +        "UMask": "0x11",
> +        "Unit": "CHA"
> +    },
> +    {
> +        "EventCode": "0x36",
> +        "EventName": "UNC_CHA_TOR_OCCUPANCY.IA_HIT_LlcPrefCRD",
> +        "Filter": "config1=3D0x4b233",
> +        "PerPkg": "1",
> +        "UMask": "0x11",
> +        "Unit": "CHA"
> +    },
> +    {
> +        "EventCode": "0x36",
> +        "EventName": "UNC_CHA_TOR_OCCUPANCY.IA_HIT_LlcPrefDRD",
> +        "Filter": "config1=3D0x4b433",
> +        "PerPkg": "1",
> +        "UMask": "0x11",
> +        "Unit": "CHA"
> +    },
> +    {
> +        "EventCode": "0x36",
> +        "EventName": "UNC_CHA_TOR_OCCUPANCY.IA_HIT_LlcPrefRFO",
> +        "Filter": "config1=3D0x4b033",
> +        "PerPkg": "1",
> +        "UMask": "0x11",
> +        "Unit": "CHA"
> +    },
> +    {
> +        "EventCode": "0x36",
> +        "EventName": "UNC_CHA_TOR_OCCUPANCY.IA_HIT_RFO",
> +        "Filter": "config1=3D0x40033",
> +        "PerPkg": "1",
> +        "UMask": "0x11",
> +        "Unit": "CHA"
> +    },
> +    {
> +        "EventCode": "0x36",
> +        "EventName": "UNC_CHA_TOR_OCCUPANCY.IA_MISS_CRD",
> +        "Filter": "config1=3D0x40233",
> +        "PerPkg": "1",
> +        "UMask": "0x21",
> +        "Unit": "CHA"
> +    },
> +    {
> +        "EventCode": "0x36",
> +        "EventName": "UNC_CHA_TOR_OCCUPANCY.IA_MISS_DRD",
> +        "Filter": "config1=3D0x40433",
> +        "PerPkg": "1",
> +        "UMask": "0x21",
> +        "Unit": "CHA"
> +    },
> +    {
> +        "EventCode": "0x36",
> +        "EventName": "UNC_CHA_TOR_OCCUPANCY.IA_MISS_LlcPrefCRD",
> +        "Filter": "config1=3D0x4b233",
> +        "PerPkg": "1",
> +        "UMask": "0x21",
> +        "Unit": "CHA"
> +    },
> +    {
> +        "EventCode": "0x36",
> +        "EventName": "UNC_CHA_TOR_OCCUPANCY.IA_MISS_LlcPrefDRD",
> +        "Filter": "config1=3D0x4b433",
> +        "PerPkg": "1",
> +        "UMask": "0x21",
> +        "Unit": "CHA"
> +    },
> +    {
> +        "EventCode": "0x36",
> +        "EventName": "UNC_CHA_TOR_OCCUPANCY.IA_MISS_LlcPrefRFO",
> +        "Filter": "config1=3D0x4b033",
> +        "PerPkg": "1",
> +        "UMask": "0x21",
> +        "Unit": "CHA"
> +    },
> +    {
> +        "EventCode": "0x36",
> +        "EventName": "UNC_CHA_TOR_OCCUPANCY.IA_MISS_RFO",
> +        "Filter": "config1=3D0x40033",
> +        "PerPkg": "1",
> +        "UMask": "0x21",
> +        "Unit": "CHA"
> +    },
> +    {
> +        "BriefDescription": "Clockticks of the IIO Traffic Controller",
> +        "Counter": "0,1,2,3",
> +        "EventCode": "0x1",
> +        "EventName": "UNC_IIO_CLOCKTICKS",
> +        "PerPkg": "1",
> +        "PublicDescription": "Counts clockticks of the 1GHz trafiic cont=
roller clock in the IIO unit.",
> +        "Unit": "IIO"
> +    },
> +    {
> +        "BriefDescription": "Read request for 4 bytes made by the CPU to=
 IIO Part0",
> +        "Counter": "2,3",
> +        "EventCode": "0xC0",
> +        "EventName": "UNC_IIO_DATA_REQ_BY_CPU.MEM_READ.PART0",
> +        "FCMask": "0x07",
> +        "Filter": "fc, chnl",
> +        "PerPkg": "1",
> +        "PortMask": "0x01",
> +        "PublicDescription": "Counts every read request for 4 bytes of d=
ata made by a unit on the main die (generally a core) or by another IIO uni=
t to the MMIO space of a card on IIO Part0. In the general case, Part0 refe=
rs to a standard PCIe card of any size (x16,x8,x4) that is plugged directly=
 into one of the PCIe slots. Part0 could also refer to any device plugged i=
nto the first slot of a PCIe riser card or to a device attached to the IIO =
unit which starts its use of the bus using lane 0 of the 16 lanes supported=
 by the bus.",
> +        "UMask": "0x04",
> +        "Unit": "IIO"
> +    },
> +    {
> +        "BriefDescription": "Read request for 4 bytes made by the CPU to=
 IIO Part1",
> +        "Counter": "2,3",
> +        "EventCode": "0xC0",
> +        "EventName": "UNC_IIO_DATA_REQ_BY_CPU.MEM_READ.PART1",
> +        "FCMask": "0x07",
> +        "Filter": "fc, chnl",
> +        "PerPkg": "1",
> +        "PortMask": "0x02",
> +        "PublicDescription": "Counts every read request for 4 bytes of d=
ata made by a unit on the main die (generally a core) or by another IIO uni=
t to the MMIO space of a card on IIO Part1. In the general case, Part1 refe=
rs to a x4 PCIe card plugged into the second slot of a PCIe riser card, but=
 it could refer to any x4 device attached to the IIO unit using lanes start=
ing at lane 4 of the 16 lanes supported by the bus.",
> +        "UMask": "0x04",
> +        "Unit": "IIO"
> +    },
> +    {
> +        "BriefDescription": "Read request for 4 bytes made by the CPU to=
 IIO Part2",
> +        "Counter": "2,3",
> +        "EventCode": "0xC0",
> +        "EventName": "UNC_IIO_DATA_REQ_BY_CPU.MEM_READ.PART2",
> +        "FCMask": "0x07",
> +        "Filter": "fc, chnl",
> +        "PerPkg": "1",
> +        "PortMask": "0x04",
> +        "PublicDescription": "Counts every read request for 4 bytes of d=
ata made by a unit on the main die (generally a core) or by another IIO uni=
t to the MMIO space of a card on IIO Part2. In the general case, Part2 refe=
rs to a x4 or x8 PCIe card plugged into the third slot of a PCIe riser card=
, but it could refer to any x4 or x8 device attached to the IIO unit and us=
ing lanes starting at lane 8 of the 16 lanes supported by the bus.",
> +        "UMask": "0x04",
> +        "Unit": "IIO"
> +    },
> +    {
> +        "BriefDescription": "Read request for 4 bytes made by the CPU to=
 IIO Part3",
> +        "Counter": "2,3",
> +        "EventCode": "0xC0",
> +        "EventName": "UNC_IIO_DATA_REQ_BY_CPU.MEM_READ.PART3",
> +        "FCMask": "0x07",
> +        "Filter": "fc, chnl",
> +        "PerPkg": "1",
> +        "PortMask": "0x08",
> +        "PublicDescription": "Counts every read request for 4 bytes of d=
ata made by a unit on the main die (generally a core) or by another IIO uni=
t to the MMIO space of a card on IIO Part3. In the general case, Part3 refe=
rs to a x4 PCIe card plugged into the fourth slot of a PCIe riser card, but=
 it could brefer to  any device attached to the IIO unit using the lanes st=
arting at lane 12 of the 16 lanes supported by the bus.",
> +        "UMask": "0x04",
> +        "Unit": "IIO"
> +    },
> +    {
> +        "BriefDescription": "Write request of 4 bytes made to IIO Part0 =
by the CPU",
> +        "Counter": "2,3",
> +        "EventCode": "0xC0",
> +        "EventName": "UNC_IIO_DATA_REQ_BY_CPU.MEM_WRITE.PART0",
> +        "FCMask": "0x07",
> +        "Filter": "fc, chnl",
> +        "PerPkg": "1",
> +        "PortMask": "0x01",
> +        "PublicDescription": "Counts every write request of 4 bytes of d=
ata made to the MMIO space of a card on IIO Part0 by a unit on the main die=
 (generally a core) or by another IIO unit. In the general case, Part0 refe=
rs to a standard PCIe card of any size (x16,x8,x4) that is plugged directly=
 into one of the PCIe slots. Part0 could also refer to any device plugged i=
nto the first slot of a PCIe riser card or to a device attached to the IIO =
unit which starts its use of the bus using lane 0 of the 16 lanes supported=
 by the bus.",
> +        "UMask": "0x01",
> +        "Unit": "IIO"
> +    },
> +    {
> +        "BriefDescription": "Write request of 4 bytes made to IIO Part1 =
by the CPU",
> +        "Counter": "2,3",
> +        "EventCode": "0xC0",
> +        "EventName": "UNC_IIO_DATA_REQ_BY_CPU.MEM_WRITE.PART1",
> +        "FCMask": "0x07",
> +        "Filter": "fc, chnl",
> +        "PerPkg": "1",
> +        "PortMask": "0x02",
> +        "PublicDescription": "Counts every write request of 4 bytes of d=
ata made to the MMIO space of a card on IIO Part1 by a unit on the main die=
 (generally a core) or by another IIO unit. In the general case, Part1 refe=
rs to a x4 PCIe card plugged into the second slot of a PCIe riser card, but=
 it could refer to any x4 device attached to the IIO unit using lanes start=
ing at lane 4 of the 16 lanes supported by the bus.",
> +        "UMask": "0x01",
> +        "Unit": "IIO"
> +    },
> +    {
> +        "BriefDescription": "Write request of 4 bytes made to IIO Part2 =
by the CPU",
> +        "Counter": "2,3",
> +        "EventCode": "0xC0",
> +        "EventName": "UNC_IIO_DATA_REQ_BY_CPU.MEM_WRITE.PART2",
> +        "FCMask": "0x07",
> +        "Filter": "fc, chnl",
> +        "PerPkg": "1",
> +        "PortMask": "0x04",
> +        "PublicDescription": "Counts every write request of 4 bytes of d=
ata made to the MMIO space of a card on IIO Part2 by  a unit on the main di=
e (generally a core) or by another IIO unit. In the general case, Part2 ref=
ers to a x4 or x8 PCIe card plugged into the third slot of a PCIe riser car=
d, but it could refer to any x4 or x8 device attached to the IIO unit and u=
sing lanes starting at lane 8 of the 16 lanes supported by the bus.",
> +        "UMask": "0x01",
> +        "Unit": "IIO"
> +    },
> +    {
> +        "BriefDescription": "Write request of 4 bytes made to IIO Part3 =
by the CPU",
> +        "Counter": "2,3",
> +        "EventCode": "0xC0",
> +        "EventName": "UNC_IIO_DATA_REQ_BY_CPU.MEM_WRITE.PART3",
> +        "FCMask": "0x07",
> +        "Filter": "fc, chnl",
> +        "PerPkg": "1",
> +        "PortMask": "0x08",
> +        "PublicDescription": "Counts every write request of 4 bytes of d=
ata made to the MMIO space of a card on IIO Part3 by  a unit on the main di=
e (generally a core) or by another IIO unit. In the general case, Part3 ref=
ers to a x4 PCIe card plugged into the fourth slot of a PCIe riser card, bu=
t it could brefer to any device attached to the IIO unit using the lanes st=
arting at lane 12 of the 16 lanes supported by the bus.",
> +        "UMask": "0x01",
> +        "Unit": "IIO"
> +    },
> +    {
> +        "BriefDescription": "Peer to peer read request for 4 bytes made =
by a different IIO unit to IIO Part0",
> +        "Counter": "2,3",
> +        "EventCode": "0xC0",
> +        "EventName": "UNC_IIO_DATA_REQ_BY_CPU.PEER_READ.PART0",
> +        "FCMask": "0x07",
> +        "Filter": "fc, chnl",
> +        "PerPkg": "1",
> +        "PortMask": "0x01",
> +        "PublicDescription": "Counts ever peer to peer read request for =
4 bytes of data made by a different IIO unit to the MMIO space of a card on=
 IIO Part0. Does not include requests made by the same IIO unit. In the gen=
eral case, Part0 refers to a standard PCIe card of any size (x16,x8,x4) tha=
t is plugged directly into one of the PCIe slots. Part0 could also refer to=
 any device plugged into the first slot of a PCIe riser card or to a device=
 attached to the IIO unit which starts its use of the bus using lane 0 of t=
he 16 lanes supported by the bus.",
> +        "UMask": "0x08",
> +        "Unit": "IIO"
> +    },
> +    {
> +        "BriefDescription": "Peer to peer read request for 4 bytes made =
by a different IIO unit to IIO Part1",
> +        "Counter": "2,3",
> +        "EventCode": "0xC0",
> +        "EventName": "UNC_IIO_DATA_REQ_BY_CPU.PEER_READ.PART1",
> +        "FCMask": "0x07",
> +        "Filter": "fc, chnl",
> +        "PerPkg": "1",
> +        "PortMask": "0x02",
> +        "PublicDescription": "Counts ever peer to peer read request for =
4 bytes of data made by a different IIO unit to the MMIO space of a card on=
 IIO Part1. Does not include requests made by the same IIO unit. In the gen=
eral case, Part1 refers to a x4 PCIe card plugged into the second slot of a=
 PCIe riser card, but it could refer to any x4 device attached to the IIO u=
nit using lanes starting at lane 4 of the 16 lanes supported by the bus.",
> +        "UMask": "0x08",
> +        "Unit": "IIO"
> +    },
> +    {
> +        "BriefDescription": "Peer to peer read request for 4 bytes made =
by a different IIO unit to IIO Part2",
> +        "Counter": "2,3",
> +        "EventCode": "0xC0",
> +        "EventName": "UNC_IIO_DATA_REQ_BY_CPU.PEER_READ.PART2",
> +        "FCMask": "0x07",
> +        "Filter": "fc, chnl",
> +        "PerPkg": "1",
> +        "PortMask": "0x04",
> +        "PublicDescription": "Counts ever peer to peer read request for =
4 bytes of data made by a different IIO unit to the MMIO space of a card on=
 IIO Part2. Does not include requests made by the same IIO unit. In the gen=
eral case, Part2 refers to a x4 or x8 PCIe card plugged into the third slot=
 of a PCIe riser card, but it could refer to any x4 or x8 device attached t=
o the IIO unit and using lanes starting at lane 8 of the 16 lanes supported=
 by the bus.",
> +        "UMask": "0x08",
> +        "Unit": "IIO"
> +    },
> +    {
> +        "BriefDescription": "Peer to peer read request for 4 bytes made =
by a different IIO unit to IIO Part3",
> +        "Counter": "2,3",
> +        "EventCode": "0xC0",
> +        "EventName": "UNC_IIO_DATA_REQ_BY_CPU.PEER_READ.PART3",
> +        "FCMask": "0x07",
> +        "Filter": "fc, chnl",
> +        "PerPkg": "1",
> +        "PortMask": "0x08",
> +        "PublicDescription": "Counts ever peer to peer read request for =
4 bytes of data made by a different IIO unit to the MMIO space of a card on=
 IIO Part3. Does not include requests made by the same IIO unit. In the gen=
eral case, Part3 refers to a x4 PCIe card plugged into the fourth slot of a=
 PCIe riser card, but it could brefer to  any device attached to the IIO un=
it using the lanes starting at lane 12 of the 16 lanes supported by the bus=
=2E",
> +        "UMask": "0x08",
> +        "Unit": "IIO"
> +    },
> +    {
> +        "BriefDescription": "Peer to peer write request of 4 bytes made =
to IIO Part0 by a different IIO unit",
> +        "Counter": "2,3",
> +        "EventCode": "0xC0",
> +        "EventName": "UNC_IIO_DATA_REQ_BY_CPU.PEER_WRITE.PART0",
> +        "FCMask": "0x07",
> +        "Filter": "fc, chnl",
> +        "PerPkg": "1",
> +        "PortMask": "0x01",
> +        "PublicDescription": "Counts every peer to peer write request of=
 4 bytes of data made to the MMIO space of a card on IIO Part0 by a differe=
nt IIO unit. Does not include requests made by the same IIO unit.  In the g=
eneral case, Part0 refers to a standard PCIe card of any size (x16,x8,x4) t=
hat is plugged directly into one of the PCIe slots. Part0 could also refer =
to any device plugged into the first slot of a PCIe riser card or to a devi=
ce attached to the IIO unit which starts its use of the bus using lane 0 of=
 the 16 lanes supported by the bus.",
> +        "UMask": "0x02",
> +        "Unit": "IIO"
> +    },
> +    {
> +        "BriefDescription": "Peer to peer write request of 4 bytes made =
to IIO Part1 by a different IIO unit",
> +        "Counter": "2,3",
> +        "EventCode": "0xC0",
> +        "EventName": "UNC_IIO_DATA_REQ_BY_CPU.PEER_WRITE.PART1",
> +        "FCMask": "0x07",
> +        "Filter": "fc, chnl",
> +        "PerPkg": "1",
> +        "PortMask": "0x02",
> +        "PublicDescription": "Counts every peer to peer write request of=
 4 bytes of data made to the MMIO space of a card on IIO Part1 by a differe=
nt IIO unit. Does not include requests made by the same IIO unit. In the ge=
neral case, Part1 refers to a x4 PCIe card plugged into the second slot of =
a PCIe riser card, but it could refer to any x4 device attached to the IIO =
unit using lanes starting at lane 4 of the 16 lanes supported by the bus.",
> +        "UMask": "0x02",
> +        "Unit": "IIO"
> +    },
> +    {
> +        "BriefDescription": "Peer to peer write request of 4 bytes made =
to IIO Part2 by a different IIO unit",
> +        "Counter": "2,3",
> +        "EventCode": "0xC0",
> +        "EventName": "UNC_IIO_DATA_REQ_BY_CPU.PEER_WRITE.PART2",
> +        "FCMask": "0x07",
> +        "Filter": "fc, chnl",
> +        "PerPkg": "1",
> +        "PortMask": "0x04",
> +        "PublicDescription": "Counts every peer to peer write request of=
 4 bytes of data made to the MMIO space of a card on IIO Part2 by a differe=
nt IIO unit. Does not include requests made by the same IIO unit. In the ge=
neral case, Part2 refers to a x4 or x8 PCIe card plugged into the third slo=
t of a PCIe riser card, but it could refer to any x4 or x8 device attached =
to the IIO unit and using lanes starting at lane 8 of the 16 lanes supporte=
d by the bus.",
> +        "UMask": "0x02",
> +        "Unit": "IIO"
> +    },
> +    {
> +        "BriefDescription": "Peer to peer write request of 4 bytes made =
to IIO Part3 by a different IIO unit",
> +        "Counter": "2,3",
> +        "EventCode": "0xC0",
> +        "EventName": "UNC_IIO_DATA_REQ_BY_CPU.PEER_WRITE.PART3",
> +        "FCMask": "0x07",
> +        "Filter": "fc, chnl",
> +        "PerPkg": "1",
> +        "PortMask": "0x08",
> +        "PublicDescription": "Counts every peer to peer write request of=
 4 bytes of data made to the MMIO space of a card on IIO Part3 by a differe=
nt IIO unit. Does not include requests made by the same IIO unit. In the ge=
neral case, Part3 refers to a x4 PCIe card plugged into the fourth slot of =
a PCIe riser card, but it could brefer to any device attached to the IIO un=
it using the lanes starting at lane 12 of the 16 lanes supported by the bus=
=2E",
> +        "UMask": "0x02",
> +        "Unit": "IIO"
> +    },
> +    {
> +        "BriefDescription": "Peer to peer read request for 4 bytes made =
by IIO Part0 to an IIO target",
> +        "Counter": "0,1",
> +        "EventCode": "0x83",
> +        "EventName": "UNC_IIO_DATA_REQ_OF_CPU.PEER_READ.PART0",
> +        "FCMask": "0x07",
> +        "Filter": "fc, chnl",
> +        "PerPkg": "1",
> +        "PortMask": "0x01",
> +        "PublicDescription": "Counts every peer to peer read request for=
 4 bytes of data made by IIO Part0 to the MMIO space of an IIO target. In t=
he general case, Part0 refers to a standard PCIe card of any size (x16,x8,x=
4) that is plugged directly into one of the PCIe slots. Part0 could also re=
fer to any device plugged into the first slot of a PCIe riser card or to a =
device attached to the IIO unit which starts its use of the bus using lane =
0 of the 16 lanes supported by the bus.",
> +        "UMask": "0x08",
> +        "Unit": "IIO"
> +    },
> +    {
> +        "BriefDescription": "Peer to peer read request for 4 bytes made =
by IIO Part1 to an IIO target",
> +        "Counter": "0,1",
> +        "EventCode": "0x83",
> +        "EventName": "UNC_IIO_DATA_REQ_OF_CPU.PEER_READ.PART1",
> +        "FCMask": "0x07",
> +        "Filter": "fc, chnl",
> +        "PerPkg": "1",
> +        "PortMask": "0x02",
> +        "PublicDescription": "Counts every peer to peer read request for=
 4 bytes of data made by IIO Part1 to the MMIO space of an IIO target. In t=
he general case, Part1 refers to a x4 PCIe card plugged into the second slo=
t of a PCIe riser card, but it could refer to any x4 device attached to the=
 IIO unit using lanes starting at lane 4 of the 16 lanes supported by the b=
us.",
> +        "UMask": "0x08",
> +        "Unit": "IIO"
> +    },
> +    {
> +        "BriefDescription": "Peer to peer read request for 4 bytes made =
by IIO Part2 to an IIO target",
> +        "Counter": "0,1",
> +        "EventCode": "0x83",
> +        "EventName": "UNC_IIO_DATA_REQ_OF_CPU.PEER_READ.PART2",
> +        "FCMask": "0x07",
> +        "Filter": "fc, chnl",
> +        "PerPkg": "1",
> +        "PortMask": "0x04",
> +        "PublicDescription": "Counts every peer to peer read request for=
 4 bytes of data made by IIO Part2 to the MMIO space of an IIO target. In t=
he general case, Part2 refers to a x4 or x8 PCIe card plugged into the thir=
d slot of a PCIe riser card, but it could refer to any x4 or x8 device atta=
ched to the IIO unit and using lanes starting at lane 8 of the 16 lanes sup=
ported by the bus.",
> +        "UMask": "0x08",
> +        "Unit": "IIO"
> +    },
> +    {
> +        "BriefDescription": "Peer to peer read request for 4 bytes made =
by IIO Part3 to an IIO target",
> +        "Counter": "0,1",
> +        "EventCode": "0x83",
> +        "EventName": "UNC_IIO_DATA_REQ_OF_CPU.PEER_READ.PART3",
> +        "FCMask": "0x07",
> +        "Filter": "fc, chnl",
> +        "PerPkg": "1",
> +        "PortMask": "0x08",
> +        "PublicDescription": "Counts every peer to peer read request for=
 4 bytes of data made by IIO Part3 to the MMIO space of an IIO target. In t=
he general case, Part3 refers to a x4 PCIe card plugged into the fourth slo=
t of a PCIe riser card, but it could brefer to any device attached to the I=
IO unit using the lanes starting at lane 12 of the 16 lanes supported by th=
e bus.",
> +        "UMask": "0x08",
> +        "Unit": "IIO"
> +    },
> +    {
> +        "BriefDescription": "Peer to peer write request of 4 bytes made =
by IIO Part0 to an IIO target",
> +        "Counter": "0,1",
> +        "EventCode": "0x83",
> +        "EventName": "UNC_IIO_DATA_REQ_OF_CPU.PEER_WRITE.PART0",
> +        "FCMask": "0x07",
> +        "Filter": "fc, chnl",
> +        "PerPkg": "1",
> +        "PortMask": "0x01",
> +        "PublicDescription": "Counts every peer to peer write request of=
 4 bytes of data made by IIO Part0 to the MMIO space of an IIO target. In t=
he general case, Part0 refers to a standard PCIe card of any size (x16,x8,x=
4) that is plugged directly into one of the PCIe slots. Part0 could also re=
fer to any device plugged into the first slot of a PCIe riser card or to a =
device attached to the IIO unit which starts its use of the bus using lane =
0 of the 16 lanes supported by the bus.",
> +        "UMask": "0x02",
> +        "Unit": "IIO"
> +    },
> +    {
> +        "BriefDescription": "Peer to peer write request of 4 bytes made =
by IIO Part0 to an IIO target",
> +        "Counter": "0,1",
> +        "EventCode": "0x83",
> +        "EventName": "UNC_IIO_DATA_REQ_OF_CPU.PEER_WRITE.PART1",
> +        "FCMask": "0x07",
> +        "Filter": "fc, chnl",
> +        "PerPkg": "1",
> +        "PortMask": "0x02",
> +        "PublicDescription": "Counts every peer to peer write request of=
 4 bytes of data made by IIO Part1 to the MMIO space of an IIO target. In t=
he general case, Part1 refers to a x4 PCIe card plugged into the second slo=
t of a PCIe riser card, but it could refer to any x4 device attached to the=
 IIO unit using lanes starting at lane 4 of the 16 lanes supported by the b=
us.",
> +        "UMask": "0x02",
> +        "Unit": "IIO"
> +    },
> +    {
> +        "BriefDescription": "Peer to peer write request of 4 bytes made =
by IIO Part0 to an IIO target",
> +        "Counter": "0,1",
> +        "EventCode": "0x83",
> +        "EventName": "UNC_IIO_DATA_REQ_OF_CPU.PEER_WRITE.PART2",
> +        "FCMask": "0x07",
> +        "Filter": "fc, chnl",
> +        "PerPkg": "1",
> +        "PortMask": "0x04",
> +        "PublicDescription": "Counts every peer to peer write request of=
 4 bytes of data made by IIO Part2 to the MMIO space of an IIO target. In t=
he general case, Part2 refers to a x4 or x8 PCIe card plugged into the thir=
d slot of a PCIe riser card, but it could refer to any x4 or x8 device atta=
ched to the IIO unit and using lanes starting at lane 8 of the 16 lanes sup=
ported by the bus.",
> +        "UMask": "0x02",
> +        "Unit": "IIO"
> +    },
> +    {
> +        "BriefDescription": "Peer to peer write request of 4 bytes made =
by IIO Part0 to an IIO target",
> +        "Counter": "0,1",
> +        "EventCode": "0x83",
> +        "EventName": "UNC_IIO_DATA_REQ_OF_CPU.PEER_WRITE.PART3",
> +        "FCMask": "0x07",
> +        "Filter": "fc, chnl",
> +        "PerPkg": "1",
> +        "PortMask": "0x08",
> +        "PublicDescription": "Counts every peer to peer write request of=
 4 bytes of data made by IIO Part3 to the MMIO space of an IIO target. In t=
he general case, Part3 refers to a x4 PCIe card plugged into the fourth slo=
t of a PCIe riser card, but it could brefer to  any device attached to the =
IIO unit using the lanes starting at lane 12 of the 16 lanes supported by t=
he bus.",
> +        "UMask": "0x02",
> +        "Unit": "IIO"
> +    },
> +    {
> +        "BriefDescription": "Read request for up to a 64 byte transactio=
n is made by the CPU to IIO Part0",
> +        "Counter": "0,1,2,3",
> +        "EventCode": "0xC1",
> +        "EventName": "UNC_IIO_TXN_REQ_BY_CPU.MEM_READ.PART0",
> +        "FCMask": "0x07",
> +        "Filter": "fc, chnl",
> +        "PerPkg": "1",
> +        "PortMask": "0x01",
> +        "PublicDescription": "Counts every read request for up to a 64 b=
yte transaction of data made by a unit on the main die (generally a core) o=
r by another IIO unit to the MMIO space of a card on IIO Part0. In the gene=
ral case, part0 refers to a standard PCIe card of any size (x16,x8,x4) that=
 is plugged directly into one of the PCIe slots. Part0 could also refer to =
any device plugged into the first slot of a PCIe riser card or to a device =
attached to the IIO unit which starts its use of the bus using lane 0 of th=
e 16 lanes supported by the bus.",
> +        "UMask": "0x04",
> +        "Unit": "IIO"
> +    },
> +    {
> +        "BriefDescription": "Read request for up to a 64 byte transactio=
n is made by the CPU to IIO Part1",
> +        "Counter": "0,1,2,3",
> +        "EventCode": "0xC1",
> +        "EventName": "UNC_IIO_TXN_REQ_BY_CPU.MEM_READ.PART1",
> +        "FCMask": "0x07",
> +        "Filter": "fc, chnl",
> +        "PerPkg": "1",
> +        "PortMask": "0x02",
> +        "PublicDescription": "Counts every read request for up to a 64 b=
yte transaction of data made by a unit on the main die (generally a core) o=
r by another IIO unit to the MMIO space of a card on IIO Part1. In the gene=
ral case, Part1 refers to a x4 PCIe card plugged into the second slot of a =
PCIe riser card, but it could refer to any x4 device attached to the IIO un=
it using lanes starting at lane 4 of the 16 lanes supported by the bus.",
> +        "UMask": "0x04",
> +        "Unit": "IIO"
> +    },
> +    {
> +        "BriefDescription": "Read request for up to a 64 byte transactio=
n is made by the CPU to IIO Part2",
> +        "Counter": "0,1,2,3",
> +        "EventCode": "0xC1",
> +        "EventName": "UNC_IIO_TXN_REQ_BY_CPU.MEM_READ.PART2",
> +        "FCMask": "0x07",
> +        "Filter": "fc, chnl",
> +        "PerPkg": "1",
> +        "PortMask": "0x04",
> +        "PublicDescription": "Counts every read request for up to a 64 b=
yte transaction of data made by a unit on the main die (generally a core) o=
r by another IIO unit to the MMIO space of a card on IIO Part2. In the gene=
ral case, Part2 refers to a x4 or x8 PCIe card plugged into the third slot =
of a PCIe riser card, but it could refer to any x4 or x8 device attached to=
 the IIO unit and using lanes starting at lane 8 of the 16 lanes supported =
by the bus.",
> +        "UMask": "0x04",
> +        "Unit": "IIO"
> +    },
> +    {
> +        "BriefDescription": "Read request for up to a 64 byte transactio=
n is made by the CPU to IIO Part3",
> +        "Counter": "0,1,2,3",
> +        "EventCode": "0xC1",
> +        "EventName": "UNC_IIO_TXN_REQ_BY_CPU.MEM_READ.PART3",
> +        "FCMask": "0x07",
> +        "Filter": "fc, chnl",
> +        "PerPkg": "1",
> +        "PortMask": "0x08",
> +        "PublicDescription": "Counts every read request for up to a 64 b=
yte transaction of data made by a unit on the main die (generally a core) o=
r by another IIO unit to the MMIO space of a card on IIO Part3. In the gene=
ral case, Part3 refers to a x4 PCIe card plugged into the fourth slot of a =
PCIe riser card, but it could brefer to  any device attached to the IIO uni=
t using the lanes starting at lane 12 of the 16 lanes supported by the bus.=
",
> +        "UMask": "0x04",
> +        "Unit": "IIO"
> +    },
> +    {
> +        "BriefDescription": "Write request of up to a 64 byte transactio=
n is made to IIO Part0 by the CPU",
> +        "Counter": "0,1,2,3",
> +        "EventCode": "0xC1",
> +        "EventName": "UNC_IIO_TXN_REQ_BY_CPU.MEM_WRITE.PART0",
> +        "FCMask": "0x07",
> +        "Filter": "fc, chnl",
> +        "PerPkg": "1",
> +        "PortMask": "0x01",
> +        "PublicDescription": "Counts every write request of up to a 64 b=
yte transaction of data made to the MMIO space of a card on IIO Part0 by a =
unit on the main die (generally a core) or by another IIO unit. In the gene=
ral case, Part0 refers to a standard PCIe card of any size (x16,x8,x4) that=
 is plugged directly into one of the PCIe slots. Part0 could also refer to =
any device plugged into the first slot of a PCIe riser card or to a device =
attached to the IIO unit which starts its use of the bus using lane 0 of th=
e 16 lanes supported by the bus.",
> +        "UMask": "0x01",
> +        "Unit": "IIO"
> +    },
> +    {
> +        "BriefDescription": "Write request of up to a 64 byte transactio=
n is made to IIO Part1 by the CPU",
> +        "Counter": "0,1,2,3",
> +        "EventCode": "0xC1",
> +        "EventName": "UNC_IIO_TXN_REQ_BY_CPU.MEM_WRITE.PART1",
> +        "FCMask": "0x07",
> +        "Filter": "fc, chnl",
> +        "PerPkg": "1",
> +        "PortMask": "0x02",
> +        "PublicDescription": "Counts every write request of up to a 64 b=
yte transaction of data made to the MMIO space of a card on IIO Part1 by a =
unit on the main die (generally a core) or by another IIO unit. In the gene=
ral case, Part1 refers to a x4 PCIe card plugged into the second slot of a =
PCIe riser card, but it could refer to any x4 device attached to the IIO un=
it using lanes starting at lane 4 of the 16 lanes supported by the bus.",
> +        "UMask": "0x01",
> +        "Unit": "IIO"
> +    },
> +    {
> +        "BriefDescription": "Write request of up to a 64 byte transactio=
n is made to IIO Part2 by the CPU",
> +        "Counter": "0,1,2,3",
> +        "EventCode": "0xC1",
> +        "EventName": "UNC_IIO_TXN_REQ_BY_CPU.MEM_WRITE.PART2",
> +        "FCMask": "0x07",
> +        "Filter": "fc, chnl",
> +        "PerPkg": "1",
> +        "PortMask": "0x04",
> +        "PublicDescription": "Counts every write request of up to a 64 b=
yte transaction of data made to the MMIO space of a card on IIO Part2 by a =
unit on the main die (generally a core) or by another IIO unit. In the gene=
ral case, Part2 refers to a x4 or x8 PCIe card plugged into the third slot =
of a PCIe riser card, but it could refer to any x4 or x8 device attached to=
 the IIO unit and using lanes starting at lane 8 of the 16 lanes supported =
by the bus.",
> +        "UMask": "0x01",
> +        "Unit": "IIO"
> +    },
> +    {
> +        "BriefDescription": "Write request of up to a 64 byte transactio=
n is made to IIO Part3 by the CPU",
> +        "Counter": "0,1,2,3",
> +        "EventCode": "0xC1",
> +        "EventName": "UNC_IIO_TXN_REQ_BY_CPU.MEM_WRITE.PART3",
> +        "FCMask": "0x07",
> +        "Filter": "fc, chnl",
> +        "PerPkg": "1",
> +        "PortMask": "0x08",
> +        "PublicDescription": "Counts every write request of up to a 64 b=
yte transaction of data made to the MMIO space of a card on IIO Part3 by a =
unit on the main die (generally a core) or by another IIO unit. In the gene=
ral case, Part3 refers to a x4 PCIe card plugged into the fourth slot of a =
PCIe riser card, but it could brefer to  any device attached to the IIO uni=
t using the lanes starting at lane 12 of the 16 lanes supported by the bus.=
",
> +        "UMask": "0x01",
> +        "Unit": "IIO"
> +    },
> +    {
> +        "BriefDescription": "Peer to peer read request for up to a 64 by=
te transaction is made by a different IIO unit to IIO Part0",
> +        "Counter": "0,1,2,3",
> +        "EventCode": "0xC1",
> +        "EventName": "UNC_IIO_TXN_REQ_BY_CPU.PEER_READ.PART0",
> +        "FCMask": "0x07",
> +        "Filter": "fc, chnl",
> +        "PerPkg": "1",
> +        "PortMask": "0x01",
> +        "PublicDescription": "Counts every peer to peer read request for=
 up to a 64 byte transaction of data made by a different IIO unit to the MM=
IO space of a card on IIO Part0. Does not include requests made by the same=
 IIO unit. In the general case, part0 refers to a standard PCIe card of any=
 size (x16,x8,x4) that is plugged directly into one of the PCIe slots. Part=
0 could also refer to any device plugged into the first slot of a PCIe rise=
r card or to a device attached to the IIO unit which starts its use of the =
bus using lane 0 of the 16 lanes supported by the bus.",
> +        "UMask": "0x08",
> +        "Unit": "IIO"
> +    },
> +    {
> +        "BriefDescription": "Peer to peer read request for up to a 64 by=
te transaction is made by a different IIO unit to IIO Part1",
> +        "Counter": "0,1,2,3",
> +        "EventCode": "0xC1",
> +        "EventName": "UNC_IIO_TXN_REQ_BY_CPU.PEER_READ.PART1",
> +        "FCMask": "0x07",
> +        "Filter": "fc, chnl",
> +        "PerPkg": "1",
> +        "PortMask": "0x02",
> +        "PublicDescription": "Counts every peer to peer read request for=
 up to a 64 byte transaction of data made by a different IIO unit to the MM=
IO space of a card on IIO Part1. Does not include requests made by the same=
 IIO unit. In the general case, Part1 refers to a x4 PCIe card plugged into=
 the second slot of a PCIe riser card, but it could refer to any x4 device =
attached to the IIO unit using lanes starting at lane 4 of the 16 lanes sup=
ported by the bus.",
> +        "UMask": "0x08",
> +        "Unit": "IIO"
> +    },
> +    {
> +        "BriefDescription": "Peer to peer read request for up to a 64 by=
te transaction is made by a different IIO unit to IIO Part2",
> +        "Counter": "0,1,2,3",
> +        "EventCode": "0xC1",
> +        "EventName": "UNC_IIO_TXN_REQ_BY_CPU.PEER_READ.PART2",
> +        "FCMask": "0x07",
> +        "Filter": "fc, chnl",
> +        "PerPkg": "1",
> +        "PortMask": "0x04",
> +        "PublicDescription": "Counts every peer to peer read request for=
 up to a 64 byte transaction of data made by a different IIO unit to the MM=
IO space of a card on IIO Part2. Does not include requests made by the same=
 IIO unit. In the general case, Part2 refers to a x4 or x8 PCIe card plugge=
d into the third slot of a PCIe riser card, but it could refer to any x4 or=
 x8 device attached to the IIO unit and using lanes starting at lane 8 of t=
he 16 lanes supported by the bus.",
> +        "UMask": "0x08",
> +        "Unit": "IIO"
> +    },
> +    {
> +        "BriefDescription": "Peer to peer read request for up to a 64 by=
te transaction is made by a different IIO unit to IIO Part3",
> +        "Counter": "0,1,2,3",
> +        "EventCode": "0xC1",
> +        "EventName": "UNC_IIO_TXN_REQ_BY_CPU.PEER_READ.PART3",
> +        "FCMask": "0x07",
> +        "Filter": "fc, chnl",
> +        "PerPkg": "1",
> +        "PortMask": "0x08",
> +        "PublicDescription": "Counts every peer to peer read request for=
 up to a 64 byte transaction of data made by a different IIO unit to the MM=
IO space of a card on IIO Part3. Does not include requests made by the same=
 IIO unit. In the general case, Part3 refers to a x4 PCIe card plugged into=
 the fourth slot of a PCIe riser card, but it could brefer to  any device a=
ttached to the IIO unit using the lanes starting at lane 12 of the 16 lanes=
 supported by the bus.",
> +        "UMask": "0x08",
> +        "Unit": "IIO"
> +    },
> +    {
> +        "BriefDescription": "Peer to peer write request of up to a 64 by=
te transaction is made to IIO Part0 by a different IIO unit",
> +        "Counter": "0,1,2,3",
> +        "EventCode": "0xC1",
> +        "EventName": "UNC_IIO_TXN_REQ_BY_CPU.PEER_WRITE.PART0",
> +        "FCMask": "0x07",
> +        "Filter": "fc, chnl",
> +        "PerPkg": "1",
> +        "PortMask": "0x01",
> +        "PublicDescription": "Counts every peer to peer write request of=
 up to a 64 byte transaction of data made to the MMIO space of a card on II=
O Part0 by a different IIO unit. Does not include requests made by the same=
 IIO unit. In the general case, Part0 refers to a standard PCIe card of any=
 size (x16,x8,x4) that is plugged directly into one of the PCIe slots. Part=
0 could also refer to any device plugged into the first slot of a PCIe rise=
r card or to a device attached to the IIO unit which starts its use of the =
bus using lane 0 of the 16 lanes supported by the bus.",
> +        "UMask": "0x02",
> +        "Unit": "IIO"
> +    },
> +    {
> +        "BriefDescription": "Peer to peer write request of up to a 64 by=
te transaction is made to IIO Part1 by a different IIO unit",
> +        "Counter": "0,1,2,3",
> +        "EventCode": "0xC1",
> +        "EventName": "UNC_IIO_TXN_REQ_BY_CPU.PEER_WRITE.PART1",
> +        "FCMask": "0x07",
> +        "Filter": "fc, chnl",
> +        "PerPkg": "1",
> +        "PortMask": "0x02",
> +        "PublicDescription": "Counts every peer to peer write request of=
 up to a 64 byte transaction of data made to the MMIO space of a card on II=
O Part1 by a different IIO unit. Does not include requests made by the same=
 IIO unit. In the general case, Part1 refers to a x4 PCIe card plugged into=
 the second slot of a PCIe riser card, but it could refer to any x4 device =
attached to the IIO unit using lanes starting at lane 4 of the 16 lanes sup=
ported by the bus.",
> +        "UMask": "0x02",
> +        "Unit": "IIO"
> +    },
> +    {
> +        "BriefDescription": "Peer to peer write request of up to a 64 by=
te transaction is made to IIO Part2 by a different IIO unit",
> +        "Counter": "0,1,2,3",
> +        "EventCode": "0xC1",
> +        "EventName": "UNC_IIO_TXN_REQ_BY_CPU.PEER_WRITE.PART2",
> +        "FCMask": "0x07",
> +        "Filter": "fc, chnl",
> +        "PerPkg": "1",
> +        "PortMask": "0x04",
> +        "PublicDescription": "Counts every peer to peer write request of=
 up to a 64 byte transaction of data made to the MMIO space of a card on II=
O Part2 by a different IIO unit. Does not include requests made by the same=
 IIO unit. In the general case, Part2 refers to a x4 or x8 PCIe card plugge=
d into the third slot of a PCIe riser card, but it could refer to any x4 or=
 x8 device attached to the IIO unit and using lanes starting at lane 8 of t=
he 16 lanes supported by the bus.",
> +        "UMask": "0x02",
> +        "Unit": "IIO"
> +    },
> +    {
> +        "BriefDescription": "Peer to peer write request of up to a 64 by=
te transaction is made to IIO Part3 by a different IIO unit",
> +        "Counter": "0,1,2,3",
> +        "EventCode": "0xC1",
> +        "EventName": "UNC_IIO_TXN_REQ_BY_CPU.PEER_WRITE.PART3",
> +        "FCMask": "0x07",
> +        "Filter": "fc, chnl",
> +        "PerPkg": "1",
> +        "PortMask": "0x08",
> +        "PublicDescription": "Counts every peer to peer write request of=
 up to a 64 byte transaction of data made to the MMIO space of a card on II=
O Part3 by a different IIO unit. Does not include requests made by the same=
 IIO unit. In the general case, Part3 refers to a x4 PCIe card plugged into=
 the fourth slot of a PCIe riser card, but it could brefer to  any device a=
ttached to the IIO unit using the lanes starting at lane 12 of the 16 lanes=
 supported by the bus.",
> +        "UMask": "0x02",
> +        "Unit": "IIO"
> +    },
> +    {
> +        "BriefDescription": "Read request for up to a 64 byte transactio=
n is made by IIO Part0 to Memory",
> +        "Counter": "0,1,2,3",
> +        "EventCode": "0x84",
> +        "EventName": "UNC_IIO_TXN_REQ_OF_CPU.MEM_READ.PART0",
> +        "FCMask": "0x07",
> +        "Filter": "chnl",
> +        "PerPkg": "1",
> +        "PortMask": "0x01",
> +        "PublicDescription": "Counts every read request for up to a 64 b=
yte transaction of data made by IIO Part0 to a unit on the main die (genera=
lly memory). In the general case, Part0 refers to a standard PCIe card of a=
ny size (x16,x8,x4) that is plugged directly into one of the PCIe slots. Pa=
rt0 could also refer to any device plugged into the first slot of a PCIe ri=
ser card or to a device attached to the IIO unit which starts its use of th=
e bus using lane 0 of the 16 lanes supported by the bus.",
> +        "UMask": "0x04",
> +        "Unit": "IIO"
> +    },
> +    {
> +        "BriefDescription": "Read request for up to a 64 byte transactio=
n is  made by IIO Part1 to Memory",
> +        "Counter": "0,1,2,3",
> +        "EventCode": "0x84",
> +        "EventName": "UNC_IIO_TXN_REQ_OF_CPU.MEM_READ.PART1",
> +        "FCMask": "0x07",
> +        "Filter": "chnl",
> +        "PerPkg": "1",
> +        "PortMask": "0x02",
> +        "PublicDescription": "Counts every read request for up to a 64 b=
yte transaction of data made by IIO Part1 to a unit on the main die (genera=
lly memory). In the general case, Part1 refers to a x4 PCIe card plugged in=
to the second slot of a PCIe riser card, but it could refer to any x4 devic=
e attached to the IIO unit using lanes starting at lane 4 of the 16 lanes s=
upported by the bus.",
> +        "UMask": "0x04",
> +        "Unit": "IIO"
> +    },
> +    {
> +        "BriefDescription": "Read request for up to a 64 byte transactio=
n is made by IIO Part2 to Memory",
> +        "Counter": "0,1,2,3",
> +        "EventCode": "0x84",
> +        "EventName": "UNC_IIO_TXN_REQ_OF_CPU.MEM_READ.PART2",
> +        "FCMask": "0x07",
> +        "Filter": "chnl",
> +        "PerPkg": "1",
> +        "PortMask": "0x04",
> +        "PublicDescription": "Counts every read request for up to a 64 b=
yte transaction of data made by IIO Part2 to a unit on the main die (genera=
lly memory). In the general case, Part2 refers to a x4 or x8 PCIe card plug=
ged into the third slot of a PCIe riser card, but it could refer to any x4 =
or x8 device attached to the IIO unit and using lanes starting at lane 8 of=
 the 16 lanes supported by the bus.",
> +        "UMask": "0x04",
> +        "Unit": "IIO"
> +    },
> +    {
> +        "BriefDescription": "Read request for up to a 64 byte transactio=
n is made by IIO Part3 to Memory",
> +        "Counter": "0,1,2,3",
> +        "EventCode": "0x84",
> +        "EventName": "UNC_IIO_TXN_REQ_OF_CPU.MEM_READ.PART3",
> +        "FCMask": "0x07",
> +        "Filter": "chnl",
> +        "PerPkg": "1",
> +        "PortMask": "0x08",
> +        "PublicDescription": "Counts every read request for up to a 64 b=
yte transaction of data made by IIO Part3 to a unit on the main die (genera=
lly memory). In the general case, Part3 refers to a x4 PCIe card plugged in=
to the fourth slot of a PCIe riser card, but it could brefer to  any device=
 attached to the IIO unit using the lanes starting at lane 12 of the 16 lan=
es supported by the bus.",
> +        "UMask": "0x04",
> +        "Unit": "IIO"
> +    },
> +    {
> +        "BriefDescription": "Write request of up to a 64 byte transactio=
n is made by IIO Part0 to Memory",
> +        "Counter": "0,1,2,3",
> +        "EventCode": "0x84",
> +        "EventName": "UNC_IIO_TXN_REQ_OF_CPU.MEM_WRITE.PART0",
> +        "FCMask": "0x07",
> +        "Filter": "chnl",
> +        "PerPkg": "1",
> +        "PortMask": "0x01",
> +        "PublicDescription": "Counts every write request of up to a 64 b=
yte transaction of data made by IIO Part0 to a unit on the main die (genera=
lly memory). In the general case, Part0 refers to a standard PCIe card of a=
ny size (x16,x8,x4) that is plugged directly into one of the PCIe slots. Pa=
rt0 could also refer to any device plugged into the first slot of a PCIe ri=
ser card or to a device attached to the IIO unit which starts its use of th=
e bus using lane 0 of the 16 lanes supported by the bus.",
> +        "UMask": "0x01",
> +        "Unit": "IIO"
> +    },
> +    {
> +        "BriefDescription": "Write request of up to a 64 byte transactio=
n is made by IIO Part1 to Memory",
> +        "Counter": "0,1,2,3",
> +        "EventCode": "0x84",
> +        "EventName": "UNC_IIO_TXN_REQ_OF_CPU.MEM_WRITE.PART1",
> +        "FCMask": "0x07",
> +        "Filter": "chnl",
> +        "PerPkg": "1",
> +        "PortMask": "0x02",
> +        "PublicDescription": "Counts every write request of up to a 64 b=
yte transaction of data made by IIO Part1 to a unit on the main die (genera=
lly memory). In the general case, Part1 refers to a x4 PCIe card plugged in=
to the second slot of a PCIe riser card, but it could refer to any x4 devic=
e attached to the IIO unit using lanes starting at lane 4 of the 16 lanes s=
upported by the bus.",
> +        "UMask": "0x01",
> +        "Unit": "IIO"
> +    },
> +    {
> +        "BriefDescription": "Write request of up to a 64 byte transactio=
n is made by IIO Part2 to Memory",
> +        "Counter": "0,1,2,3",
> +        "EventCode": "0x84",
> +        "EventName": "UNC_IIO_TXN_REQ_OF_CPU.MEM_WRITE.PART2",
> +        "FCMask": "0x07",
> +        "Filter": "chnl",
> +        "PerPkg": "1",
> +        "PortMask": "0x04",
> +        "PublicDescription": "Counts every write request of up to a 64 b=
yte transaction of data made by IIO Part2 to a unit on the main die (genera=
lly memory). In the general case, Part2 refers to a x4 or x8 PCIe card plug=
ged into the third slot of a PCIe riser card, but it could refer to any x4 =
or x8 device attached to the IIO unit and using lanes starting at lane 8 of=
 the 16 lanes supported by the bus.",
> +        "UMask": "0x01",
> +        "Unit": "IIO"
> +    },
> +    {
> +        "BriefDescription": "Write request of up to a 64 byte transactio=
n is made by IIO Part3 to Memory",
> +        "Counter": "0,1,2,3",
> +        "EventCode": "0x84",
> +        "EventName": "UNC_IIO_TXN_REQ_OF_CPU.MEM_WRITE.PART3",
> +        "FCMask": "0x07",
> +        "Filter": "chnl",
> +        "PerPkg": "1",
> +        "PortMask": "0x08",
> +        "PublicDescription": "Counts every write request of up to a 64 b=
yte transaction of data made by IIO Part3 to a unit on the main die (genera=
lly memory). In the general case, Part3 refers to a x4 PCIe card plugged in=
to the fourth slot of a PCIe riser card, but it could brefer to  any device=
 attached to the IIO unit using the lanes starting at lane 12 of the 16 lan=
es supported by the bus.",
> +        "UMask": "0x01",
> +        "Unit": "IIO"
> +    },
> +    {
> +        "BriefDescription": "Peer to peer read request of up to a 64 byt=
e transaction is made by IIO Part0 to an IIO target",
> +        "Counter": "0,1,2,3",
> +        "EventCode": "0x84",
> +        "EventName": "UNC_IIO_TXN_REQ_OF_CPU.PEER_READ.PART0",
> +        "FCMask": "0x07",
> +        "Filter": "chnl",
> +        "PerPkg": "1",
> +        "PortMask": "0x01",
> +        "PublicDescription": "Counts every peer to peer read request of =
up to a 64 byte transaction made by IIO Part0 to the MMIO space of an IIO t=
arget. In the general case, Part0 refers to a standard PCIe card of any siz=
e (x16,x8,x4) that is plugged directly into one of the PCIe slots. Part0 co=
uld also refer to any device plugged into the first slot of a PCIe riser ca=
rd or to a device attached to the IIO unit which starts its use of the bus =
using lane 0 of the 16 lanes supported by the bus.",
> +        "UMask": "0x08",
> +        "Unit": "IIO"
> +    },
> +    {
> +        "BriefDescription": "Peer to peer read request of up to a 64 byt=
e transaction is made by IIO Part1 to an IIO target",
> +        "Counter": "0,1,2,3",
> +        "EventCode": "0x84",
> +        "EventName": "UNC_IIO_TXN_REQ_OF_CPU.PEER_READ.PART1",
> +        "FCMask": "0x07",
> +        "Filter": "chnl",
> +        "PerPkg": "1",
> +        "PortMask": "0x02",
> +        "PublicDescription": "Counts every peer to peer read request of =
up to a 64 byte transaction made by IIO Part1 to the MMIO space of an IIO t=
arget. In the general case, Part1 refers to a x4 PCIe card plugged into the=
 second slot of a PCIe riser card, but it could refer to any x4 device atta=
ched to the IIO unit using lanes starting at lane 4 of the 16 lanes support=
ed by the bus.",
> +        "UMask": "0x08",
> +        "Unit": "IIO"
> +    },
> +    {
> +        "BriefDescription": "Peer to peer read request of up to a 64 byt=
e transaction is made by IIO Part2 to an IIO target",
> +        "Counter": "0,1,2,3",
> +        "EventCode": "0x84",
> +        "EventName": "UNC_IIO_TXN_REQ_OF_CPU.PEER_READ.PART2",
> +        "FCMask": "0x07",
> +        "Filter": "chnl",
> +        "PerPkg": "1",
> +        "PortMask": "0x04",
> +        "PublicDescription": "Counts every peer to peer read request of =
up to a 64 byte transaction made by IIO Part2 to the MMIO space of an IIO t=
arget. In the general case, Part2 refers to a x4 or x8 PCIe card plugged in=
to the third slot of a PCIe riser card, but it could refer to any x4 or x8 =
device attached to the IIO unit and using lanes starting at lane 8 of the 1=
6 lanes supported by the bus.",
> +        "UMask": "0x08",
> +        "Unit": "IIO"
> +    },
> +    {
> +        "BriefDescription": "Peer to peer read request of up to a 64 byt=
e transaction is made by IIO Part3 to an IIO target",
> +        "Counter": "0,1,2,3",
> +        "EventCode": "0x84",
> +        "EventName": "UNC_IIO_TXN_REQ_OF_CPU.PEER_READ.PART3",
> +        "FCMask": "0x07",
> +        "Filter": "chnl",
> +        "PerPkg": "1",
> +        "PortMask": "0x08",
> +        "PublicDescription": "Counts every peer to peer read request of =
up to a 64 byte transaction made by IIO Part3 to the MMIO space of an IIO t=
arget. In the general case, Part3 refers to a x4 PCIe card plugged into the=
 fourth slot of a PCIe riser card, but it could brefer to any device attach=
ed to the IIO unit using the lanes starting at lane 12 of the 16 lanes supp=
orted by the bus.",
> +        "UMask": "0x08",
> +        "Unit": "IIO"
> +    },
> +    {
> +        "BriefDescription": "Peer to peer write request of up to a 64 by=
te transaction is made by IIO Part0 to an IIO target",
> +        "Counter": "0,1,2,3",
> +        "EventCode": "0x84",
> +        "EventName": "UNC_IIO_TXN_REQ_OF_CPU.PEER_WRITE.PART0",
> +        "FCMask": "0x07",
> +        "Filter": "chnl",
> +        "PerPkg": "1",
> +        "PortMask": "0x01",
> +        "PublicDescription": "Counts every peer to peer write request of=
 up to a 64 byte transaction of data made by IIO Part0 to the MMIO space of=
 an IIO target. In the general case, Part0 refers to a standard PCIe card o=
f any size (x16,x8,x4) that is plugged directly into one of the PCIe slots.=
 Part0 could also refer to any device plugged into the first slot of a PCIe=
 riser card or to a device attached to the IIO unit which starts its use of=
 the bus using lane 0 of the 16 lanes supported by the bus.",
> +        "UMask": "0x02",
> +        "Unit": "IIO"
> +    },
> +    {
> +        "BriefDescription": "Peer to peer write request of up to a 64 by=
te transaction is made by IIO Part1 to an IIO target",
> +        "Counter": "0,1,2,3",
> +        "EventCode": "0x84",
> +        "EventName": "UNC_IIO_TXN_REQ_OF_CPU.PEER_WRITE.PART1",
> +        "FCMask": "0x07",
> +        "Filter": "chnl",
> +        "PerPkg": "1",
> +        "PortMask": "0x02",
> +        "PublicDescription": "Counts every peer to peer write request of=
 up to a 64 byte transaction of data made by IIO Part1 to the MMIO space of=
 an IIO target.In the general case, Part1 refers to a x4 PCIe card plugged =
into the second slot of a PCIe riser card, but it could refer to any x4 dev=
ice attached to the IIO unit using lanes starting at lane 4 of the 16 lanes=
 supported by the bus.",
> +        "UMask": "0x02",
> +        "Unit": "IIO"
> +    },
> +    {
> +        "BriefDescription": "Peer to peer write request of up to a 64 by=
te transaction is made by IIO Part2 to an IIO target",
> +        "Counter": "0,1,2,3",
> +        "EventCode": "0x84",
> +        "EventName": "UNC_IIO_TXN_REQ_OF_CPU.PEER_WRITE.PART2",
> +        "FCMask": "0x07",
> +        "Filter": "chnl",
> +        "PerPkg": "1",
> +        "PortMask": "0x04",
> +        "PublicDescription": "Counts every peer to peer write request of=
 up to a 64 byte transaction of data made by IIO Part2 to the MMIO space of=
 an IIO target. In the general case, Part2 refers to a x4 or x8 PCIe card p=
lugged into the third slot of a PCIe riser card, but it could refer to any =
x4 or x8 device attached to the IIO unit and using lanes starting at lane 8=
 of the 16 lanes supported by the bus.",
> +        "UMask": "0x02",
> +        "Unit": "IIO"
> +    },
> +    {
> +        "BriefDescription": "Peer to peer write request of up to a 64 by=
te transaction is made by IIO Part3 to an IIO target",
> +        "Counter": "0,1,2,3",
> +        "EventCode": "0x84",
> +        "EventName": "UNC_IIO_TXN_REQ_OF_CPU.PEER_WRITE.PART3",
> +        "FCMask": "0x07",
> +        "Filter": "chnl",
> +        "PerPkg": "1",
> +        "PortMask": "0x08",
> +        "PublicDescription": "Counts every peer to peer write request of=
 up to a 64 byte transaction of data made by IIO Part3 to the MMIO space of=
 an IIO target. In the general case, Part3 refers to a x4 PCIe card plugged=
 into the fourth slot of a PCIe riser card, but it could brefer to  any dev=
ice attached to the IIO unit using the lanes starting at lane 12 of the 16 =
lanes supported by the bus.",
> +        "UMask": "0x02",
> +        "Unit": "IIO"
> +    },
> +    {
> +        "BriefDescription": "Traffic in which the M2M to iMC Bypass was =
not taken",
> +        "Counter": "0,1,2,3",
> +        "EventCode": "0x22",
> +        "EventName": "UNC_M2M_BYPASS_M2M_Egress.NOT_TAKEN",
> +        "PerPkg": "1",
> +        "PublicDescription": "Counts traffic in which the M2M (Mesh to M=
emory) to iMC (Memory Controller) bypass was not taken",
> +        "UMask": "0x2",
> +        "Unit": "M2M"
> +    },
> +    {
> +        "BriefDescription": "Cycles when direct to core mode (which bypa=
sses the CHA) was disabled",
> +        "Counter": "0,1,2,3",
> +        "EventCode": "0x24",
> +        "EventName": "UNC_M2M_DIRECT2CORE_NOT_TAKEN_DIRSTATE",
> +        "PerPkg": "1",
> +        "PublicDescription": "Counts cycles when direct to core mode (wh=
ich bypasses the CHA) was disabled",
> +        "Unit": "M2M"
> +    },
> +    {
> +        "BriefDescription": "Messages sent direct to core (bypassing the=
 CHA)",
> +        "Counter": "0,1,2,3",
> +        "EventCode": "0x23",
> +        "EventName": "UNC_M2M_DIRECT2CORE_TAKEN",
> +        "PerPkg": "1",
> +        "PublicDescription": "Counts when messages were sent direct to c=
ore (bypassing the CHA)",
> +        "Unit": "M2M"
> +    },
> +    {
> +        "BriefDescription": "Number of reads in which direct to core tra=
nsaction were overridden",
> +        "Counter": "0,1,2,3",
> +        "EventCode": "0x25",
> +        "EventName": "UNC_M2M_DIRECT2CORE_TXN_OVERRIDE",
> +        "PerPkg": "1",
> +        "PublicDescription": "Counts reads in which direct to core trans=
actions (which would have bypassed the CHA) were overridden",
> +        "Unit": "M2M"
> +    },
> +    {
> +        "BriefDescription": "Number of reads in which direct to Intel UP=
I transactions were overridden",
> +        "Counter": "0,1,2,3",
> +        "EventCode": "0x28",
> +        "EventName": "UNC_M2M_DIRECT2UPI_NOT_TAKEN_CREDITS",
> +        "PerPkg": "1",
> +        "PublicDescription": "Counts reads in which direct to Intel Ultr=
a Path Interconnect (UPI) transactions (which would have bypassed the CHA) =
were overridden",
> +        "Unit": "M2M"
> +    },
> +    {
> +        "BriefDescription": "Cycles when direct to Intel UPI was disable=
d",
> +        "Counter": "0,1,2,3",
> +        "EventCode": "0x27",
> +        "EventName": "UNC_M2M_DIRECT2UPI_NOT_TAKEN_DIRSTATE",
> +        "PerPkg": "1",
> +        "PublicDescription": "Counts cycles when the ability to send mes=
sages direct to the Intel Ultra Path Interconnect (bypassing the CHA) was d=
isabled",
> +        "Unit": "M2M"
> +    },
> +    {
> +        "BriefDescription": "Messages sent direct to the Intel UPI",
> +        "Counter": "0,1,2,3",
> +        "EventCode": "0x26",
> +        "EventName": "UNC_M2M_DIRECT2UPI_TAKEN",
> +        "PerPkg": "1",
> +        "PublicDescription": "Counts when messages were sent direct to t=
he Intel Ultra Path Interconnect (bypassing the CHA)",
> +        "Unit": "M2M"
> +    },
> +    {
> +        "BriefDescription": "Number of reads that a message sent direct2=
 Intel UPI was overridden",
> +        "Counter": "0,1,2,3",
> +        "EventCode": "0x29",
> +        "EventName": "UNC_M2M_DIRECT2UPI_TXN_OVERRIDE",
> +        "PerPkg": "1",
> +        "PublicDescription": "Counts when a read message that was sent d=
irect to the Intel Ultra Path Interconnect (bypassing the CHA) was overridd=
en",
> +        "Unit": "M2M"
> +    },
> +    {
> +        "BriefDescription": "Multi-socket cacheline Directory lookups (a=
ny state found)",
> +        "Counter": "0,1,2,3",
> +        "EventCode": "0x2D",
> +        "EventName": "UNC_M2M_DIRECTORY_LOOKUP.ANY",
> +        "PerPkg": "1",
> +        "PublicDescription": "Counts when the M2M (Mesh to Memory) looks=
 into the multi-socket cacheline Directory state, and found the cacheline m=
arked in Any State (A, I, S or unused)",
> +        "UMask": "0x1",
> +        "Unit": "M2M"
> +    },
> +    {
> +        "BriefDescription": "Multi-socket cacheline Directory lookups (c=
acheline found in A state)",
> +        "Counter": "0,1,2,3",
> +        "EventCode": "0x2D",
> +        "EventName": "UNC_M2M_DIRECTORY_LOOKUP.STATE_A",
> +        "PerPkg": "1",
> +        "PublicDescription": "Counts when the M2M (Mesh to Memory) looks=
 into the multi-socket cacheline Directory state, and found the cacheline m=
arked in the A (SnoopAll) state, indicating the cacheline is stored in anot=
her socket in any state, and we must snoop the other sockets to make sure w=
e get the latest data.  The data may be stored in any state in the local so=
cket.",
> +        "UMask": "0x8",
> +        "Unit": "M2M"
> +    },
> +    {
> +        "BriefDescription": "Multi-socket cacheline Directory lookup (ca=
cheline found in I state)",
> +        "Counter": "0,1,2,3",
> +        "EventCode": "0x2D",
> +        "EventName": "UNC_M2M_DIRECTORY_LOOKUP.STATE_I",
> +        "PerPkg": "1",
> +        "PublicDescription": "Counts when the M2M (Mesh to Memory) looks=
 into the multi-socket cacheline Directory state , and found the cacheline =
marked in the I (Invalid) state indicating the cacheline is not stored in a=
nother socket, and so there is no need to snoop the other sockets for the l=
atest data.  The data may be stored in any state in the local socket.",
> +        "UMask": "0x2",
> +        "Unit": "M2M"
> +    },
> +    {
> +        "BriefDescription": "Multi-socket cacheline Directory lookup (ca=
cheline found in S state)",
> +        "Counter": "0,1,2,3",
> +        "EventCode": "0x2D",
> +        "EventName": "UNC_M2M_DIRECTORY_LOOKUP.STATE_S",
> +        "PerPkg": "1",
> +        "PublicDescription": "Counts when the M2M (Mesh to Memory) looks=
 into the multi-socket cacheline Directory state , and found the cacheline =
marked in the S (Shared) state indicating the cacheline is either stored in=
 another socket in the S(hared) state , and so there is no need to snoop th=
e other sockets for the latest data.  The data may be stored in any state i=
n the local socket.",
> +        "UMask": "0x4",
> +        "Unit": "M2M"
> +    },
> +    {
> +        "BriefDescription": "Multi-socket cacheline Directory update fro=
m A to I",
> +        "Counter": "0,1,2,3",
> +        "EventCode": "0x2E",
> +        "EventName": "UNC_M2M_DIRECTORY_UPDATE.A2I",
> +        "PerPkg": "1",
> +        "PublicDescription": "Counts when the M2M (Mesh to Memory) updat=
es the multi-socket cacheline Directory state from from A (SnoopAll) to I (=
Invalid)",
> +        "UMask": "0x20",
> +        "Unit": "M2M"
> +    },
> +    {
> +        "BriefDescription": "Multi-socket cacheline Directory update fro=
m A to S",
> +        "Counter": "0,1,2,3",
> +        "EventCode": "0x2E",
> +        "EventName": "UNC_M2M_DIRECTORY_UPDATE.A2S",
> +        "PerPkg": "1",
> +        "PublicDescription": "Counts when the M2M (Mesh to Memory) updat=
es the multi-socket cacheline Directory state from from A (SnoopAll) to S (=
Shared)",
> +        "UMask": "0x40",
> +        "Unit": "M2M"
> +    },
> +    {
> +        "BriefDescription": "Multi-socket cacheline Directory update fro=
m/to Any state",
> +        "Counter": "0,1,2,3",
> +        "EventCode": "0x2E",
> +        "EventName": "UNC_M2M_DIRECTORY_UPDATE.ANY",
> +        "PerPkg": "1",
> +        "PublicDescription": "Counts when the M2M (Mesh to Memory) updat=
es the multi-socket cacheline Directory to a new state",
> +        "UMask": "0x1",
> +        "Unit": "M2M"
> +    },
> +    {
> +        "BriefDescription": "Multi-socket cacheline Directory update fro=
m I to A",
> +        "Counter": "0,1,2,3",
> +        "EventCode": "0x2E",
> +        "EventName": "UNC_M2M_DIRECTORY_UPDATE.I2A",
> +        "PerPkg": "1",
> +        "PublicDescription": "Counts when the M2M (Mesh to Memory) updat=
es the multi-socket cacheline Directory state from from I (Invalid) to A (S=
noopAll)",
> +        "UMask": "0x4",
> +        "Unit": "M2M"
> +    },
> +    {
> +        "BriefDescription": "Multi-socket cacheline Directory update fro=
m I to S",
> +        "Counter": "0,1,2,3",
> +        "EventCode": "0x2E",
> +        "EventName": "UNC_M2M_DIRECTORY_UPDATE.I2S",
> +        "PerPkg": "1",
> +        "PublicDescription": "Counts when the M2M (Mesh to Memory) updat=
es the multi-socket cacheline Directory state from from I (Invalid) to S (S=
hared)",
> +        "UMask": "0x2",
> +        "Unit": "M2M"
> +    },
> +    {
> +        "BriefDescription": "Multi-socket cacheline Directory update fro=
m S to A",
> +        "Counter": "0,1,2,3",
> +        "EventCode": "0x2E",
> +        "EventName": "UNC_M2M_DIRECTORY_UPDATE.S2A",
> +        "PerPkg": "1",
> +        "PublicDescription": "Counts when the M2M (Mesh to Memory) updat=
es the multi-socket cacheline Directory state from from S (Shared) to A (Sn=
oopAll)",
> +        "UMask": "0x10",
> +        "Unit": "M2M"
> +    },
> +    {
> +        "BriefDescription": "Multi-socket cacheline Directory update fro=
m S to I",
> +        "Counter": "0,1,2,3",
> +        "EventCode": "0x2E",
> +        "EventName": "UNC_M2M_DIRECTORY_UPDATE.S2I",
> +        "PerPkg": "1",
> +        "PublicDescription": "Counts when the M2M (Mesh to Memory) updat=
es the multi-socket cacheline Directory state from from S (Shared) to I (In=
valid)",
> +        "UMask": "0x8",
> +        "Unit": "M2M"
> +    },
> +    {
> +        "BriefDescription": "Reads to iMC issued",
> +        "Counter": "0,1,2,3",
> +        "EventCode": "0x37",
> +        "EventName": "UNC_M2M_IMC_READS.ALL",
> +        "PerPkg": "1",
> +        "PublicDescription": "Counts when the M2M (Mesh to Memory) issue=
s reads to the iMC (Memory Controller).",
> +        "UMask": "0x4",
> +        "Unit": "M2M"
> +    },
> +    {
> +        "BriefDescription": "Reads to iMC issued at Normal Priority (Non=
-Isochronous)",
> +        "Counter": "0,1,2,3",
> +        "EventCode": "0x37",
> +        "EventName": "UNC_M2M_IMC_READS.NORMAL",
> +        "PerPkg": "1",
> +        "PublicDescription": "Counts when the M2M (Mesh to Memory) issue=
s reads to the iMC (Memory Controller).  It only counts  normal priority no=
n-isochronous reads.",
> +        "UMask": "0x1",
> +        "Unit": "M2M"
> +    },
> +    {
> +        "BriefDescription": "Read requests to Intel Optane DC persistent=
 memory issued to the iMC from M2M",
> +        "Counter": "0,1,2,3",
> +        "EventCode": "0x37",
> +        "EventName": "UNC_M2M_IMC_READS.TO_PMM",
> +        "PerPkg": "1",
> +        "PublicDescription": "M2M Reads Issued to iMC; All, regardless o=
f priority.",
> +        "UMask": "0x8",
> +        "Unit": "M2M"
> +    },
> +    {
> +        "BriefDescription": "Writes to iMC issued",
> +        "Counter": "0,1,2,3",
> +        "EventCode": "0x38",
> +        "EventName": "UNC_M2M_IMC_WRITES.ALL",
> +        "PerPkg": "1",
> +        "PublicDescription": "Counts when the M2M (Mesh to Memory) issue=
s writes to the iMC (Memory Controller).",
> +        "UMask": "0x10",
> +        "Unit": "M2M"
> +    },
> +    {
> +        "BriefDescription": "M2M Writes Issued to iMC; All, regardless o=
f priority.",
> +        "Counter": "0,1,2,3",
> +        "EventCode": "0x38",
> +        "EventName": "UNC_M2M_IMC_WRITES.NI",
> +        "PerPkg": "1",
> +        "PublicDescription": "M2M Writes Issued to iMC; All, regardless =
of priority.",
> +        "UMask": "0x80",
> +        "Unit": "M2M"
> +    },
> +    {
> +        "BriefDescription": "Partial Non-Isochronous writes to the iMC",
> +        "Counter": "0,1,2,3",
> +        "EventCode": "0x38",
> +        "EventName": "UNC_M2M_IMC_WRITES.PARTIAL",
> +        "PerPkg": "1",
> +        "PublicDescription": "Counts when the M2M (Mesh to Memory) issue=
s partial writes to the iMC (Memory Controller).  It only counts normal pri=
ority non-isochronous writes.",
> +        "UMask": "0x2",
> +        "Unit": "M2M"
> +    },
> +    {
> +        "BriefDescription": "Write requests to Intel Optane DC persisten=
t memory issued to the iMC from M2M",
> +        "Counter": "0,1,2,3",
> +        "EventCode": "0x38",
> +        "EventName": "UNC_M2M_IMC_WRITES.TO_PMM",
> +        "PerPkg": "1",
> +        "PublicDescription": "M2M Writes Issued to iMC; All, regardless =
of priority.",
> +        "UMask": "0x20",
> +        "Unit": "M2M"
> +    },
> +    {
> +        "BriefDescription": "Prefecth requests that got turn into a dema=
nd request",
> +        "Counter": "0,1,2,3",
> +        "EventCode": "0x56",
> +        "EventName": "UNC_M2M_PREFCAM_DEMAND_PROMOTIONS",
> +        "PerPkg": "1",
> +        "PublicDescription": "Counts when the M2M (Mesh to Memory) promo=
tes a outstanding request in the prefetch queue due to a subsequent demand =
read request that entered the M2M with the same address.  Explanatory Side =
Note: The Prefecth queue is made of CAM (Content Addressable Memory)",
> +        "Unit": "M2M"
> +    },
> +    {
> +        "BriefDescription": "Inserts into the Memory Controller Prefetch=
 Queue",
> +        "Counter": "0,1,2,3",
> +        "EventCode": "0x57",
> +        "EventName": "UNC_M2M_PREFCAM_INSERTS",
> +        "PerPkg": "1",
> +        "PublicDescription": "Counts when the M2M (Mesh to Memory) recie=
ves a prefetch request and inserts it into its outstanding prefetch queue. =
 Explanatory Side Note: the prefect queue is made from CAM: Content Address=
able Memory",
> +        "Unit": "M2M"
> +    },
> +    {
> +        "BriefDescription": "AD Ingress (from CMS) Queue Inserts",
> +        "Counter": "0,1,2,3",
> +        "EventCode": "0x1",
> +        "EventName": "UNC_M2M_RxC_AD_INSERTS",
> +        "PerPkg": "1",
> +        "PublicDescription": "Counts when the a new entry is Received(Rx=
C) and then added to the AD (Address Ring) Ingress Queue from the CMS (Comm=
on Mesh Stop).  This is generally used for reads, and",
> +        "Unit": "M2M"
> +    },
> +    {
> +        "BriefDescription": "AD Ingress (from CMS) Occupancy",
> +        "Counter": "0,1,2,3",
> +        "EventCode": "0x2",
> +        "EventName": "UNC_M2M_RxC_AD_OCCUPANCY",
> +        "PerPkg": "1",
> +        "PublicDescription": "AD Ingress (from CMS) Occupancy",
> +        "Unit": "M2M"
> +    },
> +    {
> +        "BriefDescription": "BL Ingress (from CMS) Allocations",
> +        "Counter": "0,1,2,3",
> +        "EventCode": "0x5",
> +        "EventName": "UNC_M2M_RxC_BL_INSERTS",
> +        "PerPkg": "1",
> +        "PublicDescription": "BL Ingress (from CMS) Allocations",
> +        "Unit": "M2M"
> +    },
> +    {
> +        "BriefDescription": "BL Ingress (from CMS) Occupancy",
> +        "Counter": "0,1,2,3",
> +        "EventCode": "0x6",
> +        "EventName": "UNC_M2M_RxC_BL_OCCUPANCY",
> +        "PerPkg": "1",
> +        "PublicDescription": "BL Ingress (from CMS) Occupancy",
> +        "Unit": "M2M"
> +    },
> +    {
> +        "BriefDescription": "Dirty line read hits(Regular and RFO) to Ne=
ar Memory(DRAM cache) in Memory Mode",
> +        "Counter": "0,1,2,3",
> +        "EventCode": "0x2C",
> +        "EventName": "UNC_M2M_TAG_HIT.NM_RD_HIT_DIRTY",
> +        "PerPkg": "1",
> +        "PublicDescription": "Tag Hit; Read Hit from NearMem, Dirty  Lin=
e",
> +        "UMask": "0x02",
> +        "Unit": "M2M"
> +    },
> +    {
> +        "BriefDescription": "Clean line underfill read hits to Near Memo=
ry(DRAM cache) in Memory Mode",
> +        "Counter": "0,1,2,3",
> +        "EventCode": "0x2C",
> +        "EventName": "UNC_M2M_TAG_HIT.NM_UFILL_HIT_CLEAN",
> +        "PerPkg": "1",
> +        "PublicDescription": "Tag Hit; Underfill Rd Hit from NearMem, Cl=
ean Line",
> +        "UMask": "0x04",
> +        "Unit": "M2M"
> +    },
> +    {
> +        "BriefDescription": "Dirty line underfill read hits to Near Memo=
ry(DRAM cache) in Memory Mode",
> +        "Counter": "0,1,2,3",
> +        "EventCode": "0x2C",
> +        "EventName": "UNC_M2M_TAG_HIT.NM_UFILL_HIT_DIRTY",
> +        "PerPkg": "1",
> +        "PublicDescription": "Tag Hit; Underfill Rd Hit from NearMem, Di=
rty  Line",
> +        "UMask": "0x08",
> +        "Unit": "M2M"
> +    },
> +    {
> +        "BriefDescription": "AD Egress (to CMS) Allocations",
> +        "Counter": "0,1,2,3",
> +        "EventCode": "0x9",
> +        "EventName": "UNC_M2M_TxC_AD_INSERTS",
> +        "PerPkg": "1",
> +        "PublicDescription": "AD Egress (to CMS) Allocations",
> +        "Unit": "M2M"
> +    },
> +    {
> +        "BriefDescription": "AD Egress (to CMS) Occupancy",
> +        "Counter": "0,1,2,3",
> +        "EventCode": "0xA",
> +        "EventName": "UNC_M2M_TxC_AD_OCCUPANCY",
> +        "PerPkg": "1",
> +        "PublicDescription": "AD Egress (to CMS) Occupancy",
> +        "Unit": "M2M"
> +    },
> +    {
> +        "BriefDescription": "BL Egress (to CMS) Allocations; All",
> +        "Counter": "0,1,2,3",
> +        "EventCode": "0x15",
> +        "EventName": "UNC_M2M_TxC_BL_INSERTS.ALL",
> +        "PerPkg": "1",
> +        "PublicDescription": "BL Egress (to CMS) Allocations; All",
> +        "UMask": "0x03",
> +        "Unit": "M2M"
> +    },
> +    {
> +        "BriefDescription": "BL Egress (to CMS) Occupancy; All",
> +        "Counter": "0,1,2,3",
> +        "EventCode": "0x16",
> +        "EventName": "UNC_M2M_TxC_BL_OCCUPANCY.ALL",
> +        "PerPkg": "1",
> +        "PublicDescription": "BL Egress (to CMS) Occupancy; All",
> +        "UMask": "0x03",
> +        "Unit": "M2M"
> +    },
> +    {
> +        "BriefDescription": "Prefetches generated by the flow control qu=
eue of the M3UPI unit.",
> +        "Counter": "0,1,2",
> +        "EventCode": "0x29",
> +        "EventName": "UNC_M3UPI_UPI_PREFETCH_SPAWN",
> +        "PerPkg": "1",
> +        "PublicDescription": "Count cases where flow control queue that =
sits between the Intel Ultra Path Interconnect (UPI) and the mesh spawns a =
prefetch to the iMC (Memory Controller)",
> +        "Unit": "M3UPI"
> +    },
> +    {
> +        "BriefDescription": "Clocks of the Intel Ultra Path Interconnect=
 (UPI)",
> +        "Counter": "0,1,2,3",
> +        "EventCode": "0x1",
> +        "EventName": "UNC_UPI_CLOCKTICKS",
> +        "PerPkg": "1",
> +        "PublicDescription": "Counts clockticks of the fixed frequency c=
lock controlling the Intel Ultra Path Interconnect (UPI).  This clock runs =
at1/8th the 'GT/s' speed of the UPI link.  For example, a  9.6GT/s  link wi=
ll have a fixed Frequency of 1.2 Ghz.",
> +        "Unit": "UPI LL"
> +    },
> +    {
> +        "BriefDescription": "Data Response packets that go direct to cor=
e",
> +        "Counter": "0,1,2,3",
> +        "EventCode": "0x12",
> +        "EventName": "UNC_UPI_DIRECT_ATTEMPTS.D2C",
> +        "PerPkg": "1",
> +        "PublicDescription": "Counts Data Response (DRS) packets that at=
tempted to go direct to core bypassing the CHA.",
> +        "UMask": "0x1",
> +        "Unit": "UPI LL"
> +    },
> +    {
> +        "BriefDescription": "Data Response packets that go direct to Int=
el UPI",
> +        "Counter": "0,1,2,3",
> +        "EventCode": "0x12",
> +        "EventName": "UNC_UPI_DIRECT_ATTEMPTS.D2U",
> +        "PerPkg": "1",
> +        "PublicDescription": "Counts Data Response (DRS) packets that at=
tempted to go direct to Intel Ultra Path Interconnect (UPI) bypassing the C=
HA .",
> +        "UMask": "0x2",
> +        "Unit": "UPI LL"
> +    },
> +    {
> +        "BriefDescription": "Cycles Intel UPI is in L1 power mode (shutd=
own)",
> +        "Counter": "0,1,2,3",
> +        "EventCode": "0x21",
> +        "EventName": "UNC_UPI_L1_POWER_CYCLES",
> +        "PerPkg": "1",
> +        "PublicDescription": "Counts cycles when the Intel Ultra Path In=
terconnect (UPI) is in L1 power mode.  L1 is a mode that totally shuts down=
 the UPI link.  Link power states are per link and per direction, so for ex=
ample the Tx direction could be in one state while Rx was in another, this =
event only coutns when both links are shutdown.",
> +        "Unit": "UPI LL"
> +    },
> +    {
> +        "BriefDescription": "Cycles the Rx of the Intel UPI is in L0p po=
wer mode",
> +        "Counter": "0,1,2,3",
> +        "EventCode": "0x25",
> +        "EventName": "UNC_UPI_RxL0P_POWER_CYCLES",
> +        "PerPkg": "1",
> +        "PublicDescription": "Counts cycles when the the receive side (R=
x) of the Intel Ultra Path Interconnect(UPI) is in L0p power mode. L0p is a=
 mode where we disable 60% of the UPI lanes, decreasing our bandwidth in or=
der to save power.",
> +        "Unit": "UPI LL"
> +    },
> +    {
> +        "BriefDescription": "FLITs received which bypassed the Slot0 Rec=
eive Buffer",
> +        "Counter": "0,1,2,3",
> +        "EventCode": "0x31",
> +        "EventName": "UNC_UPI_RxL_BYPASSED.SLOT0",
> +        "PerPkg": "1",
> +        "PublicDescription": "Counts incoming FLITs (FLow control unITs)=
 which bypassed the slot0 RxQ buffer (Receive Queue) and passed directly to=
 the Egress.  This is a latency optimization, and should generally be the c=
ommon case.  If this value is less than the number of FLITs transfered, it =
implies that there was queueing getting onto the ring, and thus the transac=
tions saw higher latency.",
> +        "UMask": "0x1",
> +        "Unit": "UPI LL"
> +    },
> +    {
> +        "BriefDescription": "FLITs received which bypassed the Slot0 Rec=
eive Buffer",
> +        "Counter": "0,1,2,3",
> +        "EventCode": "0x31",
> +        "EventName": "UNC_UPI_RxL_BYPASSED.SLOT1",
> +        "PerPkg": "1",
> +        "PublicDescription": "Counts incoming FLITs (FLow control unITs)=
 which bypassed the slot1 RxQ buffer  (Receive Queue) and passed directly a=
cross the BGF and into the Egress.  This is a latency optimization, and sho=
uld generally be the common case.  If this value is less than the number of=
 FLITs transfered, it implies that there was queueing getting onto the ring=
, and thus the transactions saw higher latency.",
> +        "UMask": "0x2",
> +        "Unit": "UPI LL"
> +    },
> +    {
> +        "BriefDescription": "FLITs received which bypassed the Slot0 Rec=
ieve Buffer",
> +        "Counter": "0,1,2,3",
> +        "EventCode": "0x31",
> +        "EventName": "UNC_UPI_RxL_BYPASSED.SLOT2",
> +        "PerPkg": "1",
> +        "PublicDescription": "Counts incoming FLITs (FLow control unITs)=
 whcih bypassed the slot2 RxQ buffer (Receive Queue)  and passed directly t=
o the Egress.  This is a latency optimization, and should generally be the =
common case.  If this value is less than the number of FLITs transfered, it=
 implies that there was queueing getting onto the ring, and thus the transa=
ctions saw higher latency.",
> +        "UMask": "0x4",
> +        "Unit": "UPI LL"
> +    },
> +    {
> +        "BriefDescription": "Valid data FLITs received from any slot",
> +        "Counter": "0,1,2,3",
> +        "EventCode": "0x3",
> +        "EventName": "UNC_UPI_RxL_FLITS.ALL_DATA",
> +        "PerPkg": "1",
> +        "PublicDescription": "Counts valid data FLITs  (80 bit FLow cont=
rol unITs: 64bits of data) received from any of the 3 Intel Ultra Path Inte=
rconnect (UPI) Receive Queue slots on this UPI unit.",
> +        "UMask": "0x0F",
> +        "Unit": "UPI LL"
> +    },
> +    {
> +        "BriefDescription": "Null FLITs received from any slot",
> +        "Counter": "0,1,2,3",
> +        "EventCode": "0x3",
> +        "EventName": "UNC_UPI_RxL_FLITS.ALL_NULL",
> +        "PerPkg": "1",
> +        "PublicDescription": "Counts null FLITs (80 bit FLow control unI=
Ts) received from any of the 3 Intel Ultra Path Interconnect (UPI) Receive =
Queue slots on this UPI unit.",
> +        "UMask": "0x27",
> +        "Unit": "UPI LL"
> +    },
> +    {
> +        "BriefDescription": "Protocol header and credit FLITs received f=
rom any slot",
> +        "Counter": "0,1,2,3",
> +        "EventCode": "0x3",
> +        "EventName": "UNC_UPI_RxL_FLITS.NON_DATA",
> +        "PerPkg": "1",
> +        "PublicDescription": "Counts protocol header and credit FLITs  (=
80 bit FLow control unITs) received from any of the 3 UPI slots on this UPI=
 unit.",
> +        "UMask": "0x97",
> +        "Unit": "UPI LL"
> +    },
> +    {
> +        "BriefDescription": "Cycles in which the Tx of the Intel Ultra P=
ath Interconnect (UPI) is in L0p power mode",
> +        "Counter": "0,1,2,3",
> +        "EventCode": "0x27",
> +        "EventName": "UNC_UPI_TxL0P_POWER_CYCLES",
> +        "PerPkg": "1",
> +        "PublicDescription": "Counts cycles when the transmit side (Tx) =
of the Intel Ultra Path Interconnect(UPI) is in L0p power mode. L0p is a mo=
de where we disable 60% of the UPI lanes, decreasing our bandwidth in order=
 to save power.",
> +        "Unit": "UPI LL"
> +    },
> +    {
> +        "BriefDescription": "FLITs that bypassed the TxL Buffer",
> +        "Counter": "0,1,2,3",
> +        "EventCode": "0x41",
> +        "EventName": "UNC_UPI_TxL_BYPASSED",
> +        "PerPkg": "1",
> +        "PublicDescription": "Counts incoming FLITs (FLow control unITs)=
 which bypassed the TxL(transmit) FLIT buffer and pass directly out the UPI=
 Link. Generally, when data is transmitted across the Intel Ultra Path Inte=
rconnect (UPI), it will bypass the TxQ and pass directly to the link.  Howe=
ver, the TxQ will be used in L0p (Low Power) mode and (Link Layer Retry) LL=
R  mode, increasing latency to transfer out to the link.",
> +        "Unit": "UPI LL"
> +    },
> +    {
> +        "BriefDescription": "Null FLITs transmitted from any slot",
> +        "Counter": "0,1,2,3",
> +        "EventCode": "0x2",
> +        "EventName": "UNC_UPI_TxL_FLITS.ALL_NULL",
> +        "PerPkg": "1",
> +        "PublicDescription": "Counts null FLITs (80 bit FLow control unI=
Ts) transmitted via any of the 3 Intel Ulra Path Interconnect (UPI) slots o=
n this UPI unit.",
> +        "UMask": "0x27",
> +        "Unit": "UPI LL"
> +    },
> +    {
> +        "BriefDescription": "Valid Flits Sent; Data",
> +        "Counter": "0,1,2,3",
> +        "EventCode": "0x2",
> +        "EventName": "UNC_UPI_TxL_FLITS.DATA",
> +        "PerPkg": "1",
> +        "PublicDescription": "Shows legal flit time (hides impact of L0p=
 and L0c).; Count Data Flits (which consume all slots), but how much to cou=
nt is based on Slot0-2 mask, so count can be 0-3 depending on which slots a=
re enabled for counting..",
> +        "UMask": "0x8",
> +        "Unit": "UPI LL"
> +    },
> +    {
> +        "BriefDescription": "Idle FLITs transmitted",
> +        "Counter": "0,1,2,3",
> +        "EventCode": "0x2",
> +        "EventName": "UNC_UPI_TxL_FLITS.IDLE",
> +        "PerPkg": "1",
> +        "PublicDescription": "Counts when the Intel Ultra Path Interconn=
ect(UPI) transmits an idle FLIT(80 bit FLow control unITs).  Every UPI cycl=
e must be sending either data FLITs, protocol/credit FLITs or idle FLITs.",
> +        "UMask": "0x47",
> +        "Unit": "UPI LL"
> +    },
> +    {
> +        "BriefDescription": "Protocol header and credit FLITs transmitte=
d across any slot",
> +        "Counter": "0,1,2,3",
> +        "EventCode": "0x2",
> +        "EventName": "UNC_UPI_TxL_FLITS.NON_DATA",
> +        "PerPkg": "1",
> +        "PublicDescription": "Counts protocol header and credit FLITs (8=
0 bit FLow control unITs) transmitted across any of the 3 UPI (Ultra Path I=
nterconnect) slots on this UPI unit.",
> +        "UMask": "0x97",
> +        "Unit": "UPI LL"
>      }
>  ]
> --=20
> 2.17.1

--=20

- Arnaldo

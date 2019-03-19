Return-Path: <SRS0=B1dt=RW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4AB3EC4360F
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Mar 2019 19:24:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0D54320835
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Mar 2019 19:24:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="XdDHSgWx"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727545AbfCSTYD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Mar 2019 15:24:03 -0400
Received: from hqemgate14.nvidia.com ([216.228.121.143]:14647 "EHLO
        hqemgate14.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726612AbfCSTYD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Mar 2019 15:24:03 -0400
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by hqemgate14.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5c9141d30000>; Tue, 19 Mar 2019 12:24:03 -0700
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate101.nvidia.com (PGP Universal service);
  Tue, 19 Mar 2019 12:24:01 -0700
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Tue, 19 Mar 2019 12:24:01 -0700
Received: from [10.110.48.28] (10.124.1.5) by HQMAIL101.nvidia.com
 (172.20.187.10) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Tue, 19 Mar
 2019 19:24:00 +0000
Subject: Re: [PATCH v4 1/1] mm: introduce put_user_page*(), placeholder
 versions
To:     Jerome Glisse <jglisse@redhat.com>,
        "Kirill A. Shutemov" <kirill@shutemov.name>
CC:     <john.hubbard@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        <linux-mm@kvack.org>, Al Viro <viro@zeniv.linux.org.uk>,
        Christian Benvenuti <benve@cisco.com>,
        Christoph Hellwig <hch@infradead.org>,
        Christopher Lameter <cl@linux.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Dave Chinner <david@fromorbit.com>,
        Dennis Dalessandro <dennis.dalessandro@intel.com>,
        Doug Ledford <dledford@redhat.com>,
        Ira Weiny <ira.weiny@intel.com>, Jan Kara <jack@suse.cz>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Matthew Wilcox <willy@infradead.org>,
        Michal Hocko <mhocko@kernel.org>,
        Mike Rapoport <rppt@linux.ibm.com>,
        Mike Marciniszyn <mike.marciniszyn@intel.com>,
        Ralph Campbell <rcampbell@nvidia.com>,
        Tom Talpey <tom@talpey.com>,
        LKML <linux-kernel@vger.kernel.org>,
        <linux-fsdevel@vger.kernel.org>
References: <20190308213633.28978-1-jhubbard@nvidia.com>
 <20190308213633.28978-2-jhubbard@nvidia.com>
 <20190319120417.yzormwjhaeuu7jpp@kshutemo-mobl1>
 <20190319134724.GB3437@redhat.com>
From:   John Hubbard <jhubbard@nvidia.com>
X-Nvconfidentiality: public
Message-ID: <bf443287-2461-ea2d-5a15-251190782ab7@nvidia.com>
Date:   Tue, 19 Mar 2019 12:24:00 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.3
MIME-Version: 1.0
In-Reply-To: <20190319134724.GB3437@redhat.com>
X-Originating-IP: [10.124.1.5]
X-ClientProxiedBy: HQMAIL108.nvidia.com (172.18.146.13) To
 HQMAIL101.nvidia.com (172.20.187.10)
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US-large
Content-Transfer-Encoding: 7bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1553023443; bh=s8cH6GtN38AlGs5As8/XCfKmUKmyncY/yyySe4XbvA4=;
        h=X-PGP-Universal:Subject:To:CC:References:From:X-Nvconfidentiality:
         Message-ID:Date:User-Agent:MIME-Version:In-Reply-To:
         X-Originating-IP:X-ClientProxiedBy:Content-Type:Content-Language:
         Content-Transfer-Encoding;
        b=XdDHSgWxr8k7fXVywWGcvgHobknERbwVazMm7P2MkPdZY/S6rCF0VxJMzL0ZpARox
         bN/CUD2JyGwBCPOBqaNLNkcKY9rkzHDvyjo9JBS50FvVGKpZUxRGKl4r6DRCxvfMZr
         byJ2JXSvISHPFq8A2k0CzeuCoYNt0dXUElaYXZUX9DjZdrJaUQ4EMYFhTfKVkHbDJA
         yiKr93mwLLYFgp0eb1630BtR5rxsJlJossR8U7Hwu2KLdE6aJq3Cd3K22cdbEEUCyB
         7WXK3sOalp6C8h9FrcPFk+TaHXLv+qFpW9lt1bqdQkOe0IdlIepnavBH3+V0qs+Vyq
         qSZYXxoBH8x8g==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/19/19 6:47 AM, Jerome Glisse wrote:
> On Tue, Mar 19, 2019 at 03:04:17PM +0300, Kirill A. Shutemov wrote:
>> On Fri, Mar 08, 2019 at 01:36:33PM -0800, john.hubbard@gmail.com wrote:
>>> From: John Hubbard <jhubbard@nvidia.com>
> 
> [...]
>>> +void put_user_pages_dirty(struct page **pages, unsigned long npages)
>>> +{
>>> +	__put_user_pages_dirty(pages, npages, set_page_dirty);
>>
>> Have you checked if compiler is clever enough eliminate indirect function
>> call here? Maybe it's better to go with an opencodded approach and get rid
>> of callbacks?
>>
> 
> Good point, dunno if John did check that.

Hi Kirill, Jerome,

The compiler does *not* eliminate the indirect function call, at least unless
I'm misunderstanding things. The __put_user_pages_dirty() function calls the
appropriate set_page_dirty*() call, via __x86_indirect_thunk_r12, which seems
pretty definitive.

ffffffff81a00ef0 <__x86_indirect_thunk_r12>:
ffffffff81a00ef0:	41 ff e4             	jmpq   *%r12
ffffffff81a00ef3:	90                   	nop
ffffffff81a00ef4:	90                   	nop
ffffffff81a00ef5:	90                   	nop
ffffffff81a00ef6:	90                   	nop
ffffffff81a00ef7:	90                   	nop
ffffffff81a00ef8:	90                   	nop
ffffffff81a00ef9:	90                   	nop
ffffffff81a00efa:	90                   	nop
ffffffff81a00efb:	90                   	nop
ffffffff81a00efc:	90                   	nop
ffffffff81a00efd:	90                   	nop
ffffffff81a00efe:	90                   	nop
ffffffff81a00eff:	90                   	nop
ffffffff81a00f00:	90                   	nop
ffffffff81a00f01:	66 66 2e 0f 1f 84 00 	data16 nopw %cs:0x0(%rax,%rax,1)
ffffffff81a00f08:	00 00 00 00 
ffffffff81a00f0c:	0f 1f 40 00          	nopl   0x0(%rax)

However, there is no visible overhead to doing so, at a macro level. An fio
O_DIRECT run with and without the full conversion patchset shows the same 
numbers:

cat fio.conf 
[reader]
direct=1
ioengine=libaio
blocksize=4096
size=1g
numjobs=1
rw=read
iodepth=64

=====================
Before (baseline):
=====================

reader: (g=0): rw=read, bs=(R) 4096B-4096B, (W) 4096B-4096B, (T) 4096B-4096B, ioengine=libaio, iodepth=64
fio-3.3
Starting 1 process

reader: (groupid=0, jobs=1): err= 0: pid=1828: Mon Mar 18 14:56:22 2019
   read: IOPS=192k, BW=751MiB/s (787MB/s)(1024MiB/1364msec)
    slat (nsec): min=1274, max=42375, avg=1564.12, stdev=682.65
    clat (usec): min=168, max=12209, avg=331.01, stdev=184.95
     lat (usec): min=171, max=12215, avg=332.61, stdev=185.11
    clat percentiles (usec):
     |  1.00th=[  326],  5.00th=[  326], 10.00th=[  326], 20.00th=[  326],
     | 30.00th=[  326], 40.00th=[  326], 50.00th=[  326], 60.00th=[  326],
     | 70.00th=[  326], 80.00th=[  326], 90.00th=[  326], 95.00th=[  326],
     | 99.00th=[  519], 99.50th=[  523], 99.90th=[  537], 99.95th=[  594],
     | 99.99th=[12125]
   bw (  KiB/s): min=755280, max=783016, per=100.00%, avg=769148.00, stdev=19612.31, samples=2
   iops        : min=188820, max=195754, avg=192287.00, stdev=4903.08, samples=2
  lat (usec)   : 250=0.14%, 500=98.59%, 750=1.25%
  lat (msec)   : 20=0.02%
  cpu          : usr=12.69%, sys=48.20%, ctx=248836, majf=0, minf=73
  IO depths    : 1=0.1%, 2=0.1%, 4=0.1%, 8=0.1%, 16=0.1%, 32=0.1%, >=64=100.0%
     submit    : 0=0.0%, 4=100.0%, 8=0.0%, 16=0.0%, 32=0.0%, 64=0.0%, >=64=0.0%
     complete  : 0=0.0%, 4=100.0%, 8=0.0%, 16=0.0%, 32=0.0%, 64=0.1%, >=64=0.0%
     issued rwts: total=262144,0,0,0 short=0,0,0,0 dropped=0,0,0,0
     latency   : target=0, window=0, percentile=100.00%, depth=64

Run status group 0 (all jobs):
   READ: bw=751MiB/s (787MB/s), 751MiB/s-751MiB/s (787MB/s-787MB/s), io=1024MiB (1074MB), run=1364-1364msec

Disk stats (read/write):
  nvme0n1: ios=220106/0, merge=0/0, ticks=70136/0, in_queue=704, util=91.19%

==================================================
After (with enough callsites converted to run fio:
==================================================

reader: (g=0): rw=read, bs=(R) 4096B-4096B, (W) 4096B-4096B, (T) 4096B-4096B, ioengine=libaio, iodepth=64
fio-3.3
Starting 1 process

reader: (groupid=0, jobs=1): err= 0: pid=2026: Mon Mar 18 14:35:07 2019
   read: IOPS=192k, BW=751MiB/s (787MB/s)(1024MiB/1364msec)
    slat (nsec): min=1263, max=41861, avg=1591.99, stdev=692.09
    clat (usec): min=154, max=12205, avg=330.82, stdev=184.98
     lat (usec): min=157, max=12212, avg=332.45, stdev=185.14
    clat percentiles (usec):
     |  1.00th=[  322],  5.00th=[  326], 10.00th=[  326], 20.00th=[  326],
     | 30.00th=[  326], 40.00th=[  326], 50.00th=[  326], 60.00th=[  326],
     | 70.00th=[  326], 80.00th=[  326], 90.00th=[  326], 95.00th=[  326],
     | 99.00th=[  502], 99.50th=[  510], 99.90th=[  523], 99.95th=[  570],
     | 99.99th=[12125]
   bw (  KiB/s): min=746848, max=783088, per=99.51%, avg=764968.00, stdev=25625.55, samples=2
   iops        : min=186712, max=195772, avg=191242.00, stdev=6406.39, samples=2
  lat (usec)   : 250=0.09%, 500=98.88%, 750=1.01%
  lat (msec)   : 20=0.02%
  cpu          : usr=14.38%, sys=48.64%, ctx=248037, majf=0, minf=73
  IO depths    : 1=0.1%, 2=0.1%, 4=0.1%, 8=0.1%, 16=0.1%, 32=0.1%, >=64=100.0%
     submit    : 0=0.0%, 4=100.0%, 8=0.0%, 16=0.0%, 32=0.0%, 64=0.0%, >=64=0.0%
     complete  : 0=0.0%, 4=100.0%, 8=0.0%, 16=0.0%, 32=0.0%, 64=0.1%, >=64=0.0%
     issued rwts: total=262144,0,0,0 short=0,0,0,0 dropped=0,0,0,0
     latency   : target=0, window=0, percentile=100.00%, depth=64

Run status group 0 (all jobs):
   READ: bw=751MiB/s (787MB/s), 751MiB/s-751MiB/s (787MB/s-787MB/s), io=1024MiB (1074MB), run=1364-1364msec

Disk stats (read/write):
  nvme0n1: ios=220228/0, merge=0/0, ticks=70426/0, in_queue=704, util=91.27%


So, I could be persuaded either way. But given the lack of an visible perf
effects, and given that this could will get removed anyway because we'll
likely end up with set_page_dirty() called at GUP time instead...it seems
like it's probably OK to just leave it as is.

thanks,
-- 
John Hubbard
NVIDIA


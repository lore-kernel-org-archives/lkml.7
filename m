Return-Path: <SRS0=wETr=XU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A8976C432C1
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Sep 2019 06:42:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 88AE121D7E
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Sep 2019 06:42:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2393347AbfIYGmY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 25 Sep 2019 02:42:24 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:26890 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S2392973AbfIYGmY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Sep 2019 02:42:24 -0400
Received: from pps.filterd (m0098420.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x8P6bOuY069859
        for <linux-kernel@vger.kernel.org>; Wed, 25 Sep 2019 02:42:22 -0400
Received: from e06smtp03.uk.ibm.com (e06smtp03.uk.ibm.com [195.75.94.99])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2v809f5mj1-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Wed, 25 Sep 2019 02:42:22 -0400
Received: from localhost
        by e06smtp03.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <rppt@linux.ibm.com>;
        Wed, 25 Sep 2019 07:42:20 +0100
Received: from b06cxnps3074.portsmouth.uk.ibm.com (9.149.109.194)
        by e06smtp03.uk.ibm.com (192.168.101.133) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Wed, 25 Sep 2019 07:42:18 +0100
Received: from d06av23.portsmouth.uk.ibm.com (d06av23.portsmouth.uk.ibm.com [9.149.105.59])
        by b06cxnps3074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x8P6gH2n22478876
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 25 Sep 2019 06:42:17 GMT
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 65C5AA405B;
        Wed, 25 Sep 2019 06:42:17 +0000 (GMT)
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id C8B88A4055;
        Wed, 25 Sep 2019 06:42:16 +0000 (GMT)
Received: from linux.ibm.com (unknown [9.148.8.153])
        by d06av23.portsmouth.uk.ibm.com (Postfix) with ESMTPS;
        Wed, 25 Sep 2019 06:42:16 +0000 (GMT)
Date:   Wed, 25 Sep 2019 09:42:15 +0300
From:   Mike Rapoport <rppt@linux.ibm.com>
To:     Adam Ford <aford173@gmail.com>
Cc:     Lucas Stach <l.stach@pengutronix.de>,
        Russell King <linux+etnaviv@armlinux.org.uk>,
        etnaviv@lists.freedesktop.org,
        linux-arm-kernel@lists.infradead.org, linux-mm@kvack.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 00/21] Refine memblock API
References: <1548057848-15136-1-git-send-email-rppt@linux.ibm.com>
 <CAHCN7x+Jv7yGPoB0Gm=TJ30ObLJduw2XomHkd++KqFEURYQcGg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHCN7x+Jv7yGPoB0Gm=TJ30ObLJduw2XomHkd++KqFEURYQcGg@mail.gmail.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-TM-AS-GCONF: 00
x-cbid: 19092506-0012-0000-0000-000003504C83
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19092506-0013-0000-0000-0000218ADF03
Message-Id: <20190925064214.GB1857@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-09-25_04:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1908290000 definitions=main-1909250066
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

(updated CC)

Hi,

On Tue, Sep 24, 2019 at 12:52:35PM -0500, Adam Ford wrote:
> On Mon, Jan 21, 2019 at 2:05 AM Mike Rapoport <rppt@linux.ibm.com> wrote:
> >
> > Hi,
> >
> > v2 changes:
> > * replace some more %lu with %zu
> > * remove panics where they are not needed in s390 and in printk
> > * collect Acked-by and Reviewed-by.
> >
> >
> > Christophe Leroy (1):
> >   powerpc: use memblock functions returning virtual address
> >
> > Mike Rapoport (20):
> >   openrisc: prefer memblock APIs returning virtual address
> >   memblock: replace memblock_alloc_base(ANYWHERE) with memblock_phys_alloc
> >   memblock: drop memblock_alloc_base_nid()
> >   memblock: emphasize that memblock_alloc_range() returns a physical address
> >   memblock: memblock_phys_alloc_try_nid(): don't panic
> >   memblock: memblock_phys_alloc(): don't panic
> >   memblock: drop __memblock_alloc_base()
> >   memblock: drop memblock_alloc_base()
> >   memblock: refactor internal allocation functions
> >   memblock: make memblock_find_in_range_node() and choose_memblock_flags() static
> >   arch: use memblock_alloc() instead of memblock_alloc_from(size, align, 0)
> >   arch: don't memset(0) memory returned by memblock_alloc()
> >   ia64: add checks for the return value of memblock_alloc*()
> >   sparc: add checks for the return value of memblock_alloc*()
> >   mm/percpu: add checks for the return value of memblock_alloc*()
> >   init/main: add checks for the return value of memblock_alloc*()
> >   swiotlb: add checks for the return value of memblock_alloc*()
> >   treewide: add checks for the return value of memblock_alloc*()
> >   memblock: memblock_alloc_try_nid: don't panic
> >   memblock: drop memblock_alloc_*_nopanic() variants
> >
> I know it's rather late, but this patch broke the Etnaviv 3D graphics
> in my i.MX6Q.
 
Can you identify the exact patch from the series that caused the
regression?

> When I try to use the 3D, it returns some errors and the dmesg log
> shows some memory allocation errors too:
> [    3.682347] etnaviv etnaviv: bound 130000.gpu (ops gpu_ops)
> [    3.688669] etnaviv etnaviv: bound 134000.gpu (ops gpu_ops)
> [    3.695099] etnaviv etnaviv: bound 2204000.gpu (ops gpu_ops)
> [    3.700800] etnaviv-gpu 130000.gpu: model: GC2000, revision: 5108
> [    3.723013] etnaviv-gpu 130000.gpu: command buffer outside valid
> memory window
> [    3.731308] etnaviv-gpu 134000.gpu: model: GC320, revision: 5007
> [    3.752437] etnaviv-gpu 134000.gpu: command buffer outside valid
> memory window
> [    3.760583] etnaviv-gpu 2204000.gpu: model: GC355, revision: 1215
> [    3.766766] etnaviv-gpu 2204000.gpu: Ignoring GPU with VG and FE2.0
> [    3.776131] [drm] Initialized etnaviv 1.2.0 20151214 for etnaviv on minor 0
> 
> # glmark2-es2-drm
> Error creating gpu
> Error: eglCreateWindowSurface failed with error: 0x3009
> Error: eglCreateWindowSurface failed with error: 0x3009
> Error: CanvasGeneric: Invalid EGL state
> Error: main: Could not initialize canvas
> 
> 
> Before this patch:
> 
> [    3.691995] etnaviv etnaviv: bound 130000.gpu (ops gpu_ops)
> [    3.698356] etnaviv etnaviv: bound 134000.gpu (ops gpu_ops)
> [    3.704792] etnaviv etnaviv: bound 2204000.gpu (ops gpu_ops)
> [    3.710488] etnaviv-gpu 130000.gpu: model: GC2000, revision: 5108
> [    3.733649] etnaviv-gpu 134000.gpu: model: GC320, revision: 5007
> [    3.756115] etnaviv-gpu 2204000.gpu: model: GC355, revision: 1215
> [    3.762250] etnaviv-gpu 2204000.gpu: Ignoring GPU with VG and FE2.0
> [    3.771432] [drm] Initialized etnaviv 1.2.0 20151214 for etnaviv on minor 0
> 
> and the 3D gemos work without this.
> 
> I don't know enough about the i.MX6 nor the 3D accelerator to know how
> to fix it.
> I am hoping someone in the know might have some suggestions.

Can you please add "memblock=debug" to your kernel command line and send
kernel logs for both working and failing versions? 

-- 
Sincerely yours,
Mike.


Return-Path: <SRS0=6dNS=X4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CE3C9C10F14
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Oct 2019 11:30:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9E4C4206BB
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Oct 2019 11:30:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730054AbfJCLaW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 3 Oct 2019 07:30:22 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:32834 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1729912AbfJCLaW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Oct 2019 07:30:22 -0400
Received: from pps.filterd (m0098414.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x93BRXVd017056
        for <linux-kernel@vger.kernel.org>; Thu, 3 Oct 2019 07:30:20 -0400
Received: from e06smtp03.uk.ibm.com (e06smtp03.uk.ibm.com [195.75.94.99])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2vdfcjsp0y-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Thu, 03 Oct 2019 07:30:20 -0400
Received: from localhost
        by e06smtp03.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <rppt@linux.ibm.com>;
        Thu, 3 Oct 2019 12:30:18 +0100
Received: from b06cxnps4075.portsmouth.uk.ibm.com (9.149.109.197)
        by e06smtp03.uk.ibm.com (192.168.101.133) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Thu, 3 Oct 2019 12:30:14 +0100
Received: from d06av25.portsmouth.uk.ibm.com (d06av25.portsmouth.uk.ibm.com [9.149.105.61])
        by b06cxnps4075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x93BUDku57016436
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 3 Oct 2019 11:30:13 GMT
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 7F81A11C058;
        Thu,  3 Oct 2019 11:30:13 +0000 (GMT)
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 9FA8511C052;
        Thu,  3 Oct 2019 11:30:12 +0000 (GMT)
Received: from linux.ibm.com (unknown [9.148.8.153])
        by d06av25.portsmouth.uk.ibm.com (Postfix) with ESMTPS;
        Thu,  3 Oct 2019 11:30:12 +0000 (GMT)
Date:   Thu, 3 Oct 2019 14:30:10 +0300
From:   Mike Rapoport <rppt@linux.ibm.com>
To:     Russell King - ARM Linux admin <linux@armlinux.org.uk>
Cc:     Adam Ford <aford173@gmail.com>, Fabio Estevam <festevam@gmail.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Christoph Hellwig <hch@lst.de>,
        The etnaviv authors <etnaviv@lists.freedesktop.org>,
        arm-soc <linux-arm-kernel@lists.infradead.org>,
        Linux Memory Management List <linux-mm@kvack.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Lucas Stach <l.stach@pengutronix.de>
Subject: Re: [PATCH v2 00/21] Refine memblock API
References: <CAHCN7xJ32BYZu-DVTVLSzv222U50JDb8F0A_tLDERbb8kPdRxg@mail.gmail.com>
 <20190926160433.GD32311@linux.ibm.com>
 <CAHCN7xL1sFXDhKUpj04d3eDZNgLA1yGAOqwEeCxedy1Qm-JOfQ@mail.gmail.com>
 <20190928073331.GA5269@linux.ibm.com>
 <CAHCN7xJEvS2Si=M+BYtz+kY0M4NxmqDjiX9Nwq6_3GGBh3yg=w@mail.gmail.com>
 <CAHCN7xKLhWw4P9-sZKXQcfSfh2r3J_+rLxuxACW0UVgimCzyVw@mail.gmail.com>
 <20191002073605.GA30433@linux.ibm.com>
 <CAHCN7xL1MkJh44N3W_1+08DHmX__SqnfH6dqUzYzr2Wpg0kQyQ@mail.gmail.com>
 <20191003053451.GA23397@linux.ibm.com>
 <20191003084914.GV25745@shell.armlinux.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191003084914.GV25745@shell.armlinux.org.uk>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-TM-AS-GCONF: 00
x-cbid: 19100311-0012-0000-0000-00000353A8D8
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19100311-0013-0000-0000-0000218EAF93
Message-Id: <20191003113010.GC23397@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-10-03_05:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1908290000 definitions=main-1910030107
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 03, 2019 at 09:49:14AM +0100, Russell King - ARM Linux admin wrote:
> On Thu, Oct 03, 2019 at 08:34:52AM +0300, Mike Rapoport wrote:
> > (trimmed the CC)
> > 
> > On Wed, Oct 02, 2019 at 06:14:11AM -0500, Adam Ford wrote:
> > > On Wed, Oct 2, 2019 at 2:36 AM Mike Rapoport <rppt@linux.ibm.com> wrote:
> > > >
> > > 
> > > Before the patch:
> > > 
> > > # cat /sys/kernel/debug/memblock/memory
> > >    0: 0x10000000..0x8fffffff
> > > # cat /sys/kernel/debug/memblock/reserved
> > >    0: 0x10004000..0x10007fff
> > >   34: 0x2fffff88..0x3fffffff
> > > 
> > > 
> > > After the patch:
> > > # cat /sys/kernel/debug/memblock/memory
> > >    0: 0x10000000..0x8fffffff
> > > # cat /sys/kernel/debug/memblock/reserved
> > >    0: 0x10004000..0x10007fff
> > >   36: 0x80000000..0x8fffffff
> > 
> > I'm still not convinced that the memblock refactoring didn't uncovered an
> > issue in etnaviv driver.
> > 
> > Why moving the CMA area from 0x80000000 to 0x30000000 makes it fail?
> 
> I think you have that the wrong way round.

I'm relying on Adam's reports of working and non-working versions.
According to that etnaviv works when CMA area is at 0x80000000 and does not
work when it is at 0x30000000.

He also sent logs a few days ago [1], they also confirm that.

[1] https://lore.kernel.org/linux-mm/CAHCN7xJEvS2Si=M+BYtz+kY0M4NxmqDjiX9Nwq6_3GGBh3yg=w@mail.gmail.com/
 
> > BTW, the code that complained about "command buffer outside valid memory
> > window" has been removed by the commit 17e4660ae3d7 ("drm/etnaviv:
> > implement per-process address spaces on MMUv2"). 
> > 
> > Could be that recent changes to MMU management of etnaviv resolve the
> > issue?
> 
> The iMX6 does not have MMUv2 hardware, it has MMUv1.  With MMUv1
> hardware requires command buffers within the first 2GiB of physical
> RAM.

I've mentioned that patch because it removed the check for cmdbuf address
for MMUv1:

@@ -785,15 +768,7 @@ int etnaviv_gpu_init(struct etnaviv_gpu *gpu)
                                  PAGE_SIZE);
        if (ret) {
                dev_err(gpu->dev, "could not create command buffer\n");
-               goto unmap_suballoc;
-       }
-
-       if (!(gpu->identity.minor_features1 & chipMinorFeatures1_MMU_VERSION) &&
-           etnaviv_cmdbuf_get_va(&gpu->buffer, &gpu->cmdbuf_mapping) > 0x80000000) {
-               ret = -EINVAL;
-               dev_err(gpu->dev,
-                       "command buffer outside valid memory window\n");
-               goto free_buffer;
+               goto fail;
        }
 
        /* Setup event management */


I really don't know how etnaviv works, so I hoped that people who
understand it would help.
 
> I've reported the problem previously but there was no resolution,
> other than pointing the blame at CMA.
> 
> https://lists.freedesktop.org/archives/dri-devel/2019-June/thread.html#223516
> 
> -- 
> RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
> FTTC broadband for 0.8mile line in suburbia: sync at 12.1Mbps down 622kbps up
> According to speedtest.net: 11.9Mbps down 500kbps up

-- 
Sincerely yours,
Mike.


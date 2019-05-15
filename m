Return-Path: <SRS0=FrXW=TP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DD7E1C04AA7
	for <linux-kernel@archiver.kernel.org>; Wed, 15 May 2019 05:01:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A8D6E20862
	for <linux-kernel@archiver.kernel.org>; Wed, 15 May 2019 05:01:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726188AbfEOFBO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 15 May 2019 01:01:14 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:33056 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725876AbfEOFBO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 May 2019 01:01:14 -0400
Received: from pps.filterd (m0098414.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x4F4w0BL120299
        for <linux-kernel@vger.kernel.org>; Wed, 15 May 2019 01:01:12 -0400
Received: from e06smtp07.uk.ibm.com (e06smtp07.uk.ibm.com [195.75.94.103])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2sgaxgtyqw-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Wed, 15 May 2019 01:01:12 -0400
Received: from localhost
        by e06smtp07.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <rppt@linux.ibm.com>;
        Wed, 15 May 2019 06:01:10 +0100
Received: from b06cxnps4076.portsmouth.uk.ibm.com (9.149.109.198)
        by e06smtp07.uk.ibm.com (192.168.101.137) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Wed, 15 May 2019 06:01:03 +0100
Received: from d06av23.portsmouth.uk.ibm.com (d06av23.portsmouth.uk.ibm.com [9.149.105.59])
        by b06cxnps4076.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x4F512xp42795236
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 15 May 2019 05:01:02 GMT
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 8CD14A4057;
        Wed, 15 May 2019 05:01:02 +0000 (GMT)
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 36EDBA406E;
        Wed, 15 May 2019 05:01:01 +0000 (GMT)
Received: from rapoport-lnx (unknown [9.148.8.112])
        by d06av23.portsmouth.uk.ibm.com (Postfix) with ESMTPS;
        Wed, 15 May 2019 05:01:01 +0000 (GMT)
Date:   Wed, 15 May 2019 08:00:59 +0300
From:   Mike Rapoport <rppt@linux.ibm.com>
To:     Stephen Boyd <swboyd@chromium.org>
Cc:     Hsin-Yi Wang <hsinyi@chromium.org>,
        "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Frank Rowand <frowand.list@gmail.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Kees Cook <keescook@chromium.org>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Architecture Mailman List <boot-architecture@lists.linaro.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Michal Hocko <mhocko@suse.com>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Miles Chen <miles.chen@mediatek.com>,
        James Morse <james.morse@arm.com>,
        Andrew Murray <andrew.murray@arm.com>
Subject: Re: [PATCH v2 2/2] amr64: map FDT as RW for early_init_dt_scan()
References: <20190513003819.356-1-hsinyi@chromium.org>
 <20190513003819.356-2-hsinyi@chromium.org>
 <20190513085853.GB9271@rapoport-lnx>
 <CAJMQK-hKrU2J0_uGe3eO_JTNwM=HRkXbDx2u45izcdD7wqwGeQ@mail.gmail.com>
 <155786794318.14659.2925897827978978040@swboyd.mtv.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <155786794318.14659.2925897827978978040@swboyd.mtv.corp.google.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-TM-AS-GCONF: 00
x-cbid: 19051505-0028-0000-0000-0000036DCC02
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19051505-0029-0000-0000-0000242D606A
Message-Id: <20190515050059.GA4081@rapoport-lnx>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-05-15_05:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1905150031
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 14, 2019 at 02:05:43PM -0700, Stephen Boyd wrote:
> Quoting Hsin-Yi Wang (2019-05-13 04:14:32)
> > On Mon, May 13, 2019 at 4:59 PM Mike Rapoport <rppt@linux.ibm.com> wrote:
> > 
> > >
> > > This makes the fdt mapped without the call to meblock_reserve(fdt) which
> > > makes the fdt memory available for memblock allocations.
> > >
> > > Chances that is will be actually allocated are small, but you know, things
> > > happen.
> > >
> > > IMHO, instead of calling directly __fixmap_remap_fdt() it would be better
> > > to add pgprot parameter to fixmap_remap_fdt(). Then here and in kaslr.c it
> > > can be called with PAGE_KERNEL and below with PAGE_KERNEL_RO.
> > >
> > > There is no problem to call memblock_reserve() for the same area twice,
> > > it's essentially a NOP.
> > >
> > Thanks for the suggestion. Will update fixmap_remap_fdt() in next patch.
> > 
> > However, I tested on some arm64 platform, if we also call
> > memblock_reserve() in kaslr.c, would cause warning[1] when
> > memblock_reserve() is called again in setup_machine_fdt(). The warning
> > comes from https://elixir.bootlin.com/linux/latest/source/mm/memblock.c#L601
> > ```
> > if (type->regions[0].size == 0) {
> >   WARN_ON(type->cnt != 1 || type->total_size);
> >   ...
> > ```
> > 
> > Call memblock_reserve() multiple times after setup_machine_fdt()
> > doesn't have such warning though.
> > 
> > I didn't trace the real reason causing this. But in this case, maybe
> > don't call memblock_reserve() in kaslr?
> > 
> 
> Why not just have fixmap_remap_fdt() that maps it as RW and reserves
> memblock once, and then call __fixmap_remap_fdt() with RO after
> early_init_dt_scan() or unflatten_device_tree() is called? Why the
> desire to call memblock_reserve() twice or even three times?

There's no desire to call memblock_reserve() twice. It's just that leaving
the call for it in kaslr rather than in setup_arch() may end up with
unreserved FDT because kaslr was disabled or even compiled out.

I've suggested to use fixmap_remap_fdt() everywhere because IMHO this
improves readability and allows to un-export __fixmap_remap_fdt().

-- 
Sincerely yours,
Mike.


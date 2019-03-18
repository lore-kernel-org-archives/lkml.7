Return-Path: <SRS0=xYIU=RV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CCEF1C43381
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Mar 2019 07:18:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 95D7420835
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Mar 2019 07:18:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726973AbfCRHSm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Mar 2019 03:18:42 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:39408 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726135AbfCRHSm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Mar 2019 03:18:42 -0400
Received: from pps.filterd (m0098409.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x2I7GNkZ046579
        for <linux-kernel@vger.kernel.org>; Mon, 18 Mar 2019 03:18:40 -0400
Received: from e06smtp03.uk.ibm.com (e06smtp03.uk.ibm.com [195.75.94.99])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2ra44twknp-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Mon, 18 Mar 2019 03:18:40 -0400
Received: from localhost
        by e06smtp03.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <rppt@linux.ibm.com>;
        Mon, 18 Mar 2019 07:18:36 -0000
Received: from b06cxnps3075.portsmouth.uk.ibm.com (9.149.109.195)
        by e06smtp03.uk.ibm.com (192.168.101.133) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Mon, 18 Mar 2019 07:18:33 -0000
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (b06wcsmtp001.portsmouth.uk.ibm.com [9.149.105.160])
        by b06cxnps3075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x2I7IXGc26935510
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 18 Mar 2019 07:18:33 GMT
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id B99FFA4054;
        Mon, 18 Mar 2019 07:18:33 +0000 (GMT)
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id CC798A4068;
        Mon, 18 Mar 2019 07:18:32 +0000 (GMT)
Received: from rapoport-lnx (unknown [9.148.205.203])
        by b06wcsmtp001.portsmouth.uk.ibm.com (Postfix) with ESMTPS;
        Mon, 18 Mar 2019 07:18:32 +0000 (GMT)
Date:   Mon, 18 Mar 2019 09:18:31 +0200
From:   Mike Rapoport <rppt@linux.ibm.com>
To:     Anup Patel <anup@brainfault.org>
Cc:     Anup Patel <Anup.Patel@wdc.com>,
        Palmer Dabbelt <palmer@sifive.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Atish Patra <Atish.Patra@wdc.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Christoph Hellwig <hch@infradead.org>,
        "linux-riscv@lists.infradead.org" <linux-riscv@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 3/3] RISC-V: Allow booting kernel from any 4KB aligned
 address
References: <20190312220752.128141-1-anup.patel@wdc.com>
 <20190312220752.128141-4-anup.patel@wdc.com>
 <20190313183121.GB28630@rapoport-lnx>
 <CAAhSdy1mrV2CakS0cfOY8F1B7uH_yXjO3W-CiMUcYonkRnVbeQ@mail.gmail.com>
 <20190314065311.GC24380@rapoport-lnx>
 <CAAhSdy2uEgyvs=5NdoZ3H208qeDGJ9OrTOeaz6HQ+1va+R3dUA@mail.gmail.com>
 <20190315155828.GB920@rapoport-lnx>
 <CAAhSdy0HoTTccyy203Y9m3kdAjCOzjjMdrb670huU71pjOMw4A@mail.gmail.com>
 <CAAhSdy0D6JpySExCG7ziSSDmQ_88=paiMwjjXTTR1gbKCEOs3g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAAhSdy0D6JpySExCG7ziSSDmQ_88=paiMwjjXTTR1gbKCEOs3g@mail.gmail.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-TM-AS-GCONF: 00
x-cbid: 19031807-0012-0000-0000-0000030425B1
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19031807-0013-0000-0000-0000213B2E09
Message-Id: <20190318071829.GF21385@rapoport-lnx>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-03-18_05:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1903180056
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Mar 16, 2019 at 04:55:30AM +0530, Anup Patel wrote:
> On Fri, Mar 15, 2019 at 9:52 PM Anup Patel <anup@brainfault.org> wrote:
> >
> > On Fri, Mar 15, 2019 at 9:28 PM Mike Rapoport <rppt@linux.ibm.com> wrote:
> > >
> > > I still don't get why it is that important to relax alignment of the kernel
> > > load address. Provided you can use the memory below the kernel, it really
> > > should not matter.
> >
> > Irrespective to constraint on kernel load address, we certainly need
> > to allow memory below kernel to be usable but that's a separate change.
> >
> > Currently, the memory below kernel is ignored by
> > early_init_dt_add_memory_arch() in
> > drivers/of/fdt.c
> >
> 
> I explored the possibility of re-claiming memory below kernel but then
> we have an issue in this case.
> 
> For RISC-V kernel, PAGE_OFFSET is mapped to kernel load address
> (i.e. load_pa in this code). The va_pa_offset is based on load_pa so linear
> conversion of VA-to-PA and PA-to-VA won't be possible on the memory
> below kernel. I guess this is why early_init_dt_add_memory_arch() is
> marking memory below kernel as reserved. Is there better way to do it??
> 
> We started exploring ways to re-claim memory below kernel because
> we are trying to get Linux working on Kendryte K210 board
> (https://kendryte.com/). This board has dual-core 64bit RISC-V but it
> only has 8MB RAM.

Huh, 8MB of RAM is tough...

It is possible to use the memory below the kernel, e.g x86-64 does that.
But it is definitely a separate change and with such RAM diet using 4K
pages seems unavoidable.

I still have concern about using 4K pages whenever the load address is not
2M (4M) aligned. People tend to not pay enough attention to such details
and they would load the kernel at an arbitrary address and get the
performance hit.

I think the default should remain as is and the ability to map the kernel
with 4K pages (and use 4K aligned load address) should be a Kconfig option.

Another thing I'd like to suggest is to completely split swapper_pg_dir
initialization from setup_vm() and keep this function solely for
initialization of the trampoline_pg_dir. The trampoline_pg_dir can use
large pages and the memory below the kernel start can be mapped there
simply by mapping the entire large page containing the kernel start.
Then, the swapper_pg_dir setup can run with virtual memory enabled and can
have much more flexibility.

> 
> Regards,
> Anup
> 

-- 
Sincerely yours,
Mike.


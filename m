Return-Path: <SRS0=2kAr=R3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EFFDCC10F00
	for <linux-kernel@archiver.kernel.org>; Sun, 24 Mar 2019 16:43:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BEA1D2171F
	for <linux-kernel@archiver.kernel.org>; Sun, 24 Mar 2019 16:43:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728870AbfCXQnb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 24 Mar 2019 12:43:31 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:39382 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727137AbfCXQnb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 24 Mar 2019 12:43:31 -0400
Received: from pps.filterd (m0098416.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x2OGdDNN189053
        for <linux-kernel@vger.kernel.org>; Sun, 24 Mar 2019 12:43:29 -0400
Received: from e06smtp01.uk.ibm.com (e06smtp01.uk.ibm.com [195.75.94.97])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2re22udrbp-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Sun, 24 Mar 2019 12:43:29 -0400
Received: from localhost
        by e06smtp01.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <rppt@linux.ibm.com>;
        Sun, 24 Mar 2019 16:43:27 -0000
Received: from b06cxnps4074.portsmouth.uk.ibm.com (9.149.109.196)
        by e06smtp01.uk.ibm.com (192.168.101.131) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Sun, 24 Mar 2019 16:43:23 -0000
Received: from d06av24.portsmouth.uk.ibm.com (d06av24.portsmouth.uk.ibm.com [9.149.105.60])
        by b06cxnps4074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x2OGhM8U38010966
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sun, 24 Mar 2019 16:43:22 GMT
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 5F31642041;
        Sun, 24 Mar 2019 16:43:22 +0000 (GMT)
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 6E5E04203F;
        Sun, 24 Mar 2019 16:43:21 +0000 (GMT)
Received: from rapoport-lnx (unknown [9.148.207.29])
        by d06av24.portsmouth.uk.ibm.com (Postfix) with ESMTPS;
        Sun, 24 Mar 2019 16:43:21 +0000 (GMT)
Date:   Sun, 24 Mar 2019 18:43:17 +0200
From:   Mike Rapoport <rppt@linux.ibm.com>
To:     Christoph Hellwig <hch@lst.de>
Cc:     Anup Patel <Anup.Patel@wdc.com>,
        Palmer Dabbelt <palmer@sifive.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Atish Patra <Atish.Patra@wdc.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Christoph Hellwig <hch@infradead.org>,
        "linux-riscv@lists.infradead.org" <linux-riscv@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] RISC-V: Always compile mm/init.c with cmodel=medany
References: <20190324110804.68555-1-anup.patel@wdc.com>
 <20190324145708.GA3355@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190324145708.GA3355@lst.de>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-TM-AS-GCONF: 00
x-cbid: 19032416-4275-0000-0000-0000031EB317
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19032416-4276-0000-0000-0000382D429A
Message-Id: <20190324164316.GA2925@rapoport-lnx>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-03-24_10:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=932 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1903240128
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Mar 24, 2019 at 03:57:08PM +0100, Christoph Hellwig wrote:
> On Sun, Mar 24, 2019 at 11:08:29AM +0000, Anup Patel wrote:
> > Signed-off-by: Christoph Hellwig <hch@lst.de>
> > Signed-off-by: Mike Rapoport <rppt@linux.ibm.com>
> 
> Huh?  I don't think this is from Mike and me.

Suggested-by: would me more appropriate indeed :)
 
> > +unsigned long va_pa_offset;
> > +EXPORT_SYMBOL(va_pa_offset);
> > +unsigned long pfn_base;
> > +EXPORT_SYMBOL(pfn_base);
> 
> Can you move va_pa_offset and pfn_base next to the swapper_pg_dir
> declaration?  Thats where I move them in my current nommu patchset,
> as that allows to just have a single CONFIG_NOMMU in mm/init.c.
> 
> Otherwise this looks fine to me.
> 

-- 
Sincerely yours,
Mike.


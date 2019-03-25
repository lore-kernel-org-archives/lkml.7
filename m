Return-Path: <SRS0=yZjE=R4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A73A0C43381
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Mar 2019 07:20:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7B58920830
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Mar 2019 07:20:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729859AbfCYHUe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Mar 2019 03:20:34 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:52534 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1729842AbfCYHUe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Mar 2019 03:20:34 -0400
Received: from pps.filterd (m0098417.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x2P7Du3D090775
        for <linux-kernel@vger.kernel.org>; Mon, 25 Mar 2019 03:20:32 -0400
Received: from e06smtp07.uk.ibm.com (e06smtp07.uk.ibm.com [195.75.94.103])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2rer1px6b2-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Mon, 25 Mar 2019 03:20:32 -0400
Received: from localhost
        by e06smtp07.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <rppt@linux.ibm.com>;
        Mon, 25 Mar 2019 07:20:30 -0000
Received: from b06cxnps3075.portsmouth.uk.ibm.com (9.149.109.195)
        by e06smtp07.uk.ibm.com (192.168.101.137) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Mon, 25 Mar 2019 07:20:26 -0000
Received: from d06av22.portsmouth.uk.ibm.com (d06av22.portsmouth.uk.ibm.com [9.149.105.58])
        by b06cxnps3075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x2P7KPQc55116010
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 25 Mar 2019 07:20:25 GMT
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id B35974C05C;
        Mon, 25 Mar 2019 07:20:25 +0000 (GMT)
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id CD6164C044;
        Mon, 25 Mar 2019 07:20:24 +0000 (GMT)
Received: from rapoport-lnx (unknown [9.148.207.233])
        by d06av22.portsmouth.uk.ibm.com (Postfix) with ESMTPS;
        Mon, 25 Mar 2019 07:20:24 +0000 (GMT)
Date:   Mon, 25 Mar 2019 09:20:23 +0200
From:   Mike Rapoport <rppt@linux.ibm.com>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Christoph Hellwig <hch@lst.de>, Palmer Dabbelt <palmer@sifive.com>,
        Richard Kuo <rkuo@codeaurora.org>, linux-arch@vger.kernel.org,
        linux-hexagon@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, linux-riscv@lists.infradead.org
Subject: Re: [PATCH v2 0/4] provide a generic free_initmem implementation
References: <1550515285-17446-1-git-send-email-rppt@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1550515285-17446-1-git-send-email-rppt@linux.ibm.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-TM-AS-GCONF: 00
x-cbid: 19032507-0028-0000-0000-00000357E015
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19032507-0029-0000-0000-000024169150
Message-Id: <20190325072022.GD2925@rapoport-lnx>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-03-25_04:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=976 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1903250055
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Any comments on this?

On Mon, Feb 18, 2019 at 08:41:21PM +0200, Mike Rapoport wrote:
> Hi,
> 
> Many architectures implement free_initmem() in exactly the same or very
> similar way: they wrap the call to free_initmem_default() with sometimes
> different 'poison' parameter.
> 
> These patches switch those architectures to use a generic implementation
> that does free_initmem_default(POISON_FREE_INITMEM).
> 
> This was inspired by Christoph's patches for free_initrd_mem [1] and I
> shamelessly copied changelog entries from his patches :)
> 
> v2: rebased on top of v5.0-rc7 + Christoph's patches for free_initrd_mem
> 
> [1] https://lore.kernel.org/lkml/20190213174621.29297-1-hch@lst.de/
> 
> Mike Rapoport (4):
>   init: provide a generic free_initmem implementation
>   hexagon: switch over to generic free_initmem()
>   init: free_initmem: poison freed init memory
>   riscv: switch over to generic free_initmem()
> 
>  arch/alpha/mm/init.c      |  6 ------
>  arch/arc/mm/init.c        |  8 --------
>  arch/c6x/mm/init.c        |  5 -----
>  arch/h8300/mm/init.c      |  6 ------
>  arch/hexagon/mm/init.c    | 10 ----------
>  arch/microblaze/mm/init.c |  5 -----
>  arch/nds32/mm/init.c      |  5 -----
>  arch/nios2/mm/init.c      |  5 -----
>  arch/openrisc/mm/init.c   |  5 -----
>  arch/riscv/mm/init.c      |  5 -----
>  arch/sh/mm/init.c         |  5 -----
>  arch/sparc/mm/init_32.c   |  5 -----
>  arch/unicore32/mm/init.c  |  5 -----
>  arch/xtensa/mm/init.c     |  5 -----
>  init/main.c               |  5 +++++
>  15 files changed, 5 insertions(+), 80 deletions(-)
> 
> -- 
> 2.7.4
> 

-- 
Sincerely yours,
Mike.


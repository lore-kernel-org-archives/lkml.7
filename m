Return-Path: <SRS0=kjqD=WY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 01E39C3A5A6
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Aug 2019 14:39:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C61B82064A
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Aug 2019 14:39:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726777AbfH1Oj6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 28 Aug 2019 10:39:58 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:27834 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726315AbfH1Oj4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Aug 2019 10:39:56 -0400
Received: from pps.filterd (m0098410.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x7SEciaG122349
        for <linux-kernel@vger.kernel.org>; Wed, 28 Aug 2019 10:39:55 -0400
Received: from e06smtp04.uk.ibm.com (e06smtp04.uk.ibm.com [195.75.94.100])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2unuc00jhs-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Wed, 28 Aug 2019 10:39:55 -0400
Received: from localhost
        by e06smtp04.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <rppt@linux.ibm.com>;
        Wed, 28 Aug 2019 15:39:53 +0100
Received: from b06avi18626390.portsmouth.uk.ibm.com (9.149.26.192)
        by e06smtp04.uk.ibm.com (192.168.101.134) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Wed, 28 Aug 2019 15:39:50 +0100
Received: from d06av22.portsmouth.uk.ibm.com (d06av22.portsmouth.uk.ibm.com [9.149.105.58])
        by b06avi18626390.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x7SEdRfs35062130
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 28 Aug 2019 14:39:27 GMT
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 13DE64C04A;
        Wed, 28 Aug 2019 14:39:49 +0000 (GMT)
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id B006A4C046;
        Wed, 28 Aug 2019 14:39:48 +0000 (GMT)
Received: from rapoport-lnx (unknown [9.148.8.86])
        by d06av22.portsmouth.uk.ibm.com (Postfix) with ESMTPS;
        Wed, 28 Aug 2019 14:39:48 +0000 (GMT)
Date:   Wed, 28 Aug 2019 17:39:47 +0300
From:   Mike Rapoport <rppt@linux.ibm.com>
To:     Guo Ren <guoren@kernel.org>
Cc:     linux-csky@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] csky: use generic free_initrd_mem()
References: <1566999319-8151-1-git-send-email-rppt@linux.ibm.com>
 <CAJF2gTTF0W18kPzXP8hOA64FuOx=atxFnCk0syEhP7s7LOm0Kw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJF2gTTF0W18kPzXP8hOA64FuOx=atxFnCk0syEhP7s7LOm0Kw@mail.gmail.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-TM-AS-GCONF: 00
x-cbid: 19082814-0016-0000-0000-000002A3ED62
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19082814-0017-0000-0000-000033043E8B
Message-Id: <20190828143946.GA21342@rapoport-lnx>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-08-28_07:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=986 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1906280000 definitions=main-1908280154
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Wed, Aug 28, 2019 at 10:12:52PM +0800, Guo Ren wrote:
> Acked-by: Guo Ren <guoren@kernel.org>

Do you mind taking it via csky tree?
 
> On Wed, Aug 28, 2019 at 9:35 PM Mike Rapoport <rppt@linux.ibm.com> wrote:
> >
> > The csky implementation of free_initrd_mem() is an open-coded version of
> > free_reserved_area() without poisoning.
> >
> > Remove it and make csky use the generic version of free_initrd_mem().
> >
> > Signed-off-by: Mike Rapoport <rppt@linux.ibm.com>
> > ---
> >  arch/csky/mm/init.c | 16 ----------------
> >  1 file changed, 16 deletions(-)
> >
> > diff --git a/arch/csky/mm/init.c b/arch/csky/mm/init.c
> > index eb0dc9e..d4c2292 100644
> > --- a/arch/csky/mm/init.c
> > +++ b/arch/csky/mm/init.c
> > @@ -60,22 +60,6 @@ void __init mem_init(void)
> >         mem_init_print_info(NULL);
> >  }
> >
> > -#ifdef CONFIG_BLK_DEV_INITRD
> > -void free_initrd_mem(unsigned long start, unsigned long end)
> > -{
> > -       if (start < end)
> > -               pr_info("Freeing initrd memory: %ldk freed\n",
> > -                       (end - start) >> 10);
> > -
> > -       for (; start < end; start += PAGE_SIZE) {
> > -               ClearPageReserved(virt_to_page(start));
> > -               init_page_count(virt_to_page(start));
> > -               free_page(start);
> > -               totalram_pages_inc();
> > -       }
> > -}
> > -#endif
> > -
> >  extern char __init_begin[], __init_end[];
> >
> >  void free_initmem(void)
> > --
> > 2.7.4
> >
> 
> 
> -- 
> Best Regards
>  Guo Ren
> 
> ML: https://lore.kernel.org/linux-csky/
> 

-- 
Sincerely yours,
Mike.


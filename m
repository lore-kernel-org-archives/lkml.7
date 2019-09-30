Return-Path: <SRS0=rUXN=XZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CA8FFC388F4
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Sep 2019 07:44:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A800E2190F
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Sep 2019 07:44:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729685AbfI3Hor (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 30 Sep 2019 03:44:47 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:36796 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726121AbfI3Hor (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Sep 2019 03:44:47 -0400
Received: from pps.filterd (m0098419.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x8U7glWl041126
        for <linux-kernel@vger.kernel.org>; Mon, 30 Sep 2019 03:44:44 -0400
Received: from e06smtp02.uk.ibm.com (e06smtp02.uk.ibm.com [195.75.94.98])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2vbadrpxe8-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Mon, 30 Sep 2019 03:44:44 -0400
Received: from localhost
        by e06smtp02.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <heiko.carstens@de.ibm.com>;
        Mon, 30 Sep 2019 08:44:42 +0100
Received: from b06cxnps3075.portsmouth.uk.ibm.com (9.149.109.195)
        by e06smtp02.uk.ibm.com (192.168.101.132) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Mon, 30 Sep 2019 08:44:40 +0100
Received: from d06av24.portsmouth.uk.ibm.com (mk.ibm.com [9.149.105.60])
        by b06cxnps3075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x8U7icjS53673992
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 30 Sep 2019 07:44:39 GMT
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id DB8404203F;
        Mon, 30 Sep 2019 07:44:38 +0000 (GMT)
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 8A1A342041;
        Mon, 30 Sep 2019 07:44:38 +0000 (GMT)
Received: from osiris (unknown [9.152.212.201])
        by d06av24.portsmouth.uk.ibm.com (Postfix) with ESMTPS;
        Mon, 30 Sep 2019 07:44:38 +0000 (GMT)
Date:   Mon, 30 Sep 2019 09:44:37 +0200
From:   Heiko Carstens <heiko.carstens@de.ibm.com>
To:     Qian Cai <cai@lca.pw>, Peter Oberparleiter <oberpar@linux.ibm.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>, gor@linux.ibm.com,
        borntraeger@de.ibm.com, linux-s390@vger.kernel.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mm/page_alloc: fix a crash in free_pages_prepare()
References: <1569613623-16820-1-git-send-email-cai@lca.pw>
 <20190927134859.95a2f4908bdcea30df0184ed@linux-foundation.org>
 <1569618908.5576.240.camel@lca.pw>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1569618908.5576.240.camel@lca.pw>
X-TM-AS-GCONF: 00
x-cbid: 19093007-0008-0000-0000-0000031C541A
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19093007-0009-0000-0000-00004A3AF916
Message-Id: <20190930074437.GB5604@osiris>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-09-30_04:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=84 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1908290000 definitions=main-1909300082
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 27, 2019 at 05:15:08PM -0400, Qian Cai wrote:
> On Fri, 2019-09-27 at 13:48 -0700, Andrew Morton wrote:
> > On Fri, 27 Sep 2019 15:47:03 -0400 Qian Cai <cai@lca.pw> wrote:
> > > --- a/mm/page_alloc.c
> > > +++ b/mm/page_alloc.c
> > > @@ -1175,11 +1175,11 @@ static __always_inline bool free_pages_prepare(struct page *page,
> > >  		debug_check_no_obj_freed(page_address(page),
> > >  					   PAGE_SIZE << order);
> > >  	}
> > > -	arch_free_page(page, order);
> > >  	if (want_init_on_free())
> > >  		kernel_init_free_pages(page, 1 << order);
> > >  
> > >  	kernel_poison_pages(page, 1 << order, 0);
> > > +	arch_free_page(page, order);
> > >  	if (debug_pagealloc_enabled())
> > >  		kernel_map_pages(page, 1 << order, 0);
> > 
> > This is all fairly mature code, isn't it?  What happened to make this
> > problem pop up now?
> 
> In the past, there is only kernel_poison_pages() would trigger it but it needs
> "page_poison=on" kernel cmdline, and I suspect nobody tested that on s390 in the
> past.

Yes. Peter Oberparleiter reported this also before my short vacation,
but I didn't have time to look into this. Thanks for fixing!

Reviewed-by: Heiko Carstens <heiko.carstens@de.ibm.com>


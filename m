Return-Path: <SRS0=BPXs=SN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1968AC10F13
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Apr 2019 07:43:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E370E217D4
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Apr 2019 07:43:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726944AbfDKHno (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 11 Apr 2019 03:43:44 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:47714 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726104AbfDKHnm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Apr 2019 03:43:42 -0400
Received: from pps.filterd (m0098410.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x3B7hSxM073026
        for <linux-kernel@vger.kernel.org>; Thu, 11 Apr 2019 03:43:40 -0400
Received: from e06smtp05.uk.ibm.com (e06smtp05.uk.ibm.com [195.75.94.101])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2rt0ynhkp0-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Thu, 11 Apr 2019 03:43:39 -0400
Received: from localhost
        by e06smtp05.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <schwidefsky@de.ibm.com>;
        Thu, 11 Apr 2019 08:41:00 +0100
Received: from b06cxnps4075.portsmouth.uk.ibm.com (9.149.109.197)
        by e06smtp05.uk.ibm.com (192.168.101.135) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Thu, 11 Apr 2019 08:40:58 +0100
Received: from d06av26.portsmouth.uk.ibm.com (d06av26.portsmouth.uk.ibm.com [9.149.105.62])
        by b06cxnps4075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x3B7eue857671698
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 11 Apr 2019 07:40:56 GMT
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id A0FBDAE053;
        Thu, 11 Apr 2019 07:40:56 +0000 (GMT)
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 424DDAE051;
        Thu, 11 Apr 2019 07:40:56 +0000 (GMT)
Received: from mschwideX1 (unknown [9.145.74.176])
        by d06av26.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Thu, 11 Apr 2019 07:40:56 +0000 (GMT)
Date:   Thu, 11 Apr 2019 09:40:55 +0200
From:   Martin Schwidefsky <schwidefsky@de.ibm.com>
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     Harald Freudenberger <freude@linux.ibm.com>,
        Heiko Carstens <heiko.carstens@de.ibm.com>,
        clang-built-linux@googlegroups.com,
        Nick Desaulniers <ndesaulniers@google.com>,
        Nathan Chancellor <natechancellor@gmail.com>,
        linux-s390 <linux-s390@vger.kernel.org>,
        Ingo Franzki <ifranzki@de.ibm.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 05/12] s390: zcrypt: initialize variables before_use
In-Reply-To: <CAK8P3a1-1axfWq5Y1pK9XORMdsbmZyq75p+V5Do71hNRowct+g@mail.gmail.com>
References: <20190408212648.2407234-1-arnd@arndb.de>
        <20190408212648.2407234-5-arnd@arndb.de>
        <8875e0b6-00b4-884d-fd6a-a5a144543559@linux.ibm.com>
        <20190410175946.0e6d2b00@mschwideX1>
        <CAK8P3a1-1axfWq5Y1pK9XORMdsbmZyq75p+V5Do71hNRowct+g@mail.gmail.com>
X-Mailer: Claws Mail 3.13.2 (GTK+ 2.24.30; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
x-cbid: 19041107-0020-0000-0000-0000032E9E70
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19041107-0021-0000-0000-00002180CD0C
Message-Id: <20190411094055.5884244c@mschwideX1>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-04-11_05:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=897 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1904110055
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 10 Apr 2019 20:57:21 +0200
Arnd Bergmann <arnd@arndb.de> wrote:

> On Wed, Apr 10, 2019 at 5:59 PM Martin Schwidefsky
> <schwidefsky@de.ibm.com> wrote:
> > On Tue, 9 Apr 2019 11:54:30 +0200 Harald Freudenberger <freude@linux.ibm.com> wrote:  
> > > On 08.04.19 23:26, Arnd Bergmann wrote:  
> > > >             }  
> > > Thanks Arnd, but as Nathan already wrote, I'd prefer to have the
> > > variable initialized with 0 instead of -1.
> > > If you agree with this, I'll rewrite the patch and apply it to our
> > > internal git and it will appear at kernel org with the next s390 code merge then.  
> >
> > Do we agreement on func_coed=0 for this one ?  
> 
> Yes, I think that was the consensus.
> 
>        Arnd
> 

Ok, committed with func_code=0.

-- 
blue skies,
   Martin.

"Reality continues to ruin my life." - Calvin.


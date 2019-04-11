Return-Path: <SRS0=BPXs=SN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 044EBC10F13
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Apr 2019 07:32:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D17F721841
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Apr 2019 07:32:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726833AbfDKHcn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 11 Apr 2019 03:32:43 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:57000 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726139AbfDKHcn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Apr 2019 03:32:43 -0400
Received: from pps.filterd (m0098396.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x3B7UFxS094717
        for <linux-kernel@vger.kernel.org>; Thu, 11 Apr 2019 03:32:42 -0400
Received: from e06smtp03.uk.ibm.com (e06smtp03.uk.ibm.com [195.75.94.99])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2rt10grtc6-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Thu, 11 Apr 2019 03:32:41 -0400
Received: from localhost
        by e06smtp03.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <schwidefsky@de.ibm.com>;
        Thu, 11 Apr 2019 08:32:39 +0100
Received: from b06cxnps3075.portsmouth.uk.ibm.com (9.149.109.195)
        by e06smtp03.uk.ibm.com (192.168.101.133) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Thu, 11 Apr 2019 08:32:37 +0100
Received: from d06av25.portsmouth.uk.ibm.com (d06av25.portsmouth.uk.ibm.com [9.149.105.61])
        by b06cxnps3075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x3B7Waa353608620
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 11 Apr 2019 07:32:36 GMT
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 0FCCE11C04A;
        Thu, 11 Apr 2019 07:32:36 +0000 (GMT)
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 955B911C054;
        Thu, 11 Apr 2019 07:32:35 +0000 (GMT)
Received: from mschwideX1 (unknown [9.145.74.176])
        by d06av25.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Thu, 11 Apr 2019 07:32:35 +0000 (GMT)
Date:   Thu, 11 Apr 2019 09:32:34 +0200
From:   Martin Schwidefsky <schwidefsky@de.ibm.com>
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     Steven Rostedt <rostedt@goodmis.org>,
        Heiko Carstens <heiko.carstens@de.ibm.com>,
        Ingo Molnar <mingo@redhat.com>,
        clang-built-linux@googlegroups.com,
        Nick Desaulniers <ndesaulniers@google.com>,
        Nathan Chancellor <natechancellor@gmail.com>,
        linux-s390 <linux-s390@vger.kernel.org>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 10/12] s390: avoid __builtin_return_address(n) on clang
In-Reply-To: <CAK8P3a2n+nEcaNrATQVO8NSGzfrMP5n+SrvjpTYcH4ikCN5LGg@mail.gmail.com>
References: <20190408212648.2407234-1-arnd@arndb.de>
        <20190408212648.2407234-10-arnd@arndb.de>
        <20190410180357.3290d24f@mschwideX1>
        <20190410121421.1414e179@gandalf.local.home>
        <CAK8P3a2n+nEcaNrATQVO8NSGzfrMP5n+SrvjpTYcH4ikCN5LGg@mail.gmail.com>
X-Mailer: Claws Mail 3.13.2 (GTK+ 2.24.30; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
x-cbid: 19041107-0012-0000-0000-0000030D9DB6
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19041107-0013-0000-0000-00002145C4A5
Message-Id: <20190411093234.5f212a2e@mschwideX1>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-04-11_05:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=897 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1904110053
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 10 Apr 2019 21:07:56 +0200
Arnd Bergmann <arnd@arndb.de> wrote:

> On Wed, Apr 10, 2019 at 6:14 PM Steven Rostedt <rostedt@goodmis.org> wrote:
> > On Wed, 10 Apr 2019 18:03:57 +0200 Martin Schwidefsky <schwidefsky@de.ibm.com> wrote:
> >  
> > > > --- a/arch/s390/include/asm/ftrace.h
> > > > +++ b/arch/s390/include/asm/ftrace.h
> > > > @@ -13,7 +13,12 @@
> > > >
> > > >  #ifndef __ASSEMBLY__
> > > >
> > > > +#ifdef CONFIG_CC_IS_CLANG
> > > > +/* https://bugs.llvm.org/show_bug.cgi?id=41424 */
> > > > +#define ftrace_return_address(n) __builtin_return_address(0)
> > > > +#else
> > > >  #define ftrace_return_address(n) __builtin_return_address(n)
> > > > +#endif
> > > >
> > > >  void _mcount(void);
> > > >  void ftrace_caller(void);  
> > >
> > > I can say I like this one. If the compiler can not do __builtin_return_address(n)
> > > it feels wrong to just use __builtin_return_address(0).  
> >
> > I agree. The proper return value is 0UL, see include/linux/ftrace.h
> >
> > /* Archs may use other ways for ADDR1 and beyond */
> > #ifndef ftrace_return_address
> > # ifdef CONFIG_FRAME_POINTER
> > #  define ftrace_return_address(n) __builtin_return_address(n)
> > # else
> > #  define ftrace_return_address(n) 0UL
> > # endif
> > #endif
> >
> > This is why we treat zero differently:
> >
> > #define CALLER_ADDR0 ((unsigned long)ftrace_return_address0)
> > #define CALLER_ADDR1 ((unsigned long)ftrace_return_address(1))
> > #define CALLER_ADDR2 ((unsigned long)ftrace_return_address(2))
> > #define CALLER_ADDR3 ((unsigned long)ftrace_return_address(3))
> > #define CALLER_ADDR4 ((unsigned long)ftrace_return_address(4))
> > #define CALLER_ADDR5 ((unsigned long)ftrace_return_address(5))
> > #define CALLER_ADDR6 ((unsigned long)ftrace_return_address(6))  
> 
> Right, got it.
> 
> Martin, do you want me to send a replacement patch, or can you
> commit the patch with
> 
> #ifdef CONFIG_CC_IS_CLANG
> /* https://bugs.llvm.org/show_bug.cgi?id=41424 */
> #define ftrace_return_address(n) 0UL
> #else
> #define ftrace_return_address(n) __builtin_return_address(n)
> #endif
> 
> instead?

Ok, done.

-- 
blue skies,
   Martin.

"Reality continues to ruin my life." - Calvin.


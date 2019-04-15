Return-Path: <SRS0=rNeM=SR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 044C4C10F0E
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Apr 2019 06:32:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BE2E320825
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Apr 2019 06:32:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726248AbfDOGcq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Apr 2019 02:32:46 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:53456 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725796AbfDOGcq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Apr 2019 02:32:46 -0400
Received: from pps.filterd (m0098393.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x3F6UWRQ131250
        for <linux-kernel@vger.kernel.org>; Mon, 15 Apr 2019 02:32:45 -0400
Received: from e06smtp03.uk.ibm.com (e06smtp03.uk.ibm.com [195.75.94.99])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2rvkftkgnd-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Mon, 15 Apr 2019 02:32:44 -0400
Received: from localhost
        by e06smtp03.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <schwidefsky@de.ibm.com>;
        Mon, 15 Apr 2019 07:32:42 +0100
Received: from b06cxnps3074.portsmouth.uk.ibm.com (9.149.109.194)
        by e06smtp03.uk.ibm.com (192.168.101.133) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Mon, 15 Apr 2019 07:32:39 +0100
Received: from d06av25.portsmouth.uk.ibm.com (d06av25.portsmouth.uk.ibm.com [9.149.105.61])
        by b06cxnps3074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x3F6WbK259113600
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 15 Apr 2019 06:32:37 GMT
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 2AFC811C066;
        Mon, 15 Apr 2019 06:32:37 +0000 (GMT)
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id B561211C058;
        Mon, 15 Apr 2019 06:32:36 +0000 (GMT)
Received: from mschwideX1 (unknown [9.145.17.89])
        by d06av25.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Mon, 15 Apr 2019 06:32:36 +0000 (GMT)
Date:   Mon, 15 Apr 2019 08:32:34 +0200
From:   Martin Schwidefsky <schwidefsky@de.ibm.com>
To:     Nick Desaulniers <ndesaulniers@google.com>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Heiko Carstens <heiko.carstens@de.ibm.com>,
        clang-built-linux@googlegroups.com,
        Nathan Chancellor <natechancellor@gmail.com>,
        linux-s390 <linux-s390@vger.kernel.org>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Philipp Rudo <prudo@linux.ibm.com>,
        Hendrik Brueckner <brueckner@linux.ibm.com>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 2/2] s390: boot, purgatory: pass $(CLANG_FLAGS) where
 needed
In-Reply-To: <CAKwvOdmdUv3pOGdsJCf5HG3KGPfq8TJHY0523jPD=etJwuES7g@mail.gmail.com>
References: <20190410201300.3528984-1-arnd@arndb.de>
        <20190410201300.3528984-2-arnd@arndb.de>
        <CAKwvOdk-tfsZRVaOr8Suv5C146F-w3jUA-Rx0n2OxkVy+L8tCg@mail.gmail.com>
        <CAK8P3a0cdvxkoRPOF7moxZ1W2059OEJeOGAFPfSemMH1_g=YPg@mail.gmail.com>
        <CAKwvOdmdUv3pOGdsJCf5HG3KGPfq8TJHY0523jPD=etJwuES7g@mail.gmail.com>
X-Mailer: Claws Mail 3.13.2 (GTK+ 2.24.30; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
x-cbid: 19041506-0012-0000-0000-0000030ED247
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19041506-0013-0000-0000-00002147054F
Message-Id: <20190415083234.7f05254b@mschwideX1>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-04-15_03:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1904150043
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 11 Apr 2019 11:08:31 -0700
Nick Desaulniers <ndesaulniers@google.com> wrote:

> On Thu, Apr 11, 2019 at 1:52 AM Arnd Bergmann <arnd@arndb.de> wrote:
> >
> > On Thu, Apr 11, 2019 at 12:14 AM 'Nick Desaulniers' via Clang Built
> > Linux <clang-built-linux@googlegroups.com> wrote:  
> > > On Wed, Apr 10, 2019 at 1:13 PM Arnd Bergmann <arnd@arndb.de> wrote:  
> > > >
> > > > The purgatory and boot Makefiles do not inherit the original cflags,
> > > > so clang falls back to the default target architecture when building it,
> > > > typically this would be x86 when cross-compiling.
> > > >
> > > > Add $(CLANG_FLAGS) everywhere so we pass the correct --target=s390x-linux
> > > > option when cross-compiling.
> > > >
> > > > Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> > > > ---
> > > >  arch/s390/Makefile           | 5 +++--
> > > >  arch/s390/purgatory/Makefile | 1 +
> > > >  2 files changed, 4 insertions(+), 2 deletions(-)
> > > >
> > > > diff --git a/arch/s390/Makefile b/arch/s390/Makefile
> > > > index 9c079a506325..443990791099 100644
> > > > --- a/arch/s390/Makefile
> > > > +++ b/arch/s390/Makefile
> > > > @@ -17,12 +17,13 @@ KBUILD_CFLAGS_MODULE += -fPIC
> > > >  KBUILD_AFLAGS  += -m64
> > > >  KBUILD_CFLAGS  += -m64
> > > >  aflags_dwarf   := -Wa,-gdwarf-2
> > > > -KBUILD_AFLAGS_DECOMPRESSOR := -m64 -D__ASSEMBLY__
> > > > +KBUILD_AFLAGS_DECOMPRESSOR := $(CLANG_FLAGS) -m64 -D__ASSEMBLY__
> > > >  KBUILD_AFLAGS_DECOMPRESSOR += $(if $(CONFIG_DEBUG_INFO),$(aflags_dwarf))
> > > > -KBUILD_CFLAGS_DECOMPRESSOR := -m64 -O2
> > > > +KBUILD_CFLAGS_DECOMPRESSOR := $(CLANG_FLAGS) -m64 -O2
> > > >  KBUILD_CFLAGS_DECOMPRESSOR += -DDISABLE_BRANCH_PROFILING -D__NO_FORTIFY
> > > >  KBUILD_CFLAGS_DECOMPRESSOR += -fno-delete-null-pointer-checks -msoft-float
> > > >  KBUILD_CFLAGS_DECOMPRESSOR += -fno-asynchronous-unwind-tables  
> > >
> > > Thanks for the respin with Nathan's suggestion.
> > >  
> > > > +KBUILD_CFLAGS_DECOMPRESSOR += $(call cc-disable-warning,pointer-sign)  
> > >
> > > What's up with this ^ ?  Seems like the top level sets it (without
> > > cc-disable-warning :( ), but then KBUILD_CFLAGS_DECOMPRESSOR discards
> > > it.  Does Clang actually flag code in this arch (that GCC doesn't)?  
> >
> > Oops, that should have been a separate patch.
> >
> > I think what happens is that clang warns more aggressively about pointer sign
> > bugs than gcc in some cases, and some of those cases happen in s390
> > header files that are included by both the kernel and the decompressor.
> >
> > The full warning log without this change is rather long, see
> > https://pastebin.com/KG9xaTNB  
> 
> From this link, it looks like the definitions of:
> __atomic64_or
> __atomic64_and
> __atomic64_xor
> and their *_barrier variants are problematic.  I think converting
> those to use unsigned long is the way to go.  Shouldn't you be doing
> bitwise ops on unsigned types anyways?

These functions follow the type of atomic64_t which is a "long" wrapped
in a structure. We do not want to change that to unsigned long, are we?
Then having some of the functions operate on "long" and others on
"unsigned long" seem odd.

> The warnings with __atomic64_add are tougher to read/understand since
> at that point the log lines look like they start to mix together.
> 
> >
> > I also tried patching the code to avoid the warnings, but I'm not entirely
> > happy with that result either, see
> > https://pastebin.com/pSMz5eZA  
> 
> That's no terrible, IMO, particularly with the change I suggest above.

That is not too bad, the only change I do not like is the s/u8/char/ in
struct ipl_block_fcp.

-- 
blue skies,
   Martin.

"Reality continues to ruin my life." - Calvin.


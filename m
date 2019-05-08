Return-Path: <SRS0=J8hU=TI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CAFE4C04A6B
	for <linux-kernel@archiver.kernel.org>; Wed,  8 May 2019 06:14:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9C1FF214C6
	for <linux-kernel@archiver.kernel.org>; Wed,  8 May 2019 06:14:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727112AbfEHGOu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 May 2019 02:14:50 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:53978 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726179AbfEHGOu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 May 2019 02:14:50 -0400
Received: from pps.filterd (m0098410.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x4863kSN019734
        for <linux-kernel@vger.kernel.org>; Wed, 8 May 2019 02:14:49 -0400
Received: from e06smtp07.uk.ibm.com (e06smtp07.uk.ibm.com [195.75.94.103])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2sbs1mhjsw-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Wed, 08 May 2019 02:14:48 -0400
Received: from localhost
        by e06smtp07.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <schwidefsky@de.ibm.com>;
        Wed, 8 May 2019 07:14:46 +0100
Received: from b06cxnps3075.portsmouth.uk.ibm.com (9.149.109.195)
        by e06smtp07.uk.ibm.com (192.168.101.137) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Wed, 8 May 2019 07:14:42 +0100
Received: from d06av26.portsmouth.uk.ibm.com (d06av26.portsmouth.uk.ibm.com [9.149.105.62])
        by b06cxnps3075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x486Ef4C47317240
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 8 May 2019 06:14:41 GMT
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 9F6BDAE056;
        Wed,  8 May 2019 06:14:41 +0000 (GMT)
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 5331AAE04D;
        Wed,  8 May 2019 06:14:41 +0000 (GMT)
Received: from mschwideX1 (unknown [9.145.70.16])
        by d06av26.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Wed,  8 May 2019 06:14:41 +0000 (GMT)
Date:   Wed, 8 May 2019 08:14:39 +0200
From:   Martin Schwidefsky <schwidefsky@de.ibm.com>
To:     Kees Cook <keescook@chromium.org>
Cc:     Vasily Gorbik <gor@linux.ibm.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Emese Revfy <re.emese@gmail.com>,
        Heiko Carstens <heiko.carstens@de.ibm.com>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] latent_entropy: avoid build error when plugin cflags
 are not set
In-Reply-To: <CAGXu5j+-6Kt5E3E5xYeQUxDHZEYrsmZJU+EPgYO3xOrpxZtvng@mail.gmail.com>
References: <patch.git-0d8ac0206ebb.your-ad-here.call-01557238927-ext-2525@work.hours>
        <CAGXu5j+-6Kt5E3E5xYeQUxDHZEYrsmZJU+EPgYO3xOrpxZtvng@mail.gmail.com>
X-Mailer: Claws Mail 3.13.2 (GTK+ 2.24.30; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
x-cbid: 19050806-0028-0000-0000-0000036B6E28
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19050806-0029-0000-0000-0000242AE9F1
Message-Id: <20190508081439.4cab58c5@mschwideX1>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-05-08_05:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1905080039
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 7 May 2019 09:16:29 -0700
Kees Cook <keescook@chromium.org> wrote:

> On Tue, May 7, 2019 at 7:28 AM Vasily Gorbik <gor@linux.ibm.com> wrote:
> > Some architectures set up CFLAGS for linux decompressor phase from
> > scratch and do not include GCC_PLUGINS_CFLAGS. Since "latent_entropy"
> > variable declaration is generated by the plugin code itself including
> > linux/random.h in decompressor code then would cause a build
> > error. E.g. on s390:
> >
> > In file included from ./include/linux/net.h:22,
> >                  from ./include/linux/skbuff.h:29,
> >                  from ./include/linux/if_ether.h:23,
> >                  from ./arch/s390/include/asm/diag.h:12,
> >                  from arch/s390/boot/startup.c:8:
> > ./include/linux/random.h: In function 'add_latent_entropy':
> > ./include/linux/random.h:26:39: error: 'latent_entropy' undeclared
> > (first use in this function); did you mean 'add_latent_entropy'?
> >    26 |  add_device_randomness((const void *)&latent_entropy,
> >       |                                       ^~~~~~~~~~~~~~
> >       |                                       add_latent_entropy
> > ./include/linux/random.h:26:39: note: each undeclared identifier is
> > reported only once for each function it appears in
> >
> > The build error is triggered by commit a80313ff91ab ("s390/kernel:
> > introduce .dma sections") which made it into 5.2 merge window.
> >
> > To address that avoid using CONFIG_GCC_PLUGIN_LATENT_ENTROPY in
> > favour of LATENT_ENTROPY_PLUGIN definition which is defined as a
> > part of gcc plugins cflags and hence reflect more accurately when gcc
> > plugin is active. Besides that it is also used for similar purpose in
> > linux/compiler-gcc.h for latent_entropy attribute definition.
> >
> > Signed-off-by: Vasily Gorbik <gor@linux.ibm.com>  
> 
> Thanks for fixing this! Do you want to take it via the s390 tree?
> 
> Acked-by: Kees Cook <keescook@chromium.org>

Sure, I can take it via the s390 tree.
 
> > ---
> >  include/linux/random.h | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/include/linux/random.h b/include/linux/random.h
> > index 445a0ea4ff49..d4eb9b3789ad 100644
> > --- a/include/linux/random.h
> > +++ b/include/linux/random.h
> > @@ -20,7 +20,7 @@ struct random_ready_callback {
> >
> >  extern void add_device_randomness(const void *, unsigned int);
> >
> > -#if defined(CONFIG_GCC_PLUGIN_LATENT_ENTROPY) && !defined(__CHECKER__)
> > +#if defined(LATENT_ENTROPY_PLUGIN) && !defined(__CHECKER__)
> >  static inline void add_latent_entropy(void)
> >  {
> >         add_device_randomness((const void *)&latent_entropy,
> > --
> > 2.18.0.13.gd42ae10
> >  
> 
> 


-- 
blue skies,
   Martin.

"Reality continues to ruin my life." - Calvin.


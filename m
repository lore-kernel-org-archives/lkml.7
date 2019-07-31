Return-Path: <SRS0=cgli=V4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B541BC433FF
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Jul 2019 10:27:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 95D5B206A2
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Jul 2019 10:27:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387415AbfGaK1D (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 31 Jul 2019 06:27:03 -0400
Received: from cloudserver094114.home.pl ([79.96.170.134]:65291 "EHLO
        cloudserver094114.home.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728055AbfGaK1D (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Jul 2019 06:27:03 -0400
Received: from 79.184.255.110.ipv4.supernova.orange.pl (79.184.255.110) (HELO kreacher.localnet)
 by serwer1319399.home.pl (79.96.170.134) with SMTP (IdeaSmtpServer 0.83.275)
 id 517435089605ae31; Wed, 31 Jul 2019 12:27:01 +0200
From:   "Rafael J. Wysocki" <rjw@rjwysocki.net>
To:     Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Marcelo Tosatti <mtosatti@redhat.com>
Subject: Re: linux-next: build failure after merge of the pm tree
Date:   Wed, 31 Jul 2019 12:27:01 +0200
Message-ID: <2125012.dsI546JiDj@kreacher>
In-Reply-To: <20190731153419.7b728744@canb.auug.org.au>
References: <20190731153419.7b728744@canb.auug.org.au>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday, July 31, 2019 7:34:19 AM CEST Stephen Rothwell wrote:
> 
> --Sig_/RVaztRR.13XAL2aXFk8lo/g
> Content-Type: text/plain; charset=US-ASCII
> Content-Transfer-Encoding: quoted-printable
> 
> Hi all,
> 
> After merging the pm tree, today's linux-next build (x86_64 allnoconfig)
> failed like this:
> 
> x86_64-linux-gnu-ld: kernel/sched/core.o: in function `cpuidle_poll_time':
> core.c:(.text+0x230): multiple definition of `cpuidle_poll_time'; arch/x86/=
> kernel/process.o:process.c:(.text+0xc0): first defined here
> x86_64-linux-gnu-ld: kernel/sched/loadavg.o: in function `cpuidle_poll_time=
> ':
> loadavg.c:(.text+0x0): multiple definition of `cpuidle_poll_time'; arch/x86=
> /kernel/process.o:process.c:(.text+0xc0): first defined here
> x86_64-linux-gnu-ld: kernel/sched/clock.o: in function `cpuidle_poll_time':
> clock.c:(.text+0x0): multiple definition of `cpuidle_poll_time'; arch/x86/k=
> ernel/process.o:process.c:(.text+0xc0): first defined here
> x86_64-linux-gnu-ld: kernel/sched/cputime.o: in function `cpuidle_poll_time=
> ':
> cputime.c:(.text+0x0): multiple definition of `cpuidle_poll_time'; arch/x86=
> /kernel/process.o:process.c:(.text+0xc0): first defined here
> x86_64-linux-gnu-ld: kernel/sched/idle.o: in function `cpuidle_poll_time':
> idle.c:(.text+0xd0): multiple definition of `cpuidle_poll_time'; arch/x86/k=
> ernel/process.o:process.c:(.text+0xc0): first defined here
> x86_64-linux-gnu-ld: kernel/sched/fair.o: in function `cpuidle_poll_time':
> fair.c:(.text+0xb20): multiple definition of `cpuidle_poll_time'; arch/x86/=
> kernel/process.o:process.c:(.text+0xc0): first defined here
> x86_64-linux-gnu-ld: kernel/sched/rt.o: in function `cpuidle_poll_time':
> rt.c:(.text+0x790): multiple definition of `cpuidle_poll_time'; arch/x86/ke=
> rnel/process.o:process.c:(.text+0xc0): first defined here
> x86_64-linux-gnu-ld: kernel/sched/deadline.o: in function `cpuidle_poll_tim=
> e':
> deadline.c:(.text+0xce0): multiple definition of `cpuidle_poll_time'; arch/=
> x86/kernel/process.o:process.c:(.text+0xc0): first defined here
> x86_64-linux-gnu-ld: kernel/sched/wait.o: in function `cpuidle_poll_time':
> wait.c:(.text+0x1d0): multiple definition of `cpuidle_poll_time'; arch/x86/=
> kernel/process.o:process.c:(.text+0xc0): first defined here
> x86_64-linux-gnu-ld: kernel/sched/wait_bit.o: in function `cpuidle_poll_tim=
> e':
> wait_bit.c:(.text+0x50): multiple definition of `cpuidle_poll_time'; arch/x=
> 86/kernel/process.o:process.c:(.text+0xc0): first defined here
> x86_64-linux-gnu-ld: kernel/sched/swait.o: in function `cpuidle_poll_time':
> swait.c:(.text+0x30): multiple definition of `cpuidle_poll_time'; arch/x86/=
> kernel/process.o:process.c:(.text+0xc0): first defined here
> x86_64-linux-gnu-ld: kernel/sched/completion.o: in function `cpuidle_poll_t=
> ime':
> completion.c:(.text+0x0): multiple definition of `cpuidle_poll_time'; arch/=
> x86/kernel/process.o:process.c:(.text+0xc0): first defined here
> 
> Caused by commit
> 
>   259231a04561 ("cpuidle: add poll_limit_ns to cpuidle_device structure")
> 
> I have added the following patch for today:
>

I've applied this patch to my pm-cpuidle branch, thanks Stephen!

> From: Stephen Rothwell <sfr@canb.auug.org.au>
> Date: Wed, 31 Jul 2019 15:29:52 +1000
> Subject: [PATCH] cpuidle: header file stubs must be "static inline"
> 
> An x86_64 allmodconfig build produces these errors:
> 
> x86_64-linux-gnu-ld: kernel/sched/core.o: in function `cpuidle_poll_time':
> core.c:(.text+0x230): multiple definition of `cpuidle_poll_time'; arch/x86/=
> kernel/process.o:process.c:(.text+0xc0): first defined here
> 
> (and more)
> 
> Fixes: 259231a04561 ("cpuidle: add poll_limit_ns to cpuidle_device structur=
> e")
> Signed-off-by: Stephen Rothwell <sfr@canb.auug.org.au>
> ---
>  include/linux/cpuidle.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/include/linux/cpuidle.h b/include/linux/cpuidle.h
> index ba535a1a47d5..1a9f54eb3aa1 100644
> --- a/include/linux/cpuidle.h
> +++ b/include/linux/cpuidle.h
> @@ -170,7 +170,7 @@ static inline int cpuidle_enter(struct cpuidle_driver *=
> drv,
>  				struct cpuidle_device *dev, int index)
>  {return -ENODEV; }
>  static inline void cpuidle_reflect(struct cpuidle_device *dev, int index) =
> { }
> -extern u64 cpuidle_poll_time(struct cpuidle_driver *drv,
> +static inline u64 cpuidle_poll_time(struct cpuidle_driver *drv,
>  			     struct cpuidle_device *dev)
>  {return 0; }
>  static inline int cpuidle_register_driver(struct cpuidle_driver *drv)
> --=20
> 2.20.1
> 
> --=20
> Cheers,
> Stephen Rothwell
> 
> --Sig_/RVaztRR.13XAL2aXFk8lo/g
> Content-Type: application/pgp-signature
> Content-Description: OpenPGP digital signature
> 
> 
> --Sig_/RVaztRR.13XAL2aXFk8lo/g--
> 





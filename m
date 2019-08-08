Return-Path: <SRS0=IWld=WE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 40A47C0650F
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Aug 2019 20:04:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1C0A321743
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Aug 2019 20:04:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404271AbfHHUEV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 8 Aug 2019 16:04:21 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:54093 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732704AbfHHUEU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Aug 2019 16:04:20 -0400
Received: from p200300ddd71876597e7a91fffec98e25.dip0.t-ipconnect.de ([2003:dd:d718:7659:7e7a:91ff:fec9:8e25])
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1hvods-0007Hp-It; Thu, 08 Aug 2019 22:04:08 +0200
Date:   Thu, 8 Aug 2019 22:04:03 +0200 (CEST)
From:   Thomas Gleixner <tglx@linutronix.de>
To:     =?UTF-8?Q?Valdis_Kl=C4=93tnieks?= <valdis.kletnieks@vt.edu>
cc:     Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        x86@kernel.org, LKML <linux-kernel@vger.kernel.org>,
        Fenghua Yu <fenghua.yu@intel.com>
Subject: Re: [PATCH] arch/x86/kernel/cpu/umwait.c - remove unused variable
In-Reply-To: <79734.1565272329@turing-police>
Message-ID: <alpine.DEB.2.21.1908082158580.2882@nanos.tec.linutronix.de>
References: <79734.1565272329@turing-police>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323329-1191196002-1565294648=:2882"
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required,  ALL_TRUSTED=-1,SHORTCIRCUIT=-0.0001
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323329-1191196002-1565294648=:2882
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT

Valdis,

On Thu, 8 Aug 2019, Valdis Klētnieks wrote:

I really appreciate your work, but can you please refrain from using file
names as prefixes?

git log $FILE gives you usually a pretty good hint what the proper prefix
is:

  bd9a0c97e53c ("x86/umwait: Add sysfs interface to control umwait maximum time")
  ff4b353f2ef9 ("x86/umwait: Add sysfs interface to control umwait C0.2 state")
  bd688c69b7e6 ("x86/umwait: Initialize umwait control values")

See?

> We get a warning when building with W=1:

Please avoid 'We/I' in changelogs.
 
>   CC      arch/x86/kernel/cpu/umwait.o
> arch/x86/kernel/cpu/umwait.c: In function 'umwait_init':
> arch/x86/kernel/cpu/umwait.c:183:6: warning: variable 'ret' set but not used [-Wunused-but-set-variable]
>   183 |  int ret;
>       |      ^~~
> 
> And indeed, we don't do anything with it, so clean it  up.

Well, the question is whether removing the variable is the right thing to
do.
 
> Signed-off-by: Valdis Kletnieks <valdis.kletnieks@vt.edu>
> 
> diff --git a/arch/x86/kernel/cpu/umwait.c b/arch/x86/kernel/cpu/umwait.c
> index 6a204e7336c1..3d1d3952774a 100644
> --- a/arch/x86/kernel/cpu/umwait.c
> +++ b/arch/x86/kernel/cpu/umwait.c
> @@ -180,12 +180,11 @@ static struct attribute_group umwait_attr_group = {
>  static int __init umwait_init(void)
>  {
>  	struct device *dev;
> -	int ret;
>  
>  	if (!boot_cpu_has(X86_FEATURE_WAITPKG))
>  		return -ENODEV;
>  
> -	ret = cpuhp_setup_state(CPUHP_AP_ONLINE_DYN, "umwait:online",
> +	cpuhp_setup_state(CPUHP_AP_ONLINE_DYN, "umwait:online",
>  				umwait_cpu_online, NULL);

If that fails then umwait is broken. So instead of removing it, this should
actually check the return code and act accordingly. Fenghua?
  
>  	register_syscore_ops(&umwait_syscore_ops);

Thanks,

	tglx
--8323329-1191196002-1565294648=:2882--

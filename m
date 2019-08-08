Return-Path: <SRS0=IWld=WE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A55B5C433FF
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Aug 2019 20:32:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 74CF02173C
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Aug 2019 20:32:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404751AbfHHUcy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 8 Aug 2019 16:32:54 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:54206 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2404270AbfHHUcx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Aug 2019 16:32:53 -0400
Received: from p200300ddd71876597e7a91fffec98e25.dip0.t-ipconnect.de ([2003:dd:d718:7659:7e7a:91ff:fec9:8e25])
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1hvp5Y-0007kg-3Y; Thu, 08 Aug 2019 22:32:44 +0200
Date:   Thu, 8 Aug 2019 22:32:38 +0200 (CEST)
From:   Thomas Gleixner <tglx@linutronix.de>
To:     =?UTF-8?Q?Valdis_Kl=C4=93tnieks?= <valdis.kletnieks@vt.edu>
cc:     Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        x86@kernel.org, LKML <linux-kernel@vger.kernel.org>,
        Fenghua Yu <fenghua.yu@intel.com>
Subject: Re: [PATCH] arch/x86/kernel/cpu/umwait.c - remove unused variable
In-Reply-To: <141835.1565295884@turing-police>
Message-ID: <alpine.DEB.2.21.1908082229010.2882@nanos.tec.linutronix.de>
References: <79734.1565272329@turing-police> <alpine.DEB.2.21.1908082158580.2882@nanos.tec.linutronix.de> <141835.1565295884@turing-police>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323329-1568308266-1565296364=:2882"
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required,  ALL_TRUSTED=-1,SHORTCIRCUIT=-0.0001
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323329-1568308266-1565296364=:2882
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT

Valdis,

On Thu, 8 Aug 2019, Valdis Klētnieks wrote:
> On Thu, 08 Aug 2019 22:04:03 +0200, Thomas Gleixner said:
> 
> > I really appreciate your work, but can you please refrain from using file
> > names as prefixes?
> 
> OK, will do so going forward..

Care to resend the last few with fixed subject lines, so I don't have to
clean them up?
 
> > > And indeed, we don't do anything with it, so clean it  up.
> >
> > Well, the question is whether removing the variable is the right thing to
> > do.
> 
> > If that fails then umwait is broken. So instead of removing it, this should
> > actually check the return code and act accordingly. Fenghua?
> 
> [/usr/src/linux-next] git grep umwait_init
> arch/x86/kernel/cpu/umwait.c:static int __init umwait_init(void)
> arch/x86/kernel/cpu/umwait.c:device_initcall(umwait_init);
> 
> It isn't clear that whatever is doing the device_initcall()s will be able to do
> any reasonable recovery if we return an error, so any error recovery is going
> to have to happen before the function returns. It might make sense to do an
> 'if (ret) return;' before going further in the function, but given the comment a
> few lines further down about ignoring errors,  it was apparently considered
> more important to struggle through and register stuff in sysfs even if umwait
> was broken....

I missed that when going through it.

The right thing to do is to have a cpu_offline callback which clears the
umwait MSR. That covers also the failure in the cpu hotplug setup. Then
handling an error return makes sense and keeps everything in a workable
shape.

Thanks,

	tglx



--8323329-1568308266-1565296364=:2882--

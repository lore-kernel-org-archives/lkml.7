Return-Path: <SRS0=Dr8o=U4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E31E5C4321A
	for <linux-kernel@archiver.kernel.org>; Sat, 29 Jun 2019 07:37:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B8A7E214AF
	for <linux-kernel@archiver.kernel.org>; Sat, 29 Jun 2019 07:37:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726859AbfF2Hhn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 29 Jun 2019 03:37:43 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:38360 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726818AbfF2Hhn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 29 Jun 2019 03:37:43 -0400
Received: from p5b06daab.dip0.t-ipconnect.de ([91.6.218.171] helo=nanos)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1hh7vR-0001t8-Ng; Sat, 29 Jun 2019 09:37:33 +0200
Date:   Sat, 29 Jun 2019 09:37:32 +0200 (CEST)
From:   Thomas Gleixner <tglx@linutronix.de>
To:     "Bae, Chang Seok" <chang.seok.bae@intel.com>
cc:     Andy Lutomirski <luto@kernel.org>,
        Vegard Nossum <vegard.nossum@oracle.com>,
        Ingo Molnar <mingo@kernel.org>,
        "H . Peter Anvin" <hpa@zytor.com>, Andi Kleen <ak@linux.intel.com>,
        "Shankar, Ravi V" <ravi.v.shankar@intel.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Dave Hansen <dave.hansen@linux.intel.com>
Subject: Re: [PATCH v7 12/18] x86/fsgsbase/64: GSBASE handling with FSGSBASE
 in the paranoid path
In-Reply-To: <E8E632D1-7A16-4F42-954B-0ACA3C5F7409@intel.com>
Message-ID: <alpine.DEB.2.21.1906290936570.1802@nanos.tec.linutronix.de>
References: <1557309753-24073-1-git-send-email-chang.seok.bae@intel.com> <1557309753-24073-13-git-send-email-chang.seok.bae@intel.com> <E8E632D1-7A16-4F42-954B-0ACA3C5F7409@intel.com>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323329-1304247078-1561793853=:1802"
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required,  ALL_TRUSTED=-1,SHORTCIRCUIT=-0.0001
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323329-1304247078-1561793853=:1802
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8BIT

On Sat, 29 Jun 2019, Bae, Chang Seok wrote:
> > On May 8, 2019, at 03:02, Chang S. Bae <chang.seok.bae@intel.com> wrote:
> > 
> > ENTRY(paranoid_exit)
> > …
> > +
> > +	/* On FSGSBASE systems, always restore the stashed GSBASE */
> > +	wrgsbase	%rbx
> > +	jmp	.Lparanoid_exit_no_swapgs;
> 
> It would crash any time getting a paranoid entry with user GS but kernel CR3.
> The issue is thankfully uncovered by Vegard N. A relevant test case will be
> published by Andy L. The patch fixes the issue. (Rebased on the tip master.)

Can you please provide a proper patch with a proper changelog?

Thanks,

	tglx
 
--8323329-1304247078-1561793853=:1802--

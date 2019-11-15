Return-Path: <SRS0=19dG=ZH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2681CC432C3
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Nov 2019 19:36:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EF8342073B
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Nov 2019 19:36:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727140AbfKOTgG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 Nov 2019 14:36:06 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:44438 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726365AbfKOTgF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Nov 2019 14:36:05 -0500
Received: from p5b06da22.dip0.t-ipconnect.de ([91.6.218.34] helo=nanos)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1iVhNw-00062O-J3; Fri, 15 Nov 2019 20:36:00 +0100
Date:   Fri, 15 Nov 2019 20:35:54 +0100 (CET)
From:   Thomas Gleixner <tglx@linutronix.de>
To:     Boris Petkov <bp@alien8.de>
cc:     Waiman Long <longman@redhat.com>, Ingo Molnar <mingo@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org, Josh Poimboeuf <jpoimboe@redhat.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Pawan Gupta <pawan.kumar.gupta@linux.intel.com>,
        Mark Gross <mgross@linux.intel.com>,
        Tony Luck <tony.luck@intel.com>
Subject: Re: [PATCH v2 1/2] x86/speculation: Fix incorrect MDS/TAA mitigation
 status
In-Reply-To: <7EAED44C-A93E-405E-B57B-89AC3F779A70@alien8.de>
Message-ID: <alpine.DEB.2.21.1911152027200.28787@nanos.tec.linutronix.de>
References: <20191115161445.30809-1-longman@redhat.com> <20191115161445.30809-2-longman@redhat.com> <7EAED44C-A93E-405E-B57B-89AC3F779A70@alien8.de>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required,  ALL_TRUSTED=-1,SHORTCIRCUIT=-0.0001
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 15 Nov 2019, Boris Petkov wrote:

> On November 15, 2019 5:14:44 PM GMT+01:00, Waiman Long <longman@redhat.com> wrote:
> >For MDS vulnerable processors with TSX support, enabling either MDS or
> >TAA mitigations will enable the use of VERW to flush internal processor
> >buffers at the right code path. IOW, they are either both mitigated
> >or both not. However, if the command line options are inconsistent,
> >the vulnerabilites sysfs files may not report the mitigation status
> >correctly.
> >
> >For example, with only the "mds=off" option:
> >
> >  vulnerabilities/mds:Vulnerable; SMT vulnerable
> >vulnerabilities/tsx_async_abort:Mitigation: Clear CPU buffers; SMT
> >vulnerable
> >
> >The mds vulnerabilities file has wrong status in this case. Similarly,
> >the taa vulnerability file will be wrong with mds mitigation on, but
> >taa off.
> >
> >Change taa_select_mitigation() to sync up the two mitigation status
> >and have them turned off if both "mds=off" and "tsx_async_abort=off"
> >are present.
> >
> >Both hw-vuln/mds.rst and hw-vuln/tsx_async_abort.rst are updated
> >to emphasize the fact that both "mds=off" and "tsx_async_abort=off"
> >have to be specified together for processors that are affected by both
> >TAA and MDS to be effective. As kernel-parameter.txt references both
> >documents above, it is not necessary to update it.
> 
> What about kernel-parameters.txt?

See the last sentence of the paragraph you replied to :)

But serioulsy, yes we should mention the interaction in
kernel-parameters.txt as well. Something like:

	off        - Unconditionally disable MDS mitigation.
+		     On TAA affected machines, mds=off can be prevented
+		     by an active TAA mitigation as both vulnerabilities
+		     are mitigated with the same mechanism.

and the other way round for TAA.

Thanks,

	tglx

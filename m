Return-Path: <SRS0=RWM+=ZG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F0B3FC432C3
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Nov 2019 23:03:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CCD5020706
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Nov 2019 23:03:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727143AbfKNXDr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Nov 2019 18:03:47 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:41919 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726319AbfKNXDr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Nov 2019 18:03:47 -0500
Received: from p5b06da22.dip0.t-ipconnect.de ([91.6.218.34] helo=nanos)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1iVO9I-0004qZ-8n; Fri, 15 Nov 2019 00:03:36 +0100
Date:   Fri, 15 Nov 2019 00:03:35 +0100 (CET)
From:   Thomas Gleixner <tglx@linutronix.de>
To:     Waiman Long <longman@redhat.com>
cc:     Pawan Gupta <pawan.kumar.gupta@linux.intel.com>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org, Josh Poimboeuf <jpoimboe@redhat.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Mark Gross <mgross@linux.intel.com>,
        Tony Luck <tony.luck@intel.com>
Subject: Re: [PATCH] x86/speculation: Fix incorrect MDS/TAA mitigation
 status
In-Reply-To: <71de9e2b-19b6-161a-2f78-093c71d9391d@redhat.com>
Message-ID: <alpine.DEB.2.21.1911142358460.29616@nanos.tec.linutronix.de>
References: <20191113193350.24511-1-longman@redhat.com> <20191114201258.GA18745@guptapadev.amr> <71de9e2b-19b6-161a-2f78-093c71d9391d@redhat.com>
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

On Thu, 14 Nov 2019, Waiman Long wrote:
> On 11/14/19 3:12 PM, Pawan Gupta wrote:
> > On Wed, Nov 13, 2019 at 02:33:50PM -0500, Waiman Long wrote:

Folks, please trim your replies ....

> >> +	/*
> >> +	 * Update MDS mitigation, if necessary, as the mds_user_clear is
> >> +	 * now enabled for TAA mitigation.
> >> +	 */
> >> +	if (mds_mitigation == MDS_MITIGATION_OFF &&
> >> +	    boot_cpu_has_bug(X86_BUG_MDS)) {
> >> +		mds_mitigation = MDS_MITIGATION_FULL;
> >> +		mds_select_mitigation();
> > This will cause a confusing print in dmesg from previous and this call
> > to mds_select_mitigation().
> >
> > 	"MDS: Vulnerable"
> > 	"MDS: Mitigation: Clear CPU buffers"
>
> Yes, that is the side effect of this patch. It is the last message that
> is relevant. We saw this kind of messages all the time with early
> loading of microcode. A message showing a hardware vulnerability as
> vulnerable and then another message showing it as mitigated after the
> loading of microcode.
> >
> > Maybe delay MDS mitigation print till TAA is evaluated.
> 
> I will see what can be done about that. However, this is not a critical
> issue and I may not change it if there is no easy solution.

Right. There is nothing wrong with these two messages coming after each
other. They are both correct and due to the ordering they also make sense.

> > 	"MDS: Vulnerable"
> > 	"MDS: Mitigation: Clear CPU buffers"

CPU is vulnerable and then the next printk tells that mitigation is in
effect. So really nothing to worry about.

The important part is that the ordering of these messages is correct which
is the case and that the sysfs file corresponds with the last printk.

We really have more urgent problems than bikeshed painting these printks.

Thanks,

	tglx


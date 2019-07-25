Return-Path: <SRS0=6YJq=VW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1B7D3C76190
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Jul 2019 21:48:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E1FBB22C7B
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Jul 2019 21:48:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726794AbfGYVsk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Jul 2019 17:48:40 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:47683 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726704AbfGYVsk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Jul 2019 17:48:40 -0400
Received: from pd9ef1cb8.dip0.t-ipconnect.de ([217.239.28.184] helo=nanos)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1hqlbD-0005XK-2i; Thu, 25 Jul 2019 23:48:31 +0200
Date:   Thu, 25 Jul 2019 23:48:30 +0200 (CEST)
From:   Thomas Gleixner <tglx@linutronix.de>
To:     John Hubbard <jhubbard@nvidia.com>
cc:     hpa@zytor.com, john.hubbard@gmail.com,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        x86@kernel.org, LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 1/1] x86/boot: clear some fields explicitly
In-Reply-To: <345add60-de4a-73b1-0445-127738c268b4@nvidia.com>
Message-ID: <alpine.DEB.2.21.1907252343180.1791@nanos.tec.linutronix.de>
References: <20190724231528.32381-1-jhubbard@nvidia.com> <20190724231528.32381-2-jhubbard@nvidia.com> <B7DC31CA-E378-445A-A937-1B99490C77B4@zytor.com> <alpine.DEB.2.21.1907250848050.1791@nanos.tec.linutronix.de>
 <345add60-de4a-73b1-0445-127738c268b4@nvidia.com>
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

On Thu, 25 Jul 2019, John Hubbard wrote:
> On 7/25/19 12:22 AM, Thomas Gleixner wrote:
> > It removes the clearing of the range between kbd_status and hdr without any
> > replacement. It neither clears edid_info.
> 
> 
> Yes. Somehow I left that chunk out. Not my finest hour. 

S*** happens

> > +		char *p = (char *) boot_params;
> > +		int i;
> > +
> > +		for (i = 0; i < ARRAY_SIZE(toclear); i++)
> > +			memset(p + toclear[i].start, 0, toclear[i].len);
> >  	}
> >  }
> 
> Looks nice.

I have no idea whether it works and I have no cycles either, so I would
appreciate it if you could polish it up so we can handle that new fangled
GCC "feature" nicely.

Alternatively file a bug report to the GCC folks :)

But seriously I think it's not completely insane what they are doing and
the table based approach is definitely more readable and maintainable than
the existing stuff.

Thanks,

	tglx

Return-Path: <SRS0=4ODY=VF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 25491C606BD
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Jul 2019 18:27:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0B93521852
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Jul 2019 18:27:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731277AbfGHS1H (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Jul 2019 14:27:07 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:42485 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727373AbfGHS1H (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Jul 2019 14:27:07 -0400
Received: from pd9ef1cb8.dip0.t-ipconnect.de ([217.239.28.184] helo=nanos)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1hkYL3-0001TS-JZ; Mon, 08 Jul 2019 20:26:09 +0200
Date:   Mon, 8 Jul 2019 20:26:08 +0200 (CEST)
From:   Thomas Gleixner <tglx@linutronix.de>
To:     Andy Lutomirski <luto@amacapital.net>
cc:     Pingfan Liu <kernelfans@gmail.com>, x86@kernel.org,
        Michal Hocko <mhocko@suse.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Mike Rapoport <rppt@linux.ibm.com>,
        Tony Luck <tony.luck@intel.com>,
        Andy Lutomirski <luto@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        Oscar Salvador <osalvador@suse.de>,
        Pavel Tatashin <pavel.tatashin@microsoft.com>,
        Mel Gorman <mgorman@techsingularity.net>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Stephen Rothwell <sfr@canb.auug.org.au>, Qian Cai <cai@lca.pw>,
        Barret Rhoden <brho@google.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        David Rientjes <rientjes@google.com>, linux-mm@kvack.org,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 2/2] x86/numa: instance all parsed numa node
In-Reply-To: <18D4CC9F-BC2C-4C82-873E-364CD1795EFB@amacapital.net>
Message-ID: <alpine.DEB.2.21.1907082025180.1961@nanos.tec.linutronix.de>
References: <1562300143-11671-1-git-send-email-kernelfans@gmail.com> <1562300143-11671-2-git-send-email-kernelfans@gmail.com> <alpine.DEB.2.21.1907072133310.3648@nanos.tec.linutronix.de> <CAFgQCTvwS+yEkAmCJnsCfnr0JS01OFtBnDg4cr41_GqU79A4Gg@mail.gmail.com>
 <alpine.DEB.2.21.1907081125300.3648@nanos.tec.linutronix.de> <18D4CC9F-BC2C-4C82-873E-364CD1795EFB@amacapital.net>
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

On Mon, 8 Jul 2019, Andy Lutomirski wrote:
> > On Jul 8, 2019, at 3:35 AM, Thomas Gleixner <tglx@linutronix.de> wrote:
> > Anything less than the actual number of present CPUs is problematic except
> > you use the 'let's hope nothing happens' approach. We could add an option
> > to stop the bringup at the early online state similar to what we do for
> > 'nosmt'.
> > 
> How about we change nr_cpus to do that instead so we never have to have
> this conversation again?

Actually not the worst idea. We have all the infrastructure already.

Thanks,

	tglx

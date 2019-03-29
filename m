Return-Path: <SRS0=SA5R=SA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7F6B9C43381
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Mar 2019 07:34:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4C6432082F
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Mar 2019 07:34:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728901AbfC2Heq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 29 Mar 2019 03:34:46 -0400
Received: from mx1.redhat.com ([209.132.183.28]:46870 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728773AbfC2Hep (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Mar 2019 03:34:45 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id D012B308424D;
        Fri, 29 Mar 2019 07:34:44 +0000 (UTC)
Received: from localhost (ovpn-12-24.pek2.redhat.com [10.72.12.24])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id C6FAA6FF09;
        Fri, 29 Mar 2019 07:34:41 +0000 (UTC)
Date:   Fri, 29 Mar 2019 15:34:38 +0800
From:   Baoquan He <bhe@redhat.com>
To:     Pingfan Liu <kernelfans@gmail.com>
Cc:     Dave Young <dyoung@redhat.com>, x86@kernel.org,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Will Deacon <will.deacon@arm.com>,
        Nicolas Pitre <nico@linaro.org>,
        Chao Fan <fanc.fnst@cn.fujitsu.com>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCHv2] x86/boot/KASLR: skip the specified crashkernel
 reserved region
Message-ID: <20190329073438.GC7627@MiWiFi-R3L-srv>
References: <1552450771-8360-1-git-send-email-kernelfans@gmail.com>
 <20190320002524.GD18740@MiWiFi-R3L-srv>
 <CAFgQCTt3-9oZ6yi_MGYFOZhn5+cSdJLGf3OQRMJ1CJr0eXiE5w@mail.gmail.com>
 <20190322075259.GA18740@MiWiFi-R3L-srv>
 <20190322083419.GB18740@MiWiFi-R3L-srv>
 <CAFgQCTti4S3TUx_4YHi+Yx6poJbHhekT+Jzjjg__0tpZdA9tRQ@mail.gmail.com>
 <20190329062715.GA7627@MiWiFi-R3L-srv>
 <CAFgQCTvGnV5NUcyp1RCJa2hHxKiQDM=HRn_GwWs+WUdt1afLQA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAFgQCTvGnV5NUcyp1RCJa2hHxKiQDM=HRn_GwWs+WUdt1afLQA@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.40]); Fri, 29 Mar 2019 07:34:45 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 03/29/19 at 03:25pm, Pingfan Liu wrote:
> On Fri, Mar 29, 2019 at 2:27 PM Baoquan He <bhe@redhat.com> wrote:
> >
> > On 03/29/19 at 01:45pm, Pingfan Liu wrote:
> > > On Fri, Mar 22, 2019 at 4:34 PM Baoquan He <bhe@redhat.com> wrote:
> > > >
> > > > On 03/22/19 at 03:52pm, Baoquan He wrote:
> > > > > On 03/22/19 at 03:43pm, Pingfan Liu wrote:
> > > > > > > > +/* parse crashkernel=x@y option */
> > > > > > > > +static void mem_avoid_crashkernel_simple(char *option)
> > > > > > >
> > > > > > > Chao ever mentioned this, I want to ask again, why does it has to be
> > > > > > > xxx_simple()?
> > > > > > >
> > > > > > Seems that I had replied Chao's question in another email. The naming
> > > > > > follows the function parse_crashkernel_simple(), as the notes above
> > > > >                        ~~~~~~~~~~~~~~~~~~~~~~~~
> > > > >
> > > > > Sorry, I don't get.  typo?
> > > >
> > > > OK, I misunderstood it. We do have parse_crashkernel_simple() to handle
> > > > crashkernel=size[@offset] case, to differente with other complicated
> > > > cases, like crashkernel=size,[high|low],
> > > >
> > > > Then I am fine with this naming. Soryy about the noise.
> > > >
> > > > By the way, do you think if we should take care of this case:
> > > > crashkernel=<range1>:<size1>[,<range2>:<size2>,...][@offset]
> > > >
> > > > It can also specify @offset. Not sure if it's too complicated, you may
> > > > have a investigation.
> > > >
> > > In this case, kernel should get the total memory size info. So
> > > process_e820_entries() or process_efi_entries() should be called
> > > twice. One before handle_mem_options(), so crashkernel can evaluate
> > > the reserved size. It is doable, and what is your opinion about the
> >
> > You mean calling process_e820_entries to calculate the RAM size in
> > system? I may not do like that, please check what __find_max_addr() is
> > doing. Did I get it?
> 
> Yes, you got my meaning. But __find_max_addr() relies on the info, fed
> by e820__memblock_setup(). It also involves the iteration of all e820
> entries to get the max address. No essential difference, right?

Hmm, I would say iterating e820 or efi entries to get the mas addr should be
different with calling process_e820_entries(). The 1st is much simpler,
right?


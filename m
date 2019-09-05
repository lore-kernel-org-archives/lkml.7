Return-Path: <SRS0=AnJR=XA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D67D5C3A5A5
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Sep 2019 12:50:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CAC3A2082C
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Sep 2019 12:49:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1567687799;
	bh=u5/6CYSwJw54q2AdpCKJ0XMdCuQlD+4IdreRDjcYlFU=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=CAZI8dBdfHfWGbGpJUxTYsK5jLTnLGdSa9XjTaUiOiSS+sNwl9s99BawDCVVp+GMb
	 daFKjcQMC6iVO3UQonoXd7qQ246t9VkSrk75fczqINIkiqDbJE6IDr7yF3wdf2OSQL
	 yUwZpax75j0XdA1SM65hMyTLmy1SrmlX8ClSyQvE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388061AbfIEMuA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 5 Sep 2019 08:50:00 -0400
Received: from mail.kernel.org ([198.145.29.99]:33126 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730864AbfIEMuA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Sep 2019 08:50:00 -0400
Received: from devnote2 (NE2965lan1.rev.em-net.ne.jp [210.141.244.193])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id BE61620640;
        Thu,  5 Sep 2019 12:49:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1567687797;
        bh=u5/6CYSwJw54q2AdpCKJ0XMdCuQlD+4IdreRDjcYlFU=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=k4CnjkwX+6Si0MYUHHzfDMUELVvp1IkFYzD9ZdviGrsA2kdvXZzSBCuFt/Wo2GhwY
         il7E7xBY6+mHeqgsUJlT/faJnGPZCotfc23DstGh4xAVo/oh5yy9/Eo7xUYiM7GXDP
         Qz25ZpkefgCcyYKHgMwCUqA8y4m30TW7c7lqVkP0=
Date:   Thu, 5 Sep 2019 21:49:53 +0900
From:   Masami Hiramatsu <mhiramat@kernel.org>
To:     Andrew Cooper <andrew.cooper3@citrix.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Juergen Gross <jgross@suse.com>,
        Stefano Stabellini <sstabellini@kernel.org>,
        Randy Dunlap <rdunlap@infradead.org>, <x86@kernel.org>,
        <linux-kernel@vger.kernel.org>, Borislav Petkov <bp@alien8.de>,
        "Josh Poimboeuf" <jpoimboe@redhat.com>,
        <xen-devel@lists.xenproject.org>,
        "Boris Ostrovsky" <boris.ostrovsky@oracle.com>
Subject: [OT] Re: [Xen-devel] [PATCH -tip 0/2] x86: Prohibit kprobes on
 XEN_EMULATE_PREFIX
Message-Id: <20190905214953.e4ad9af6e83a911a141c8a11@kernel.org>
In-Reply-To: <4de91a14-2051-197e-6ab0-beb2538c40f9@citrix.com>
References: <156759754770.24473.11832897710080799131.stgit@devnote2>
        <ad6431be-c86e-5ed5-518a-d1e9d1959e80@citrix.com>
        <20190905104937.60aa03f699a9c0fbf1b651b9@kernel.org>
        <1372ce73-e2d8-6144-57df-a98429587826@citrix.com>
        <20190905082647.GZ2332@hirez.programming.kicks-ass.net>
        <4de91a14-2051-197e-6ab0-beb2538c40f9@citrix.com>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 5 Sep 2019 09:53:32 +0100
Andrew Cooper <andrew.cooper3@citrix.com> wrote:

> On 05/09/2019 09:26, Peter Zijlstra wrote:
> > On Thu, Sep 05, 2019 at 08:54:17AM +0100, Andrew Cooper wrote:
> >
> >> I don't know if you've spotted, but the prefix is a ud2a instruction
> >> followed by 'xen' in ascii.
> >>
> >> The KVM version was added in c/s 6c86eedc206dd1f9d37a2796faa8e6f2278215d2
> > While the Xen one disassebles to valid instructions, that KVM one does
> > not:
> >
> > 	.text
> > xen:
> > 	ud2; .ascii "xen"
> > kvm:
> > 	ud2; .ascii "kvm"
> >
> > disassembles like:
> >
> > 0000000000000000 <xen>:
> >    0:   0f 0b                   ud2
> >    2:   78 65                   js     69 <kvm+0x64>
> >    4:   6e                      outsb  %ds:(%rsi),(%dx)
> > 0000000000000005 <kvm>:
> >    5:   0f 0b                   ud2
> >    7:   6b                      .byte 0x6b
> >    8:   76 6d                   jbe    77 <kvm+0x72>
> >
> > Which is a bit unfortunate I suppose. At least they don't appear to
> > consume further bytes.
> 
> It does when you give objdump one extra byte to look at.
> 
> 0000000000000005 <kvm>:
>    5:    0f 0b                    ud2   
>    7:    6b 76 6d 00              imul   $0x0,0x6d(%rsi),%esi
> 

Hmm, that consumes the first byte of the next instruction.
For example, 

  .text
xen:
  ud2; .ascii "xen"; cpuid
kvm:
  ud2; .ascii "kvm"; cpuid

0000000000000000 <xen>:
   0:	0f 0b                	ud2    
   2:	78 65                	js     69 <kvm+0x62>
   4:	6e                   	outsb  %ds:(%rsi),(%dx)
   5:	0f a2                	cpuid  

0000000000000007 <kvm>:
   7:	0f 0b                	ud2    
   9:	6b 76 6d 0f          	imul   $0xf,0x6d(%rsi),%esi
   d:	a2                   	.byte 0xa2

This will disturbe decoding bytestream. Anyway, with the next version
it will be fixed in x86 insn decoder.

Thanks,

-- 
Masami Hiramatsu <mhiramat@kernel.org>

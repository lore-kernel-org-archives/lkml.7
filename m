Return-Path: <SRS0=Exau=WQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C397CC3A589
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Aug 2019 13:43:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9A66D22DA9
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Aug 2019 13:43:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730804AbfHTNnN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 20 Aug 2019 09:43:13 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:52052 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730755AbfHTNnB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Aug 2019 09:43:01 -0400
Received: from p5de0b6c5.dip0.t-ipconnect.de ([93.224.182.197] helo=nanos)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1i04Pa-0006ml-5F; Tue, 20 Aug 2019 15:42:58 +0200
Date:   Tue, 20 Aug 2019 15:42:57 +0200 (CEST)
From:   Thomas Gleixner <tglx@linutronix.de>
To:     =?ISO-8859-15?Q?Thomas_Hellstr=F6m_=28VMware=29?= 
        <thomas_os@shipmail.org>
cc:     Peter Zijlstra <peterz@infradead.org>,
        linux-kernel@vger.kernel.org, pv-drivers@vmware.com,
        Thomas Hellstrom <thellstrom@vmware.com>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org,
        Doug Covelli <dcovelli@vmware.com>
Subject: Re: [PATCH 2/4] x86/vmware: Add a header file for hypercall
 definitions
In-Reply-To: <597132a4-2514-2f13-5786-b423d82b7fd4@shipmail.org>
Message-ID: <alpine.DEB.2.21.1908201540400.2223@nanos.tec.linutronix.de>
References: <20190818143316.4906-1-thomas_os@shipmail.org> <20190818143316.4906-3-thomas_os@shipmail.org> <20190820113203.GM2332@hirez.programming.kicks-ass.net> <597132a4-2514-2f13-5786-b423d82b7fd4@shipmail.org>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323329-1285972205-1566308578=:2223"
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required,  ALL_TRUSTED=-1,SHORTCIRCUIT=-0.0001
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323329-1285972205-1566308578=:2223
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8BIT

On Tue, 20 Aug 2019, Thomas Hellström (VMware) wrote:

> On 8/20/19 1:32 PM, Peter Zijlstra wrote:
> > On Sun, Aug 18, 2019 at 04:33:14PM +0200, Thomas Hellström (VMware) wrote:
> > 
> > > +#define VMWARE_HYPERCALL \
> > > +	ALTERNATIVE_2(".byte 0xed", \
> > > +		      ".byte 0x0f, 0x01, 0xc1", X86_FEATURE_VMW_VMCALL,	\
> > > +		      ".byte 0x0f, 0x01, 0xd9", X86_FEATURE_VMW_VMMCALL)
> > For sanity, could we either add comments, or macros for those
> > instrucions?
> 
> Hmm. Here I followed and slightly extended what was done in asm/kvm_para.h.
> 
> What confuses me a bit is, if it's clarity we're after, why don't people use
> 
> #define VMWARE_HYPERCALL 					\
> 	ALTERNATIVE_2("inl (%%dx)", 				\
> 		      "vmcall", X86_FEATURE_VMW_VMCALL,		\	
> 		      "vmmcall", X86_FEATURE_VMW_VMMCALL)
> 
> Seems to build fine here. Is it fear of old assemblers not supporting, for
> example vmmcall

The requirement for binutils is version >= 2.21. If 2.21 supports vmcall and
vmmcall all good.

Thanks,

	tglx
--8323329-1285972205-1566308578=:2223--

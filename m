Return-Path: <SRS0=31nU=WT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6BEE0C3A5A2
	for <linux-kernel@archiver.kernel.org>; Fri, 23 Aug 2019 14:51:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 357D021848
	for <linux-kernel@archiver.kernel.org>; Fri, 23 Aug 2019 14:51:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1566571896;
	bh=aVchjuHWTXOaTDZuWT4rE8xKpWB6QsFxLg6BDqrPMBU=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=SpqM9jkycYngtv3OuTwomWz0sXNkMgJUEYJkubFBVeZ8SXekIFTdOTERkIa4GyvxU
	 4qSdofpOVZA17tB5Wbg2orb7oXiFAqzKYXbCWg78a3dtBI8fPPAPdmnOTfxYzYEZtV
	 vwKBCF5P8EQiPdi+27MdKMJjr6sXS288HWNSVo2o=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2395412AbfHWOvf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 23 Aug 2019 10:51:35 -0400
Received: from mail.kernel.org ([198.145.29.99]:34322 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388352AbfHWOvf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Aug 2019 10:51:35 -0400
Received: from devnote2 (NE2965lan1.rev.em-net.ne.jp [210.141.244.193])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 97BFE2166E;
        Fri, 23 Aug 2019 14:51:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1566571894;
        bh=aVchjuHWTXOaTDZuWT4rE8xKpWB6QsFxLg6BDqrPMBU=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=lOhadIdBCMKhZZkWRsZKTsc0dnSKABUI8r7IDxP9auoTwL6cq9VHHquL4sgCddJ6+
         i1Jq9+dVh+hxyozPx0IO9InPMe2+rO8hPvYEdx76EdJfBrs/UVH85CpxjJtTRN9YbF
         4CjkRdbiWquBWBZNXw5KcjOc4pDLb86Dt8FmvwSE=
Date:   Fri, 23 Aug 2019 23:51:27 +0900
From:   Masami Hiramatsu <mhiramat@kernel.org>
To:     Jisheng Zhang <Jisheng.Zhang@synaptics.com>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Will Deacon <will@kernel.org>, Ingo Molnar <mingo@redhat.com>,
        Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>,
        "x86@kernel.org" <x86@kernel.org>,
        "Naveen N. Rao" <naveen.n.rao@linux.ibm.com>,
        Anil S Keshavamurthy <anil.s.keshavamurthy@intel.com>,
        "David S. Miller" <davem@davemloft.net>,
        "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>
Subject: Re: [PATCH v2 1/3] kprobes/x86: use instruction_pointer and
 instruction_pointer_set
Message-Id: <20190823235127.6b1ab6bdb3a280b64ca8585e@kernel.org>
In-Reply-To: <20190821095527.729b2b0d@xhacker.debian>
References: <20190820113928.1971900c@xhacker.debian>
        <20190820114109.4624d56b@xhacker.debian>
        <alpine.DEB.2.21.1908201050370.2223@nanos.tec.linutronix.de>
        <20190820165152.20275268@xhacker.debian>
        <20190821105247.f0236d2c04b2c0c4d4e1847e@kernel.org>
        <20190821095527.729b2b0d@xhacker.debian>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jisheng,

On Wed, 21 Aug 2019 02:09:10 +0000
Jisheng Zhang <Jisheng.Zhang@synaptics.com> wrote:

> > > In v2, actually, the arm64 version's kprobe_ftrace_handler() is the same
> > > as x86's, the only difference is comment, e.g
> > >
> > > /* Kprobe handler expects regs->ip = ip + 1 as breakpoint hit */
> > >
> > > while in arm64
> > >
> > > /* Kprobe handler expects regs->pc = ip + 1 as breakpoint hit */  
> > 
> > As Peter pointed, on arm64, is that really 1 or 4 bytes?
> > This part is heavily depends on the processor software-breakpoint
> > implementation.
> 
> Per my understanding, the "+1" here means "+ one kprobe_opcode_t".

No, that is the size of INT3. It just emulates the software trap on x86.

Thank you,
-- 
Masami Hiramatsu <mhiramat@kernel.org>

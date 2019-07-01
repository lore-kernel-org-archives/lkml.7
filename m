Return-Path: <SRS0=3QRk=U6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AFFE2C0650E
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Jul 2019 14:53:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 867792064B
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Jul 2019 14:53:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729894AbfGAOxj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Jul 2019 10:53:39 -0400
Received: from mga05.intel.com ([192.55.52.43]:17881 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726967AbfGAOxi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Jul 2019 10:53:38 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga105.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 01 Jul 2019 07:53:37 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.63,439,1557212400"; 
   d="scan'208";a="174246309"
Received: from ranerica-svr.sc.intel.com ([172.25.110.23])
  by orsmga002.jf.intel.com with ESMTP; 01 Jul 2019 07:53:36 -0700
Date:   Mon, 1 Jul 2019 07:53:08 -0700
From:   Ricardo Neri <ricardo.neri-calderon@linux.intel.com>
To:     Paolo Bonzini <pbonzini@redhat.com>
Cc:     Li Wang <liwang@redhat.com>, tglx@linutronix.de,
        kernellwp@gmail.com, ricardo.neri@intel.com, pengfei.xu@intel.com,
        LTP List <ltp@lists.linux.it>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Ping Fang <pifang@redhat.com>
Subject: Re: [Kernel BUG?] SMSW operation get success on UMIP KVM guest
Message-ID: <20190701145308.GA19368@ranerica-svr.sc.intel.com>
References: <CAEemH2cg01cdz=amrCWU00Xof9+cxmfR_DqCBaQe36QoGsakmA@mail.gmail.com>
 <5622c0ac-236f-4e3e-a132-c8d3bd8fadc4@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <5622c0ac-236f-4e3e-a132-c8d3bd8fadc4@redhat.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 01, 2019 at 02:02:35PM +0200, Paolo Bonzini wrote:
> On 01/07/19 09:50, Li Wang wrote:
> > Hello there,
> > 
> > LTP/umip_basic_test get failed on KVM UMIP
> > system(kernel-v5.2-rc4.x86_64). The test is only trying to do
> >      asm volatile("smsw %0\n" : "=m" (val));
> > and expect to get SIGSEGV in this SMSW operation, but it exits with 0
> > unexpectedly.
> 
> In addition to what Thomas said, perhaps you are using a host that does
> *not* have UMIP, and configuring KVM to emulate it(*).  In that case, it
> is not possible to intercept SMSW, and therefore it will incorrectly
> succeed.

Also, emulation for SMSW, SIDT, and SGDT is done only for 32-bit
processes. As Thomas said, the purpose is not on break Wine. In 64-bit
processes, we sould always see a #GP exception.
> 
> Paolo
> 
> (*) before the x86 people jump at me, this won't happen unless you
> explicitly pass an option to QEMU, such as "-cpu host,+umip". :)  The
> incorrect emulation of SMSW when CR4.UMIP=1 is why.

Paolo, what do you mean by the incorrect emulation of SMSW?

Thanks and BR,
Ricardo

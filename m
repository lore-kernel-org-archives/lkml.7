Return-Path: <SRS0=AnJR=XA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9DDBBC3A5A5
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Sep 2019 08:27:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 70CBA20870
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Sep 2019 08:27:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="UqdnQMjm"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732604AbfIEI1D (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 5 Sep 2019 04:27:03 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:44234 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732583AbfIEI1D (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Sep 2019 04:27:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=T29HodBB++BKOCDptdMCNIsRzIU120R7kdF9uHbtmks=; b=UqdnQMjmtW19KSZrfKLHCPF4Q
        fGEVr4nbDik31n728nyaw2T0mxPNcCefnf9ns8C8tqhZKAdzSl4bhlsNrEleFzoexO5B/SBBv9pZ1
        gP9SAQN2MOR1kDvVSxtS5jWdPes3qUDGPC65tqRxYNSU8TlEa3ABWQO4fuvr7DqnumBUREc9abOfb
        pm8a9ftCNMHb4ubY4rrxy9wpBbWDgwiq/k74bEM3ocaT6SWNGYh6gwhh8ZWMSWQPmMhuOKCylsbrb
        ei30B0ulngvsmH4dr4EArVzL+/inlrpqCjWKVUkcx0UCiQ7Fwh+9S3nwK1zNoC/uv0dlDj2qmXDzO
        md6vSHZEA==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.92 #3 (Red Hat Linux))
        id 1i5n6Q-0005aT-I9; Thu, 05 Sep 2019 08:26:50 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id B44AE305E47;
        Thu,  5 Sep 2019 10:26:10 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 95DF220977763; Thu,  5 Sep 2019 10:26:47 +0200 (CEST)
Date:   Thu, 5 Sep 2019 10:26:47 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Andrew Cooper <andrew.cooper3@citrix.com>
Cc:     Masami Hiramatsu <mhiramat@kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Juergen Gross <jgross@suse.com>,
        Stefano Stabellini <sstabellini@kernel.org>,
        Randy Dunlap <rdunlap@infradead.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org, Borislav Petkov <bp@alien8.de>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        xen-devel@lists.xenproject.org,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>
Subject: Re: [Xen-devel] [PATCH -tip 0/2] x86: Prohibit kprobes on
 XEN_EMULATE_PREFIX
Message-ID: <20190905082647.GZ2332@hirez.programming.kicks-ass.net>
References: <156759754770.24473.11832897710080799131.stgit@devnote2>
 <ad6431be-c86e-5ed5-518a-d1e9d1959e80@citrix.com>
 <20190905104937.60aa03f699a9c0fbf1b651b9@kernel.org>
 <1372ce73-e2d8-6144-57df-a98429587826@citrix.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1372ce73-e2d8-6144-57df-a98429587826@citrix.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 05, 2019 at 08:54:17AM +0100, Andrew Cooper wrote:

> I don't know if you've spotted, but the prefix is a ud2a instruction
> followed by 'xen' in ascii.
>
> The KVM version was added in c/s 6c86eedc206dd1f9d37a2796faa8e6f2278215d2

While the Xen one disassebles to valid instructions, that KVM one does
not:

	.text
xen:
	ud2; .ascii "xen"
kvm:
	ud2; .ascii "kvm"

disassembles like:

0000000000000000 <xen>:
   0:   0f 0b                   ud2
   2:   78 65                   js     69 <kvm+0x64>
   4:   6e                      outsb  %ds:(%rsi),(%dx)
0000000000000005 <kvm>:
   5:   0f 0b                   ud2
   7:   6b                      .byte 0x6b
   8:   76 6d                   jbe    77 <kvm+0x72>

Which is a bit unfortunate I suppose. At least they don't appear to
consume further bytes.

I know it is water under the bridge at this point; but you could've used
UD1 with a displacement with some 'unlikely' values. That way it
would've decoded to a single instruction.

Something like:

	ud1    0x6e6578(%rax),%rax

which spells out "xen\0" in the displacement:

	48 0f b9 80 78 65 6e 00

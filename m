Return-Path: <SRS0=GGWy=XB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 66FC8C43331
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Sep 2019 08:51:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 43B8D20842
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Sep 2019 08:51:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1567759910;
	bh=dq2PqlTTw4AElMpP7ipwksECqbehXK1zm3qLvsANfrM=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=nH/uuvJIC0NBWlxCcsOlMsbBbVie1XYfWJi6PDm66veyoNBN/nuSDMpUYBWwcMcyN
	 dl7T8cYK8A2CieP67faEt5Le4KXAMD1h54/MT/pTGkKZIIA0KSDlpFtZO5+Vb0UuRe
	 HUZhPu9/jFImDPbsheHDneW63vFbU59mnTcqBa8w=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392757AbfIFIvt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 6 Sep 2019 04:51:49 -0400
Received: from mail.kernel.org ([198.145.29.99]:34302 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731942AbfIFIvt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Sep 2019 04:51:49 -0400
Received: from devnote2 (NE2965lan1.rev.em-net.ne.jp [210.141.244.193])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D635E20578;
        Fri,  6 Sep 2019 08:51:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1567759908;
        bh=dq2PqlTTw4AElMpP7ipwksECqbehXK1zm3qLvsANfrM=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=YhS2+p4hAE3qi/YHQnaSjDgvtiLthO++VBzJ5h5XyiQRZJxPJNmyCg2B9mfG33C+y
         l7BNfv4Sij6TO4piVHUz+Og3vQy5lzuLx6JpTaXAhLhl6FQ/AQfi4E+5w0G0Oj0Rg6
         OBfosjkDswbiTvw8D57R/XCrMOvOq4VuY8bLRruk=
Date:   Fri, 6 Sep 2019 17:51:43 +0900
From:   Masami Hiramatsu <mhiramat@kernel.org>
To:     Masami Hiramatsu <mhiramat@kernel.org>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Andrew Cooper <andrew.cooper3@citrix.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        Borislav Petkov <bp@alien8.de>,
        Juergen Gross <jgross@suse.com>,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        Stefano Stabellini <sstabellini@kernel.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org, xen-devel@lists.xenproject.org
Subject: Re: [PATCH -tip v3 1/2] x86: xen: insn: Decode Xen and KVM
 emulate-prefix signature
Message-Id: <20190906175143.469287501610cbca73f0abbb@kernel.org>
In-Reply-To: <20190906174519.699b83f08d81b55203212fa1@kernel.org>
References: <156773433821.31441.2905951246664148487.stgit@devnote2>
        <156773434815.31441.12739136439382289412.stgit@devnote2>
        <20190906073436.GS2349@hirez.programming.kicks-ass.net>
        <20190906174519.699b83f08d81b55203212fa1@kernel.org>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 6 Sep 2019 17:45:19 +0900
Masami Hiramatsu <mhiramat@kernel.org> wrote:

> > 
> > How about we make this asm/virt_prefix.h or something and include:
> > 
> > /*
> >  * Virt escape sequences to trigger instruction emulation;
> >  * ideally these would decode to 'whole' instruction and not destroy
> >  * the instruction stream; sadly this is not true for the 'kvm' one :/
> >  */
> > 
> > #define __XEN_EMULATE_PREFIX  0x0f,0x0b,0x78,0x65,0x6e  /* ud2 ; .ascii "xen" */
> > #define __KVM_EMULATE_PREFIX  0x0f,0x0b,0x6b,0x76,0x6d	/* ud2 ; .ascii "kvm" */

BTW, what should we call it, "emulate prefix" or "virt prefix"?
"virt prefix" sounds too generic to me. So I rather like emulate_prefix.h.

Thank you,
-- 
Masami Hiramatsu <mhiramat@kernel.org>

Return-Path: <SRS0=GGWy=XB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 094BEC43331
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Sep 2019 01:39:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ECFC02082C
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Sep 2019 01:39:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1567733950;
	bh=aHg0E3mt7AI+DRDT0bvLOsakhhkONV9V1aoQPlFMNE4=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=mofjjNyNSulAK9BY9v1shSGC2DWkyxij9BRb1rULgy0/lm5t69xSz3MWDYP8yNkEA
	 Be0Wa0OrvWSRJV3cqLyJek0ltWK6BMe8Eto+oPODALcrudCAaghs8V4ruL7DTnJvpK
	 QPYH5ZtxCX85fBJaNQ0z/uhQXChcZVf++q8puif0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387444AbfIFBjJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 5 Sep 2019 21:39:09 -0400
Received: from mail.kernel.org ([198.145.29.99]:59794 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726858AbfIFBjI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Sep 2019 21:39:08 -0400
Received: from devnote2 (NE2965lan1.rev.em-net.ne.jp [210.141.244.193])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5EC3E207E0;
        Fri,  6 Sep 2019 01:39:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1567733948;
        bh=aHg0E3mt7AI+DRDT0bvLOsakhhkONV9V1aoQPlFMNE4=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=h1/LB253vTL/bFRu7AR63XO0H8mRHG6hnMyzEjSZqjzMKbRQ0kmWWrDnElyIqhyPG
         n+6jMf2x9aq15ZMF5LEowxUqh0dJkOpAVi0GRxp6x6xK5fVMdxRzjTMI6QJEOFuSyF
         dEPeTPyOgb9E8xo94UpkzEbGkpFurmqxwT16X7GI=
Date:   Fri, 6 Sep 2019 10:39:03 +0900
From:   Masami Hiramatsu <mhiramat@kernel.org>
To:     Josh Poimboeuf <jpoimboe@redhat.com>
Cc:     Ingo Molnar <mingo@kernel.org>,
        Andrew Cooper <andrew.cooper3@citrix.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Randy Dunlap <rdunlap@infradead.org>,
        Borislav Petkov <bp@alien8.de>,
        Juergen Gross <jgross@suse.com>,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        Stefano Stabellini <sstabellini@kernel.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org, xen-devel@lists.xenproject.org
Subject: Re: [PATCH -tip v2 1/2] x86: xen: insn: Decode Xen and KVM
 emulate-prefix signature
Message-Id: <20190906103903.36868b9074b3111ada3d85da@kernel.org>
In-Reply-To: <20190906011350.y65zwuychhryt7eg@treble>
References: <156773100816.29031.12557431294039450779.stgit@devnote2>
        <156773101914.29031.4027232648773934988.stgit@devnote2>
        <20190906011350.y65zwuychhryt7eg@treble>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 5 Sep 2019 20:13:50 -0500
Josh Poimboeuf <jpoimboe@redhat.com> wrote:

> On Fri, Sep 06, 2019 at 09:50:19AM +0900, Masami Hiramatsu wrote:
> > --- a/tools/objtool/sync-check.sh
> > +++ b/tools/objtool/sync-check.sh
> > @@ -4,6 +4,7 @@
> >  FILES='
> >  arch/x86/include/asm/inat_types.h
> >  arch/x86/include/asm/orc_types.h
> > +arch/x86/include/asm/xen/prefix.h
> >  arch/x86/lib/x86-opcode-map.txt
> >  arch/x86/tools/gen-insn-attr-x86.awk
> >  '
> > @@ -46,6 +47,6 @@ done
> >  check arch/x86/include/asm/inat.h     '-I "^#include [\"<]\(asm/\)*inat_types.h[\">]"'
> >  check arch/x86/include/asm/insn.h     '-I "^#include [\"<]\(asm/\)*inat.h[\">]"'
> >  check arch/x86/lib/inat.c             '-I "^#include [\"<]\(../include/\)*asm/insn.h[\">]"'
> > -check arch/x86/lib/insn.c             '-I "^#include [\"<]\(../include/\)*asm/in\(at\|sn\).h[\">]"'
> > +check arch/x86/lib/insn.c             '-I "^#include [\"<]\(../include/\)*asm/in\(at\|sn\).h[\">]" -I "^#include [\"<]\(../include/\)*asm/xen/prefix.h[\">]"'
> 
> Unfortunately perf also has a similar sync check script:
> tools/perf/check-headers.sh.  So you'll also need to add the above
> changes there.

Oops, I thought it was integrated... OK, I'll update this patch.

> 
> Otherwise
> 
> Acked-by: Josh Poimboeuf <jpoimboe@redhat.com>

Thanks!

> 
> -- 
> Josh


-- 
Masami Hiramatsu <mhiramat@kernel.org>

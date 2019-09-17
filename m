Return-Path: <SRS0=bFUY=XM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 49612C4CEC9
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Sep 2019 06:14:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1D02B21852
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Sep 2019 06:14:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1568700850;
	bh=sE3YRRODfOBV2JbJVxF12dvUKJrD1eRcmK4W8+NtWs0=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=JCxLtpVL3OiSDDMM04dysOAv4vG2ZzQMuNM8Yp4bNSXdhTqJU1MjcoT//Al5d8CIz
	 piQXt1L351yFHxcrWypMPK+ORseWmled9iIU4wDuuDdHG/Zifjj4cIwWF1CuP2vJrA
	 p3ojCdkT5zbHOp3MMSE8uyJMcRycKp2u1gMuI6gQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404104AbfIQGOJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 17 Sep 2019 02:14:09 -0400
Received: from mail.kernel.org ([198.145.29.99]:60114 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726511AbfIQGOJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Sep 2019 02:14:09 -0400
Received: from devnote2 (NE2965lan1.rev.em-net.ne.jp [210.141.244.193])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A118B206C2;
        Tue, 17 Sep 2019 06:14:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1568700848;
        bh=sE3YRRODfOBV2JbJVxF12dvUKJrD1eRcmK4W8+NtWs0=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=PiljeJClnrFwTFVeSrlY/eFqTrasaUfOpTJM3Un7Z8k0+/0fBioj6SEPpWBLJuP/p
         0HjLXHipxGvcx7Eo5gzjhpBbuCYOEuj71yWix3N2qWvtK63wJw/8vTB9P3Ev1LtT5l
         7I5S2tyM+uguK9IugUHKcKw7SS/l6VD/P0GMnsCY=
Date:   Tue, 17 Sep 2019 15:14:03 +0900
From:   Masami Hiramatsu <mhiramat@kernel.org>
To:     Masami Hiramatsu <mhiramat@kernel.org>
Cc:     Ingo Molnar <mingo@kernel.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Andrew Cooper <andrew.cooper3@citrix.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Randy Dunlap <rdunlap@infradead.org>,
        Borislav Petkov <bp@alien8.de>,
        Juergen Gross <jgross@suse.com>,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        Stefano Stabellini <sstabellini@kernel.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org, xen-devel@lists.xenproject.org
Subject: Re: [PATCH -tip v4 0/4] x86: kprobes: Prohibit kprobes on Xen/KVM
 emulate prefixes
Message-Id: <20190917151403.60023814bda80304777a35e5@kernel.org>
In-Reply-To: <156777561745.25081.1205321122446165328.stgit@devnote2>
References: <156777561745.25081.1205321122446165328.stgit@devnote2>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Peter,

Could you review this version?

Thank you,

On Fri,  6 Sep 2019 22:13:37 +0900
Masami Hiramatsu <mhiramat@kernel.org> wrote:

> Hi,
> 
> Here is the 4th version of patches to handle Xen/KVM emulate
> prefix by x86 instruction decoder.
> 
> These patches allow x86 instruction decoder to decode
> Xen and KVM emulate prefix correctly, and prohibit kprobes to
> probe on it.
> Previous version is here;
> 
>  https://lkml.kernel.org/r/156773433821.31441.2905951246664148487.stgit@devnote2
> 
> In this version, I added 2 patches, [1/4] fixes __ASM_FORM() to
> accept macros using __stringify(), [2/4] introduces new
> asm/emulate_prefix.h to initialize Xen and KVM emulate prefix
> at one place. [3/4] is updated to use new emulate_prefix.h and
> fix to add emulate_prefix.h to sync check list.
> 
> This series can be applied on -tip master branch which
> has merged Josh's objtool/perf sharing common x86 insn
> decoder series.
> 
> Thank you,
> 
> ---
> 
> Masami Hiramatsu (4):
>       x86/asm: Allow to pass macros to __ASM_FORM()
>       x86: xen: kvm: Gather the definition of emulate prefixes
>       x86: xen: insn: Decode Xen and KVM emulate-prefix signature
>       x86: kprobes: Prohibit probing on instruction which has emulate prefix
> 
> 
>  arch/x86/include/asm/asm.h                  |    8 ++++--
>  arch/x86/include/asm/emulate_prefix.h       |   14 +++++++++++
>  arch/x86/include/asm/insn.h                 |    6 +++++
>  arch/x86/include/asm/xen/interface.h        |   11 +++------
>  arch/x86/kernel/kprobes/core.c              |    4 +++
>  arch/x86/kvm/x86.c                          |    4 ++-
>  arch/x86/lib/insn.c                         |   34 +++++++++++++++++++++++++++
>  tools/arch/x86/include/asm/emulate_prefix.h |   14 +++++++++++
>  tools/arch/x86/include/asm/insn.h           |    6 +++++
>  tools/arch/x86/lib/insn.c                   |   34 +++++++++++++++++++++++++++
>  tools/objtool/sync-check.sh                 |    3 ++
>  tools/perf/check-headers.sh                 |    3 ++
>  12 files changed, 128 insertions(+), 13 deletions(-)
>  create mode 100644 arch/x86/include/asm/emulate_prefix.h
>  create mode 100644 tools/arch/x86/include/asm/emulate_prefix.h
> 
> --
> Masami Hiramatsu (Linaro) <mhiramat@kernel.org>


-- 
Masami Hiramatsu <mhiramat@kernel.org>

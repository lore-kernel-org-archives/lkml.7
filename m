Return-Path: <SRS0=2mSC=W2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9C732C3A59B
	for <linux-kernel@archiver.kernel.org>; Fri, 30 Aug 2019 15:20:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6C26820659
	for <linux-kernel@archiver.kernel.org>; Fri, 30 Aug 2019 15:20:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1567178419;
	bh=qyV0RCZJt0JTNnsp/PHNLEf674aXY77Jj6dQJAqmFmg=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=N2CflFySrub+5T+oiwH/DGlk4NiufJt94I768aONfgT+Sg6dySD15eOXsqzYJaobL
	 fcvTaUg996YxJiZsZ4kNFJfSsf5QmqJk2JlWyeWnbqe2ZYsXSEzp7eU6rviWJ304QJ
	 oIiHsEedWRtY3YrABnnxnwGHXf/sXZWtuUMQh4nE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728088AbfH3PUS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 30 Aug 2019 11:20:18 -0400
Received: from mail.kernel.org ([198.145.29.99]:47746 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727135AbfH3PUS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Aug 2019 11:20:18 -0400
Received: from devnote2 (NE2965lan1.rev.em-net.ne.jp [210.141.244.193])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3B70523407;
        Fri, 30 Aug 2019 15:20:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1567178416;
        bh=qyV0RCZJt0JTNnsp/PHNLEf674aXY77Jj6dQJAqmFmg=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=kqYiYTxN/HlygbqB9rmptMSjs8Z8Y58lJfAEwgaYbn/xMzQuZki1khG63g3bmX9yx
         UD9FCjQOdMUd+uccyJiPFHj0+T0D5IzBrlQolLucmUX2zoYvWXpEjitzo/VROlC2sN
         4qsfJtWmDyhWQkS2Hq9QlPdFubWuV3zg4S5SzzFI=
Date:   Sat, 31 Aug 2019 00:20:04 +0900
From:   Masami Hiramatsu <mhiramat@kernel.org>
To:     Josh Poimboeuf <jpoimboe@redhat.com>
Cc:     x86@kernel.org, linux-kernel@vger.kernel.org,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Jiri Olsa <jolsa@redhat.com>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Adrian Hunter <adrian.hunter@intel.com>
Subject: Re: [PATCH 0/4] objtool,perf: Use shared x86 insn decoder
Message-Id: <20190831002004.d570fcb7b611860e025dbdb2@kernel.org>
In-Reply-To: <cover.1567118001.git.jpoimboe@redhat.com>
References: <cover.1567118001.git.jpoimboe@redhat.com>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 29 Aug 2019 17:41:17 -0500
Josh Poimboeuf <jpoimboe@redhat.com> wrote:

> It's kind of silly that we have *three* identical copies of the x86 insn
> decoder in the kernel tree.  Make it approximately 50% less silly by
> reducing that number to two.
> 

Sounds good to me ;)

Reviewed-by: Masami Hiramatsu <mhiramat@kernel.org>

Thanks,

> Josh Poimboeuf (4):
>   objtool: Move x86 insn decoder to a common location
>   perf: Update .gitignore file
>   perf intel-pt: Remove inat.c from build dependency list
>   perf intel-pt: Use shared x86 insn decoder
> 
>  .../{objtool => }/arch/x86/include/asm/inat.h |    0
>  .../arch/x86/include/asm/inat_types.h         |    0
>  .../{objtool => }/arch/x86/include/asm/insn.h |    0
>  .../arch/x86/include/asm/orc_types.h          |    0
>  tools/{objtool => }/arch/x86/lib/inat.c       |    0
>  tools/{objtool => }/arch/x86/lib/insn.c       |    0
>  .../arch/x86/lib/x86-opcode-map.txt           |    0
>  .../arch/x86/tools/gen-insn-attr-x86.awk      |    0
>  tools/objtool/Makefile                        |    4 +-
>  tools/objtool/arch/x86/Build                  |    4 +-
>  tools/objtool/arch/x86/decode.c               |    4 +-
>  tools/objtool/sync-check.sh                   |   12 +-
>  tools/perf/.gitignore                         |    3 +
>  tools/perf/arch/x86/tests/insn-x86.c          |    2 +-
>  tools/perf/arch/x86/util/archinsn.c           |    2 +-
>  tools/perf/check-headers.sh                   |   11 +-
>  tools/perf/util/intel-pt-decoder/Build        |   22 +-
>  .../intel-pt-decoder/gen-insn-attr-x86.awk    |  392 ------
>  tools/perf/util/intel-pt-decoder/inat.c       |   82 --
>  tools/perf/util/intel-pt-decoder/inat.h       |  230 ----
>  tools/perf/util/intel-pt-decoder/inat_types.h |   15 -
>  tools/perf/util/intel-pt-decoder/insn.c       |  593 ---------
>  tools/perf/util/intel-pt-decoder/insn.h       |  216 ----
>  .../intel-pt-decoder/intel-pt-insn-decoder.c  |   10 +-
>  .../util/intel-pt-decoder/x86-opcode-map.txt  | 1072 -----------------
>  25 files changed, 34 insertions(+), 2640 deletions(-)
>  rename tools/{objtool => }/arch/x86/include/asm/inat.h (100%)
>  rename tools/{objtool => }/arch/x86/include/asm/inat_types.h (100%)
>  rename tools/{objtool => }/arch/x86/include/asm/insn.h (100%)
>  rename tools/{objtool => }/arch/x86/include/asm/orc_types.h (100%)
>  rename tools/{objtool => }/arch/x86/lib/inat.c (100%)
>  rename tools/{objtool => }/arch/x86/lib/insn.c (100%)
>  rename tools/{objtool => }/arch/x86/lib/x86-opcode-map.txt (100%)
>  rename tools/{objtool => }/arch/x86/tools/gen-insn-attr-x86.awk (100%)
>  delete mode 100644 tools/perf/util/intel-pt-decoder/gen-insn-attr-x86.awk
>  delete mode 100644 tools/perf/util/intel-pt-decoder/inat.c
>  delete mode 100644 tools/perf/util/intel-pt-decoder/inat.h
>  delete mode 100644 tools/perf/util/intel-pt-decoder/inat_types.h
>  delete mode 100644 tools/perf/util/intel-pt-decoder/insn.c
>  delete mode 100644 tools/perf/util/intel-pt-decoder/insn.h
>  delete mode 100644 tools/perf/util/intel-pt-decoder/x86-opcode-map.txt
> 
> -- 
> 2.20.1
> 


-- 
Masami Hiramatsu <mhiramat@kernel.org>

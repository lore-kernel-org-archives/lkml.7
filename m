Return-Path: <SRS0=2mSC=W2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1AD01C3A59B
	for <linux-kernel@archiver.kernel.org>; Fri, 30 Aug 2019 18:40:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DB9F123428
	for <linux-kernel@archiver.kernel.org>; Fri, 30 Aug 2019 18:40:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cIwpHcZU"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728157AbfH3Skb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 30 Aug 2019 14:40:31 -0400
Received: from mail-qt1-f196.google.com ([209.85.160.196]:37298 "EHLO
        mail-qt1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727791AbfH3Skb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Aug 2019 14:40:31 -0400
Received: by mail-qt1-f196.google.com with SMTP id y26so8688454qto.4
        for <linux-kernel@vger.kernel.org>; Fri, 30 Aug 2019 11:40:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=DqUAZl3KHcHwDI7BBwIPsUwofAQrOC22PyB1XbUvzD4=;
        b=cIwpHcZUdzajJ/0Q6r+KJxBBce2sfi/UZUN9f0k/T+JYuJWtg/Q3o8fN30V2u9t9SQ
         VMEuzJtM2/ulBzPjs9pGlDobK62+mGZ6KfnmZQfVrlV1SxE52oPcWPDT7oyZVchIhndN
         8RlOeC20cl3VJbnt1VGHMNo8SznWQ/y9T3w8uPxucRQXjarX46+BMDMD2yqsaPRx2dm+
         ajWft400BkWhoLbLXXP+QcrklPIZ3dDcXlDJVl99PN6nZi09KTmT/FGru8um9D8eQPSA
         9GlH9eWbVhoG15+Z8C2JHbFo4aNJahiTp2BYp27kxoAwv+v06l/+pcpojvQs/rqajrBq
         wv/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=DqUAZl3KHcHwDI7BBwIPsUwofAQrOC22PyB1XbUvzD4=;
        b=CN5QJEbA9HEqkEbD9P6YcmLnodmFBPxYhxJzURJqQK7lGdoH0ChlkGu+ezGDc4H+s2
         tRKmXq7rs04YaqP6tLS2VTlp3kOZZnfCZIcEWzHcxwtYIZCHg7HCOXFGRlRwaRDr3tXn
         Bcj6PlndgOSRuVFHSu6kFguuuz0MZPfMe+EyZ0zthcb1A4z8c7OUNIYQHQez76niUhHQ
         /iTO45CxX26PCEDwoe86w07IxYLDhBEDrpf1amhjU4oe9az8bNu+G0EQ4Yyj7GAxVNPq
         iF8DEF0P+38cvSMBSWeMzG2Oiyjy1lW8cPEbi6/4bKaohJEhoAd718yLhTrZG73svGCL
         VNhA==
X-Gm-Message-State: APjAAAWf8LJE1xuGcf6Jxu7nOkIMDD1TbWaVICc4WiBabYyJPza3exyH
        j/xuuoejbioHK1QsRXvV3NYLOwhK
X-Google-Smtp-Source: APXvYqzP+KoFn5mH/l4co+N53FcZuLIMUoXGl5qXpxm+E57KJQIQixyo97q28mgxclF0dHe7LyKaBQ==
X-Received: by 2002:ac8:397c:: with SMTP id t57mr16993623qtb.21.1567190430244;
        Fri, 30 Aug 2019 11:40:30 -0700 (PDT)
Received: from quaco.ghostprotocols.net (179-240-168-86.3g.claro.net.br. [179.240.168.86])
        by smtp.gmail.com with ESMTPSA id i9sm3157474qkk.82.2019.08.30.11.40.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Aug 2019 11:40:29 -0700 (PDT)
From:   Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>
X-Google-Original-From: Arnaldo Carvalho de Melo <acme@kernel.org>
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 3CE4F41146; Fri, 30 Aug 2019 15:40:20 -0300 (-03)
Date:   Fri, 30 Aug 2019 15:40:20 -0300
To:     Josh Poimboeuf <jpoimboe@redhat.com>
Cc:     x86@kernel.org, linux-kernel@vger.kernel.org,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>, Jiri Olsa <jolsa@redhat.com>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Adrian Hunter <adrian.hunter@intel.com>
Subject: Re: [PATCH 0/4] objtool,perf: Use shared x86 insn decoder
Message-ID: <20190830184020.GG28011@kernel.org>
References: <cover.1567118001.git.jpoimboe@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1567118001.git.jpoimboe@redhat.com>
X-Url:  http://acmel.wordpress.com
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Thu, Aug 29, 2019 at 05:41:17PM -0500, Josh Poimboeuf escreveu:
> It's kind of silly that we have *three* identical copies of the x86 insn
> decoder in the kernel tree.  Make it approximately 50% less silly by
> reducing that number to two.

Ok, I fixed up some minor conflicts with my perf/core branch and will
submit this together with the other things to the container builds and
then push it upstream, collected Peter and Masami's Acks.

- Arnaldo
 
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

-- 

- Arnaldo

Return-Path: <SRS0=2mSC=W2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 58A96C3A59B
	for <linux-kernel@archiver.kernel.org>; Fri, 30 Aug 2019 15:41:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 20D6023407
	for <linux-kernel@archiver.kernel.org>; Fri, 30 Aug 2019 15:41:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ff/syI5y"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728368AbfH3PlI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 30 Aug 2019 11:41:08 -0400
Received: from mail-qt1-f195.google.com ([209.85.160.195]:33585 "EHLO
        mail-qt1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727850AbfH3PlI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Aug 2019 11:41:08 -0400
Received: by mail-qt1-f195.google.com with SMTP id r5so2796371qtd.0
        for <linux-kernel@vger.kernel.org>; Fri, 30 Aug 2019 08:41:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=djD1pQ1U7LhQ/148ZQfZebehfdvHuL8mZ2td74QG7gA=;
        b=Ff/syI5yLdu0ja4Kdyq9aVwjjyIDV2gJiItT4pZn2Zw9XrWofLZe/+bmXAvq0gc4Vc
         f3EJcvfXbnJ4yVU7HYTqFkhNhRx/6A8/4PA3tN1pM7WB0T7diXqFsyWWffTh6Hyeuhdp
         rNiPJKpku7NB6WN1ViS3WrjHvXz/EaRsCmOq2mvhs/7Z+gRwMGFydPcSELrfmY99e5GU
         1YbQr89iBNUmJVXd+Iztt/v6wQQsqtUuY6KqCiah5jACppnM1bC9Y04NeoJbSUh7ZxCt
         WajM3rZQfE1B6OKJjXAL83Oi+l6852bNBY5LqJ+0RdAlFHeCx1Bw57I/fY+1++dt6/Dc
         jqbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=djD1pQ1U7LhQ/148ZQfZebehfdvHuL8mZ2td74QG7gA=;
        b=uXXTzc8Tq+7jxSr6LC6LiCnsVaVE+i0qK/GqOeZwp34uvfU445Fnw1lJw5d8squWuY
         viQJC+p6uMnryXxhsZfvxG20tueGJEMoX717G064sirYjoJ5EDkSuQmu61wSWzjwvUr6
         e/fwyn+/6yzqPNoFXZVC9mpZwdl6fRqYKsjrFSggLgAra7QCVgIg/c0G5ZDh8suL9p10
         8Tn/renxMF901PhHPbiB7/zPV4gczssE2dXFSM1z7Hl3GOA4SiQHH8dVF7XiU9ETCsZl
         RrJX3RIv+vzeioapMD7MW1PymCma+V2B89+YvoawP/Y4VZNvxl3DdXsFkygF9Uq0S0F3
         Q9aw==
X-Gm-Message-State: APjAAAUyxVqbRoRnI5ghJmx3yCHGdQmPwmaD4PkzWQaJpQ1dvCpn8z+b
        6gjbPRbOAxjzycQ2K1j6Y58=
X-Google-Smtp-Source: APXvYqw/7somUTQTd2TTBc+L0G94eZDim5rIR3AA3axbBqLZAD07MbIMr2Cvs7OFOJdtTHKEkNIrzw==
X-Received: by 2002:ac8:31cc:: with SMTP id i12mr16178711qte.170.1567179666815;
        Fri, 30 Aug 2019 08:41:06 -0700 (PDT)
Received: from quaco.ghostprotocols.net ([179.97.35.50])
        by smtp.gmail.com with ESMTPSA id k49sm3064292qtc.9.2019.08.30.08.41.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Aug 2019 08:41:06 -0700 (PDT)
From:   Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>
X-Google-Original-From: Arnaldo Carvalho de Melo <acme@kernel.org>
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 3F24041146; Fri, 30 Aug 2019 12:41:03 -0300 (-03)
Date:   Fri, 30 Aug 2019 12:41:03 -0300
To:     Adrian Hunter <adrian.hunter@intel.com>,
        Masami Hiramatsu <mhiramat@kernel.org>
Cc:     Josh Poimboeuf <jpoimboe@redhat.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>, Jiri Olsa <jolsa@redhat.com>
Subject: Re: [PATCH 0/4] objtool,perf: Use shared x86 insn decoder
Message-ID: <20190830154103.GA8994@kernel.org>
References: <cover.1567118001.git.jpoimboe@redhat.com>
 <20190831002004.d570fcb7b611860e025dbdb2@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190831002004.d570fcb7b611860e025dbdb2@kernel.org>
X-Url:  http://acmel.wordpress.com
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Sat, Aug 31, 2019 at 12:20:04AM +0900, Masami Hiramatsu escreveu:
> On Thu, 29 Aug 2019 17:41:17 -0500
> Josh Poimboeuf <jpoimboe@redhat.com> wrote:
> 
> > It's kind of silly that we have *three* identical copies of the x86 insn
> > decoder in the kernel tree.  Make it approximately 50% less silly by
> > reducing that number to two.
> > 
> 
> Sounds good to me ;)
> 
> Reviewed-by: Masami Hiramatsu <mhiramat@kernel.org>

Good, two already, Adrian?

- Arnaldo
 
> Thanks,
> 
> > Josh Poimboeuf (4):
> >   objtool: Move x86 insn decoder to a common location
> >   perf: Update .gitignore file
> >   perf intel-pt: Remove inat.c from build dependency list
> >   perf intel-pt: Use shared x86 insn decoder
> > 
> >  .../{objtool => }/arch/x86/include/asm/inat.h |    0
> >  .../arch/x86/include/asm/inat_types.h         |    0
> >  .../{objtool => }/arch/x86/include/asm/insn.h |    0
> >  .../arch/x86/include/asm/orc_types.h          |    0
> >  tools/{objtool => }/arch/x86/lib/inat.c       |    0
> >  tools/{objtool => }/arch/x86/lib/insn.c       |    0
> >  .../arch/x86/lib/x86-opcode-map.txt           |    0
> >  .../arch/x86/tools/gen-insn-attr-x86.awk      |    0
> >  tools/objtool/Makefile                        |    4 +-
> >  tools/objtool/arch/x86/Build                  |    4 +-
> >  tools/objtool/arch/x86/decode.c               |    4 +-
> >  tools/objtool/sync-check.sh                   |   12 +-
> >  tools/perf/.gitignore                         |    3 +
> >  tools/perf/arch/x86/tests/insn-x86.c          |    2 +-
> >  tools/perf/arch/x86/util/archinsn.c           |    2 +-
> >  tools/perf/check-headers.sh                   |   11 +-
> >  tools/perf/util/intel-pt-decoder/Build        |   22 +-
> >  .../intel-pt-decoder/gen-insn-attr-x86.awk    |  392 ------
> >  tools/perf/util/intel-pt-decoder/inat.c       |   82 --
> >  tools/perf/util/intel-pt-decoder/inat.h       |  230 ----
> >  tools/perf/util/intel-pt-decoder/inat_types.h |   15 -
> >  tools/perf/util/intel-pt-decoder/insn.c       |  593 ---------
> >  tools/perf/util/intel-pt-decoder/insn.h       |  216 ----
> >  .../intel-pt-decoder/intel-pt-insn-decoder.c  |   10 +-
> >  .../util/intel-pt-decoder/x86-opcode-map.txt  | 1072 -----------------
> >  25 files changed, 34 insertions(+), 2640 deletions(-)
> >  rename tools/{objtool => }/arch/x86/include/asm/inat.h (100%)
> >  rename tools/{objtool => }/arch/x86/include/asm/inat_types.h (100%)
> >  rename tools/{objtool => }/arch/x86/include/asm/insn.h (100%)
> >  rename tools/{objtool => }/arch/x86/include/asm/orc_types.h (100%)
> >  rename tools/{objtool => }/arch/x86/lib/inat.c (100%)
> >  rename tools/{objtool => }/arch/x86/lib/insn.c (100%)
> >  rename tools/{objtool => }/arch/x86/lib/x86-opcode-map.txt (100%)
> >  rename tools/{objtool => }/arch/x86/tools/gen-insn-attr-x86.awk (100%)
> >  delete mode 100644 tools/perf/util/intel-pt-decoder/gen-insn-attr-x86.awk
> >  delete mode 100644 tools/perf/util/intel-pt-decoder/inat.c
> >  delete mode 100644 tools/perf/util/intel-pt-decoder/inat.h
> >  delete mode 100644 tools/perf/util/intel-pt-decoder/inat_types.h
> >  delete mode 100644 tools/perf/util/intel-pt-decoder/insn.c
> >  delete mode 100644 tools/perf/util/intel-pt-decoder/insn.h
> >  delete mode 100644 tools/perf/util/intel-pt-decoder/x86-opcode-map.txt
> > 
> > -- 
> > 2.20.1
> > 
> 
> 
> -- 
> Masami Hiramatsu <mhiramat@kernel.org>

-- 

- Arnaldo

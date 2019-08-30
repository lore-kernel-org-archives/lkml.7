Return-Path: <SRS0=2mSC=W2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7A574C3A59B
	for <linux-kernel@archiver.kernel.org>; Fri, 30 Aug 2019 20:06:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4DBE02073F
	for <linux-kernel@archiver.kernel.org>; Fri, 30 Aug 2019 20:06:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NWwtRe+n"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728195AbfH3UG1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 30 Aug 2019 16:06:27 -0400
Received: from mail-qk1-f194.google.com ([209.85.222.194]:46813 "EHLO
        mail-qk1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727888AbfH3UG0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Aug 2019 16:06:26 -0400
Received: by mail-qk1-f194.google.com with SMTP id p13so7210394qkg.13
        for <linux-kernel@vger.kernel.org>; Fri, 30 Aug 2019 13:06:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=3OxXfJIUkPY0Uhe7EJj2Zo2AiiODRbZSWZ2MMuVaylA=;
        b=NWwtRe+nXj3xJ3sF5tbV1Jr1/t7Rn1MT4kXsfZvVFpHV8a1OEJbeAs8llknGLwbxPt
         IZ01dMXWkBGA1VFgR/IgcZU2Fu+3Xj6UY/lS+TejfPUENNOBYQ5n9HJgNAWQIWouqVG/
         mi8SF6V7kesCD5KKB1v/88oNDdl13AFjqJVWM2R3pbEIlky/VQFhgm3YBYN1KTwie35E
         jDDLq1xTW2rN/LKVS7/B8PRSZd6yulHmTDNQgQfsRrj8NKAp1UcdL1ocUfyKblIFfO6t
         uzJwApwGyWDBPFYrt1huDRuiH/+n9mSm1IU8AL/XPtNtJSdhhOPgD4j+SXMBZ/ecds0T
         w8vQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=3OxXfJIUkPY0Uhe7EJj2Zo2AiiODRbZSWZ2MMuVaylA=;
        b=IWEX0k1Tr5XbYP7v7mLLo6H9m3PeBhKLQvloDuIi9yJxdaW3fDxbTdaUVqZaz+8Uen
         me0lHOLnGoV0qhOKM06c7Adz7P/oqincA4MAImNTnPF1fTioD4TJF9soTWhrcq9xuqfK
         W08z1YrKXJabR24FXIsrZJjym49O5oTfdVpjiTNtK49CBJl4YbOgIrmMKz2mQ2nhLbSU
         ElXeb9UfzUZCaVszlLW79IBMyPY8/zq0JT3Xm+9K820PAa5lt1ywLBfyY0mqqHqfN+vq
         VsU94SXmSn+pkcLCIjaVAl+V7kDTYMfHs1YKUMZEZAtnqeGs2cmP95JO+VqDjwdJvgUt
         p6rQ==
X-Gm-Message-State: APjAAAUlySfqWNHsKEqo6iaWIy/oVi9OD9AcfUcm8waKb5SkTJRB2RyH
        8kH5Ijh4M59Vo0u1oW4ZNh4=
X-Google-Smtp-Source: APXvYqwJhoD7h9xkz7E13YF75TJ7FVDt3AvCX3S86rCZBTydGYZpxjuXRE3RX1DX0rW7W8ZUlBTxPg==
X-Received: by 2002:a05:620a:144d:: with SMTP id i13mr12361471qkl.197.1567195585433;
        Fri, 30 Aug 2019 13:06:25 -0700 (PDT)
Received: from quaco.ghostprotocols.net (187-26-100-20.3g.claro.net.br. [187.26.100.20])
        by smtp.gmail.com with ESMTPSA id o34sm4272055qtc.61.2019.08.30.13.06.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Aug 2019 13:06:25 -0700 (PDT)
From:   Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>
X-Google-Original-From: Arnaldo Carvalho de Melo <acme@kernel.org>
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 872EF41146; Fri, 30 Aug 2019 17:06:20 -0300 (-03)
Date:   Fri, 30 Aug 2019 17:06:20 -0300
To:     Josh Poimboeuf <jpoimboe@redhat.com>
Cc:     x86@kernel.org, linux-kernel@vger.kernel.org,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>, Jiri Olsa <jolsa@redhat.com>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Adrian Hunter <adrian.hunter@intel.com>
Subject: Re: [PATCH 4/4] perf intel-pt: Use shared x86 insn decoder
Message-ID: <20190830200620.GK28011@kernel.org>
References: <cover.1567118001.git.jpoimboe@redhat.com>
 <8a37e615d2880f039505d693d1e068a009358a2b.1567118001.git.jpoimboe@redhat.com>
 <20190830195937.GJ28011@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190830195937.GJ28011@kernel.org>
X-Url:  http://acmel.wordpress.com
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Fri, Aug 30, 2019 at 04:59:37PM -0300, Arnaldo Carvalho de Melo escreveu:
> Em Thu, Aug 29, 2019 at 05:41:21PM -0500, Josh Poimboeuf escreveu:
> > +++ b/tools/perf/util/intel-pt-decoder/Build
> > @@ -1,7 +1,7 @@
> >  perf-$(CONFIG_AUXTRACE) += intel-pt-pkt-decoder.o intel-pt-insn-decoder.o intel-pt-log.o intel-pt-decoder.o
> >  
> > -inat_tables_script = util/intel-pt-decoder/gen-insn-attr-x86.awk
> > -inat_tables_maps = util/intel-pt-decoder/x86-opcode-map.txt
> > +inat_tables_script = ../../arch/x86/tools/gen-insn-attr-x86.awk
> > +inat_tables_maps = ../../arch/x86/lib/x86-opcode-map.txt
> 
> I'm having trouble building it from:
> 
> [acme@quaco perf]$ make help | grep perf
>   perf-tar-src-pkg    - Build perf-5.3.0-rc6.tar source tarball
>   perf-targz-src-pkg  - Build perf-5.3.0-rc6.tar.gz source tarball
>   perf-tarbz2-src-pkg - Build perf-5.3.0-rc6.tar.bz2 source tarball
>   perf-tarxz-src-pkg  - Build perf-5.3.0-rc6.tar.xz source tarball
> 
> I.e. detached tarballs, outside the kernel source tree, also using O=
> 
> [acme@quaco perf]$ ls -la perf-5*
> ls: cannot access 'perf-5*': No such file or directory
> [acme@quaco perf]$ make perf-tarxz-src-pkg ; ls -la perf-5.* 
>   TAR
>   PERF_VERSION = 5.3.rc6.gc55f04097932
> -rw-rw-r--. 1 acme acme 1670016 Aug 30 16:57 perf-5.3.0-rc6.tar.xz
>   LD       /tmp/build/perf/tests/perf-in.o
>   CC       /tmp/build/perf/util/auxtrace.o
> make[5]: *** No rule to make target '../../arch/x86/tools/gen-insn-attr-x86.awk', needed by '/tmp/build/perf/util/intel-pt-decoder/inat-tables.c'.  Stop.
> make[5]: *** Waiting for unfinished jobs....

A fix, please lemme know if you're ok, so that I can fold both patches
so that we can keep it all bisect happy.

- Arnaldo

commit 423a2bf6e04aaecbeb5c2d5689cb3b832c240df0
Author: Arnaldo Carvalho de Melo <acme@redhat.com>
Date:   Fri Aug 30 17:01:58 2019 -0300

    srcdir awk
    
    Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>

diff --git a/tools/perf/util/intel-pt-decoder/Build b/tools/perf/util/intel-pt-decoder/Build
index 1530f5cfd1b8..bc629359826f 100644
--- a/tools/perf/util/intel-pt-decoder/Build
+++ b/tools/perf/util/intel-pt-decoder/Build
@@ -1,7 +1,7 @@
 perf-$(CONFIG_AUXTRACE) += intel-pt-pkt-decoder.o intel-pt-insn-decoder.o intel-pt-log.o intel-pt-decoder.o
 
-inat_tables_script = ../../arch/x86/tools/gen-insn-attr-x86.awk
-inat_tables_maps = ../../arch/x86/lib/x86-opcode-map.txt
+inat_tables_script = $(srctree)/tools/arch/x86/tools/gen-insn-attr-x86.awk
+inat_tables_maps = $(srctree)/tools/arch/x86/lib/x86-opcode-map.txt
 
 $(OUTPUT)util/intel-pt-decoder/inat-tables.c: $(inat_tables_script) $(inat_tables_maps)
 	$(call rule_mkdir)

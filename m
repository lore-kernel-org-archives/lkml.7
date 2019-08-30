Return-Path: <SRS0=2mSC=W2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9AEF0C3A59B
	for <linux-kernel@archiver.kernel.org>; Fri, 30 Aug 2019 20:10:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7820523439
	for <linux-kernel@archiver.kernel.org>; Fri, 30 Aug 2019 20:10:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728271AbfH3UK2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 30 Aug 2019 16:10:28 -0400
Received: from mx1.redhat.com ([209.132.183.28]:33270 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728079AbfH3UK1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Aug 2019 16:10:27 -0400
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 4B81410C6983;
        Fri, 30 Aug 2019 20:10:27 +0000 (UTC)
Received: from treble (ovpn-123-26.rdu2.redhat.com [10.10.123.26])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id C23D919C58;
        Fri, 30 Aug 2019 20:10:23 +0000 (UTC)
Date:   Fri, 30 Aug 2019 15:10:21 -0500
From:   Josh Poimboeuf <jpoimboe@redhat.com>
To:     Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>
Cc:     x86@kernel.org, linux-kernel@vger.kernel.org,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>, Jiri Olsa <jolsa@redhat.com>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Adrian Hunter <adrian.hunter@intel.com>
Subject: Re: [PATCH 4/4] perf intel-pt: Use shared x86 insn decoder
Message-ID: <20190830201021.utzjr6cs5hoxygyi@treble>
References: <cover.1567118001.git.jpoimboe@redhat.com>
 <8a37e615d2880f039505d693d1e068a009358a2b.1567118001.git.jpoimboe@redhat.com>
 <20190830195937.GJ28011@kernel.org>
 <20190830200620.GK28011@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190830200620.GK28011@kernel.org>
User-Agent: NeoMutt/20180716
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.6.2 (mx1.redhat.com [10.5.110.65]); Fri, 30 Aug 2019 20:10:27 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> A fix, please lemme know if you're ok, so that I can fold both patches
> so that we can keep it all bisect happy.
> 
> - Arnaldo
> 
> commit 423a2bf6e04aaecbeb5c2d5689cb3b832c240df0
> Author: Arnaldo Carvalho de Melo <acme@redhat.com>
> Date:   Fri Aug 30 17:01:58 2019 -0300
> 
>     srcdir awk
>     
>     Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
> 
> diff --git a/tools/perf/util/intel-pt-decoder/Build b/tools/perf/util/intel-pt-decoder/Build
> index 1530f5cfd1b8..bc629359826f 100644
> --- a/tools/perf/util/intel-pt-decoder/Build
> +++ b/tools/perf/util/intel-pt-decoder/Build
> @@ -1,7 +1,7 @@
>  perf-$(CONFIG_AUXTRACE) += intel-pt-pkt-decoder.o intel-pt-insn-decoder.o intel-pt-log.o intel-pt-decoder.o
>  
> -inat_tables_script = ../../arch/x86/tools/gen-insn-attr-x86.awk
> -inat_tables_maps = ../../arch/x86/lib/x86-opcode-map.txt
> +inat_tables_script = $(srctree)/tools/arch/x86/tools/gen-insn-attr-x86.awk
> +inat_tables_maps = $(srctree)/tools/arch/x86/lib/x86-opcode-map.txt
>  
>  $(OUTPUT)util/intel-pt-decoder/inat-tables.c: $(inat_tables_script) $(inat_tables_maps)
>  	$(call rule_mkdir)

Looks good to me.  Thanks for fixing these!

-- 
Josh

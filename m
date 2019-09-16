Return-Path: <SRS0=w+Kb=XL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E4FD4C49ED7
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Sep 2019 19:18:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B8081206C2
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Sep 2019 19:18:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390853AbfIPTSl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 16 Sep 2019 15:18:41 -0400
Received: from mx1.redhat.com ([209.132.183.28]:54264 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1733190AbfIPTSk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Sep 2019 15:18:40 -0400
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id A19858E584;
        Mon, 16 Sep 2019 19:18:40 +0000 (UTC)
Received: from treble (ovpn-120-32.rdu2.redhat.com [10.10.120.32])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id EB77819C4F;
        Mon, 16 Sep 2019 19:18:38 +0000 (UTC)
Date:   Mon, 16 Sep 2019 14:18:36 -0500
From:   Josh Poimboeuf <jpoimboe@redhat.com>
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] objdump: restore quiet build output
Message-ID: <20190916191836.4jwbndzivivejftg@treble>
References: <20190910092031.2897823-1-arnd@arndb.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190910092031.2897823-1-arnd@arndb.de>
User-Agent: NeoMutt/20180716
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.28]); Mon, 16 Sep 2019 19:18:40 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 10, 2019 at 11:20:24AM +0200, Arnd Bergmann wrote:
> After a recent sync-check.sh update, a 'make -s' build prints a
> single line of output from the 'cd -' command:
> 
>     /git/linux/tools/objtool
> 
> This is clearly unintended, so revert back to a completely quiet
> build by redirecting the cd output to /dev/null.
> 
> Fixes: 2ffd84ae973b ("objtool: Update sync-check.sh from perf's check-headers.sh")
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> ---
>  tools/objtool/sync-check.sh | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/tools/objtool/sync-check.sh b/tools/objtool/sync-check.sh
> index 0a832e265a50..94b8d76c2851 100755
> --- a/tools/objtool/sync-check.sh
> +++ b/tools/objtool/sync-check.sh
> @@ -48,4 +48,4 @@ check arch/x86/include/asm/insn.h     '-I "^#include [\"<]\(asm/\)*inat.h[\">]"'
>  check arch/x86/lib/inat.c             '-I "^#include [\"<]\(../include/\)*asm/insn.h[\">]"'
>  check arch/x86/lib/insn.c             '-I "^#include [\"<]\(../include/\)*asm/in\(at\|sn\).h[\">]"'
>  
> -cd -
> +cd - > /dev/null
> -- 
> 2.20.0
> 

Arnaldo, do you want to pick this one up?

Acked-by: Josh Poimboeuf <jpoimboe@redhat.com>

-- 
Josh

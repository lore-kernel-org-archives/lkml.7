Return-Path: <SRS0=7o0M=UP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 29D1AC31E49
	for <linux-kernel@archiver.kernel.org>; Sun, 16 Jun 2019 09:46:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EFFBF2147A
	for <linux-kernel@archiver.kernel.org>; Sun, 16 Jun 2019 09:46:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726495AbfFPJqV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 16 Jun 2019 05:46:21 -0400
Received: from mx1.redhat.com ([209.132.183.28]:57540 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725888AbfFPJqU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 16 Jun 2019 05:46:20 -0400
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 8CAA33688E;
        Sun, 16 Jun 2019 09:46:20 +0000 (UTC)
Received: from krava (ovpn-204-53.brq.redhat.com [10.40.204.53])
        by smtp.corp.redhat.com (Postfix) with SMTP id 394701001DDE;
        Sun, 16 Jun 2019 09:46:09 +0000 (UTC)
Date:   Sun, 16 Jun 2019 11:46:05 +0200
From:   Jiri Olsa <jolsa@redhat.com>
To:     Florian Fainelli <f.fainelli@gmail.com>
Cc:     linux-kernel@vger.kernel.org,
        bcm-kernel-feedback-list@broadcom.com,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Alexey Budankov <alexey.budankov@linux.intel.com>,
        Quentin Monnet <quentin.monnet@netronome.com>,
        Stanislav Fomichev <sdf@google.com>,
        Jakub Kicinski <jakub.kicinski@netronome.com>
Subject: Re: [PATCH] perf: Don't hardcode host include path for libslang
Message-ID: <20190616094605.GB2500@krava>
References: <20190614183949.5588-1-f.fainelli@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190614183949.5588-1-f.fainelli@gmail.com>
User-Agent: Mutt/1.11.4 (2019-03-13)
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.30]); Sun, 16 Jun 2019 09:46:20 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 14, 2019 at 11:39:47AM -0700, Florian Fainelli wrote:
> Hardcoding /usr/include/slang is fundamentally incompatible with cross
> compilation and will lead to the inability for a cross-compiled
> environment to properly detect whether slang is available or not.
> 
> If /usr/include/slang is necessary that is a distribution specific
> knowledge that could be solved with either a standard pkg-config .pc
> file (which slang has) or simply overriding CFLAGS accordingly, but the
> default perf Makefile should be clean of all of that.

fedora 30 is ok with this, I guess acme's distro test will
tell us about the rest ;-)

jirka

> 
> Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>
> ---
>  tools/build/feature/Makefile | 2 +-
>  tools/perf/Makefile.config   | 1 -
>  2 files changed, 1 insertion(+), 2 deletions(-)
> 
> diff --git a/tools/build/feature/Makefile b/tools/build/feature/Makefile
> index 4b8244ee65ce..f9432d21eff9 100644
> --- a/tools/build/feature/Makefile
> +++ b/tools/build/feature/Makefile
> @@ -181,7 +181,7 @@ $(OUTPUT)test-libaudit.bin:
>  	$(BUILD) -laudit
>  
>  $(OUTPUT)test-libslang.bin:
> -	$(BUILD) -I/usr/include/slang -lslang
> +	$(BUILD) -lslang
>  
>  $(OUTPUT)test-libcrypto.bin:
>  	$(BUILD) -lcrypto
> diff --git a/tools/perf/Makefile.config b/tools/perf/Makefile.config
> index 85fbcd265351..b11134fdf59f 100644
> --- a/tools/perf/Makefile.config
> +++ b/tools/perf/Makefile.config
> @@ -641,7 +641,6 @@ ifndef NO_SLANG
>      NO_SLANG := 1
>    else
>      # Fedora has /usr/include/slang/slang.h, but ubuntu /usr/include/slang.h
> -    CFLAGS += -I/usr/include/slang
>      CFLAGS += -DHAVE_SLANG_SUPPORT
>      EXTLIBS += -lslang
>      $(call detected,CONFIG_SLANG)
> -- 
> 2.17.1
> 

Return-Path: <SRS0=2uMJ=VL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 86AD9C73C66
	for <linux-kernel@archiver.kernel.org>; Sun, 14 Jul 2019 15:40:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5B8C720820
	for <linux-kernel@archiver.kernel.org>; Sun, 14 Jul 2019 15:40:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728370AbfGNPkJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 14 Jul 2019 11:40:09 -0400
Received: from mx1.redhat.com ([209.132.183.28]:43590 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728095AbfGNPkJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 14 Jul 2019 11:40:09 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 8D17A3084288;
        Sun, 14 Jul 2019 15:40:08 +0000 (UTC)
Received: from krava (ovpn-204-80.brq.redhat.com [10.40.204.80])
        by smtp.corp.redhat.com (Postfix) with SMTP id 75A345D772;
        Sun, 14 Jul 2019 15:40:07 +0000 (UTC)
Date:   Sun, 14 Jul 2019 17:40:06 +0200
From:   Jiri Olsa <jolsa@redhat.com>
To:     "Joel Fernandes (Google)" <joel@joelfernandes.org>
Cc:     linux-kernel@vger.kernel.org, acme@kernel.org,
        Jiri Olsa <jolsa@kernel.org>
Subject: Re: [RFC] Fix python feature detection
Message-ID: <20190714154006.GB16802@krava>
References: <20190707144417.237913-1-joel@joelfernandes.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190707144417.237913-1-joel@joelfernandes.org>
User-Agent: Mutt/1.12.0 (2019-05-25)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.40]); Sun, 14 Jul 2019 15:40:08 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jul 07, 2019 at 10:44:17AM -0400, Joel Fernandes (Google) wrote:
> I am having a hard time building BPF samples by doing a make in
> samples/bpf. While I am debugging that, I ran into the Python issue.
> Even though the system has libpython2.7-dev:
> 
> If I just do a 'make' inside tools/build/feature/ I get:
> Python.h: No such file or directory

because you don't have FLAGS_PYTHON_EMBED set?

> 
> This led me to this patch which fixes Python feature detection for me.
> I am not sure if it is the right fix for Python since it is hardcoded
> for Python version 2, but I thought it could be useful.

we detect python in tools/perf/Makefile.config and
set FLAGS_PYTHON_EMBED properly

it's supposed to be set by a project using tools/build
for feature detection.. what are you building? AFAICS
samples/bpf do not use tools/build

jirka

> 
> My system is a Debian buster release.
> 
> Cc: acme@kernel.org
> Cc: jolsa@redhat.com
> Signed-off-by: Joel Fernandes (Google) <joel@joelfernandes.org>
> ---
>  tools/build/feature/Makefile | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/tools/build/feature/Makefile b/tools/build/feature/Makefile
> index 4b8244ee65ce..cde44cb38a5e 100644
> --- a/tools/build/feature/Makefile
> +++ b/tools/build/feature/Makefile
> @@ -83,7 +83,7 @@ __BUILDXX = $(CXX) $(CXXFLAGS) -MD -Wall -Werror -o $@ $(patsubst %.bin,%.cpp,$(
>  ###############################
>  
>  $(OUTPUT)test-all.bin:
> -	$(BUILD) -fstack-protector-all -O2 -D_FORTIFY_SOURCE=2 -ldw -lelf -lnuma -lelf -laudit -I/usr/include/slang -lslang $(shell $(PKG_CONFIG) --libs --cflags gtk+-2.0 2>/dev/null) $(FLAGS_PERL_EMBED) $(FLAGS_PYTHON_EMBED) -DPACKAGE='"perf"' -lbfd -ldl -lz -llzma
> +	$(BUILD) -fstack-protector-all -O2 -D_FORTIFY_SOURCE=2 -ldw -lelf -lnuma -lelf -laudit -I/usr/include/slang -lslang $(shell $(PKG_CONFIG) --libs --cflags gtk+-2.0 2>/dev/null) $(shell $(PKG_CONFIG) --libs --cflags python2 2>/dev/null) $(FLAGS_PERL_EMBED) $(FLAGS_PYTHON_EMBED) -DPACKAGE='"perf"' -lbfd -ldl -lz -llzma
>  
>  $(OUTPUT)test-hello.bin:
>  	$(BUILD)
> @@ -205,7 +205,7 @@ $(OUTPUT)test-libperl.bin:
>  	$(BUILD) $(FLAGS_PERL_EMBED)
>  
>  $(OUTPUT)test-libpython.bin:
> -	$(BUILD) $(FLAGS_PYTHON_EMBED)
> +	$(BUILD) $(shell $(PKG_CONFIG) --libs --cflags python2 2>/dev/null) $(FLAGS_PYTHON_EMBED)
>  
>  $(OUTPUT)test-libpython-version.bin:
>  	$(BUILD)
> -- 
> 2.22.0.410.gd8fdbe21b5-goog
> 

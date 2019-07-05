Return-Path: <SRS0=fBTF=VC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C865DC4649B
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Jul 2019 14:54:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9D26C21738
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Jul 2019 14:54:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bvr2dtBM"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727326AbfGEOyl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 5 Jul 2019 10:54:41 -0400
Received: from mail-qk1-f194.google.com ([209.85.222.194]:35506 "EHLO
        mail-qk1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725837AbfGEOyk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Jul 2019 10:54:40 -0400
Received: by mail-qk1-f194.google.com with SMTP id r21so7790348qke.2
        for <linux-kernel@vger.kernel.org>; Fri, 05 Jul 2019 07:54:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=lwEfFFPPH+LKrX/l1YmHucKffvgoDyWRRe5matIpm/o=;
        b=bvr2dtBMr5vmUmFXMm9KW63hXuzVRcpjxXVMdU2XXGUFywmc4LQwxyYj0wYAtull2p
         RoIZtR8b/wis9OLGCq43QTO1DhDm1xHIKMTyL7muIPAUQzxdKAu6axRajHVwin3Lmkxd
         zd5AueCz5v89FwpU8kvJKttXyEc1GSB453m0n2VvlN+nbVY7cMVF9FSlrIXZGKLheqzp
         i4n7XY5ZsR7ybiM02xamL4aKP1jW6JZsvJPKxcuMEXulCF0b55aXmGmN74ui+DevGsLV
         Tj8J8l+NIA0nPwLsZ7QTFdo+8rADlIXFOPKmynW3UN4+9drWTY/ctDDy46Ig4xbh+ALL
         JVSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=lwEfFFPPH+LKrX/l1YmHucKffvgoDyWRRe5matIpm/o=;
        b=XvUv1EuDWEF8PI+0ZcVsY9t/UiaSEQ7WWeP76ykLUomjEGCC1xo7b2II7YKhWB8ynp
         fHYg3k37Qia2aavLIjpV5Mj+EJY7dT+Lge09C9aKApl0Une3L4vN+Yt6l05MwsoRltdZ
         aCw7v/Og/kiAFe5zSLn4Jrry0HMoj+NFTh/lQQAUxTFdh780Xfc+VmKosHX2xroTQ6tC
         /jLvo4Z+dinSOzsAXVd24VRvfLmmdDXQ4FXn8W/eL5jbgDwKX0L7O+X4DIrRdbY/s867
         Ew3Zo7TOUAzoar7RBy4QVg2hjFy0n5CC+C8997b0lyYALw8/I7pcNcWxSXk0hET5RX5n
         Liwg==
X-Gm-Message-State: APjAAAU/ZZuOGjFTp48XEukDl0iKV4KD2lvMLQ2Ho89oIakG/GUatups
        uMdDVQKxAG3fCTE8DzI7Yhg=
X-Google-Smtp-Source: APXvYqxkcfPq6fgrJTiykZ9xRAfLLQbqBRy6n41BC3HpGgFj6tPcWENe6GwPWsW8rl6Rh0PWPp8IVQ==
X-Received: by 2002:ae9:ed4b:: with SMTP id c72mr3296236qkg.404.1562338479447;
        Fri, 05 Jul 2019 07:54:39 -0700 (PDT)
Received: from quaco.ghostprotocols.net ([179.97.35.11])
        by smtp.gmail.com with ESMTPSA id z19sm346207qkg.28.2019.07.05.07.54.38
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Fri, 05 Jul 2019 07:54:38 -0700 (PDT)
From:   Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>
X-Google-Original-From: Arnaldo Carvalho de Melo <acme@kernel.org>
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 25F0540495; Fri,  5 Jul 2019 11:54:36 -0300 (-03)
Date:   Fri, 5 Jul 2019 11:54:36 -0300
To:     Raphael Gault <raphael.gault@arm.com>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        mingo@redhat.com, peterz@infradead.org, catalin.marinas@arm.com,
        will.deacon@arm.com, mark.rutland@arm.com
Subject: Re: [PATCH v2 1/5] perf: arm64: Add test to check userspace access
 to hardware counters.
Message-ID: <20190705145436.GA29396@kernel.org>
References: <20190705085541.9356-1-raphael.gault@arm.com>
 <20190705085541.9356-2-raphael.gault@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190705085541.9356-2-raphael.gault@arm.com>
X-Url:  http://acmel.wordpress.com
User-Agent: Mutt/1.12.0 (2019-05-25)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Fri, Jul 05, 2019 at 09:55:37AM +0100, Raphael Gault escreveu:
> This test relies on the fact that the PMU registers are accessible
> from userspace. It then uses the perf_event_mmap_page to retrieve
> the counter index and access the underlying register.
> 
> This test uses sched_setaffinity(2) in order to run on all CPU and thus
> check the behaviour of the PMU of all cpus in a big.LITTLE environment.
> 
> Signed-off-by: Raphael Gault <raphael.gault@arm.com>
> ---
>  tools/perf/arch/arm64/include/arch-tests.h |   6 +
>  tools/perf/arch/arm64/tests/Build          |   1 +
>  tools/perf/arch/arm64/tests/arch-tests.c   |   4 +
>  tools/perf/arch/arm64/tests/user-events.c  | 255 +++++++++++++++++++++
>  4 files changed, 266 insertions(+)
>  create mode 100644 tools/perf/arch/arm64/tests/user-events.c
> 
> diff --git a/tools/perf/arch/arm64/include/arch-tests.h b/tools/perf/arch/arm64/include/arch-tests.h
> index 90ec4c8cb880..a9b17ae0560b 100644
> --- a/tools/perf/arch/arm64/include/arch-tests.h
> +++ b/tools/perf/arch/arm64/include/arch-tests.h
> @@ -2,11 +2,17 @@
>  #ifndef ARCH_TESTS_H
>  #define ARCH_TESTS_H
>  
> +#define __maybe_unused	__attribute__((unused))


What is wrong with using:

#include <linux/compiler.h>

?

[acme@quaco perf]$ find tools/perf/ -name "*.[ch]" | xargs grep __maybe_unused | wc -l
1115
[acme@quaco perf]$ grep __maybe_unused tools/include/linux/compiler.h
#ifndef __maybe_unused
# define __maybe_unused		__attribute__((unused))
[acme@quaco perf]$

Also please don't break strings in multiple lines just to comply with
the 80 column limit. That is ok when you have multiple lines ending with
a newline, but otherwise just makes it look ugly.

- Arnaldo

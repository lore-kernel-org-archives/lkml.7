Return-Path: <SRS0=c+yg=TC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.5 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C1156C43219
	for <linux-kernel@archiver.kernel.org>; Thu,  2 May 2019 14:36:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7D75320652
	for <linux-kernel@archiver.kernel.org>; Thu,  2 May 2019 14:36:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hdvPcYfM"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726372AbfEBOgX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 May 2019 10:36:23 -0400
Received: from mail-yw1-f67.google.com ([209.85.161.67]:46852 "EHLO
        mail-yw1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726197AbfEBOgW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 May 2019 10:36:22 -0400
Received: by mail-yw1-f67.google.com with SMTP id v15so1694995ywe.13;
        Thu, 02 May 2019 07:36:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=kB2jz2u+F6Q0PrHO/rPXXO1DBKOlGlVPQ5PtRrKLBRU=;
        b=hdvPcYfM7okLZlk99hAf5q86Wcmg2dBie6sIJAzC/4d4worv95OD50EX+5DSPCLcnH
         gFESpXSrFqGTdj3/55F5bJUMv1/halwkLCOFJtssjEP7JRfz66PzBYQoEtRv+jBd3ZF4
         TTPj+MMmUvIiuCorxF188NZmgattobSc/zr8wpN/WkACroTrQMMxMGGLJ2M6ShIOQmFi
         EaBuTaW5+dD8h4WhA9Wk73+J01yq2OKfSh2+6NJ3yV3pHOrl1+ikgQwA/Ef93zy8XRrh
         9a+Y1eczafCFH8krQMAcRhZUmHAX53BrxTuuveIaQBktiMCRKBZJJSZZMfqHlRpSjYT4
         wBbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=kB2jz2u+F6Q0PrHO/rPXXO1DBKOlGlVPQ5PtRrKLBRU=;
        b=Edm62LcsEfRGzjC/5W4Cxpur86QiEmkvNMcS1z0uHBzcCM1xNAtN0kzIO2+7lOqpLr
         DBr8uZDvTxM11FtNKtKoDlPdyzKwK08gQpODcnXISnfMeychwdQd9gwiiw3pPdKktOup
         LWxwbNwfjWvQmsK5O6QvXbiqC2DU3zz6TrXp9GlLaB3WyYbSPTbWiw5po/SwKenKzzi4
         i4ohLUHSZzpbI8j4wrzDVAAA1lEaioZgD7SsbRAt6ur83ZC2m66o0nNNlZA0kEQ4mtq6
         WBsbL0u4Eqw+TCNW6eF0CZsZ8Fi+C2rQMMy5BB5rsLuRRkngD+mmjOb5/XtTNHuWhKkz
         gmkA==
X-Gm-Message-State: APjAAAUCsb9JGrnv7mGaqQNDUdNNT4iPXqZ7Rh+k/cEwH9ncoUy8IbX1
        vOBKDzhCaG9GOJxTC4CPJDI=
X-Google-Smtp-Source: APXvYqysMXSSiIHCqYNISToKilZfyS/F0wyKwqaCYD9iL9SVAl6HIW9TIAZuV06hUQltAP6YiD2SQQ==
X-Received: by 2002:a25:81cd:: with SMTP id n13mr3498430ybm.293.1556807781364;
        Thu, 02 May 2019 07:36:21 -0700 (PDT)
Received: from quaco.ghostprotocols.net (adsl-173-228-226-134.prtc.net. [173.228.226.134])
        by smtp.gmail.com with ESMTPSA id z206sm13761532ywa.20.2019.05.02.07.36.19
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 02 May 2019 07:36:19 -0700 (PDT)
From:   Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>
X-Google-Original-From: Arnaldo Carvalho de Melo <acme@kernel.org>
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id F174F4111F; Thu,  2 May 2019 10:36:18 -0400 (EDT)
Date:   Thu, 2 May 2019 10:36:18 -0400
To:     Vineet Gupta <Vineet.Gupta1@synopsys.com>
Cc:     Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>,
        Arnd Bergmann <arnd@arndb.de>, Rich Felker <dalias@libc.org>,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        lkml <linux-kernel@vger.kernel.org>,
        "linux-perf-users@vger.kernel.org" <linux-perf-users@vger.kernel.org>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        arcml <linux-snps-arc@lists.infradead.org>
Subject: Re: perf tools build broken after v5.1-rc1
Message-ID: <20190502143618.GH21436@kernel.org>
References: <eeb83498-f37f-e234-4941-2731b81dc78c@synopsys.com>
 <20190422152027.GB11750@kernel.org>
 <C2D7FE5348E1B147BCA15975FBA2307501A250584C@us01wembx1.internal.synopsys.com>
 <CAK8P3a2JrAApXDws+t=q8AnKFkHJZSox7gsgwW-xEJTfs_mdzw@mail.gmail.com>
 <20190501204115.GF21436@kernel.org>
 <C2D7FE5348E1B147BCA15975FBA2307501A2506BF3@us01wembx1.internal.synopsys.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <C2D7FE5348E1B147BCA15975FBA2307501A2506BF3@us01wembx1.internal.synopsys.com>
X-Url:  http://acmel.wordpress.com
User-Agent: Mutt/1.11.3 (2019-02-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Wed, May 01, 2019 at 09:17:52PM +0000, Vineet Gupta escreveu:
> On 5/1/19 1:41 PM, Arnaldo Carvalho de Melo wrote:
> >> The 1a787fc5ba18ac7 commit copied over the changes for arm64, but
> >> missed all the other architectures changed in c8ce48f06503 and the
> >> related commits.
> > Right, I have a patch copying the missing headers, and that fixed the
> > build with the glibc-based toolchain, but then broke the uCLibc one :-\
 
> tools/perf/util/cloexec.c  #includes <sys/syscall.h> which for glibc includes
> asm/unistd.h
 
> uClibc <sys/syscall.h> OTOH #include <bits/sysnum.h> containign#define __NR_*
> (generated by parsing kernel's unistd). This header does the right thing by
> chekcing for redefs, but in the end we still collide with newly added
> tools/arc/arc/*/**/unistd.h which doesn't have conditional definitions. I'm sure
> this is not an ARC problem, any uClibc build would be affected. Do you have a arm
> uclibc toolchain to test ?

This solves it for fedora:29,
arc_gnu_2017.09-rc2_prebuilt_uclibc_le_arc700_linux_install,
arc_gnu_2019.03-rc1_prebuilt_uclibc_le_archs_linux_install and
arc_gnu_2019.03-rc1_prebuilt_glibc_le_archs_linux_install.

Also ok with:

  make -C tools/perf build-test

Now build testing with the full set of containers.

- Arnaldo

commit 1931594a680dba28e98b526192dd065430c850c0
Author: Arnaldo Carvalho de Melo <acme@redhat.com>
Date:   Thu May 2 09:26:23 2019 -0400

    perf tools: Remove needless asm/unistd.h include fixing build in some places
    
    We were including sys/syscall.h and asm/unistd.h, since sys/syscall.h
    includes asm/unistd.h, sometimes this leads to the redefinition of
    defines, breaking the build.
    
    Noticed on ARC with uCLibc.
    
    Cc: Adrian Hunter <adrian.hunter@intel.com>
    Cc: Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>
    Cc: Arnd Bergmann <arnd@arndb.de>
    Cc: Jiri Olsa <jolsa@kernel.org>
    Cc: Namhyung Kim <namhyung@kernel.org>
    Cc: Rich Felker <dalias@libc.org>
    Cc: Vineet Gupta <Vineet.Gupta1@synopsys.com>
    Link: https://lkml.kernel.org/n/tip-xjpf80o64i2ko74aj2jih0qg@git.kernel.org
    Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>

diff --git a/tools/perf/util/cloexec.c b/tools/perf/util/cloexec.c
index ca0fff6272be..06f48312c5ed 100644
--- a/tools/perf/util/cloexec.c
+++ b/tools/perf/util/cloexec.c
@@ -7,7 +7,6 @@
 #include "asm/bug.h"
 #include "debug.h"
 #include <unistd.h>
-#include <asm/unistd.h>
 #include <sys/syscall.h>
 
 static unsigned long flag = PERF_FLAG_FD_CLOEXEC;

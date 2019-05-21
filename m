Return-Path: <SRS0=9PYC=TV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 70F22C04AAF
	for <linux-kernel@archiver.kernel.org>; Tue, 21 May 2019 13:28:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 428EF2173C
	for <linux-kernel@archiver.kernel.org>; Tue, 21 May 2019 13:28:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="C4OYf+iJ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728449AbfEUN2w (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 21 May 2019 09:28:52 -0400
Received: from mail-qk1-f195.google.com ([209.85.222.195]:35979 "EHLO
        mail-qk1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728045AbfEUN2v (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 May 2019 09:28:51 -0400
Received: by mail-qk1-f195.google.com with SMTP id c14so11041554qke.3
        for <linux-kernel@vger.kernel.org>; Tue, 21 May 2019 06:28:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=cvvOQE23MwdFnUZeKL2gbjCzqL3FWxm72jrOP4dw27c=;
        b=C4OYf+iJYkz3nPxU1Ucd7ro+3tXceXoYuWDEukvbB8WML7GWvsSqAvR2hCcesl4kLb
         ADvMyFCOo3Y44d+Bo3B3vb2FaZ4cRU1JNGRnNjHgIG42JLIWft7ndbqpU2CSVFL/Xj5P
         /QZzX+Mqrh1gAyerbY70T/L+Za3lye4ks0CFrr8SHqSJScFuzXg0xPYBeD5nRiygFgfd
         yX0UYM3PJ86Hy06kfu2CrBqRpkqM1UgNVS2VoYLoJGwu76/afH/iNUwngn2q25ZzHsRJ
         z83FzgfaN+5GT+9vTHA7ss5xdlmyYRY+H7+SaQ5I4DUidbOweNXO/W6Zpf+LBWYAtJKb
         KbWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=cvvOQE23MwdFnUZeKL2gbjCzqL3FWxm72jrOP4dw27c=;
        b=aTZWh7I2ColIRqn64o+htAZb54l9JZiaHUqG6KxNchm4c2n27F8WijSCiMHuWAL3PS
         eHYzfBXGlgHYzWUF71mkhn7OdkTlTvHQ63sMm0M3UN/AvP15xtg+gTHxXRhbK1tqx1TT
         krD5QRcmrG9mFXiik809X0ofArF1Smws9XWOU5Amw4k/m65nKz+tQreZ+L66s4tVUezA
         uQ7t/JeQ7avRnPfdBHlHOJzfO9OMK+Q8Ri7CXb6sG8Bp25U+7nE9Pz0yYcRjWz4Za8Nv
         XtpJ0fFAj4kW6IqVzLOuuEifH85m8ASTnYQQTUll+mlEVC7CznEYIclXvtEpWjLAvvFu
         Nrlw==
X-Gm-Message-State: APjAAAXszhQaZ0n44PYE8CdLsW++igmxYcRusiOsALvCztyzn3eqsS9X
        wWMqjuE98ipibATXswcrUq0=
X-Google-Smtp-Source: APXvYqwDnfz226jOrtJBd0bC8BawGSJzb9m+9TVxmsHrZ0B9wq0YgRc6/wZnJDIXOCQFmMqsUYII/g==
X-Received: by 2002:ae9:e642:: with SMTP id x2mr32611140qkl.181.1558445330702;
        Tue, 21 May 2019 06:28:50 -0700 (PDT)
Received: from quaco.ghostprotocols.net ([179.97.35.11])
        by smtp.gmail.com with ESMTPSA id j5sm9833203qtb.30.2019.05.21.06.28.47
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Tue, 21 May 2019 06:28:50 -0700 (PDT)
From:   Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>
X-Google-Original-From: Arnaldo Carvalho de Melo <acme@kernel.org>
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id C6117404A1; Tue, 21 May 2019 10:28:38 -0300 (-03)
Date:   Tue, 21 May 2019 10:28:38 -0300
To:     Vitaly Chikunov <vt@altlinux.org>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>, linux-kernel@vger.kernel.org,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Hendrik Brueckner <brueckner@linux.ibm.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Kim Phillips <kim.phillips@arm.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Ravi Bangoria <ravi.bangoria@linux.vnet.ibm.com>
Subject: Re: [PATCH] perf arm64: Fix mksyscalltbl when system kernel headers
 are ahead of the kernel
Message-ID: <20190521132838.GB26253@kernel.org>
References: <20190521030203.1447-1-vt@altlinux.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190521030203.1447-1-vt@altlinux.org>
X-Url:  http://acmel.wordpress.com
User-Agent: Mutt/1.11.3 (2019-02-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Tue, May 21, 2019 at 06:02:03AM +0300, Vitaly Chikunov escreveu:
> When a host system has kernel headers that are newer than a compiling
> kernel, mksyscalltbl fails with errors such as:
> 
>   <stdin>: In function 'main':
>   <stdin>:271:44: error: '__NR_kexec_file_load' undeclared (first use in this function)
>   <stdin>:271:44: note: each undeclared identifier is reported only once for each function it appears in
>   <stdin>:272:46: error: '__NR_pidfd_send_signal' undeclared (first use in this function)
>   <stdin>:273:43: error: '__NR_io_uring_setup' undeclared (first use in this function)
>   <stdin>:274:43: error: '__NR_io_uring_enter' undeclared (first use in this function)
>   <stdin>:275:46: error: '__NR_io_uring_register' undeclared (first use in this function)
>   tools/perf/arch/arm64/entry/syscalls//mksyscalltbl: line 48: /tmp/create-table-xvUQdD: Permission denied
> 
> mksyscalltbl is compiled with default host includes, but run with

It shouldn't :-\ So with this you're making it use the ones shipped in
tools/include? Good, I'll test it, thanks!

- Arnaldo

> compiling kernel tree includes, causing some syscall numbers being
> undeclared.
> 
> Signed-off-by: Vitaly Chikunov <vt@altlinux.org>
> Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
> Cc: Arnaldo Carvalho de Melo <acme@kernel.org>
> Cc: Hendrik Brueckner <brueckner@linux.ibm.com>
> Cc: Ingo Molnar <mingo@redhat.com>
> Cc: Jiri Olsa <jolsa@redhat.com>
> Cc: Kim Phillips <kim.phillips@arm.com>
> Cc: Namhyung Kim <namhyung@kernel.org>
> Cc: Peter Zijlstra <peterz@infradead.org>
> Cc: Ravi Bangoria <ravi.bangoria@linux.vnet.ibm.com>
> ---
>  tools/perf/arch/arm64/entry/syscalls/mksyscalltbl | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/tools/perf/arch/arm64/entry/syscalls/mksyscalltbl b/tools/perf/arch/arm64/entry/syscalls/mksyscalltbl
> index c88fd32563eb..459469b7222c 100755
> --- a/tools/perf/arch/arm64/entry/syscalls/mksyscalltbl
> +++ b/tools/perf/arch/arm64/entry/syscalls/mksyscalltbl
> @@ -56,7 +56,7 @@ create_table()
>  	echo "};"
>  }
>  
> -$gcc -E -dM -x c  $input	       \
> +$gcc -E -dM -x c -I $incpath/include/uapi $input \
>  	|sed -ne 's/^#define __NR_//p' \
>  	|sort -t' ' -k2 -nu	       \
>  	|create_table
> -- 
> 2.11.0

-- 

- Arnaldo

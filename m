Return-Path: <SRS0=uyI7=RK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1375CC10F03
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Mar 2019 23:26:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D41CE2085A
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Mar 2019 23:26:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=fomichev-me.20150623.gappssmtp.com header.i=@fomichev-me.20150623.gappssmtp.com header.b="fOx0sap2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726386AbfCGX0e (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 Mar 2019 18:26:34 -0500
Received: from mail-pf1-f195.google.com ([209.85.210.195]:34445 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726242AbfCGX0e (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Mar 2019 18:26:34 -0500
Received: by mail-pf1-f195.google.com with SMTP id u9so12651692pfn.1
        for <linux-kernel@vger.kernel.org>; Thu, 07 Mar 2019 15:26:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fomichev-me.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=s7cJRMc5KalDw+jgFBJx4Iw1WPTiJ8GUlpiEplESzz8=;
        b=fOx0sap2a/XNmLnTxYU5WTDKqg6FGqSAIw9cPN8nkEqxTqAxiZKDWfFzecWGiu5wt+
         LAJ4UEHEVLIVwpwvTvA+bPb0jtDD+J2VqQgiou44DdHZL6zgnuD3lQW9LH+eAartcr6Q
         hX1fuZvQ48Nbzs1mVpssiBrOK7j0YrUilel2mOmWzZd5aLqp2cLv6YK7fYnSWeNfBcj/
         beHCFT9QosmBa9nr1zVNiclNZ28qxUJhpBIQXBxdtglqOZ5Z1wtleFSAFhiuS8HfzC7q
         fZB51QxDi3alZF+kW1teqbq+nZw3AoOgK1t6DCGu6CoBEp5WPROm4wD1W5Gr5kcoHXh9
         8FkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=s7cJRMc5KalDw+jgFBJx4Iw1WPTiJ8GUlpiEplESzz8=;
        b=Su1u19jTbFKT1E6yHNvTw086H/TLSfHJbm2bNKrgdMOcBtfKiTW5DbaouaSLHzStqb
         AfwkG4QVhCP5OjKo+NszWOBVrrvHngK+HC9nuJy+0QG6j+SsMUjO0UDbsFw2xh8uFcx5
         tGri0dfP+9Qfb7h95UfQwMFZTDMIaTD5RHoUWz7nMGO5a27Y5i5cAVlFeFm8dEz4ZPJq
         /UTSPbiAjZz7JG/+dE+1q+wPEuVl12kFxplzBQpRv03fb01Zvul1BhLHiRd28FP0wXZJ
         hxIe8n4f9chmnM/E8imDwVUr1wWCHHoAUATbsj8tizmbV4c7H7RfVQJpjIQraDiIYPe0
         EGHg==
X-Gm-Message-State: APjAAAXxGjU9SfQO1SeMpjsx9tutMnYMiRjaJwVdQoqKHLDtAnq/h4zL
        hc8P5dixTDnoc4q6mZSy3HVjEw==
X-Google-Smtp-Source: APXvYqz72lYudIr5rK49mN+94KBfqJXlrbnZPy6hSG7AFNOkN1jApFV0sNyW3JjowB6U4HePfiz75g==
X-Received: by 2002:a17:902:834b:: with SMTP id z11mr15667426pln.257.1552001192959;
        Thu, 07 Mar 2019 15:26:32 -0800 (PST)
Received: from localhost ([2601:646:8f00:18d9:d0fa:7a4b:764f:de48])
        by smtp.gmail.com with ESMTPSA id a1sm9034196pfn.26.2019.03.07.15.26.31
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 07 Mar 2019 15:26:32 -0800 (PST)
Date:   Thu, 7 Mar 2019 15:26:31 -0800
From:   Stanislav Fomichev <sdf@fomichev.me>
To:     Song Liu <songliubraving@fb.com>
Cc:     bpf@vger.kernel.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, ast@kernel.org, daniel@iogearbox.net,
        kernel-team@fb.com, peterz@infradead.org, acme@redhat.com,
        jolsa@kernel.org, namhyung@kernel.org
Subject: Re: [PATCH v7 perf,bpf 11/15] perf: add -lopcodes to feature-libbfd
Message-ID: <20190307232631.GA5481@mini-arch.hsd1.ca.comcast.net>
References: <20190307175810.249857-1-songliubraving@fb.com>
 <20190307175810.249857-12-songliubraving@fb.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190307175810.249857-12-songliubraving@fb.com>
User-Agent: Mutt/1.11.3 (2019-02-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 03/07, Song Liu wrote:
> Both libbfd and libopcodes are distributed with binutil-dev/devel. When
> libbfd presents, it is OK to assume libopcodes also presents. This has
> been a safe assumption for bpftool.
> 
> This patch adds -lopcodes to perf/Makefile.config. libopcodes will be
> used in the next commit for bpf annotation.
> 
> Signed-off-by: Song Liu <songliubraving@fb.com>
> ---
>  tools/perf/Makefile.config | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/tools/perf/Makefile.config b/tools/perf/Makefile.config
> index b441c88cafa1..e0bafbc273af 100644
> --- a/tools/perf/Makefile.config
> +++ b/tools/perf/Makefile.config
> @@ -701,7 +701,7 @@ else
>  endif
>  
>  ifeq ($(feature-libbfd), 1)
> -  EXTLIBS += -lbfd
> +  EXTLIBS += -lbfd -lopcodes
I think you need to add -lopcodes to the other feature checks as
well (to work on the systems which require -liberty and/or -lz for
libfd):

--

diff --git a/tools/perf/Makefile.config b/tools/perf/Makefile.config
index b441c88cafa1..3fa2f5d7d54f 100644
--- a/tools/perf/Makefile.config
+++ b/tools/perf/Makefile.config
@@ -701,7 +701,7 @@ else
 endif
 
 ifeq ($(feature-libbfd), 1)
-  EXTLIBS += -lbfd
+  EXTLIBS += -lbfd -lopcodes
 else
   # we are on a system that requires -liberty and (maybe) -lz
   # to link against -lbfd; test each case individually here
@@ -712,10 +712,10 @@ else
   $(call feature_check,libbfd-liberty-z)
 
   ifeq ($(feature-libbfd-liberty), 1)
-    EXTLIBS += -lbfd -liberty
+    EXTLIBS += -lbfd -lopcodes -liberty
   else
     ifeq ($(feature-libbfd-liberty-z), 1)
-      EXTLIBS += -lbfd -liberty -lz
+      EXTLIBS += -lbfd -lopcodes -liberty -lz
     endif
   endif
 endif

>  else
>    # we are on a system that requires -liberty and (maybe) -lz
>    # to link against -lbfd; test each case individually here
> -- 
> 2.17.1
> 

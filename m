Return-Path: <SRS0=6OEZ=YL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2CA4DCA9EA0
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Oct 2019 18:08:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0167420869
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Oct 2019 18:08:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="sWU3T83Y"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2505785AbfJRSIB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 18 Oct 2019 14:08:01 -0400
Received: from mail-qk1-f194.google.com ([209.85.222.194]:35439 "EHLO
        mail-qk1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2634544AbfJRSHr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Oct 2019 14:07:47 -0400
Received: by mail-qk1-f194.google.com with SMTP id w2so6146107qkf.2
        for <linux-kernel@vger.kernel.org>; Fri, 18 Oct 2019 11:07:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=ph1gsWl8b+KE0jxl78060VBvyBbktI0ey+ejee4Ra+M=;
        b=sWU3T83YtwtKbPCpz47RAxEs8mvbBVd81ozmTNKEGnuqYPCvpcU6Wsi09Xt8hKO1LJ
         wPSEdxn3BwM2jceEQeOiwf9GxDfM/rEYKy/rjEOpJFh/lk0uDkQF/ZxvXnPIilVHnizv
         hzM5CTAO3dSkXjLBnkHNJCmK+izfW3yUhdVOWtZJX7LWTk4CW9svOUyu6qB+6V/DM/x+
         uZ3Ru6M7nxLbVoJ7BscjR7u1KTmxWmdtYM6rreQJPXc3RvAT/RjDOnLDE0q7jAf3vVfB
         q9NfOjJzGubVGVMGQ7C4rb1FWiWPtnXU73xsbJ7ESI58l9oX0lJ5dab3228Fer5osrBu
         a5SA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=ph1gsWl8b+KE0jxl78060VBvyBbktI0ey+ejee4Ra+M=;
        b=MQP+qkR68Eb7vVG+oXPwE13tDLBygHwbDAmNd5vngewicSnUWcj6TjmGLij2mhfQEZ
         9anOdDhx1seRcSn3/isT4LQEV31CYTQURWgA8niYBDR92ZMw4DrPMYznAGWoXyPUL/zP
         euzaNyZA9P0uUbq0ueZXlagvi7Zao2KIB75odRJ0NE853dUDXvmSgb9f+ir75kwbyAP7
         i/VJJMFUxb1Qxh4G0cWuLMgrnEQu1f3/zIfmMyrw9sWI686pcQBvYOSi5N+ILoxpxwMm
         MUx+fFrjNGj8/UHhHbpHpHn5N0sMliJtUf1X88ZP3/4ULQVjCIGIUNe/DPw3Z7lHYv+z
         U2Gg==
X-Gm-Message-State: APjAAAVDo7IemSmfVpylxOrh23McuTM1t7REBPDI+3/IdKRW43qwavqV
        F0nR94XKA9md92bw3qvyFpw=
X-Google-Smtp-Source: APXvYqwO6jVQPXxC22MlgfbIb12hr47Prv/SXLJuhkT6R3SEbKaWgxTVpTQYicMzs+Gni7aJLdrTRw==
X-Received: by 2002:a37:85c5:: with SMTP id h188mr2708920qkd.191.1571422065884;
        Fri, 18 Oct 2019 11:07:45 -0700 (PDT)
Received: from quaco.ghostprotocols.net (179-240-170-47.3g.claro.net.br. [179.240.170.47])
        by smtp.gmail.com with ESMTPSA id i66sm3049654qkb.105.2019.10.18.11.07.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Oct 2019 11:07:43 -0700 (PDT)
From:   Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>
X-Google-Original-From: Arnaldo Carvalho de Melo <acme@kernel.org>
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 8818A4DD66; Fri, 18 Oct 2019 15:07:38 -0300 (-03)
Date:   Fri, 18 Oct 2019 15:07:38 -0300
To:     Jiri Olsa <jolsa@kernel.org>
Cc:     lkml <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Michael Petlan <mpetlan@redhat.com>,
        Andi Kleen <ak@linux.intel.com>,
        Stephane Eranian <eranian@google.com>,
        Jin Yao <yao.jin@linux.intel.com>,
        Alexey Budankov <alexey.budankov@linux.intel.com>
Subject: Re: [PATCH 05/10] libperf: Add _GNU_SOURCE define to compilation
Message-ID: <20191018180738.GD1797@kernel.org>
References: <20191017105918.20873-1-jolsa@kernel.org>
 <20191017105918.20873-6-jolsa@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191017105918.20873-6-jolsa@kernel.org>
X-Url:  http://acmel.wordpress.com
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Why?


Em Thu, Oct 17, 2019 at 12:59:13PM +0200, Jiri Olsa escreveu:
> Link: http://lkml.kernel.org/n/tip-m7t1e9kgea4jc3piyvjju7ps@git.kernel.org
> Signed-off-by: Jiri Olsa <jolsa@kernel.org>
> ---
>  tools/perf/lib/Makefile       | 1 +
>  tools/perf/lib/tests/Makefile | 2 ++
>  2 files changed, 3 insertions(+)
> 
> diff --git a/tools/perf/lib/Makefile b/tools/perf/lib/Makefile
> index 0f233638ef1f..20396f68fcad 100644
> --- a/tools/perf/lib/Makefile
> +++ b/tools/perf/lib/Makefile
> @@ -73,6 +73,7 @@ override CFLAGS += -Werror -Wall
>  override CFLAGS += -fPIC
>  override CFLAGS += $(INCLUDES)
>  override CFLAGS += -fvisibility=hidden
> +override CFLAGS += -D_GNU_SOURCE
>  
>  all:
>  
> diff --git a/tools/perf/lib/tests/Makefile b/tools/perf/lib/tests/Makefile
> index a43cd08c5c03..78c3d8c83c53 100644
> --- a/tools/perf/lib/tests/Makefile
> +++ b/tools/perf/lib/tests/Makefile
> @@ -12,6 +12,8 @@ else
>    CFLAGS := -g -Wall
>  endif
>  
> +CFLAGS += -D_GNU_SOURCE
> +
>  all:
>  
>  include $(srctree)/tools/scripts/Makefile.include
> -- 
> 2.21.0

-- 

- Arnaldo

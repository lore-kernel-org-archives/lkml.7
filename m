Return-Path: <SRS0=EKka=XV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8B437C4360C
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Sep 2019 15:18:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5C5D621D56
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Sep 2019 15:18:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kph4ir4a"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727285AbfIZPSR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 26 Sep 2019 11:18:17 -0400
Received: from mail-qt1-f195.google.com ([209.85.160.195]:37778 "EHLO
        mail-qt1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726030AbfIZPSR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Sep 2019 11:18:17 -0400
Received: by mail-qt1-f195.google.com with SMTP id l3so3328829qtr.4
        for <linux-kernel@vger.kernel.org>; Thu, 26 Sep 2019 08:18:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=mkhsT+Dv1BprTt8ZlYgxb9uMbxLlzxbohGERNOR0kNk=;
        b=kph4ir4a3ZaENqN5OP2awiN9cXxsY5aMpOGdTI9N1gkjhCYHqtOjZUiDL+pLvf+eZW
         ZvrsGuULCAghaEiPZpoEXWuFsMU6tEYe0vwLV95p3ArzORP4D9Geb8W//aEOS2GIzKbS
         vRdHD0jPu9erBuV2m7I67PKoGFXp/0VqazruZ6D3uqlOK39yJpalXmLcj29EohAZn1P2
         jGds3pGZUgDmXWL3Hij3FPwB5vAWClGnXHO+EwIkNKlKBXl8Izcg9WyJ+g33JFZnCt97
         CpL+WR3z7G0dhSyrO1Kyet+7CoYRy3unCZ5enZrgIKAEItirHvCnlXtEJvtYN1awr+Qa
         AqIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=mkhsT+Dv1BprTt8ZlYgxb9uMbxLlzxbohGERNOR0kNk=;
        b=IZG+8/KvouOJRFfsV8mPhQPJPNgOcg7f4j9U//1fsSlc+IfYSkoa1q96psrsUwX3GT
         FZCYupf6e9CWr+pVFxnzJzf8SpCRr0v572ze5ihP8k5D7mDHNL3dUOLDgXz7xhLBO0id
         tK8CD71xhO3iWqpHQADSMaiIu0r8V2F3c7EZX/q6BQ7sT0egFiFx9zchItodzUclbcpB
         QTZ8adG0cvGjmbu3Z0RVrKEJyVnjaKDPj9fxQaSZmT1KZgZWfvCFmqMJbf4yiiGMt+Ty
         AxZfX26YlqBCtvW3oHv0DcoQbYFK2lzwsbAxiPHU0bbtobX9uZWNG2uJNxqhSHY+W95h
         YtSg==
X-Gm-Message-State: APjAAAUg3gYgCVjANaNJCbQr6xEKB/4FZf4oQqUlto/kqRD2z6JXIAuT
        e/2rk6fOt5Casm/uarxP+iQ=
X-Google-Smtp-Source: APXvYqzlr6NNYpXchcfNBAWV7+mW/HjA1Fti9BRmUqO7c7cFthVXuHgoRuNfwtZK4I49/CTKqZq+xg==
X-Received: by 2002:ad4:42af:: with SMTP id e15mr3119141qvr.186.1569511096247;
        Thu, 26 Sep 2019 08:18:16 -0700 (PDT)
Received: from quaco.ghostprotocols.net ([179.97.35.50])
        by smtp.gmail.com with ESMTPSA id j4sm1197938qkf.116.2019.09.26.08.18.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Sep 2019 08:18:14 -0700 (PDT)
From:   Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>
X-Google-Original-From: Arnaldo Carvalho de Melo <acme@kernel.org>
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 1D75D40396; Thu, 26 Sep 2019 12:18:13 -0300 (-03)
Date:   Thu, 26 Sep 2019 12:18:13 -0300
To:     Ian Rogers <irogers@google.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Andi Kleen <ak@linux.intel.com>, linux-kernel@vger.kernel.org,
        Stephane Eranian <eranian@google.com>,
        Josh Poimboeuf <jpoimboe@redhat.com>
Subject: Re: [PATCH 1/2] Make _FORTIFY_SOURCE defines dependent on the feature
Message-ID: <20190926151813.GC10129@kernel.org>
References: <20190925195924.152834-1-irogers@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190925195924.152834-1-irogers@google.com>
X-Url:  http://acmel.wordpress.com
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Wed, Sep 25, 2019 at 12:59:23PM -0700, Ian Rogers escreveu:
> Unconditionally defining _FORTIFY_SOURCE can break tools that don't work
> with it, such as memory sanitizers:
> https://github.com/google/sanitizers/wiki/AddressSanitizer#faq

Thanks, and added this:

Cc: Josh Poimboeuf <jpoimboe@redhat.com>
Fixes: 4b6ab94eabe4 ("perf subcmd: Create subcmd library")
 
> Signed-off-by: Ian Rogers <irogers@google.com>
> ---
>  tools/lib/subcmd/Makefile | 8 +++++++-
>  1 file changed, 7 insertions(+), 1 deletion(-)
> 
> diff --git a/tools/lib/subcmd/Makefile b/tools/lib/subcmd/Makefile
> index ed61fb3a46c0..5b2cd5e58df0 100644
> --- a/tools/lib/subcmd/Makefile
> +++ b/tools/lib/subcmd/Makefile
> @@ -20,7 +20,13 @@ MAKEFLAGS += --no-print-directory
>  LIBFILE = $(OUTPUT)libsubcmd.a
>  
>  CFLAGS := $(EXTRA_WARNINGS) $(EXTRA_CFLAGS)
> -CFLAGS += -ggdb3 -Wall -Wextra -std=gnu99 -U_FORTIFY_SOURCE -D_FORTIFY_SOURCE=2 -fPIC
> +CFLAGS += -ggdb3 -Wall -Wextra -std=gnu99 -fPIC
> +
> +ifeq ($(DEBUG),0)
> +  ifeq ($(feature-fortify-source), 1)
> +    CFLAGS += -U_FORTIFY_SOURCE -D_FORTIFY_SOURCE=2
> +  endif
> +endif
>  
>  ifeq ($(CC_NO_CLANG), 0)
>    CFLAGS += -O3
> -- 
> 2.23.0.351.gc4317032e6-goog

-- 

- Arnaldo

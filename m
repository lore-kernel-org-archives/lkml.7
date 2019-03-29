Return-Path: <SRS0=SA5R=SA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7558FC43381
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Mar 2019 14:24:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 45A832173C
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Mar 2019 14:24:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=joelfernandes.org header.i=@joelfernandes.org header.b="BYg4mQrn"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729206AbfC2OYa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 29 Mar 2019 10:24:30 -0400
Received: from mail-pl1-f194.google.com ([209.85.214.194]:33283 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728630AbfC2OY3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Mar 2019 10:24:29 -0400
Received: by mail-pl1-f194.google.com with SMTP id bg8so1133108plb.0
        for <linux-kernel@vger.kernel.org>; Fri, 29 Mar 2019 07:24:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=Cr6+Hgz8ti+JffVYStJyezXO/1XywriRHSV9PBDVcoE=;
        b=BYg4mQrnMOC0SjSueGeE+mPJ0GPtCzjTqHlcNyqLiORXMCW28bQoYmL74Id+J5BzQu
         o/JB2L/mfSITGFDmKP/nS6jIJohfvKioATI8WnFelsRMQfVQmokWE6Wg2Wzjao0KJZfo
         ZG5+C7a+oV2gzoGm0MGFmFEs1n4PFe1fZIsK4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=Cr6+Hgz8ti+JffVYStJyezXO/1XywriRHSV9PBDVcoE=;
        b=AUjBo0Fo+J8Iv9zbbOwHVAmIG2alNbGkwPjVbFksilsQN12X26HHxxooZLWnCahXCR
         OZf1fpeJNOg8WwQ4zgR7U89AQRYouzLV/HA1q77Ey23FV3Np4sUpubqFO5UwwdTg43RI
         374Qq3y+e4SiRb4xDpbBDCIPJD4eCnu4moPJmhtLglR39qiFZa+PhRJ9zKIbtL9rQPXQ
         o5CcRl8XbiyBFkX0NZsxbkrdzgR4n1plcZL1pxDWqV9iThrf4j5ER60J6IzI5TnE28B8
         loLSqP2Z8etUr7FDzht0bRncHiaq8AjKHRaRAuSSqAZkqybf0rruIefD7YVjT+95VQeY
         rsNw==
X-Gm-Message-State: APjAAAWE0n0mVhA/+wu7fZ6l07dOX6g7jFMcchlOfOaqJ5MAMJY+N2uw
        YDS+eMX6r3FU2guKwsHPCWi2MQ==
X-Google-Smtp-Source: APXvYqyRi0MqRL+gt9n/oVLbnnxxvCCtRvNbgkOqE6Do6K1obODqt45/lBqBU5RzzE9LRRqS20yHAA==
X-Received: by 2002:a17:902:7d81:: with SMTP id a1mr41819141plm.202.1553869468943;
        Fri, 29 Mar 2019 07:24:28 -0700 (PDT)
Received: from localhost ([2620:15c:6:12:9c46:e0da:efbf:69cc])
        by smtp.gmail.com with ESMTPSA id c18sm8839160pfc.0.2019.03.29.07.24.27
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 29 Mar 2019 07:24:28 -0700 (PDT)
Date:   Fri, 29 Mar 2019 10:24:26 -0400
From:   Joel Fernandes <joel@joelfernandes.org>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Clark Williams <williams@redhat.com>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [PATCH 05/13] tools headers uapi: Sync linux/fcntl.h to get the
 F_SEAL_FUTURE_WRITE addition
Message-ID: <20190329142426.GA122290@google.com>
References: <20190329133801.21004-1-acme@kernel.org>
 <20190329133801.21004-6-acme@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190329133801.21004-6-acme@kernel.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 29, 2019 at 10:37:53AM -0300, Arnaldo Carvalho de Melo wrote:
> From: Arnaldo Carvalho de Melo <acme@redhat.com>
> 
> To get the changes in:
> 
>   ab3948f58ff8 ("mm/memfd: add an F_SEAL_FUTURE_WRITE seal to memfd")
> 
> And silence this perf build warning:
> 
>   Warning: Kernel ABI header at 'tools/include/uapi/linux/fcntl.h' differs from latest version at 'include/uapi/linux/fcntl.h'
>   diff -u tools/include/uapi/linux/fcntl.h include/uapi/linux/fcntl.h
> 
> Cc: Adrian Hunter <adrian.hunter@intel.com>
> Cc: Jiri Olsa <jolsa@kernel.org>
> Cc: Joel Fernandes (Google) <joel@joelfernandes.org>
> Cc: Linus Torvalds <torvalds@linux-foundation.org>
> Cc: Namhyung Kim <namhyung@kernel.org>
> Link: https://lkml.kernel.org/n/tip-lvfx5cgf0xzmdi9mcjva1ttl@git.kernel.org
> Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>

Acked-by: Joel Fernandes (Google) <joel@joelfernandes.org>

thanks!

 - Joel

> ---
>  tools/include/uapi/linux/fcntl.h | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/tools/include/uapi/linux/fcntl.h b/tools/include/uapi/linux/fcntl.h
> index 6448cdd9a350..a2f8658f1c55 100644
> --- a/tools/include/uapi/linux/fcntl.h
> +++ b/tools/include/uapi/linux/fcntl.h
> @@ -41,6 +41,7 @@
>  #define F_SEAL_SHRINK	0x0002	/* prevent file from shrinking */
>  #define F_SEAL_GROW	0x0004	/* prevent file from growing */
>  #define F_SEAL_WRITE	0x0008	/* prevent writes */
> +#define F_SEAL_FUTURE_WRITE	0x0010  /* prevent future writes while mapped */
>  /* (1U << 31) is reserved for signed error codes */
>  
>  /*
> -- 
> 2.20.1
> 

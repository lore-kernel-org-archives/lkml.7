Return-Path: <SRS0=/WLL=WS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNWANTED_LANGUAGE_BODY,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8F36AC3A5A1
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Aug 2019 14:13:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5FD8121743
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Aug 2019 14:13:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bJ21gx7B"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387553AbfHVONy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 22 Aug 2019 10:13:54 -0400
Received: from mail-qt1-f196.google.com ([209.85.160.196]:33166 "EHLO
        mail-qt1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731416AbfHVONx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Aug 2019 10:13:53 -0400
Received: by mail-qt1-f196.google.com with SMTP id v38so7881375qtb.0
        for <linux-kernel@vger.kernel.org>; Thu, 22 Aug 2019 07:13:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=ah8qsrNWQ2a1VAqzZswTu8dPxggXMPo2COVvsIyEDvc=;
        b=bJ21gx7BvS2BKdlqCQ9Dsg36I0ZfnczeK80rKMB6pu2bJBcpZzO3oTJ45xGe654Re7
         8tg3wA4Qja1CIO9QrmytkPQECNlhU3lm1gOO0qf0M+pKFNTaXtvMtlEtPdrQ+n8B7cC0
         vI4RtrdRt93QYFW9WQhRD48xiamI/vRINo+CbMn96d7SI2XWZu1Z7jpXo6C6IOFO7/GW
         b8qlKaemkfYUWrOEVQdP0UgAEYnUWw+X4C0tWw9MPNUPk4MiJULDhiOYtV+Aru35xlRa
         jyj8JlS5ixmA/Wc1YmbIxRywTFM70n8hbO0dg/6HOxSaIavqHGLksh3OYdLhMBVD+KUs
         Jc0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=ah8qsrNWQ2a1VAqzZswTu8dPxggXMPo2COVvsIyEDvc=;
        b=IkwU/xaqxaNXVwr/N86PJpvL1mLz8JTXIfmLy9WURH5Iydxcl1EfpGtyDdrFdauHKw
         3XyLpQ0xEtT29Ah5eCf6k9p40yG7dafCPWAq8wFje/Vdfrs+04o7xal4YkVnUP7sTmpB
         1fDG9tnz0fVSE+IGxD/vSqalbBQLOXiw8YOgQpQFMzBAeMBNxjfRJjRSNdfVIR/F3m1Q
         2rHgQe8UqDgksZc7Pleo0RBACFgsc45RVz1+vUosqnKuf3Gwx+xkyVrACZ2+aysb5tHw
         6v7pLfdmLIQww2fPG6Qd6Aq8bBgUMGpgQkVtWYfHb2zacJSU9w6MnVYwxF85C8/+lxPZ
         xzJA==
X-Gm-Message-State: APjAAAWX5ouyzIbpirbfoI7ppncLSqfTxB0YC9DeVB/aIipX8JL9N+14
        SV/DaAvvVC2XFz/wvk66zg0=
X-Google-Smtp-Source: APXvYqwY2Qgnue8NFJOE93PlMlyY1ecvEkZV7kEMEBJou61m2HSJjvZD35qhwHjztrphmEpKEI0D1A==
X-Received: by 2002:aed:2d67:: with SMTP id h94mr35734801qtd.154.1566483232632;
        Thu, 22 Aug 2019 07:13:52 -0700 (PDT)
Received: from quaco.ghostprotocols.net ([179.97.35.50])
        by smtp.gmail.com with ESMTPSA id m194sm11605024qke.123.2019.08.22.07.13.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Aug 2019 07:13:51 -0700 (PDT)
From:   Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>
X-Google-Original-From: Arnaldo Carvalho de Melo <acme@kernel.org>
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id D248240340; Thu, 22 Aug 2019 11:13:48 -0300 (-03)
Date:   Thu, 22 Aug 2019 11:13:48 -0300
To:     Jiri Olsa <jolsa@kernel.org>
Cc:     lkml <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Michael Petlan <mpetlan@redhat.com>
Subject: Re: [PATCH 1/5] tools: Add missing perf_event.h include
Message-ID: <20190822141348.GA29569@kernel.org>
References: <20190822111141.25823-1-jolsa@kernel.org>
 <20190822111141.25823-2-jolsa@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190822111141.25823-2-jolsa@kernel.org>
X-Url:  http://acmel.wordpress.com
User-Agent: Mutt/1.12.0 (2019-05-25)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Thu, Aug 22, 2019 at 01:11:37PM +0200, Jiri Olsa escreveu:
> We need perf_event.h include for 'struct perf_event_mmap_page'.
> 
> Link: http://lkml.kernel.org/n/tip-bolqkmqajexhccjb0ib0an8w@git.kernel.org

Thanks, applied.

- Arnaldo

> Signed-off-by: Jiri Olsa <jolsa@kernel.org>
> ---
>  tools/include/linux/ring_buffer.h | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/tools/include/linux/ring_buffer.h b/tools/include/linux/ring_buffer.h
> index 9a083ae60473..6c02617377c2 100644
> --- a/tools/include/linux/ring_buffer.h
> +++ b/tools/include/linux/ring_buffer.h
> @@ -2,6 +2,7 @@
>  #define _TOOLS_LINUX_RING_BUFFER_H_
>  
>  #include <asm/barrier.h>
> +#include <linux/perf_event.h>
>  
>  /*
>   * Contract with kernel for walking the perf ring buffer from
> -- 
> 2.21.0

-- 

- Arnaldo

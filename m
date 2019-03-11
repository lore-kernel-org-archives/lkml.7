Return-Path: <SRS0=FxTY=RO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 45950C43381
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Mar 2019 20:33:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0E7212087C
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Mar 2019 20:33:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="keHDOb05"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728020AbfCKUdI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Mar 2019 16:33:08 -0400
Received: from mail-qk1-f196.google.com ([209.85.222.196]:45871 "EHLO
        mail-qk1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726675AbfCKUdI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Mar 2019 16:33:08 -0400
Received: by mail-qk1-f196.google.com with SMTP id z76so91256qkb.12;
        Mon, 11 Mar 2019 13:33:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=C4J8mq3az5sF9WMkjs/a8MHl/W1ZrLx/37ck5BZlRio=;
        b=keHDOb052KsujBzpWvDBXJjpEz85u/wDtSLQfSULqYuTeQxBVp+UQpboR7hbesht9t
         sW8aaHTHchcdckD2S0iCR/pRULRUGW5llIUz2610Ro3JjQqilOsLNsn0Qd9v4dObZffs
         ycuAofQWOsSu73h21dU0MndTC1MPJDnNHssROpHzFBnImOn4yecqiCM7U5z0zfd37DOu
         nFHc75aXTI7emU8F2gzhNnT2NHINbekeUhqwXamKS6keNNT4u6iqDpZpM1G23gvnc7hX
         XYkwY4mmnIj2ld/HP8phDoDO5xXU3fVp6D/VtUX7WZFMTriBCQP1jV0xjYcRFwJUrZDc
         gNAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=C4J8mq3az5sF9WMkjs/a8MHl/W1ZrLx/37ck5BZlRio=;
        b=a+MFI7c+98w6H+Nzz9xPUX/nW7jM8xXo9WAV9/PTg9O3+GEJmfyHLDiZ/L58s6219z
         3OX9CbTYUwp+w6g3DHxudOMVnY41J+qY+edHp69j7Xz16TuDqctEBHdmbPj7wsBoLNCx
         K3ZgitFHHJ3FYzC705gTx/yotQfMjfHTqzsLN/IfMJFPHPmLGJRIAmgjt6LQ0XaIbDXH
         CtB/BNYtK4VcX6jKrAVLvbpNZPU6achyQljm7Ur3dbz90ymvgKscNWy3jh+QPRYgJvmV
         CxX46JmwLQHfts6DNYvJURUJCU0Wg7Q/26lazohpQsrM7dBf0ec8xX4E4nRWv1GYjEVY
         mg+A==
X-Gm-Message-State: APjAAAVZwahN2A9agyduhzHWBeAjEStJI6ku6ZC1+vPFIta4P1Q2bpH/
        zT3wGfueLAlBCrrkEKHYpkw=
X-Google-Smtp-Source: APXvYqx7ajR/X9r3MNmjsn2f9qPa4N6x9vPT+INCzGLNL93a8l4x/RzQ+YBJPJkUl+TdDsxhJH1qTw==
X-Received: by 2002:a37:508a:: with SMTP id e132mr25540293qkb.347.1552336386761;
        Mon, 11 Mar 2019 13:33:06 -0700 (PDT)
Received: from quaco.ghostprotocols.net (177.206.235.230.dynamic.adsl.gvt.net.br. [177.206.235.230])
        by smtp.gmail.com with ESMTPSA id u25sm3876899qkj.96.2019.03.11.13.33.05
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 11 Mar 2019 13:33:05 -0700 (PDT)
From:   Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>
X-Google-Original-From: Arnaldo Carvalho de Melo <acme@kernel.org>
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 2D6154039C; Mon, 11 Mar 2019 17:33:02 -0300 (-03)
Date:   Mon, 11 Mar 2019 17:33:02 -0300
To:     Andi Kleen <andi@firstfloor.org>
Cc:     jolsa@kernel.org, linux-perf-users@vger.kernel.org,
        linux-kernel@vger.kernel.org, Andi Kleen <ak@linux.intel.com>
Subject: Re: [PATCH v1 06/10] perf, tools, report: Print better message for
 JITed code
Message-ID: <20190311203302.GB10690@kernel.org>
References: <20190311202446.10210-1-andi@firstfloor.org>
 <20190311202446.10210-7-andi@firstfloor.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190311202446.10210-7-andi@firstfloor.org>
X-Url:  http://acmel.wordpress.com
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Mon, Mar 11, 2019 at 01:24:42PM -0700, Andi Kleen escreveu:
> From: Andi Kleen <ak@linux.intel.com>
> 
> The message about missing /tmp/perf-* for JITed code is quite confusing
> to users. Add a better error message, but only print it once.
> 
> Signed-off-by: Andi Kleen <ak@linux.intel.com>
> ---
>  tools/perf/util/map.c | 9 +++++++++
>  1 file changed, 9 insertions(+)
> 
> diff --git a/tools/perf/util/map.c b/tools/perf/util/map.c
> index fbeb0c6efaa6..d476b76abc6a 100644
> --- a/tools/perf/util/map.c
> +++ b/tools/perf/util/map.c
> @@ -316,6 +316,15 @@ int map__load(struct map *map)
>  
>  	nr = dso__load(map->dso, map);
>  	if (nr < 0) {
> +		if (!strncmp(map->dso->name, "/tmp/perf-", 10)) {
> +			static bool warned;
> +			if (!warned) {
> +				pr_err("Cannot find executable, JITed code present? May need agent.\n");
> +				warned = true;
> +			}

Please use WARN_ON_ONCE(), we have it in tools/include/asm/bug.h, just
like the kernel.

> +			return -1;
> +		}
> +
>  		if (map->dso->has_build_id) {
>  			char sbuild_id[SBUILD_ID_SIZE];
>  
> -- 
> 2.20.1

-- 

- Arnaldo

Return-Path: <SRS0=rUXN=XZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BC48AC32792
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Sep 2019 10:50:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8CA7B206BB
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Sep 2019 10:50:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lb51xANn"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730819AbfI3Ku0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 30 Sep 2019 06:50:26 -0400
Received: from mail-qk1-f194.google.com ([209.85.222.194]:46303 "EHLO
        mail-qk1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729870AbfI3Ku0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Sep 2019 06:50:26 -0400
Received: by mail-qk1-f194.google.com with SMTP id 201so7269912qkd.13
        for <linux-kernel@vger.kernel.org>; Mon, 30 Sep 2019 03:50:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=eb/OD0+6kl6InPN48kdKyyt3Gl5DHdDbUpre2gx/ub8=;
        b=lb51xANnjO9r1cPtu4SXv42EwBy6ggxalzx1tjYFaEn8flT7hAbcDn0wOzcs99FfDk
         6MqDlQs7Xtgtv97FDunjvbOq/y5bGijVG7mmN9RTlEOygmqlN0ow1hONEzvwrEmiwA3o
         J9o3i/3/BzQPKkiv+Rdt+GxcBWX2GXuCw++uc1xI4wDdnYDvRUk13uJOFWdMDWIPB7WD
         5L/LUyuLcI/6I/HlT2vxsp2HQKebNH2To+Ib35CgIRa/eqpW7sUSba7X0V0piW3c/A9R
         jfZ1ohqEt5wCaTSiG/m3oa3upfrErOp53eAACRxA7JsUQQoPXDHpa0AIfV+NclyHQcEO
         QDyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=eb/OD0+6kl6InPN48kdKyyt3Gl5DHdDbUpre2gx/ub8=;
        b=h0WfuRgY33BwXkXTgj9Cks2MVUX0wM+jHxtfPokgUJoI7SOM8yGNAtFK6QkQvkpMKy
         /6f5DgrQgKUP5GqCHyL7QTU2J5NGQcY5Zrg+rxgYpJxkzMLCQL7ytUyO5F4WODqQAfsM
         Jmn381QB3EAgIEtZjwiGUwHvVcagBGZ303CMzkW39cQUyT3QesMdqWuz/X8EAWQeFPcB
         SaTNcdgPLi/cy5hD2+uZbKSUhRlLf/JQZ7TEWXyHUb+WW/99L9Pic0FO/heFpGw5GwIB
         xYYyt7C3nsMu9HkldJd4Y7oCAMW+UZxW2q9k3P55Dc6Q9D9X4NlCm9UQSMqhpJabsVGe
         Bf5Q==
X-Gm-Message-State: APjAAAVO6rH5Kcob0ry9R8KSSnFrBse6GdPieh2MeGaO5QXtvxPApcUy
        mEi0h3RN+JzFwTSeWVKMkCEP8LnC
X-Google-Smtp-Source: APXvYqyGisMj8iz1T0Cr9MFJbTF5p+qLmRxPizM/S1s8cHgsabJFd7K0RwQo0WLAMeB4BRpm3pn4xA==
X-Received: by 2002:a37:4802:: with SMTP id v2mr18089079qka.496.1569840625589;
        Mon, 30 Sep 2019 03:50:25 -0700 (PDT)
Received: from quaco.ghostprotocols.net ([179.97.35.50])
        by smtp.gmail.com with ESMTPSA id x59sm6754687qte.20.2019.09.30.03.50.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Sep 2019 03:50:24 -0700 (PDT)
From:   Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>
X-Google-Original-From: Arnaldo Carvalho de Melo <acme@kernel.org>
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 14A7440396; Mon, 30 Sep 2019 07:50:23 -0300 (-03)
Date:   Mon, 30 Sep 2019 07:50:23 -0300
To:     Andi Kleen <andi@firstfloor.org>
Cc:     jolsa@kernel.org, linux-kernel@vger.kernel.org,
        Andi Kleen <ak@linux.intel.com>
Subject: Re: [PATCH 1/3] perf script brstackinsn: Fix recovery from
 LBR/binary mismatch
Message-ID: <20190930105023.GD9622@kernel.org>
References: <20190927233546.11533-1-andi@firstfloor.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190927233546.11533-1-andi@firstfloor.org>
X-Url:  http://acmel.wordpress.com
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Fri, Sep 27, 2019 at 04:35:44PM -0700, Andi Kleen escreveu:
> From: Andi Kleen <ak@linux.intel.com>
> 
> When the LBR data and the instructions in a binary do not match the
> loop printing instructions could get confused and print a long
> stream of bogus <bad> instructions.
> 
> The problem was that if the instruction decoder cannot decode an
> instruction it ilen wasn't initialized, so the loop going through
> the basic block would continue with the previous value.
> 
> Harden the code to avoid such problems:
> - Make sure ilen is always freshly initialized and is 0 for bad
> instructions.
> - Do not overrun the code buffer while printing instructions
> - Print a warning message if the final jump is not on an
> instruction boundary.

Thanks, applied.

- Arnaldo
 
> Signed-off-by: Andi Kleen <ak@linux.intel.com>
> ---
>  tools/perf/builtin-script.c | 6 +++++-
>  1 file changed, 5 insertions(+), 1 deletion(-)
> 
> diff --git a/tools/perf/builtin-script.c b/tools/perf/builtin-script.c
> index e079b34201f2..32b17d51c982 100644
> --- a/tools/perf/builtin-script.c
> +++ b/tools/perf/builtin-script.c
> @@ -1061,7 +1061,7 @@ static int perf_sample__fprintf_brstackinsn(struct perf_sample *sample,
>  			continue;
>  
>  		insn = 0;
> -		for (off = 0;; off += ilen) {
> +		for (off = 0; off < (unsigned)len; off += ilen) {
>  			uint64_t ip = start + off;
>  
>  			printed += ip__fprintf_sym(ip, thread, x.cpumode, x.cpu, &lastsym, attr, fp);
> @@ -1072,6 +1072,7 @@ static int perf_sample__fprintf_brstackinsn(struct perf_sample *sample,
>  					printed += print_srccode(thread, x.cpumode, ip);
>  				break;
>  			} else {
> +				ilen = 0;
>  				printed += fprintf(fp, "\t%016" PRIx64 "\t%s\n", ip,
>  						   dump_insn(&x, ip, buffer + off, len - off, &ilen));
>  				if (ilen == 0)
> @@ -1081,6 +1082,8 @@ static int perf_sample__fprintf_brstackinsn(struct perf_sample *sample,
>  				insn++;
>  			}
>  		}
> +		if (off != (unsigned)len)
> +			printed += fprintf(fp, "\tmismatch of LBR data and executable\n");
>  	}
>  
>  	/*
> @@ -1121,6 +1124,7 @@ static int perf_sample__fprintf_brstackinsn(struct perf_sample *sample,
>  		goto out;
>  	}
>  	for (off = 0; off <= end - start; off += ilen) {
> +		ilen = 0;
>  		printed += fprintf(fp, "\t%016" PRIx64 "\t%s\n", start + off,
>  				   dump_insn(&x, start + off, buffer + off, len - off, &ilen));
>  		if (ilen == 0)
> -- 
> 2.21.0

-- 

- Arnaldo

Return-Path: <SRS0=FxTY=RO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D3718C43381
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Mar 2019 18:10:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A06C9206DF
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Mar 2019 18:10:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="S4FMq8xt"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727904AbfCKSK1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Mar 2019 14:10:27 -0400
Received: from mail-qt1-f194.google.com ([209.85.160.194]:35545 "EHLO
        mail-qt1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727008AbfCKSK0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Mar 2019 14:10:26 -0400
Received: by mail-qt1-f194.google.com with SMTP id b16so5058032qtt.2;
        Mon, 11 Mar 2019 11:10:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=pdUcx2DG7vNx38cGxgDtsGGweNfsR7/aaFa2nOJg28E=;
        b=S4FMq8xtew0O4lJu7sWRk0xpsGiFNBxmnC9mL07rvVSu0wfPLR3JZ+dY9b3/ipZtE1
         mjyfvrT/dZg8+ybGR+fySw0INKDL6JW2Mf8L0LszQRyUfCPJvhxP5ffGq0E6DZEgNu/9
         8OkpFfC5R/iYV8WVpcUu1O73INpoJc2sx9YBK/0aFrxIn3Xisy9BX55iAidHEiV3gkBM
         u+aHbngbrO+M27uCvRnsaHCAUd4lL/zOXfIDGOo3R/9xctPYW9YQxaCtr7hiKJ4fM17M
         qt6RzmBy6xCkMulzLSee9TarOvOwtFXyQZ3e2RgojRsKsl/syM0QIKxfmSh38v0gFTiF
         hCyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=pdUcx2DG7vNx38cGxgDtsGGweNfsR7/aaFa2nOJg28E=;
        b=pD3RSvXxkg1lbD5OD5tFMMy001JJx3mCoPphP1qlhhkaH+ZQ43s6XyGLZM+k4njjNn
         PC6YY0VpkJ+BeAHa89kHXMDfTbFS0mzNLKIPAEridqYiD930HnMRCN/CoESUAAjB4tRE
         zpi0TIK+pUd0xahZfvuCMwgfJDL3/exFJkJmzXORK7jRYpDb57XhClStNnbOi8zXLpVd
         EgER4e5J+t166U/BL0tzPmw1xxvcDIN6Y15N/2O35WxNUl3I/1xUxGHcyd/l7kgSMZ+T
         aytZScQjKPxszPevsgHvggXWgnghZXlw9SR7EczdGF78W+V37lW4q08kk5ijr2Ar0+Vr
         wYHg==
X-Gm-Message-State: APjAAAXml18LTxk63amBzGuHHSugRFfNDLZdKEJ3kM0FZXg0aDb0LvSs
        teQZWNIk5xFg9W5DBxCnGfM=
X-Google-Smtp-Source: APXvYqzadlEm4x/T3VEitHbD3YPioA2uxJodGd0XpY10jWD1elikNOffnQhrizCbzGol0ePgBKZAPw==
X-Received: by 2002:ac8:5297:: with SMTP id s23mr25902202qtn.371.1552327824800;
        Mon, 11 Mar 2019 11:10:24 -0700 (PDT)
Received: from quaco.ghostprotocols.net ([2804:1b1:210a:2644:8d4d:9170:85d5:da34])
        by smtp.gmail.com with ESMTPSA id k64sm3740303qkd.55.2019.03.11.11.10.23
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 11 Mar 2019 11:10:23 -0700 (PDT)
From:   Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>
X-Google-Original-From: Arnaldo Carvalho de Melo <acme@kernel.org>
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 2F20B4039C; Mon, 11 Mar 2019 15:10:21 -0300 (-03)
Date:   Mon, 11 Mar 2019 15:10:21 -0300
To:     Andi Kleen <andi@firstfloor.org>
Cc:     jolsa@kernel.org, linux-perf-users@vger.kernel.org,
        linux-kernel@vger.kernel.org, Andi Kleen <ak@linux.intel.com>
Subject: Re: [PATCH v6 09/11] perf tools report: Add custom scripts to script
 menu
Message-ID: <20190311181021.GT10690@kernel.org>
References: <20190311144502.15423-1-andi@firstfloor.org>
 <20190311144502.15423-10-andi@firstfloor.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190311144502.15423-10-andi@firstfloor.org>
X-Url:  http://acmel.wordpress.com
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Mon, Mar 11, 2019 at 07:45:00AM -0700, Andi Kleen escreveu:
> From: Andi Kleen <ak@linux.intel.com>
> 
> Add a way to define custom scripts through ~/.perfconfig, which
> are then added to the scripts menu. The scripts get the same
> arguments as perf script, in particular -i, --cpu, --tid.
> 
> Signed-off-by: Andi Kleen <ak@linux.intel.com>
> ---
>  tools/perf/Documentation/perf-config.txt |  8 ++++++++
>  tools/perf/ui/browsers/scripts.c         | 20 ++++++++++++++++++++
>  2 files changed, 28 insertions(+)
> 
> diff --git a/tools/perf/Documentation/perf-config.txt b/tools/perf/Documentation/perf-config.txt
> index 2d0fb7613134..c3323228d3d0 100644
> --- a/tools/perf/Documentation/perf-config.txt
> +++ b/tools/perf/Documentation/perf-config.txt
> @@ -590,6 +590,14 @@ samples.*::
>  		Define how many ns worth of time to show
>  		around samples in perf report sample context browser.
>  
> +script.*::
> +
> +	Any option defines a script that is added to the scripts menu
> +	in the interactive perf browser and whose output is displayed.
> +	The name of the option is the name, the value is a script command line.
> +	The script gets the same options passed as a full perf script,
> +	in particular -i perfdata file, --cpu, --tid
> +

Isn't it better to use 'scripts' for those scripts and leave 'script'
for configuring the 'perf script' command like we have options for
annotate, etc?

- Arnaldo

>  SEE ALSO
>  --------
>  linkperf:perf[1]
> diff --git a/tools/perf/ui/browsers/scripts.c b/tools/perf/ui/browsers/scripts.c
> index cdba58447b85..5d407ab834b5 100644
> --- a/tools/perf/ui/browsers/scripts.c
> +++ b/tools/perf/ui/browsers/scripts.c
> @@ -6,6 +6,7 @@
>  #include "../../util/symbol.h"
>  #include "../browser.h"
>  #include "../libslang.h"
> +#include "config.h"
>  
>  #define SCRIPT_NAMELEN	128
>  #define SCRIPT_MAX_NO	64
> @@ -53,6 +54,24 @@ static int add_script_option(const char *name, const char *opt,
>  	return 0;
>  }
>  
> +static int scripts_config(const char *var, const char *value, void *data)
> +{
> +	struct script_config *c = data;
> +
> +	if (!strstarts(var, "script."))
> +		return -1;
> +	if (c->index >= SCRIPT_MAX_NO)
> +		return -1;
> +	c->names[c->index] = strdup(var + 7);
> +	if (!c->names[c->index])
> +		return -1;
> +	if (asprintf(&c->paths[c->index], "%s %s", value,
> +		     c->extra_format) < 0)
> +		return -1;
> +	c->index++;
> +	return 0;
> +}
> +
>  /*
>   * When success, will copy the full path of the selected script
>   * into  the buffer pointed by script_name, and return 0.
> @@ -87,6 +106,7 @@ static int list_scripts(char *script_name, bool *custom,
>  			  &scriptc);
>  	add_script_option("Show individual samples with source", "-F +srcline,+srccode",
>  			  &scriptc);
> +	perf_config(scripts_config, &scriptc);
>  	custom_perf = scriptc.index;
>  	add_script_option("Show samples with custom perf script arguments", "", &scriptc);
>  	i = scriptc.index;
> -- 
> 2.20.1

-- 

- Arnaldo

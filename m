Return-Path: <SRS0=uOpN=TO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D93F1C04AB4
	for <linux-kernel@archiver.kernel.org>; Tue, 14 May 2019 13:36:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A152B20881
	for <linux-kernel@archiver.kernel.org>; Tue, 14 May 2019 13:36:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZE2ntmlL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726179AbfENNgP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 May 2019 09:36:15 -0400
Received: from mail-qk1-f193.google.com ([209.85.222.193]:44925 "EHLO
        mail-qk1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725854AbfENNgP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 May 2019 09:36:15 -0400
Received: by mail-qk1-f193.google.com with SMTP id w25so10243078qkj.11
        for <linux-kernel@vger.kernel.org>; Tue, 14 May 2019 06:36:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=oA4FNsUWgRu6ZdEjoSbJvMd+5E5ZcrViOBsXvvgdKU4=;
        b=ZE2ntmlLmFa1vwlJmYM1zXq3oLJLzZMTteC9unfh/Lyu0tu/zEjSrfYeV2w1eKPlSf
         9ytKCLMZq5vPx91oZatuVdxGYOXP+ClJLCzzCjytneEKFZzZ/LF15IOJccxjZBrMG55q
         I9OQLB4uv5Pox5/YgUB1vtin5ktdW4jkwM8YkSh/Yb63B7pSJBYPDz2SlY3KTTrgmvq3
         STJfCcYWVRFic1jSC7fswTU5UrH3tShOtOtO0ehCqQiHAQn3mRjPf+r50L1N2NmnNbwZ
         GLwb4eZzsu1OETPrQfmA3hkxknCARw300FjBkP5LBTLcUamv9rrC2Un/bicpSBQ9/gIW
         i2cA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=oA4FNsUWgRu6ZdEjoSbJvMd+5E5ZcrViOBsXvvgdKU4=;
        b=noDbVs+90di6PenPfgRLeeN8Lf7LPMV8krUgy2TsAAccO8tSOGsKu1SM/rPp5+zjXO
         wju25pMFKNSRzOgaBhVUn1x6LaUzszjKw7Vtl6kHxRS7QMOIRoua1F/rbeF8MguE/WNZ
         T0s/4QeHHGuNr2yYz1D3cSCJjA5JZVuR9MwSQGbkkLT3bRRCAZC0ww6E1zuOZ3CyROiN
         aUlN6iEkLcXCNCpc2yt7x4fObwCH+Y/NLuM8PALuwMwR7dD0pRPiOcipQtcrBs4mI5WW
         LTqmgrZvuxfmofWKSYRhanMyGJ6YqtISVwO4wUxc1WBQJWhjC1UADXlGNldMhSYlD3Xs
         SUKw==
X-Gm-Message-State: APjAAAXLml9hSVXsg/9ZMLQqrQdqHXglhGdszx2iZ1Dkm0gehhhWCNqv
        c4HatY0hK5fatvUhk7N5JrvWHKJ9jLs=
X-Google-Smtp-Source: APXvYqyoiUpLPUZmwVApZDbH1B9gqMfp2zYbaXV7x9j/Amfq25Lvo2uUg6+aSaLU0ZDuuFdJHlUqHA==
X-Received: by 2002:a37:7a47:: with SMTP id v68mr28335186qkc.56.1557840974073;
        Tue, 14 May 2019 06:36:14 -0700 (PDT)
Received: from quaco.ghostprotocols.net ([177.195.209.210])
        by smtp.gmail.com with ESMTPSA id f33sm2945183qtf.64.2019.05.14.06.36.12
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 14 May 2019 06:36:13 -0700 (PDT)
From:   Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>
X-Google-Original-From: Arnaldo Carvalho de Melo <acme@kernel.org>
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id B551F403AD; Tue, 14 May 2019 10:36:03 -0300 (-03)
Date:   Tue, 14 May 2019 10:36:03 -0300
To:     Donald Yandt <donald.yandt@gmail.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>, linux-kernel@vger.kernel.org,
        Yanmin Zhang <yanmin_zhang@linux.intel.com>
Subject: Re: [PATCH v2] tools/perf/util: null-terminate version char array
 upon error
Message-ID: <20190514133603.GH3198@kernel.org>
References: <20190514110100.22019-1-donald.yandt@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190514110100.22019-1-donald.yandt@gmail.com>
X-Url:  http://acmel.wordpress.com
User-Agent: Mutt/1.11.3 (2019-02-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Tue, May 14, 2019 at 07:01:00AM -0400, Donald Yandt escreveu:
> If fgets fails due to any other error besides end-of-file, the version char array may not even be null-terminated.

Thanks, but out of curiosity, was this found just by visual inspection?
Some static analysis tool? An actual problem you stumbled when
processing some /proc/version in a custom kernel?

Also please consider adding a:

Fixes: a1645ce12adb ("perf: 'perf kvm' tool for monitoring guest performance from host")

So that we can get this picked up by the stable kernel trees. I'm adding
it now.

Thanks!

- Arnaldo
 
> Signed-off-by: Donald Yandt <donald.yandt@gmail.com>
> ---
>  tools/perf/util/machine.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/tools/perf/util/machine.c b/tools/perf/util/machine.c
> index 3c520baa1..28a9541c4 100644
> --- a/tools/perf/util/machine.c
> +++ b/tools/perf/util/machine.c
> @@ -1234,8 +1234,9 @@ static char *get_kernel_version(const char *root_dir)
>  	if (!file)
>  		return NULL;
> 
> -	version[0] = '\0';
>  	tmp = fgets(version, sizeof(version), file);
> +	if (!tmp)
> +		*version = '\0';
>  	fclose(file);
> 
>  	name = strstr(version, prefix);
> --
> 2.20.1

-- 

- Arnaldo

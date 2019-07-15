Return-Path: <SRS0=zSVa=VM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7059CC7618F
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Jul 2019 11:00:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 43226206B8
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Jul 2019 11:00:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="o67/JMLn"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729849AbfGOLAL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Jul 2019 07:00:11 -0400
Received: from mail-qt1-f195.google.com ([209.85.160.195]:38424 "EHLO
        mail-qt1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729755AbfGOLAK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Jul 2019 07:00:10 -0400
Received: by mail-qt1-f195.google.com with SMTP id n11so15075730qtl.5
        for <linux-kernel@vger.kernel.org>; Mon, 15 Jul 2019 04:00:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=TaYBXrvXWL6qklGi5B13aoo0MRLfwhj34xQOMe1pwjo=;
        b=o67/JMLnQbQVZ5hROrWjsOwssd/29PJGx12NI9ix6leDYKPUyY314ToR9aHyTsqCZM
         oV42rwhHr3mpsYP6XGiQn8Brkr3qYDOiXB8ilPX6JtlkKJmGMpjt9nuQAD/omWVA4d4y
         spvFsZmaEGfOY7Ngzfg9sz+wrEE7E8htesFLfszVoqn+XIihS6LHQKCIgSXkBnNMODTz
         LUhdiA/hQSJhq8W+fMywGmyY0gkrOERlmPcWGZFi6qVqdte//8myqCuxih8TJRk9+mOq
         LQejIgXgh+n2EZs2HYM6w4pmnA1yNR4FgZtSVcusBDqWz1C4j2aBepA17bgiwWkodGp0
         AFmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=TaYBXrvXWL6qklGi5B13aoo0MRLfwhj34xQOMe1pwjo=;
        b=UwyjrY144ROXMzL+daetLHVB+1o2bbDQm45nxBI4gPgnSfnpt+bfOTITZr1InJ4SbR
         vNsEexZWGCtxrUA7DEWVap8wfjgocZJZjPE2NLfJeQJKisqnqzdEUWto5MsqYubFh2oj
         2sFl18TPD0DWEnkOz2am5TiUTSk8Ikl4zYKVoc3Mt+8zXEOwXRJgQ/4YblicejHV4L9T
         YxY9SOOFL8Hb0R+tHWWGoVQszpCk7KT+3mkjFQeyf2B8eUExb/gaUOxV4EgOb4bqXeoO
         IN97Wc/6DZGhLPBBNMU0/jkui6GPAHdqwgQOSS9cnjkQp7ub8OnmEz2ds6D1EyP97GBV
         8JCQ==
X-Gm-Message-State: APjAAAXFP4YARg+CFpkKLwPJYC9qjBq1noqrwHW3sgtqIjQ4aRRdpcBu
        0uWwME499DowKUsKDueyUzE=
X-Google-Smtp-Source: APXvYqza1UcWjKcfp94v1/yNB3BMmYSCZ0jQk6Eu1dxRrMv20/c5k2JhhW//eqezmtasRz2DWVSTmg==
X-Received: by 2002:ac8:3f55:: with SMTP id w21mr17433100qtk.217.1563188409806;
        Mon, 15 Jul 2019 04:00:09 -0700 (PDT)
Received: from quaco.ghostprotocols.net ([179.97.35.11])
        by smtp.gmail.com with ESMTPSA id m27sm7716905qtu.31.2019.07.15.04.00.08
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Mon, 15 Jul 2019 04:00:08 -0700 (PDT)
From:   Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>
X-Google-Original-From: Arnaldo Carvalho de Melo <acme@kernel.org>
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 8BFD940340; Mon, 15 Jul 2019 08:00:06 -0300 (-03)
Date:   Mon, 15 Jul 2019 08:00:06 -0300
To:     Ravi Bangoria <ravi.bangoria@linux.ibm.com>
Cc:     jolsa@redhat.com, kamalesh@linux.vnet.ibm.com,
        mamatha4@linux.vnet.ibm.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] perf version: Fix segfault
Message-ID: <20190715110006.GA6779@kernel.org>
References: <20190611030109.20228-1-ravi.bangoria@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190611030109.20228-1-ravi.bangoria@linux.ibm.com>
X-Url:  http://acmel.wordpress.com
User-Agent: Mutt/1.12.0 (2019-05-25)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Tue, Jun 11, 2019 at 08:31:09AM +0530, Ravi Bangoria escreveu:
> 'perf version' on powerpc segfaults when used with non-supported
> option:
>   # perf version -a
>   Segmentation fault (core dumped)
> 
> Fix this.
> 
> Signed-off-by: Ravi Bangoria <ravi.bangoria@linux.ibm.com>
> Reviewed-by: Kamalesh babulal <kamalesh@linux.vnet.ibm.com>
> Tested-by: Mamatha Inamdar <mamatha4@linux.vnet.ibm.com>
> ---
>  tools/perf/builtin-version.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/tools/perf/builtin-version.c b/tools/perf/builtin-version.c
> index f470144d1a70..bf114ca9ca87 100644
> --- a/tools/perf/builtin-version.c
> +++ b/tools/perf/builtin-version.c
> @@ -19,6 +19,7 @@ static struct version version;
>  static struct option version_options[] = {
>  	OPT_BOOLEAN(0, "build-options", &version.build_options,
>  		    "display the build options"),
> +	OPT_END(),
>  };

Thanks, applied.

- Arnaldo

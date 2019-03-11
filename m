Return-Path: <SRS0=FxTY=RO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 84E35C43381
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Mar 2019 18:35:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5A72320657
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Mar 2019 18:35:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="J6Y2wsU/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727945AbfCKSfu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Mar 2019 14:35:50 -0400
Received: from mail-qt1-f194.google.com ([209.85.160.194]:39146 "EHLO
        mail-qt1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726942AbfCKSfu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Mar 2019 14:35:50 -0400
Received: by mail-qt1-f194.google.com with SMTP id t28so2604893qte.6;
        Mon, 11 Mar 2019 11:35:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=RrDpNbk1ju3i8h5jNswWEQCixY6hpdKEEXb/lFWlncU=;
        b=J6Y2wsU/gNEi27zylFbfEYaw3q/qsRkTrJfu5VmInWq+e1u5aZozbJG9tr+JsgFo+L
         7S2hCe766xPgoZEM/NUsW7ZfcaWUPm2UjkYj05kH5iQXlvNOsUcKvfjt+2ffnuwlbzG5
         lDFkRNRs0bUa1RHmwIX4T1N18PkVrXU1FRsSLZ/B0gCx1PbDPLgSKzds/sbmXWoQbmvv
         Mq3b5LFyAKMPMPXkLSHHjtHscUHyZl770O/qvfDUNycJiN6BpQRV+4vjcDwijsKC1myG
         VmMVazeavjozxtO3I7WphUQFk9RJsp/hKBeM3J28slR/dWHTc9bN5sIhxLPLTwZ6tQc/
         g2RA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=RrDpNbk1ju3i8h5jNswWEQCixY6hpdKEEXb/lFWlncU=;
        b=d41iflw2YN95YmAdyw/4QDOYFXWcFmA3chhEV9pZfCADNFe93DAe+GGQQhmw4Ip1qj
         YIAEp6/5Y43L0jvuu43rybSD/Cp2UzX5EZEuiNdJiXe3K2wtCqrhPxpccBrgLACF+Sum
         NOrR7yFe3wNQVCTXJr5ve8s4gO/jeYC0uk58X8v+SKt1xrMMnhOsRrvvf6Aj6LSZ0kee
         bVbQX7WLJTiPwUwrceP66TAD2Rop6EqbJs5jmGgZ5Vd+CF1moJoNVjsT5Txjaua5xiPl
         DZALOmHfLlFQ6oFaUkUereW233lsIBCqZwkdHPEFtmd1s1Pv4f3N/16VO6Ndyk5K1m0D
         mwMw==
X-Gm-Message-State: APjAAAWVdLxq70DtIIAC2r8wkT2rzWtdnrdy4A9zJTfL3vvvfeChdbeh
        JkoOSCe23DR3uUJBCBPNpWk=
X-Google-Smtp-Source: APXvYqw587JB8nXgy1EwGaTfbQIk6G8Rk0XeEv73RI8g2Qel1lgZbxlfhf5auhLLpyiaGqHDIw7y6Q==
X-Received: by 2002:ac8:2415:: with SMTP id c21mr24811312qtc.93.1552329348860;
        Mon, 11 Mar 2019 11:35:48 -0700 (PDT)
Received: from quaco.ghostprotocols.net ([2804:1b1:210a:2644:8d4d:9170:85d5:da34])
        by smtp.gmail.com with ESMTPSA id p188sm2624795qkb.43.2019.03.11.11.35.47
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 11 Mar 2019 11:35:48 -0700 (PDT)
From:   Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>
X-Google-Original-From: Arnaldo Carvalho de Melo <acme@kernel.org>
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 48DFE4039C; Mon, 11 Mar 2019 15:35:45 -0300 (-03)
Date:   Mon, 11 Mar 2019 15:35:45 -0300
To:     Andi Kleen <ak@linux.intel.com>
Cc:     Jiri Olsa <jolsa@redhat.com>, Andi Kleen <andi@firstfloor.org>,
        jolsa@kernel.org, linux-perf-users@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v6 07/11] perf tools report: Implement browsing of
 individual samples
Message-ID: <20190311183545.GY10690@kernel.org>
References: <20190311144502.15423-1-andi@firstfloor.org>
 <20190311144502.15423-8-andi@firstfloor.org>
 <20190311172420.GC9664@krava>
 <20190311174605.GA29294@tassilo.jf.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190311174605.GA29294@tassilo.jf.intel.com>
X-Url:  http://acmel.wordpress.com
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Mon, Mar 11, 2019 at 10:46:05AM -0700, Andi Kleen escreveu:
> On Mon, Mar 11, 2019 at 06:24:20PM +0100, Jiri Olsa wrote:
> > On Mon, Mar 11, 2019 at 07:44:58AM -0700, Andi Kleen wrote:
> > 
> > SNIP
> > 
> > > diff --git a/tools/perf/ui/browsers/scripts.c b/tools/perf/ui/browsers/scripts.c
> > > index 9e5f87558af6..cdba58447b85 100644
> > > --- a/tools/perf/ui/browsers/scripts.c
> > > +++ b/tools/perf/ui/browsers/scripts.c
> > > @@ -125,7 +125,7 @@ static int list_scripts(char *script_name, bool *custom,
> > >  	return ret;
> > >  }
> > >  
> > > -static void run_script(char *cmd)
> > > +void run_script(char *cmd)
> > >  {
> > >  	pr_debug("Running %s\n", cmd);
> > >  	SLang_reset_tty();
> > > diff --git a/tools/perf/util/hist.c b/tools/perf/util/hist.c
> > > index fd5d02c1a521..3a0e2bb40529 100644
> > > --- a/tools/perf/util/hist.c
> > > +++ b/tools/perf/util/hist.c
> > > @@ -436,6 +436,13 @@ static int hist_entry__init(struct hist_entry *he,
> > >  			goto err_rawdata;
> > >  	}
> > >  
> > > +	if (symbol_conf.res_sample) {
> > > +		he->res_samples = calloc(sizeof(struct res_sample),
> > > +					symbol_conf.res_sample);
> > > +		if (!he->res_samples)
> > > +			return -ENOMEM;
> > > +	}
> > 
> > https://lore.kernel.org/lkml/20190311123227.GA26829@krava/
> 
> Here's an updated patch.

And here is the diff to what was before. Replaced the previous patch
with this one and I'm adding Jiri's Acked-by to the whole series, as he
provided me privately, thanks guys!

- Arnaldo


diff --git a/tools/perf/util/hist.c b/tools/perf/util/hist.c
index 3a0e2bb40529..c2894013191a 100644
--- a/tools/perf/util/hist.c
+++ b/tools/perf/util/hist.c
@@ -440,7 +440,7 @@ static int hist_entry__init(struct hist_entry *he,
 		he->res_samples = calloc(sizeof(struct res_sample),
 					symbol_conf.res_sample);
 		if (!he->res_samples)
-			return -ENOMEM;
+			goto err_srcline;
 	}
 
 	INIT_LIST_HEAD(&he->pairs.node);
@@ -453,6 +453,9 @@ static int hist_entry__init(struct hist_entry *he,
 
 	return 0;
 
+err_srcline:
+	free(he->srcline);
+
 err_rawdata:
 	free(he->raw_data);
 

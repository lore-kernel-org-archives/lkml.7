Return-Path: <SRS0=FxTY=RO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B50D4C43381
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Mar 2019 18:45:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8AB5F2084F
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Mar 2019 18:45:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MvsMs5Kf"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727559AbfCKSpk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Mar 2019 14:45:40 -0400
Received: from mail-qt1-f195.google.com ([209.85.160.195]:40007 "EHLO
        mail-qt1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726675AbfCKSpk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Mar 2019 14:45:40 -0400
Received: by mail-qt1-f195.google.com with SMTP id f11so6294023qti.7;
        Mon, 11 Mar 2019 11:45:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=85Ezg2SSxmh9iBs/MP9WNLcx7pRhPP5LsOqG4fxxL8w=;
        b=MvsMs5KfH25bf/dQq0DeEX45JmNgn4osPeygKnr5KPifSGMThc6pStpZ31zYNjfBf9
         wYDUSAMzCNRGr1ZPVVciEmKuWFeNDIfkhw0OsruUWtpFTzGDIEfeShm3MXcGQsrcBM29
         Crkwzo/IEGDVU7iRp7jomCdcLeQxnxvjqjQJNT/7tDGK29/4iHCXNhkOuGQB/9BGLJ4w
         yAYDWnxNm4v+pqsH5wxpwQLwD0l0qWq4Oa5Rb+d6d394nDRY0HQa/3gXx+EcAlPZtJHq
         kiG7OiWYlL47GCwyLAVzkmITTm2ITmhLoUgVr0w6uWR1ROAh8L8GO1ouN99TmX3u+ZPd
         TpOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=85Ezg2SSxmh9iBs/MP9WNLcx7pRhPP5LsOqG4fxxL8w=;
        b=b+KL7MRkQvuICmU6qX4vTqsURYjaTb7RkuHs8sUXra5P1/Vf6Yk+BpbAxCHRbdXvmD
         /1cYyWNPDF33IQsfuj59un6e7uIMehV3O3MMwLOvpES2JB7MrC1dZ+2ukhZq33LDkVK6
         NXJmq/sPIB/iGjfbpy99PtazWLA6b03ej+J3lgt6+aTHpZfNKT+Ung/kukAeQiLU31Wy
         aTb1an6a3JXrXRKQNUz62HxPCmVEVsAk4j2GWSHlL7U6wQPPuE8lVVCnH1440Wt7odCs
         2VprIxnwMqY7Yv9pswJOGMoGa8viac/NqzootHsayPEq6DE+ga1uSL25dKAItOUQYMKa
         NKFQ==
X-Gm-Message-State: APjAAAXxARLkRVyU4xeGVcXls45AGpIrXI3gZcyZJQlsLrymnd1ABWHy
        1OQ4DbB3RfBygXZoaosUDzc=
X-Google-Smtp-Source: APXvYqzECA+rQdjIL1daXDdwZIb4qJid4eIaPItQTTRtSfIKaSzdKA3vRIUXPHYZYuRj/5pXuvJTTA==
X-Received: by 2002:ac8:7545:: with SMTP id b5mr9544470qtr.239.1552329939120;
        Mon, 11 Mar 2019 11:45:39 -0700 (PDT)
Received: from quaco.ghostprotocols.net ([179.162.132.204])
        by smtp.gmail.com with ESMTPSA id 46sm4397251qto.87.2019.03.11.11.45.37
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 11 Mar 2019 11:45:37 -0700 (PDT)
From:   Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>
X-Google-Original-From: Arnaldo Carvalho de Melo <acme@kernel.org>
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 842614039C; Mon, 11 Mar 2019 15:45:34 -0300 (-03)
Date:   Mon, 11 Mar 2019 15:45:34 -0300
To:     Andi Kleen <ak@linux.intel.com>
Cc:     Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>,
        Andi Kleen <andi@firstfloor.org>, jolsa@kernel.org,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v6 09/11] perf tools report: Add custom scripts to script
 menu
Message-ID: <20190311184534.GZ10690@kernel.org>
References: <20190311144502.15423-1-andi@firstfloor.org>
 <20190311144502.15423-10-andi@firstfloor.org>
 <20190311181021.GT10690@kernel.org>
 <20190311183455.GB29294@tassilo.jf.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190311183455.GB29294@tassilo.jf.intel.com>
X-Url:  http://acmel.wordpress.com
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Mon, Mar 11, 2019 at 11:34:55AM -0700, Andi Kleen escreveu:
> > Isn't it better to use 'scripts' for those scripts and leave 'script'
> > for configuring the 'perf script' command like we have options for
> > annotate, etc?
> 
> Yes that's fine.
> 
> That's just two character updates in the doc and in the strstarts below. 
> If there's nothing else can you please just do these changes when you apply?

Sure, doing that now.
 
> Thanks.
> 
> > > +static int scripts_config(const char *var, const char *value, void *data)
> > > +{
> > > +	struct script_config *c = data;
> > > +
> > > +	if (!strstarts(var, "script."))
> > > +		return -1;

-- 

- Arnaldo

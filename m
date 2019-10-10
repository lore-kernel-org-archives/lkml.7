Return-Path: <SRS0=5y3R=YD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1A035C10F14
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Oct 2019 16:07:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E94A020B7C
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Oct 2019 16:07:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CcmShbOz"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726339AbfJJQHW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 10 Oct 2019 12:07:22 -0400
Received: from mail-qt1-f194.google.com ([209.85.160.194]:42645 "EHLO
        mail-qt1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725901AbfJJQHW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Oct 2019 12:07:22 -0400
Received: by mail-qt1-f194.google.com with SMTP id w14so9446080qto.9
        for <linux-kernel@vger.kernel.org>; Thu, 10 Oct 2019 09:07:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=wKz6+enNqDdYt1jyGExLvEudHceohtta0eMtT6eQJ7o=;
        b=CcmShbOzJK6tNGpewdMIWIZINmshsoo/O57jFHY9u4NzO+IwZ5klQBwfWJRCKvB/of
         rSIC4yoYV6HCo0N8EBEoGnssK8XAB45yVVJ1gsWQZSb/UHJMFkfXKasZ58M3Kpqw6YEP
         3IzJCy5WTD7SXwGjaF4NcMf8sd8QzjQGEGDkGMAhyTEnmgCEyZOWzcBEJn3WYpCA2JYv
         z45DPiQZplEZ+ycPzLLlFtfp49dXIhLmDBWp2NRz8veMCaKtHC6iphqn9D9bb/97QJdH
         eimP7NKXc3itfAKbc8GXEOroXeT3MQdrjSB1y4sftdh8qSUo70eC4bGP9XSr55D/7wtV
         Qx0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=wKz6+enNqDdYt1jyGExLvEudHceohtta0eMtT6eQJ7o=;
        b=o5EmXTCKltq3b4pL1QxwyHBHx/85dE98GyM3Su1CxRY5xKsjxfucuMK9ES99c2sTdE
         Rl14mSx9cNlAXML6XKCnBIckrKi5BmUIDDLP2Xy9ZqSzyQYTGeivvxyRZOjOarhdToQw
         QG3VgLj6ivJ215ZkyHvbCf74z8Mo4t5OgYAtx+THu9HnzrzP5Zij8WBsDo29oJhUxZT0
         pQD1lDWjRK2XIA5s3ym4/tDFNu+JJO3BC9mZWeheC09qVa0/6uo7dGyjYG6FaHcTBFRH
         1TKXSrCTlyiKuGEfxtHE43fOjYYAjEY+y973IYosoIdanRuO5LQ5THOb6xpUcCx8+2JZ
         vkJQ==
X-Gm-Message-State: APjAAAUbDT6fXPrOfOzVzbHQHb24fObJHdXsIQhgZW20IKX9ClGshUZa
        eBbh79uPoaP/v53ceS5F19x0aH03
X-Google-Smtp-Source: APXvYqxci6+esxZIx7KGvbd7A5tpn0SumL3LXWlemIgp9b3rw7l3gWZLuYYZQ4zSrSsRupRMXlKDmg==
X-Received: by 2002:ac8:2813:: with SMTP id 19mr11434693qtq.375.1570723641419;
        Thu, 10 Oct 2019 09:07:21 -0700 (PDT)
Received: from quaco.ghostprotocols.net ([179.97.35.50])
        by smtp.gmail.com with ESMTPSA id 77sm3046141qke.78.2019.10.10.09.07.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Oct 2019 09:07:20 -0700 (PDT)
From:   Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>
X-Google-Original-From: Arnaldo Carvalho de Melo <acme@kernel.org>
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id C3F384DD66; Thu, 10 Oct 2019 13:07:18 -0300 (-03)
Date:   Thu, 10 Oct 2019 13:07:18 -0300
To:     Jiri Olsa <jolsa@redhat.com>
Cc:     Jiri Olsa <jolsa@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Michael Petlan <mpetlan@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        lkml <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>
Subject: Re: [PATCH 12/36] libperf: Add perf_mmap__read_event() function
Message-ID: <20191010160718.GD11638@kernel.org>
References: <20191007125344.14268-1-jolsa@kernel.org>
 <20191007125344.14268-13-jolsa@kernel.org>
 <20191010144700.GB11638@kernel.org>
 <20191010153232.GA24818@krava>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191010153232.GA24818@krava>
X-Url:  http://acmel.wordpress.com
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Thu, Oct 10, 2019 at 05:32:32PM +0200, Jiri Olsa escreveu:
> On Thu, Oct 10, 2019 at 11:47:00AM -0300, Arnaldo Carvalho de Melo wrote:
> 
> SNIP
> 
> > > diff --git a/tools/perf/lib/include/internal/mmap.h b/tools/perf/lib/include/internal/mmap.h
> > > index ee536c4441bb..b328332b6ccf 100644
> > > --- a/tools/perf/lib/include/internal/mmap.h
> > > +++ b/tools/perf/lib/include/internal/mmap.h
> > > @@ -11,6 +11,7 @@
> > >  #define PERF_SAMPLE_MAX_SIZE (1 << 16)
> > >  
> > >  struct perf_mmap;
> > > +union perf_event;
> > 
> > Why are you adding this here?
> 
> oops, it should be in lib/include/perf/mmap.h ;-)
> plz let me know if you want me to repost

I fixed it already, its in acme/tmp.perf/core, will continue later,
possibly will push to Ingo  what I have there if it passes all the
tests, its getting too big a perf/core. :-)

- Arnaldo

Return-Path: <SRS0=/WLL=WS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AB7F4C3A5A1
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Aug 2019 15:19:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7D43A2089E
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Aug 2019 15:19:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RPXiTZyR"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389527AbfHVPTT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 22 Aug 2019 11:19:19 -0400
Received: from mail-qt1-f196.google.com ([209.85.160.196]:39794 "EHLO
        mail-qt1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727874AbfHVPTS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Aug 2019 11:19:18 -0400
Received: by mail-qt1-f196.google.com with SMTP id l9so8129965qtu.6
        for <linux-kernel@vger.kernel.org>; Thu, 22 Aug 2019 08:19:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=Mf7WlHglYJOzVxlRAETexTf7b5FZsaOV3O7fbNGdKwk=;
        b=RPXiTZyRinsAKcVVnkM055Rx2dB0XOroizYdCvBXJjCx0SFiaxk3sH7jrshKYKnsi+
         3zaG6L4ga6wqsIHcPnNDY1v7SY6R65s+wq5Fv8NrgNLQMlm5jGJZkUiAXjS3lRPW0Evy
         mfjUh4zE1N+K8idKHqQYL+mcIm7OAf5FEFAfyJ288YqCiGmkAo5r3PDZsbUDEl99qQR/
         /n1InykkJNeDR6Bx78mR52BYfn0e6/LSn/YvpqIajKaJ0YKxYaGBGw8xlJ0ok2l5SKBW
         hWELG6mz/3QzsQNNumg++FDP+8issKFggmEuojYWuhgG4zuKCIl3xCs64Dp4Vq/dnbp1
         +ZNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=Mf7WlHglYJOzVxlRAETexTf7b5FZsaOV3O7fbNGdKwk=;
        b=jWY4ITAyK1zYKC1KKD2GcjTOiPqh5cGGoXWLdpr7nMFxi3ttXZFZX30lmEZZjekUgu
         41r9em+kmN5xv6Qua8geqR+Tbl7hElPuuWd/XUUImldHEpL71ssB7D2F7QRHIeGxekzH
         kcNIfE97rmEYB6KCSffBJrzFEku4gihFYIcemMjYGV8CWLIRo6jSOa8BHFpMQjHd/Jkv
         7h8etovvY4O1a/iDPvexJd8nN55HH31/SMaxr/JACKPIok0QkorlUMU49XCvfyCE00i1
         AthZNKlcfVFOZgyfPv+lt+Af1thJ7tTqFsJHsNsVgyjdLGRTJ2y3f762ShLwB/3WDDkc
         7K9g==
X-Gm-Message-State: APjAAAUr3qL9eaXEEebZ/2NA8Hd2aL2HtnUtsmDSolD/FHNEA+kIzqaj
        xqrUJAwKAuHPAbMP/aHokLY=
X-Google-Smtp-Source: APXvYqwvqWdedQh8TLdCEWjT4y78ICqzV/83/BAw74OMc/Dix033fzaVrXg4349PIyDcCbhhgVeekw==
X-Received: by 2002:aed:3e96:: with SMTP id n22mr42807qtf.247.1566487157884;
        Thu, 22 Aug 2019 08:19:17 -0700 (PDT)
Received: from quaco.ghostprotocols.net ([179.97.35.50])
        by smtp.gmail.com with ESMTPSA id i25sm11622248qki.49.2019.08.22.08.19.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Aug 2019 08:19:17 -0700 (PDT)
From:   Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>
X-Google-Original-From: Arnaldo Carvalho de Melo <acme@kernel.org>
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 4D01240340; Thu, 22 Aug 2019 12:19:15 -0300 (-03)
Date:   Thu, 22 Aug 2019 12:19:15 -0300
To:     Jiri Olsa <jolsa@redhat.com>
Cc:     Ravi Bangoria <ravi.bangoria@linux.ibm.com>,
        linux-kernel@vger.kernel.org,
        Nageswara R Sastry <nasastry@in.ibm.com>
Subject: Re: [PATCH] perf c2c: Fix report with offline cpus
Message-ID: <20190822151915.GC29569@kernel.org>
References: <20190822085045.25108-1-ravi.bangoria@linux.ibm.com>
 <20190822101026.GE28439@krava>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190822101026.GE28439@krava>
X-Url:  http://acmel.wordpress.com
User-Agent: Mutt/1.12.0 (2019-05-25)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Thu, Aug 22, 2019 at 12:10:26PM +0200, Jiri Olsa escreveu:
> On Thu, Aug 22, 2019 at 02:20:45PM +0530, Ravi Bangoria wrote:
> > If c2c is recorded on a machine where any cpus are offline,
> > 'perf c2c report' throws an error "node/cpu topology bugFailed
> > setup nodes". It fails because while preparing node-cpu mapping
> > we don't consider offline cpus.
> > 
> > Fixes: 1e181b92a2da ("perf c2c report: Add 'node' sort key")
> > Reported-by: Nageswara R Sastry <nasastry@in.ibm.com>
> > Signed-off-by: Ravi Bangoria <ravi.bangoria@linux.ibm.com>
> 
> Acked-by: Jiri Olsa <jolsa@redhat.com>

Thanks, applied.

- Arnaldo
 
> thanks,
> jirka
> 
> > ---
> >  tools/perf/builtin-c2c.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> > diff --git a/tools/perf/builtin-c2c.c b/tools/perf/builtin-c2c.c
> > index 9e6cc86..fc68a94 100644
> > --- a/tools/perf/builtin-c2c.c
> > +++ b/tools/perf/builtin-c2c.c
> > @@ -2027,7 +2027,7 @@ static int setup_nodes(struct perf_session *session)
> >  		c2c.node_info = 2;
> >  
> >  	c2c.nodes_cnt = session->header.env.nr_numa_nodes;
> > -	c2c.cpus_cnt  = session->header.env.nr_cpus_online;
> > +	c2c.cpus_cnt  = session->header.env.nr_cpus_avail;
> >  
> >  	n = session->header.env.numa_nodes;
> >  	if (!n)
> > -- 
> > 1.8.3.1
> > 

-- 

- Arnaldo

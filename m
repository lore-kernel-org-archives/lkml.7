Return-Path: <SRS0=fWiu=Y6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BFA7EC5DF63
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Nov 2019 19:01:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9150B20869
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Nov 2019 19:01:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ME4JSc6G"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732480AbfKFTBj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 Nov 2019 14:01:39 -0500
Received: from mail-qt1-f175.google.com ([209.85.160.175]:46151 "EHLO
        mail-qt1-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731922AbfKFTBi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Nov 2019 14:01:38 -0500
Received: by mail-qt1-f175.google.com with SMTP id u22so34841348qtq.13
        for <linux-kernel@vger.kernel.org>; Wed, 06 Nov 2019 11:01:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=bUWe5P+sqYK5OZT5sl31hT/qcl3zO9MIPDH1nbBo4Zg=;
        b=ME4JSc6G9HbfOYVGH4FkIJgVzwb14PicsP2oJM5SvPryNR2hGnq1KtrEV5aIiAkXbe
         eNaxSJLx9L3FnzWyQL4GspIpqzO21y5xQ6TW+0duNgXUKJR7t02VOQJ/48sdIWaZEBJ7
         lBixZB54gBmk691BrjYrlhEND3BYK9hj9RN2e4oKnu+BOQbB6APii+HdqwVfHDwFWecD
         z+f//5pXmgbKV4PP6wuyY09Rcscr7Qvlq3zWsLvre33W8dhoncV0pzc9l1pYC3S7Kzl4
         muxzvhia+gERCjmPN7e0aXI82BzQX15YFB+prIBp8qkMG+yQpiuDXZmGCf0nqaPtW+dT
         Bzhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=bUWe5P+sqYK5OZT5sl31hT/qcl3zO9MIPDH1nbBo4Zg=;
        b=k5i99DqOzC0RJj6C10URowZaqPLhda9ucKGvweO2HIY4mj6RyWcbgp+mxnYdGL57E1
         j30tjIec+AQ2l+0ki4jkLUQZPBLeKHaTIB/Un8NT9puN2BuSpm9tabbLd53gXNvAs/aG
         MrIgMo8A9LnQgje0GsjEmYs+jTsXCOHzBIJk8LaaPsCWeCe4gjbBi69Xh2buBMRC06dP
         TM0dnn1Kcw8aUaRExPViwTcR8kpYTMTkf1FEokJ3Z0uutDkVqecmABQzaWpEtuj3uAHn
         D/7iWFIGl59NEcufY2zVd3DsrzmQ6tzI2dySUz7PW/JSqYMFSjoLU6npdNd8fynSxbca
         9Xgg==
X-Gm-Message-State: APjAAAVseQ4Rp1YoIt4FGvNoItpbLaD5CoCM0yBLgpyGLOM2hXkrOzMf
        Z8dS+4X396Vu3kvKeTIfT4s=
X-Google-Smtp-Source: APXvYqwJ/O8AcowIryHI4Grt9phufoUjsBOJYILRrRQvq/msQ7B5xlTKfd6+VWR0iLnyLRLx7EamjQ==
X-Received: by 2002:ac8:4409:: with SMTP id j9mr55667qtn.283.1573066896386;
        Wed, 06 Nov 2019 11:01:36 -0800 (PST)
Received: from quaco.ghostprotocols.net (187-26-100-98.3g.claro.net.br. [187.26.100.98])
        by smtp.gmail.com with ESMTPSA id s123sm11888405qke.31.2019.11.06.11.01.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Nov 2019 11:01:35 -0800 (PST)
From:   Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>
X-Google-Original-From: Arnaldo Carvalho de Melo <acme@kernel.org>
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 6DD5A40B1D; Wed,  6 Nov 2019 16:01:31 -0300 (-03)
Date:   Wed, 6 Nov 2019 16:01:31 -0300
To:     Jiri Olsa <jolsa@redhat.com>
Cc:     Ian Rogers <irogers@google.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Jin Yao <yao.jin@linux.intel.com>,
        Song Liu <songliubraving@fb.com>, linux-kernel@vger.kernel.org,
        Stephane Eranian <eranian@google.com>
Subject: Re: [PATCH] perf annotate: fix heap overflow
Message-ID: <20191106190131.GD3636@kernel.org>
References: <20191026035644.217548-1-irogers@google.com>
 <20191028192908.GA28772@krava>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191028192908.GA28772@krava>
X-Url:  http://acmel.wordpress.com
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Mon, Oct 28, 2019 at 08:29:08PM +0100, Jiri Olsa escreveu:
> On Fri, Oct 25, 2019 at 08:56:44PM -0700, Ian Rogers wrote:
> > Fix expand_tabs that copies the source lines '\0' and then appends
> > another '\0' at a potentially out of bounds address.
> 
> not sure it could get out of bounds, but i think
> the change is right, it matches the memcpy before
> and I dont see reason to add +1
> 
> Acked-by: Jiri Olsa <jolsa@kernel.org>


Thanks, applied,

- Arnaldo

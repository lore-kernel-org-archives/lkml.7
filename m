Return-Path: <SRS0=fWiu=Y6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3E793C5DF63
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Nov 2019 20:07:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0A240207FA
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Nov 2019 20:07:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="r2Yo6slc"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727640AbfKFUHJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 Nov 2019 15:07:09 -0500
Received: from mail-qt1-f195.google.com ([209.85.160.195]:36810 "EHLO
        mail-qt1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726934AbfKFUHI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Nov 2019 15:07:08 -0500
Received: by mail-qt1-f195.google.com with SMTP id y10so28322250qto.3
        for <linux-kernel@vger.kernel.org>; Wed, 06 Nov 2019 12:07:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=vSAHJ2hH+BDOa7ncWkSHzAzX8VuIN49R8pX+Ia3bqWM=;
        b=r2Yo6slcxx6NmlRabn8hILC36uAOO0PDu+G2S9/n+roGztUK4U7Tdxp6ZMSv6Y/ory
         KxlkIFphIsZokn5DnRx/8/tFhGq6S76pW8FPBsDW+8SRj3kvRfAEkvBsmR8WRpVEA5TJ
         PUlVMsQ6LGuRWX5cnEaeAh2tTzyGFBVWb3qmKK1FMyPCe9K3ZQnqksQO2GEtu3zp+zYb
         4jV3ZAN80aLk5ud5BpmZD7fcjwx3nZk+IwQ00sVB+hG/yqMFEMpMMVQ8kFImivg1Y5MJ
         sx6FJRHP46RuWGJ4rDSGGqjo3hWiry/9nfxn69F3U0l2OlJ6YsxdiCeUkZX46dW6hzVM
         d7NQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=vSAHJ2hH+BDOa7ncWkSHzAzX8VuIN49R8pX+Ia3bqWM=;
        b=t8vky5bJm6S+9FSCrvR5MI26sM09uMQsabSlsGroLdYESYxU1+x2LCfVdR9exXcKQQ
         RCno4COagIqr9rdXpw2gHuhOh3kyj19BHfy+b4uShlHdUoh5/S5xUz1XHtt+TDHnR/v1
         b5Csm9/C98/zsuD/V1qh78sD4FO615Wypszypi5klrKjT6C3eTlxOYVGEEcM1ZC9EsYv
         ZCWORljjPuGs+BFbLm4S0A6GrmuuSF/EGYm/jXg7M0cXDS1e1975c8wUNs15GLwCFGzN
         KX19h8pqrtZwfmhe11gaXv9SfoCe3sDFNLzxnpPutlSEVjDO4i0svm4sHwJBnsWN0Si9
         m/kQ==
X-Gm-Message-State: APjAAAX+7VqO9nxLZLTtbGO6xlbg3uf3OUU0j724pxBSwB/fVzfMJS2G
        1mvq04jxmy6DxZmV/CfejzM=
X-Google-Smtp-Source: APXvYqxCFHRKJ1NM9qNyPNregnobOw0TuXyOxdwiFyDE+qAWmTn6UL2ZOgsrCCmpyYctzSdY3dqZqw==
X-Received: by 2002:aed:38c8:: with SMTP id k66mr4521497qte.181.1573070826186;
        Wed, 06 Nov 2019 12:07:06 -0800 (PST)
Received: from quaco.ghostprotocols.net (187-26-100-98.3g.claro.net.br. [187.26.100.98])
        by smtp.gmail.com with ESMTPSA id p54sm17710457qta.39.2019.11.06.12.07.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Nov 2019 12:07:05 -0800 (PST)
From:   Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>
X-Google-Original-From: Arnaldo Carvalho de Melo <acme@kernel.org>
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 2505140B1D; Wed,  6 Nov 2019 17:06:59 -0300 (-03)
Date:   Wed, 6 Nov 2019 17:06:59 -0300
To:     Masami Hiramatsu <mhiramat@kernel.org>
Cc:     Jiri Olsa <jolsa@redhat.com>, Namhyung Kim <namhyung@kernel.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [BUGFIX PATCH 2/4] perf probe: Filter out instances except for
 inlined subroutine and subprogram
Message-ID: <20191106200659.GC13829@kernel.org>
References: <157241935028.32002.10228194508152968737.stgit@devnote2>
 <157241937063.32002.11024544873990816590.stgit@devnote2>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <157241937063.32002.11024544873990816590.stgit@devnote2>
X-Url:  http://acmel.wordpress.com
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Wed, Oct 30, 2019 at 04:09:30PM +0900, Masami Hiramatsu escreveu:
> Filter out instances except for inlined_subroutine and subprogram
> DIE in die_walk_instances() and die_is_func_instance().
> This fixes an issue that perf probe sets some probes on calling
> address instead of a target function itself.
> 
> When perf probe walks on instances of an abstruct origin
> (a kind of function prototype of inlined function),
> die_walk_instances() can also pass a GNU_call_site (a GNU
> extension for call site) to callback. Since it is not
> an inlined instance of target function, we have to filter
> out when searching a probe point.
> 
> Without this patch, perf probe sets probes on call site
> address too.This can happen on some function which is marked
> "inlined", but has actual symbol. (I'm not sure why GCC mark
> it "inlined")

Thanks, tested before and after and applied,

- Arnaldo

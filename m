Return-Path: <SRS0=facv=24=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1524AC33C9E
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Jan 2020 06:31:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DF85F207E0
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Jan 2020 06:31:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="HTLGfKa3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727328AbgAGGbw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 Jan 2020 01:31:52 -0500
Received: from mail-pl1-f193.google.com ([209.85.214.193]:38446 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725267AbgAGGbv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Jan 2020 01:31:51 -0500
Received: by mail-pl1-f193.google.com with SMTP id f20so22800956plj.5
        for <linux-kernel@vger.kernel.org>; Mon, 06 Jan 2020 22:31:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=rIt7/qOuxCe+bTr1Wnd2LRcC3pVPsjTSIxV83hfUP1Y=;
        b=HTLGfKa3fcTvK5gwY2o/RhPYWBbfO/ht2LBc/0A5ZDV6Jl8DQmMireZs4lpyFet+1s
         bWrgKbUuN6rQ6bVsRI4UERCWy8WFDJcvggmt6lz8Xsj3daREfzHifvcpWTO9vr01l0Qu
         VpZBxP7hbYdDqbPmJft6S67k8jF43dSwLDAmEM3+yHLRoHwBMVIxNKeIgIjIYXPjxfh9
         viMDW1JHQEfDu+A5CPOdvKfVJQbuTIDUw7imlnnb4X+DdrH6MWPMTOb9qs3UguN/ZMZA
         yyiovwMX+DLfQmF6P9Up/D/AKAgLTW97bionDPYA2+Lo3akC6dhfV3n1tdkM5kKON18H
         WaYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=rIt7/qOuxCe+bTr1Wnd2LRcC3pVPsjTSIxV83hfUP1Y=;
        b=UCYm23bGn9RUmol4hLp0ZapVqxSkk1Nkhi9MPEELZOGsG8DxlK+XuW51v/p6+a9RNW
         RrsspxW0HgBWlTo24JlnotiGahYXF5RL/JfBUiPjnQRWyyndfVC2CcJKe1njHQH1vKGQ
         1lZyNtERieok0p8cKWk2RG32WS5yegODdM+DmqZWYjQp5GIAyevFjW//Kk8S274++0aI
         x9fGQk5cwcppns+WVwE86KogMbn/nKwkkHgD4YaAkGofgiyMlEBI2GC2GJS1u7WYWbXp
         ht9CewFo6eoLJZ0jOCwuFj3qmz5Da/u3OOJuzkOWQT4NHn65eGC5nDl0oxxEvAcSREqS
         ZHjQ==
X-Gm-Message-State: APjAAAWXd9uX5VPY7MuHPwOQxXKWLKmmgJAFqKLW50qW8FI7pFzOq5uD
        E8UBbh/aG0VBOuIUbHn9od7NjA==
X-Google-Smtp-Source: APXvYqwyymqg/dX8KMgo+H2hSC9clUay904mRdykr8CUp58TUkBswxSnHXPz+dMPSgZpbGd/FzVFiQ==
X-Received: by 2002:a17:90b:3004:: with SMTP id hg4mr47499847pjb.52.1578378711131;
        Mon, 06 Jan 2020 22:31:51 -0800 (PST)
Received: from localhost ([122.172.26.121])
        by smtp.gmail.com with ESMTPSA id y197sm81887026pfc.79.2020.01.06.22.31.49
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 06 Jan 2020 22:31:50 -0800 (PST)
Date:   Tue, 7 Jan 2020 12:01:48 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     =?utf-8?B?TWljaGHFgiBNaXJvc8WCYXc=?= <mirq-linux@rere.qmqm.pl>
Cc:     Viresh Kumar <vireshk@kernel.org>, Nishanth Menon <nm@ti.com>,
        Stephen Boyd <sboyd@kernel.org>, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] opp: fix of_node leak for unsupported entries
Message-ID: <20200107063148.lr2s65igfncbkpxx@vireshk-i7>
References: <a8060fe5b23929e2e5c9bf5735e63b302124f66c.1578077228.git.mirq-linux@rere.qmqm.pl>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <a8060fe5b23929e2e5c9bf5735e63b302124f66c.1578077228.git.mirq-linux@rere.qmqm.pl>
User-Agent: NeoMutt/20180716-391-311a52
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 03-01-20, 20:36, Michał Mirosław wrote:
> When parsing OPP v2 table, unsupported entries return NULL from
> _opp_add_static_v2().

Please fix that and return something sensible from there.

> In this case node reference is leaked.
> Make _opp_add_static_v2() always assume ownership of the reference
> to fix this.

The ownership lies with the routine which took the reference in the first place.

-- 
viresh

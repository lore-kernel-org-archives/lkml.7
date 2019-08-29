Return-Path: <SRS0=brkd=WZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EA88CC3A5A1
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Aug 2019 00:27:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B3D97215EA
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Aug 2019 00:27:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GsjSJvpf"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726975AbfH2A1y (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 28 Aug 2019 20:27:54 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:45289 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725873AbfH2A1x (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Aug 2019 20:27:53 -0400
Received: by mail-pf1-f193.google.com with SMTP id w26so815423pfq.12;
        Wed, 28 Aug 2019 17:27:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=+FnKt6T+ltE8w3yLy1h9tF886M9S45rP25oiOveKiPQ=;
        b=GsjSJvpfeS5lqXKDFc6FVuaL98JD5Wymo3Lbqr26yCOctql4nM8K7m43/YzFJ25tCa
         XRnIlBVTgCCa7GpBgbs+0vYz5kuwLZ6NUe0LA7qEMv4qb2oMzH5HXMD6VVt5NjV1Wnlk
         SF+xwwb5UnvhqkeLyaOO8Azi7QTOhGGcRlLl3CVViQ3OBSbm2voGPbH0uNafLXI9pN8k
         p1HSPtbGO/pc8153DuNXTJILp9RTNuHZJx0zs4hpwXRAdcEswrqj9donhrTYrefBB7RQ
         VFRNjEXtXq5OzGO0oRupaFTzDFO8s8r9sMDRv9+5B24znf0uA0hCtuuoAUtT7CAyvz4t
         CDSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=+FnKt6T+ltE8w3yLy1h9tF886M9S45rP25oiOveKiPQ=;
        b=d7tKff4vTT4kQv8lEQ0J7ZvN+kwGjZEB+2np7f/Ye8lGC4ytXBgCLgiDIC7+bSQJG7
         XxQncgwhzZD0pGQUWhnJWviyGAgj8MapmqLE+7ztALsoz5dzY78YFRuyKlRp31P80FJY
         Cs/cJhAqx9uaX+cThi5eiN+DpXuyKjpDCoGwW8bCKrncgf96zlCbtvKmSYPwJS7hyCVz
         l0AdH4LpEnEqE+DbyN+37520T4z+XAb+2Hdo+INizLcevZK59NyA9a5IyJwI9d+ToAdL
         9lQy49Va5JDR8ZyHp5CfNWRcEf8bJSGNBjdf8xVgXvD5NQxlVhi1wV2sPCxIUBUMq7LT
         FOIw==
X-Gm-Message-State: APjAAAWZLpz2xit3+87Vji2KzPpeMfiMbVnpGhOgvC3XYB5CgkkgfJNl
        ivy/JtwIeJEs9TOZ7UzB8pg=
X-Google-Smtp-Source: APXvYqw2OlfA6jZmJSpwaH818/I+5awEkLLuXP4oPnTJM9FuiV5ShzYywDl2G+kuK0f0/O2haKhnxQ==
X-Received: by 2002:aa7:8808:: with SMTP id c8mr7648608pfo.67.1567038473241;
        Wed, 28 Aug 2019 17:27:53 -0700 (PDT)
Received: from localhost ([39.7.51.95])
        by smtp.gmail.com with ESMTPSA id 65sm574401pff.148.2019.08.28.17.27.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Aug 2019 17:27:52 -0700 (PDT)
Date:   Thu, 29 Aug 2019 09:27:49 +0900
From:   Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>
To:     Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <uwe@kleine-koenig.org>
Cc:     Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Jani Nikula <jani.nikula@linux.intel.com>,
        Petr Mladek <pmladek@suse.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        "Enrico Weigelt, metux IT consult" <lkml@metux.net>,
        Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] vsprintf: introduce %dE for error constants
Message-ID: <20190829002749.GA530@jagdpanzerIV>
References: <20190827211244.7210-1-uwe@kleine-koenig.org>
 <20190828113216.p2yiha4xyupkbcbs@pathway.suse.cz>
 <87o9097bff.fsf@intel.com>
 <20190828120246.GA31416@jagdpanzerIV>
 <087e8e18-8044-27ef-b0bd-8a1093f53b32@rasmusvillemoes.dk>
 <20190828125951.GA12653@jagdpanzerIV>
 <61cd079f-d41b-75ec-9a1e-ef80f9d1f8fd@kleine-koenig.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <61cd079f-d41b-75ec-9a1e-ef80f9d1f8fd@kleine-koenig.org>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On (08/28/19 18:22), Uwe Kleine-König wrote:
> That is wrong. When you do
> 
> 	pr_err("There are no round tuits to give out: %dE\n", -ENOENT);
> 
> in a kernel that doesn't support %dE you get:
> 
> 	There are no round tuits to give out: -2E

OK. Good point.

	-ss

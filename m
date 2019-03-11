Return-Path: <SRS0=FxTY=RO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A0812C43381
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Mar 2019 17:14:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 65D13205F4
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Mar 2019 17:14:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=cmpxchg-org.20150623.gappssmtp.com header.i=@cmpxchg-org.20150623.gappssmtp.com header.b="cbnTo9uh"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727548AbfCKROG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Mar 2019 13:14:06 -0400
Received: from mail-yw1-f68.google.com ([209.85.161.68]:34610 "EHLO
        mail-yw1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726625AbfCKROF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Mar 2019 13:14:05 -0400
Received: by mail-yw1-f68.google.com with SMTP id x129so3532937ywc.1
        for <linux-kernel@vger.kernel.org>; Mon, 11 Mar 2019 10:14:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=y58oEk6VFS6vSzvCUZ1rAopBEFvhw4rM0vVvFY79z3w=;
        b=cbnTo9uhVT9wL0/pDjHdpqDCQAmDqAAWTT5Y5z3BS8FgIRZRCmrMBSupLQtrmwiEU7
         KNWY5PgO92GOlMjDPP0UOCN5cJxUoHP6F0cYtfYBH0kvGx0Df9p0KqeMeAinp7e6Hn7H
         qFeICoJOIUdbPnLvus51stmzJXaJ/+uInYfSGDOxkAxWBeJKtUvW2rdohxe2yz7qvTQ6
         0O1D0M5XS3k4/pk8AY5EFdwCn5gOgS7J1ZsHZ45xqR571yERkeULGtH3An/Fy/czxlTE
         94o1WvQc7t0r8iKPOxsSvgeCImOhz2aSP1OZVo2zCD6Jtc2HJuGJIQcB4TXESbv9wLGo
         hUUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=y58oEk6VFS6vSzvCUZ1rAopBEFvhw4rM0vVvFY79z3w=;
        b=l2FVBKH4oASXao64eC+Ytlck0YNm7Aa4bknIcWHrCy5GG48JMesa+KtrfPEK9SgSVh
         u23iPPcXZ6RVS0nkaYt0Ad+bUp3FKQSQ2kISfb9Kk3y/5iPsXWyFs+EMHThipDv/Uckc
         DlByEq4H4kb41on/Vn4zHXuZEKrLsDjiNLBIIF3G+gRvunSMU10xUwVj0ZwiW0tXI28p
         Pe8JkzhosBnNljnsZU39PYFsVdO3nZ+SMvAZ+i3jeqb+UehJlyJa4GZkQBd8iAI1nQ5L
         LlV6tTVfv7GgGf/ldeGPoqLhiNb+CBQPCW8DXDiojyCEYQkDNeDC9jXS0i5QpD/iRYdZ
         s2JA==
X-Gm-Message-State: APjAAAWN5tpt9GXtCFIn3VOAHlJ2UoNIZagt/PSjYPPQRM8SjcGMmzbl
        ci/4ilJ2cro2u2TFuQ0/mxj4JA==
X-Google-Smtp-Source: APXvYqwbksG6pV6NHQrSLAiG/AmNqN4B0KIeTZpNK2uAn6ch6pNfdQ5TPs6pHjzKEEq0BGkEHZCHyA==
X-Received: by 2002:a81:a055:: with SMTP id x82mr26386742ywg.177.1552324444748;
        Mon, 11 Mar 2019 10:14:04 -0700 (PDT)
Received: from localhost ([2620:10d:c091:200::1:3c60])
        by smtp.gmail.com with ESMTPSA id j10sm1933530ywb.39.2019.03.11.10.14.03
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 11 Mar 2019 10:14:03 -0700 (PDT)
Date:   Mon, 11 Mar 2019 13:14:02 -0400
From:   Johannes Weiner <hannes@cmpxchg.org>
To:     Roman Gushchin <guroan@gmail.com>
Cc:     linux-mm@kvack.org, kernel-team@fb.com,
        linux-kernel@vger.kernel.org, Tejun Heo <tj@kernel.org>,
        Rik van Riel <riel@surriel.com>,
        Michal Hocko <mhocko@kernel.org>, Roman Gushchin <guro@fb.com>
Subject: Re: [PATCH 1/5] mm: prepare to premature release of
 memcg->vmstats_percpu
Message-ID: <20190311171402.GA10823@cmpxchg.org>
References: <20190307230033.31975-1-guro@fb.com>
 <20190307230033.31975-2-guro@fb.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190307230033.31975-2-guro@fb.com>
User-Agent: Mutt/1.11.3 (2019-02-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 07, 2019 at 03:00:29PM -0800, Roman Gushchin wrote:
> Prepare to handle premature release of memcg->vmstats_percpu data.
> Currently it's a generic pointer which is expected to be non-NULL
> during the whole life time of a memcg. Switch over to the
> rcu-protected pointer, and carefully check it for being non-NULL.
> 
> This change is a required step towards dynamic premature release
> of percpu memcg data.
> 
> Signed-off-by: Roman Gushchin <guro@fb.com>

Acked-by: Johannes Weiner <hannes@cmpxchg.org>

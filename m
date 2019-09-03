Return-Path: <SRS0=TDKO=W6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_2 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CEF9AC3A5A2
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Sep 2019 15:42:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A6DA123711
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Sep 2019 15:42:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lca.pw header.i=@lca.pw header.b="EzcjS1ne"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729832AbfICPm0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 Sep 2019 11:42:26 -0400
Received: from mail-qt1-f193.google.com ([209.85.160.193]:46853 "EHLO
        mail-qt1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727107AbfICPmZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Sep 2019 11:42:25 -0400
Received: by mail-qt1-f193.google.com with SMTP id j15so20414606qtl.13
        for <linux-kernel@vger.kernel.org>; Tue, 03 Sep 2019 08:42:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lca.pw; s=google;
        h=message-id:subject:from:to:cc:date:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=EHMZPUP68y2z5iguVqfzfNFlYo+Wg20UbTwXQGqtd0o=;
        b=EzcjS1ne4C9CO1P3CFCR3w0b95IZNPd6WLZr0ngkGQpYO3cX3IyLFr+dohcEyQLsns
         SwiDwwkeIYFf7VUVU35KLiQv93fjflQ44R93x0WULpKB+q7gsueMZiVGyxBXgsNmsQv9
         7sQsKdTDOxerv9Ll27PozXLJKKOuv0XM0eSXw0EGjeFTqH4pXSYcLealkPpszkzwHYW5
         2si2Cply4cTtIYbVZ9v8aAhWY50BSs1yApFvgqenwcn1hTxY30s5LcRLk2GsZwhaVqtp
         FzaGA+tBBm85RAOhG/PhDnSFMeq2OfGk7wzz0ZZ9iLycsN2ny7PDQd6MvO1im0waXF/f
         oH8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=EHMZPUP68y2z5iguVqfzfNFlYo+Wg20UbTwXQGqtd0o=;
        b=BUwe+SDX7suHqHFoLrnLTsC+Nnyru8m5IgSiarM9r50q2sltnjNf1m3RWrOFKnuVIz
         s8z8Wg2wZ2C59q8+4AFG9PpalMf+yaBpcBYSafuH03yUWObcY+6fdoxq8scBs3OSU9MI
         efJEvqcvVMuPQm6srfza/AlUboFdcmjeYI/8BubA9ExgvCxwLOtFkjtifYbBmtFnkeT+
         gOpq+0hm1g+5KrtlAD7EoKCfqAP2dqRCo1kkF6cSwuFBX29nAqlsHLJJfgOwxgQpbNgO
         54Kc99Jzyl1ipjzmZc5Cj6OhjhRgqVl1D46jyZ06MqyzaodZdOeqq91jtACBi1YaGmN7
         PbwQ==
X-Gm-Message-State: APjAAAWRhBfdO2yZ2mfl4jCjRtaGGS0ZpSew0U9mDtWOGbqO0TUbfY1m
        Kdk86gsLcMOP0UqhBq/TMQY24w==
X-Google-Smtp-Source: APXvYqw+IwNKrHV+dGx3RobeKrDl8nlXyE0LPhn/oZzdxlaGBn0SEZqwK+nCGwY7RbgaekZ6W8Fyhg==
X-Received: by 2002:ac8:92d:: with SMTP id t42mr7369525qth.206.1567525344750;
        Tue, 03 Sep 2019 08:42:24 -0700 (PDT)
Received: from dhcp-41-57.bos.redhat.com (nat-pool-bos-t.redhat.com. [66.187.233.206])
        by smtp.gmail.com with ESMTPSA id f83sm841590qke.80.2019.09.03.08.42.23
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 03 Sep 2019 08:42:24 -0700 (PDT)
Message-ID: <1567525342.5576.60.camel@lca.pw>
Subject: Re: [PATCH] net/skbuff: silence warnings under memory pressure
From:   Qian Cai <cai@lca.pw>
To:     Michal Hocko <mhocko@kernel.org>,
        Eric Dumazet <eric.dumazet@gmail.com>
Cc:     davem@davemloft.net, netdev@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Date:   Tue, 03 Sep 2019 11:42:22 -0400
In-Reply-To: <20190903132231.GC18939@dhcp22.suse.cz>
References: <1567177025-11016-1-git-send-email-cai@lca.pw>
         <6109dab4-4061-8fee-96ac-320adf94e130@gmail.com>
         <1567178728.5576.32.camel@lca.pw>
         <229ebc3b-1c7e-474f-36f9-0fa603b889fb@gmail.com>
         <20190903132231.GC18939@dhcp22.suse.cz>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.22.6 (3.22.6-10.el7) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2019-09-03 at 15:22 +0200, Michal Hocko wrote:
> On Fri 30-08-19 18:15:22, Eric Dumazet wrote:
> > If there is a risk of flooding the syslog, we should fix this generically
> > in mm layer, not adding hundred of __GFP_NOWARN all over the places.
> 
> We do already ratelimit in warn_alloc. If it isn't sufficient then we
> can think of a different parameters. Or maybe it is the ratelimiting
> which doesn't work here. Hard to tell and something to explore.

The time-based ratelimit won't work for skb_build() as when a system under
memory pressure, and the CPU is fast and IO is so slow, it could take a long
time to swap and trigger OOM.

I suppose what happens is those skb_build() allocations are from softirq, and
once one of them failed, it calls printk() which generates more interrupts.
Hence, the infinite loop.

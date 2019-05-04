Return-Path: <SRS0=6aFo=TE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E545AC43219
	for <linux-kernel@archiver.kernel.org>; Sat,  4 May 2019 11:07:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AC0C6205ED
	for <linux-kernel@archiver.kernel.org>; Sat,  4 May 2019 11:07:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=netronome-com.20150623.gappssmtp.com header.i=@netronome-com.20150623.gappssmtp.com header.b="P3x+TuZj"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727201AbfEDLHk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 4 May 2019 07:07:40 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:41384 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726694AbfEDLHk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 4 May 2019 07:07:40 -0400
Received: by mail-pg1-f193.google.com with SMTP id z3so307343pgp.8
        for <linux-kernel@vger.kernel.org>; Sat, 04 May 2019 04:07:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=netronome-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:in-reply-to:references
         :organization:mime-version:content-transfer-encoding;
        bh=nl39g1T53hJKf6/e5lRm3PMMlr45uQylbYUKdQVwCZQ=;
        b=P3x+TuZjO/Tiiyl0gQtR335ZstOaMNPLqE/hLK7B2kqG7r2mekcmcVcn4e7G2UB1X0
         DoppWzS5KQ0cTy4uQGWi8NejpmyzjJlm3NZvFtW5+4Som8PwKpi2/rf6kT7r1kgjiwdL
         jtQRhcm8vpn7A5vRYuLPBlsjNDO7TgVyq7+EFF8SSGzYqsY2ZBj3qV6GaL+Ov1xpw2v3
         GbtR018SSuxz73HhyIG5AYrMdjV3UwwO/TRBPDi7ugEMLI8K4jM/RqIJQfbHKzGlZgam
         9HCVdI/V4zXJYv7uozm+315T8hn+AlvvwgPvDCkTWITP2g7fvNmdDuh5WzI8Q7kkN5Ts
         7+9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:in-reply-to
         :references:organization:mime-version:content-transfer-encoding;
        bh=nl39g1T53hJKf6/e5lRm3PMMlr45uQylbYUKdQVwCZQ=;
        b=qOzi+FABXT23jU30xGAWHM1InjP9OEOCGsxT34c26gdq1c4K+0UfkFPY5VO1NPi2Ah
         KRJaxo+qIHsyldqzDe6m2JnMN9iMKyM9RFEkAA5w2YpTnhHSxinVWdiCVSOu9cXW6vS6
         59CTo2za7pC35pvia9qggVGBvzYiAt5tU1n6VwYTI6WBfLoZrZMbb8t5N0pBH+yyxBrf
         W94/wFVg9GG6px58ti6K1/L/WxCombYiDbzRJazG/h/5K2G83sSBWWk/Tuw0Ou/tbg1W
         r4dGUGnEFpVi0twJ1c9amba4yM28bni6oeZdKAEljxQhuPNAI/0sG/a1XR6mfvY5Ivsr
         h8xg==
X-Gm-Message-State: APjAAAUhNtJMtZXuDlBzt8hgvzcq4EXJhKyXr40AePVxvtqmI9E5cd2R
        wJObgKfm60p9RknyqSq8aP8FPA==
X-Google-Smtp-Source: APXvYqzsaN9URwb267F102CSdh+nIvxMj4k9Y3AWShpurEAK0b2y5Tak9/sA6WKLkkL2z1Vdv6r2hg==
X-Received: by 2002:a62:62c2:: with SMTP id w185mr18628880pfb.237.1556968059359;
        Sat, 04 May 2019 04:07:39 -0700 (PDT)
Received: from cakuba.netronome.com (ip-174-155-149-146.miamfl.spcsdns.net. [174.155.149.146])
        by smtp.gmail.com with ESMTPSA id j19sm5779633pfh.41.2019.05.04.04.07.37
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Sat, 04 May 2019 04:07:39 -0700 (PDT)
Date:   Sat, 4 May 2019 07:07:24 -0400
From:   Jakub Kicinski <jakub.kicinski@netronome.com>
To:     YueHaibing <yuehaibing@huawei.com>
Cc:     <davem@davemloft.net>, <linux-kernel@vger.kernel.org>,
        <netdev@vger.kernel.org>
Subject: Re: [PATCH net-next] netdevsim: Make nsim_num_vf static
Message-ID: <20190504070724.439eab34@cakuba.netronome.com>
In-Reply-To: <20190504081207.22764-1-yuehaibing@huawei.com>
References: <20190504081207.22764-1-yuehaibing@huawei.com>
Organization: Netronome Systems, Ltd.
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 4 May 2019 16:12:07 +0800, YueHaibing wrote:
> Fix sparse warning:
> 
> drivers/net/netdevsim/bus.c:253:5: warning:
>  symbol 'nsim_num_vf' was not declared. Should it be static?
> 
> Reported-by: Hulk Robot <hulkci@huawei.com>
> Signed-off-by: YueHaibing <yuehaibing@huawei.com>

Acked-by: Jakub Kicinski <jakub.kicinski@netronome.com>

Thanks!

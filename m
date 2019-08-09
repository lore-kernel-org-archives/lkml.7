Return-Path: <SRS0=0SVE=WF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 55FA6C31E40
	for <linux-kernel@archiver.kernel.org>; Fri,  9 Aug 2019 16:00:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 014FF20C01
	for <linux-kernel@archiver.kernel.org>; Fri,  9 Aug 2019 16:00:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="AdaoX5kf"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2436937AbfHIQA4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 9 Aug 2019 12:00:56 -0400
Received: from mail-pl1-f194.google.com ([209.85.214.194]:38848 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2436926AbfHIQAy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Aug 2019 12:00:54 -0400
Received: by mail-pl1-f194.google.com with SMTP id m12so6519712plt.5
        for <linux-kernel@vger.kernel.org>; Fri, 09 Aug 2019 09:00:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=txjrO/ukHW/V8tkDPdv+tXjuE6UndjIzFZV6EbQgweI=;
        b=AdaoX5kfmRRDO75Blops/TNpQi1Me4FTv/2FQvDgEKKZp73pwIHbiJhj1LBW35UKjN
         0YrzgMVnJfzQJInbm18v3QSJjKnHyqJK8lenJ4EsMt9s+3uHmu8+8dQKGhxtFuQk1oxg
         BmTveXlUtQ0c3pOv88F7TMvBGqZSPK2Ti4pQFZlvUF0nrr77ydJ/hgcmKIPrz6v7YCVY
         vCNJc97r6WNUoDUs4YnuedPG9iO6n3CJyT3G9y1fzStGndf02iKG713R9nfU9klw0YFV
         YsT5ZBo+CCkxSq06baoAd9WG3TWrbB6yN+6b7dJf/PbQABQPU1DrlM5r8Ze3jD02Pq5U
         fP7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=txjrO/ukHW/V8tkDPdv+tXjuE6UndjIzFZV6EbQgweI=;
        b=jfde8QEg0IhkYyWiCbpEYOueYuVTEVeg8P78noLveET2+NxPreq6KO8CILpA9+I/h6
         B4KJQF+o+4f4IggtZu5E2NHlr42ViuLU+O5Nl3Hh32pLtGYFIxUNG7/ddSmw/RMgnjmp
         +G6wCmKJzEZT8+0s2xvXLkF+HC7O2pK5grIIDx+D46LaxRfUjjN3c9CsxGT1dJc0wkcd
         MYOs5+gaQwB0nAKKXvZAwcNONOG7OLqCg+QOMvjMQVjkmSYsfSjtiIF3nKjpwEF5izu6
         +A9hOFnTGFdB9k7KSEP4O4oE+K/0WkfsV3eNPXYA41dwz5g5ZUgbUbLDa9xpDj9XLpbt
         oCFw==
X-Gm-Message-State: APjAAAUnhq86B88bQZjnYOCAbRaNfBi+jHJH8cTI8abvoyicnul5QtrX
        o6ooIZOTVlWfl4J3nm9I8N/WepEvda0tzg==
X-Google-Smtp-Source: APXvYqymjDUUZeDcn23AB/pb/kVfmj76shSiPkafdWeOx6i3oPDMLrepqSpwPiHzizPqTJzC6CW8VA==
X-Received: by 2002:a17:902:ab96:: with SMTP id f22mr13267254plr.147.1565366453173;
        Fri, 09 Aug 2019 09:00:53 -0700 (PDT)
Received: from ?IPv6:2605:e000:100e:83a1:8460:a1eb:bc6a:7081? ([2605:e000:100e:83a1:8460:a1eb:bc6a:7081])
        by smtp.gmail.com with ESMTPSA id p68sm115840887pfb.80.2019.08.09.09.00.51
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 09 Aug 2019 09:00:52 -0700 (PDT)
Subject: Re: [PATCH v2 0/2] Lookup PCS offset, and cleanup hex formatting
To:     Stephen Douthit <stephend@silicom-usa.com>
Cc:     "linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <20190809144827.1609-1-stephend@silicom-usa.com>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <d73ec81d-52d3-816f-0a3b-fa1f493df53a@kernel.dk>
Date:   Fri, 9 Aug 2019 09:00:50 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190809144827.1609-1-stephend@silicom-usa.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/9/19 7:48 AM, Stephen Douthit wrote:
> v2: Fix case of hex values
> 
> Stephen Douthit (2):
>    ata: ahci: Lookup PCS register offset based on PCI device ID
>    ata: ahci: Cleanup hex values to use lowercase everywhere
> 
>   drivers/ata/ahci.c | 62 ++++++++++++++++++++++++++++++++++++----------
>   1 file changed, 49 insertions(+), 13 deletions(-)

Thanks, applied.

-- 
Jens Axboe


Return-Path: <SRS0=SZ1Q=SM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4EC50C10F11
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Apr 2019 18:17:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 24D512077C
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Apr 2019 18:17:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="j7Wuoud1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730245AbfDJSRV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 10 Apr 2019 14:17:21 -0400
Received: from mail-pg1-f182.google.com ([209.85.215.182]:35574 "EHLO
        mail-pg1-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729205AbfDJSRU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Apr 2019 14:17:20 -0400
Received: by mail-pg1-f182.google.com with SMTP id g8so2046947pgf.2
        for <linux-kernel@vger.kernel.org>; Wed, 10 Apr 2019 11:17:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=BfbaaiXHZN6UJr+RjXOEU+oiazV3hLAf19xreHTSUe8=;
        b=j7Wuoud1m5nSUcRDLWuzK67TYk8bTttA8o1bgZG/Bf7HN0U2IQqTgDgzXCU+3bV1VJ
         93mbvAH7i2AN0fuNU4ivPeU9k2blSToQtTphs8Gxhfgs3XcAjOymSKJVlXsV/R+FFkXp
         JFWDKcdchk6nweaI9slGE70BDctyvRnCkdwe7/CxxVThxmSL5lVYlNYB/8VoxRxMPz30
         MFFTgS4quUp9Z8vUZ0XrHLY+Klc56VDQSm1LspU3Kbgwr4Vn84PDMiHJumSiCXjBMg/n
         zZYzvL71/pCsxKsQ/VaRvB0U+RwM96XLLqOaO55HnJjT0qZ3UQY/YWnb35wfux0sT1Ko
         l9ww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=BfbaaiXHZN6UJr+RjXOEU+oiazV3hLAf19xreHTSUe8=;
        b=aeuGulv/5IH+gwoTbgYfMDReAx2SGYZpmuqYtXM4lZN+B3GO6YUgE5nKWbcIpO8FCB
         Y1FRRCUg6jck3EI/Kft36EAXjNtaQ6FsMeSLWNa0BoO3P9UfRaJOJXPsF2ylm1t3hJqO
         erU5hW36B1RWVhotjXGWMuerklezqNuAuPscHkkN+Sk5SEOUXLrgnxjTe/gNpnVKJFKI
         EwegjWfc3xGWQgoWKTaGMVB39rf9OxGZdu6TR8G4vQCAjosqzZptJA5cozfrKz0n166J
         iBv4KqlXush5jlvwETYRP9H8XVACzKa8lWt3UjodEK1jQwP6qWw5eAbNr/+DOCTz9gWa
         gcrQ==
X-Gm-Message-State: APjAAAWgph8Mn9NoFj85KL+3VLf+IAA+U0eHm1/1azOYpUVXRzKEoKTG
        x2hfvs9L03SFvPSMd2OHNOXsyXiom9gYUw==
X-Google-Smtp-Source: APXvYqxJkgZeqQSsr+COLbo4Mx/FUgwtHBqzUV1OBtqOeY71a480mKPTc02RzbByfV2NKZLvl35VjQ==
X-Received: by 2002:a63:4f52:: with SMTP id p18mr41972003pgl.333.1554920239816;
        Wed, 10 Apr 2019 11:17:19 -0700 (PDT)
Received: from [192.168.1.121] (66.29.188.166.static.utbb.net. [66.29.188.166])
        by smtp.gmail.com with ESMTPSA id b26sm69307872pgn.4.2019.04.10.11.17.17
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 10 Apr 2019 11:17:18 -0700 (PDT)
Subject: Re: [GIT PULL] lightnvm: pblk: fix crash in pblk_end_partial_read due
 to multipage bvecs
To:     =?UTF-8?Q?Matias_Bj=c3=b8rling?= <mb@lightnvm.io>
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        Hans Holmberg <hans.holmberg@cnexlabs.com>
References: <20190410175643.11000-1-mb@lightnvm.io>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <09b7919d-2ae3-eded-0abb-472c7f642c4d@kernel.dk>
Date:   Wed, 10 Apr 2019 12:17:16 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190410175643.11000-1-mb@lightnvm.io>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/10/19 11:56 AM, Matias Bjørling wrote:
> From: Hans Holmberg <hans.holmberg@cnexlabs.com>
> 
> The introduction of multipage bio vectors broke pblk's partial read
> logic due to it not being prepared for multipage bio vectors.
> 
> Use bio vector iterators instead of direct bio vector indexing.

Applied, thanks.

-- 
Jens Axboe


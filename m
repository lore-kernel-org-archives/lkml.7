Return-Path: <SRS0=Ecng=WJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2B76DC433FF
	for <linux-kernel@archiver.kernel.org>; Tue, 13 Aug 2019 15:00:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E7E7F205F4
	for <linux-kernel@archiver.kernel.org>; Tue, 13 Aug 2019 15:00:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="dzbIYMoR"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729880AbfHMPAD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 13 Aug 2019 11:00:03 -0400
Received: from mail-ot1-f65.google.com ([209.85.210.65]:39123 "EHLO
        mail-ot1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729060AbfHMPAD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Aug 2019 11:00:03 -0400
Received: by mail-ot1-f65.google.com with SMTP id b1so5475248otp.6
        for <linux-kernel@vger.kernel.org>; Tue, 13 Aug 2019 08:00:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google;
        h=date:from:to:cc:subject:in-reply-to:message-id:references
         :user-agent:mime-version;
        bh=OBSBHOWBi0TEv/V0/1s9tAyHS9rLQ+x44wNZD/HrkLA=;
        b=dzbIYMoRiy9vx9rKEBuPcH/mGrArbJfiwJ7ot057oEwafi1mYopo5TS45ZGfU2Tmwe
         SLBPqgIMOrEkCecn0w57P/yGOR/d0N23xNAgHwxYLkMRv5H+NhgbobUFp2ICtHe5BRH5
         GbIm4qBk6hMIm+NPgLSYJgtDYxGY7QDf7AIpMTT6sktBJYnpLjG3FK3zI1obJ75IUzvc
         CwZwYPupTtwIOGSkKBn71MZLcIk+Gw1yi1TZVHVhBvmHg6zL06/3TKtlmSTECtHfpSl+
         SYIopnbJP7tqKWRjn6KfBfDEEk9A3lazC9zFZFqtAQ4BKm6TdFY1hy6XJ1fekCbmULHI
         RG6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:in-reply-to:message-id
         :references:user-agent:mime-version;
        bh=OBSBHOWBi0TEv/V0/1s9tAyHS9rLQ+x44wNZD/HrkLA=;
        b=oKkr9k6TPOUKcUW5356NVbQpkv5tNeEfyDk1Dnfop9OIArwoiuoJeLrHfllb9v4KZJ
         tofOIiGymrIIvxXFLa8kIzj7i+SgjHOeRBJyoldOb32w3R1Bm0NkbnvBsioerEzAF3XP
         Ei7Jb/OI4C8ByUeD/5gmxN6WfDRjqve1JgOUgCmKxXBxNNYeFSh+NCXiwEZmwh4fFlAr
         xFrTZLKaIHy4NRPx551dbCPgSngu34c9Tqdq+UFhVCJZ06EvprPIzRDSasXgQWUM5mkw
         Sbv5RdQs6ZLrZWocdepgbeqtSWFXQTt5Qk+RRHXl6tD5GwOp8Umc9N7W754Lpzdm0zid
         5n7Q==
X-Gm-Message-State: APjAAAUwCA8c64gGMFAuAXK6XMeYdIBcs+rVMQt3VKDWaz5Dick8gRn/
        cLiEeURV2eVFpun1eOa9HDPflA==
X-Google-Smtp-Source: APXvYqzyvc5FubiG3PND2CV+AkpmsPRzV4pLljW3e2iTjvTSUTJIOAqABu4MArwAhjoI85WgQ/29gQ==
X-Received: by 2002:a05:6602:2193:: with SMTP id b19mr35481897iob.113.1565708402482;
        Tue, 13 Aug 2019 08:00:02 -0700 (PDT)
Received: from localhost (c-73-95-159-87.hsd1.co.comcast.net. [73.95.159.87])
        by smtp.gmail.com with ESMTPSA id j5sm81309698iom.69.2019.08.13.08.00.01
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Tue, 13 Aug 2019 08:00:01 -0700 (PDT)
Date:   Tue, 13 Aug 2019 08:00:00 -0700 (PDT)
From:   Paul Walmsley <paul.walmsley@sifive.com>
X-X-Sender: paulw@viisi.sifive.com
To:     Bin Meng <bmeng.cn@gmail.com>
cc:     Albert Ou <aou@eecs.berkeley.edu>,
        Palmer Dabbelt <palmer@sifive.com>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org
Subject: Re: [PATCH] riscv: dts: sifive: Add missing "clock-frequency" to
 cpu0/cpu1 nodes
In-Reply-To: <1565158960-12240-1-git-send-email-bmeng.cn@gmail.com>
Message-ID: <alpine.DEB.2.21.9999.1908130758550.27195@viisi.sifive.com>
References: <1565158960-12240-1-git-send-email-bmeng.cn@gmail.com>
User-Agent: Alpine 2.21.9999 (DEB 301 2018-08-15)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 6 Aug 2019, Bin Meng wrote:

> Add the missing "clock-frequency" property to the cpu0/cpu1 nodes
> for consistency with other cpu nodes.
> 
> Signed-off-by: Bin Meng <bmeng.cn@gmail.com>

Is this being driven by a schema validator warning?  If not, and this 
property isn't required, it seems better just to drop it.  It seems 
useless?


- Paul

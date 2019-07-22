Return-Path: <SRS0=CEgE=VT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5F129C7618F
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Jul 2019 21:48:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2F1F321951
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Jul 2019 21:48:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="MB1brrVu"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732898AbfGVVsn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 22 Jul 2019 17:48:43 -0400
Received: from mail-io1-f66.google.com ([209.85.166.66]:38777 "EHLO
        mail-io1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732820AbfGVVsm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Jul 2019 17:48:42 -0400
Received: by mail-io1-f66.google.com with SMTP id j6so2235998ioa.5
        for <linux-kernel@vger.kernel.org>; Mon, 22 Jul 2019 14:48:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google;
        h=date:from:to:cc:subject:in-reply-to:message-id:references
         :user-agent:mime-version;
        bh=MNd1s/RK3q606uXXVJTbjFYHj9TY0k28b7cB1e/7MAQ=;
        b=MB1brrVu2uq0F45QssDCMFp8dE+S7FCP6t7lDN60jYhQmIfjMkzXGWmmi3kXOz3zud
         3WdjyM0+VEXASec8IoI9iUuYFkw6vnDDCm0F1OcreqlhgZN4yzXedLc/6WYFGCJewnHM
         m8uapPWOfQJawreTjO1fzmrLeqYvuFfJfom7Lq5mYYgLRpxRNii/J6z58qLjlD5dcfOz
         US9ROESCUbI1jO0cCkTklAaVXlSQYbiaYkE2D7LNmRcNJazb84NTwPnG83vVmYosRRkR
         dq6e6yfBx2sTbOu4SqzCEWon4Jv/glnD/edbvvXlwzlnHJ7GxrxAe2BPd4cvxxzL/183
         GcBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:in-reply-to:message-id
         :references:user-agent:mime-version;
        bh=MNd1s/RK3q606uXXVJTbjFYHj9TY0k28b7cB1e/7MAQ=;
        b=i9IJKryQYt7JLMnzeQkKu3fVKNmKXlCBZSbw/UWaeV69nMkczB8RyYclTFdxMrjaHR
         cTvXswCLAZpsxx+xynntRNN4+T8nymxmz3/uzqsEeZk4nVkIrTKHRpiwaxrRkhr/kfpc
         2+ym65hxsASh+9NCFj6hcP2Huc97f9xSnub75O09jNWVO/3xyGPKA5DtjAjhCEQu2x9O
         dPGrpZ+jiJuB/2sKI+vUOFulJD1tFGS974+ii4JFyaYAbiDpB5ovfIWRYtFS6wspTLLu
         apELJImwBIqKaKa04p05KOpD0YoPdsDQSNonS1Py85nDgc2EhYpvCN5599NruGnf3d+J
         euAw==
X-Gm-Message-State: APjAAAVqcXEOHteItbBf7g5uWhqpTjZxQoIHXSa3IW5l4tDTuanrLXcw
        cageNceO62sYm7NiD14BNZTHMg==
X-Google-Smtp-Source: APXvYqxULiroOZ1sO9gKcnArywEPT23iTB5ofTsbzS21+NJj0kZoYkSm7Q/+HCczMOrY+80+gzO+2Q==
X-Received: by 2002:a5d:9b1a:: with SMTP id y26mr1829264ion.238.1563832121767;
        Mon, 22 Jul 2019 14:48:41 -0700 (PDT)
Received: from localhost (67-0-62-24.albq.qwest.net. [67.0.62.24])
        by smtp.gmail.com with ESMTPSA id t14sm34809856ioi.60.2019.07.22.14.48.41
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Mon, 22 Jul 2019 14:48:41 -0700 (PDT)
Date:   Mon, 22 Jul 2019 14:48:40 -0700 (PDT)
From:   Paul Walmsley <paul.walmsley@sifive.com>
X-X-Sender: paulw@viisi.sifive.com
To:     Yash Shah <yash.shah@sifive.com>, davem@davemloft.net
cc:     sagar.kadam@sifive.com, robh+dt@kernel.org, netdev@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-riscv@lists.infradead.org, mark.rutland@arm.com,
        palmer@sifive.com, aou@eecs.berkeley.edu,
        nicolas.ferre@microchip.com, ynezz@true.cz,
        sachin.ghadi@sifive.com, andrew@lunn.ch
Subject: Re: [PATCH 3/3] riscv: dts: Add DT node for SiFive FU540 Ethernet
 controller driver
In-Reply-To: <1563534631-15897-3-git-send-email-yash.shah@sifive.com>
Message-ID: <alpine.DEB.2.21.9999.1907221446340.5793@viisi.sifive.com>
References: <1563534631-15897-1-git-send-email-yash.shah@sifive.com> <1563534631-15897-3-git-send-email-yash.shah@sifive.com>
User-Agent: Alpine 2.21.9999 (DEB 301 2018-08-15)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 19 Jul 2019, Yash Shah wrote:

> DT node for SiFive FU540-C000 GEMGXL Ethernet controller driver added
> 
> Signed-off-by: Yash Shah <yash.shah@sifive.com>

Thanks, queuing this one for v5.3-rc with Andrew's suggested change to 
change phy1 to phy0.

Am assuming patches 1 and 2 will go in via -net.


- Paul

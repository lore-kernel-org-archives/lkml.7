Return-Path: <SRS0=RWM+=ZG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,URIBL_SBL,URIBL_SBL_A,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 84CCCC432C3
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Nov 2019 07:31:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 56A7A206E1
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Nov 2019 07:31:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="f/dc+DTz"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726969AbfKNHb5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Nov 2019 02:31:57 -0500
Received: from mail-ot1-f68.google.com ([209.85.210.68]:35089 "EHLO
        mail-ot1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725852AbfKNHb4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Nov 2019 02:31:56 -0500
Received: by mail-ot1-f68.google.com with SMTP id n19so248749otk.2
        for <linux-kernel@vger.kernel.org>; Wed, 13 Nov 2019 23:31:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google;
        h=date:from:to:cc:subject:in-reply-to:message-id:references
         :user-agent:mime-version;
        bh=sp13pugco4jeUE50+6Uu51koFZjpGmyiNJG3fNaiPd4=;
        b=f/dc+DTzMkOZ4pCueMlTZ2zYgXFCESUH66S+6oBdUDG0ckAOvDUBVbwCy2azw0t4Gt
         Y6ySKwQdgG/d79vyUQW1Ui0JRoyKDAajPdI2Bnp3Kv8Xng0DpLHiM3RgA3cl3mKTqzW/
         AW6AhYnQDuSXK45iHFZD7zxbq5DRD2WKyip6RDsmULomo8m2az5CgBlZp8K6/LhqHC1p
         +AQ299E7pvjaSWy7MifuxpSDq2YvaW+CDDwr1Sq1OYx5TeExkik33xKuY5HqlMQA9SI3
         ht371LC/Q27u+Ddi01O3CIdpvQGHN9LWXRJa9NxOUTgH/N6cLJct70OfgsocJI5+xncA
         01Ww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:in-reply-to:message-id
         :references:user-agent:mime-version;
        bh=sp13pugco4jeUE50+6Uu51koFZjpGmyiNJG3fNaiPd4=;
        b=SFhAaYfwbpFYu32/trYt921RlpH8V6atMOB5YVhkhTwbIwdeX5JZzvT5lMcepj06lw
         FIR2RMJJdlThul6AjVxvl9GD8i/jeAygpXQmQjJDGAfNvQ3oKX070/drGsPdKFF/UaXG
         Tg3FGqfUoiB0vthG7zoZ7xETj8Fg1dfwsC7ksIQ/ZGjb6c7VA9E2Nb8Tx7PgOu6MWR03
         +bQie6Y+qE6qg1qgXP1qUwvaub3SobBecWkWPtFF8xzbG4H4BJTqbNWOyCZG8NLhcC36
         fwxXdg+HBhb2/ofwBDUxBCxqwGvI0d3CWwYxFLB1N+JhaeHulKERdg332Qs4RevJJG5J
         L4kg==
X-Gm-Message-State: APjAAAVYmh2oH7HiAA57EBh9I5x2dDBdcVe63m3LryJjJd1hjzew/i+y
        txoxODIBpE/DCO3uYvrcd/tqIQ==
X-Google-Smtp-Source: APXvYqwZtjyK4dW4se6QSnR09jKm821lvY6sQSncjnPNJZv7Dc0K8dmxr54D80OFEAeJzCrvn5A02Q==
X-Received: by 2002:a05:6830:50:: with SMTP id d16mr5921950otp.132.1573716715829;
        Wed, 13 Nov 2019 23:31:55 -0800 (PST)
Received: from localhost (wsip-98-172-187-222.no.no.cox.net. [98.172.187.222])
        by smtp.gmail.com with ESMTPSA id x11sm1531991oie.25.2019.11.13.23.31.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Nov 2019 23:31:55 -0800 (PST)
Date:   Wed, 13 Nov 2019 23:31:54 -0800 (PST)
From:   Paul Walmsley <paul.walmsley@sifive.com>
X-X-Sender: paulw@viisi.sifive.com
To:     Christoph Hellwig <hch@lst.de>
cc:     Palmer Dabbelt <palmer@sifive.com>,
        Damien Le Moal <damien.lemoal@wdc.com>,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        Anup Patel <anup@brainfault.org>
Subject: Re: [PATCH 02/12] riscv: don't allow selecting SBI based drivers
 for M-mode
In-Reply-To: <20191028121043.22934-3-hch@lst.de>
Message-ID: <alpine.DEB.2.21.9999.1911132330180.11342@viisi.sifive.com>
References: <20191028121043.22934-1-hch@lst.de> <20191028121043.22934-3-hch@lst.de>
User-Agent: Alpine 2.21.9999 (DEB 301 2018-08-15)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 28 Oct 2019, Christoph Hellwig wrote:

> From: Damien Le Moal <damien.lemoal@wdc.com>
> 
> When running in M-mode we can't use SBI based drivers.  Add a new
> CONFIG_RISCV_SBI that drivers that do SBI calls can depend on
> instead.
> 
> Signed-off-by: Damien Le Moal <damien.lemoal@wdc.com>
> Reviewed-by: Anup Patel <anup@brainfault.org>
> Signed-off-by: Christoph Hellwig <hch@lst.de>

Thanks, queued for v5.5-rc1.


- Paul

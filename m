Return-Path: <SRS0=OaAC=YQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8B692CA9EBB
	for <linux-kernel@archiver.kernel.org>; Wed, 23 Oct 2019 22:05:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 585462084C
	for <linux-kernel@archiver.kernel.org>; Wed, 23 Oct 2019 22:05:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="DXtMHtar"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2436657AbfJWWFB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 23 Oct 2019 18:05:01 -0400
Received: from mail-io1-f65.google.com ([209.85.166.65]:43835 "EHLO
        mail-io1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731301AbfJWWFB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Oct 2019 18:05:01 -0400
Received: by mail-io1-f65.google.com with SMTP id c11so17835180iom.10
        for <linux-kernel@vger.kernel.org>; Wed, 23 Oct 2019 15:05:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google;
        h=date:from:to:cc:subject:in-reply-to:message-id:references
         :user-agent:mime-version;
        bh=XdPCEWlB4SwMtK6X0JrzAACXbCmQF9hCLxinMMV5oKY=;
        b=DXtMHtarGS/991rhtQn7HiY905vOBpsVeKHWWuraadUPXnYwcgaOxCQ6CyqK52G1WJ
         oLqKh0ufsj1NN0h6b1+ldhs3JnF2et6/vzpjPbklc+cFSogL6za9lDUterUbKddjPvFg
         6nXxsZBxwOWPCFPAeHrdqAiF8QIybMb/OVsp1hqKV0pTrIeoj3GaqSGNX3NmSMQN70tu
         3ucYujVS7edy6y2UPknBDCT7JPHPYltLhmPy03ySSZeynZ+3sSau+yq2StAUyvi1C0Kk
         5/t6MFtjq4Dzsq31ffIYG7vDcNl3ugWzafyatEwBiGDGx0bFkrSI+nf/PFSTCgBfpfkh
         8KDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:in-reply-to:message-id
         :references:user-agent:mime-version;
        bh=XdPCEWlB4SwMtK6X0JrzAACXbCmQF9hCLxinMMV5oKY=;
        b=CjHd7foR2tXxQura0pFWrLEWYbj3Ug7gvpDuQmt7mams6NkXn9F/iuqOZV8cPR14t2
         AMxtqWEJ/zeqS2o0zmiSHKri+Dw+7Hw/4g3f1IP12X3faHbaW7XEkbB30DSyRcEF2ziz
         7FaHwKrNTpVnVPdohHbSci9bzBZHK9onlh5NwaDrmb8w/NO2MkuFG0yBf1ZJM//keawY
         vsRrgX89O0+hapShsR9xo2FHXf18N/ovbbgkkF3dw2G7rRuzU1V5jb2AWmzlzb+mphCQ
         W/DWT5v6tAFcF0imDlcHRJkf+beFV5CtHcVp6C0Z4hxHcXpRKNgj0YqtM/G3Api2YEVo
         lKQQ==
X-Gm-Message-State: APjAAAULkYCzQornoQZfVQKp8wUw0rnCgkBKR9MQ27eoE+bZeLrEiXUc
        O0vbht4Bzw5uHnWjspnFBlE/xg==
X-Google-Smtp-Source: APXvYqyouhiLhfPkOcgMyKI6xZ8nOzoA6AHtQWyGjoCzRe6OlSEwj/Cz5O79ZygyDNmxJz3rPwbULA==
X-Received: by 2002:a6b:400e:: with SMTP id k14mr5875901ioa.254.1571868300059;
        Wed, 23 Oct 2019 15:05:00 -0700 (PDT)
Received: from localhost ([64.62.168.194])
        by smtp.gmail.com with ESMTPSA id p19sm4640731ili.56.2019.10.23.15.04.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Oct 2019 15:04:59 -0700 (PDT)
Date:   Wed, 23 Oct 2019 15:04:56 -0700 (PDT)
From:   Paul Walmsley <paul.walmsley@sifive.com>
X-X-Sender: paulw@viisi.sifive.com
To:     Christoph Hellwig <hch@lst.de>
cc:     Palmer Dabbelt <palmer@sifive.com>,
        Damien Le Moal <damien.lemoal@wdc.com>,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 01/15] riscv: cleanup <asm/bug.h>
In-Reply-To: <20191017173743.5430-2-hch@lst.de>
Message-ID: <alpine.DEB.2.21.9999.1910231504450.16536@viisi.sifive.com>
References: <20191017173743.5430-1-hch@lst.de> <20191017173743.5430-2-hch@lst.de>
User-Agent: Alpine 2.21.9999 (DEB 301 2018-08-15)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 17 Oct 2019, Christoph Hellwig wrote:

> Remove various not required ifdefs and externs.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>

Thanks, queued for v5.4-rc.


- Paul

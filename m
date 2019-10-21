Return-Path: <SRS0=BTkm=YO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A69D6CA9EBA
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Oct 2019 08:47:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7CAE52089C
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Oct 2019 08:47:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=cogentembedded-com.20150623.gappssmtp.com header.i=@cogentembedded-com.20150623.gappssmtp.com header.b="1m2lTqA9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727827AbfJUIrj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 21 Oct 2019 04:47:39 -0400
Received: from mail-lf1-f68.google.com ([209.85.167.68]:45263 "EHLO
        mail-lf1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727309AbfJUIri (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Oct 2019 04:47:38 -0400
Received: by mail-lf1-f68.google.com with SMTP id v8so8802190lfa.12
        for <linux-kernel@vger.kernel.org>; Mon, 21 Oct 2019 01:47:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cogentembedded-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=QXiJynjMNN+K0FoWykKekuEj/OBAnoR2FAHWqATIrfA=;
        b=1m2lTqA9g8pR+gNDKI38Hf1YD7AHOVMKSH+qSD61rfazdteezEy9qc5uu2ptisQ9la
         2LtDIJrwJ7X1O01IGsFjD9Q/tJKUKXCVjQmfmnHyU1gdA5IsuEbNn8xmSiwXeHIxvmk/
         6pVLd5kq52suDJKdMlVESukd4NeWOaLnxEtoHQCsXi6XdP7Fg9uthetLEeVehsgGmwkk
         ja7ACVppObMYfmKfim6MGSHkS3TgOluieW1CYSonwzhW9/htLzCwwZtSsHf1htBxQR70
         GPCtExDc04v5gmZKf1XkxxBDsYhoYYnWBWz0PP+O7PTGn50JCdZZF3jn0h256hnPJzT7
         KjZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=QXiJynjMNN+K0FoWykKekuEj/OBAnoR2FAHWqATIrfA=;
        b=oCMN50MDVt2cStQNj0u1nzxxxcVSfEqATww6Kut88gIluhW67UW3xdBkaSN86cp47Y
         cFuaUKvT1zsZ47v5Q1HZx56eDcoAVdaplPg9BkFLTR2zEQDk+/x/Mo339+GAzGEE1a97
         7g3yPcIXrwXnt8LXO4+qido9Ebg/rab6Ld8HUDDuBGQMkE1hvu9GHQ2q57L0gnBohX8u
         6AAEz5fTX2r4qz0pTUJ2WNDLoLfFKd6OhbGk+dtR0JjZkoYsG3+7siE1KcTQ99xft1RS
         yAjUSiRpVaR/BQkrpPOZxNgVUISQDk2Mj+8J/4b/AaXRz15iKjqhNxlwk8MbSjefRfFq
         tV4Q==
X-Gm-Message-State: APjAAAUHcp7Ffd3TptSKv+QNBvPz0KV/nZ6CmkrTQzrUnnsAOa7dV1q7
        eR5x5PuyA6TASIZKcrSiadReEYrMoX01YQ==
X-Google-Smtp-Source: APXvYqylsk8yws60VuLL0ozqdrRuKOuNEAm0brGxK1g45riofpGFYvmXbrn9qDfFdvJfYm2OEK4gUA==
X-Received: by 2002:ac2:4283:: with SMTP id m3mr14587900lfh.41.1571647656443;
        Mon, 21 Oct 2019 01:47:36 -0700 (PDT)
Received: from ?IPv6:2a00:1fa0:2d0:74aa:edd9:b20e:81b0:5b8f? ([2a00:1fa0:2d0:74aa:edd9:b20e:81b0:5b8f])
        by smtp.gmail.com with ESMTPSA id x76sm12649907ljb.81.2019.10.21.01.47.34
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 21 Oct 2019 01:47:35 -0700 (PDT)
Subject: Re: [PATCH 03/21] ia64: rename ioremap_nocache to ioremap_uc
To:     Christoph Hellwig <hch@lst.de>, Arnd Bergmann <arnd@arndb.de>,
        Guo Ren <guoren@kernel.org>, Michal Simek <monstr@monstr.eu>,
        Greentime Hu <green.hu@gmail.com>,
        Vincent Chen <deanbo422@gmail.com>,
        Guan Xuetao <gxt@pku.edu.cn>, x86@kernel.org
Cc:     linux-alpha@vger.kernel.org, linux-snps-arc@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org,
        linux-hexagon@vger.kernel.org, linux-ia64@vger.kernel.org,
        linux-m68k@lists.linux-m68k.org, linux-mips@vger.kernel.org,
        nios2-dev@lists.rocketboards.org, openrisc@lists.librecores.org,
        linux-parisc@vger.kernel.org, linux-riscv@lists.infradead.org,
        linux-s390@vger.kernel.org, linux-sh@vger.kernel.org,
        sparclinux@vger.kernel.org, linux-xtensa@linux-xtensa.org,
        linux-mtd@lists.infradead.org, linux-arch@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20191017174554.29840-1-hch@lst.de>
 <20191017174554.29840-4-hch@lst.de>
From:   Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Message-ID: <915c9aaa-ea20-7c29-7ee8-5c5f68f7d123@cogentembedded.com>
Date:   Mon, 21 Oct 2019 11:47:17 +0300
User-Agent: Mozilla/5.0 (Windows NT 6.3; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20191017174554.29840-4-hch@lst.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello!

On 17.10.2019 20:45, Christoph Hellwig wrote:

> On ia64 ioremap_nocache fails if attributs don't match.  Not other

   Attributes?

> architectures does this, and we plan to get rid of ioremap_nocache.
> So get rid of the special semantics and define ioremap_nocache in
> terms of ioremap as no portable driver could rely on the behavior
> anyway.
> 
> However x86 implements ioremap_uc with a in a similar way as the ia64

    With a what?

> version of ioremap_nocache, so implement that instead.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---
>   arch/ia64/include/asm/io.h | 6 +++---
>   arch/ia64/mm/ioremap.c     | 4 ++--
>   2 files changed, 5 insertions(+), 5 deletions(-)
> 
> diff --git a/arch/ia64/include/asm/io.h b/arch/ia64/include/asm/io.h
> index 54e70c21352a..fec9df9609ed 100644
> --- a/arch/ia64/include/asm/io.h
> +++ b/arch/ia64/include/asm/io.h
[...]

MBR, Sergei

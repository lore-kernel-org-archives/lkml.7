Return-Path: <SRS0=21RF=YY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,URIBL_SBL,URIBL_SBL_A,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8538BCA9ECB
	for <linux-kernel@archiver.kernel.org>; Thu, 31 Oct 2019 23:55:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 48D5E2087F
	for <linux-kernel@archiver.kernel.org>; Thu, 31 Oct 2019 23:55:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="l3C/2pCp"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728438AbfJaXzM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 31 Oct 2019 19:55:12 -0400
Received: from mail-il1-f193.google.com ([209.85.166.193]:42604 "EHLO
        mail-il1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726506AbfJaXzL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Oct 2019 19:55:11 -0400
Received: by mail-il1-f193.google.com with SMTP id n18so155419ilt.9
        for <linux-kernel@vger.kernel.org>; Thu, 31 Oct 2019 16:55:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google;
        h=date:from:to:cc:subject:in-reply-to:message-id:references
         :user-agent:mime-version;
        bh=N5iHmlILXRbEi8EN+IUZsNyE4Ymf/VB8PmWy2Y78vP4=;
        b=l3C/2pCpaeuyWCknJRQnTKh6SlFTtCYRDRLdQ4KxJW12S9T67ROtFv1XDnteZ4c6pe
         RZMawNLPTzAJdVH58ytBFB8FjbdKER6jaVf5hBD+ZXfWPrsCt1kaeHn/kqbSdzn5G+se
         TdxXO9hz4JV8xcaq6VxA1HMHYCylImZ31fpFBx0xs1ELH7sKeePIMh9PWet8fYYcCLfr
         aNgGL3OwXekCBs5EMg/PVpVO3kZ9TLhOYd7Jm/hhnclYSHU1wCDDZhCzqM0WSDWYZg7e
         Ukv3noUisj0/t0pGlqjaNpbHhfvixS4ZMc9xkaIBaAhfDFKGbMMjAHyTcQaT4wvUMZDC
         Uvug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:in-reply-to:message-id
         :references:user-agent:mime-version;
        bh=N5iHmlILXRbEi8EN+IUZsNyE4Ymf/VB8PmWy2Y78vP4=;
        b=A1DmC6J0mv7ZlHHaIprUGXEoHHpEowyeT/P2fPrRvlVOEXHYPVSjLQREhhz0hI/Z0l
         dIkOQNLuokZdtf7ysdMLpxjpJz2ESKRRsYuFv7LUVyv5ljalAtPGb8y25ck4kWSTonFA
         M30LVpqe1gglVbDT5ZSa00Nh+gkZTSX22hwjsJLbi/SLBadjRP3BRcWuzs0dLsf3p9Ej
         /mPGgch8erxmHnnkKmUcCS7unBwfks8F1xr67s1SarLHgilw5xb9O6DN0ya2ayyENTFk
         arQxAPICsb5DQRN2WFtn3Jm4xBVBeqeubaIbteh5F3LJyDUysX5Sn0oQuktAX+iYhq0A
         PMZQ==
X-Gm-Message-State: APjAAAWB0WgeynXlnUE8o0qDmA8SnsxzjCChQHi7lvthja8Q6DcmTWjf
        oqjkZOun/TwH6f3lXlpO++DDNw==
X-Google-Smtp-Source: APXvYqxU4quf2N5vI+TJ+4eYesycO5XewOnq4v3en4F2cHPBfEh+mUIkSI/bOsMbiXzuQTLUnrWjQQ==
X-Received: by 2002:a92:5c5d:: with SMTP id q90mr9702452ilb.22.1572566111105;
        Thu, 31 Oct 2019 16:55:11 -0700 (PDT)
Received: from localhost ([64.62.168.194])
        by smtp.gmail.com with ESMTPSA id g13sm494749ion.23.2019.10.31.16.55.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 31 Oct 2019 16:55:10 -0700 (PDT)
Date:   Thu, 31 Oct 2019 16:55:08 -0700 (PDT)
From:   Paul Walmsley <paul.walmsley@sifive.com>
X-X-Sender: paulw@viisi.sifive.com
To:     Christoph Hellwig <hch@lst.de>
cc:     Palmer Dabbelt <palmer@sifive.com>,
        Damien Le Moal <damien.lemoal@wdc.com>,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        Anup Patel <anup@brainfault.org>
Subject: Re: [PATCH 03/12] riscv: poison SBI calls for M-mode
In-Reply-To: <20191028121043.22934-4-hch@lst.de>
Message-ID: <alpine.DEB.2.21.9999.1910311654570.25874@viisi.sifive.com>
References: <20191028121043.22934-1-hch@lst.de> <20191028121043.22934-4-hch@lst.de>
User-Agent: Alpine 2.21.9999 (DEB 301 2018-08-15)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 28 Oct 2019, Christoph Hellwig wrote:

> There is no SBI when we run in M-mode, so fail the compile for any code
> trying to use SBI calls.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> Reviewed-by: Anup Patel <anup@brainfault.org>

Thanks, queued for v5.5-rc.


- Paul

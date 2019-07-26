Return-Path: <SRS0=vtn1=VX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 17A7FC7618B
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Jul 2019 16:16:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E53C6218DA
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Jul 2019 16:16:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="GhJtb6y3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728405AbfGZQQA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 26 Jul 2019 12:16:00 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:35200 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726143AbfGZQP7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Jul 2019 12:15:59 -0400
Received: by mail-pg1-f193.google.com with SMTP id s1so18698605pgr.2
        for <linux-kernel@vger.kernel.org>; Fri, 26 Jul 2019 09:15:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=9pxdI8Q1eQGc6MFJDXbX8IPKQf5e9FjRtdij/Ccdk+g=;
        b=GhJtb6y3IvR2euTrzUQLBPzuWpMC1r078nOKLTS2B26A9HymM6QBFZfT03uDUsxGMt
         qEU5Dj5ZPRoFY2MiQMolT8V6egN2ZpXNx0R/y1ExRSFTnrcIQQkTlH+qisWgVrr+fhu5
         fwWtJB/yQ5JNCDew1FsG+XjvLgH1fzf99fEmQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=9pxdI8Q1eQGc6MFJDXbX8IPKQf5e9FjRtdij/Ccdk+g=;
        b=peRftu/kLmlNqJpDGeVUdqSB7GqXw/3DaG7RwA8vpVTwodrLdcnmRGOIDZRStqHdJ7
         7VXUREj96bPedxCW2fUt7QaVVeVh5O1olhKo+IGC0reqfGaRPOrvL9lMMEwIYbCYlFJV
         nMEv5Nhwl0G7A/qUNisyhjTT2SgpE507ExSnvgLrIr7u0tELaD0FhF7Q7ZXPv2Lsysyt
         oPii6+ycDFsYR4zF2/q7HA04eMGdco2yxDam4IUMPYFwH8vcS7U7hLjT5RhEyyLKicOT
         vUvI19CpKPeFegkids2HewqDIaBFbh6ucVNsVo9ZRsv+HlA+qihRiNAM+hKrXSs6pgds
         mRDQ==
X-Gm-Message-State: APjAAAVhsxvz/5rDT2o1oA4DRgNqGhb7n3BnwIB0eoHzzpMaoBuqNoF/
        5t1pHtCwDhrqRxu5V96GpGbalA==
X-Google-Smtp-Source: APXvYqxorBpjLgP/KwuMcH8kC+695azPg68CPTEJ3NXXlbisGsg21F6WBT3zy6Q5jm5oFPVjAt8Owg==
X-Received: by 2002:a62:5344:: with SMTP id h65mr23349574pfb.32.1564157758990;
        Fri, 26 Jul 2019 09:15:58 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id i126sm61479400pfb.32.2019.07.26.09.15.57
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 26 Jul 2019 09:15:58 -0700 (PDT)
Date:   Fri, 26 Jul 2019 09:15:57 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Jason Yan <yanaijie@huawei.com>
Cc:     mpe@ellerman.id.au, linuxppc-dev@lists.ozlabs.org,
        diana.craciun@nxp.com, christophe.leroy@c-s.fr,
        benh@kernel.crashing.org, paulus@samba.org, npiggin@gmail.com,
        kernel-hardening@lists.openwall.com, linux-kernel@vger.kernel.org,
        wangkefeng.wang@huawei.com, yebin10@huawei.com,
        thunder.leizhen@huawei.com, jingxiangfeng@huawei.com,
        fanchengyang@huawei.com
Subject: Re: [RFC PATCH 00/10] implement KASLR for powerpc/fsl_booke/32
Message-ID: <201907260914.E37F9B041@keescook>
References: <20190717080621.40424-1-yanaijie@huawei.com>
 <e6ad41bc-5d5a-cf3f-b308-e1863b4fef99@huawei.com>
 <201907251252.0C58037@keescook>
 <877d818d-b3ec-1cea-d024-4ad6aea7af60@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <877d818d-b3ec-1cea-d024-4ad6aea7af60@huawei.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 26, 2019 at 03:20:26PM +0800, Jason Yan wrote:
> The boot code only maps one 64M zone at early start. If the kernel crosses
> two 64M zones, we need to map two 64M zones. Keep the kernel in one 64M
> saves a lot of complex codes.

Ah-ha. Gotcha. Thanks for the clarification.

> Yes, if this feature can be accepted, I will start to work with powerpc64
> KASLR and other things like CONFIG_RANDOMIZE_MEMORY.

Awesome. :)

-- 
Kees Cook

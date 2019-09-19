Return-Path: <SRS0=X8En=XO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 45847C3A5A6
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Sep 2019 12:55:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0BB1E218AF
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Sep 2019 12:55:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="aMXMVXNc"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390364AbfISMzX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 19 Sep 2019 08:55:23 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:35312 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389212AbfISMzW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Sep 2019 08:55:22 -0400
Received: by mail-wr1-f65.google.com with SMTP id v8so3010953wrt.2
        for <linux-kernel@vger.kernel.org>; Thu, 19 Sep 2019 05:55:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google;
        h=date:from:to:cc:subject:in-reply-to:message-id:references
         :user-agent:mime-version;
        bh=65/ywDMWrzjeCzGWCGYnBZeM7JciK2cM+apP1oaSTMo=;
        b=aMXMVXNc+01+ALajqoxJSw001xwdNeYz8ol0SlDxQ23fL+trAlbYvQpAtgX5YMFRPk
         boQx8cdnW+Hxop65M+odc7EH+HqEkw6/hVRPSgasuYXJlzjSidX52xTTaBXqjVeIpOXH
         GC904JYvj30jGTfjm/qj+mgyoFJVo0MXRHWDe7VXTgz4rtIX/wWhTJjpVkb8sRohbjtF
         BtdyqNCFKqVgCnQoxne1Pqu4uPeqYX7jQvJIkp2o4gdjFOMVHHEYarCoQEKR2P24i1J9
         pNpq8ur/JCVRqiorhCqDxPsPVfR2THSMQ/Nfn3ectKGf7KOv6IpTUR9wtIFfi5nsfawp
         Ey8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:in-reply-to:message-id
         :references:user-agent:mime-version;
        bh=65/ywDMWrzjeCzGWCGYnBZeM7JciK2cM+apP1oaSTMo=;
        b=Ge36tlnvlJRA06JivmhVyRzV+gIIjFmIUAbWghhYW/lwKymJ5f/y7r+86sdzR+JKja
         96uAL6uEYSLfE3P/FsrpecKbxsLC9vvrM0RMLe+cQNqfTnHCHXv3jxB9tDqAZA/cRcTq
         /45gaRc5mhFp2paknzBKUav4Czcs+poM4ep2gX9qs3Yqqe8nqe7yLQKw6gBLVlSANbqO
         DxD/D5dtzg4Gjq3HUH8tAc5g/c16FVOPOezL2tQtIIR3YQIdkgqZi7xujxvaXcGyIT3t
         IweMOZ9Q9DxLAbE6v9+ZdMpfy9wiQxRf+hjN4fFYV5kE4aaNRSmNZ+nM6p3s/1obixW5
         f+uQ==
X-Gm-Message-State: APjAAAXrQHW+k3+rH6UDRkNg6RcWwFK3cUbEaNyo5KTEDh5F9utYwnJE
        sy1COJmr9AcpP+9yoC0HZBO1VA==
X-Google-Smtp-Source: APXvYqzfX9Vgi3rEEb5XfbpNt8GsXKxAGn3g+PjDZmnfOKy+ytg28J4GtD1MxJfxDh88ZbWtbFr7XA==
X-Received: by 2002:adf:ce91:: with SMTP id r17mr7277133wrn.97.1568897720776;
        Thu, 19 Sep 2019 05:55:20 -0700 (PDT)
Received: from localhost ([109.190.253.11])
        by smtp.gmail.com with ESMTPSA id q3sm10364469wrm.86.2019.09.19.05.55.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Sep 2019 05:55:20 -0700 (PDT)
Date:   Thu, 19 Sep 2019 05:55:18 -0700 (PDT)
From:   Paul Walmsley <paul.walmsley@sifive.com>
X-X-Sender: paulw@viisi.sifive.com
To:     Bin Meng <bmeng.cn@gmail.com>
cc:     Palmer Dabbelt <palmer@sifive.com>, linux-kernel@vger.kernel.org,
        linux-riscv@lists.infradead.org
Subject: Re: [PATCH v2] riscv: dts: sifive: Drop "clock-frequency" property
 of cpu nodes
In-Reply-To: <1567687553-22334-1-git-send-email-bmeng.cn@gmail.com>
Message-ID: <alpine.DEB.2.21.9999.1909190555020.13446@viisi.sifive.com>
References: <1567687553-22334-1-git-send-email-bmeng.cn@gmail.com>
User-Agent: Alpine 2.21.9999 (DEB 301 2018-08-15)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 5 Sep 2019, Bin Meng wrote:

> The "clock-frequency" property of cpu nodes isn't required. Drop it.
> 
> Signed-off-by: Bin Meng <bmeng.cn@gmail.com>

Thanks, queued for v5.4-rc with Christoph's Reviewed-by:.

- Paul

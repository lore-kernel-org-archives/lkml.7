Return-Path: <SRS0=AnJR=XA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0FD7EC3A5AB
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Sep 2019 07:54:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DAB8A21743
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Sep 2019 07:54:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="f9GOGijb"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731818AbfIEHyM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 5 Sep 2019 03:54:12 -0400
Received: from mail-io1-f68.google.com ([209.85.166.68]:41920 "EHLO
        mail-io1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729366AbfIEHyL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Sep 2019 03:54:11 -0400
Received: by mail-io1-f68.google.com with SMTP id r26so2643289ioh.8
        for <linux-kernel@vger.kernel.org>; Thu, 05 Sep 2019 00:54:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google;
        h=date:from:to:cc:subject:in-reply-to:message-id:references
         :user-agent:mime-version;
        bh=XEwhLYvc4QUR6wvAGjdkKm4IcG5eE3iFZQx/tTNYViw=;
        b=f9GOGijbalzUu0CJL+Gr/ytsBHHkUCfxTJmxJ3N0hokbi/y34zaAwN8d3+He+KXQJk
         vPQGMyBlLIshOD8UDGxbQoiISxNE7iad2N9MzEaID2bMkcZk56AsrarO4g8u9ZxQmMub
         5okbyjjEuNbRUTvEedp2vCHE+lHojS9mSeprf5ZthfKCTQ5i4VlADp5qcX7ZmKVIdp9r
         w1Yp+/Cm7yfpEmkscIAkjQzEIuWEIQKdU18utJA6BcgPyfOtM1oQFD6rOGng01yTcbPd
         zT+bMKGeV7XyKScy6noh7dFr61O1cfwNW17yzfJzRVBYMX8UDAfP8tiOh/WCoC46od+P
         HQfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:in-reply-to:message-id
         :references:user-agent:mime-version;
        bh=XEwhLYvc4QUR6wvAGjdkKm4IcG5eE3iFZQx/tTNYViw=;
        b=Nt+8jaZFhJaIZCQK4zK+WSY3qe7cyA+JMvynHXwJUrjMoPtahKnXAcsCn9FgKYfA/k
         XfBjxEzRoFYlzABYi1hkg6gZnIwCy9SD1rrtmo89j+9ppcdewXe2WE/nBmPbZmo11aeW
         RHKOK3Kj1N1FXO9UErt4aFP2pAHhQuphi+0ejremLiSyG4Ri72xzgoTEbUh8QX8GyGHI
         itL9st2bOam53lKI4CakySYp6ztMp/a53Tf/SiIFwa2dlunR3yr6xzWPwA+ySVO8Oa8n
         RFQhSQMiyFSfjTrkISOKABOZ/FX0xVagRHFqIB/1TSn7CEgHzVX4JTMI8JRFuzYv+MAt
         jfyg==
X-Gm-Message-State: APjAAAVvUmW5Eza83OBnheC/cXSiAYFPbJFYdxNYpFxxtmCcJMhqrM0x
        Xs0cIdIwIc42Z1HDkXzd5ukcMA==
X-Google-Smtp-Source: APXvYqzhSbbGP9r0GEa00JWqwYlWyFKnvo7aDMeQ+g/vQTEPBv3G0gV8TBzguYR+mq6CgCtkF0/VpA==
X-Received: by 2002:a6b:c9d7:: with SMTP id z206mr2564361iof.172.1567670050705;
        Thu, 05 Sep 2019 00:54:10 -0700 (PDT)
Received: from localhost ([2601:8c4:0:9294:cb6f:4cf:b239:2fee])
        by smtp.gmail.com with ESMTPSA id m67sm2549041iof.21.2019.09.05.00.54.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Sep 2019 00:54:10 -0700 (PDT)
Date:   Thu, 5 Sep 2019 00:54:08 -0700 (PDT)
From:   Paul Walmsley <paul.walmsley@sifive.com>
X-X-Sender: paulw@viisi.sifive.com
To:     Mao Han <han_mao@c-sky.com>
cc:     linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-csky@vger.kernel.org, Greentime Hu <green.hu@gmail.com>,
        Palmer Dabbelt <palmer@sifive.com>,
        Christoph Hellwig <hch@lst.de>, Guo Ren <guoren@kernel.org>
Subject: Re: [PATCH V7 1/2] riscv: Add support for perf registers sampling
In-Reply-To: <49c2c29459afc59130b036eba1b1fd5155572355.1567653632.git.han_mao@c-sky.com>
Message-ID: <alpine.DEB.2.21.9999.1909050053100.27305@viisi.sifive.com>
References: <cover.1567653632.git.han_mao@c-sky.com> <49c2c29459afc59130b036eba1b1fd5155572355.1567653632.git.han_mao@c-sky.com>
User-Agent: Alpine 2.21.9999 (DEB 301 2018-08-15)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 5 Sep 2019, Mao Han wrote:

> This patch implements the perf registers sampling and validation API
> for riscv arch. The valid registers and their register ID are defined in
> perf_regs.h. Perf tool can backtrace in userspace with unwind library
> and the registers/user stack dump support.
> 
> Signed-off-by: Mao Han <han_mao@c-sky.com>
> Cc: Paul Walmsley <paul.walmsley@sifive.com>
> Cc: Greentime Hu <green.hu@gmail.com>
> Cc: Palmer Dabbelt <palmer@sifive.com>
> Cc: linux-riscv <linux-riscv@lists.infradead.org>
> Cc: Christoph Hellwig <hch@lst.de>
> Cc: Guo Ren <guoren@kernel.org>

Thanks, queued for v5.4-rc1 with Greentime's Tested-by: (since the changes 
from v6 to v7 had no functional impact).

- Paul

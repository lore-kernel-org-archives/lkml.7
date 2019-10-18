Return-Path: <SRS0=6OEZ=YL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 24F0BCA9EC8
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Oct 2019 01:15:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DA28121D80
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Oct 2019 01:15:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="awDrOrTN"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2409233AbfJRBPe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 17 Oct 2019 21:15:34 -0400
Received: from mail-il1-f195.google.com ([209.85.166.195]:38881 "EHLO
        mail-il1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2391934AbfJRBPe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Oct 2019 21:15:34 -0400
Received: by mail-il1-f195.google.com with SMTP id y5so3986236ilb.5
        for <linux-kernel@vger.kernel.org>; Thu, 17 Oct 2019 18:15:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google;
        h=date:from:to:cc:subject:in-reply-to:message-id:references
         :user-agent:mime-version;
        bh=xMVFVGLiYSSLdYjE6VASkhDClgpi5ByjWpde3EPzDTo=;
        b=awDrOrTNZsTliFwdBDUIyxs4uX5joR2/y276X1UXTxr76eI9fflr4Pp//BNKhw4LDP
         udF5JY/ajGrCY8RdxmG2kJGXyipHWyNWPld3aZCqGILhwuTzivqGa1IDcV2DNRnj84q3
         jlhnWl/WK/LTKjgg1pinyZrNLcMWVxx9FOwlZFX2iHQXHVfBZCuyWYvdWDFdVSM66+B4
         SHBwMkz/wzQWkQVbZR+r2lNRYuiUTKLqYPo0e3CA1LavnCJGdkOF8sRgaNGe05WYeZC+
         xG/cSojbKWDQHv1N8NC8pVWLjReHS2jTlxCJFM1wMFgozUD9nbcTIJIUroCyYj2/DMdi
         Udlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:in-reply-to:message-id
         :references:user-agent:mime-version;
        bh=xMVFVGLiYSSLdYjE6VASkhDClgpi5ByjWpde3EPzDTo=;
        b=jqTow5UiKaM8eD4i9yUyNH2X1pig+Uw/A/vAS32krEaeXRvKGmoksddXUqY4gXyVmM
         /3nhuGwyVG0yQsur7Si6N7TlA+ZCOwc2fWa13ra/KcnCqz6i1QQW6sP6TrpKtXjuIsZx
         gMzvQDvcoronOQRWcGuoo1VIiCa49tpUuzAvQl6r+Z5sf4/SARyOH8zgROV2LywDTL82
         0ggzQEuXFhCw4GZNd54P2ltkgj3GrJsQRjhMgZQnka8tdikX/4zEelgGm0TKHSiIx53j
         8cmFO7nFgukOLwBE+Gb+rQJYmJxb1RCkx87sJenFiOD/XyZVQim/cimPxsZ+rwiwOgXr
         O10A==
X-Gm-Message-State: APjAAAUKHSsEH7xH/LYcVkkI2V2U4jW/FqSC2GGwiMO0KoIn2lqEDDMi
        /PDuUkGRshGKA/lBbVIAZSM2iQ4ERRY=
X-Google-Smtp-Source: APXvYqzDVQiMyZIgvTZC/Q7ZcqBa0pFaN3EJ5m9p1+F6LuzHOYBWFwOn3qLkn0mFMNJ187/UdFrNTw==
X-Received: by 2002:a92:83c5:: with SMTP id p66mr7527394ilk.204.1571361331720;
        Thu, 17 Oct 2019 18:15:31 -0700 (PDT)
Received: from localhost ([64.62.168.194])
        by smtp.gmail.com with ESMTPSA id t86sm1829722ila.21.2019.10.17.18.15.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Oct 2019 18:15:31 -0700 (PDT)
Date:   Thu, 17 Oct 2019 18:15:29 -0700 (PDT)
From:   Paul Walmsley <paul.walmsley@sifive.com>
X-X-Sender: paulw@viisi.sifive.com
To:     linux-riscv@lists.infradead.org
cc:     linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/8] riscv: add prototypes for assembly language functions
 from head.S
In-Reply-To: <20191018004929.3445-3-paul.walmsley@sifive.com>
Message-ID: <alpine.DEB.2.21.9999.1910171814310.12651@viisi.sifive.com>
References: <20191018004929.3445-1-paul.walmsley@sifive.com> <20191018004929.3445-3-paul.walmsley@sifive.com>
User-Agent: Alpine 2.21.9999 (DEB 301 2018-08-15)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 17 Oct 2019, Paul Walmsley wrote:

> Add prototypes for assembly language functions defined in head.S,
> and include these prototypes into C source files that call those
> functions.

[ ... ]

> diff --git a/arch/riscv/mm/fault.c b/arch/riscv/mm/fault.c
> index 96add1427a75..ec15a9b15448 100644
> --- a/arch/riscv/mm/fault.c
> +++ b/arch/riscv/mm/fault.c
> @@ -18,6 +18,8 @@
>  #include <asm/ptrace.h>
>  #include <asm/tlbflush.h>
>  
> +#include "../head.h"
> +

"../kernel/head.h", rather.


- Paul

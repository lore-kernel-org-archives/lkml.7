Return-Path: <SRS0=tMFY=W7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DF44EC3A5A9
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Sep 2019 21:25:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B60C920449
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Sep 2019 21:25:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="fTLS4AC5"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730694AbfIDVZB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 4 Sep 2019 17:25:01 -0400
Received: from mail-io1-f68.google.com ([209.85.166.68]:36946 "EHLO
        mail-io1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727156AbfIDVY7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Sep 2019 17:24:59 -0400
Received: by mail-io1-f68.google.com with SMTP id r4so32444906iop.4
        for <linux-kernel@vger.kernel.org>; Wed, 04 Sep 2019 14:24:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google;
        h=date:from:to:cc:subject:in-reply-to:message-id:references
         :user-agent:mime-version;
        bh=gpnxUOC87Hy/bQFTjChPoPUmVY9m9l5TllB0pP0NeVk=;
        b=fTLS4AC5Y3ATB96yfTaa7NNHIOTrZhvDflTG9Orv7lWVtnUCwEpcmP20IMPHHfbAo4
         8IZUu4m/TmyBzD4IkRERocaj62+YgKlCnp0UnS9rfQgWahlhEFwbtw+h7L7OoNv6+ap+
         RJudWwoFvJWcbxdoKoVd/Td0s4qFhYYQFo5RvC7qc4TKPMc3MftX/S71qdKw2PGFipAO
         nIux+yq5b0aZNpSAGSZID8kbRRvqRopQ2NLanjEh0XZx17D9feHuYXCD+G3JbySlMwSq
         wlTIM/KfezSMBzPmjTFMtfGCmlA465gjVqqLLGaudRkH6Z3C1ADjcKPc1Em1eTAFMHrl
         oBYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:in-reply-to:message-id
         :references:user-agent:mime-version;
        bh=gpnxUOC87Hy/bQFTjChPoPUmVY9m9l5TllB0pP0NeVk=;
        b=qO5l6o4VbwmeMyc/T0ONlhNm+o0Dhh6YS3zlI93+kNGWbiHT0C5/slsgUvJMOaYGjY
         J7uBGkYYt83mqcqDAk/wowTJWrzp3dDg7RpYeTgr0ewuOwsSHZJIfE/aKxaqMdBPp33x
         XIMo/2yLU6Z1y4XOTp9fNO8hbOvY+MXW9YnGpMrmm9+hJeGn3CwskPcVsIv1+yNKYfHy
         ulOj2mleoZYiLh1WGLIUU3Tzi6XmzHk2H3A3fXoAdUAzA1PUg6nvkJNyKxGEjOPcb4Fa
         EMSyTltbvWzCROd2MpLdDEinjS8uEQxZe+flMyMyDf8KaY0K4K3euJIwN1P+tnE89RIB
         doDg==
X-Gm-Message-State: APjAAAX+qORQcKXbDGICXGCOjTXsqbfU377s5dCyd5Ob4AewhW5By2OK
        9zGDSeNxQhpmN8/zR5/Qi+WSL4UTscQ=
X-Google-Smtp-Source: APXvYqxjjM03c8YncfiKMgSDvfLe10vnXrh6O5z7tHl/a/2REfqzPMyznieZD1T0RCpHILA7wU/D0g==
X-Received: by 2002:a02:cad1:: with SMTP id f17mr333310jap.18.1567632299044;
        Wed, 04 Sep 2019 14:24:59 -0700 (PDT)
Received: from localhost (75-161-11-128.albq.qwest.net. [75.161.11.128])
        by smtp.gmail.com with ESMTPSA id r2sm66211ioh.61.2019.09.04.14.24.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Sep 2019 14:24:58 -0700 (PDT)
Date:   Wed, 4 Sep 2019 14:24:57 -0700 (PDT)
From:   Paul Walmsley <paul.walmsley@sifive.com>
X-X-Sender: paulw@viisi.sifive.com
To:     Mao Han <han_mao@c-sky.com>
cc:     linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-csky@vger.kernel.org, Greentime Hu <green.hu@gmail.com>,
        Palmer Dabbelt <palmer@sifive.com>,
        Christoph Hellwig <hch@lst.de>, Guo Ren <guoren@kernel.org>
Subject: Re: [PATCH V6 3/3] riscv: Add support for libdw
In-Reply-To: <4cba2dfb6b1ef0df01185c6bce78a0a2867d0a7d.1567060834.git.han_mao@c-sky.com>
Message-ID: <alpine.DEB.2.21.9999.1909041422220.13502@viisi.sifive.com>
References: <cover.1567060834.git.han_mao@c-sky.com> <4cba2dfb6b1ef0df01185c6bce78a0a2867d0a7d.1567060834.git.han_mao@c-sky.com>
User-Agent: Alpine 2.21.9999 (DEB 301 2018-08-15)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Mao Han,

On Thu, 29 Aug 2019, Mao Han wrote:

> This patch add support for DWARF register mappings and libdw registers
> initialization, which is used by perf callchain analyzing when
> --call-graph=dwarf is given.

> diff --git a/tools/arch/riscv/include/uapi/asm/perf_regs.h b/tools/arch/riscv/include/uapi/asm/perf_regs.h
> new file mode 100644
> index 0000000..df1a581
> --- /dev/null
> +++ b/tools/arch/riscv/include/uapi/asm/perf_regs.h
> @@ -0,0 +1,42 @@
> +/* SPDX-License-Identifier: GPL-2.0 */

As with 

https://lore.kernel.org/linux-riscv/CAJF2gTRXH_bx0rwsTZMTnX+umZfVTL_iVnewPtVM50sLaqJPTg@mail.gmail.com/T/#t

is it possible to change this license string to "GPL-2.0 WITH 
Linux-syscall-note" to match the other Linux architectures? 


- Paul

Return-Path: <SRS0=21RF=YY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 91136CA9ECB
	for <linux-kernel@archiver.kernel.org>; Thu, 31 Oct 2019 19:29:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 633742080F
	for <linux-kernel@archiver.kernel.org>; Thu, 31 Oct 2019 19:29:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="XzWHPNa9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729624AbfJaT3y (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 31 Oct 2019 15:29:54 -0400
Received: from mail-io1-f54.google.com ([209.85.166.54]:36726 "EHLO
        mail-io1-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726940AbfJaT3y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Oct 2019 15:29:54 -0400
Received: by mail-io1-f54.google.com with SMTP id s3so4246719ioe.3
        for <linux-kernel@vger.kernel.org>; Thu, 31 Oct 2019 12:29:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google;
        h=date:from:to:cc:subject:in-reply-to:message-id:references
         :user-agent:mime-version;
        bh=ps9mIWZL6I4lt3cKBlCNZFVxrfgS2HQqXQheS1VhANc=;
        b=XzWHPNa9zlkb/3BPgBxi8pnviBHJE8YC5j2rV4X3/iFDVc/vTJyS8zUGIi3MEUf14u
         BWRGXbNjc1dXRhDzIfNdPuC2L8EfTJfsB/idFuJBVzfRDdQ4bp+thdbbQM9rsgNoymKk
         OxzDrzhcHFAVu/EK027/3Y0ud/pMYD6x3CFPpsWOA95kh5FLxjSUyX6NDSjt/fhqyNZM
         a1ldEorqYXclz7PPLviY2YnF+7YZOPJtMlfGSyyjGT3nZoXCP/V90hxfTuaMnG6SYu/d
         nufF+cQRjKbMG9VqqJxVV89krnxzoELhpLDfaC63PNVj7IZvfnJLoUVsrn9zeRauA1Pw
         N/xg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:in-reply-to:message-id
         :references:user-agent:mime-version;
        bh=ps9mIWZL6I4lt3cKBlCNZFVxrfgS2HQqXQheS1VhANc=;
        b=BDiGRzSiC+CHg3bK6eIkbSDiWu8ROk22jY2aG5ugUgHXw0FAKxOJaXqhtvx9NbAq3d
         diYemaMCkfi3NNQUIZ9nhZAWqUaXZ1jwNRkHasJ3gzye70i7HCP+h7z8y0K3PU3a5Jfl
         OkfQxPSK4JtU3xb6/pz6kzEfmxFyKD20wHs/dlWnw+H2q1kQKqGC20BuxWn1Unq2l6HG
         3lL0BRrEik0yZf2zwDXY+WGbFW+RSAypPR0ivUBuloQ0JuD7vnUuFHjHIn4w8RDZ4nT0
         oHqBX2A77NhHlRSejjWlWwuOvMUWAcwfXgRI7qp39PnIIu6kOMEdL8Mg82oYW0JwfNiB
         iFXA==
X-Gm-Message-State: APjAAAXLhpI4xXPHU55W6KeMq87CwjbE5r2c46UbhziTSf/c0FatMnU2
        tAhfNQFIL8aBu0Lr9glGwPr8Pw==
X-Google-Smtp-Source: APXvYqwuUBD1GtseY327OIvcq+SpT+2E+Z53XNLIt4/i9Xs32ZGpLdq2+5z5898PYsIrf3ahdzC5QA==
X-Received: by 2002:a5d:9712:: with SMTP id h18mr5049544iol.256.1572550193215;
        Thu, 31 Oct 2019 12:29:53 -0700 (PDT)
Received: from localhost ([64.62.168.194])
        by smtp.gmail.com with ESMTPSA id y5sm350498ilk.83.2019.10.31.12.29.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 31 Oct 2019 12:29:52 -0700 (PDT)
Date:   Thu, 31 Oct 2019 12:29:49 -0700 (PDT)
From:   Paul Walmsley <paul.walmsley@sifive.com>
X-X-Sender: paulw@viisi.sifive.com
To:     Anup Patel <anup@brainfault.org>
cc:     linux-riscv <linux-riscv@lists.infradead.org>,
        Atish Patra <atish.patra@wdc.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Damien Le Moal <Damien.LeMoal@wdc.com>,
        Alistair Francis <Alistair.Francis@wdc.com>,
        linux-kernel@vger.kernel.org
Subject: Re: Experimental branch
In-Reply-To: <CAAhSdy3Y1W_8Uu00F66jVM=ObFouxw1C_z4-MVkLh0+s5Wx3HQ@mail.gmail.com>
Message-ID: <alpine.DEB.2.21.9999.1910311223050.16921@viisi.sifive.com>
References: <alpine.DEB.2.21.9999.1910311101480.23683@viisi.sifive.com> <CAAhSdy3Y1W_8Uu00F66jVM=ObFouxw1C_z4-MVkLh0+s5Wx3HQ@mail.gmail.com>
User-Agent: Alpine 2.21.9999 (DEB 301 2018-08-15)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 1 Nov 2019, Anup Patel wrote:

> You can drop the KVM RISC-V patches from your experimental branch.

We're not only doing it for you ;-)

> We are already maintaining KVM RISC-V patches (and dependent patches)
> in the official KVM RISC-V gitrepo at: https://github.com/kvm-riscv/linux.git
> 
> All KVM RISC-V related work will go through above mentioned gitrepo
> in-future. This gitrepo is co-maintained by me and Atish.

It's great that you guys have your own git repository for KVM patch 
development!

For upstreaming, all of the RISC-V KVM changes under arch/riscv need to go 
up via the arch/riscv maintainers to ensure a coherent maintenance 
approach across arch/riscv.  We may work out something with Paolo in the 
future.


thanks,

- Paul

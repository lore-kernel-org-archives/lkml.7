Return-Path: <SRS0=54v9=YS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D4309CA9EAF
	for <linux-kernel@archiver.kernel.org>; Fri, 25 Oct 2019 03:09:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AD64A21D71
	for <linux-kernel@archiver.kernel.org>; Fri, 25 Oct 2019 03:09:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="Ark4hOE7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391940AbfJYDJo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 24 Oct 2019 23:09:44 -0400
Received: from mail-io1-f66.google.com ([209.85.166.66]:38998 "EHLO
        mail-io1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729283AbfJYDJn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Oct 2019 23:09:43 -0400
Received: by mail-io1-f66.google.com with SMTP id y12so719286ioa.6
        for <linux-kernel@vger.kernel.org>; Thu, 24 Oct 2019 20:09:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google;
        h=date:from:to:cc:subject:in-reply-to:message-id:references
         :user-agent:mime-version;
        bh=NDnBP4/LxhdGXSkB81z59K6SH35dARBNL26jgxKs1DU=;
        b=Ark4hOE7lqn5cgq/Ov0R55L1DNSP47nM+/2lKqSaYlr/WWlTf3ju7IgIPjgTmpii/A
         hALDty3X+F3p4kuLNe7SxZakxh/OnoIYX14cm2g3aeUL8r9kav7bIKNzKfJKEfdw+tNP
         Ej3qXt9Zonj4wENgpQNwu9KuYvrc3Ec+cAPRZcUbxqpW3Jttr+ND4OrNkpFimhkVb+Z7
         l8ImnHWofoJtjSU6dElBzmF6xcaCJXJ7J2cSY8/T9xg5pfhS9hvbHPKD0Ix+YT53mKlf
         zE8Dqgbu/kVRb7r0sCsXmaQFxvlp4gMpY7fpAynPSaKrgCcNQGQcTO4shg8rOIK92I6n
         XFLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:in-reply-to:message-id
         :references:user-agent:mime-version;
        bh=NDnBP4/LxhdGXSkB81z59K6SH35dARBNL26jgxKs1DU=;
        b=Si+sdrXgxsiehyKao/kvTYBw0PMXmg0z+pm2opF+V31Ex1y8r9VnR0mcvGFIaiRUhF
         GsZPXUBseK7OBq6VsvKbi6NrJdCUSDV4YCMJo/i3pBnnD1BsvSkzJlPPSFGMg0AT6pBA
         IrDkbJdnP43jXn2hT2/2EeK/FpnvMjjEiUOxDXkvNJaZ6JmnxpzG9ohdhH4fZosxfMum
         nqf2B89ubNcY/byoA3jVC++XbgsVtWDfs0iJIvA+nmgVvH8NVxo3iB2BKJmuEBRLfAEd
         7rLxTc6wKOkuejRr3ii3Tp4N1kdj7AwFBpsE6ZaA5zhD6CRH3TeW+dN6isxFP/K3CNuS
         aPiw==
X-Gm-Message-State: APjAAAUlq1YT3L8jVB8FGoya6jQ9uP6sr/Zqe68pbCMcuHQ715tJuXJn
        pqwjDP4KtErNImBz4A07TcalfQ==
X-Google-Smtp-Source: APXvYqy0FbVU82h3B9ymHO5htMn2YmR821IaXarEdMsXRvsC8BJsi2gz+DV6xh78xXHlEDsYOjR82g==
X-Received: by 2002:a6b:7d0b:: with SMTP id c11mr1526968ioq.236.1571972982795;
        Thu, 24 Oct 2019 20:09:42 -0700 (PDT)
Received: from localhost ([64.62.168.194])
        by smtp.gmail.com with ESMTPSA id d6sm173269ilc.39.2019.10.24.20.09.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Oct 2019 20:09:42 -0700 (PDT)
Date:   Thu, 24 Oct 2019 20:09:40 -0700 (PDT)
From:   Paul Walmsley <paul.walmsley@sifive.com>
X-X-Sender: paulw@viisi.sifive.com
To:     Atish Patra <atish.patra@wdc.com>
cc:     linux-kernel@vger.kernel.org, Albert Ou <aou@eecs.berkeley.edu>,
        linux-riscv@lists.infradead.org,
        Palmer Dabbelt <palmer@sifive.com>,
        Christoph Hellwig <hch@lst.de>, Anup Patel <Anup.Patel@wdc.com>
Subject: Re: [PATCH v4 0/3] Optimize tlbflush path
In-Reply-To: <alpine.DEB.2.21.9999.1908301939300.16731@viisi.sifive.com>
Message-ID: <alpine.DEB.2.21.9999.1910242001550.28076@viisi.sifive.com>
References: <20190822075151.24838-1-atish.patra@wdc.com> <alpine.DEB.2.21.9999.1908301939300.16731@viisi.sifive.com>
User-Agent: Alpine 2.21.9999 (DEB 301 2018-08-15)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 30 Aug 2019, Paul Walmsley wrote:

> On Thu, 22 Aug 2019, Atish Patra wrote:
> 
> > This series adds few optimizations to reduce the trap cost in the tlb
> > flush path. We should only make SBI calls to remote tlb flush only if
> > absolutely required. 
> 
> The patches look great.  My understanding is that these optimization 
> patches may actually be a partial workaround for the TLB flushing bug that 
> we've been looking at for the last month or so, which can corrupt memory 
> or crash the system.

I don't think we're any closer to root-causing this issue.  Meanwhile, 
OpenSBI has merged patches to work around it.  So since many of us have 
looked at Atish's TLB optimization patches, and we all think they are 
useful optimizations, let's plan to merge it for v5.5-rc1.


- Paul

Return-Path: <SRS0=gp+X=WL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 57758C3A589
	for <linux-kernel@archiver.kernel.org>; Thu, 15 Aug 2019 20:29:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1943B2083B
	for <linux-kernel@archiver.kernel.org>; Thu, 15 Aug 2019 20:29:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="TZBSwwEe"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731979AbfHOU3Y (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 15 Aug 2019 16:29:24 -0400
Received: from mail-io1-f65.google.com ([209.85.166.65]:36238 "EHLO
        mail-io1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726865AbfHOU3X (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Aug 2019 16:29:23 -0400
Received: by mail-io1-f65.google.com with SMTP id o9so1807167iom.3
        for <linux-kernel@vger.kernel.org>; Thu, 15 Aug 2019 13:29:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google;
        h=date:from:to:cc:subject:in-reply-to:message-id:references
         :user-agent:mime-version;
        bh=3zMGQrUE3EUacLldQeVzqh4LwSGfvpMr8mJRvzACSDc=;
        b=TZBSwwEezcawSVNZH+A75BHDYHt86Jp1ExhFT8vaEmeCOK7nQuGV9QJVPPazwk/Ku6
         G7uOzEdiWUPRJBvVSImVcHfmRHeEjWKF3+fPNsIjKMjC090ZeES3WGG91W+PlTkpl1Uh
         BSFxoOQGBx4Z/oJpHzZwV2sTbbXxw438FlpApwHNeYdijWj6kwo87ikWEYNaDOvUTg5q
         p2ajq2dV+MDAVl57UdoSW23sadBfejXtoomIIw3UFpjl0q7xrdzDiyLZFAH6InH8raNy
         F5Nnj5CYwT+7toN4+Ot/KPImSYK040afUlaSsBZPUfgqAaKarIaYbJQwhByjQ6fALu8I
         nPbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:in-reply-to:message-id
         :references:user-agent:mime-version;
        bh=3zMGQrUE3EUacLldQeVzqh4LwSGfvpMr8mJRvzACSDc=;
        b=tf4EG7fbNUWqJVxZcvsC8VyOObiFsbu1S0hAL8zarA2uPBcgEOmKA+QLngSEp8hkmh
         hLVa/RmP9VFPZp10p5kaAq/smpulr0Wgi5Xll/QeTJKnHIPGCZvVGULYh59CjfFcaJpH
         aqhuZk1fnAn0iiiV55yzPh/0GTtPzPlnptA9bIOMYRjHEXCtaS4FX8XFvPKkUYGork41
         IKyxuqwVLCohSFaKH/vVHDZ+agvLR7p9qudZSmEfmJIDR+5/ZgLpZUupPL20oj0bsGj/
         BGiI1MEpdAHKtWmSptZvfGGtJDys8XjXk+N4QMWTGmUqd3APAz3wKuuxi+gOyeIlD7z8
         m0sw==
X-Gm-Message-State: APjAAAWhYYpNtzz99O1jSoaHRUnDbBAEfZ/BSeCw3KP/y2CF7NruVfva
        pEJ5RDm1bxy+Fcgy9goOvDzg0w==
X-Google-Smtp-Source: APXvYqztay6Yb+QIZjMIXgP/NTKKBDSokMhhJhNQBbxSBqLRj/Kts7XEjjIqjt8CsBOxwxaGiowugA==
X-Received: by 2002:a02:2243:: with SMTP id o64mr4786098jao.100.1565900962576;
        Thu, 15 Aug 2019 13:29:22 -0700 (PDT)
Received: from localhost (c-73-95-159-87.hsd1.co.comcast.net. [73.95.159.87])
        by smtp.gmail.com with ESMTPSA id e22sm2717551iog.2.2019.08.15.13.29.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Aug 2019 13:29:22 -0700 (PDT)
Date:   Thu, 15 Aug 2019 13:29:21 -0700 (PDT)
From:   Paul Walmsley <paul.walmsley@sifive.com>
X-X-Sender: paulw@viisi.sifive.com
To:     Alistair Francis <Alistair.Francis@wdc.com>,
        David Abdurachmanov <david.abdurachmanov@gmail.com>
cc:     Anup Patel <Anup.Patel@wdc.com>,
        "aou@eecs.berkeley.edu" <aou@eecs.berkeley.edu>,
        "palmer@sifive.com" <palmer@sifive.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "rppt@linux.ibm.com" <rppt@linux.ibm.com>,
        "hch@infradead.org" <hch@infradead.org>,
        Atish Patra <Atish.Patra@wdc.com>,
        "linux-riscv@lists.infradead.org" <linux-riscv@lists.infradead.org>
Subject: Re: [PATCH v5 2/2] RISC-V: Setup initial page tables in two stages
In-Reply-To: <CAEn-LTpz_iL0Ts5GG9J6oESN76DcjBaNs-Oz-c9CcpbmRiN5Sw@mail.gmail.com>
Message-ID: <alpine.DEB.2.21.9999.1908151327490.18249@viisi.sifive.com>
References: <20190607060049.29257-1-anup.patel@wdc.com> <20190607060049.29257-3-anup.patel@wdc.com> <alpine.DEB.2.21.9999.1907101703150.3422@viisi.sifive.com> <847fb8c879bbd2c3fd41dc1e428b3217253acebb.camel@wdc.com>
 <CAEn-LTpz_iL0Ts5GG9J6oESN76DcjBaNs-Oz-c9CcpbmRiN5Sw@mail.gmail.com>
User-Agent: Alpine 2.21.9999 (DEB 301 2018-08-15)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 15 Aug 2019, David Abdurachmanov wrote:

> Yes, I do see those in Fedora/RISCV build farm every morning, but with
> riscv64 and 5.2.0-rc7 kernel.

[...]

> fedora-riscv-4 login: [178876.406122] Unable to handle kernel paging
> request at virtual address 0000000000012a28
> fedora-riscv-7 login: [17983.074847] Unable to handle kernel paging
> request at virtual address 0fffffdff5e14700

Alistair, you're seeing panics immediately after the userspace transition, 
right?  100% of the time?

If so, this is probably a different bug.  Most likely the TLB flushing 
issue.


- Paul

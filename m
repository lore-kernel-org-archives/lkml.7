Return-Path: <SRS0=Ecng=WJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 99D94C433FF
	for <linux-kernel@archiver.kernel.org>; Tue, 13 Aug 2019 19:59:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 56E39208C2
	for <linux-kernel@archiver.kernel.org>; Tue, 13 Aug 2019 19:59:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="RpTx+//5"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726694AbfHMT7t (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 13 Aug 2019 15:59:49 -0400
Received: from mail-ot1-f67.google.com ([209.85.210.67]:38100 "EHLO
        mail-ot1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725923AbfHMT7t (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Aug 2019 15:59:49 -0400
Received: by mail-ot1-f67.google.com with SMTP id r20so27086556ota.5
        for <linux-kernel@vger.kernel.org>; Tue, 13 Aug 2019 12:59:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google;
        h=date:from:to:cc:subject:in-reply-to:message-id:references
         :user-agent:mime-version;
        bh=nWHNHqC3bIoRSwxuJl3F0SbV8pQ/Gx2zD3CiOeVvxHM=;
        b=RpTx+//5O9mDpRShXm2soE7BxQNZ/E69lzZKvBD4Eyj7Zcz5AZ9/JOnA8RRj2j8zMO
         np46BJ79HOnpT+k6xHYwZHiAn7QQ/5KJXvhZgThFn4T132QDvX4j2UwDrxtSXLgbPRfi
         Xtl3NDG+bO5TG+1A5WsST2oftutb6MChj4lnoKmqN66lS1SurI87+w3SQcgDLtO8B5Ed
         WOGeet1AOPhlp99+tLtt/SIMWWf7NYE66VYIkhL+8YwyOnjMlsVf+K0Lhc+SC41x4pVE
         plxrVBAhhcAk565C8P/alfYup7JAk2GDSrGZggsWdTX/XlKstw3W3Yl5yqqrKOj0BXuu
         Speg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:in-reply-to:message-id
         :references:user-agent:mime-version;
        bh=nWHNHqC3bIoRSwxuJl3F0SbV8pQ/Gx2zD3CiOeVvxHM=;
        b=Z0cGBNktOS0r0iTYN1xia/EJ4NMix264/jbr6YRIag3FsGSbASTgPTd04XlBSzXBOh
         86BuR79qQCRy/aLS+Od75yBOLA0qqJ3+eV7OsHMxb9PMUGjgWkyh/nZYo2GM/4YW+VBH
         qaynI3P0Rvp4qrfdZIUygOLkrc0QGhzE/nsK8q5VlVF3BZdGp1MEYXP34xL/DDKJKg1Y
         axb6eZilBFmudvuduywcperrXl2J6wLh7IqfOzhXDvlJrpoPi1k836gsStA2FbCzoufH
         qXKJ/yP7DK3Q6UobOs1FFVZylVwM+NdUZEQRzh5tyVlUeyBpGP+Odm53HXqVVdXIO2P1
         /uhA==
X-Gm-Message-State: APjAAAVqTJLFhdxAoxd/I1SphHt8yuoxEjPZpeInOIuqyNd20md1ELR+
        E7oUZK9C2YY4IJaxKf9vZpv6bA==
X-Google-Smtp-Source: APXvYqwc0uOqr7pRZlj85UgmmPYYrogEs6beI+PqksxlVBwZUtkPwKhgCRe5EWMdFyOGNFdEQENfxw==
X-Received: by 2002:a6b:6209:: with SMTP id f9mr2472333iog.236.1565726388798;
        Tue, 13 Aug 2019 12:59:48 -0700 (PDT)
Received: from localhost (c-73-95-159-87.hsd1.co.comcast.net. [73.95.159.87])
        by smtp.gmail.com with ESMTPSA id o6sm9868759ioh.22.2019.08.13.12.59.48
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Tue, 13 Aug 2019 12:59:48 -0700 (PDT)
Date:   Tue, 13 Aug 2019 12:59:47 -0700 (PDT)
From:   Paul Walmsley <paul.walmsley@sifive.com>
X-X-Sender: paulw@viisi.sifive.com
To:     Bin Meng <bmeng.cn@gmail.com>
cc:     Albert Ou <aou@eecs.berkeley.edu>, Anup Patel <Anup.Patel@wdc.com>,
        Palmer Dabbelt <palmer@sifive.com>,
        linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org,
        Andreas Schwab <schwab@suse.de>, Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH v3] riscv: Using CSR numbers to access CSRs
In-Reply-To: <1565194418-9672-1-git-send-email-bmeng.cn@gmail.com>
Message-ID: <alpine.DEB.2.21.9999.1908131259290.5033@viisi.sifive.com>
References: <1565184656-4282-1-git-send-email-bmeng.cn@gmail.com> <1565194418-9672-1-git-send-email-bmeng.cn@gmail.com>
User-Agent: Alpine 2.21.9999 (DEB 301 2018-08-15)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 7 Aug 2019, Bin Meng wrote:

> Since commit a3182c91ef4e ("RISC-V: Access CSRs using CSR numbers"),
> we should prefer accessing CSRs using their CSR numbers, but there
> are several leftovers like sstatus / sptbr we missed.
> 
> Signed-off-by: Bin Meng <bmeng.cn@gmail.com>
> Reviewed-by: Anup Patel <anup@brainfault.org>

Thanks, queued for v5.4-rc1.


- Paul

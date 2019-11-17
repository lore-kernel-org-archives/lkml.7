Return-Path: <SRS0=PwuH=ZJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 770FCC432C0
	for <linux-kernel@archiver.kernel.org>; Sun, 17 Nov 2019 23:14:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4893320727
	for <linux-kernel@archiver.kernel.org>; Sun, 17 Nov 2019 23:14:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="HuGsw0WO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726475AbfKQXOq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 17 Nov 2019 18:14:46 -0500
Received: from mail-io1-f65.google.com ([209.85.166.65]:43802 "EHLO
        mail-io1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726268AbfKQXOp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 17 Nov 2019 18:14:45 -0500
Received: by mail-io1-f65.google.com with SMTP id r2so11465639iot.10
        for <linux-kernel@vger.kernel.org>; Sun, 17 Nov 2019 15:14:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google;
        h=date:from:to:cc:subject:in-reply-to:message-id:references
         :user-agent:mime-version;
        bh=2SwiOPrz9lQzJrPwuSOi0dkJbqCkOMet1m3VEq6ehp8=;
        b=HuGsw0WO1ywbPU4/6vTO8BnOAFHadJD0Pg7GJPIHyM7K2ZXzN9XA7KhlvLSHqaIWGR
         lxf3aSHSqHWt4a+iyHvbmE9UBLs7kqS7EjO67heUYvMtNCcadSHCMzqW262LcbSs+Ftv
         1zUBYo2K4iTDVrJB5lCFUQnitCLrNia7AvDkxhmGFbp5xf+hL8sl0/IVpk8+oVPaAHI5
         zi+hSjAIJHUgW83rltsywRF5KCK5EGSUAQfKdrYNKpf0tI7oaQ6n+1Qh068ev8pkliAa
         QR183GeoiAqs/zLa9+jalxef/R+oj358ZNQYdY/AOqiauKiopgBQJoLKDUxnK0gTDAm1
         AS3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:in-reply-to:message-id
         :references:user-agent:mime-version;
        bh=2SwiOPrz9lQzJrPwuSOi0dkJbqCkOMet1m3VEq6ehp8=;
        b=tvh1mg/zIYAJ/O49CkhOKzT3QVp2LyPMVGdmwH3PlqFYKZ5XCjA18EMKMm9YOGJRNb
         9OB7BHybYGA/DnhqwcbVgWMJuX/c2cZmkS4Z/dLtJCS6fQHMGSHAY/QDEi3VVt+c27J4
         iCs9vZkycLwkfnCK3w+YuSRq0soupRY0XuWwOS4kHtfRM64stZmILz8kp2Np2/XSLJbx
         sXxrlyE390O/01857ZTQ0ElytrPBxVBSavMmH9QNP4B0BcG1rTsVBvu0bYyv1sNyeQYW
         oPDU/awGYoCVCF4wzKBFvwEEOGelqhrR3rh3WYtw7cX2bd07xe9UTNAkz9genUECw4nX
         QBgw==
X-Gm-Message-State: APjAAAU3UF3ZBEBv+HILvlkTGfSkkYPy0aMQwxsWNe9cEWYq+Uc0lzxU
        CTwBuFDbMMRU7KE1zXde7IzujQ==
X-Google-Smtp-Source: APXvYqywhlrj8ZldFVX9V6ThX8YouDrfs2kh5MsGe9hqOAGTww9D5VUPGptXnPS/Ju6fmldtDbdHHg==
X-Received: by 2002:a5d:85c7:: with SMTP id e7mr10166083ios.59.1574032484957;
        Sun, 17 Nov 2019 15:14:44 -0800 (PST)
Received: from localhost ([2601:8c4:0:9294:cb6f:4cf:b239:2fee])
        by smtp.gmail.com with ESMTPSA id y15sm3976054iln.32.2019.11.17.15.14.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 17 Nov 2019 15:14:44 -0800 (PST)
Date:   Sun, 17 Nov 2019 15:14:43 -0800 (PST)
From:   Paul Walmsley <paul.walmsley@sifive.com>
X-X-Sender: paulw@viisi.sifive.com
To:     Christoph Hellwig <hch@lst.de>
cc:     Palmer Dabbelt <palmer@sifive.com>,
        Damien Le Moal <damien.lemoal@wdc.com>,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        Anup Patel <anup@brainfault.org>
Subject: Re: [PATCH 11/12] riscv: provide a flat image loader
In-Reply-To: <20191028121043.22934-12-hch@lst.de>
Message-ID: <alpine.DEB.2.21.9999.1911171514260.5296@viisi.sifive.com>
References: <20191028121043.22934-1-hch@lst.de> <20191028121043.22934-12-hch@lst.de>
User-Agent: Alpine 2.21.9999 (DEB 301 2018-08-15)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 28 Oct 2019, Christoph Hellwig wrote:

> This allows just loading the kernel at a pre-set address without
> qemu going bonkers trying to map the ELF file.
> 
> Contains a controbution from Aurabindo Jayamohanan to reuse the
> PAGE_OFFSET definition.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> Reviewed-by: Anup Patel <anup@brainfault.org>

Thanks, queued for v5.5-rc1.


- Paul

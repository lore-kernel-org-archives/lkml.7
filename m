Return-Path: <SRS0=tgXE=2S=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B0356C2D0C8
	for <linux-kernel@archiver.kernel.org>; Sat, 28 Dec 2019 06:04:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7EAF620722
	for <linux-kernel@archiver.kernel.org>; Sat, 28 Dec 2019 06:04:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="mWj/glpF"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726359AbfL1GEM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 28 Dec 2019 01:04:12 -0500
Received: from mail-pj1-f68.google.com ([209.85.216.68]:51571 "EHLO
        mail-pj1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725857AbfL1GEM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 28 Dec 2019 01:04:12 -0500
Received: by mail-pj1-f68.google.com with SMTP id j11so5606215pjs.1
        for <linux-kernel@vger.kernel.org>; Fri, 27 Dec 2019 22:04:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google;
        h=date:from:to:cc:subject:in-reply-to:message-id:references
         :user-agent:mime-version;
        bh=UHnltpIdmtv99s8Ay3j5EvPeMK+kCV0IwYbjU8qa/BQ=;
        b=mWj/glpFDtAIfwZhhH4CK7iwQXoEUeQIBvq1iA4O1i5vo+04DOIUBSgRBaiXgQhRTE
         sdDT/PcTaE8AiqfD1g3/vvenTg7pK6PphT4jQwBVPge0EJdmtQFNyhM1dxvH5CZZXv4n
         eX4z8hnFHDb8TQhYAXM4JJ98D7nm5Ve0OAafk728w7BWmECRTFgsvx/nsVyfC/QwAYpL
         7LuDtMllYUP9Ym8+JOrpIDVu4V+cCKRU39l8p2J/vAlJh6dfhcnt/422G8Bl2nWfv7IY
         4WQKd1i7AdxedKDZCdCWkZ14Ad9/3Tlp4a6LSqBPYIe9BWVkVKULOZqUYBHqCrbqIV89
         MCHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:in-reply-to:message-id
         :references:user-agent:mime-version;
        bh=UHnltpIdmtv99s8Ay3j5EvPeMK+kCV0IwYbjU8qa/BQ=;
        b=mBBCq9AEgqLzGKELH0eBd2KZXlKY3tR6sSuhKCeaY2yRxo+Whdjb5c2DD2wU+cXmaw
         r4a7rdkDPdXRdSCNFzQIbQtXs5DclchwtYu40iRd3sgfJ4zqMMOc8w4lPRdAIrmOqxrE
         qSr1yPto8PDxYvLWztToguT1xkSIa5GI7si1bhjxdlbqR9v/7uCp1+6kgFXhcqSoTKH6
         o2+OaUV/GRdcsLKAO8whG7CQQAQPtaipYAGvLW1aNch+8wuKrrdiNDxfjug0WDnIhbgE
         FahfjbAQouQHeBtzekIo9N28tWDELQADQBaT/geQ3yVHelSYifqiOuunjn/LG5I0g5Nn
         Ibig==
X-Gm-Message-State: APjAAAWMXOH+/MZ6cd1Fl8GW4RNb1l6mYayLVrZ2k3L6DP9ILhGUZhmE
        vcvKPlTIjclG/51k9g81bq6BjZIpypg=
X-Google-Smtp-Source: APXvYqyWdnS9g1IihQlcQOZcv/w+7ACgjVAzwEUEpt8ur/ux93P509B9aen4dTfZpQXXBoiFQA6v6w==
X-Received: by 2002:a17:90a:ab0c:: with SMTP id m12mr30393735pjq.81.1577513051649;
        Fri, 27 Dec 2019 22:04:11 -0800 (PST)
Received: from localhost ([64.62.168.194])
        by smtp.gmail.com with ESMTPSA id q15sm39582730pgi.55.2019.12.27.22.04.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Dec 2019 22:04:10 -0800 (PST)
Date:   Fri, 27 Dec 2019 22:04:09 -0800 (PST)
From:   Paul Walmsley <paul.walmsley@sifive.com>
X-X-Sender: paulw@viisi.sifive.com
To:     Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
cc:     linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org,
        kbuild test robot <lkp@intel.com>,
        Christoph Hellwig <hch@lst.de>,
        Palmer Dabbelt <palmer@dabbelt.com>
Subject: Re: [PATCH] riscv: fix compile failure with EXPORT_SYMBOL() & !MMU
In-Reply-To: <20191222092604.92217-1-luc.vanoostenryck@gmail.com>
Message-ID: <alpine.DEB.2.21.9999.1912272203260.194339@viisi.sifive.com>
References: <20191222092604.92217-1-luc.vanoostenryck@gmail.com>
User-Agent: Alpine 2.21.9999 (DEB 301 2018-08-15)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 22 Dec 2019, Luc Van Oostenryck wrote:

> When support for !MMU was added, the declaration of
> __asm_copy_to_user() & __asm_copy_from_user() were #ifdefed
> out hence their EXPORT_SYMBOL() give an error message like:
>   .../riscv_ksyms.c:13:15: error: '__asm_copy_to_user' undeclared here
>   .../riscv_ksyms.c:14:15: error: '__asm_copy_from_user' undeclared here
> 
> Since these symbols are not defined with !MMU it's wrong to export them.
> Same for __clear_user() (even though this one is also declared in
> include/asm-generic/uaccess.h and thus doesn't give an error message).
> 
> Fix this by doing the EXPORT_SYMBOL() directly where these symbols
> are defined: inside lib/uaccess.S itself.
> 
> Fixes 6bd33e1ece528f67646db33bf97406b747dafda0
> Reported-by: kbuild test robot <lkp@intel.com>
> Cc: Christoph Hellwig <hch@lst.de>
> Cc: Palmer Dabbelt <palmer@dabbelt.com>
> Cc: Paul Walmsley <paul.walmsley@sifive.com>
> Signed-off-by: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>

Thanks Luc; queued for v5.5-rc.


- Paul

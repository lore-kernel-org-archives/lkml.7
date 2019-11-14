Return-Path: <SRS0=RWM+=ZG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,URIBL_SBL,URIBL_SBL_A,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C0E94C432C3
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Nov 2019 07:45:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 94ADB206DC
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Nov 2019 07:45:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="iuW8cKb+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726263AbfKNHpM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Nov 2019 02:45:12 -0500
Received: from mail-ot1-f66.google.com ([209.85.210.66]:40117 "EHLO
        mail-ot1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726000AbfKNHpM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Nov 2019 02:45:12 -0500
Received: by mail-ot1-f66.google.com with SMTP id m15so4058484otq.7
        for <linux-kernel@vger.kernel.org>; Wed, 13 Nov 2019 23:45:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google;
        h=date:from:to:cc:subject:in-reply-to:message-id:references
         :user-agent:mime-version;
        bh=dKg/k5qQH9spLz57/2miGXOjddJokItWVKvEng4G0Iw=;
        b=iuW8cKb+IKhbV1bFCx5109eZeJhUncE1UV7wudHbBIKmXPQ4m/SYYe4xVquJZXnvD4
         kCBpUfC80OQy6lt8GMe0L6CKRiMwe+NzPgHcoAfJ4z5uYT+sseVEHPlBMR5tTGLPYo2r
         NZ42Bwjk7h0YfpPsVnVx5f0mBIS0PKJXI0slr3lcdeHC/2DbHUwYBwy9GFuSD9cRm6Qu
         4s3OZuqje2pftqEpC+GB2q1YCf9t8LVrHDDNf2/z2GTIBw4hbrMhwlShbjKaPEo9abwt
         D4Dc4vsNC1mr5jFPBybKEOYliVqn+x59FOTOUdesg6D/YaaOelAFunXV329vnbxOtObJ
         +1Sg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:in-reply-to:message-id
         :references:user-agent:mime-version;
        bh=dKg/k5qQH9spLz57/2miGXOjddJokItWVKvEng4G0Iw=;
        b=H8JXRaDQk24EJDpfQnmpJRaV9LzoCNLoy0Je44yAf6UZcdgQrIsm+xjNa0ooW3NgD2
         sxlmpAtZbNAE9OnJx60yT9YmXu3CVh3ZSINAGNv+kUWNhs3awdf/rOka7Eyk/ACEzn3X
         JGKGTAYT1244xJBoF2eXp+IYP4KqElGaBlhWXpsXvgCF8IJgeXdIMi8PPx3dJmAkrw0u
         HZrNnq3KfAbYO4u4uP5VDGztJOvY0SNL7NeQ5RBXoko+NvKyBG6FI4ZXAmW+LMBPv/1o
         IK0Rp6kpJanevszINKiWAue2r7ue0cfYblxt+aJqrgoccbty4U2StlUB8AfBwkIxRkmK
         PBUQ==
X-Gm-Message-State: APjAAAUbXUnIupAOCZt8xw5vrmBRDNb5CcBsWY7You0ukiFPnLfhelyc
        uugYduIe/5SrvKs2e88TfSvYsA==
X-Google-Smtp-Source: APXvYqzFrDF+lSCTrF1j8O4mTzBCFW8nox2nwrgCgZfzyKd0fGwuQwTQZx3Rhm+flvGA0Ut3R+LK5w==
X-Received: by 2002:a9d:1a5:: with SMTP id e34mr6709264ote.105.1573717511403;
        Wed, 13 Nov 2019 23:45:11 -0800 (PST)
Received: from localhost (wsip-98-172-187-222.no.no.cox.net. [98.172.187.222])
        by smtp.gmail.com with ESMTPSA id j129sm1579463oib.22.2019.11.13.23.45.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Nov 2019 23:45:10 -0800 (PST)
Date:   Wed, 13 Nov 2019 23:45:10 -0800 (PST)
From:   Paul Walmsley <paul.walmsley@sifive.com>
X-X-Sender: paulw@viisi.sifive.com
To:     Christoph Hellwig <hch@lst.de>
cc:     Palmer Dabbelt <palmer@sifive.com>,
        Damien Le Moal <damien.lemoal@wdc.com>,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        Anup Patel <anup@brainfault.org>
Subject: Re: [PATCH 09/12] riscv: clear the instruction cache and all registers
 when booting
In-Reply-To: <20191028121043.22934-10-hch@lst.de>
Message-ID: <alpine.DEB.2.21.9999.1911132344530.11342@viisi.sifive.com>
References: <20191028121043.22934-1-hch@lst.de> <20191028121043.22934-10-hch@lst.de>
User-Agent: Alpine 2.21.9999 (DEB 301 2018-08-15)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 28 Oct 2019, Christoph Hellwig wrote:

> When we get booted we want a clear slate without any leaks from previous
> supervisors or the firmware.  Flush the instruction cache and then clear
> all registers to known good values.  This is really important for the
> upcoming nommu support that runs on M-mode, but can't really harm when
> running in S-mode either.  Vaguely based on the concepts from opensbi.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> Reviewed-by: Anup Patel <anup@brainfault.org>

Thanks, queued for v5.5-rc1.

- Paul

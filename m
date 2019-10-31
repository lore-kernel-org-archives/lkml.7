Return-Path: <SRS0=21RF=YY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,URIBL_SBL,URIBL_SBL_A,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6F63FCA9ECB
	for <linux-kernel@archiver.kernel.org>; Thu, 31 Oct 2019 23:57:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3F6DB2087F
	for <linux-kernel@archiver.kernel.org>; Thu, 31 Oct 2019 23:57:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="QKg7HV2p"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728528AbfJaX5t (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 31 Oct 2019 19:57:49 -0400
Received: from mail-io1-f67.google.com ([209.85.166.67]:39364 "EHLO
        mail-io1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726506AbfJaX5s (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Oct 2019 19:57:48 -0400
Received: by mail-io1-f67.google.com with SMTP id 18so8952184ion.6
        for <linux-kernel@vger.kernel.org>; Thu, 31 Oct 2019 16:57:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google;
        h=date:from:to:cc:subject:in-reply-to:message-id:references
         :user-agent:mime-version;
        bh=DlWmb7IgZmhk+yp3PdCqAG1wjzyXN6dB08lLnHa3HSI=;
        b=QKg7HV2pAE7DIHMgc/9tZeYwmdgbo2E+YYpv/47wUW17mWxHMTJ5yDYC1ruwzxtcBi
         t9+kMhToecgxgoI9nhoVEw48Li/xVty1stCAtxtG2RovvSqv6rBCW78Ehp2+j5EmcFIs
         UOsW5rIqW+axEbyd0M32o/mbx1WjWmbDfpaeJM3ZPxA0i4TfejI2Ms4I4Fk4TkLTCXOk
         E6jErckYSrZ5IsP2d9+KaHBP6/LFhTB5wKaR74Ro+UGxej9RmD+qE31b37b6ceScIvMQ
         8HLgAIs4bzDWhGXenL4fkBDEmp1SRIC7UgIcF8wSRhSbW5f+nKIPRZm7EB3gfwyDL2or
         mXDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:in-reply-to:message-id
         :references:user-agent:mime-version;
        bh=DlWmb7IgZmhk+yp3PdCqAG1wjzyXN6dB08lLnHa3HSI=;
        b=Bn9DZYUwJV3vE9A9IBd5jVccO9YnSxe0dJyjrVyeNZJtE9UM4X5D2IJiwop9260g1u
         A9gOiK6s4/w0B6+fWNqVQE8Ltpza3MHDb5nSQevbS7Mr7H+WLrsf7Toanyx2+JtZlSeG
         2VBJNKVzRkU06mLWokwSl4jHHl/7k+5wJYKF+wJ+//NjXjHhARUKEZ130pLEVQoTGt6j
         RC1dTBC98dLC5Wfc2gAdX+mBFbFA6lOsXUUDFQXjG0Uk+pyYAoTF45I9Xg+BHnEef1tf
         HZRzac+YOcXK51/I7AbQpoOybkEo7qVMXX1IxmpVVSpzrvevb5ucBgdjDeHWgxWT6ePe
         nJzQ==
X-Gm-Message-State: APjAAAV/FBfSl3EIJ6eWDFIqcAc4OkjdnWMJHeYbag1oJPqWNk3xvm+4
        EFsrXlMEjncRSiEyEgZnaddgxZTW59c=
X-Google-Smtp-Source: APXvYqy/KVTA2A/G8TC2Xo2QaQ5wgHyPiwtcrr4nHibTrr61rJ7aezpdz/Jbn9eXGIwUvSRXBQWkrQ==
X-Received: by 2002:a05:6638:da:: with SMTP id w26mr5957124jao.58.1572566267869;
        Thu, 31 Oct 2019 16:57:47 -0700 (PDT)
Received: from localhost ([64.62.168.194])
        by smtp.gmail.com with ESMTPSA id s70sm807595ili.13.2019.10.31.16.57.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 31 Oct 2019 16:57:47 -0700 (PDT)
Date:   Thu, 31 Oct 2019 16:57:45 -0700 (PDT)
From:   Paul Walmsley <paul.walmsley@sifive.com>
X-X-Sender: paulw@viisi.sifive.com
To:     Christoph Hellwig <hch@lst.de>
cc:     Palmer Dabbelt <palmer@sifive.com>,
        Damien Le Moal <damien.lemoal@wdc.com>,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        Anup Patel <anup@brainfault.org>
Subject: Re: [PATCH 05/12] riscv: implement remote sfence.i using IPIs
In-Reply-To: <20191028121043.22934-6-hch@lst.de>
Message-ID: <alpine.DEB.2.21.9999.1910311657150.25874@viisi.sifive.com>
References: <20191028121043.22934-1-hch@lst.de> <20191028121043.22934-6-hch@lst.de>
User-Agent: Alpine 2.21.9999 (DEB 301 2018-08-15)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 28 Oct 2019, Christoph Hellwig wrote:

> The RISC-V ISA only supports flushing the instruction cache for the
> local CPU core.  Currently we always offload the remote TLB flushing to
> the SBI, which then issues an IPI under the hoods.  But with M-mode
> we do not have an SBI so we have to do it ourselves.   IPI to the
> other nodes using the existing kernel helpers instead if we have
> native clint support and thus can IPI directly from the kernel.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> Reviewed-by: Anup Patel <anup@brainfault.org>

Thanks, queued for v5.5-rc1 with a minor fix to one of the code comments.


- Paul

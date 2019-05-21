Return-Path: <SRS0=9PYC=TV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 10F92C04AAF
	for <linux-kernel@archiver.kernel.org>; Tue, 21 May 2019 05:31:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DA41521743
	for <linux-kernel@archiver.kernel.org>; Tue, 21 May 2019 05:31:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="kyLq6vqx"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727822AbfEUFbi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 21 May 2019 01:31:38 -0400
Received: from mail-lf1-f67.google.com ([209.85.167.67]:40629 "EHLO
        mail-lf1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725794AbfEUFbh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 May 2019 01:31:37 -0400
Received: by mail-lf1-f67.google.com with SMTP id h13so12026928lfc.7
        for <linux-kernel@vger.kernel.org>; Mon, 20 May 2019 22:31:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=BtJH/XFatQoBOkqt6CnXFYn8cVFYIMDvg7sFFa+676w=;
        b=kyLq6vqxe11UGM5dCp65/VIEmlD+ACNL83MCfoFC4CUz1LW2/BkZq4jQPkPHtoH8Ze
         tbExs1uaTjddyOv7pHBFTilzgdvXBRGSZKZXcpcn8xDRUGBmna44cQXLRF96xO5UXA4u
         eYGAysbsIfGMw15tyeUOW4868nK5HtjkxNHYDXZkLaE0/bvwzSKsmyMn1g8Y97f7epr5
         QPgL7TJOZ7IO8L2Aff3vxpQwf56lh+FleBOwoZLtOZ0xtS8nWiBooOlgBkDp+5b0SYgW
         JtV2bfR2aAL4pJj7ygZJl1GuzifomEgI2FgLpQehqn/Cpw+fhIjwKraPQ3DYgPxGcaM3
         8xHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=BtJH/XFatQoBOkqt6CnXFYn8cVFYIMDvg7sFFa+676w=;
        b=Qx/oYtCBsdXsF5OYVy4JUnK1a47XcxTJ0rMEpaNJeuYW5z8b0b5urRkG/X4rIzU2Az
         tALll3Z9fQ+ZCaHGip7gmSYIN1g3kEo6v786jwD6LmpvJVNK/7Hj7kzILezaRShgN+fg
         uf2mAKtlTbFzOoKHJOZuMxKdgwNBgUBxNkzpgCu57eK3ItXPja0LTXwMiSrAtyQnIFZj
         2GLrfvcz54nBXjZcFDGSkdigrx/Utrmc2htcBshFsnZbimuKXW8DPmXad6T9HaCFZL+x
         0ykMvlG4iLJbCLVOF6meTZal0gAcNjCzv9d1OGT8v9zB4oR/X2p2RxIfeAtiwon9po1W
         iaog==
X-Gm-Message-State: APjAAAV0ojV8LtszCOa+xROEk2LBvgGeBcftYuP6lmP/PeBcj8MTvQeV
        PyuooB2rjeiWKaBbMAiCtxyjVagoScnjUIpGHRmj/A==
X-Google-Smtp-Source: APXvYqwTO5cDb3MVcX3rsZTp5AzbDa+LWhvMDys5bBDQIRDcxlANQjUTioD3NEoxscJG3c+mMbm/QAYAZESzHIp/t1k=
X-Received: by 2002:a19:c60f:: with SMTP id w15mr39497034lff.61.1558416695999;
 Mon, 20 May 2019 22:31:35 -0700 (PDT)
MIME-Version: 1.0
References: <1557142026-15949-1-git-send-email-yash.shah@sifive.com> <1557142026-15949-2-git-send-email-yash.shah@sifive.com>
In-Reply-To: <1557142026-15949-2-git-send-email-yash.shah@sifive.com>
From:   Yash Shah <yash.shah@sifive.com>
Date:   Tue, 21 May 2019 11:00:59 +0530
Message-ID: <CAJ2_jOG9Ag0spbh3YCxavUE5XEAUP1pHcgCZ56Nu2u4TqfrzHQ@mail.gmail.com>
Subject: Re: [PATCH v2] edac: sifive: Add EDAC platform driver for SiFive SoCs
To:     linux-edac@vger.kernel.org, linux-riscv@lists.infradead.org,
        Palmer Dabbelt <palmer@sifive.com>,
        Borislav Petkov <bp@alien8.de>,
        James Morse <james.morse@arm.com>
Cc:     Paul Walmsley <paul.walmsley@sifive.com>,
        linux-kernel@vger.kernel.org, aou@eecs.berkeley.edu,
        mchehab@kernel.org, Sachin Ghadi <sachin.ghadi@sifive.com>,
        davem@davemloft.net, gregkh@linuxfoundation.org,
        nicolas.ferre@microchip.com, paulmck@linux.ibm.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 6, 2019 at 4:57 PM Yash Shah <yash.shah@sifive.com> wrote:
>
> The initial ver of EDAC driver supports:
> - ECC event monitoring and reporting through the EDAC framework for SiFive
>   L2 cache controller.
>
> The EDAC driver registers for notifier events from the L2 cache controller
> driver (arch/riscv/mm/sifive_l2_cache.c) for L2 ECC events
>
> Signed-off-by: Yash Shah <yash.shah@sifive.com>
> Reviewed-by: James Morse <james.morse@arm.com>
> ---
> This patch depends on patch
> 'RISC-V: sifive_l2_cache: Add L2 cache controller driver for SiFive SoCs'
> https://lkml.org/lkml/2019/5/6/255

The prerequisite patch (sifive_l2_cache driver) has been merged into
mainline v5.2-rc1
It should be OK to merge this edac driver now.

- Yash

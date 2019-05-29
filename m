Return-Path: <SRS0=t3dz=T5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 07CE7C28CC0
	for <linux-kernel@archiver.kernel.org>; Wed, 29 May 2019 16:41:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DFEB623E2C
	for <linux-kernel@archiver.kernel.org>; Wed, 29 May 2019 16:41:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727280AbfE2Qlw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 May 2019 12:41:52 -0400
Received: from mail-pf1-f195.google.com ([209.85.210.195]:33606 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726605AbfE2Qlv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 May 2019 12:41:51 -0400
Received: by mail-pf1-f195.google.com with SMTP id z28so2000037pfk.0
        for <linux-kernel@vger.kernel.org>; Wed, 29 May 2019 09:41:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:subject:in-reply-to:cc:from:to:message-id
         :mime-version:content-transfer-encoding;
        bh=PDhUrA5/RrC3JM7DYbgnLMAMpwwCgpy6bnreDMvHf4U=;
        b=J8wNHRrxWsG5CWgUp3ekQW4kM2q+nuKkiB2cNIbTaZKH8JZMjtq28QRmpDRb88RDjf
         WAPpuUJf5EL72x9TDWjE7SwoPCu3kh/vpZDn1Z9LfHmPQ4jnGkybGiKMd4IjdmXPBHBF
         rPTTHtCiv40U+P4qZ8Cpu/hBymWZceW+Z7FdQ/7Fsi2oy3Bz+6wkLkjzjdQvcb9YwtwL
         7cLxVQiiXieAZiBnvs8BQHvudQeBrglSC1nqYYCyyxuGKZxqYuEMrYz5Ew4HQHTLSTkk
         1cNA5XKorPKAn211q4VeDbEydR2Ah4bCQjXKE8w48WKZ8S7eT2eu/YRAxeC1vV31PfUV
         by+A==
X-Gm-Message-State: APjAAAWmwNJwB/Vg7t3LFerMGTJpb/u2UBnXruPg89iTu18D7yV+S0h8
        HrJOIpy7lujp2xA2Sou/7f+Jng==
X-Google-Smtp-Source: APXvYqyZ3V1656NRZe9sautQeFGu8evjanQeuikfzOH4Kg314/FswV7M7Zan7JmCuTha1Fo9ELaMIQ==
X-Received: by 2002:a62:ae0e:: with SMTP id q14mr6280675pff.164.1559148106114;
        Wed, 29 May 2019 09:41:46 -0700 (PDT)
Received: from localhost ([12.206.222.5])
        by smtp.gmail.com with ESMTPSA id 128sm180525pff.16.2019.05.29.09.41.45
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 29 May 2019 09:41:45 -0700 (PDT)
Date:   Wed, 29 May 2019 09:41:45 -0700 (PDT)
X-Google-Original-Date: Wed, 29 May 2019 09:39:12 PDT (-0700)
Subject:     Re: [PATCH] riscv: fix locking violation in page fault handler
In-Reply-To: <mvmy336luba.fsf@suse.de>
CC:     linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
From:   Palmer Dabbelt <palmer@sifive.com>
To:     schwab@suse.de
Message-ID: <mhng-35399cf5-4e49-4d23-9a53-297a53c3d573@palmer-si-x1e>
Mime-Version: 1.0 (MHng)
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 16 May 2019 00:42:01 PDT (-0700), schwab@suse.de wrote:
> On Mai 07 2019, Palmer Dabbelt <palmer@sifive.com> wrote:
>
>> LMK if you, or anyone else, has a preference.  I'm assuming this will go in
>> through my tree, so I've picked up my version for now :)
>
> You did?

It ended up landing in Linus' tree as 8fef9900d43f ("riscv: fix locking
violation in page fault handler"), so it looks like I did manage avoid losing
this one.

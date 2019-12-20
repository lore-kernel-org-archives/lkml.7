Return-Path: <SRS0=w7sF=2K=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9A9CAC43603
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Dec 2019 11:07:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6B9C324679
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Dec 2019 11:07:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="FwfDOzr2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727315AbfLTLHL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 20 Dec 2019 06:07:11 -0500
Received: from mail-il1-f196.google.com ([209.85.166.196]:46399 "EHLO
        mail-il1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727177AbfLTLHK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Dec 2019 06:07:10 -0500
Received: by mail-il1-f196.google.com with SMTP id t17so7579744ilm.13
        for <linux-kernel@vger.kernel.org>; Fri, 20 Dec 2019 03:07:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google;
        h=date:from:to:cc:subject:in-reply-to:message-id:references
         :user-agent:mime-version;
        bh=CuvYmZxLd8M5BiQxeXMEPvKPsn+T62f9uaUdU+HsmZI=;
        b=FwfDOzr2MfGAiaCWXP4Vk9K87UmjUQo6aakivfZOVFPohjKd5SrzNfxYDQ8tvd9eBC
         +YanTBNiGCq353VWzjbaueAE1tkeJjXv0T/suPEhNc8cgeqkauiTLFXGilXy9FMoBoG6
         HvGb3ovru3NdYW1DqwJ6bJkUDYkVBDWlYROV2ALtuirb8h9eLcuWGQwrjX7/i6NzHbqR
         N7JXX4ucOsr7H5352iJQ58Im9WfybP1VlQatLQWNRe//JgEHcx/i/GV1Bwj5Up1INqrH
         GRGO8EOQ/CdEjaGlrlkdpv6AGkh/Jhp3jwErieygv8Ncr6AhVuEd+YG7NIC+/KBHmxAx
         qMog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:in-reply-to:message-id
         :references:user-agent:mime-version;
        bh=CuvYmZxLd8M5BiQxeXMEPvKPsn+T62f9uaUdU+HsmZI=;
        b=BfPmINE5s96f8GSbE1WM6PKgaZh6tpEbSa7WbY5gmGHCYsIFs3nCs/C6kVeoixCi9z
         kIRBCGUS0+e3gP/osXJ034aqgUhrNQpuAybu8LJyn3jDl9xzX7wrQxb1+YALcuYfiNMe
         YbyQZOzJdvJMbkR/AZ1c7bhxnvSVUzawXRnDnzStOxzCZWRRM9R0QovyTqq7rgyeUXDF
         JIZZTJBcDf/pAWoPuvdb9PhgzStZs+7VYh44fcbG9wEp5B5Z3S4wuOuXdIEnEqFeWPm8
         3jARrU2XSdpyVRkwRyahrfp/UPuNNhvQ5C8s0IndN9b93xvQJD/t+XUj5ko8pLFYi7yI
         e8dA==
X-Gm-Message-State: APjAAAWkf3Q3+t+M1sX7+LUYdW576jPVz1881PpmbooEc72Oy0fFljYC
        o/WjpFVRlb7kcknJhF8r8q0yUw==
X-Google-Smtp-Source: APXvYqwpMTaRtzctXAmhjDIK368kqdrepo6dFIR1hQ9bfncZwyvO5j/1INF5YTU3nfNI5+PJkTY+Sg==
X-Received: by 2002:a92:9e99:: with SMTP id s25mr11698837ilk.80.1576840030346;
        Fri, 20 Dec 2019 03:07:10 -0800 (PST)
Received: from localhost (67-0-26-4.albq.qwest.net. [67.0.26.4])
        by smtp.gmail.com with ESMTPSA id g6sm4416389ilj.64.2019.12.20.03.07.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Dec 2019 03:07:09 -0800 (PST)
Date:   Fri, 20 Dec 2019 03:07:08 -0800 (PST)
From:   Paul Walmsley <paul.walmsley@sifive.com>
X-X-Sender: paulw@viisi.sifive.com
To:     Greentime Hu <greentime.hu@sifive.com>
cc:     green.hu@gmail.com, greentime@kernel.org, hch@lst.de,
        palmer@dabbelt.com, linux-riscv@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] riscv: fix scratch register clearing in M-mode.
In-Reply-To: <20191219064459.20790-1-greentime.hu@sifive.com>
Message-ID: <alpine.DEB.2.21.9999.1912200306570.3767@viisi.sifive.com>
References: <20191219064459.20790-1-greentime.hu@sifive.com>
User-Agent: Alpine 2.21.9999 (DEB 301 2018-08-15)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 19 Dec 2019, Greentime Hu wrote:

> This patch fixes that the sscratch register clearing in M-mode. It cleared
> sscratch register in M-mode, but it should clear mscratch register. That will
> cause kernel trap if the CPU core doesn't support S-mode when trying to access
> sscratch.
> 
> Fixes: 9e80635619b5 ("riscv: clear the instruction cache and all registers when booting")
> Signed-off-by: Greentime Hu <greentime.hu@sifive.com>

Thanks Greentime, queued for v5.5-rc.

- Paul

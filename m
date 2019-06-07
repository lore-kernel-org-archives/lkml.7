Return-Path: <SRS0=2dYc=UG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EB1F4C2BCA1
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Jun 2019 23:30:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B415520868
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Jun 2019 23:30:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="1k1SzTsm"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730348AbfFGX37 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Jun 2019 19:29:59 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:44189 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730089AbfFGX37 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Jun 2019 19:29:59 -0400
Received: by mail-pf1-f194.google.com with SMTP id t16so1981281pfe.11
        for <linux-kernel@vger.kernel.org>; Fri, 07 Jun 2019 16:29:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:in-reply-to:references:date:message-id
         :mime-version;
        bh=I1PywGpIKSbkW0TWj4vZQWbg6HMbsTN3+fpFYP0xgw0=;
        b=1k1SzTsm1Ud8uu8kDrkNN7lSN+ROfcV2DHlbyFdUfCX7EoP2ofCPMwnre+fh5d5viP
         SRIxgm3GiUBdi1KBfPHFwfeKuZkkrEVugtRwpqZbAYDhadtTcL2K4d6ZVa6RxIFTigOp
         B30CZlHv+4uh3iefmsqR+fLOIuUvBPNNvyfUN6GM79sbHWQ9611jxaOzUWvFUOL0TYRm
         5ivwaEQ8sTcsb405Ufw6GDs8EDXZoTKViSaQ7aqIays29uyTShHqAiKhIvnsdM4NSEiM
         0sws9Kqlv2qD34Wn25NypjrqnR5g0BTDyCrTuLzKO6xHolWp0Tro2PoH+2nb53IZ5tms
         g9QA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version;
        bh=I1PywGpIKSbkW0TWj4vZQWbg6HMbsTN3+fpFYP0xgw0=;
        b=HMS8UMPzUUHMw9GPvVqr1z0D0aO/z0p4qHLpisUm47b8N6xQ23xVkh6s/iZnnpffno
         wrxWsRYT2+5+6pO5NoAt9ZfToaX4P+7gpVkriobuAHWzw6TESMyHHoPvdUs0ptYqtG0W
         GrLV2wp5H3LZy97SaqmX2xeXocgy0kDLA0NQgzCkLEGp/KWLyx4kAHMmWOyB0a/Sm40a
         D9Ax2AYpOsNB7gTgjSTO7Frgfsc9c4ix/S0K7S8YHrxYNG0VCgA6oBVQYsA4FKfWQgsr
         cFad1H4iFY2KWHWWse4ywhZuV60FbnWS4ShaAO9H5BzKhCLmR4oBrSbdXXdNBHFV7XZK
         VqKw==
X-Gm-Message-State: APjAAAWhsxS36NNuMSuUMSPL1vnwTd7q20RigVPWYcNg4AzXSXPDlWSe
        ik9s+WWrO1ec4kIf4PARcy3Txw==
X-Google-Smtp-Source: APXvYqwNQQJVPEemCv+XbvWWBEWm2pO4zGQmJGYgK94LzsBPnbkxSliCDyzqks25l326dpkQXcJgzg==
X-Received: by 2002:a63:191b:: with SMTP id z27mr5107334pgl.327.1559950198221;
        Fri, 07 Jun 2019 16:29:58 -0700 (PDT)
Received: from localhost (c-71-197-186-152.hsd1.wa.comcast.net. [71.197.186.152])
        by smtp.googlemail.com with ESMTPSA id e184sm7910921pfa.169.2019.06.07.16.29.56
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 07 Jun 2019 16:29:57 -0700 (PDT)
From:   Kevin Hilman <khilman@baylibre.com>
To:     linux-riscv@lists.infradead.org, Palmer Dabbelt <palmer@sifive.com>
Cc:     linux-kernel@vger.kernel.org, Atish Patra <atish.patra@wdc.com>,
        Loys Ollivier <lollivier@baylibre.com>
Subject: Re: [PATCH] RISC-V: defconfig: enable clocks, serial console
In-Reply-To: <20190605175042.13719-1-khilman@baylibre.com>
References: <20190605175042.13719-1-khilman@baylibre.com>
Date:   Fri, 07 Jun 2019 16:29:56 -0700
Message-ID: <7h5zphas97.fsf@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Palmer,

Kevin Hilman <khilman@baylibre.com> writes:

> Enable PRCI clock driver and serial console by default, so the default
> upstream defconfig is bootable to a serial console.
>
> Signed-off-by: Kevin Hilman <khilman@baylibre.com>

If possible, this would be great to have for v5.2-rc so we have a
bootable upstream defconfig ready for kernelCI as soon as the DT series
lands.

Kevin

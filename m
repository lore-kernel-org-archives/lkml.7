Return-Path: <SRS0=OvUS=X5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 98569C47404
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Oct 2019 17:35:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6B640222BE
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Oct 2019 17:35:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="R8tPzBVI"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388348AbfJDRfq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 4 Oct 2019 13:35:46 -0400
Received: from mail-io1-f67.google.com ([209.85.166.67]:33184 "EHLO
        mail-io1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387948AbfJDRfq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Oct 2019 13:35:46 -0400
Received: by mail-io1-f67.google.com with SMTP id z19so15378960ior.0
        for <linux-kernel@vger.kernel.org>; Fri, 04 Oct 2019 10:35:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google;
        h=date:from:to:cc:subject:in-reply-to:message-id:references
         :user-agent:mime-version;
        bh=oovUconFoZBqNagUNSlVfZVpfIZyDqPDT/CS6h4yspg=;
        b=R8tPzBVIbwYLF10JXGaRyqUSriMYzhv7spR40ceRqO4WuChwvefLVAWFpRT4np59+b
         j+UGpiP33B6BJRwp3hjm4sKp7obvptYCvBaGlLL3I6gGawFLujuEiwq9EbHLm8YWOUiO
         f1M0GhgQ73gdfhg9WM8bhULqg4DQmAnjT3UmGwbyfsBLNU5ZpyHpp73HRa3PImj/+0Qa
         mEVsU4ckdYRg1hlgrujJjaHkVJ082g7/z2qHK+nXBVfYpkXr/rq1R4kk0OraheeJ3LNs
         RjhBn67cYrrrwYfFvrkFdfaEZeApElHzUsZfa39SnlDL7ImWf6t0V8DgJD7nvbXyGoy/
         yqIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:in-reply-to:message-id
         :references:user-agent:mime-version;
        bh=oovUconFoZBqNagUNSlVfZVpfIZyDqPDT/CS6h4yspg=;
        b=JnirubNLJ26tdZiatBCEi+pVuMKnE1im/ibb8KGXJ4jPy2ChJJWiT3AiILQYbo3z0b
         iDV7Y5i4LnJXD0I6wwruBM5dbIn7MvVu3XpuTMxyhFUvDaZN03wtSk0j6d3K9+AbGhfb
         9kxL9KTWxqZ9GM5L95PlvRTZgEMn8vawsh4NTTqsppZWbjefEFdyNgqm+Nk0QdgahRFm
         Ll3SjcdDYsExPc06WyuuKDQRfpHCT6ckZ6bm4X6t6HKDtF7o1WfoKZLCAv8Blel+DeBW
         KjC1ygvcwGUjBzfYt8qzFBqWAYE3aBTCTz/PUzndhU4vQXQ6ZEnxuUeKzDJiAi7s0MD9
         fgQg==
X-Gm-Message-State: APjAAAUb2CRFFZGWoYlez3wx8J6ZIMr3s8ya/BTt9FDIzCEH2aSihIjP
        p0cVmsjQReilpacHEG4CW83M6Q==
X-Google-Smtp-Source: APXvYqxvYn72ktE7CKz9uGGXhGnh/KTLFuWKIMA57WzZfBVVSihoHoDE+6U4DPpck5tJO94CnT1h3w==
X-Received: by 2002:a92:8347:: with SMTP id f68mr16680035ild.216.1570210545382;
        Fri, 04 Oct 2019 10:35:45 -0700 (PDT)
Received: from localhost (67-0-10-3.albq.qwest.net. [67.0.10.3])
        by smtp.gmail.com with ESMTPSA id p81sm3621162ilk.86.2019.10.04.10.35.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Oct 2019 10:35:44 -0700 (PDT)
Date:   Fri, 4 Oct 2019 10:35:44 -0700 (PDT)
From:   Paul Walmsley <paul.walmsley@sifive.com>
X-X-Sender: paulw@viisi.sifive.com
To:     Palmer Dabbelt <palmer@sifive.com>
cc:     linux-riscv@lists.infradead.org, mark.rutland@arm.com,
        me@carlosedp.com, linux-kernel@vger.kernel.org, joel@sing.id.au,
        marco@decred.org
Subject: Re: [PATCH] RISC-V: Clear load reservations while restoring hart
 contexts
In-Reply-To: <20190925001556.12827-1-palmer@sifive.com>
Message-ID: <alpine.DEB.2.21.9999.1910041035340.15827@viisi.sifive.com>
References: <20190925001556.12827-1-palmer@sifive.com>
User-Agent: Alpine 2.21.9999 (DEB 301 2018-08-15)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 24 Sep 2019, Palmer Dabbelt wrote:

> This is almost entirely a comment.  The bug is unlikely to manifest on
> existing hardware because there is a timeout on load reservations, but
> manifests on QEMU because there is no timeout.
> 
> Signed-off-by: Palmer Dabbelt <palmer@sifive.com>

Thanks, queued for v5.4-rc.


- Paul

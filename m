Return-Path: <SRS0=OaAC=YQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B119FCA9EA0
	for <linux-kernel@archiver.kernel.org>; Wed, 23 Oct 2019 00:05:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 82C5D2084B
	for <linux-kernel@archiver.kernel.org>; Wed, 23 Oct 2019 00:05:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="Y+boVY1h"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731273AbfJWAE2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 22 Oct 2019 20:04:28 -0400
Received: from mail-io1-f68.google.com ([209.85.166.68]:35202 "EHLO
        mail-io1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727610AbfJWAE2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Oct 2019 20:04:28 -0400
Received: by mail-io1-f68.google.com with SMTP id t18so18570309iog.2
        for <linux-kernel@vger.kernel.org>; Tue, 22 Oct 2019 17:04:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google;
        h=date:from:to:cc:subject:in-reply-to:message-id:references
         :user-agent:mime-version;
        bh=1rtVr/ZOhpNpvbFSPZYgwy0CM3ZRkSH7ha89fWeyBas=;
        b=Y+boVY1hjhDRKWtrcGpFDcm0GwovVPTWbsrU2MchHjtOF7yX5Kb4Im3xw04s2HMhP6
         pwDTJ7wiXMpBV28Pj4VO7o+mPBCGcnyZNITcfem8VeyJ34KmCNuY+39RX3ArXgcvg83l
         ufDPIFtVbLF0kDbtdYw0ovgumUPXSmkXUTrO6CAx4g3kMiuzRIKtyW/OSBxCITcv/wYM
         DjM30dPrY8dIvSDk4tuEtV5F6krPfdImPHc4bqzMJoIsNsOeXHbYra7kY8OElLJaQNcG
         zqHuuH/eKwoIcU3sDgeWUl+gi4TJs8GbpztY1vSxQe8bSJg+kk0GeGAlJ+NQRTZAR14Q
         YxTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:in-reply-to:message-id
         :references:user-agent:mime-version;
        bh=1rtVr/ZOhpNpvbFSPZYgwy0CM3ZRkSH7ha89fWeyBas=;
        b=BJDxgZ/OpfZlXeMQtqGXhuF8WImVeK6ulT+A1I5UFOJ6xQAh4p/JmpzxguYD+3qubJ
         Bi7hvwYYqxp1RqAz8sbDKciWw27WKlBUmr81QRdz1ahpLdgIZcRIKD875q7+zkI2gjWN
         n7RcKGvRIplMILCcZLqdwqKXzIUUY7s64oF8WE9W/HPhMYHTI8NqW9Jdg7nlDOx10QO9
         vNEziv3qW3i7O7R0xAE5YvTPnQG2sADGQUF+JXcte9rt8sk48BJXgkXBnhN6tNX/y9Hf
         OqmUL5xBaySNIkej7U0LkN9pW4QyuOP+dRngLYONvhVB/MscJzVbPGLVe4HoQP3Svqpe
         axGA==
X-Gm-Message-State: APjAAAWFAlX/H/ikqSkC9hPWk+1O/QF+10oJmaeGsZ5gsZtCryAmrB65
        39NlK/FYi93p8Zi4SahIgSe5zw==
X-Google-Smtp-Source: APXvYqzyoNKcYzwZ/8xyNs7i4pJ3CtGNzrEchhGUJe7DwTb0UAJxkLfB10L7NcRu39S/HmlD+n1LNg==
X-Received: by 2002:a6b:d61a:: with SMTP id w26mr477097ioa.159.1571789067401;
        Tue, 22 Oct 2019 17:04:27 -0700 (PDT)
Received: from localhost ([64.62.168.194])
        by smtp.gmail.com with ESMTPSA id q66sm8814241ili.69.2019.10.22.17.04.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Oct 2019 17:04:26 -0700 (PDT)
Date:   Tue, 22 Oct 2019 17:04:24 -0700 (PDT)
From:   Paul Walmsley <paul.walmsley@sifive.com>
X-X-Sender: paulw@viisi.sifive.com
To:     David Abdurachmanov <david.abdurachmanov@gmail.com>
cc:     Palmer Dabbelt <palmer@sifive.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Anup Patel <Anup.Patel@wdc.com>,
        Mike Rapoport <rppt@linux.ibm.com>,
        Greentime Hu <greentime.hu@sifive.com>,
        Stefan O'Rear <sorear2@gmail.com>,
        David Abdurachmanov <david.abdurachmanov@sifive.com>,
        Alexandre Ghiti <alex@ghiti.fr>,
        Logan Gunthorpe <logang@deltatee.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] riscv: fix fs/proc/kcore.c compilation with sparsemem
 enabled
In-Reply-To: <20191022162136.19076-1-david.abdurachmanov@sifive.com>
Message-ID: <alpine.DEB.2.21.9999.1910221703540.25457@viisi.sifive.com>
References: <20191022162136.19076-1-david.abdurachmanov@sifive.com>
User-Agent: Alpine 2.21.9999 (DEB 301 2018-08-15)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 22 Oct 2019, David Abdurachmanov wrote:

> Failed to compile Fedora/RISCV kernel (5.4-rc3+) with sparsemem enabled:
> 
> fs/proc/kcore.c: In function 'read_kcore':
> fs/proc/kcore.c:510:8: error: implicit declaration of function 'kern_addr_valid'; did you mean 'virt_addr_valid'? [-Werror=implicit-function-declaration]
>   510 |    if (kern_addr_valid(start)) {
>       |        ^~~~~~~~~~~~~~~
>       |        virt_addr_valid
> 
> Looking at other architectures I don't see kern_addr_valid being guarded by
> CONFIG_FLATMEM.
> 
> Fixes: d95f1a542c3d ("RISC-V: Implement sparsemem")
> Signed-off-by: David Abdurachmanov <david.abdurachmanov@sifive.com>
> Tested-by: David Abdurachmanov <david.abdurachmanov@sifive.com>

Thanks, queued for v5.4-rc with Logan's Reviewed-by:.


- Paul

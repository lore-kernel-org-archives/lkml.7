Return-Path: <SRS0=E2Zf=ZP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.3 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E53C6C432C0
	for <linux-kernel@archiver.kernel.org>; Sat, 23 Nov 2019 18:29:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B38EF2068D
	for <linux-kernel@archiver.kernel.org>; Sat, 23 Nov 2019 18:29:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="tPlWJIgY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726744AbfKWS3u (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 23 Nov 2019 13:29:50 -0500
Received: from mail-pj1-f65.google.com ([209.85.216.65]:40245 "EHLO
        mail-pj1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726494AbfKWS3t (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 23 Nov 2019 13:29:49 -0500
Received: by mail-pj1-f65.google.com with SMTP id ep1so4592393pjb.7
        for <linux-kernel@vger.kernel.org>; Sat, 23 Nov 2019 10:29:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:subject:in-reply-to:cc:from:to:message-id:mime-version
         :content-transfer-encoding;
        bh=TES+D47gjUEYLRi0DVPp3J/8b4TWlZhdLdQzXfHGuX4=;
        b=tPlWJIgYpLWxBMHIO+01rkY8YKxvLtDYYVMoe/agzNO7wcd6XN4T3Oxg18xvGSlu2t
         OABJrLs27BBj6Xf9sdIezGJ5bya1ZQyYD1Cd0qaaSgdCoxhC+bN0VH2IXZhoPbyKSZFN
         tLdnqE8ZNvfhOIHZ1HTl0InMhWgPadCNG9opM3qdZBlVJurXrYT0bMtmN8pPZVRKS9Xe
         6eXHrMcrkpPO3jSrOKQWSnedNH+QAh3QD40h/MZ+l6dC96Fh7K31D4R0I8d4jrgQHsQG
         bS9Gb07OQxOie7CTOH8Y4VX/AH8cTjdnCVBPvA2LQd8Rfrt1hThwORt95GNgvwBc0ZN1
         6lIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:subject:in-reply-to:cc:from:to:message-id
         :mime-version:content-transfer-encoding;
        bh=TES+D47gjUEYLRi0DVPp3J/8b4TWlZhdLdQzXfHGuX4=;
        b=iKYL9zqEwsO8bpDaSSBRKAPISu9HoCuFqsWPhnbpvgqNbbLInL49zN7u2FAyBhn4xi
         GfxSNSD5fqT+XIbvT77AAITYaY4xeeJQDarJp1eiIXX5UfhLDru2Ya09Dsyq/x3fvLYC
         +l9c5KK3x0g9mkahqcGgcXNDKQ2oKoXimZGDrV5CrZY46QNK4zHqHo+jH6GY/6Xm8JGk
         0HUWO1KRzhTQYEnb6O50C1bv/gOuczNCcXRxWUAtuOwxTgt4MsM5806aE1soGhBOwroD
         tcGS3qQBfUASMnZfPcA0FhhvKqkxSqEXH+6dxH/wJfxPo3BlIyPY2tWaPCctdZJVCRRg
         ZGJA==
X-Gm-Message-State: APjAAAVpLLYG8y9F5mxHwzeMOIRsv2C5JotbX4xIK97mraes8O6NgfM2
        bfa00cMdOzNYRiUDvg0pj8nL+Q==
X-Google-Smtp-Source: APXvYqw7ayFmjaG98HZR4MgbH2glRl8JwiusMos4hjFqGGyavQywamTVSiYvu2KXur0XuWQM18gYiA==
X-Received: by 2002:a17:90a:1:: with SMTP id 1mr27811515pja.42.1574533788576;
        Sat, 23 Nov 2019 10:29:48 -0800 (PST)
Received: from localhost ([2620:0:1000:3510:a526:6d27:395d:e917])
        by smtp.gmail.com with ESMTPSA id 81sm2331345pfx.142.2019.11.23.10.29.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 23 Nov 2019 10:29:47 -0800 (PST)
Date:   Sat, 23 Nov 2019 10:29:47 -0800 (PST)
X-Google-Original-Date: Sat, 23 Nov 2019 10:24:07 PST (-0800)
Subject:     Re: [PATCH] Documentation: riscv: add patch acceptance guidelines
In-Reply-To: <alpine.DEB.2.21.9999.1911221842200.14532@viisi.sifive.com>
CC:     linux-riscv@lists.infradead.org, aou@eecs.berkeley.edu,
        krste@berkeley.edu, waterman@eecs.berkeley.edu,
        linux-kernel@vger.kernel.org, corbet@lwn.net,
        linux-doc@vger.kernel.org
From:   Palmer Dabbelt <palmerdabbelt@google.com>
To:     Paul Walmsley <paul.walmsley@sifive.com>
Message-ID: <mhng-ff930dda-c0ba-447c-9753-03dee62ba21c@palmerdabbelt-glaptop>
Mime-Version: 1.0 (MHng)
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 22 Nov 2019 18:44:39 PST (-0800), Paul Walmsley wrote:
>
> Formalize, in kernel documentation, the patch acceptance policy for
> arch/riscv.  In summary, it states that as maintainers, we plan to only
> accept patches for new modules or extensions that have been frozen or
> ratified by the RISC-V Foundation.
>
> We've been following these guidelines for the past few months.  In the
> meantime, we've received quite a bit of feedback that it would be
> helpful to have these guidelines formally documented.
>
> Signed-off-by: Paul Walmsley <paul.walmsley@sifive.com>
> Cc: Palmer Dabbelt <palmer@dabbelt.com>
> Cc: Albert Ou <aou@eecs.berkeley.edu>
> Cc: Krste Asanovic <krste@berkeley.edu>
> Cc: Andrew Waterman <waterman@eecs.berkeley.edu>
> ---
>  Documentation/riscv/patch-acceptance.rst | 32 ++++++++++++++++++++++++
>  1 file changed, 32 insertions(+)
>  create mode 100644 Documentation/riscv/patch-acceptance.rst
>
> diff --git a/Documentation/riscv/patch-acceptance.rst b/Documentation/riscv/patch-acceptance.rst
> new file mode 100644
> index 000000000000..2e658353b53c
> --- /dev/null
> +++ b/Documentation/riscv/patch-acceptance.rst
> @@ -0,0 +1,32 @@
> +.. SPDX-License-Identifier: GPL-2.0
> +
> +====================================================
> +arch/riscv maintenance and the RISC-V specifications
> +====================================================
> +
> +The RISC-V instruction set architecture is developed in the open:
> +in-progress drafts are available for all to review and to experiment
> +with implementations.  New module or extension drafts can change
> +during the development process - sometimes in ways that are
> +incompatible with previous drafts.  This flexibility can present a
> +challenge for RISC-V Linux maintenance.  Linux maintainers disapprove
> +of churn, and the Linux development process prefers well-reviewed and
> +tested code over experimental code.  We wish to extend these same
> +principles to the RISC-V-related code that will be accepted for
> +inclusion in the kernel.
> +
> +Therefore, as maintainers, we'll only accept patches for new modules
> +or extensions if the specifications for those modules or extensions
> +are listed as being "Frozen" or "Ratified" by the RISC-V Foundation.
> +(Developers may, of course, maintain their own Linux kernel trees that
> +contain code for any draft extensions that they wish.)
> +
> +Additionally, the RISC-V specification allows implementors to create
> +their own custom extensions.  These custom extensions aren't required
> +to go through any review or ratification process by the RISC-V
> +Foundation.  To avoid the maintenance complexity and potential
> +performance impact of adding kernel code for implementor-specific
> +RISC-V extensions, we'll only to accept patches for extensions that
> +have been officially frozen or ratified by the RISC-V Foundation.
> +(Implementors, may, of course, maintain their own Linux kernel trees
> +containing code for any custom extensions that they wish.)

Reviewed-by: Palmer Dabbelt <palmerdabbelt@google.com>

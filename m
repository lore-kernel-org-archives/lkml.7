Return-Path: <SRS0=3QRk=U6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EB1C6C0650E
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Jul 2019 18:51:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BEF1B21855
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Jul 2019 18:51:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="KZy85/4t"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726820AbfGASvy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Jul 2019 14:51:54 -0400
Received: from mail-io1-f65.google.com ([209.85.166.65]:43152 "EHLO
        mail-io1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726076AbfGASvy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Jul 2019 14:51:54 -0400
Received: by mail-io1-f65.google.com with SMTP id k20so4836177ios.10
        for <linux-kernel@vger.kernel.org>; Mon, 01 Jul 2019 11:51:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google;
        h=date:from:to:cc:subject:in-reply-to:message-id:references
         :user-agent:mime-version;
        bh=DYrhizvtIbWqHkjv2BkSfsRwmy8RzQ5cYYvDtrQv3lo=;
        b=KZy85/4tTSnfbHIjMO+VoX0+BzXfz2fZQXO03A8+ppgNGdVN1iiRyi0w65nxrfVUZl
         LepUYO6VLS+jWb4ZEZIP29HDqaCzsslQpNBhXbiOlIoxgSn2uuIl4ssVV9xuCXFt8tUT
         TL+Z5XhuSUaJjo0+lMAckhVGAYw8uHtOm4kXAp4cKTJsd9jeJqnnFl8VS6x5iUdwAk4o
         bvnvtEKAJCVVT91seyxUHFcUgBIhvWFC6h1heJaNnYcHpP3SG2SKIXfdKgofJ/rKSkPj
         aYy7DtYis+jalc6jZkzq+JsJ81egv/yIQivLKN+bVoPVv6YsKV8EOVJwFQr95bRlUiwD
         dPAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:in-reply-to:message-id
         :references:user-agent:mime-version;
        bh=DYrhizvtIbWqHkjv2BkSfsRwmy8RzQ5cYYvDtrQv3lo=;
        b=AVikWIcc8DR1JkjFoe/jDgUCaWeMm09IUueM7LOFXEdyCnZaxRWlc6VbYq4HL5gzM6
         7pVXYIhtzVhXH8ZZsutMI8n6ufdb6jI6AmppyZp0+em4Zpoxx8QubTtEZTvAtX0wVbkb
         EyIiALGsNY343RjfOjRnC75iwIlFVOh+7xhifQOXarCJ1esZI1GnIVU71QWBpqR1YQJ/
         lx51iHoCJt+OOK8Lgsc/kcv+bdnmq0bSCXnLSrLCQDKtSSTScibMpvEJ3FvCbi1iQFHI
         hRcMt2ePJwxqZr4hjLH5afYWZiDkm7tbRyYFFgu736wzilsZZ8KMMisaU0qHXEJ+kHOs
         cuZA==
X-Gm-Message-State: APjAAAV+o/BqK7zE/gwNCeOn6Bb5JGEuFJ4OwMEZR32GKSNmh6+Rr1s5
        J12Ns5CTzeOOM6JFJ6NI4atM6oTRqcI=
X-Google-Smtp-Source: APXvYqx8evMbqCB5mcUZCJSlJkUvQvODT7P9GsKOEHqnl7p98ygfjhRMioyAwvw2nWgeKnX/BBIurQ==
X-Received: by 2002:a02:cb96:: with SMTP id u22mr30802401jap.118.1562007111969;
        Mon, 01 Jul 2019 11:51:51 -0700 (PDT)
Received: from localhost (c-73-95-159-87.hsd1.co.comcast.net. [73.95.159.87])
        by smtp.gmail.com with ESMTPSA id r5sm9977978iom.42.2019.07.01.11.51.51
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Mon, 01 Jul 2019 11:51:51 -0700 (PDT)
Date:   Mon, 1 Jul 2019 11:51:50 -0700 (PDT)
From:   Paul Walmsley <paul.walmsley@sifive.com>
X-X-Sender: paulw@viisi.sifive.com
To:     Palmer Dabbelt <palmer@sifive.com>,
        Catalin Marinas <catalin.marinas@arm.com>
cc:     Hanjun Guo <guohanjun@huawei.com>, Alexandre Ghiti <alex@ghiti.fr>,
        Christoph Hellwig <hch@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Palmer Dabbelt <palmer@sifive.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H . Peter Anvin" <hpa@zytor.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-riscv@lists.infradead.org
Subject: Re: [PATCH v3 1/2] x86, arm64: Move ARCH_WANT_HUGE_PMD_SHARE config
 in arch/Kconfig
In-Reply-To: <20190701175900.4034-2-alex@ghiti.fr>
Message-ID: <alpine.DEB.2.21.9999.1907011146550.3867@viisi.sifive.com>
References: <20190701175900.4034-1-alex@ghiti.fr> <20190701175900.4034-2-alex@ghiti.fr>
User-Agent: Alpine 2.21.9999 (DEB 301 2018-08-15)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Catalin, Palmer,

On Mon, 1 Jul 2019, Alexandre Ghiti wrote:

> ARCH_WANT_HUGE_PMD_SHARE config was declared in both architectures:
> move this declaration in arch/Kconfig and make those architectures
> select it.
> 
> Signed-off-by: Alexandre Ghiti <alex@ghiti.fr>

Since the change from v2 to v3 was minor (the removal of the "config 
ARCH_WANT_HUGE_PMD_SHARE" line from the arm64 port), I'm planning to 
apply your Reviewed-by:s and acks from 

https://lore.kernel.org/linux-riscv/20190603172723.GH63283@arrakis.emea.arm.com/

https://lore.kernel.org/linux-riscv/mhng-4d1d4acb-f65f-4ed4-bc86-85a14b7c3e16@palmer-si-x1e/

If there's any objection, please let me know as soon as possible.


- Paul

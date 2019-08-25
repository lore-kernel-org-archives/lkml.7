Return-Path: <SRS0=kjqD=WY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E4C0FC3A5A1
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Aug 2019 17:36:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B981B2173E
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Aug 2019 17:36:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="oFW8k5sh"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727021AbfH1Rg3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 28 Aug 2019 13:36:29 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:41788 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726975AbfH1Rg1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Aug 2019 13:36:27 -0400
Received: by mail-pg1-f193.google.com with SMTP id x15so95979pgg.8
        for <linux-kernel@vger.kernel.org>; Wed, 28 Aug 2019 10:36:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=m0Ol9KiCJuTthVJpNdqXavAOI9ULv3o3m1zh5s9b1As=;
        b=oFW8k5shx9dzTZCg4oYfKxxrESLsvpAIA5QCO3DOe5JfSNX5ICxHFKvHATbc9VgD3w
         5+rVewSkK5+kiL+7lS0d7oAaUMKOuRqjYZaH4CxrLhIbqdMKdMJyL9TmnRR+lSFDhS+9
         H/J3m1QfdE0eP7mou/vg7EAYza9c0CwIYY860=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=m0Ol9KiCJuTthVJpNdqXavAOI9ULv3o3m1zh5s9b1As=;
        b=Duo6ZM2ewpMH3NuEWS0SelFCjUDm5k60OKAC2xf87ON+QpHKSJZtnFG4PdDHEziMkm
         Nw6B/RiPBh0gv0DDzUFsEo4zUTCv+sMEzPeUVo0zq6kuGizVB4pDIf4sKyOq0z7606lA
         BUDFkgN4yW9cDc592LP6vVx96aGCU78b5GSMQ31GdjuTjkVxM05NKo4aA9pWgHAzt80b
         6ZYPmVBhySHiZTnc2eSCgJMEiR9WuyiHaDrpUDHQEDeQWiJdLfX9TGB3GxGKJT3UoP7g
         N5SYllX0oxKGavvvL5MAMc/sbKSPz1phc2G4htEvDvpJEACfRmYgvT8aZg5LTIsK109s
         oxNw==
X-Gm-Message-State: APjAAAV/Ck9P55kCtbPuTwTOuEsT7jSLB8vFH6lnpCM9fWZDJQm0D4Gp
        CqSjsHXFQQXl5Dt4kYGsHx08Wg==
X-Google-Smtp-Source: APXvYqyH/WYT3nu0TOtBHExVMlqdFHVZ7R0fY91sEAf7okZikcnLyqTOEJjyRHLyXhLgGQXRNGz22Q==
X-Received: by 2002:a63:f13:: with SMTP id e19mr4496092pgl.132.1567013786692;
        Wed, 28 Aug 2019 10:36:26 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id d11sm4397723pfh.59.2019.08.28.10.36.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Aug 2019 10:36:25 -0700 (PDT)
Date:   Sun, 25 Aug 2019 14:59:37 -0700
From:   Kees Cook <keescook@chromium.org>
To:     David Abdurachmanov <david.abdurachmanov@gmail.com>
Cc:     Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@sifive.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Oleg Nesterov <oleg@redhat.com>,
        Andy Lutomirski <luto@amacapital.net>,
        Will Drewry <wad@chromium.org>, Shuah Khan <shuah@kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Martin KaFai Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
        David Abdurachmanov <david.abdurachmanov@sifive.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Allison Randal <allison@lohutok.net>,
        Alexios Zavras <alexios.zavras@intel.com>,
        Anup Patel <Anup.Patel@wdc.com>,
        Vincent Chen <vincentc@andestech.com>,
        Alan Kao <alankao@andestech.com>,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org, netdev@vger.kernel.org,
        bpf@vger.kernel.org, me@carlosedp.com
Subject: Re: [PATCH v2] riscv: add support for SECCOMP and SECCOMP_FILTER
Message-ID: <201908251451.73C6812E8@keescook>
References: <20190822205533.4877-1-david.abdurachmanov@sifive.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190822205533.4877-1-david.abdurachmanov@sifive.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 22, 2019 at 01:55:22PM -0700, David Abdurachmanov wrote:
> This patch was extensively tested on Fedora/RISCV (applied by default on
> top of 5.2-rc7 kernel for <2 months). The patch was also tested with 5.3-rc
> on QEMU and SiFive Unleashed board.

Oops, I see the mention of QEMU here. Where's the best place to find
instructions on creating a qemu riscv image/environment?

> There is one failing kernel selftest: global.user_notification_signal

This test has been fragile (and is not arch-specific), so as long as
everything else is passing, I would call this patch ready to go. :)

Reviewed-by: Kees Cook <keescook@chromium.org>

-- 
Kees Cook

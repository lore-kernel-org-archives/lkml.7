Return-Path: <SRS0=g5d9=RD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7AEA2C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Feb 2019 23:43:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3AA7920C01
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Feb 2019 23:43:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1551397408;
	bh=dplmfv6vVROr0h1jNUQcvIOIDqhJRQKcihmYyn7pKts=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=N9CiMoSvxz6DDwYBidsBzMMYIERGbjKWnrDWRjdfE/qklDRx9DaASnB2024lIOOEa
	 v9dhG8mA/wV6YT5T32HxwJU1gzsXGiBJ2G3mzxu7pNMGkplfXu/Q8iTaoGqz33pOO1
	 TV6T03soAV0gMdTkC67yzvWNqzn5z4L/l54enWKk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728680AbfB1Xn0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Feb 2019 18:43:26 -0500
Received: from mail.kernel.org ([198.145.29.99]:58202 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727707AbfB1Xn0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Feb 2019 18:43:26 -0500
Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com [209.85.221.51])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id AEC1D218D9
        for <linux-kernel@vger.kernel.org>; Thu, 28 Feb 2019 23:43:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1551397406;
        bh=dplmfv6vVROr0h1jNUQcvIOIDqhJRQKcihmYyn7pKts=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=NQFe50H23wRdHX2hV0MXfoiF79PbTWAy5QhoyuStIjEiC9Bsjk/N1hFK6EfqLS6lg
         QVi7rQ7iZ8dnYx/0iGKi/QZM8YBciEH5lfeaixmA4qHOTqyM4zWb7lZqAwlyYmbMnI
         nwkR2P2/luyt+ZF+1sVDa9EwCU0JPG+mzEohNTOQ=
Received: by mail-wr1-f51.google.com with SMTP id n2so23883220wrw.8
        for <linux-kernel@vger.kernel.org>; Thu, 28 Feb 2019 15:43:25 -0800 (PST)
X-Gm-Message-State: APjAAAVA5Yq21qyU+1b0ubrRbjuUwW9dL8getdMnr/XhOEF+x5OGgW9w
        3o2W2T0Nz+dYeXxREv8PxXBxy3w0/VB4gGsuFk6CnQ==
X-Google-Smtp-Source: APXvYqyhD1Obv2Xz5j3nPTaLMXnbqwk6yRcYRxBJ0buqF8neDzSQqlJvvDasjXv8JvAfmdA1ipDjVjOIMm9Ia4eHbSs=
X-Received: by 2002:adf:e58f:: with SMTP id l15mr1212854wrm.309.1551397404167;
 Thu, 28 Feb 2019 15:43:24 -0800 (PST)
MIME-Version: 1.0
References: <20190228220155.88124-1-cai@lca.pw>
In-Reply-To: <20190228220155.88124-1-cai@lca.pw>
From:   Andy Lutomirski <luto@kernel.org>
Date:   Thu, 28 Feb 2019 15:43:12 -0800
X-Gmail-Original-Message-ID: <CALCETrW+p_PsdRfQh99JkPW2Zi6z_w4RqDnsK0=kU+D7RqeYzA@mail.gmail.com>
Message-ID: <CALCETrW+p_PsdRfQh99JkPW2Zi6z_w4RqDnsK0=kU+D7RqeYzA@mail.gmail.com>
Subject: Re: [PATCH] x86/mm: fix "cpu" set but not used
To:     Qian Cai <cai@lca.pw>
Cc:     Dave Hansen <dave.hansen@linux.intel.com>,
        Andrew Lutomirski <luto@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>, X86 ML <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 28, 2019 at 2:02 PM Qian Cai <cai@lca.pw> wrote:
>
> The commit a2055abe9c67 ("x86/mm: Pass flush_tlb_info to
> flush_tlb_others() etc") removed the unnecessary cpu parameter from
> uv_flush_tlb_others() but left an unused variable.
>
> arch/x86/mm/tlb.c: In function 'native_flush_tlb_others':
> arch/x86/mm/tlb.c:688:16: warning: variable 'cpu' set but not used
> [-Wunused-but-set-variable]
>    unsigned int cpu;
>                 ^~~
>

Acked-by: Andyt Lutomirski <luto@kernel.org>

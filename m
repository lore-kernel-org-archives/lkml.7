Return-Path: <SRS0=+gZy=2O=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A94CFC2D0D2
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Dec 2019 02:07:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7FDE42075B
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Dec 2019 02:07:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1577153266;
	bh=nuWZ8yhnitZpPr2h+5PU5xzGudc3XC10lX5Ec91GR+s=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=GkY5cH4lNoqpXGTGhHk2oBQI4C/b39xtttZSzBhE2RBLG4rYMo06iEF9tUJRFfoxo
	 IBQE+yb2UkReZ6CdKJBuwE9yXS2g7QsCJFn9Fdsu5zCwAdIcgkfK+B5m8i89Qeg6vb
	 xhpqORiqhUg0jhMpPoXODlbyHS25Ri0To0bUOIRY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727144AbfLXCHp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 23 Dec 2019 21:07:45 -0500
Received: from mail.kernel.org ([198.145.29.99]:46946 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726997AbfLXCHp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Dec 2019 21:07:45 -0500
Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5119321927
        for <linux-kernel@vger.kernel.org>; Tue, 24 Dec 2019 02:07:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1577153264;
        bh=nuWZ8yhnitZpPr2h+5PU5xzGudc3XC10lX5Ec91GR+s=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=E6kVU9g202rFhym4tXVVBYm1fF7zrf4imuKY1UsLFAoqO0HfSsUASADU8FpcnUTFX
         au8dQB0MMEwRaITZ7AkOA+CdDJ26kZ865Lo1+fULgI1ZCLw1Y/TN1ZP2AMm5x/siU4
         pk8YakrCG+Ck+yePKWOcsbZyKUUeS+p1lIRxmwIs=
Received: by mail-wr1-f49.google.com with SMTP id q6so18560544wro.9
        for <linux-kernel@vger.kernel.org>; Mon, 23 Dec 2019 18:07:44 -0800 (PST)
X-Gm-Message-State: APjAAAV6j1fZcEc/TcvetFzIWFa/n4tWiLL06/VFS4gD7yMzy493paPm
        b4yWSZOhAGDEPES0TVqsBpVZplFFu/kX7ok/6/CRcg==
X-Google-Smtp-Source: APXvYqykVrvy0YjrN0kH0ZW9RItFuTqBfOCiQcjlBJoCQ0o5yZwU56b/UhrC0QUXlKV7VRHUBN0rn8CMmknayBiXVnU=
X-Received: by 2002:adf:eb09:: with SMTP id s9mr34073707wrn.61.1577153262733;
 Mon, 23 Dec 2019 18:07:42 -0800 (PST)
MIME-Version: 1.0
References: <cover.1577111363.git.christophe.leroy@c-s.fr> <47701b5fb73cf536db074031db8e6e3fa3695168.1577111365.git.christophe.leroy@c-s.fr>
In-Reply-To: <47701b5fb73cf536db074031db8e6e3fa3695168.1577111365.git.christophe.leroy@c-s.fr>
From:   Andy Lutomirski <luto@kernel.org>
Date:   Mon, 23 Dec 2019 18:07:30 -0800
X-Gmail-Original-Message-ID: <CALCETrULuV5iAU3kSjMdcpV6DFGEw1z2so0DfDca6hoLB4X4cA@mail.gmail.com>
Message-ID: <CALCETrULuV5iAU3kSjMdcpV6DFGEw1z2so0DfDca6hoLB4X4cA@mail.gmail.com>
Subject: Re: [RFC PATCH v2 01/10] lib: vdso: ensure all arches have 32bit fallback
To:     Christophe Leroy <christophe.leroy@c-s.fr>
Cc:     Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Arnd Bergmann <arnd@arndb.de>,
        Thomas Gleixner <tglx@linutronix.de>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        Andrew Lutomirski <luto@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        "open list:MIPS" <linux-mips@vger.kernel.org>,
        X86 ML <x86@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 23, 2019 at 6:31 AM Christophe Leroy
<christophe.leroy@c-s.fr> wrote:
>
> In order to simplify next step which moves fallback call at arch
> level, ensure all arches have a 32bit fallback instead of handling
> the lack of 32bit fallback in the common code based
> on VDSO_HAS_32BIT_FALLBACK

I don't like this.  You've implemented what appear to be nonsensical
fallbacks (the 32-bit fallback for a 64-bit vDSO build?  There's no
such thing).

How exactly does this simplify patch 2?

--Andy

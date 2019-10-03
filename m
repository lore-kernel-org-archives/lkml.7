Return-Path: <SRS0=6dNS=X4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E27F7C10F14
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Oct 2019 20:49:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A0CD5222BE
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Oct 2019 20:49:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1570135791;
	bh=T7GyCKf+5lR0UHhpOwx4h8MhXmzyZ24igcrrwR+1Grc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=tZ74HMkQiHPdWyNA1vLBytBvB2MMnxrZqwEkl0/CGXK7CwpCv5dXpc1z/I4kKNAM9
	 rXHIoT5BQbYRpMfoo59H73a+tRasHuaItF7thFxYcET2BZympQElLkRPh/+KQ/nstO
	 O+M/aSuy7kRM0z/TS4OL26/fzqA8Zh/SyT77GVeY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731635AbfJCUtu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 3 Oct 2019 16:49:50 -0400
Received: from mail.kernel.org ([198.145.29.99]:41762 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727326AbfJCUtu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Oct 2019 16:49:50 -0400
Received: from willie-the-truck (236.31.169.217.in-addr.arpa [217.169.31.236])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 836AC2086A;
        Thu,  3 Oct 2019 20:49:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1570135790;
        bh=T7GyCKf+5lR0UHhpOwx4h8MhXmzyZ24igcrrwR+1Grc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=YlsegnXXNUnybEBXEiNuPIaAn6MGu0PBLmoyYyZOGQMBQhz2leOs4foXuyQddIs05
         FmGYYmMaGqfBjbUqRHuh53SzDP0dq/PhR7W6DOYBcJsEShxWm/6npfRvJdkMBuYZ/I
         D1T6Z3ytd0PlY3qs1BaBqxjwb0QWj1dLUCwZfts4=
Date:   Thu, 3 Oct 2019 21:49:45 +0100
From:   Will Deacon <will@kernel.org>
To:     Nick Desaulniers <ndesaulniers@google.com>
Cc:     Vincenzo Frascino <vincenzo.frascino@arm.com>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Andy Lutomirski <luto@kernel.org>
Subject: Re: [PATCH v5 2/6] arm64: vdso32: Detect binutils support for dmb
 ishld
Message-ID: <20191003204944.6wuzflqkjdpawzvp@willie-the-truck>
References: <20191003174838.8872-1-vincenzo.frascino@arm.com>
 <20191003174838.8872-3-vincenzo.frascino@arm.com>
 <CAKwvOdmhyVHREHvyB0wL2GfMsE8GcJ1Ouj_8ifrR4hU8kBYukQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAKwvOdmhyVHREHvyB0wL2GfMsE8GcJ1Ouj_8ifrR4hU8kBYukQ@mail.gmail.com>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 03, 2019 at 01:18:16PM -0700, Nick Desaulniers wrote:
> On Thu, Oct 3, 2019 at 10:48 AM Vincenzo Frascino
> <vincenzo.frascino@arm.com> wrote:
> >
> > Older versions of binutils that do not support certain types of memory
> > barriers can cause build failure of the vdso32 library.
> 
> Do you know specific version numbers of binutils that are affected?
> May be helpful to have in the commit message just for future
> travelers.

A quick bit of archaeology suggests e797f7e0b2be added this back in 2012,
which seems to correlate with the 2.24 release.

Will

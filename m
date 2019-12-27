Return-Path: <SRS0=GVTe=2R=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B5BAFC2D0C6
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Dec 2019 11:07:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 72E3320CC7
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Dec 2019 11:07:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1577444864;
	bh=q3rNVUgSWezoYAANYKGsbrCWgwXuaqppTl7vYxs9iNw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=nr9hw13sJQ512PH0vXDFnUxJeZ3lipgvFVJ0qAGKHFmh24t/60shW397yzvnNtWdV
	 QH0q6VmYJjCuvsdNrdmXyfawwzN6BTBbISpARPcgPk212MxWPNT33AgXVKILVzVGbI
	 UECG4rVXXhg/u+YnSHkMyASPvO/fJM3BNfPxrgTo=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726720AbfL0LHn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 27 Dec 2019 06:07:43 -0500
Received: from mail.kernel.org ([198.145.29.99]:49132 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726053AbfL0LHn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Dec 2019 06:07:43 -0500
Received: from rapoport-lnx (unknown [77.127.33.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id CE6B0208C4;
        Fri, 27 Dec 2019 11:07:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1577444862;
        bh=q3rNVUgSWezoYAANYKGsbrCWgwXuaqppTl7vYxs9iNw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=lN3X80yFRbeuFoQmfp/quJMjc6g1P35Nd3ItKRERu2SWl/hRsqZmgVkvfHE7Tk67z
         APClLY9JxqmZg+AXtrjLysNdRFEketcEQbKYoo7+SocC8BQY6/X1O24poFBF0OTNWI
         fxV38Crf4Uw13HwjHkOakhB1dKlrCirZsH4KLOLM=
Date:   Fri, 27 Dec 2019 13:07:37 +0200
From:   Mike Rapoport <rppt@kernel.org>
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     Nick Hu <nickhu@andestech.com>, Greentime Hu <green.hu@gmail.com>,
        Vincent Chen <deanbo422@gmail.com>, linux-arch@vger.kernel.org,
        linux-kernel@vger.kernel.org, Mike Rapoport <rppt@linux.ibm.com>,
        Mike Rapoport <rppt@kernel.org>
Subject: Re: [PATCH 0/2] fix recent nds32 build breakage
Message-ID: <20191227110736.GA30363@rapoport-lnx>
References: <20191223110004.2157-1-rppt@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191223110004.2157-1-rppt@kernel.org>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Arnd,

Can you please take these via asm-generic tree?

On Mon, Dec 23, 2019 at 01:00:02PM +0200, Mike Rapoport wrote:
> From: Mike Rapoport <rppt@linux.ibm.com>
> 
> Hi,
> 
> The kbuild robot reported build breakage of nds32 architecture [1] that
> happens with CONFIG_CPU_CACHE_ALIASING=n and CONFIG_HUGHMEM=y.
> 
> There are two issues: one with a missing macro during conversion of page
> folding and another one is a conflict between cacheflush.h definitions in
> arch/nds32 and asm-generic.
> 
> [1] https://lore.kernel.org/lkml/201912212139.yptX8CsV%25lkp@intel.com/
> 
> Mike Rapoport (2):
>   asm-generic/nds32: don't redefine cacheflush primitives
>   nds32: fix build failure caused by page table folding updates
> 
>  arch/nds32/include/asm/cacheflush.h | 11 ++++++----
>  arch/nds32/include/asm/pgtable.h    |  2 +-
>  include/asm-generic/cacheflush.h    | 33 ++++++++++++++++++++++++++++-
>  3 files changed, 40 insertions(+), 6 deletions(-)
> 
> -- 
> 2.24.0
> 

-- 
Sincerely yours,
Mike.

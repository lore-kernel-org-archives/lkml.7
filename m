Return-Path: <SRS0=6OEZ=YL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5FA6DCA9EA9
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Oct 2019 15:58:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2A26F21897
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Oct 2019 15:58:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="hOVWoIm1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391083AbfJRP6D (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 18 Oct 2019 11:58:03 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:51534 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726506AbfJRP6C (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Oct 2019 11:58:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=yYmrwGKEGtVRfsP/gPNywSLmmglMNKPJ/qLufe/HUsE=; b=hOVWoIm1RKwBJaTEP6/T2XsPV
        tw2x3CgSD9FqbMlobDs1zAlbvyrPiwICtqKXNcmcqb/fgxWd0P2HOg62zbx/Gty8fLoqSkcx8FC8l
        zjLbwT+w+gyn19WaE/nafQ83wIL70oiN2zRatzyZkU5FwSsxJ6ib0krzi/ycltJbcsbyUG28D/jhD
        vMy+6dPYmDJVp26leBsj6DfSNx2k9pOf06sVu4YCReNBKPE0KdD8tGne8MWflSusVtTxwgb7ImHRJ
        wjiu8si97RqyAVaot+giqDbmXCeWDQ/rq33Giju7Dx3UuiP3wCGur1pEPzfqTTr8r7cKWmAHSWrzF
        IU91TgbNQ==;
Received: from hch by bombadil.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1iLUdL-00086G-K0; Fri, 18 Oct 2019 15:57:43 +0000
Date:   Fri, 18 Oct 2019 08:57:43 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Steven Price <steven.price@arm.com>
Cc:     linux-mm@kvack.org, Mark Rutland <Mark.Rutland@arm.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>, linux-riscv@lists.infradead.org,
        Will Deacon <will@kernel.org>,
        "Liang, Kan" <kan.liang@linux.intel.com>,
        Alexandre Ghiti <alex@ghiti.fr>, x86@kernel.org,
        Ingo Molnar <mingo@redhat.com>,
        Palmer Dabbelt <palmer@sifive.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Arnd Bergmann <arnd@arndb.de>,
        =?iso-8859-1?B?Suly9G1l?= Glisse <jglisse@redhat.com>,
        Borislav Petkov <bp@alien8.de>,
        Andy Lutomirski <luto@kernel.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-arm-kernel@lists.infradead.org,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        linux-kernel@vger.kernel.org, James Morse <james.morse@arm.com>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH v12 07/22] riscv: mm: Add p?d_leaf() definitions
Message-ID: <20191018155743.GG25386@infradead.org>
References: <20191018101248.33727-1-steven.price@arm.com>
 <20191018101248.33727-8-steven.price@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191018101248.33727-8-steven.price@arm.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> +	return pud_present(pud)
> +		&& (pud_val(pud) & (_PAGE_READ | _PAGE_WRITE | _PAGE_EXEC));
> +}

The operators always need to go before the line break, not after it
per linux coding style.  There are a few more spots like this, so please
audit the whole series for it.

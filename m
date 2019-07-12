Return-Path: <SRS0=V+Ds=VJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C9A96C742D2
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Jul 2019 21:11:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9A325217D4
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Jul 2019 21:11:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1562965862;
	bh=+PDIywT7eFvyZf95nvjtVQCdwtDY3k2q5PrEskDIDbY=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=Tyx0wQ2cAp/r2nHfxOSOXmS/hoSEk4TR1Kf/uTl5XqlRYrmkH+97YXysJU2o2Sro9
	 Pyn/IXfIOX78zxVFmVv6H8/bycpKKOjG9h44BEvRNW7KtdWEqk1Wxm0LIQXwqKLjSw
	 i3BS7bkZSAXri+4gbweLcrh2Ruq5sy5aTaafrBZE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728049AbfGLVLB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 12 Jul 2019 17:11:01 -0400
Received: from mail.kernel.org ([198.145.29.99]:54174 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726811AbfGLVLA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Jul 2019 17:11:00 -0400
Received: from akpm3.svl.corp.google.com (unknown [104.133.8.64])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C830D2146E;
        Fri, 12 Jul 2019 21:10:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1562965859;
        bh=+PDIywT7eFvyZf95nvjtVQCdwtDY3k2q5PrEskDIDbY=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=qCUkHkGeIMzy206xZZpgubP0yJCOFFKUt2Q3JXjAp8FEPO18W82BQHRrFGarkBbw0
         yWXFtS6sPBuwWWCSqoRV1k0ZXgSO6hZVoQIfihSyliLFUErxUzXvbFfeEE9TFMdXFK
         gMXmDS2CCyphjnVVANTsPwmvdw/HYUXZHyaSv+EY=
Date:   Fri, 12 Jul 2019 14:10:58 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Qian Cai <cai@lca.pw>
Cc:     linux-kernel@vger.kernel.org, anshuman.khandual@arm.com,
        anton.ivanov@cambridgegreys.com, aou@eecs.berkeley.edu,
        arnd@arndb.de, catalin.marinas@arm.com, deanbo422@gmail.com,
        deller@gmx.de, geert@linux-m68k.org, green.hu@gmail.com,
        guoren@kernel.org, gxt@pku.edu.cn, lftan@altera.com,
        linux@armlinux.org.uk, mattst88@gmail.com, mhocko@suse.com,
        mm-commits@vger.kernel.org, mpe@ellerman.id.au, palmer@sifive.com,
        paul.burton@mips.com, ralf@linux-mips.org, ren_guo@c-sky.com,
        richard@nod.at, rkuo@codeaurora.org, rppt@linux.ibm.com,
        sammy@sammy.net, torvalds@linux-foundation.org, willy@infradead.org
Subject: Re: [patch 105/147] arm64: switch to generic version of pte
 allocation
Message-Id: <20190712141058.d8fd55c910dbdf6044fab2c4@linux-foundation.org>
In-Reply-To: <1562935747.8510.26.camel@lca.pw>
References: <20190712035802.eeH5anzpz%akpm@linux-foundation.org>
        <1562935747.8510.26.camel@lca.pw>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 12 Jul 2019 08:49:07 -0400 Qian Cai <cai@lca.pw> wrote:

> Actually, this patch is slightly off. There is one delta need to apply (ignore
> the part in pgtable.h which has already in mainline via the commit 615c48ad8f42
> "arm64/mm: don't initialize pgd_cache twice") in.
> 
> https://lore.kernel.org/linux-mm/20190617151252.GF16810@rapoport-lnx/

That's already merged - it went in via the arm64 tree I think.

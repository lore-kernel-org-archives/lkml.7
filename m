Return-Path: <SRS0=w7sF=2K=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C468CC43603
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Dec 2019 15:55:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 834A821D7E
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Dec 2019 15:55:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=shipmail.org header.i=@shipmail.org header.b="TjvMiIej"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727411AbfLTPy7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 20 Dec 2019 10:54:59 -0500
Received: from pio-pvt-msa2.bahnhof.se ([79.136.2.41]:51836 "EHLO
        pio-pvt-msa2.bahnhof.se" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727233AbfLTPy7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Dec 2019 10:54:59 -0500
Received: from localhost (localhost [127.0.0.1])
        by pio-pvt-msa2.bahnhof.se (Postfix) with ESMTP id 7EAFB3F76A;
        Fri, 20 Dec 2019 16:54:56 +0100 (CET)
Authentication-Results: pio-pvt-msa2.bahnhof.se;
        dkim=pass (1024-bit key; unprotected) header.d=shipmail.org header.i=@shipmail.org header.b=TjvMiIej;
        dkim-atps=neutral
X-Virus-Scanned: Debian amavisd-new at bahnhof.se
Received: from pio-pvt-msa2.bahnhof.se ([127.0.0.1])
        by localhost (pio-pvt-msa2.bahnhof.se [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id yDT3YremuHvA; Fri, 20 Dec 2019 16:54:55 +0100 (CET)
Received: from mail1.shipmail.org (h-205-35.A357.priv.bahnhof.se [155.4.205.35])
        (Authenticated sender: mb878879)
        by pio-pvt-msa2.bahnhof.se (Postfix) with ESMTPA id A757C3F5D4;
        Fri, 20 Dec 2019 16:54:54 +0100 (CET)
Received: from localhost.localdomain (h-205-35.A357.priv.bahnhof.se [155.4.205.35])
        by mail1.shipmail.org (Postfix) with ESMTPSA id E7330362158;
        Fri, 20 Dec 2019 16:54:53 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=shipmail.org; s=mail;
        t=1576857293; bh=dh0iOkelcGLbAowahmsupk/G5uFo11djWIGikieW09g=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=TjvMiIej3WKfCTNKKBket9vK9kUw2WaxcPusZmwdhhpQq8vKoRj8/rrlyfjWESb7V
         +plX6u+EcOriAPTTNoaq/rGIiB5SvExgu6fC3FBPysf9h4HRTiLDXYDVBV4BiPVu+L
         goF34lR6seDAv3zNoQW/U+W+TIKKz101D+VWmcXE=
Subject: Re: [PATCH] mm/hmm: Cleanup hmm_vma_walk_pud()/walk_pud_range()
To:     Steven Price <steven.price@arm.com>,
        =?UTF-8?B?SsOpcsO0bWUgR2xpc3Nl?= <jglisse@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org
References: <20191220153826.24229-1-steven.price@arm.com>
From:   =?UTF-8?Q?Thomas_Hellstr=c3=b6m_=28VMware=29?= 
        <thomas_os@shipmail.org>
Organization: VMware Inc.
Message-ID: <0d648083-2664-f99c-f1d7-4655e66b3a5b@shipmail.org>
Date:   Fri, 20 Dec 2019 16:54:52 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20191220153826.24229-1-steven.price@arm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/20/19 4:38 PM, Steven Price wrote:
> There are a number of minor misuses of the page table APIs in
> hmm_vma_walk_pud():
>
> If the pud_trans_huge_lock() hasn't been obtained it might be because
> the PUD is unstable, so we should retry.
>
> If it has been obtained then there's no need for a READ_ONCE, and the
> PUD cannot be pud_none() or !pud_present() so these paths are dead code.
>
> Finally in walk_pud_range(), after a call to split_huge_pud() the code
> should check pud_trans_unstable() rather than pud_none() to decide
> whether the PUD should be retried.
>
> Suggested-by: Thomas Hellström (VMware) <thomas_os@shipmail.org>
> Signed-off-by: Steven Price <steven.price@arm.com>
> ---
> This is based on top of my "Generic page walk and ptdump" series and
> fixes some pre-existing bugs spotted by Thomas.
>
>   mm/hmm.c      | 16 +++++-----------
>   mm/pagewalk.c |  2 +-
>   2 files changed, 6 insertions(+), 12 deletions(-)

LGTM.

Reviewed-by: Thomas Hellstrom <thellstrom@vmware.com>



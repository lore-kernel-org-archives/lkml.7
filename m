Return-Path: <SRS0=19dG=ZH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 58E6DC432C3
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Nov 2019 19:58:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2023C2073A
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Nov 2019 19:58:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1573847883;
	bh=9eEUACUiUScydrh4MXxVRPBLnMoSekdOCE+FsJAkc3E=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=HoymvnXke16TBseDma4uzLkxxS82PI1FUEco9xTgZ1RjyNrl/HATZKdki5JTvYrsM
	 dI3r0Y4TxiCYDbMPlT4x2ro5GMHtWMensAd6pY9sVeZnRfG5wmSvBkanaZLrSqsHNg
	 9vSsn7ejfx8Nn4h38sDbbVMUmna6D6Sl5q+bsg8A=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727053AbfKOT6C (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 Nov 2019 14:58:02 -0500
Received: from mail.kernel.org ([198.145.29.99]:46776 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726466AbfKOT6B (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Nov 2019 14:58:01 -0500
Received: from localhost.localdomain (c-73-231-172-41.hsd1.ca.comcast.net [73.231.172.41])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1847720733;
        Fri, 15 Nov 2019 19:58:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1573847881;
        bh=9eEUACUiUScydrh4MXxVRPBLnMoSekdOCE+FsJAkc3E=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=tH4LTUuA0frt+nTxwAqJnW7b7yALaBBF/joGatE/G6dCMM7ljKX4XluD4UjyZhNaz
         HVoVEu40i27bJ3534wFVLL7qHyYVMF2kFXZSAPA5EvudNcvw08l555KbwKICfXWP8V
         JroVYAegFpyC3WQq23xul25MMLVR3/ZZHHs9YRhU=
Date:   Fri, 15 Nov 2019 11:58:00 -0800
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Thomas =?ISO-8859-1?Q?Hellstr=F6m?= (VMware) 
        <thomas_os@shipmail.org>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        Thomas Hellstrom <thellstrom@vmware.com>,
        Arnd Bergmann <arnd@arndb.de>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Matthew Wilcox <willy@infradead.org>
Subject: Re: [PATCH 2/2] mm: Fix a huge pud insertion race during faulting
Message-Id: <20191115115800.45c053abcdb550d70b9baec9@linux-foundation.org>
In-Reply-To: <20191115115808.21181-2-thomas_os@shipmail.org>
References: <20191115115808.21181-1-thomas_os@shipmail.org>
        <20191115115808.21181-2-thomas_os@shipmail.org>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 15 Nov 2019 12:58:08 +0100 Thomas Hellstr=F6m (VMware) <thomas_os@s=
hipmail.org> wrote:

> A huge pud page can theoretically be faulted in racing with pmd_alloc()
> in __handle_mm_fault(). That will lead to pmd_alloc() returning an
> invalid pmd pointer. Fix this by adding a pud_trans_unstable() function
> similar to pmd_trans_unstable() and check whether the pud is really stable
> before using the pmd pointer.
>=20
> Race:
> Thread 1:             Thread 2:                 Comment
> create_huge_pud()                               Fallback - not taken.
> 		      create_huge_pud()         Taken.
> pmd_alloc()                                     Returns an invalid pointe=
r.

What are the user-visible runtime effects of this change?

Is a -stable backport warranted?

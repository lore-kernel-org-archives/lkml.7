Return-Path: <SRS0=TxL2=YH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 01F71C4CECE
	for <linux-kernel@archiver.kernel.org>; Mon, 14 Oct 2019 22:44:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C5A8221882
	for <linux-kernel@archiver.kernel.org>; Mon, 14 Oct 2019 22:44:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1571093066;
	bh=bR1w6UoSnX74UluDNWX1wTa+jYiev1lVKk27mIadYqc=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=NUDHKs6N89YMnaOuX64BharqpOgiG4oX1yaXtBUzs0/nQZgxvpy1HTtR764g29KlF
	 ox81/lRJh3zT/SLR2eSkNNx0s4xEUnVxuQ0PT5BRNwkHV5Hlrkn3ZJ74rDjMzx/APH
	 8Y6jpVSco25hbZITgpz5+P4LYl+2s765GRJIiJMU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726180AbfJNWoZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 14 Oct 2019 18:44:25 -0400
Received: from mail.kernel.org ([198.145.29.99]:46866 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726095AbfJNWoZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Oct 2019 18:44:25 -0400
Received: from akpm3.svl.corp.google.com (unknown [104.133.8.65])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 74E6F21835;
        Mon, 14 Oct 2019 22:44:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1571093064;
        bh=bR1w6UoSnX74UluDNWX1wTa+jYiev1lVKk27mIadYqc=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=VX64SZlgGVvm8FdahZlm6oDXPO4gIeEsrTnQbPR3Va+ueoUcERwlEsVXpOMlAnrdy
         a9qqXuO57/DkfQ3i24e7ANndxhlSTJQfn+0uTQD2YJnB07dpkZUaj401Z9AWJdNQyN
         CmskUWlecnXShZvGIg08xYVXTDI9siwDaYwyu5dc=
Date:   Mon, 14 Oct 2019 15:44:23 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Mike Rapoport <rppt@kernel.org>
Cc:     Adam Ford <aford173@gmail.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Christoph Hellwig <hch@lst.de>,
        Fabio Estevam <festevam@gmail.com>,
        Lucas Stach <l.stach@pengutronix.de>,
        etnaviv@lists.freedesktop.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, Mike Rapoport <rppt@linux.ibm.com>
Subject: Re: [PATCH] mm: memblock: do not enforce current limit for
 memblock_phys* family
Message-Id: <20191014154423.a472315834ce6a730ccbaf3f@linux-foundation.org>
In-Reply-To: <1570915861-17633-1-git-send-email-rppt@kernel.org>
References: <1570915861-17633-1-git-send-email-rppt@kernel.org>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 13 Oct 2019 00:31:01 +0300 Mike Rapoport <rppt@kernel.org> wrote:

> Until commit 92d12f9544b7 ("memblock: refactor internal allocation
> functions") the maximal address for memblock allocations was forced to
> memblock.current_limit only for the allocation functions returning virtual
> address. The changes introduced by that commit moved the limit enforcement
> into the allocation core and as a result the allocation functions returning
> physical address also started to limit allocations to
> memblock.current_limit.
> 
> This caused breakage of etnaviv GPU driver:
> 
> ...
>

So I'll add a cc:stable, yes?

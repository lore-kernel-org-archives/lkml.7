Return-Path: <SRS0=FHjv=VA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E5274C0650E
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Jul 2019 09:17:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BF76A218A3
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Jul 2019 09:17:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1562145439;
	bh=Hg5W6VICCo9BzbpQFSwcqmSxDvvrpRJduyurYjvoOVo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=D21ZJ7ArNChqN5GKvnE6zRIkvgQ0ehIc5gfs1QoOwdQNYfKdLBNvJk2HSL8Uq3ww8
	 VFgdESoehV6ifZw68YOFJj1AvN1skIeKAJ9w599HuKZEVFx7VQxsxFJYWgLBtgVWFq
	 hYyMDxjOwU0jPPkD1CpDTTPcCiD+WXBcUIaEJsKc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727355AbfGCJRS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Jul 2019 05:17:18 -0400
Received: from mail.kernel.org ([198.145.29.99]:54844 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727045AbfGCJRS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Jul 2019 05:17:18 -0400
Received: from willie-the-truck (236.31.169.217.in-addr.arpa [217.169.31.236])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3E6622189E;
        Wed,  3 Jul 2019 09:17:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1562145437;
        bh=Hg5W6VICCo9BzbpQFSwcqmSxDvvrpRJduyurYjvoOVo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=TfPa+hxXf06h9Xj4zZdAlr5/jj8yCzIiwNgYP9YLngnSKp7sU/Jx0YpS/FrgeV3Pe
         biCdpMGidC7UJF9ifDZcVprwG9+LqhV3djhFOQ4V/AMKIXJJISCVYSK0PIbT6QApU2
         QDrUnI6YPMpepSQrZx4zlTImxdFHzqxxrueayOeA=
Date:   Wed, 3 Jul 2019 10:17:13 +0100
From:   Will Deacon <will@kernel.org>
To:     Nathan Huckleberry <nhuck@google.com>
Cc:     catalin.marinas@arm.com, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, clang-built-linux@googlegroups.com
Subject: Re: [PATCH v2] arm64: mm: Fix dead assignment of old_pte
Message-ID: <20190703091712.h6l6yba7ciuv4tin@willie-the-truck>
References: <CAJkfWY4yvVVmJoQ0WwyoFBkWYsUJnnQPNU+-g23-m-L3ETe_hQ@mail.gmail.com>
 <20190702234135.78780-1-nhuck@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190702234135.78780-1-nhuck@google.com>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 02, 2019 at 04:41:35PM -0700, Nathan Huckleberry wrote:
> When analyzed with the clang static analyzer the
> following warning occurs
> 
> line 251, column 2
> Value stored to 'old_pte' is never read
> 
> This warning is repeated every time pgtable.h is
> included by another file and produces ~3500
> extra warnings.

Does this warning actually trigger with linux-next?

Will

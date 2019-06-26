Return-Path: <SRS0=hRvo=UZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 12E01C48BD6
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Jun 2019 12:21:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DDD9E2133F
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Jun 2019 12:21:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1561551703;
	bh=bzzuAsJFpALlF09800RIXkmFifwZs/0LsYp0Xdjf7lA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=tKKEzGi/kXI4GzTe7tp8M0wvPszsHRZz9mKrh2XXVORwrqZk51OAscAgg4h/fPHmm
	 KSzBzh9I0Ii6FD95w/MN7nu2K+4Csb9DKOw6x9APfqhpN5g4UgRih6eiWX2TGVtpfF
	 xBp78wCS9ey2u/Q1hy9oxQLID2K8R6J0ZmHyZviQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727409AbfFZMVm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Jun 2019 08:21:42 -0400
Received: from mail.kernel.org ([198.145.29.99]:57478 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726104AbfFZMVm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Jun 2019 08:21:42 -0400
Received: from willie-the-truck (236.31.169.217.in-addr.arpa [217.169.31.236])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 54F0E20663;
        Wed, 26 Jun 2019 12:21:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1561551701;
        bh=bzzuAsJFpALlF09800RIXkmFifwZs/0LsYp0Xdjf7lA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=QG5wNuPmjrSNBSjDiSSCgTZlz/8TXSmjSfBQaTeh2HpKuAucc31EfN0oweUcEWWTz
         UaVUE0sG5oMoB6F/Q9kYiwXqsgOhR5khCwluVydKxhPDnfDZ8gt0iSrFYKL9djGBt9
         HPnxRmX9CVEVhrUeI27SI6mVupT9IPj5JYfKqL2E=
Date:   Wed, 26 Jun 2019 13:21:35 +0100
From:   Will Deacon <will@kernel.org>
To:     jinho lim <jordan.lim@samsung.com>, catalin.marinas@arm.com
Cc:     will.deacon@arm.com, mark.rutland@arm.com,
        anshuman.khandual@arm.com, marc.zyngier@arm.com,
        andreyknvl@google.com, linux-kernel@vger.kernel.org,
        seroto7@gmail.com, ebiederm@xmission.com,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v3] arm64: rename dump_instr as dump_kernel_instr
Message-ID: <20190626122134.fg7s6di5o3d3gim4@willie-the-truck>
References: <CGME20190626115016epcas1p455530417de86ea2e72ce1b389ae57a75@epcas1p4.samsung.com>
 <20190626115013.13044-1-jordan.lim@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190626115013.13044-1-jordan.lim@samsung.com>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 26, 2019 at 08:50:13PM +0900, jinho lim wrote:
> In traps.c, only __die calls dump_instr.
> However, this function has sub-function as __dump_instr.
> 
> dump_kernel_instr can replace those functions.
> By using aarch64_insn_read, it does not have to change fs to KERNEL_DS.
> 
> Signed-off-by: jinho lim <jordan.lim@samsung.com>
> ---
>  arch/arm64/kernel/traps.c | 23 +++++++----------------
>  1 file changed, 7 insertions(+), 16 deletions(-)

Thanks, this looks good to me now:

Acked-by: Will Deacon <will.deacon@arm.com>

Catalin can pick this up for 5.3.

Will

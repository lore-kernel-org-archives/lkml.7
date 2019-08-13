Return-Path: <SRS0=Ecng=WJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E6C6DC32750
	for <linux-kernel@archiver.kernel.org>; Tue, 13 Aug 2019 08:24:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BBEAC20679
	for <linux-kernel@archiver.kernel.org>; Tue, 13 Aug 2019 08:24:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1565684669;
	bh=Rz+v3dkBfs3QN68t0zxLnFK2Q8XWGYQrgM1IhEDbkD4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=yhj70SX5arAZy5ts1uq9hi1gNG3rGXoE2foFEaf5CL0/yJgXo6PeTYbpsxuHdyIP+
	 rjN3QaJ7P7gpe7r8p31Ke11p1gndK8BJOtMthkLKn7tAzC7YN6C7dAcAm2CkICXRFe
	 t6A14Oj3sOhRqJUtSqHtHNpa5DrEhGuivXseDNCg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728041AbfHMIY3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 13 Aug 2019 04:24:29 -0400
Received: from mail.kernel.org ([198.145.29.99]:45660 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727166AbfHMIY2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Aug 2019 04:24:28 -0400
Received: from willie-the-truck (236.31.169.217.in-addr.arpa [217.169.31.236])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 427AB20663;
        Tue, 13 Aug 2019 08:24:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1565684667;
        bh=Rz+v3dkBfs3QN68t0zxLnFK2Q8XWGYQrgM1IhEDbkD4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=fRRSt2XOeK52+/CQl/KBGdbbiwjT89hcNEti95svIwNmYHskbJKcXkc2I8CPK2P9C
         9tJLWBJTLIK0FRG5YQ+0y9iMKjN6MzqLYUZSx+zcLOxQYwcNozEKPeffNOR6hRib7X
         UntY9jHYNSeahSoizepsqZYapYT9UZtp1DU/0dRo=
Date:   Tue, 13 Aug 2019 09:24:23 +0100
From:   Will Deacon <will@kernel.org>
To:     Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul@pwsan.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Jeremy Linton <jeremy.linton@arm.com>,
        Atish Patra <atish.patra@wdc.com>
Subject: Re: linux-next: manual merge of the risc-v tree with the arm64 tree
Message-ID: <20190813082422.lecgqtknnn5g4dyj@willie-the-truck>
References: <20190813093447.747a5853@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190813093447.747a5853@canb.auug.org.au>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 13, 2019 at 09:34:47AM +1000, Stephen Rothwell wrote:
> Hi all,
> 
> Today's linux-next merge of the risc-v tree got a conflict in:
> 
>   arch/arm64/kernel/topology.c
> 
> between commit:
> 
>   98dc19902a0b ("arm64: topology: Use PPTT to determine if PE is a thread")
> 
> from the arm64 tree and commit:
> 
>   60c1b220d8bc ("cpu-topology: Move cpu topology code to common code.")
> 
> from the risc-v tree.
> 
> I fixed it up (see below) and can carry the fix as necessary. This
> is now fixed as far as linux-next is concerned, but any non trivial
> conflicts should be mentioned to your upstream maintainer when your tree
> is submitted for merging.  You may also want to consider cooperating
> with the maintainer of the conflicting tree to minimise any particularly
> complex conflicts.

Thanks, Stephen.

Paul, Palmer -- If it's not too late, then it would probably be best to
stick this commit (60c1b220d8bc) and any dependencies on their own stable
branch so that we can both pull it into our respective trees and I can
resolve this conflict in the arm64 tree, which I'll send early during the
merge window.

Looking at your tree, I guess I could just pull in
common/for-v5.4-rc1/cpu-topology if you promise never to rebase it. Failing
that, you could fork a new branch from 60c1b220d8bc and I could just pull
that part instead.

Please let me know.

Will

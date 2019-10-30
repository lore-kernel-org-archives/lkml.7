Return-Path: <SRS0=iR9I=YX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4BFA9CA9EAF
	for <linux-kernel@archiver.kernel.org>; Wed, 30 Oct 2019 09:20:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 27003205ED
	for <linux-kernel@archiver.kernel.org>; Wed, 30 Oct 2019 09:20:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726488AbfJ3JUS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 30 Oct 2019 05:20:18 -0400
Received: from mx2.suse.de ([195.135.220.15]:49894 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726028AbfJ3JUR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Oct 2019 05:20:17 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 3A11EB263;
        Wed, 30 Oct 2019 09:20:16 +0000 (UTC)
Date:   Wed, 30 Oct 2019 10:20:14 +0100
From:   Joerg Roedel <jroedel@suse.de>
To:     Denys Vlasenko <dvlasenk@redhat.com>
Cc:     Tom Lendacky <thomas.lendacky@amd.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] iommu/amd: Do not re-fetch iommu->cmd_buf_tail
Message-ID: <20191030092014.GO838@suse.de>
References: <20191024125410.19224-1-dvlasenk@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191024125410.19224-1-dvlasenk@redhat.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 24, 2019 at 02:54:10PM +0200, Denys Vlasenko wrote:
> The compiler is not smart enough to realize that iommu->cmd_buf_tail
> can't be modified across memcpy:
> 
> 41 8b 45 74          mov    0x74(%r13),%eax   # iommu->cmd_buf_tail
> 44 8d 78 10          lea    0x10(%rax),%r15d  # += sizeof(*cmd)
> 41 81 e7 ff 1f 00 00 and    $0x1fff,%r15d     # %= CMD_BUFFER_SIZE
> 49 03 45 68          add    0x68(%r13),%rax   # target = iommu->cmd_buf + iommu->cmd_buf_tail
> 45 89 7d 74          mov    %r15d,0x74(%r13)  # store to iommu->cmd_buf_tail
> 49 8b 34 24          mov    (%r12),%rsi       # memcpy
> 49 8b 7c 24 08       mov    0x8(%r12),%rdi    # memcpy
> 48 89 30             mov    %rsi,(%rax)       # memcpy
> 48 89 78 08          mov    %rdi,0x8(%rax)    # memcpy
> 49 8b 55 38          mov    0x38(%r13),%rdx   # iommu->mmio_base
> 41 8b 45 74          mov    0x74(%r13),%eax   # redundant load of iommu->cmd_buf_tail
> ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
> 89 82 08 20 00 00    mov    %eax,0x2008(%rdx) # writel
> 
> CC: Tom Lendacky <thomas.lendacky@amd.com>
> CC: Joerg Roedel <jroedel@suse.de>
> CC: linux-kernel@vger.kernel.org
> Signed-off-by: Denys Vlasenko <dvlasenk@redhat.com>
> ---
>  drivers/iommu/amd_iommu.c | 13 +++++++------
>  1 file changed, 7 insertions(+), 6 deletions(-)

Applied, thanks.


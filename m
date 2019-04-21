Return-Path: <SRS0=ebdT=SX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EDF87C10F14
	for <linux-kernel@archiver.kernel.org>; Sun, 21 Apr 2019 14:19:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C16032086A
	for <linux-kernel@archiver.kernel.org>; Sun, 21 Apr 2019 14:19:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727829AbfDUOTA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 21 Apr 2019 10:19:00 -0400
Received: from bilbo.ozlabs.org ([203.11.71.1]:51893 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727764AbfDUOS7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 21 Apr 2019 10:18:59 -0400
Received: by ozlabs.org (Postfix, from userid 1034)
        id 44nBf84YyCz9sB3; Mon, 22 Apr 2019 00:18:56 +1000 (AEST)
X-powerpc-patch-notification: thanks
X-powerpc-patch-commit: cc76404feaed597bb4f5234d34d3f49e2d1139bf
X-Patchwork-Hint: ignore
In-Reply-To: <1553596191-78889-1-git-send-email-peng.hao2@zte.com.cn>
To:     Peng Hao <peng.hao2@zte.com.cn>, vitb@kernel.crashing.org,
        benh@kernel.crashing.org, paulus@samba.org, christophe.leroy@c-s.fr
From:   Michael Ellerman <patch-notifications@ellerman.id.au>
Cc:     linuxppc-dev@lists.ozlabs.org, Wen Yang <wen.yang99@zte.com.cn>,
        linux-kernel@vger.kernel.org
Subject: Re: [v3] powerpc/8xx: fix possible object reference leak
Message-Id: <44nBf84YyCz9sB3@ozlabs.org>
Date:   Mon, 22 Apr 2019 00:18:56 +1000 (AEST)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2019-03-26 at 10:29:51 UTC, Peng Hao wrote:
> From: Wen Yang <wen.yang99@zte.com.cn>
> 
> The call to of_find_compatible_node returns a node pointer with refcount
> incremented thus it must be explicitly decremented after the last
> usage.
> irq_domain_add_linear also calls of_node_get to increase refcount,
> so irq_domain will not be affected when it is released.
> 
> Detected by coccinelle with the following warnings:
> ./arch/powerpc/platforms/8xx/pic.c:158:1-7: ERROR: missing of_node_put; acquired a node pointer with refcount incremented on line 136, but without a corresponding object release within this function.
> 
> Fixes: a8db8cf0d894 ("irq_domain: Replace irq_alloc_host() with
> revmap-specific initializers")
> Signed-off-by: Wen Yang <wen.yang99@zte.com.cn>
> Suggested-by: Christophe Leroy <christophe.leroy@c-s.fr>
> Suggested-by: Michael Ellerman <mpe@ellerman.id.au>
> Reviewed-by: Peng Hao <peng.hao2@zte.com.cn>
> Reviewed-by: Christophe Leroy <christophe.leroy@c-s.fr>
> Cc: Vitaly Bordug <vitb@kernel.crashing.org>
> Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>
> Cc: Paul Mackerras <paulus@samba.org>
> Cc: Michael Ellerman <mpe@ellerman.id.au>
> Cc: linuxppc-dev@lists.ozlabs.org
> Cc: linux-kernel@vger.kernel.org

Applied to powerpc next, thanks.

https://git.kernel.org/powerpc/c/cc76404feaed597bb4f5234d34d3f49e

cheers

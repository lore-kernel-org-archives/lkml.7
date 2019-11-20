Return-Path: <SRS0=PPSE=ZM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F1AA8C432C0
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Nov 2019 00:41:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C606D22459
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Nov 2019 00:41:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="AhfuabiF"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727549AbfKTAlf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Nov 2019 19:41:35 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:54054 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727222AbfKTAlf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Nov 2019 19:41:35 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        Content-Type:In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:
        Subject:Sender:Reply-To:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=MI+FDKWd/af66kCsbPIfd7ZDkg9OijP7AcDslYamW4U=; b=AhfuabiFRf1SMbSZSSFkUSsfK
        xTkyTGl2wVVKJKb2MXDA253e7cL8yLOBk56TSAAWJwkFjAre+oFr6iw46uuFjba4yaR2J09YhTO//
        BF+1io+IgPec0BcScxRBiUNg8FAYuyumdsjcGZ0+oDAM3Nt1C+hhOZ3sQt9YFPyzm3pk9vu/+gIkC
        K0vV/AODAYt40uznqcF5PjsG14Gid7+yIpXMmV6gvVQfFV2ISTrD7nMkHJyWXVtoDBYKIwbjiVLra
        UEP2zhBT1m53F3b5fCdjw4sBlVx0MRR6abWerIbPgxFswFqmItAtV+OlK92au7EY5NFkVVeE0uduB
        SddfxIGwQ==;
Received: from [2603:3004:32:9a00::f45c]
        by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1iXE3p-0004T5-Fm; Wed, 20 Nov 2019 00:41:33 +0000
Subject: Re: [PATCH] arch/sh/: fix NUMA build errors
To:     Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Yoshinori Sato <ysato@users.sourceforge.jp>,
        Rich Felker <dalias@libc.org>,
        Linux-sh list <linux-sh@vger.kernel.org>
References: <20d33517-6df0-9104-fc0a-7f621f87192e@infradead.org>
 <CAMuHMdU0Vx1E9V+h8XYTyAJitPT42NdGvgzLAfG-=1BVZd-rbA@mail.gmail.com>
From:   Randy Dunlap <rdunlap@infradead.org>
Message-ID: <413c9aad-2123-b22a-56bc-faa5c7d38d06@infradead.org>
Date:   Tue, 19 Nov 2019 16:41:32 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.1
MIME-Version: 1.0
In-Reply-To: <CAMuHMdU0Vx1E9V+h8XYTyAJitPT42NdGvgzLAfG-=1BVZd-rbA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/18/19 11:38 PM, Geert Uytterhoeven wrote:
> Hi Randy,
> 
> 
> BTW, you didn't have the issue with CPU_SHX3 and CPU_SUBTYPE_SH7785?

Geert,

I don't see a defconfig with that combination.

Also, http://kisskb.ellerman.id.au/kisskb/branch/linus/head/af42d3466bdc8f39806b26f593604fdc54140bcb/
didn't report any such problem.  I only addressed the 3 build errors that were reported there as
  page_alloc.c:(.text+0x3148): undefined reference to `node_reclaim_distance'

I did just test sdk7786_defconfig successfully, but that's no surprise since it sets CONFIG_SMP.

-- 
~Randy

Return-Path: <SRS0=fSNO=YI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5EBA5C10F14
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Oct 2019 06:42:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2D7D421835
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Oct 2019 06:42:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1571121736;
	bh=rysVRgS2FyWINWo6N494AjxosS0+rfoIKEY8cnAlqSA=;
	h=Date:In-Reply-To:References:Subject:To:CC:From:List-ID:From;
	b=eREZuI7+gRp/l4Uhl5CjX1UHQyMsjhLFLfc0CFzR80dW4wdAzhdj+Hf+oyKOSKJB5
	 tJLL81NFYN1iY1taPcVfwFTchUBZtve8DuTB7nSVKv6q9mKcyilkWHKZOxQQN8MWL4
	 rvHsMlqWM1e66LNyZJNa2ho7j3lYCC3X9mCiPU0A=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727330AbfJOGmP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 15 Oct 2019 02:42:15 -0400
Received: from mail.kernel.org ([198.145.29.99]:58030 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726052AbfJOGmO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Oct 2019 02:42:14 -0400
Received: from [172.20.185.47] (unknown [151.9.251.10])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4E23320872;
        Tue, 15 Oct 2019 06:42:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1571121734;
        bh=rysVRgS2FyWINWo6N494AjxosS0+rfoIKEY8cnAlqSA=;
        h=Date:In-Reply-To:References:Subject:To:CC:From:From;
        b=WJ1RiJWg0ldBHseqfrvp5PmB2jl/7wc3M+Lc/btmiZF+qOzXjamufdias7ll/sXEJ
         QwS1noye5k0R7HoaydsDEqHqK5e/mvsfAeXgrBzGgtAaYQ5tDA/4/k6x302+mFvcxj
         QnD2Xs8HFk6dR3yYBKakkri/5m/87RAUPZ70FxNQ=
Date:   Tue, 15 Oct 2019 08:42:07 +0200
User-Agent: K-9 Mail for Android
In-Reply-To: <20191014154423.a472315834ce6a730ccbaf3f@linux-foundation.org>
References: <1570915861-17633-1-git-send-email-rppt@kernel.org> <20191014154423.a472315834ce6a730ccbaf3f@linux-foundation.org>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH] mm: memblock: do not enforce current limit for memblock_phys* family
To:     Andrew Morton <akpm@linux-foundation.org>
CC:     Adam Ford <aford173@gmail.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Christoph Hellwig <hch@lst.de>,
        Fabio Estevam <festevam@gmail.com>,
        Lucas Stach <l.stach@pengutronix.de>,
        etnaviv@lists.freedesktop.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, Mike Rapoport <rppt@linux.ibm.com>
From:   Mike Rapoport <rppt@kernel.org>
Message-ID: <43610D35-58EE-4019-B979-EAE3F4781EAA@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On October 15, 2019 12:44:23 AM GMT+02:00, Andrew Morton <akpm@linux-founda=
tion=2Eorg> wrote:
>On Sun, 13 Oct 2019 00:31:01 +0300 Mike Rapoport <rppt@kernel=2Eorg>
>wrote:
>
>> Until commit 92d12f9544b7 ("memblock: refactor internal allocation
>> functions") the maximal address for memblock allocations was forced
>to
>> memblock=2Ecurrent_limit only for the allocation functions returning
>virtual
>> address=2E The changes introduced by that commit moved the limit
>enforcement
>> into the allocation core and as a result the allocation functions
>returning
>> physical address also started to limit allocations to
>> memblock=2Ecurrent_limit=2E
>>=20
>> This caused breakage of etnaviv GPU driver:
>>=20
>> =2E=2E=2E
>>
>
>So I'll add a cc:stable, yes?

Yeah, right=2E Somehow I've missed that=2E=2E=2E

--=20
Sincerely yours,
Mike

Return-Path: <SRS0=PPSE=ZM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C8C04C432C0
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Nov 2019 10:38:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9E8A222429
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Nov 2019 10:38:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ellerman.id.au header.i=@ellerman.id.au header.b="rRRCPct7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728772AbfKTKiC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Nov 2019 05:38:02 -0500
Received: from bilbo.ozlabs.org ([203.11.71.1]:58827 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728616AbfKTKiC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Nov 2019 05:38:02 -0500
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 47Hzfp2kJlz9sPc;
        Wed, 20 Nov 2019 21:37:54 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ellerman.id.au;
        s=201909; t=1574246278;
        bh=3p1/+Y2XGImhWJp2Nfr1Vtn9hbxxW6xCuiO/qlCWHs8=;
        h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
        b=rRRCPct7qxNjUoAWjW+qjiY8Kr3Tw3xNCLARmyKqEVyL++OKOBFQIJamuKslc0nbo
         ZbfwIM3mtOBt0P5b1BPx1hd8ea3qB7nXXlIUjCBwq55BHhkEsiYXW0SXEUy1hSxZRG
         kzq9gZZOYdY5PQQpTmZVSW8UKRV/ENRAOwNibjCo7M4XgZrbk6oHYO1hCmftgt5el4
         hgIkt5tj1sDdv2h4MRNYO4VF0OR5fRbpkWD9HaxhR81lLDChjbUl4D3IQ+l2cbl5d/
         bwmb8hjNZt/PcpvEcjt0VG1nBWGFp8wr9tyiJiT0/YN4zp/7RinHLSE7+CkjcEIhlN
         fgIV931xHcIGw==
From:   Michael Ellerman <mpe@ellerman.id.au>
To:     Will Deacon <will@kernel.org>, linux-kernel@vger.kernel.org
Cc:     Will Deacon <will@kernel.org>, Yunjae Lee <lyj7694@gmail.com>,
        SeongJae Park <sj38.park@gmail.com>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Josh Triplett <josh@joshtriplett.org>,
        Matt Turner <mattst88@gmail.com>,
        Ivan Kokshaysky <ink@jurassic.park.msu.ru>,
        Richard Henderson <rth@twiddle.net>,
        Peter Zijlstra <peterz@infradead.org>,
        Alan Stern <stern@rowland.harvard.edu>,
        "Michael S. Tsirkin" <mst@redhat.com>,
        Jason Wang <jasowang@redhat.com>,
        Arnd Bergmann <arnd@arndb.de>, Joe Perches <joe@perches.com>,
        Boqun Feng <boqun.feng@gmail.com>, linux-alpha@vger.kernel.org,
        virtualization@lists.linux-foundation.org
Subject: Re: [PATCH 11/13] powerpc: Remove comment about read_barrier_depends()
In-Reply-To: <20191108170120.22331-12-will@kernel.org>
References: <20191108170120.22331-1-will@kernel.org> <20191108170120.22331-12-will@kernel.org>
Date:   Wed, 20 Nov 2019 21:37:52 +1100
Message-ID: <87imnebzpb.fsf@mpe.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Will Deacon <will@kernel.org> writes:
> 'read_barrier_depends()' doesn't exist anymore so stop talking about it.
>
> Signed-off-by: Will Deacon <will@kernel.org>
> ---
>  arch/powerpc/include/asm/barrier.h | 2 --
>  1 file changed, 2 deletions(-)
>
> diff --git a/arch/powerpc/include/asm/barrier.h b/arch/powerpc/include/asm/barrier.h
> index fbe8df433019..123adcefd40f 100644
> --- a/arch/powerpc/include/asm/barrier.h
> +++ b/arch/powerpc/include/asm/barrier.h
> @@ -18,8 +18,6 @@
>   * mb() prevents loads and stores being reordered across this point.
>   * rmb() prevents loads being reordered across this point.
>   * wmb() prevents stores being reordered across this point.
> - * read_barrier_depends() prevents data-dependent loads being reordered
> - *	across this point (nop on PPC).

Acked-by: Michael Ellerman <mpe@ellerman.id.au>

cheers

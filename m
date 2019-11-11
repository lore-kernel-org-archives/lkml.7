Return-Path: <SRS0=camR=ZD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5FE4EC43331
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Nov 2019 23:39:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 15A0421872
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Nov 2019 23:39:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ellerman.id.au header.i=@ellerman.id.au header.b="j6tITVSL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727402AbfKKXjC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Nov 2019 18:39:02 -0500
Received: from bilbo.ozlabs.org ([203.11.71.1]:42047 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726877AbfKKXjB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Nov 2019 18:39:01 -0500
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 47BnQC2p1gz9sPF;
        Tue, 12 Nov 2019 10:38:59 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ellerman.id.au;
        s=201909; t=1573515539;
        bh=of9FC9t2V9xW8CXha5HyP+jg6moyYbSVDlJkzkj4WLk=;
        h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
        b=j6tITVSL0NQ4whoYHE8PXvbulMlLctyUar+U0KznKjBWKYh6I/WylI3skpsEL+H7q
         L2IFGE7PsOPMQKFbc9sGPwe/+F44NSfXc0KxGiV7gJr7nTwQ9MKDA+bmANZhvgzQsO
         ntFwvCIUd2HVDlocywKQ9KaRwlmGBR2opmuT2EtRRlS4Z1Kh9uUolwJ+7ie0ZUABWD
         IQ5Q+SOu9qq9pCCCETSV2McT/Luz3gikYYVQrWbbvbcOw3ks2TlnDg/Kj9mwTee0s5
         bJMhgC8iLuUb22dUEoUmviyu/voPztQCKy2AXxWM0SJI5jLjJ8fVhLj/0975Gv2MNp
         DmPe9+4xaRSxg==
From:   Michael Ellerman <mpe@ellerman.id.au>
To:     Eric Dumazet <edumazet@google.com>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc:     linux-kernel <linux-kernel@vger.kernel.org>,
        "David S . Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Eric Dumazet <eric.dumazet@gmail.com>,
        kbuild test robot <lkp@intel.com>
Subject: Re: [PATCH] powerpc: add const qual to local_read() parameter
In-Reply-To: <20191108141353.193961-1-edumazet@google.com>
References: <20191108141353.193961-1-edumazet@google.com>
Date:   Tue, 12 Nov 2019 10:38:56 +1100
Message-ID: <87y2wm2dbj.fsf@mpe.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Eric Dumazet <edumazet@google.com> writes:
> A patch in net-next triggered a compile error on powerpc.

Would be nice to mention the compiler error, I haven't seen the report.

> This seems reasonable to relax powerpc local_read() requirements.

Seems fine.

Acked-by: Michael Ellerman <mpe@ellerman.id.au>

Dave can you please put this in net-next to limit the window of
breakage.

cheers

> Fixes: 316580b69d0a ("u64_stats: provide u64_stats_t type")
> Signed-off-by: Eric Dumazet <edumazet@google.com>
> Reported-by: kbuild test robot <lkp@intel.com>
> Cc:	Benjamin Herrenschmidt <benh@kernel.crashing.org>
> Cc:	Paul Mackerras <paulus@samba.org>
> Cc:	Michael Ellerman <mpe@ellerman.id.au>
> Cc:	linuxppc-dev@lists.ozlabs.org

Seems it didn't actually get cc'ed to linuxppc-dev for some reason.

> ---
>  arch/powerpc/include/asm/local.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/arch/powerpc/include/asm/local.h b/arch/powerpc/include/asm/local.h
> index fdd00939270bf08113b537a090d6a6e34a048361..bc4bd19b7fc235b80ec1132f44409b6fe1057975 100644
> --- a/arch/powerpc/include/asm/local.h
> +++ b/arch/powerpc/include/asm/local.h
> @@ -17,7 +17,7 @@ typedef struct
>  
>  #define LOCAL_INIT(i)	{ (i) }
>  
> -static __inline__ long local_read(local_t *l)
> +static __inline__ long local_read(const local_t *l)
>  {
>  	return READ_ONCE(l->v);
>  }
> -- 
> 2.24.0.432.g9d3f5f5b63-goog

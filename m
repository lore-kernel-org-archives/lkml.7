Return-Path: <SRS0=B1dt=RW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B2B51C43381
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Mar 2019 21:55:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 88F172146E
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Mar 2019 21:55:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727669AbfCSVzZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Mar 2019 17:55:25 -0400
Received: from albireo.enyo.de ([5.158.152.32]:36072 "EHLO albireo.enyo.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726768AbfCSVzY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Mar 2019 17:55:24 -0400
Received: from [172.17.203.2] (helo=deneb.enyo.de)
        by albireo.enyo.de with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        id 1h6Mhc-0005XW-T8; Tue, 19 Mar 2019 21:55:20 +0000
Received: from fw by deneb.enyo.de with local (Exim 4.92)
        (envelope-from <fw@deneb.enyo.de>)
        id 1h6Mhc-0005Wt-QC; Tue, 19 Mar 2019 22:55:20 +0100
From:   Florian Weimer <fw@deneb.enyo.de>
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     linux-api@vger.kernel.org, linux-arch@vger.kernel.org,
        netdev@vger.kernel.org, Laura Abbott <labbott@redhat.com>,
        Paul Burton <pburton@wavecomp.com>,
        Deepa Dinamani <deepa.kernel@gmail.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] uapi: avoid namespace conflict in linux/posix_types.h
References: <20190319165123.3967889-1-arnd@arndb.de>
Date:   Tue, 19 Mar 2019 22:55:20 +0100
In-Reply-To: <20190319165123.3967889-1-arnd@arndb.de> (Arnd Bergmann's message
        of "Tue, 19 Mar 2019 17:51:09 +0100")
Message-ID: <87bm26il6f.fsf@mid.deneb.enyo.de>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

* Arnd Bergmann:

> diff --git a/include/uapi/asm-generic/posix_types.h b/include/uapi/asm-generic/posix_types.h
> index f0733a26ebfc..2a8c68ac88ca 100644
> --- a/include/uapi/asm-generic/posix_types.h
> +++ b/include/uapi/asm-generic/posix_types.h
> @@ -77,7 +77,11 @@ typedef __kernel_long_t	__kernel_ptrdiff_t;
>  
>  #ifndef __kernel_fsid_t
>  typedef struct {
> +#ifdef __KERNEL__
>  	int	val[2];
> +#else
> +	int	__kernel_val[2];
> +#endif
>  } __kernel_fsid_t;
>  #endif
>  
> diff --git a/include/uapi/linux/posix_types.h b/include/uapi/linux/posix_types.h
> index 9a7a740b35a2..a5a5cfc38bbf 100644
> --- a/include/uapi/linux/posix_types.h
> +++ b/include/uapi/linux/posix_types.h
> @@ -23,7 +23,7 @@
>  #define __FD_SETSIZE	1024
>  
>  typedef struct {
> -	unsigned long fds_bits[__FD_SETSIZE / (8 * sizeof(long))];
> +	unsigned long __kernel_fds_bits[__FD_SETSIZE / (8 * sizeof(long))];
>  } __kernel_fd_set;
>  
>  /* Type of a signal handler.  */

Both changes look reasonably to me, but I have not tested them.

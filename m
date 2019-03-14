Return-Path: <SRS0=GgR0=RR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C1ECAC4360F
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Mar 2019 18:48:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A449E217F5
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Mar 2019 18:48:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727507AbfCNSr7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Mar 2019 14:47:59 -0400
Received: from albireo.enyo.de ([5.158.152.32]:45402 "EHLO albireo.enyo.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727034AbfCNSr6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Mar 2019 14:47:58 -0400
X-Greylist: delayed 389 seconds by postgrey-1.27 at vger.kernel.org; Thu, 14 Mar 2019 14:47:56 EDT
Received: from [172.17.203.2] (helo=deneb.enyo.de)
        by albireo.enyo.de with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        id 1h4VIA-0001U3-5A; Thu, 14 Mar 2019 18:41:22 +0000
Received: from fw by deneb.enyo.de with local (Exim 4.89)
        (envelope-from <fw@deneb.enyo.de>)
        id 1h4VEB-0006rP-Rh; Thu, 14 Mar 2019 19:37:15 +0100
From:   Florian Weimer <fw@deneb.enyo.de>
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     "David S . Miller" <davem@davemloft.net>,
        Deepa Dinamani <deepa.kernel@gmail.com>,
        Willem de Bruijn <willemb@google.com>,
        linux-alpha@vger.kernel.org, linux-arch@vger.kernel.org,
        linux-mips@vger.kernel.org, linux-parisc@vger.kernel.org,
        sparclinux@vger.kernel.org, Laura Abbott <labbott@redhat.com>,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-api@vger.kernel.org
Subject: Re: [PATCH] y2038: fix socket.h header inclusion
References: <20190311153857.563743-1-arnd@arndb.de>
Date:   Thu, 14 Mar 2019 19:37:15 +0100
In-Reply-To: <20190311153857.563743-1-arnd@arndb.de> (Arnd Bergmann's message
        of "Mon, 11 Mar 2019 16:38:17 +0100")
Message-ID: <87k1h1fgkk.fsf@mid.deneb.enyo.de>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

* Arnd Bergmann:

> diff --git a/arch/alpha/include/uapi/asm/socket.h b/arch/alpha/include/uapi/asm/socket.h
> index 0d0fddb7e738..976e89b116e5 100644
> --- a/arch/alpha/include/uapi/asm/socket.h
> +++ b/arch/alpha/include/uapi/asm/socket.h
> @@ -2,8 +2,8 @@
>  #ifndef _UAPI_ASM_SOCKET_H
>  #define _UAPI_ASM_SOCKET_H
>  
> +#include <linux/posix_types.h>
>  #include <asm/sockios.h>
> -#include <asm/bitsperlong.h>

This breaks POSIX conformance in glibc because the
<linux/posix_types.h> header is not namespace clean.  It contains the
identifiers fds_bits and val:

	unsigned long fds_bits[__FD_SETSIZE / (8 * sizeof(long))];

        int     val[2];

We could duplicate some of the SO_* constants for POSIX mode in glibc,
but it would be nice to avoid that.

Is there a different way of fixing this on the kernel side that avoids
including <linux/posix_types.h>?

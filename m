Return-Path: <SRS0=PPSE=ZM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BECB4C432C0
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Nov 2019 22:30:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8944A20872
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Nov 2019 22:30:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726905AbfKTWaW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Nov 2019 17:30:22 -0500
Received: from imap1.codethink.co.uk ([176.9.8.82]:37120 "EHLO
        imap1.codethink.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726080AbfKTWaW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Nov 2019 17:30:22 -0500
Received: from [167.98.27.226] (helo=xylophone)
        by imap1.codethink.co.uk with esmtpsa (Exim 4.84_2 #1 (Debian))
        id 1iXYUM-00061O-RV; Wed, 20 Nov 2019 22:30:18 +0000
Message-ID: <a5f530323b66cd8c0055c5e642ef4eb035c53808.camel@codethink.co.uk>
Subject: Re: [Y2038] [PATCH 02/23] y2038: add __kernel_old_timespec and
 __kernel_old_time_t
From:   Ben Hutchings <ben.hutchings@codethink.co.uk>
To:     Arnd Bergmann <arnd@arndb.de>, y2038@lists.linaro.org
Cc:     Deepa Dinamani <deepa.kernel@gmail.com>,
        linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org,
        "David S. Miller" <davem@davemloft.net>
Date:   Wed, 20 Nov 2019 22:30:18 +0000
In-Reply-To: <20191108210824.1534248-2-arnd@arndb.de>
References: <20191108210236.1296047-1-arnd@arndb.de>
         <20191108210824.1534248-2-arnd@arndb.de>
Organization: Codethink Ltd.
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.30.5-1.1 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2019-11-08 at 22:07 +0100, Arnd Bergmann wrote:
> The 'struct timespec' definition can no longer be part of the uapi headers
> because it conflicts with a a now incompatible libc definition. Also,
> we really want to remove it in order to prevent new uses from creeping in.
> 
> The same namespace conflict exists with time_t, which should also be
> removed. __kernel_time_t could be used safely, but adding 'old' in the
> name makes it clearer that this should not be used for new interfaces.
> 
> Add a replacement __kernel_old_timespec structure and __kernel_old_time_t
> along the lines of __kernel_old_timeval.
[...]
> --- a/include/uapi/linux/time_types.h
> +++ b/include/uapi/linux/time_types.h
> @@ -28,6 +28,11 @@ struct __kernel_old_timeval {
>  };
>  #endif
>  
> +struct __kernel_old_timespec {
> +	__kernel_time_t	tv_sec;			/* seconds */

Should this be __kernel_old_time_t for consistency?

Ben.

> +	long		tv_nsec;		/* nanoseconds */
> +};
> +
>  struct __kernel_sock_timeval {
>  	__s64 tv_sec;
>  	__s64 tv_usec;
-- 
Ben Hutchings, Software Developer                         Codethink Ltd
https://www.codethink.co.uk/                 Dale House, 35 Dale Street
                                     Manchester, M1 2HF, United Kingdom


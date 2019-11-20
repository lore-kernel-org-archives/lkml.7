Return-Path: <SRS0=PPSE=ZM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8C57EC432C3
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Nov 2019 19:27:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6F0C62071F
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Nov 2019 19:27:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727733AbfKTT1d (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Nov 2019 14:27:33 -0500
Received: from imap1.codethink.co.uk ([176.9.8.82]:34242 "EHLO
        imap1.codethink.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727003AbfKTT1d (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Nov 2019 14:27:33 -0500
Received: from [167.98.27.226] (helo=xylophone)
        by imap1.codethink.co.uk with esmtpsa (Exim 4.84_2 #1 (Debian))
        id 1iXVdQ-0002RA-UC; Wed, 20 Nov 2019 19:27:29 +0000
Message-ID: <41baf20a190039443cb2b82aea0c2a8ec872cfed.camel@codethink.co.uk>
Subject: Re: [Y2038] [PATCH 6/8] lp: fix sparc64 LPSETTIMEOUT ioctl
From:   Ben Hutchings <ben.hutchings@codethink.co.uk>
To:     Arnd Bergmann <arnd@arndb.de>, y2038@lists.linaro.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     "Gustavo A. R. Silva" <gustavo@embeddedor.com>,
        linux-kernel@vger.kernel.org, stable@vger.kernel.org,
        Bamvor Jian Zhang <bamv2005@gmail.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Sudip Mukherjee <sudipm.mukherjee@gmail.com>
Date:   Wed, 20 Nov 2019 19:27:27 +0000
In-Reply-To: <20191108203435.112759-7-arnd@arndb.de>
References: <20191108203435.112759-1-arnd@arndb.de>
         <20191108203435.112759-7-arnd@arndb.de>
Organization: Codethink Ltd.
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.30.5-1.1 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2019-11-08 at 21:34 +0100, Arnd Bergmann wrote:
> The layout of struct timeval is different on sparc64 from
> anything else, and the patch I did long ago failed to take
> this into account.
> 
> Change it now to handle sparc64 user space correctly again.
> 
> Quite likely nobody cares about parallel ports on sparc64,
> but there is no reason not to fix it.
> 
> Cc: stable@vger.kernel.org
> Fixes: 9a450484089d ("lp: support 64-bit time_t user space")
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> ---
>  drivers/char/lp.c | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/drivers/char/lp.c b/drivers/char/lp.c
> index 7c9269e3477a..bd95aba1f9fe 100644
> --- a/drivers/char/lp.c
> +++ b/drivers/char/lp.c
> @@ -713,6 +713,10 @@ static int lp_set_timeout64(unsigned int minor, void __user *arg)
>  	if (copy_from_user(karg, arg, sizeof(karg)))
>  		return -EFAULT;
>  
> +	/* sparc64 suseconds_t is 32-bit only */
> +	if (IS_ENABLED(CONFIG_SPARC64) && !in_compat_syscall())
> +		karg[1] >>= 32;
> +
>  	return lp_set_timeout(minor, karg[0], karg[1]);
>  }
>

It seems like it would make way more sense to use __kernel_old_timeval.
Then you don't have to explicitly handle the sparc64 oddity.

As it is, this still over-reads from user-space which might result in a
spurious -EFAULT.

Ben.

-- 
Ben Hutchings, Software Developer                         Codethink Ltd
https://www.codethink.co.uk/                 Dale House, 35 Dale Street
                                     Manchester, M1 2HF, United Kingdom


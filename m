Return-Path: <SRS0=PPSE=ZM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D0B63C43215
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Nov 2019 22:49:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A90A120708
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Nov 2019 22:49:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726666AbfKTWts (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Nov 2019 17:49:48 -0500
Received: from imap1.codethink.co.uk ([176.9.8.82]:37388 "EHLO
        imap1.codethink.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725820AbfKTWtr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Nov 2019 17:49:47 -0500
Received: from [167.98.27.226] (helo=xylophone)
        by imap1.codethink.co.uk with esmtpsa (Exim 4.84_2 #1 (Debian))
        id 1iXYmm-0006Lg-Um; Wed, 20 Nov 2019 22:49:21 +0000
Message-ID: <dd1a30609f05e800550097080c1d1b27065f91ff.camel@codethink.co.uk>
Subject: Re: [Y2038] [PATCH 08/23] y2038: ipc: remove __kernel_time_t
 reference from headers
From:   Ben Hutchings <ben.hutchings@codethink.co.uk>
To:     Arnd Bergmann <arnd@arndb.de>, y2038@lists.linaro.org,
        Ralf Baechle <ralf@linux-mips.org>,
        Paul Burton <paul.burton@mips.com>,
        James Hogan <jhogan@kernel.org>,
        "James E.J. Bottomley" <James.Bottomley@HansenPartnership.com>,
        Helge Deller <deller@gmx.de>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        "David S. Miller" <davem@davemloft.net>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        x86@kernel.org
Cc:     linux-arch@vger.kernel.org, linux-parisc@vger.kernel.org,
        linux-mips@vger.kernel.org, linux-kernel@vger.kernel.org,
        "H. Peter Anvin" <hpa@zytor.com>, sparclinux@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org
Date:   Wed, 20 Nov 2019 22:49:19 +0000
In-Reply-To: <20191108210824.1534248-8-arnd@arndb.de>
References: <20191108210236.1296047-1-arnd@arndb.de>
         <20191108210824.1534248-8-arnd@arndb.de>
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
[...]
> --- a/arch/x86/include/uapi/asm/sembuf.h
> +++ b/arch/x86/include/uapi/asm/sembuf.h
> @@ -21,9 +21,9 @@ struct semid64_ds {
>  	unsigned long	sem_ctime;	/* last change time */
>  	unsigned long	sem_ctime_high;
>  #else
> -	__kernel_time_t	sem_otime;	/* last semop time */
> +	long		sem_otime;	/* last semop time */
>  	__kernel_ulong_t __unused1;
> -	__kernel_time_t	sem_ctime;	/* last change time */
> +	long		sem_ctime;	/* last change time */
>  	__kernel_ulong_t __unused2;
>  #endif
>  	__kernel_ulong_t sem_nsems;	/* no. of semaphores in array */
[...]

We need to use __kernel_long_t here to do the right thing on x32.

Ben.

-- 
Ben Hutchings, Software Developer                         Codethink Ltd
https://www.codethink.co.uk/                 Dale House, 35 Dale Street
                                     Manchester, M1 2HF, United Kingdom


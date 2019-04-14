Return-Path: <SRS0=avfD=SQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CDA47C10F14
	for <linux-kernel@archiver.kernel.org>; Sun, 14 Apr 2019 20:31:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9DE492082E
	for <linux-kernel@archiver.kernel.org>; Sun, 14 Apr 2019 20:31:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="g2vXMoBW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727230AbfDNUbU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 14 Apr 2019 16:31:20 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:50805 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725797AbfDNUbU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 14 Apr 2019 16:31:20 -0400
Received: by mail-wm1-f66.google.com with SMTP id z11so17985273wmi.0;
        Sun, 14 Apr 2019 13:31:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:subject:to:cc:references:from:openpgp:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=OqDMtve4D/P5Q6oyq3tvHG3ctD+xyevYdt55M8kqXqQ=;
        b=g2vXMoBWe82jpe06NEoVEXg7oH3KjiKYwsVzsA0ETM25RbUX9b9cyWyOS39L9MR2t3
         SWzb1qJ/5RWHG4v1evM+w2cPQmpPRXU6HlCudLRNlBYUAKiuNAyyJUTihZO+sEptTik6
         z0uYzwA/6VaUFULRmJQAoh51Pg3PfKctqdhn1hETgOqmSoNrkuadDIxGu/8cbby9rTkf
         ethcxMTgh1cXTgFlO9xYgvXDA940HrapIxXKPpWHnd/cl3T1d7/6xYsVrZwePZKLU1d1
         sn1UOGXMTnc1rwCy99/MnGhtegN8Sq3cm6ObaDf5YtzULIMqTn38SSIuQSe9117Amggf
         m42g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:subject:to:cc:references:from:openpgp
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=OqDMtve4D/P5Q6oyq3tvHG3ctD+xyevYdt55M8kqXqQ=;
        b=gu65v3tov+yUZehj3bZuqSMzIFnGLowgELWO5aswvFXCMyzlAmfawhcU55AQVx5TAU
         Wt74dfV1Et2UWMyibwPeT5Y2xvZ1ENokL5lHGI9jPzVjqyMihn7OpgGnb1WZRoE+aezs
         im9duenghwrXTA5qH9rC9Yt1jeBye7PzbZ9c92BT9icwZpCjvvOuJWDw2UOsbi+NXMmQ
         yWP3YtV1pi/RclZJfcDEsg050KaxsD2/P0UmIJtNCIw9zUB+hX3fFGcL8DZOpGKjpJY9
         vS+hlkvTlKU8c1ferCbc2aTgjHdADd70lgVxtNvP7yMZ6au83UjhIlGPzwkS0DFAekk1
         BurQ==
X-Gm-Message-State: APjAAAXqokmZUuw6OAOhkRwqcHSe0SHppvl8Le2iD2/ubmwSsUfYp3I7
        I80vV8R3hHFWbRnF9x6pd1PD4Jhd
X-Google-Smtp-Source: APXvYqwzlCc2hzLIAGoXPhar2+5guo7ko+IS7HlBaInq1bL2cLzdGMUc8x9mNY3GfhJAqypvfgaR9A==
X-Received: by 2002:a1c:b189:: with SMTP id a131mr18626909wmf.107.1555273878201;
        Sun, 14 Apr 2019 13:31:18 -0700 (PDT)
Received: from [192.168.1.37] (193.red-88-21-103.staticip.rima-tde.net. [88.21.103.193])
        by smtp.gmail.com with ESMTPSA id d3sm32993987wmf.46.2019.04.14.13.31.16
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 14 Apr 2019 13:31:17 -0700 (PDT)
Subject: Re: [PATCH] MIPS: scall64-o32: Fix indirect syscall number load
To:     Aurelien Jarno <aurelien@aurel32.net>,
        Ralf Baechle <ralf@linux-mips.org>,
        Paul Burton <paul.burton@mips.com>,
        James Hogan <jhogan@kernel.org>
Cc:     linux-mips@vger.kernel.org, linux-kernel@vger.kernel.org,
        stable@vger.kernel.org
References: <20190409145355.25842-1-aurelien@aurel32.net>
From:   =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Openpgp: url=http://pgp.mit.edu/pks/lookup?op=get&search=0xE3E32C2CDEADC0DE
Message-ID: <1ebf2209-9fd7-4c1f-0d1f-ff23d5d5e300@amsat.org>
Date:   Sun, 14 Apr 2019 22:31:16 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190409145355.25842-1-aurelien@aurel32.net>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/9/19 4:53 PM, Aurelien Jarno wrote:
> Commit 4c21b8fd8f14 (MIPS: seccomp: Handle indirect system calls (o32))
> added indirect syscall detection for O32 processes running on MIPS64,
> but it did not work correctly for big endian kernel/processes. The
> reason is that the syscall number is loaded from ARG1 using the lw
> instruction while this is a 64-bit value, so zero is loaded instead of
> the syscall number.
> 
> Fix the code by using the ld instruction instead. When running a 32-bit
> processes on a 64 bit CPU, the values are properly sign-extended, so it
> ensures the value passed to syscall_trace_enter is correct.
> 
> Recent systemd versions with seccomp enabled whitelist the getpid
> syscall for their internal  processes (e.g. systemd-journald), but call
> it through syscall(SYS_getpid). This fix therefore allows O32 big endian
> systems with a 64-bit kernel to run recent systemd versions.
> 
> Signed-off-by: Aurelien Jarno <aurelien@aurel32.net>
> Cc: <stable@vger.kernel.org> # v3.15+
> ---
>  arch/mips/kernel/scall64-o32.S | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/mips/kernel/scall64-o32.S b/arch/mips/kernel/scall64-o32.S
> index f158c5894a9a..feb2653490df 100644
> --- a/arch/mips/kernel/scall64-o32.S
> +++ b/arch/mips/kernel/scall64-o32.S
> @@ -125,7 +125,7 @@ trace_a_syscall:
>  	subu	t1, v0,  __NR_O32_Linux
>  	move	a1, v0
>  	bnez	t1, 1f /* __NR_syscall at offset 0 */
> -	lw	a1, PT_R4(sp) /* Arg1 for __NR_syscall case */
> +	ld	a1, PT_R4(sp) /* Arg1 for __NR_syscall case */
>  	.set	pop
>  
>  1:	jal	syscall_trace_enter
> 
> 

Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>

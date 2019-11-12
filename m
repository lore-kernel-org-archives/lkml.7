Return-Path: <SRS0=WT+Y=ZE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 05113C43331
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Nov 2019 21:09:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B7E4920659
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Nov 2019 21:09:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fU7vwVcr"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726985AbfKLVJT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Nov 2019 16:09:19 -0500
Received: from mail-lj1-f195.google.com ([209.85.208.195]:35064 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726645AbfKLVJT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Nov 2019 16:09:19 -0500
Received: by mail-lj1-f195.google.com with SMTP id r7so52597ljg.2;
        Tue, 12 Nov 2019 13:09:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=JPZechq2eKF4wwi+8Qv9lfknYNyHmyO47xHG86HtDMs=;
        b=fU7vwVcrYm0D0uGcCtgj0ZXXNmSaBK8mJoOPiWQqqTejkcej/6TWQmT8eSkDCn4Jf/
         Pr2gGz0366EnVZSFzSalSEisx2UYQv2iLejrLZdy1/PmVkbxERC3U08mvKGfl9VnXNhD
         eG8dWD0PWDMQeFRVeCN43IAJViixazSac7nKrm6Fz0aYjflN8BCjXd5ENVGOk77tH5uw
         s3NkaypO210iBobuYM8NgwwjOPZiL7rOKlV8y5tKqjIUGChDU8CHOoS8IjSCasdyn/Az
         8r8Jf/O/RZu2evBDlSN/59MIt33XBDP+Hh1Kf9RP7DSKpnhoeCmsrxJjGsdlouvXvDlp
         rZxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=JPZechq2eKF4wwi+8Qv9lfknYNyHmyO47xHG86HtDMs=;
        b=WLUcuqz1o/05TlKnpeX9SqJp8IvhikGpgMrRpgTDSLOs6of3p4qa6Jm8wgeuvzl2zq
         ORjUuX0+hCOTYNiNs2IGGfn2jeSLezpXncBjULLT4or5FWTJ1d8oHolqG3erFvUNrpxn
         QPMx8NAsfOMuDmmZZEXoqsBdxchIPI1/jcK7UjYKY3tMKhtPcDISVjlPsX70SPxDqsqY
         QDdsunebGgO9tZaMAY2oAkv6vFqr6lW8BOqcEepsqMsvKM+KP9QfiqmikqNHmAKNpMdU
         w4TcksGZ1uLit0EiaJeZCO2WvNOhI7aaAeua0hZaWXuhW07NdmUfPvDIov2P23Fvi44E
         R7bg==
X-Gm-Message-State: APjAAAUJfhXPwjaGOzJj5lqzDIPWgpO5OkJTTqbLpWDTjHXH+vzo0Z9L
        5l37hEVFYrDnxb6qC5VIpPA=
X-Google-Smtp-Source: APXvYqyo8cgTa2EjqKxK1NhWe5i3Yoq8ReGunMfOjSn81p4+F4lqwfdn3S7sooJZvNF/Jg8C9ieggg==
X-Received: by 2002:a2e:9802:: with SMTP id a2mr21941492ljj.254.1573592957014;
        Tue, 12 Nov 2019 13:09:17 -0800 (PST)
Received: from uranus.localdomain ([5.18.102.224])
        by smtp.gmail.com with ESMTPSA id u5sm9400286ljg.68.2019.11.12.13.09.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Nov 2019 13:09:15 -0800 (PST)
Received: by uranus.localdomain (Postfix, from userid 1000)
        id 5B4884605D3; Wed, 13 Nov 2019 00:09:15 +0300 (MSK)
Date:   Wed, 13 Nov 2019 00:09:15 +0300
From:   Cyrill Gorcunov <gorcunov@gmail.com>
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     y2038@lists.linaro.org, Richard Henderson <rth@twiddle.net>,
        Ivan Kokshaysky <ink@jurassic.park.msu.ru>,
        Matt Turner <mattst88@gmail.com>, linux-kernel@vger.kernel.org,
        Deepa Dinamani <deepa.kernel@gmail.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Will Deacon <will@kernel.org>,
        Michal =?iso-8859-1?Q?Koutn=FD?= <mkoutny@suse.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        linux-alpha@vger.kernel.org
Subject: Re: [PATCH 11/23] y2038: rusage: use __kernel_old_timeval
Message-ID: <20191112210915.GD5130@uranus>
References: <20191108210236.1296047-1-arnd@arndb.de>
 <20191108211323.1806194-2-arnd@arndb.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191108211323.1806194-2-arnd@arndb.de>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 08, 2019 at 10:12:10PM +0100, Arnd Bergmann wrote:
> There are two 'struct timeval' fields in 'struct rusage'.
> 
> Unfortunately the definition of timeval is now ambiguous when used in
> user space with a libc that has a 64-bit time_t, and this also changes
> the 'rusage' definition in user space in a way that is incompatible with
> the system call interface.
> 
> While there is no good solution to avoid all ambiguity here, change
> the definition in the kernel headers to be compatible with the kernel
> ABI, using __kernel_old_timeval as an unambiguous base type.
> 
> In previous discussions, there was also a plan to add a replacement
> for rusage based on 64-bit timestamps and nanosecond resolution,
> i.e. 'struct __kernel_timespec'. I have patches for that as well,
> if anyone thinks we should do that.
> 
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> ---
> Question: should we also rename 'struct rusage' into 'struct __kernel_rusage'
> here, to make them completely unambiguous?

The patch looks ok to me. I must confess I looked into rusage long ago
so __kernel_timespec type used in uapi made me nervious at first,
but then i found that we've this type defined in time_types.h uapi
so userspace should be safe. I also like the idea of __kernel_rusage
but definitely on top of the series.

Reviewed-by: Cyrill Gorcunov <gorcunov@gmail.com>

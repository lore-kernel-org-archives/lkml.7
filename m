Return-Path: <SRS0=NWWL=SU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FSL_HELO_FAKE,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3AE07C10F0E
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Apr 2019 13:20:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 05C05217D7
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Apr 2019 13:20:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1555593654;
	bh=tB6W23DqVoY0ovjvn+gfIFqrcvOuFPUUX6EhZ2Swf2Y=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=PlUGmN4IUHTzfNo2RxTGOszuf8BtGD7Sjr9WX2Yuf8a5uEKyeGoM+iZ7Q9t9XdtUW
	 MdZ6n0V7RrEygq3vv3+kJ+EYS+hOKrxI5DouLbqSOPJ7QcIZi3tNGNmcIPZmz/HFVC
	 5tXnUwQ+EmchSA8rs+C/baG8ItSoBWc4fMuNoPCU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389011AbfDRNUx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Apr 2019 09:20:53 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:33744 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727807AbfDRNUw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Apr 2019 09:20:52 -0400
Received: by mail-wr1-f68.google.com with SMTP id k1so1780371wrw.0;
        Thu, 18 Apr 2019 06:20:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=XQCHoAAFT5Z9bDRSYOBbJEBinvShFFVBSkUMOBYi/Tc=;
        b=OBVI3mxBq7hJJ7GMq63UZAs5eDSNSQHVMQhmsRcAzOUlEvQybBl1shmYvk0PdKKK5/
         0AT3aJ9peUWu6DDE2+uo/dmc7PEUAwXzlwkLRi6iJQAHlOzIPupYPzVxLR6BgJ1aoE8/
         PaA7Uf6uU6WdoZEbRyIT6Bl8wnNCRk7UlthLWf1af5Bs/hdbglOXeyfrugNoRNZbu+ve
         K6oedra3Ss9p/ADCD3fv4vNKJ1x2sNjXk8UGfrCFuaZT7pQkl/USfphp6YQaSoQn1qZZ
         OJjlYQjkhJvXBlSdRxhmEm7YT/CUd/7rFK/KQcjGeGoFbZTeIJoWsQ6fLUy7H1fnUd8s
         b6mg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=XQCHoAAFT5Z9bDRSYOBbJEBinvShFFVBSkUMOBYi/Tc=;
        b=HyAedJ13BSndJyNGMfLKRQ35i4vThDLmzI3hShhbYtODM/y/VId9Kt9S22Y0acdgQ8
         n4ii6hTWqXEbmR5bLiMYB5V4ulQa9fGzkY4arMvxhAsb1xmZK/0mASRwxmZBoo+XEH9L
         Qhr8qOwzc/jg+w2Yxh3z8ysyUeKShRMcPFoBYBi+EVYmPUsmRwlN+tTJJPmYhkRcN4as
         DUX+Z9/7d1Ok51P7/I1foRT2T/dKWcnnSvhKFZMrgEr2gXeooYRh81X/hgDXv9CHpzfE
         aWCmxJp88yuOrrjzl4SqfyNKbWd5DgbCFJbXXlmRntbO2mzlJpMDUD/hm8tfWv0quQiZ
         3epA==
X-Gm-Message-State: APjAAAUBXnIn3sfLDDOVXwY6OkmT5h2hykRKX/nOhWUTWFcxRZEX1BrC
        P1qc0nUQiLwzTn9jrrndrEQ=
X-Google-Smtp-Source: APXvYqzJ/ySJ+z0VjPKhlTQyMQFU1iuU9BCAPDw4iU0TqindWFDaAlZ0lD4Q/VA3V2aWhbWS1mn+aA==
X-Received: by 2002:a05:6000:1111:: with SMTP id z17mr282634wrw.103.1555593650693;
        Thu, 18 Apr 2019 06:20:50 -0700 (PDT)
Received: from gmail.com (2E8B0CD5.catv.pool.telekom.hu. [46.139.12.213])
        by smtp.gmail.com with ESMTPSA id r18sm3417736wme.18.2019.04.18.06.20.49
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 18 Apr 2019 06:20:49 -0700 (PDT)
Date:   Thu, 18 Apr 2019 15:20:47 +0200
From:   Ingo Molnar <mingo@kernel.org>
To:     Masahiro Yamada <yamada.masahiro@socionext.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        linux-arch <linux-arch@vger.kernel.org>,
        linux-arm-kernel@lists.infradead.org,
        Ingo Molnar <mingo@redhat.com>,
        Paul Burton <paul.burton@mips.com>, linux-mips@vger.kernel.org,
        x86@kernel.org, linux-mtd@lists.infradead.org,
        Arnd Bergmann <arnd@arndb.de>, linux-kernel@vger.kernel.org,
        linux-s390@vger.kernel.org, Dave Hansen <dave@sr71.net>,
        linuxppc-dev@lists.ozlabs.org,
        Michael Ellerman <mpe@ellerman.id.au>
Subject: Re: [PATCH] compiler: allow all arches to enable
 CONFIG_OPTIMIZE_INLINING
Message-ID: <20190418132047.GA21430@gmail.com>
References: <1553062828-27798-1-git-send-email-yamada.masahiro@socionext.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1553062828-27798-1-git-send-email-yamada.masahiro@socionext.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


* Masahiro Yamada <yamada.masahiro@socionext.com> wrote:

> Commit 60a3cdd06394 ("x86: add optimized inlining") introduced
> CONFIG_OPTIMIZE_INLINING, but it has been available only for x86.
> 
> The idea is obviously arch-agnostic although we need some code fixups.
> This commit moves the config entry from arch/x86/Kconfig.debug to
> lib/Kconfig.debug so that all architectures (except MIPS for now) can
> benefit from it.
> 
> At this moment, I added "depends on !MIPS" because fixing 0day bot reports
> for MIPS was complex to me.
> 
> I tested this patch on my arm/arm64 boards.
> 
> This can make a huge difference in kernel image size especially when
> CONFIG_OPTIMIZE_FOR_SIZE is enabled.
> 
> For example, I got 3.5% smaller arm64 kernel image for v5.1-rc1.
> 
>   dec       file
>   18983424  arch/arm64/boot/Image.before
>   18321920  arch/arm64/boot/Image.after
> 
> This also slightly improves the "Kernel hacking" Kconfig menu.
> Commit e61aca5158a8 ("Merge branch 'kconfig-diet' from Dave Hansen')
> mentioned this config option would be a good fit in the "compiler option"
> menu. I did so.

No objections against moving it from x86 code to generic code.

Thanks,

	Ingo

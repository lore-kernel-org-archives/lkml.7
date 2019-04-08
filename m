Return-Path: <SRS0=N68d=SK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5DBF4C10F13
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Apr 2019 22:35:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 20C74213F2
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Apr 2019 22:35:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MchLEDOs"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727787AbfDHWfZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Apr 2019 18:35:25 -0400
Received: from mail-ed1-f67.google.com ([209.85.208.67]:41475 "EHLO
        mail-ed1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726842AbfDHWfZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Apr 2019 18:35:25 -0400
Received: by mail-ed1-f67.google.com with SMTP id u2so8744178eds.8;
        Mon, 08 Apr 2019 15:35:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=AJTWu+gzIUIvtWlNqA1e99iCU+3wNgpuuBcFCKmYYzI=;
        b=MchLEDOssAovwrDCxnZWnsSB99u9map72+dURApDIZfwla/M44b+uoSu8mZPqdUIh0
         f+8dJVyfY4PvKjGep8ULxvPKEuU/ilL5ZUbUe0LnVRSqxowkUqHSkU48j5vUSX3RSwP3
         0IpzytEHiuOR7HkgUb5G56uH0PDbuTP2zd3AB3Sm/mlWTMqp4+DiLY1HAHLXrgGKGp3d
         PIYa5wCtsx3GIrA3p0nx9HQgTYPFurXN9gHG1dGs5rCHFAvu/bubxqONmrRgJXmY+/v/
         n6ByH4UcOQAO1NND8IAagMANBJPE/nQijnY5hTMCTUMZCi2gdccBS1DB60CVcvZ62i8k
         z6mA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=AJTWu+gzIUIvtWlNqA1e99iCU+3wNgpuuBcFCKmYYzI=;
        b=NltfdMFoUUMIuPMhDZhp45jaFf91kyx2ZvSHu8y0Fgd5Do5+PEmKMwE5CojkCAvxzS
         AYnxT+JK30Q8fn/TcIc0TJOxEOtbASdelNhlfKtr5zRWuJvRsBiGEZpMxyc+udy96JCl
         JtzQbY0gA9AOjTe27rgQQ++KrDkY5IPBEnlB0KKIRcmiH4wOQwvOQ+8GWK7593X4P6H+
         pLrQdr45tTIcJFCo8yeuQfaAW/wxhck3sfydztVfAG7KJ5kXXv+FkphLtaLn+QNfgpS5
         RIErtIOyNZEcDxlbIaTXgUn/GumVjcwqy6yh9V3DMG96L1QPdqQjvFR2oFA/dH/OB+Ne
         AqjQ==
X-Gm-Message-State: APjAAAVL67LVTU+HJqXINlAlXWPD2gNprAr2MFs1ffAFZSBau8ya6tJa
        DZoXjcXGxJazAOBiJouERzYJgwPdc8t7ng==
X-Google-Smtp-Source: APXvYqy9OBmjwRCy5fSl7SmoJah/JCXmykWQkK8AQEwrUta0ooOAFnALQE7AcndYAO9m0zSAdARcFA==
X-Received: by 2002:a50:912b:: with SMTP id e40mr21122665eda.44.1554762923695;
        Mon, 08 Apr 2019 15:35:23 -0700 (PDT)
Received: from archlinux-i9 ([2a01:4f9:2b:2b84::2])
        by smtp.gmail.com with ESMTPSA id i1sm8904250edi.15.2019.04.08.15.35.22
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Mon, 08 Apr 2019 15:35:22 -0700 (PDT)
Date:   Mon, 8 Apr 2019 15:35:20 -0700
From:   Nathan Chancellor <natechancellor@gmail.com>
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     Martin Schwidefsky <schwidefsky@de.ibm.com>,
        Heiko Carstens <heiko.carstens@de.ibm.com>,
        Sebastian Ott <sebott@linux.ibm.com>,
        Peter Oberparleiter <oberpar@linux.ibm.com>,
        clang-built-linux@googlegroups.com,
        Nick Desaulniers <ndesaulniers@google.com>,
        linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 07/12] s390: cio: fix cio_irb declaration
Message-ID: <20190408223520.GE18333@archlinux-i9>
References: <20190408212648.2407234-1-arnd@arndb.de>
 <20190408212648.2407234-7-arnd@arndb.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190408212648.2407234-7-arnd@arndb.de>
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 08, 2019 at 11:26:20PM +0200, Arnd Bergmann wrote:
> clang points out that the declaration of cio_irb does not match the
> definition exactly, it is missing the alignment attribute:
> 
> ../drivers/s390/cio/cio.c:50:1: warning: section does not match previous declaration [-Wsection]
> DEFINE_PER_CPU_ALIGNED(struct irb, cio_irb);
> ^
> ../include/linux/percpu-defs.h:150:2: note: expanded from macro 'DEFINE_PER_CPU_ALIGNED'
>         DEFINE_PER_CPU_SECTION(type, name, PER_CPU_ALIGNED_SECTION)     \
>         ^
> ../include/linux/percpu-defs.h:93:9: note: expanded from macro 'DEFINE_PER_CPU_SECTION'
>         extern __PCPU_ATTRS(sec) __typeof__(type) name;                 \
>                ^
> ../include/linux/percpu-defs.h:49:26: note: expanded from macro '__PCPU_ATTRS'
>         __percpu __attribute__((section(PER_CPU_BASE_SECTION sec)))     \
>                                 ^
> ../drivers/s390/cio/cio.h:118:1: note: previous attribute is here
> DECLARE_PER_CPU(struct irb, cio_irb);
> ^
> ../include/linux/percpu-defs.h:111:2: note: expanded from macro 'DECLARE_PER_CPU'
>         DECLARE_PER_CPU_SECTION(type, name, "")
>         ^
> ../include/linux/percpu-defs.h:87:9: note: expanded from macro 'DECLARE_PER_CPU_SECTION'
>         extern __PCPU_ATTRS(sec) __typeof__(type) name
>                ^
> ../include/linux/percpu-defs.h:49:26: note: expanded from macro '__PCPU_ATTRS'
>         __percpu __attribute__((section(PER_CPU_BASE_SECTION sec)))     \
>                                 ^
> Use DECLARE_PER_CPU_ALIGNED() here, to make the two match.
> 
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>

Reviewed-by: Nathan Chancellor <natechancellor@gmail.com>

> ---
>  drivers/s390/cio/cio.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/s390/cio/cio.h b/drivers/s390/cio/cio.h
> index 9811fd8a0c73..92eabbb5f18d 100644
> --- a/drivers/s390/cio/cio.h
> +++ b/drivers/s390/cio/cio.h
> @@ -115,7 +115,7 @@ struct subchannel {
>  	struct schib_config config;
>  } __attribute__ ((aligned(8)));
>  
> -DECLARE_PER_CPU(struct irb, cio_irb);
> +DECLARE_PER_CPU_ALIGNED(struct irb, cio_irb);
>  
>  #define to_subchannel(n) container_of(n, struct subchannel, dev)
>  
> -- 
> 2.20.0
> 

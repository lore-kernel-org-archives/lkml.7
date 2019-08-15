Return-Path: <SRS0=gp+X=WL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D97BEC3A589
	for <linux-kernel@archiver.kernel.org>; Thu, 15 Aug 2019 21:02:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ABEC82063F
	for <linux-kernel@archiver.kernel.org>; Thu, 15 Aug 2019 21:02:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="O8I4Hv20"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733062AbfHOVCL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 15 Aug 2019 17:02:11 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:38412 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726008AbfHOVCK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Aug 2019 17:02:10 -0400
Received: by mail-pg1-f194.google.com with SMTP id e11so1827570pga.5;
        Thu, 15 Aug 2019 14:02:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=BtLaiUFG0I+lDd+yyoqx+gGXxf6RzpGtAnOY1h/Vn7g=;
        b=O8I4Hv20M1KGrTCAcQzm/iIfhIVNCNVrHhUwX5At4M8PqRhBIucpMeFL4NV123zeDc
         o3oY7q9606YyJ8GXfK3t0JPYlyp1kdVKYW0dXZhnKhM2pXO0EqIH86V0VCeRYNKW9JiL
         m1NwNzFoX7vhOqcvw2ZHbTZ15JePYTCfv80eAy+IX9ppZrD1WDqtlUAaBAT7V+oIxJpw
         Pae8HNVLamX0VeZP6/ZxU7QjzRdpFMWka7Zmn4R270jMrve94Bp+H+MYuPnRCWxVpIQP
         dxCXBbCnULAuqSpGrY/t9Rx6QQRrKBGQEc5UjMQdyMg0JPPGmMa9bS9TLqFNQGoUKrtP
         t4OA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=BtLaiUFG0I+lDd+yyoqx+gGXxf6RzpGtAnOY1h/Vn7g=;
        b=LR7CEJNTtD2U4mn5bUwuNJH1e2hCqGcgrn0lV33qjRHKVaw+dSP5VHsXRTcWxWxIT4
         J9HcssYQ3Ys+RUoSj+Ar4G4kFOE9r2kC546RjD7c2BWFxV95+nU9oG/MQXA/kpmWqlKz
         4YfSJ/prf844hRvHrjFlEHWDAcWVsQvqxbUWODQUmKPIXgTSlIv4dHKBAzC72MfDV90t
         XSgIo2N8QXe9rxJx5zJUyQTRGXyANoHFmrWz3v+6oJttjifiogKSnN/cKvHcnGatHhQ7
         VjANpuGZxej3rZUa4hCZTJLeNE37KglmVl5nTKG/RY86HsIFt7wEgS12EV2V8705Uxym
         hwVA==
X-Gm-Message-State: APjAAAVUfV7UoQGJycDJ/nSW0GmETS3veSBmweGhmILBMceL2KaytvXc
        3F4Wh3PdToJWFdd3TzRNr/2HCITp
X-Google-Smtp-Source: APXvYqymXjNjGUl0DeBYCJHEzb3l5Ece3CkIgKcVwhO5btVVopm6qcGADls7fPCu/ahnlAT21TBTUw==
X-Received: by 2002:a62:1858:: with SMTP id 85mr7467116pfy.120.1565902930078;
        Thu, 15 Aug 2019 14:02:10 -0700 (PDT)
Received: from localhost ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id h129sm3459816pfb.110.2019.08.15.14.02.09
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 15 Aug 2019 14:02:09 -0700 (PDT)
Date:   Thu, 15 Aug 2019 14:02:08 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     Qian Cai <cai@lca.pw>
Cc:     akpm@linux-foundation.org, James.Bottomley@HansenPartnership.com,
        deller@gmx.de, kirill.shutemov@linux.intel.com,
        linux-parisc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] parisc: fix compilation errrors
Message-ID: <20190815210208.GA9868@roeck-us.net>
References: <20190815205305.1382-1-cai@lca.pw>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190815205305.1382-1-cai@lca.pw>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 15, 2019 at 04:53:05PM -0400, Qian Cai wrote:
> The commit 0cfaee2af3a0 ("include/asm-generic/5level-fixup.h: fix
> variable 'p4d' set but not used") converted a few functions from macros
> to static inline, which causes parisc to complain,
> 
> In file included from ./include/asm-generic/4level-fixup.h:38:0,
>                  from ./arch/parisc/include/asm/pgtable.h:5,
>                  from ./arch/parisc/include/asm/io.h:6,
>                  from ./include/linux/io.h:13,
>                  from sound/core/memory.c:9:
> ./include/asm-generic/5level-fixup.h:14:18: error: unknown type name
> 'pgd_t'; did you mean 'pid_t'?
>  #define p4d_t    pgd_t
>                   ^
> ./include/asm-generic/5level-fixup.h:24:28: note: in expansion of macro
> 'p4d_t'
>  static inline int p4d_none(p4d_t p4d)
>                             ^~~~~
> 
> It is because "4level-fixup.h" is included before "asm/page.h" where
> "pgd_t" is defined.
> 
> Fixes: 0cfaee2af3a0 ("include/asm-generic/5level-fixup.h: fix variable 'p4d' set but not used")
> Reported-by: Guenter Roeck <linux@roeck-us.net>
> Signed-off-by: Qian Cai <cai@lca.pw>

Tested-by: Guenter Roeck <linux@roeck-us.net>

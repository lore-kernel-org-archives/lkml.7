Return-Path: <SRS0=bMiL=T7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8599FC04AB6
	for <linux-kernel@archiver.kernel.org>; Fri, 31 May 2019 23:57:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 43E7227034
	for <linux-kernel@archiver.kernel.org>; Fri, 31 May 2019 23:57:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726804AbfEaX5z (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 31 May 2019 19:57:55 -0400
Received: from mail-pl1-f193.google.com ([209.85.214.193]:35226 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726550AbfEaX5z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 May 2019 19:57:55 -0400
Received: by mail-pl1-f193.google.com with SMTP id p1so4607136plo.2
        for <linux-kernel@vger.kernel.org>; Fri, 31 May 2019 16:57:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:subject:in-reply-to:cc:from:to:message-id
         :mime-version:content-transfer-encoding;
        bh=t9nVl1gIHwlIdoPhU2OlffJsZVlBCqHfyxU1NxDBE+w=;
        b=dNyd78CA5oSXEpmmFtqGTURXPzIrtsTGZ5bdlzoZJp7nTRzg0DRfZvsGkc0wXMlg6c
         KXK0spMNBji4xsUjXd3jf/E9IuZN6e3BC2XAQUP3ymlEXR4oEpq+pzGBTfyg48HDW0h7
         +rRcZJJoMmkyzBE1r/C2HEDPDSjHJjMFTZ3dlvp2AXs1uuhWAqe2z7rab2nx6OVQKv/+
         1elHEQvyQO/L8KebXeHdFhdqspo0YZrVzidqwgYAbqF4PGzhFXp5zyTwxesRwQxPeuM9
         /a+i8eMwnzfRef5tyxSb+oi22Obu6QhcWGWvYXI2Icy3CleB5Jampx3U7DtgukHBh10s
         KTfw==
X-Gm-Message-State: APjAAAVb2Yq4h5kPE82GeM1oK7B1M4Y6hHtr9SLXANxK13h+vmzK5X2V
        pBJB6XHXsq5yUIC0QcgohiOWkA==
X-Google-Smtp-Source: APXvYqxtos57K7T2XrlqEmaGz3PgUmvWlxnSpQme8O4EI89epWX4DYPjXoKLLCIvww44k1fLGUHRiA==
X-Received: by 2002:a17:902:bb96:: with SMTP id m22mr13017495pls.5.1559347074023;
        Fri, 31 May 2019 16:57:54 -0700 (PDT)
Received: from localhost ([12.206.222.5])
        by smtp.gmail.com with ESMTPSA id t124sm7527066pfb.80.2019.05.31.16.57.52
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 31 May 2019 16:57:53 -0700 (PDT)
Date:   Fri, 31 May 2019 16:57:53 -0700 (PDT)
X-Google-Original-Date: Fri, 31 May 2019 16:42:25 PDT (-0700)
Subject:     Re: [PATCH 3/5] asm-generic: Register fchmodat4 as syscall 428
In-Reply-To: <CAK8P3a2=xko56LbwV4tyhyyyX+tw+EV-NGavYEYj0q61t=mnwg@mail.gmail.com>
CC:     viro@zeniv.linux.org.uk, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-api@vger.kernel.org,
        linux-arch@vger.kernel.org, x86@kernel.org, luto@kernel.org,
        tglx@linutronix.de, mingo@redhat.com, bp@alien8.de, hpa@zytor.com
From:   Palmer Dabbelt <palmer@sifive.com>
To:     Arnd Bergmann <arnd@arndb.de>
Message-ID: <mhng-d362e451-72d2-4893-a749-8469359b65ea@palmer-si-x1e>
Mime-Version: 1.0 (MHng)
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 31 May 2019 12:56:39 PDT (-0700), Arnd Bergmann wrote:
> On Fri, May 31, 2019 at 9:23 PM Palmer Dabbelt <palmer@sifive.com> wrote:
>>
>> Signed-off-by: Palmer Dabbelt <palmer@sifive.com>
>
> As usual, each patch needs a changelog text. I would prefer having a single
> patch here that changes /all/ system call tables at once, rather than doing one
> at a time like we used to.

Works for me.  That also gives me something to write about it the text :)

> In linux-next, we are at number 434 now, and there are a couple of other
> new system calls being proposed right now (more than usual), so you may
> have to change the number a few times.

OK, no problem.  It'll be a bit easier to handle the number that way.

> Note: most architectures use .tbl files now, the exceptions are
> include/uapi/asm-generic/unistd.h and arch/arm64/include/asm/unistd32.h,
> and the latter also requires changing __NR_compat_syscalls in asm/unistd.h.
>
> Numbers should now be the same across architectures, except for alpha,
> which has a +110 offset. We have discussed ways to have a single
> file to modify for a new call on all architectures, but no patches yet.

OK, thanks.  I'll wait a bit for feedback, but unless there's anything else
I'll go ahead and finish this.

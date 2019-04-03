Return-Path: <SRS0=7x1k=SF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_NEOMUTT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 983CAC4360F
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Apr 2019 14:02:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 689FE2075E
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Apr 2019 14:02:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=brauner.io header.i=@brauner.io header.b="CRs6oIkk"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726544AbfDCOCJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Apr 2019 10:02:09 -0400
Received: from mail-ed1-f65.google.com ([209.85.208.65]:39795 "EHLO
        mail-ed1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726193AbfDCOCI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Apr 2019 10:02:08 -0400
Received: by mail-ed1-f65.google.com with SMTP id p20so15016765eds.6
        for <linux-kernel@vger.kernel.org>; Wed, 03 Apr 2019 07:02:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=brauner.io; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=Jmr0XL65zkJLVQU8qMMDu16r6hNH3o7/wQtFHYQMQl4=;
        b=CRs6oIkki4ZwTJvuTzGu5Jup5fA7mvnHRyDoEDsyKtZc3mAIidZuFaIO3uaqr/TitR
         Jmohs6IDShKzGKNp6CPEXS3FBCs9tgtx95pMTBn72l9e3bGBO0rXMCe3EXdDV5wBr8qo
         e19jiWyCCxFbBGXknaj7MafFHjk3VLQggZ7Z84A5CgTce0na10wAl72Ytg5nVNiBRxrq
         RfEloMeOUxroOXkFS808Hug5qADlLEeTE2LLuLFUvFcjyqcoTpqzBlDR1I8/AdBZnNp5
         V4cJcq2uce5fBFWacbGao9WqYQlf8BzB9yBTthe0Wk6Vvr2KMvFxPmu+b4x7XuUUverq
         OODg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=Jmr0XL65zkJLVQU8qMMDu16r6hNH3o7/wQtFHYQMQl4=;
        b=siNR/w1VubHrRFr9vkr+LHPw2CdH10OsUpnK/wEr6EPrw4pxnMiroI3qzr0aiJsHG9
         D6njGxri40fJskcwGpxaX68NBZLiMkHLl8c9cd0oMj4+9CXQWuVhQ/ex5Bk7jXqaVB1X
         /aA8D9oQ9L44/6JcQg59H8k32lIY85iCvyiLZUTbhmQMgDCSMoZ139khHnXAAPXITjud
         kizvEDmMVxaAmCeb70IYqE5dUoyRJiUZZu+ibYGAJYCFs7zgCzFKxtZg4sWkiK2V2maL
         HOuMsUScPJBsZ5NeIyAUuzGeQHtPQK0jiUW51klsiULv+TFSgZw99g5CYCq+d8PKiXSF
         IuGA==
X-Gm-Message-State: APjAAAVMUotE0MIOqLqQK4OJWFNUoLxxYxecR/mEZRObYFuYbHwN4+fJ
        0IAi4B9qj93gmu9YjDGHnhbcqg==
X-Google-Smtp-Source: APXvYqzSYXi/Yk0XpBT9tURLiDfLo5/IkCeO7+7r8zv+aoxHzoe3cp2FNJb97xMAQ1RC4Czi1ndNXg==
X-Received: by 2002:a50:fa90:: with SMTP id w16mr51909481edr.42.1554300126203;
        Wed, 03 Apr 2019 07:02:06 -0700 (PDT)
Received: from brauner.io ([212.91.227.56])
        by smtp.gmail.com with ESMTPSA id b3sm3083871eje.3.2019.04.03.07.02.05
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Wed, 03 Apr 2019 07:02:05 -0700 (PDT)
Date:   Wed, 3 Apr 2019 16:02:04 +0200
From:   Christian Brauner <christian@brauner.io>
To:     Matteo Croce <mcroce@redhat.com>
Cc:     linux-fsdevel@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>,
        Luis Chamberlain <mcgrof@kernel.org>,
        Kees Cook <keescook@chromium.org>, willy@infradead.org,
        zev@bewilderbeest.net, akpm@linux-foundation.org
Subject: Re: [PATCH] kernel/sysctl.c: fix out of bounds access in fs.file-max
Message-ID: <20190403140203.qq37rgcikvoawb5f@brauner.io>
References: <20190328130306.25384-1-mcroce@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190328130306.25384-1-mcroce@redhat.com>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 28, 2019 at 02:03:06PM +0100, Matteo Croce wrote:
> fs.file-max sysctl uses proc_doulongvec_minmax() as proc handler, which
> accesses *extra1 and *extra2 as unsigned long, but commit 32a5ad9c2285
> ("sysctl: handle overflow for file-max") assigns &zero, which is an int,
> to extra1, generating the following KASAN report.
> Fix this by changing 'zero' to long, which does not need to be duplicated
> like 'one' and 'one_ul' for two data types.

Yeah, maybe but it still feels cleaner and more obvious to just add:

static long long_zero;

given that most callers actually seem to want an (unsigned) int.

I don't have a strong opinion though so if others feel that it's just a
waste of space consider it acked.

> 
> ==================================================================
> BUG: KASAN: global-out-of-bounds in __do_proc_doulongvec_minmax+0x2f9/0x600
> Read of size 8 at addr ffffffff8233dc20 by task systemd/1
> 
> CPU: 0 PID: 1 Comm: systemd Not tainted 5.1.0-rc2-kvm+ #22
> Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS ?-20180724_192412-buildhw-07.phx2.fedoraproject.org-1.fc29 04/01/2014
> Call Trace:
>  print_address_description+0x67/0x23d
>  kasan_report.cold.3+0x1c/0x36
>  __do_proc_doulongvec_minmax+0x2f9/0x600
>  proc_doulongvec_minmax+0x3a/0x50
>  proc_sys_call_handler+0x11d/0x170
>  vfs_write+0xd7/0x200
>  ksys_write+0x93/0x110
>  do_syscall_64+0x57/0x140
>  entry_SYSCALL_64_after_hwframe+0x44/0xa9
> RIP: 0033:0x7f67d33e8804
> Code: 00 f7 d8 64 89 02 48 c7 c0 ff ff ff ff eb b3 0f 1f 80 00 00 00 00 48 8d 05 f9 5e 0d 00 8b 00 85 c0 75 13 b8 01 00 00 00 0f 05 <48> 3d 00 f0 ff ff 77 54 c3 0f 1f 00 41 54 49 89 d4 55 48 89 f5 53
> RSP: 002b:00007fffd9992ed8 EFLAGS: 00000246 ORIG_RAX: 0000000000000001
> RAX: ffffffffffffffda RBX: 0000000000000000 RCX: 00007f67d33e8804
> RDX: 0000000000000015 RSI: 00005586ce2607b0 RDI: 0000000000000004
> RBP: 00007fffd9992f30 R08: 000000000000c0c0 R09: ffffffffffff0000
> R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000004
> R13: 0000000000000015 R14: 00005586ce2607c4 R15: 00007fffd9992f70
> 
> The buggy address belongs to the variable:
>  0xffffffff8233dc20
> 
> Memory state around the buggy address:
>  ffffffff8233db00: 00 00 00 00 00 00 00 00 fa fa fa fa 04 fa fa fa
>  ffffffff8233db80: fa fa fa fa 04 fa fa fa fa fa fa fa 04 fa fa fa
> >ffffffff8233dc00: fa fa fa fa 04 fa fa fa fa fa fa fa 00 00 00 00
>                                ^
>  ffffffff8233dc80: fa fa fa fa fa fa fa fa 00 00 00 00 00 00 00 00
>  ffffffff8233dd00: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> ==================================================================
> 
> Fixes: 32a5ad9c2285 ("sysctl: handle overflow for file-max")

Next time, please take the time to Cc the author of the Fixes patch as
well whose commit this is fixing right away.

> Signed-off-by: Matteo Croce <mcroce@redhat.com>
> ---
>  kernel/sysctl.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/kernel/sysctl.c b/kernel/sysctl.c
> index e5da394d1ca3..3e959d67d619 100644
> --- a/kernel/sysctl.c
> +++ b/kernel/sysctl.c
> @@ -124,7 +124,7 @@ static int sixty = 60;
>  
>  static int __maybe_unused neg_one = -1;
>  
> -static int zero;
> +static long zero;

>  static int __maybe_unused one = 1;
>  static int __maybe_unused two = 2;
>  static int __maybe_unused four = 4;
> -- 
> 2.20.1
> 

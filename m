Return-Path: <SRS0=LniW=ZY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BF899C432C3
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Dec 2019 15:40:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9068D2084F
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Dec 2019 15:40:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="ZuACP+D8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727533AbfLBPkt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 2 Dec 2019 10:40:49 -0500
Received: from mail-il1-f196.google.com ([209.85.166.196]:42553 "EHLO
        mail-il1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727436AbfLBPkt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Dec 2019 10:40:49 -0500
Received: by mail-il1-f196.google.com with SMTP id f6so22846ilh.9
        for <linux-kernel@vger.kernel.org>; Mon, 02 Dec 2019 07:40:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=Qo0WCLG/RhcpIAjfVeitSqiWKm1KS1IacYIGFKaHtek=;
        b=ZuACP+D8ju5cgg0LyHFliG0Q8/9feKVCNcdWd0oXkCcuaedkespPghKpv9mfFyxZRS
         ZXsnO+3bNzcMA8yRzWG0/lHtJrvvccRtdL5yifvMFNxe27/5jSB6OB5d25YHAAVMey42
         wOuwr96LroiltNAZ8mRDNJhho6c3wsufng70hEbeufxMAaZaTa6syagxaGf6gLmg5Nwg
         /1bLlnOBuSZNkxT5ABR7YDP5ZWq6Ks9KhzQxLz9OL1Xt73Nf3crm0nLNLSmlopYVT38b
         DV+0YisNvyX9bF9qtS6kmeNq27bByKWy9N6mhMtKsoe0KqlyAVIiZB8FhsYnuL/RU8Y2
         ohVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=Qo0WCLG/RhcpIAjfVeitSqiWKm1KS1IacYIGFKaHtek=;
        b=BWNzkWqnmY9QI2eg1g0QxbvgpPEhzXBfrXgraFopKPIkHsZayom68lOgYzPYCfNT14
         9KMbDR7BEeGW/Ueq4mpGtQca4SYjAfif5oQPM5o6daDgNMhf0xHEN9rmeG/Ga7v2fLUc
         APk8JNti0KXhvIlksGXp0YSPL791AVRc5SI9ujJFSZCg43ruAjC5/vD4nskQMaImWk1C
         OV+urXxIi6Xh5eujb2nLkDJx3w1BwG2hi8Q+/n+kM4uvXVfa0G3JTkU64oE/DZjCo9SI
         B70OFqeUJU75Jm5kNZ6/oImRuyHfZCU3FZG+XUn8AZslsXxkL2/p6W1JLFKIB78LHM0Y
         0xaw==
X-Gm-Message-State: APjAAAX/3Wz36gquyo1GxnDw3vLKssAAQg1CG/sm/pnsy4j70Q1ObORA
        zgroB036ekVLuGn8kkoYYAnt+g==
X-Google-Smtp-Source: APXvYqxj7s9YyvQDe8VJRKErNoRUHFcUmxx9XB+GBE+Mucwdhyd2TBhUUwbPpwBrXHhH/gErwV8ZIA==
X-Received: by 2002:a92:3dd0:: with SMTP id k77mr20312842ilf.3.1575301248415;
        Mon, 02 Dec 2019 07:40:48 -0800 (PST)
Received: from [192.168.1.159] ([65.144.74.34])
        by smtp.gmail.com with ESMTPSA id s2sm8128247ioe.64.2019.12.02.07.40.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 02 Dec 2019 07:40:47 -0800 (PST)
Subject: Re: general protection fault in override_creds
To:     Dmitry Vyukov <dvyukov@google.com>,
        syzbot <syzbot+5320383e16029ba057ff@syzkaller.appspotmail.com>,
        Al Viro <viro@zeniv.linux.org.uk>, io-uring@vger.kernel.org,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>
Cc:     Anna.Schumaker@netapp.com,
        Casey Schaufler <casey@schaufler-ca.com>,
        David Howells <dhowells@redhat.com>,
        Jann Horn <jannh@google.com>,
        Kees Cook <keescook@chromium.org>,
        Kate Stewart <kstewart@linuxfoundation.org>,
        LKML <linux-kernel@vger.kernel.org>, NeilBrown <neilb@suse.com>,
        syzkaller-bugs <syzkaller-bugs@googlegroups.com>,
        Thomas Gleixner <tglx@linutronix.de>
References: <000000000000da160a0598b2c704@google.com>
 <CACT4Y+ZGx16qc8qtekP0Bx=syVQest8K_RVtEN084jnszx4qhA@mail.gmail.com>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <39ea5e00-3278-a84f-25ae-c7a93a4b8ab5@kernel.dk>
Date:   Mon, 2 Dec 2019 08:40:45 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.1
MIME-Version: 1.0
In-Reply-To: <CACT4Y+ZGx16qc8qtekP0Bx=syVQest8K_RVtEN084jnszx4qhA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/1/19 10:40 PM, Dmitry Vyukov wrote:
> On Mon, Dec 2, 2019 at 7:35 AM syzbot
> <syzbot+5320383e16029ba057ff@syzkaller.appspotmail.com> wrote:
>>
>> Hello,
>>
>> syzbot found the following crash on:
>>
>> HEAD commit:    b94ae8ad Merge tag 'seccomp-v5.5-rc1' of git://git.kernel...
>> git tree:       upstream
>> console output: https://syzkaller.appspot.com/x/log.txt?x=10f9ffcee00000
>> kernel config:  https://syzkaller.appspot.com/x/.config?x=ff560c3de405258c
>> dashboard link: https://syzkaller.appspot.com/bug?extid=5320383e16029ba057ff
>> compiler:       gcc (GCC) 9.0.0 20181231 (experimental)
>> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=12dd682ae00000
>> C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=16290abce00000
>>
>> IMPORTANT: if you fix the bug, please add the following tag to the commit:
>> Reported-by: syzbot+5320383e16029ba057ff@syzkaller.appspotmail.com
> 
> I think this relates to fs/io_uring.c rather than kernel/cred.c.
> +io_uring maintainers

Yeah that's my fault, guessing the below will fix it. I'll test and
queue it up.


diff --git a/fs/io_uring.c b/fs/io_uring.c
index ec53aa7cdc94..afafe0463d2d 100644
--- a/fs/io_uring.c
+++ b/fs/io_uring.c
@@ -4361,7 +4361,8 @@ static void io_ring_ctx_free(struct io_ring_ctx *ctx)
  		io_unaccount_mem(ctx->user,
  				ring_pages(ctx->sq_entries, ctx->cq_entries));
  	free_uid(ctx->user);
-	put_cred(ctx->creds);
+	if (ctx->creds)
+		put_cred(ctx->creds);
  	kfree(ctx->completions);
  	kmem_cache_free(req_cachep, ctx->fallback_req);
  	kfree(ctx);
@@ -4759,7 +4760,12 @@ static int io_uring_create(unsigned entries, struct io_uring_params *p)
  	ctx->compat = in_compat_syscall();
  	ctx->account_mem = account_mem;
  	ctx->user = user;
+
  	ctx->creds = prepare_creds();
+	if (!ctx->creds) {
+		ret = -ENOMEM;
+		goto err;
+	}
  
  	ret = io_allocate_scq_urings(ctx, p);
  	if (ret)

-- 
Jens Axboe


Return-Path: <SRS0=fl2C=S4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AB2E6C43218
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Apr 2019 13:01:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7092C2067D
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Apr 2019 13:01:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PbUII7W6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726379AbfDZNBn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 26 Apr 2019 09:01:43 -0400
Received: from mail-ed1-f65.google.com ([209.85.208.65]:35950 "EHLO
        mail-ed1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726039AbfDZNBl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Apr 2019 09:01:41 -0400
Received: by mail-ed1-f65.google.com with SMTP id a8so1043114edx.3;
        Fri, 26 Apr 2019 06:01:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=B4pMRr+qD2C/mlGJoUk8LUMpjGw7AuwkyCqkmdPeTXw=;
        b=PbUII7W6Lf4184BK5+eG15f+QEstYdWjdaP/007t/42OI7Ptj/DLV8TheDVSOGAqeG
         hzyeYAwf4JXL9NA5AisAupr2G/rhtaAnGBbrLiTEJOMwMnFiP51pUgbmkKA83Jf3yS/B
         R7nEutWsu4SZYvJJv7WlrylSpOgj/krHtHBrPx9pxEAAbvFPM6dI9DC4i9nZnq6P8BY5
         C9IzwJOts3dLwDNnp4KHBBA1Sonuh4xZR1JVrw5HkfZ48Mt+I0nROn9fnLdAwbAU+sts
         ZTe5c0KGQwvDdtvJehekueOVKIV51HWvqdgypCykpL2tOkJQF/HvcuLsYcR4u+k8Fmb4
         pYMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=B4pMRr+qD2C/mlGJoUk8LUMpjGw7AuwkyCqkmdPeTXw=;
        b=Hj1kzH2OI86RbAy+H+tNJbXB0OmL2GHQ7j8Epm857q9LPFDHYLOEOj+Jz7jZ/L3Khi
         g1CKB1ukyyy3nxCQuq4KoKgEaMykxrdwauDNeObakGI4vN0HvFspkpn+B2y/Ye++OC9U
         alPBznvZlIAMuBNO92KI1hWP0HTEYAbm/iMISKLpdQBKy8lM0VOp2b5xAtk7YMsDAAT1
         JTlr5sweLbeDDuKNcZ81zU4A6FhL0mVcU5u9m7heNm3hDRXtiGBW6MYIV/T0Iy5sS8ng
         0mw9p6vBZEI3gkDtUCZKcwrDLI645Jd4NPsEtW7dYjra/ragxhOo8sMkWvNThq7WlUQP
         wmjA==
X-Gm-Message-State: APjAAAW0YksDNkZpDHgO6Jv9pUQchbwnWJpT2qnP7F3z23T0YAhrzcs3
        s6Q+V+JFEdfSZehbMgNPCTs=
X-Google-Smtp-Source: APXvYqxkf0zoB6r38kr0n+gXfFUwqmsjIslxDm2C/+EOwrk4K2PLaQg1wbt0Bgbri0gezQddaNkcgA==
X-Received: by 2002:a50:a3b1:: with SMTP id s46mr26777823edb.99.1556283697636;
        Fri, 26 Apr 2019 06:01:37 -0700 (PDT)
Received: from archlinux-i9 ([2a01:4f9:2b:2b84::2])
        by smtp.gmail.com with ESMTPSA id g55sm7092291edb.12.2019.04.26.06.01.36
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Fri, 26 Apr 2019 06:01:36 -0700 (PDT)
Date:   Fri, 26 Apr 2019 06:01:34 -0700
From:   Nathan Chancellor <natechancellor@gmail.com>
To:     Coly Li <colyli@suse.de>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Kent Overstreet <kent.overstreet@gmail.com>,
        clang-built-linux@googlegroups.com,
        Nick Desaulniers <ndesaulniers@google.com>,
        Jens Axboe <axboe@kernel.dk>,
        Shenghui Wang <shhuiw@foxmail.com>,
        Hannes Reinecke <hare@suse.com>, linux-bcache@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] bcache: avoid clang -Wunintialized warning
Message-ID: <20190426130134.GB12483@archlinux-i9>
References: <20190322143507.1256436-1-arnd@arndb.de>
 <20190425180853.GA4507@archlinux-i9>
 <44474338-8031-13eb-1e95-376c1036b611@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <44474338-8031-13eb-1e95-376c1036b611@suse.de>
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 26, 2019 at 10:43:01AM +0800, Coly Li wrote:
> On 2019/4/26 2:08 上午, Nathan Chancellor wrote:
> > On Fri, Mar 22, 2019 at 03:35:00PM +0100, Arnd Bergmann wrote:
> >> clang has identified a code path in which it thinks a
> >> variable may be unused:
> >>
> >> drivers/md/bcache/alloc.c:333:4: error: variable 'bucket' is used uninitialized whenever 'if' condition is false
> >>       [-Werror,-Wsometimes-uninitialized]
> >>                         fifo_pop(&ca->free_inc, bucket);
> >>                         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> >> drivers/md/bcache/util.h:219:27: note: expanded from macro 'fifo_pop'
> >>  #define fifo_pop(fifo, i)       fifo_pop_front(fifo, (i))
> >>                                 ^~~~~~~~~~~~~~~~~~~~~~~~~
> >> drivers/md/bcache/util.h:189:6: note: expanded from macro 'fifo_pop_front'
> >>         if (_r) {                                                       \
> >>             ^~
> >> drivers/md/bcache/alloc.c:343:46: note: uninitialized use occurs here
> >>                         allocator_wait(ca, bch_allocator_push(ca, bucket));
> >>                                                                   ^~~~~~
> >> drivers/md/bcache/alloc.c:287:7: note: expanded from macro 'allocator_wait'
> >>                 if (cond)                                               \
> >>                     ^~~~
> >> drivers/md/bcache/alloc.c:333:4: note: remove the 'if' if its condition is always true
> >>                         fifo_pop(&ca->free_inc, bucket);
> >>                         ^
> >> drivers/md/bcache/util.h:219:27: note: expanded from macro 'fifo_pop'
> >>  #define fifo_pop(fifo, i)       fifo_pop_front(fifo, (i))
> >>                                 ^
> >> drivers/md/bcache/util.h:189:2: note: expanded from macro 'fifo_pop_front'
> >>         if (_r) {                                                       \
> >>         ^
> >> drivers/md/bcache/alloc.c:331:15: note: initialize the variable 'bucket' to silence this warning
> >>                         long bucket;
> >>                                    ^
> >>
> >> This cannot happen in practice because we only enter the loop
> >> if there is at least one element in the list.
> >>
> >> Slightly rearranging the code makes this clearer to both the
> >> reader and the compiler, which avoids the warning.
> >>
> >> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> >> ---
> >>  drivers/md/bcache/alloc.c | 5 +++--
> >>  1 file changed, 3 insertions(+), 2 deletions(-)
> >>
> >> diff --git a/drivers/md/bcache/alloc.c b/drivers/md/bcache/alloc.c
> >> index 5002838ea476..f8986effcb50 100644
> >> --- a/drivers/md/bcache/alloc.c
> >> +++ b/drivers/md/bcache/alloc.c
> >> @@ -327,10 +327,11 @@ static int bch_allocator_thread(void *arg)
> >>  		 * possibly issue discards to them, then we add the bucket to
> >>  		 * the free list:
> >>  		 */
> >> -		while (!fifo_empty(&ca->free_inc)) {
> >> +		while (1) {
> >>  			long bucket;
> >>  
> >> -			fifo_pop(&ca->free_inc, bucket);
> >> +			if (!fifo_pop(&ca->free_inc, bucket))
> >> +				break;
> >>  
> >>  			if (ca->discard) {
> >>  				mutex_unlock(&ca->set->bucket_lock);
> >> -- 
> >> 2.20.0
> >>
> > 
> > Hi all,
> > 
> > Could someone please review/pick this up? This is one of two remaining
> > -Wsometimes-uninitialized warnings among arm, arm64, and x86_64
> > all{yes,mod}config and I'd like to get it turned on as soon as possible
> > to catch more bugs.
> 
> Hi Nathan,
> 
> It is in Jens' block tree for-next branch already, for Linux v5.2 merge
> window.
> 
> Thanks.
> 
> -- 
> 
> Coly Li

Hi Coly,

Thank you for the reply and heads up, it hadn't hit -next when I sent
that message and I didn't check Jens' tree.

I appreciate you picking it up!

Nathan

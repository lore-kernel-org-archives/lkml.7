Return-Path: <SRS0=SHWF=W4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1E4EBC3A5A4
	for <linux-kernel@archiver.kernel.org>; Sun,  1 Sep 2019 14:55:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DBAFD22CF7
	for <linux-kernel@archiver.kernel.org>; Sun,  1 Sep 2019 14:55:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="tGi/tj5P"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728982AbfIAOzQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 1 Sep 2019 10:55:16 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:44504 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728889AbfIAOzQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 1 Sep 2019 10:55:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        Content-Type:In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:
        Subject:Sender:Reply-To:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=yK4SKs2otDIGXkzGuKS5qjqU2ydZa20aaRelCAvd3zk=; b=tGi/tj5P9dZ6Sdu5vRb8p5s2z
        ghLGS73yHmQDLQaUC/b+ZV82erpT4LEmTOoe0x2iQ3o6JMems/81ajCm376/R9pOSrPUHlJzJsSSZ
        tYpIOKV8hqnN+VSBUyqriYhQbA4kpfFfraNEPnqNPygUc6nU4//Tyw5QVyxldrnqul57Y4sTPVCTa
        /Snj/JqTlAwMpfjCj9GG32yd4wh78yfzZDvswmzIa0TWtxCKB6nH1lQc4a3iJGttSppQRvWToszko
        JH7bmvR74HAavEekI+wqtUOucm2EO/DAotwrJ1OvSMPhpgUFcsGpiCU5iZvm7bTg4IGCV8P5/9RZZ
        PXkGhOYzQ==;
Received: from [2601:1c0:6200:6e8::4f71]
        by bombadil.infradead.org with esmtpsa (Exim 4.92 #3 (Red Hat Linux))
        id 1i4RG1-0007ut-Jd; Sun, 01 Sep 2019 14:55:09 +0000
Subject: Re: [PATCH RESEND] arch/microblaze: add support for get_user() of
 size 8 bytes
To:     Leon Romanovsky <leonro@mellanox.com>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        "Steven J. Magnani" <steve@digidescorp.com>,
        Michal Simek <monstr@monstr.eu>,
        Jason Gunthorpe <jgg@mellanox.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Doug Ledford <dledford@redhat.com>
References: <99f83474-3e71-4325-ddff-cf23a172b984@infradead.org>
 <20190901064926.GL12611@unreal>
From:   Randy Dunlap <rdunlap@infradead.org>
Message-ID: <a0711df8-50e1-c104-7603-929f8c4462cb@infradead.org>
Date:   Sun, 1 Sep 2019 07:55:08 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190901064926.GL12611@unreal>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/31/19 11:49 PM, Leon Romanovsky wrote:
> On Sat, Aug 31, 2019 at 08:40:05PM -0700, Randy Dunlap wrote:
>> From: Randy Dunlap <rdunlap@infradead.org>
>>
>> arch/microblaze/ is missing support for get_user() of size 8 bytes,
>> so add it by using __copy_from_user().
>>
>> Fixes these build errors:
>>    drivers/infiniband/core/uverbs_main.o: In function `ib_uverbs_write':
>>    drivers/infiniband/core/.tmp_gl_uverbs_main.o:(.text+0x13a4): undefined reference to `__user_bad'
>>    drivers/android/binder.o: In function `binder_thread_write':
>>    drivers/android/.tmp_gl_binder.o:(.text+0xda6c): undefined reference to `__user_bad'
>>    drivers/android/.tmp_gl_binder.o:(.text+0xda98): undefined reference to `__user_bad'
>>    drivers/android/.tmp_gl_binder.o:(.text+0xdf10): undefined reference to `__user_bad'
>>    drivers/android/.tmp_gl_binder.o:(.text+0xe498): undefined reference to `__user_bad'
>>    drivers/android/binder.o:drivers/android/.tmp_gl_binder.o:(.text+0xea78): more undefined references to `__user_bad' follow
>>
>> 'make allmodconfig' now builds successfully for arch/microblaze/.
>>
>> Fixes: 538722ca3b76 ("microblaze: fix get_user/put_user side-effects")
>> Reported-by: kbuild test robot <lkp@intel.com>
>> Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
>> Cc: Al Viro <viro@zeniv.linux.org.uk>
>> Cc: Steven J. Magnani <steve@digidescorp.com>
>> Cc: Michal Simek <monstr@monstr.eu>
>> Cc: Jason Gunthorpe <jgg@mellanox.com>
>> Cc: Leon Romanovsky <leonro@mellanox.com>
>> Cc: Andrew Morton <akpm@linux-foundation.org>
>> Cc: Doug Ledford <dledford@redhat.com>
>> Reviewed-by: Leon Romanovsky <leonro@mellanox.com>
>> ---
>> What is a reasonable path for having this patch merged?
>> Leon Romanovsky <leonro@mellanox.com> has tested it.
> 
> I tested it for compilation only, we (RDMA) don't work on
> arch/microblaze/ at all and care about kbuild failures only.

Hi Leon,
Since I modified the patch (about to send v3), I dropped your
Reviewed-by.

Thanks.

-- 
~Randy

Return-Path: <SRS0=8hmg=W5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 51206C3A5A4
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Sep 2019 02:10:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1CD3B21874
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Sep 2019 02:10:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="Xy4Qg4nu"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729211AbfIBCKQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 1 Sep 2019 22:10:16 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:57924 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727517AbfIBCKQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 1 Sep 2019 22:10:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        Content-Type:In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:
        Subject:Sender:Reply-To:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=IKEtilq2bCFU0ExW/kQEechgE7sEyiAZtsK6K3A0aYY=; b=Xy4Qg4nuoZ6/KSJhUspUj71XI
        mbaz/IVdXenNWL1LKL9plQv9geiHY86SuQO0ixHozKNmJxtbEacXej57pmenRH8w0KlEjJwwZMTFq
        eGVMwvFN9MQ2qoVAiPe8fphyLamELduVy9sYqA8LSs0XVsstbxBSa0nHStSazf9nUf3B8PRAQ4TQD
        Pn4WqFDZr+TXsdeYRAAK3WE8EUfZKDJJTluu9VCWOw4u4dOCWlifTtB7H5J+7GnyPcuRJDNt9YVjv
        +Br/XLSlTpP1NxVGiG2UobCe2rKSmmwrBvJx5gjnRGuuF/DHrerFZ8fIm7WDF48tWWVSsxRkJHU2V
        qRh0Sd+NA==;
Received: from [2601:1c0:6200:6e8::4f71]
        by bombadil.infradead.org with esmtpsa (Exim 4.92 #3 (Red Hat Linux))
        id 1i4bnI-0006CI-LK; Mon, 02 Sep 2019 02:10:12 +0000
Subject: Re: [PATCH v3] arch/microblaze: add support for get_user() of size 8
 bytes
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        "Steven J. Magnani" <steve@digidescorp.com>,
        Michal Simek <monstr@monstr.eu>,
        Jason Gunthorpe <jgg@mellanox.com>,
        Leon Romanovsky <leonro@mellanox.com>,
        Doug Ledford <dledford@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>
References: <5a3e440f-4ec5-65d7-b2a4-c57fec0df973@infradead.org>
 <CAHk-=wg4mE8pSEdWViqJBC9Teh8h1c9LrqqP6=_g8ud5hvkfmA@mail.gmail.com>
 <CAHk-=whH+Wzj+h0WzgdLMu+xtFddokoVy8dWWvEJqJRGA_HLmw@mail.gmail.com>
 <6184ffdd-30bf-668a-cdee-88cc8eb2ead7@infradead.org>
From:   Randy Dunlap <rdunlap@infradead.org>
Message-ID: <98c83922-6ab1-98ca-7682-7796ae1facf4@infradead.org>
Date:   Sun, 1 Sep 2019 19:10:11 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <6184ffdd-30bf-668a-cdee-88cc8eb2ead7@infradead.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/1/19 12:10 PM, Randy Dunlap wrote:
> On 9/1/19 10:31 AM, Linus Torvalds wrote:
>> On Sun, Sep 1, 2019 at 10:07 AM Linus Torvalds
>> <torvalds@linux-foundation.org> wrote:
>>>
>>> I guess I'll apply it. I'm not sure why you _care_ about microblaze, but ...
> 
> It was just a response to the 0day build bot reporting build errors.
> 
> 
>> Ugh. As I was going to apply it, my code cleanliness conscience struck.
>>
>> I can't deal with that unnecessary duplication of code. Does something
>> like the attached patch work instead?
>>
>> Totally untested, but looks much cleaner.
> 
> Hm, I'm getting one (confusing) build error, in block/scsi_ioctl.c:
> 
>   CC      block/scsi_ioctl.o
> In file included from ../include/linux/uaccess.h:11,
>                  from ../include/linux/highmem.h:9,
>                  from ../include/linux/pagemap.h:11,
>                  from ../include/linux/blkdev.h:16,
>                  from ../block/scsi_ioctl.c:9:
> ../block/scsi_ioctl.c: In function 'sg_scsi_ioctl':
> ../arch/microblaze/include/asm/uaccess.h:167:25: error: invalid initializer
>   typeof(ptr) __gu_ptr = (ptr);   \
>                          ^
> ../block/scsi_ioctl.c:426:6: note: in expansion of macro 'get_user'
>   if (get_user(opcode, sic->data))
>       ^~~~~~~~

	if (get_user(opcode, sic->data))
		return -EFAULT;

where sic->data is unsigned char data[0] here:

typedef struct scsi_ioctl_command {
	unsigned int inlen;
	unsigned int outlen;
	unsigned char data[0];
} Scsi_Ioctl_Command;

On x86_64 this builds as a call to get_user_1().
(cannot do objdump on arch/microblaze/, unknown arch/machine)

I guess we need a way to coerce that to call get_user_1(),
such as a typecast.  This _seems_ to work (i.e., call get_user_1()):

	if (get_user(opcode, (unsigned char *)(sic->data)))
		return -EFAULT;

??

-- 
~Randy

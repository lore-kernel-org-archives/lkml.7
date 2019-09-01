Return-Path: <SRS0=SHWF=W4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CD3FFC3A5A4
	for <linux-kernel@archiver.kernel.org>; Sun,  1 Sep 2019 19:10:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9B37321874
	for <linux-kernel@archiver.kernel.org>; Sun,  1 Sep 2019 19:10:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="fuiHZduC"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729181AbfIATKU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 1 Sep 2019 15:10:20 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:33416 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728830AbfIATKT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 1 Sep 2019 15:10:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        Content-Type:In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:
        Subject:Sender:Reply-To:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=udqiYKR1m77/U3JtKXAs1BCQma4/l5S0DGLhPu8CZzQ=; b=fuiHZduCC5LYy0nG7YVSBDcaH
        oYeV5AjzSbMo9zQUfXqO+DaNfJI3gTw4u95yiXfcBxA2hEAx7TyxKd1DOKylqIl5yqGyvX1/skH7R
        geTL5KhiNwhfaeezKkFk8TGoa+abJtrbBTQlWyyMly8FiB+NbJgerFk1KqPhHWKDvWEn1uICoZEKT
        CTcKa1NNTTl/kiLv0ti/S3JGaQxOrz28KoFkZYSQV4VJ4SY7LxzZIsCFY9PGiqAd5oxwQ66DRdGDf
        MQaK1ItTUMepKkGhFlDLA9jal6QWA6Vxikj6F7cKDprHg57tqpfrgv+ubmNjmRr1vFWaNIVXuyGd7
        RME+i26xQ==;
Received: from [2601:1c0:6200:6e8::4f71]
        by bombadil.infradead.org with esmtpsa (Exim 4.92 #3 (Red Hat Linux))
        id 1i4VEr-0000lH-HV; Sun, 01 Sep 2019 19:10:13 +0000
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
From:   Randy Dunlap <rdunlap@infradead.org>
Message-ID: <6184ffdd-30bf-668a-cdee-88cc8eb2ead7@infradead.org>
Date:   Sun, 1 Sep 2019 12:10:11 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <CAHk-=whH+Wzj+h0WzgdLMu+xtFddokoVy8dWWvEJqJRGA_HLmw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/1/19 10:31 AM, Linus Torvalds wrote:
> On Sun, Sep 1, 2019 at 10:07 AM Linus Torvalds
> <torvalds@linux-foundation.org> wrote:
>>
>> I guess I'll apply it. I'm not sure why you _care_ about microblaze, but ...

It was just a response to the 0day build bot reporting build errors.


> Ugh. As I was going to apply it, my code cleanliness conscience struck.
> 
> I can't deal with that unnecessary duplication of code. Does something
> like the attached patch work instead?
> 
> Totally untested, but looks much cleaner.

Hm, I'm getting one (confusing) build error, in block/scsi_ioctl.c:

  CC      block/scsi_ioctl.o
In file included from ../include/linux/uaccess.h:11,
                 from ../include/linux/highmem.h:9,
                 from ../include/linux/pagemap.h:11,
                 from ../include/linux/blkdev.h:16,
                 from ../block/scsi_ioctl.c:9:
../block/scsi_ioctl.c: In function 'sg_scsi_ioctl':
../arch/microblaze/include/asm/uaccess.h:167:25: error: invalid initializer
  typeof(ptr) __gu_ptr = (ptr);   \
                         ^
../block/scsi_ioctl.c:426:6: note: in expansion of macro 'get_user'
  if (get_user(opcode, sic->data))
      ^~~~~~~~


-- 
~Randy

Return-Path: <SRS0=SHWF=W4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C44CCC3A5A4
	for <linux-kernel@archiver.kernel.org>; Sun,  1 Sep 2019 19:11:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9551721874
	for <linux-kernel@archiver.kernel.org>; Sun,  1 Sep 2019 19:11:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="hGvfoVM7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729233AbfIATLX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 1 Sep 2019 15:11:23 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:33444 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728930AbfIATLX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 1 Sep 2019 15:11:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        Content-Type:In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:
        Subject:Sender:Reply-To:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=eZ1ZYS5stKR+NtN8D5MKkGEXnpoTWC1z1t4HtiysR9w=; b=hGvfoVM73YXqpFce9oaZN3wtT
        bFzTvtvxkRoBIReE+FNAosoUPJBaJsCVjel4r/poWl3gkCHpzvhMw8pAv2OOD0n4Y1fErtGow3Uk4
        +UZN4bRJCbqHn3dAo5PC3htQSM2YtY6cQpGOQaZVcJXpfI3wfz1uaixuPHzyIo7xeExwVT9VQMenF
        jc/vd+qfpyqF37f7qSvFdtd5cCqe1I9j+vXG/e+OUvlBL9a4N8JhaEvtnsEmJ2vEPHt7PJpUrl6ok
        FOuTacDmTWSDIKI33gEAGHWIF1Ol5C7Gwe2zxQAVwpIOMNolB5mOVoM7KeLEc+uMY5GcC4lbdHeoL
        u+eBRftCA==;
Received: from [2601:1c0:6200:6e8::4f71]
        by bombadil.infradead.org with esmtpsa (Exim 4.92 #3 (Red Hat Linux))
        id 1i4VFw-0000o6-7u; Sun, 01 Sep 2019 19:11:20 +0000
Subject: Re: [PATCH v3] arch/microblaze: add support for get_user() of size 8
 bytes
To:     monstr@monstr.eu, Linus Torvalds <torvalds@linux-foundation.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        "Steven J. Magnani" <steve@digidescorp.com>,
        Jason Gunthorpe <jgg@mellanox.com>,
        Leon Romanovsky <leonro@mellanox.com>,
        Doug Ledford <dledford@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>
References: <5a3e440f-4ec5-65d7-b2a4-c57fec0df973@infradead.org>
 <CAHk-=wg4mE8pSEdWViqJBC9Teh8h1c9LrqqP6=_g8ud5hvkfmA@mail.gmail.com>
 <4ef41a92-56d2-3973-8926-084891c965ee@monstr.eu>
From:   Randy Dunlap <rdunlap@infradead.org>
Message-ID: <97a9bc55-82d5-0389-7be6-c9c7c58c5545@infradead.org>
Date:   Sun, 1 Sep 2019 12:11:19 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <4ef41a92-56d2-3973-8926-084891c965ee@monstr.eu>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/1/19 10:33 AM, Michal Simek wrote:
> Hi,
> 
> On 01. 09. 19 19:07, Linus Torvalds wrote:
>> On Sun, Sep 1, 2019 at 7:55 AM Randy Dunlap <rdunlap@infradead.org> wrote:
>>>
>>> What is a reasonable path for having this patch merged?
>>> I have sent several emails to Micahl Simek but he seems to have
>>> dropped active maintenance of arch/microblaze/.
>>
>> Yeah, I haven't gotten a pull request from him since March, and that
>> was a trivial fixup.
>>
>> I guess I'll apply it. I'm not sure why you _care_ about microblaze, but ...
> 
> I am still around. The reason why I didn't send any pull request was
> simply there were no patches. For 5.4 there will be some patches.
> 
> Randy: I found one email which was sent July and this thread when I had
> vacation. I will take a look at both tmr. If there is something else
> please resend.

Good to hear that you are still around.
I'll let you know if I find other lost patches.

thanks.
-- 
~Randy

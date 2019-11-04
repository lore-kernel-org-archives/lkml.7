Return-Path: <SRS0=xa+R=Y4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B7377CA9EB5
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Nov 2019 14:34:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7546821D71
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Nov 2019 14:34:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kalray.eu header.i=@kalray.eu header.b="CWih9Sww"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728982AbfKDOen (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 Nov 2019 09:34:43 -0500
Received: from zimbra2.kalray.eu ([92.103.151.219]:60728 "EHLO
        zimbra2.kalray.eu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727861AbfKDOen (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Nov 2019 09:34:43 -0500
Received: from localhost (localhost [127.0.0.1])
        by zimbra2.kalray.eu (Postfix) with ESMTP id 432D327E03F9;
        Mon,  4 Nov 2019 15:34:41 +0100 (CET)
Received: from zimbra2.kalray.eu ([127.0.0.1])
        by localhost (zimbra2.kalray.eu [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id iCtUtBHQ30vp; Mon,  4 Nov 2019 15:34:40 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
        by zimbra2.kalray.eu (Postfix) with ESMTP id D6B3727E08CF;
        Mon,  4 Nov 2019 15:34:40 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.10.3 zimbra2.kalray.eu D6B3727E08CF
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kalray.eu;
        s=32AE1B44-9502-11E5-BA35-3734643DEF29; t=1572878080;
        bh=pD0MUKyotGulN1CLftCO1i1SN0De2+Xqp9tO+mZ1yzE=;
        h=Date:From:To:Message-ID:MIME-Version;
        b=CWih9SwwV6LHORRDXXXP6pPflux0yx0cLlJxR+BLo4soFLw85sob1AqWHQru3BrNE
         PIKXbCb7MvKlSYyzWdZ72nZUOQ3SDPgc32sOiru96j0hrO8m2a4bwiAN4rQZ6dn8JI
         rXKUoLRWDuqUsx+/Vbc2+VKHjuIwLBUGgSmW/cTQ=
X-Virus-Scanned: amavisd-new at zimbra2.kalray.eu
Received: from zimbra2.kalray.eu ([127.0.0.1])
        by localhost (zimbra2.kalray.eu [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id DU5pN41YXiic; Mon,  4 Nov 2019 15:34:40 +0100 (CET)
Received: from zimbra2.kalray.eu (localhost [127.0.0.1])
        by zimbra2.kalray.eu (Postfix) with ESMTP id A0FD827E0868;
        Mon,  4 Nov 2019 15:34:40 +0100 (CET)
Date:   Mon, 4 Nov 2019 15:34:40 +0100 (CET)
From:   Marta Rybczynska <mrybczyn@kalray.eu>
To:     Christoph Hellwig <hch@lst.de>
Cc:     Charles Machalow <csm10495@gmail.com>,
        linux-nvme <linux-nvme@lists.infradead.org>,
        kbusch <kbusch@kernel.org>, axboe <axboe@fb.com>,
        Sagi Grimberg <sagi@grimberg.me>,
        linux-kernel <linux-kernel@vger.kernel.org>
Message-ID: <1977598237.90293761.1572878080625.JavaMail.zimbra@kalray.eu>
In-Reply-To: <20191031133921.GA4763@lst.de>
References: <20191031050338.12700-1-csm10495@gmail.com> <20191031133921.GA4763@lst.de>
Subject: Re: [PATCH] nvme: change nvme_passthru_cmd64's result field.
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
X-Originating-IP: [192.168.40.202]
X-Mailer: Zimbra 8.8.12_GA_3794 (ZimbraWebClient - FF57 (Linux)/8.8.12_GA_3794)
Thread-Topic: nvme: change nvme_passthru_cmd64's result field.
Thread-Index: a1J64yF1pUDUpDcN+i9ToaOYAPxGqg==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



----- On 31 Oct, 2019, at 14:39, Christoph Hellwig hch@lst.de wrote:

> On Wed, Oct 30, 2019 at 10:03:38PM -0700, Charles Machalow wrote:
>> Changing nvme_passthru_cmd64's result field to be backwards compatible
>> with the nvme_passthru_cmd/nvme_admin_cmd struct in terms of the result
>> field. With this change the first 32 bits of result in either case
>> point to CQE DW0. This allows userspace tools to use the new structure
>> when using the old ADMIN/IO_CMD ioctls or new ADMIN/IO_CMD64 ioctls.
> 
> All that casting is a pretty bad idea.  please just add an explicit
> reserved field before the result, and check that it always is zero
> in the ioctl handler.

That would change the size of a structure in UAPI, won't it? 
I wanted to avoid it when adding the *64 ioctls and that's why
I added separate ones instead of extending the ones that exist.

Marta

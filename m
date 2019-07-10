Return-Path: <SRS0=5O2B=VH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 135F5C73C6D
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Jul 2019 05:26:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D597A20665
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Jul 2019 05:26:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kalray.eu header.i=@kalray.eu header.b="aqNTLf+X"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727068AbfGJF0z (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 10 Jul 2019 01:26:55 -0400
Received: from zimbra2.kalray.eu ([92.103.151.219]:38278 "EHLO
        zimbra2.kalray.eu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725932AbfGJF0z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Jul 2019 01:26:55 -0400
Received: from localhost (localhost [127.0.0.1])
        by zimbra2.kalray.eu (Postfix) with ESMTP id 7A0362BE068D;
        Wed, 10 Jul 2019 07:26:54 +0200 (CEST)
Received: from zimbra2.kalray.eu ([127.0.0.1])
        by localhost (zimbra2.kalray.eu [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id JlrKVqP9bF-r; Wed, 10 Jul 2019 07:26:47 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
        by zimbra2.kalray.eu (Postfix) with ESMTP id E23272BE0691;
        Wed, 10 Jul 2019 07:26:46 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.10.3 zimbra2.kalray.eu E23272BE0691
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kalray.eu;
        s=32AE1B44-9502-11E5-BA35-3734643DEF29; t=1562736406;
        bh=+2lMnvpoKjx0Ngf9cwUYGi4yi5g7W+P6A5+xpsO8iBY=;
        h=Date:From:To:Message-ID:MIME-Version;
        b=aqNTLf+XfRmJ9UKN6JcmU8vF/naP12Zw/pqnA9Pmg8CPQkC8CscnENMnR7foF8tP5
         UMLBS27LdDAHiBuDb+ClP9Cg07IrGoIqBhIWLN8yUVrfU0t5INts0ZsEdL3MkdhQ8G
         qA5KS5hh+I6mX2rgw/F+fHCw4Kp36lvQGzQ2+UaM=
X-Virus-Scanned: amavisd-new at zimbra2.kalray.eu
Received: from zimbra2.kalray.eu ([127.0.0.1])
        by localhost (zimbra2.kalray.eu [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id NUe8OLhz0rwc; Wed, 10 Jul 2019 07:26:46 +0200 (CEST)
Received: from zimbra2.kalray.eu (zimbra2.kalray.eu [192.168.40.202])
        by zimbra2.kalray.eu (Postfix) with ESMTP id C9F532BE0631;
        Wed, 10 Jul 2019 07:26:46 +0200 (CEST)
Date:   Wed, 10 Jul 2019 07:26:46 +0200 (CEST)
From:   Marta Rybczynska <mrybczyn@kalray.eu>
To:     Christoph Hellwig <hch@lst.de>
Cc:     Max Gurtovoy <maxg@mellanox.com>, kbusch <kbusch@kernel.org>,
        axboe <axboe@fb.com>, Sagi Grimberg <sagi@grimberg.me>,
        linux-nvme <linux-nvme@lists.infradead.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Samuel Jones <sjones@kalray.eu>,
        Jean-Baptiste Riaux <jbriaux@kalray.eu>
Message-ID: <516302383.30860772.1562736406606.JavaMail.zimbra@kalray.eu>
In-Reply-To: <20190709212904.GB9636@lst.de>
References: <1575872828.30576006.1562335512322.JavaMail.zimbra@kalray.eu> <989987da-6711-0abc-785c-6574b3bb768c@mellanox.com> <20190709212904.GB9636@lst.de>
Subject: Re: [PATCH v2] nvme: fix multipath crash when ANA desactivated
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
X-Originating-IP: [192.168.40.202]
X-Mailer: Zimbra 8.8.12_GA_3794 (ZimbraWebClient - FF57 (Linux)/8.8.12_GA_3794)
Thread-Topic: nvme: fix multipath crash when ANA desactivated
Thread-Index: 3ZiudTJo+4Xoo4yxPm7HpynQ7U2Unw==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



----- On 9 Jul, 2019, at 23:29, Christoph Hellwig hch@lst.de wrote:

> On Sat, Jul 06, 2019 at 01:06:44PM +0300, Max Gurtovoy wrote:
>>> +	/* check if multipath is enabled and we have the capability */
>>> +	if (!multipath)
>>> +		return 0;
>>> +	if (!ctrl->subsys || ((ctrl->subsys->cmic & (1 << 3)) != 0))
>>
>> shouldn't it be:
>>
>> if (!ctrl->subsys || ((ctrl->subsys->cmic & (1 << 3)) == 0))
>>
>> or
>>
>> if (!ctrl->subsys || !(ctrl->subsys->cmic & (1 << 3)))
>>
>>
>> Otherwise, you don't really do any initialization and return 0 in case you have
>> the capability, right ?
> 
> Yes.  FYI, my idea how to fix this would be something like:

Thanks both, error when changing the condition on my side. I submit the next
version very soon.

Christoph, why would you like to put the use_ana function in the header?
It isn't used anywhere else outside of that file.

Regards,
Marta

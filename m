Return-Path: <SRS0=IWld=WE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 253E7C0650F
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Aug 2019 20:34:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DB06B2173C
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Aug 2019 20:34:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=shipmail.org header.i=@shipmail.org header.b="Lf5+Mxhb"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390398AbfHHUeO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 8 Aug 2019 16:34:14 -0400
Received: from pio-pvt-msa1.bahnhof.se ([79.136.2.40]:43396 "EHLO
        pio-pvt-msa1.bahnhof.se" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390186AbfHHUeK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Aug 2019 16:34:10 -0400
Received: from localhost (localhost [127.0.0.1])
        by pio-pvt-msa1.bahnhof.se (Postfix) with ESMTP id B14B03F5D5;
        Thu,  8 Aug 2019 22:34:07 +0200 (CEST)
Authentication-Results: pio-pvt-msa1.bahnhof.se;
        dkim=pass (1024-bit key; unprotected) header.d=shipmail.org header.i=@shipmail.org header.b="Lf5+Mxhb";
        dkim-atps=neutral
X-Virus-Scanned: Debian amavisd-new at bahnhof.se
Received: from pio-pvt-msa1.bahnhof.se ([127.0.0.1])
        by localhost (pio-pvt-msa1.bahnhof.se [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id N-GpX9dXhaTB; Thu,  8 Aug 2019 22:34:06 +0200 (CEST)
Received: from mail1.shipmail.org (h-205-35.A357.priv.bahnhof.se [155.4.205.35])
        (Authenticated sender: mb878879)
        by pio-pvt-msa1.bahnhof.se (Postfix) with ESMTPA id B78203F5A8;
        Thu,  8 Aug 2019 22:34:05 +0200 (CEST)
Received: from localhost.localdomain (h-205-35.A357.priv.bahnhof.se [155.4.205.35])
        by mail1.shipmail.org (Postfix) with ESMTPSA id E0D65360301;
        Thu,  8 Aug 2019 22:34:04 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=shipmail.org; s=mail;
        t=1565296444; bh=EIk0/MUpwLpbdNkCz481ROZL1qwhrG0hJX4BjHbekd8=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=Lf5+MxhbJc+lwsstwp0LgCIZkWOVlVZhKQueAOEsO3kwvFF8OliImWzJw26HVXTf/
         PUGGY9SB6hV4Qh3dGW73STTF+vVQ5BqMuvG9UanaRrb8uTJbuZ+CSLxEvu9rTo6c1n
         mm8RZL/XZ8xyPu1syz5148DT/U61+whiMp3kL398=
Subject: Re: [PATCH 2/3] pagewalk: seperate function pointers from iterator
 data
To:     Christoph Hellwig <hch@lst.de>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     Jerome Glisse <jglisse@redhat.com>,
        Jason Gunthorpe <jgg@mellanox.com>,
        Steven Price <steven.price@arm.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
References: <20190808154240.9384-1-hch@lst.de>
 <20190808154240.9384-3-hch@lst.de>
From:   Thomas Hellstrom <thomas@shipmail.org>
Message-ID: <087f19ee-0278-b828-feb0-ff4a2c830a0f@shipmail.org>
Date:   Thu, 8 Aug 2019 22:34:04 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190808154240.9384-3-hch@lst.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/8/19 5:42 PM, Christoph Hellwig wrote:
> The mm_walk structure currently mixed data and code.  Split out the
> operations vectors into a new mm_walk_ops structure, and while we
> are changing the API also declare the mm_walk structure inside the
> walk_page_range and walk_page_vma functions.
>
> Based on patch from Linus Torvalds.
>
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---

Typo: For the patch title s/seperate/separate/

Otherwise for the series

Reviewed-by: Thomas Hellstrom <thellstrom@vmware.com>

/Thomas



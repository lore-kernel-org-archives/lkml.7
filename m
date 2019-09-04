Return-Path: <SRS0=tMFY=W7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DB020C3A5A7
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Sep 2019 13:22:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AFFFD2168B
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Sep 2019 13:22:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=shipmail.org header.i=@shipmail.org header.b="YuMj7bu6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730219AbfIDNWB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 4 Sep 2019 09:22:01 -0400
Received: from pio-pvt-msa3.bahnhof.se ([79.136.2.42]:38082 "EHLO
        pio-pvt-msa3.bahnhof.se" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729020AbfIDNWB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Sep 2019 09:22:01 -0400
Received: from localhost (localhost [127.0.0.1])
        by pio-pvt-msa3.bahnhof.se (Postfix) with ESMTP id 3F5B03F7B6;
        Wed,  4 Sep 2019 15:21:59 +0200 (CEST)
Authentication-Results: pio-pvt-msa3.bahnhof.se;
        dkim=pass (1024-bit key; unprotected) header.d=shipmail.org header.i=@shipmail.org header.b=YuMj7bu6;
        dkim-atps=neutral
X-Virus-Scanned: Debian amavisd-new at bahnhof.se
Received: from pio-pvt-msa3.bahnhof.se ([127.0.0.1])
        by localhost (pio-pvt-msa3.bahnhof.se [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id JaEMwbwikqrj; Wed,  4 Sep 2019 15:21:58 +0200 (CEST)
Received: from mail1.shipmail.org (h-205-35.A357.priv.bahnhof.se [155.4.205.35])
        (Authenticated sender: mb878879)
        by pio-pvt-msa3.bahnhof.se (Postfix) with ESMTPA id AB2613F538;
        Wed,  4 Sep 2019 15:21:57 +0200 (CEST)
Received: from localhost.localdomain (h-205-35.A357.priv.bahnhof.se [155.4.205.35])
        by mail1.shipmail.org (Postfix) with ESMTPSA id 1C21F360160;
        Wed,  4 Sep 2019 15:21:57 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=shipmail.org; s=mail;
        t=1567603317; bh=yiIBmQhIS6s0ipKjugaVe6+eubjvGH0sI0nWCFLP7rc=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=YuMj7bu680Kp7FvTxZJWVkWQxK0ymtONbkrPrLR7useEdrIv5vqWYL8/f3gnpGA8O
         46LAMwg7ZwIjG28d0UWROFVJ8Ab+P9vXQk+AM5Ma7sjgqK3BHpeOvw+yMdnsnvigq/
         bK0phgOaoY4JzjcjyPO+qmNiTYXoU7KuRF7LAChk=
Subject: Re: dma api errors with swiotlb
To:     Christoph Hellwig <hch@infradead.org>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <e3c4b2e1-7518-ab0e-a6ce-3fae9903dac0@shipmail.org>
 <20190904121722.GA15601@infradead.org>
 <4e21951d-025a-2b3d-14c8-878c6f237525@shipmail.org>
 <20190904125538.GA30177@infradead.org>
 <a78c4100-4f93-d96d-60d1-d965a7769fca@shipmail.org>
 <20190904131638.GA29164@infradead.org>
From:   =?UTF-8?Q?Thomas_Hellstr=c3=b6m_=28VMware=29?= 
        <thomas_os@shipmail.org>
Organization: VMware Inc.
Message-ID: <d7bf95a0-e4c3-f257-77f5-c384996cf7f4@shipmail.org>
Date:   Wed, 4 Sep 2019 15:21:55 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190904131638.GA29164@infradead.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/4/19 3:16 PM, Christoph Hellwig wrote:
> On Wed, Sep 04, 2019 at 03:02:14PM +0200, Thomas Hellström (VMware) wrote:
>> It looks like it does that, although when we send it, the SWIOTLB error has
>> already occured and been printed out, and then the sequence starts again.
> Well, the only way to really find out is to try.  We also have a
> backoff algorithm in the SCSI midlayer, so it should not be much of
> an inpact.  If you care about the warnings they can be disabled using
> DMA_ATTR_NO_WARN.  I have to admit that I'm not even sure the warnings
> are all that useful, but that's something you need to take up with
> the swiotlb maintainer.

Yes, I guess so. I actually think the warnings make sense, since while 
the scsi midlayer handles this nicely, other drivers competing for the 
space might not.

Thanks!
Thomas



Return-Path: <SRS0=tMFY=W7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2E63EC3A5A8
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Sep 2019 13:02:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 05CAA22CED
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Sep 2019 13:02:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=shipmail.org header.i=@shipmail.org header.b="lOQfSesj"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730250AbfIDNCT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 4 Sep 2019 09:02:19 -0400
Received: from pio-pvt-msa1.bahnhof.se ([79.136.2.40]:53638 "EHLO
        pio-pvt-msa1.bahnhof.se" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727929AbfIDNCS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Sep 2019 09:02:18 -0400
Received: from localhost (localhost [127.0.0.1])
        by pio-pvt-msa1.bahnhof.se (Postfix) with ESMTP id CBEA540D93;
        Wed,  4 Sep 2019 15:02:16 +0200 (CEST)
Authentication-Results: pio-pvt-msa1.bahnhof.se;
        dkim=pass (1024-bit key; unprotected) header.d=shipmail.org header.i=@shipmail.org header.b="lOQfSesj";
        dkim-atps=neutral
X-Virus-Scanned: Debian amavisd-new at bahnhof.se
Received: from pio-pvt-msa1.bahnhof.se ([127.0.0.1])
        by localhost (pio-pvt-msa1.bahnhof.se [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id z32uQ1aYt2-F; Wed,  4 Sep 2019 15:02:15 +0200 (CEST)
Received: from mail1.shipmail.org (h-205-35.A357.priv.bahnhof.se [155.4.205.35])
        (Authenticated sender: mb878879)
        by pio-pvt-msa1.bahnhof.se (Postfix) with ESMTPA id 6DA443F9C0;
        Wed,  4 Sep 2019 15:02:15 +0200 (CEST)
Received: from localhost.localdomain (h-205-35.A357.priv.bahnhof.se [155.4.205.35])
        by mail1.shipmail.org (Postfix) with ESMTPSA id C917B360160;
        Wed,  4 Sep 2019 15:02:14 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=shipmail.org; s=mail;
        t=1567602134; bh=MvNSj1oBbf5yDVt6vl8OTStVRE6Cxf5Kr2v1clBeS3s=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=lOQfSesj4F9e/SyKkd9cWVmh6BZ9kRI6seG0hvKEFTfmnivFdA65vHBv0p8gFRs/W
         aPQKhOERbALQYAN2NW1CQE5R19MCLF7NBvkzmI475qS0X+CCmrZTk0ZPIMCGoGAvhW
         iicJiTl2WtRTYXi87uWUqBZn4u+os8RxaWxChadA=
Subject: Re: dma api errors with swiotlb
To:     Christoph Hellwig <hch@infradead.org>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <e3c4b2e1-7518-ab0e-a6ce-3fae9903dac0@shipmail.org>
 <20190904121722.GA15601@infradead.org>
 <4e21951d-025a-2b3d-14c8-878c6f237525@shipmail.org>
 <20190904125538.GA30177@infradead.org>
From:   =?UTF-8?Q?Thomas_Hellstr=c3=b6m_=28VMware=29?= 
        <thomas_os@shipmail.org>
Organization: VMware Inc.
Message-ID: <a78c4100-4f93-d96d-60d1-d965a7769fca@shipmail.org>
Date:   Wed, 4 Sep 2019 15:02:14 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190904125538.GA30177@infradead.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/4/19 2:55 PM, Christoph Hellwig wrote:
> On Wed, Sep 04, 2019 at 02:54:26PM +0200, Thomas Hellström (VMware) wrote:
>> On 9/4/19 2:17 PM, Christoph Hellwig wrote:
>>> A call to dma_max_mapping_size() to limit the maximum I/O size solves
>>> that problem.  With the latest kernel that should actually be done
>>> automatically by the SCSI midlayer for you.
>> Hmm, OK. I guess with a sufficient queue depth and many mappings waiting for
>> DMA completion, the SWIOTLB may fill up anyway...
>>
>> I'll see if I can come up with something.
> You are supposed to return SCSI_MLQUEUE_HOST_BUSY in that case,
> which means that the kernel won't send more commands until another
> one completed.

It looks like it does that, although when we send it, the SWIOTLB error 
has already occured and been printed out, and then the sequence starts 
again.

Seems like the most effective way to stop it is to decrease the queue depth.

/Thomas



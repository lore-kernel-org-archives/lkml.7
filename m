Return-Path: <SRS0=tMFY=W7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AC187C3A5A8
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Sep 2019 07:59:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 61F9720820
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Sep 2019 07:59:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=shipmail.org header.i=@shipmail.org header.b="IQ61v1gT"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729235AbfIDH7L (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 4 Sep 2019 03:59:11 -0400
Received: from ste-pvt-msa2.bahnhof.se ([213.80.101.71]:1160 "EHLO
        ste-pvt-msa2.bahnhof.se" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728909AbfIDH7L (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Sep 2019 03:59:11 -0400
Received: from localhost (localhost [127.0.0.1])
        by ste-pvt-msa2.bahnhof.se (Postfix) with ESMTP id 0DE733F5F0;
        Wed,  4 Sep 2019 09:59:10 +0200 (CEST)
Authentication-Results: ste-pvt-msa2.bahnhof.se;
        dkim=pass (1024-bit key; unprotected) header.d=shipmail.org header.i=@shipmail.org header.b=IQ61v1gT;
        dkim-atps=neutral
X-Virus-Scanned: Debian amavisd-new at bahnhof.se
Authentication-Results: ste-ftg-msa2.bahnhof.se (amavisd-new);
        dkim=pass (1024-bit key) header.d=shipmail.org
Received: from ste-pvt-msa2.bahnhof.se ([127.0.0.1])
        by localhost (ste-ftg-msa2.bahnhof.se [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id VlwumVT_5Fq4; Wed,  4 Sep 2019 09:59:09 +0200 (CEST)
Received: from mail1.shipmail.org (h-205-35.A357.priv.bahnhof.se [155.4.205.35])
        (Authenticated sender: mb878879)
        by ste-pvt-msa2.bahnhof.se (Postfix) with ESMTPA id BEF383F346;
        Wed,  4 Sep 2019 09:59:08 +0200 (CEST)
Received: from localhost.localdomain (h-205-35.A357.priv.bahnhof.se [155.4.205.35])
        by mail1.shipmail.org (Postfix) with ESMTPSA id 847A536117F;
        Wed,  4 Sep 2019 09:59:08 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=shipmail.org; s=mail;
        t=1567583948; bh=u13FcfsPPB+rHX6dHh07axBYmf9RAYcEXi36fo/oS+E=;
        h=To:Cc:From:Subject:Date:From;
        b=IQ61v1gTFy6dWmoVldP8ckGJ3X2qWRd+BKgDVG3BVpcHQy5IONzEICcwffHpL5pEl
         ciM4ra7cN3gxcTvsHkXON0Ol7lKJ7hsK8OVCKMSDUSBnFj2HZNtX9X0FzH0+adWEBA
         R0JNPmR1kyNo1bykPHpgzj0ZzCC37gdLTILuy1Zk=
To:     Christoph Hellwig <hch@infradead.org>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
From:   =?UTF-8?Q?Thomas_Hellstr=c3=b6m_=28VMware=29?= 
        <thomas_os@shipmail.org>
Subject: dma api errors with swiotlb
Organization: VMware Inc.
Message-ID: <e3c4b2e1-7518-ab0e-a6ce-3fae9903dac0@shipmail.org>
Date:   Wed, 4 Sep 2019 09:59:08 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, Cristoph.

Another DMA related question before I start to post patches in this area 
again..

Our virtual SCSI device (which BTW is fully DMA compliant) has a large 
queue depth and therefore runs out of SWIOTLB space => The scsi middle 
layer behaves nicely and asks the driver to retry the dma mapping 
operation. All fine.

The problem is that while this happens, the kernel log spits out a 
number of dma- and SWIOTLB errors, which are really harmless.

While one could probably just say go and increase the SWIOTLB size, but 
on some systems that might not be doable.

We could reduce the queue depth when SEV is active, which is probably 
one of those hacky solutions you dislike.

We could silence the dma- and swiotlb errors? At least selectively for 
some devices?

Do you have any guidance into the best solution here?

Thanks,
Thomas.







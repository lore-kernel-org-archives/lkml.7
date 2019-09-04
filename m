Return-Path: <SRS0=tMFY=W7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C700CC3A5A7
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Sep 2019 12:54:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8EB412073F
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Sep 2019 12:54:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=shipmail.org header.i=@shipmail.org header.b="nsrFer4N"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729950AbfIDMya (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 4 Sep 2019 08:54:30 -0400
Received: from ste-pvt-msa1.bahnhof.se ([213.80.101.70]:22688 "EHLO
        ste-pvt-msa1.bahnhof.se" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725965AbfIDMya (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Sep 2019 08:54:30 -0400
Received: from localhost (localhost [127.0.0.1])
        by ste-pvt-msa1.bahnhof.se (Postfix) with ESMTP id 953AD3F6BF;
        Wed,  4 Sep 2019 14:54:28 +0200 (CEST)
Authentication-Results: ste-pvt-msa1.bahnhof.se;
        dkim=pass (1024-bit key; unprotected) header.d=shipmail.org header.i=@shipmail.org header.b=nsrFer4N;
        dkim-atps=neutral
X-Virus-Scanned: Debian amavisd-new at bahnhof.se
Received: from ste-pvt-msa1.bahnhof.se ([127.0.0.1])
        by localhost (ste-pvt-msa1.bahnhof.se [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id BVSgqDGQCpuw; Wed,  4 Sep 2019 14:54:27 +0200 (CEST)
Received: from mail1.shipmail.org (h-205-35.A357.priv.bahnhof.se [155.4.205.35])
        (Authenticated sender: mb878879)
        by ste-pvt-msa1.bahnhof.se (Postfix) with ESMTPA id 69C7A3F6A7;
        Wed,  4 Sep 2019 14:54:26 +0200 (CEST)
Received: from localhost.localdomain (h-205-35.A357.priv.bahnhof.se [155.4.205.35])
        by mail1.shipmail.org (Postfix) with ESMTPSA id A7CB7360160;
        Wed,  4 Sep 2019 14:54:26 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=shipmail.org; s=mail;
        t=1567601666; bh=upzIZSLLF6duTN76hVSfhKtMddKOA3X3vki43QO64y0=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=nsrFer4N1Lg3tAVhzg80ql6321PSBah+sDckVQAilsxXlTvvs1CZgE9WsJT3iClYB
         +Zhag++W127Yry/WQq+rAcBWBTBmUsH4mlEKJOFidWAFnHi5tTyxT4Vd7V3v3oKkGs
         WoBs1AKqcozTOQ60/PYSQHqg+1qKp67H9Nhek/x8=
Subject: Re: dma api errors with swiotlb
To:     Christoph Hellwig <hch@infradead.org>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <e3c4b2e1-7518-ab0e-a6ce-3fae9903dac0@shipmail.org>
 <20190904121722.GA15601@infradead.org>
From:   =?UTF-8?Q?Thomas_Hellstr=c3=b6m_=28VMware=29?= 
        <thomas_os@shipmail.org>
Organization: VMware Inc.
Message-ID: <4e21951d-025a-2b3d-14c8-878c6f237525@shipmail.org>
Date:   Wed, 4 Sep 2019 14:54:26 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190904121722.GA15601@infradead.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/4/19 2:17 PM, Christoph Hellwig wrote:
> A call to dma_max_mapping_size() to limit the maximum I/O size solves
> that problem.  With the latest kernel that should actually be done
> automatically by the SCSI midlayer for you.

Hmm, OK. I guess with a sufficient queue depth and many mappings waiting 
for DMA completion, the SWIOTLB may fill up anyway...

I'll see if I can come up with something.

Thanks,

Thomas



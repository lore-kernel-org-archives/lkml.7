Return-Path: <SRS0=Q+aa=S3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 37335C43219
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Apr 2019 14:31:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 277B720679
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Apr 2019 14:31:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=mev.co.uk header.i=@mev.co.uk header.b="JZJzO+mE"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726961AbfDYObF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Apr 2019 10:31:05 -0400
Received: from smtp65.ord1d.emailsrvr.com ([184.106.54.65]:39878 "EHLO
        smtp65.ord1d.emailsrvr.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725959AbfDYObF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Apr 2019 10:31:05 -0400
Received: from smtp9.relay.ord1d.emailsrvr.com (localhost [127.0.0.1])
        by smtp9.relay.ord1d.emailsrvr.com (SMTP Server) with ESMTP id E5492C0289;
        Thu, 25 Apr 2019 10:31:03 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=mev.co.uk;
        s=20190130-41we5z8j; t=1556202663;
        bh=w18i9e5QU9exjC8EuByjFALVjeh17EI57d2TFOrUF90=;
        h=Subject:To:From:Date:From;
        b=JZJzO+mE7htKl4IHFy1AskJ48Fb1Ix37C0eA9c85Weu+N43zNibb6jlIgToS4nMUh
         PDGXuYf+Dl4xLuKupT9CyrDcrpYSjnRTqNCfrA7owsaUFhJb1E6MeRoE/gVgGbN8yy
         CSdkQ3WxzSxNfbdAG5pfD3/5LBPevrAD/RV0pkMQ=
X-Auth-ID: abbotti@mev.co.uk
Received: by smtp9.relay.ord1d.emailsrvr.com (Authenticated sender: abbotti-AT-mev.co.uk) with ESMTPSA id BB782C0291;
        Thu, 25 Apr 2019 10:31:02 -0400 (EDT)
X-Sender-Id: abbotti@mev.co.uk
Received: from [10.0.0.62] (remote.quintadena.com [81.133.34.160])
        (using TLSv1.2 with cipher AES128-SHA)
        by 0.0.0.0:465 (trex/5.7.12);
        Thu, 25 Apr 2019 10:31:03 -0400
Subject: Re: [PATCH] dma-mapping: remove an unnecessary NULL check
To:     Christoph Hellwig <hch@lst.de>
Cc:     Dan Carpenter <dan.carpenter@oracle.com>,
        Jiri Slaby <jslaby@suse.com>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Robin Murphy <robin.murphy@arm.com>,
        iommu@lists.linux-foundation.org,
        "kernel-janitors@vger.kernel.org H Hartley Sweeten" 
        <hsweeten@visionengravers.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org
References: <20190424142437.GA29490@mwanda> <20190424142743.GC20974@lst.de>
 <3142dc82-1d4c-5f01-678e-628038d86bd6@mev.co.uk>
 <20190425141832.GA16643@lst.de>
From:   Ian Abbott <abbotti@mev.co.uk>
Organization: MEV Ltd.
Message-ID: <ab71b3ad-c737-82ed-5727-9f4382569b4b@mev.co.uk>
Date:   Thu, 25 Apr 2019 15:31:01 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190425141832.GA16643@lst.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 25/04/2019 15:18, Christoph Hellwig wrote:
> On Thu, Apr 25, 2019 at 03:13:49PM +0100, Ian Abbott wrote:
>> So for comedi_isadma, we can just replace the NULL with a pointer to a
>> static dummy device with a 24-bit coherent mask?
> 
> It should be converted to a proper isa_driver, so that it gets a real
> struct device.

But it will work as a short term solution?  comedi_isadma isn't a 
driver, but is used by a few comedi drivers for ISA cards.

-- 
-=( Ian Abbott <abbotti@mev.co.uk> || Web: www.mev.co.uk )=-
-=( MEV Ltd. is a company registered in England & Wales. )=-
-=( Registered number: 02862268.  Registered address:    )=-
-=( 15 West Park Road, Bramhall, STOCKPORT, SK7 3JZ, UK. )=-

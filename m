Return-Path: <SRS0=BPXs=SN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E51A2C10F13
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Apr 2019 21:38:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AFAC22146F
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Apr 2019 21:38:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="ZNzrxnG/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726937AbfDKViF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 11 Apr 2019 17:38:05 -0400
Received: from esa1.hgst.iphmx.com ([68.232.141.245]:42154 "EHLO
        esa1.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726655AbfDKViF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Apr 2019 17:38:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1555018684; x=1586554684;
  h=from:subject:to:cc:references:message-id:date:
   mime-version:in-reply-to:content-transfer-encoding;
  bh=NtI2VCs09OfggKYynEKfYppzyRx311u5nZ4KBIOzIW8=;
  b=ZNzrxnG/Z7DQPP6sjeHKN1FNIn4YNVDqeqPHLdq0gmYQC3IkQsNPxYAA
   RORJDDCrTU2TztyVtp/AxqahRAfLd6MVdl5MCYlkWJLVncMB4O3GL4gAA
   AP1qqy9F0ThrRbDDcXf1M4rJ/gyGqrDSeN10wkkVzN5WPLS3s1b43mDDT
   t+GJqDVK8F5PpTMj9O2MfrgMg/6tOa0eXeZ9xD6PXii2+Uh4hQ6pWSKrn
   QrCy2LB3vkf/TKSGtB4ghXf9VCRvI0f4OBZPSjlq5A5ldEoLVwBLuNa1O
   FNpY0MaE6gBOgrkTXawAVii7WKlN9qSl3kASwmEksNurtz13hY6IUCWDJ
   A==;
X-IronPort-AV: E=Sophos;i="5.60,338,1549900800"; 
   d="scan'208";a="211425449"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 12 Apr 2019 05:38:04 +0800
IronPort-SDR: pximnqMPvSY/SL6Qyo7DpTMrPPmX822ly+IHjGQ+bsm/8EgY3bdgnS0cegVuN0bwZyzTDR8M+x
 x4bZgbDD3um6TQzOpRpv0VF8iBUuOzEttbDsod0IVLHcxF6mKJD0Tgtx3rSwMmwhim+zRbg0Cv
 x27qmTepIf5ce+Qf+8IORB5MMqaMlaQSnsnGdEyneSiL/6vmKNzZYcYX40EA/FON7b0Oalb1Ll
 MiCa1lXuvnOT3gV9y/NDFzHywuoOAXScKJO1pM19WsLKxB4SPYQStwiyV+74w9F6FDiy/M5Gay
 SNAhN+Fbr4mtvxjremkQdGJ5
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep01.wdc.com with ESMTP; 11 Apr 2019 14:14:57 -0700
IronPort-SDR: oFMBs+ixy3Mxisl+X4Lv2ip0TCwJpkuq8TKEsIcw9gml3/WDhk/75Kf3oMq4vG8YFukkBtsmwj
 sye+UQCyG6Xjv62LzqAplZnWWkmD7zI0+EUhgDyJalpQyyBShs/foVV6S2zFWDLawDJkFWj1jR
 0Ylz2OBO4eu2va+BT8lnAbglWAwqpL7KxGgWJqXlnZWVY7phcyMLL8lhO2x1VtXVwn13FiZdOl
 Xl5rXsw4VE1uk4zoe0oPkb8zh2Bb/5BLhAOusJpFKuf9COGOlQA+iFvKbpiv2DkgrCAm6SxFxS
 egg=
Received: from usa001883.ad.shared (HELO [10.86.51.17]) ([10.86.51.17])
  by uls-op-cesaip01.wdc.com with ESMTP; 11 Apr 2019 14:38:03 -0700
From:   Atish Patra <atish.patra@wdc.com>
Subject: Re: [PATCH 1/6] arch: riscv: add support for building DTB files from
 DT source data
To:     Christoph Hellwig <hch@infradead.org>,
        Paul Walmsley <paul.walmsley@sifive.com>
Cc:     "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        Paul Walmsley <paul@pwsan.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Palmer Dabbelt <palmer@sifive.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-riscv@lists.infradead.org" <linux-riscv@lists.infradead.org>
References: <20190411084304.5072-2-paul.walmsley@sifive.com>
 <20190411114616.GA10032@infradead.org>
Message-ID: <b1f10ff7-6c45-1468-c97c-ff301bb66966@wdc.com>
Date:   Thu, 11 Apr 2019 14:38:02 -0700
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.14; rv:60.0)
 Gecko/20100101 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190411114616.GA10032@infradead.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/11/19 4:46 AM, Christoph Hellwig wrote:
> On Thu, Apr 11, 2019 at 01:42:59AM -0700, Paul Walmsley wrote:
>> Similar to ARM64, add support for building DTB files from DT source
>> data for RISC-V boards.
>>
>> This patch starts with the infrastructure needed for SiFive boards.
>> Boards from other vendors would add support here in a similar form.
> 
> What do we build it for?  We'd really need something like this:
> 
> http://git.infradead.org/users/hch/misc.git/commitdiff/d6242aa147baf57e05e2932199c74d8d24b9926e
> http://git.infradead.org/users/hch/misc.git/commitdiff/0cd5413c8094ab57b68e0629dacfed695f4c1ef1
> 
> To actually use the DT files.
> 

We also need to modify the DT, as the default DTS file in this patch 
series has hart0 status as "okay",

Or we should set hart0 status as "masked" in the .dts file now.

Regards,
Atish
> _______________________________________________
> linux-riscv mailing list
> linux-riscv@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-riscv
> 



Return-Path: <SRS0=M1fl=TR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 458EDC04AB4
	for <linux-kernel@archiver.kernel.org>; Fri, 17 May 2019 19:01:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 12D9F20848
	for <linux-kernel@archiver.kernel.org>; Fri, 17 May 2019 19:01:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="nor/VvRW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727880AbfEQTBt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 17 May 2019 15:01:49 -0400
Received: from esa6.hgst.iphmx.com ([216.71.154.45]:54647 "EHLO
        esa6.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726293AbfEQTBs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 May 2019 15:01:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1558119709; x=1589655709;
  h=subject:to:cc:references:from:message-id:date:
   mime-version:in-reply-to:content-transfer-encoding;
  bh=sCHcqEnJzvTT1HQ3nCB58qYi8YhUS/CBmEQC9NnNdhw=;
  b=nor/VvRW6QPxLy4bMwbwSn3Gi1vOCVmSKF6geTP1qXE4xFx1r4Fc07tl
   DWVVSyTBny3CWM0cFW+2/Ey8Gh1SErR7aPKR6aBaZ7eG/NnNCVIR4jlm8
   QIyX7joLds3h7czoFvEDRGq04Q852kzTRciTjzvlcj0OufN/yOgIOjt8D
   494pSMS10ryQYixx/jkFHCxPvtzAjtWgJBSgwBzgxFN+0BzVh2VM63x+/
   bnlbt7Rdk2Dp5yZMldsLhlI3xBBUUMqFZHEL1HZ5hJdc1WI53BUzSJSn9
   lfyyvBAMZeCP3woK0U29AbGe3boP2HXMwIIS+MQWhOgBEe7zlkF7rH8q2
   A==;
X-IronPort-AV: E=Sophos;i="5.60,481,1549900800"; 
   d="scan'208";a="110234059"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 18 May 2019 03:01:48 +0800
IronPort-SDR: XGJtbrv01eKlBOw/5PDXS1C43hjFtduMAVejp6s3geoT17gSVnsxPn2uQ6qBuKX070PvVXM0La
 wwLJzwiZ2iWf+ighkihF0K3iUZ64ibBYcLTWXeDeOuapLw7Doflb9Ch8FpC5rxLeFutr70XjBJ
 /3QDxhNiKKPEwDRmpkG81KIBqHtxRsbXo1En67UbQS49b0KlaxeX/uGELhA8RUv6zIAcp1fIuu
 oSMzU2ulkjNLWP079O72NvpuqSeKYr1xwARlWEz6G2D7YLBE6udCLussWeTg4Mp2w+vvnY6P4L
 tNaZEULsIpIc0qg0i62aFgt0
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP; 17 May 2019 11:37:19 -0700
IronPort-SDR: Gu7q0xAdL22XcBU/yPn/+JDD88Iu4XRdgU+EV6wulb5SqSKv19ICR1lonDFOjrdpIwtlS7B9tI
 XVbnajdmVvoGWxmqt6qEXlO5rcWvN/q7Eh/y8cMV07uveDWi9O2aoxh2y1Ea284gcrHe00Sxlz
 WcyfjAXg0A9QGZOswE9zJwCdnybPxRq/TiSklrAL8tNdFnMO5VmFkC9g3bvEm5UD3oY6dHBYfw
 MNI81DExSLt8zytIpglwz2NUbY6wuyQu3JVLb2X17VvPqZC39q7e01ZIImcr2H3MHyW4viTQvk
 pwo=
Received: from cnf000212.ad.shared (HELO [10.86.56.27]) ([10.86.56.27])
  by uls-op-cesaip02.wdc.com with ESMTP; 17 May 2019 12:01:48 -0700
Subject: Re: [v2 PATCH] RISC-V: Add a PE/COFF compliant Image header.
To:     Paul Walmsley <paul.walmsley@sifive.com>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Anup Patel <anup@brainfault.org>,
        Palmer Dabbelt <palmer@sifive.com>,
        Zong Li <zong@andestech.com>,
        "merker@debian.org" <merker@debian.org>,
        "linux-riscv@lists.infradead.org" <linux-riscv@lists.infradead.org>
References: <20190501195607.32553-1-atish.patra@wdc.com>
 <alpine.DEB.2.21.9999.1905171017510.9104@viisi.sifive.com>
From:   Atish Patra <atish.patra@wdc.com>
Message-ID: <e71f11f1-4c48-342c-a718-de5f14de4c36@wdc.com>
Date:   Fri, 17 May 2019 12:00:22 -0700
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.14; rv:60.0)
 Gecko/20100101 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <alpine.DEB.2.21.9999.1905171017510.9104@viisi.sifive.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 5/17/19 10:39 AM, Paul Walmsley wrote:
> 
> On Wed, 1 May 2019, Atish Patra wrote:
> 
>> Currently, last stage boot loaders such as U-Boot can accept only
>> uImage which is an unnecessary additional step in automating boot flows.
>>
>> Add a PE/COFF compliant image header that boot loaders can parse and
>> directly load kernel flat Image. The existing booting methods will continue
>> to work as it is.
> 
> One other thought: as I think you or someone else may have pointed out,
> this isn't the PE/COFF header itself, but rather an ersatz DOS stub
> header, that is apparently quite close to what some EFI bootloaders
> require.  So from that point of view, it's probably best to just write in
> the patch description that the idea is to add something that resembles an
> MS-DOS stub header, and that the motivations are that:
> 
> 1. it resembles what ARM64 is doing, and there's not much point in
> inventing another boot header format that's completely different
> 

Yup. I will add this in the next version.

> 2. it can be easily converted into an MS-DOS header that some EFI
> bootloaders apparently require, by tweaking a few bytes at the beginning
> 

I mentioned all the required changes in the proposed header to so that 
EFI bootloaders can load it directly. Probably, I will clarify it more 
to avoid confusion.


> 
> - Paul
> 


-- 
Regards,
Atish

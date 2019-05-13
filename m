Return-Path: <SRS0=lMFC=TN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9B50CC04AA7
	for <linux-kernel@archiver.kernel.org>; Mon, 13 May 2019 23:19:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6C8C3208C3
	for <linux-kernel@archiver.kernel.org>; Mon, 13 May 2019 23:19:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="o9BLw/Vm"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726635AbfEMXTO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 13 May 2019 19:19:14 -0400
Received: from esa3.hgst.iphmx.com ([216.71.153.141]:17019 "EHLO
        esa3.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726466AbfEMXTN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 May 2019 19:19:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1557789553; x=1589325553;
  h=subject:to:cc:references:from:message-id:date:
   mime-version:in-reply-to:content-transfer-encoding;
  bh=j9JSv3iEB6Xovwkc3ROUtt6XNLJIN55oc6Y7C+ZA8SU=;
  b=o9BLw/VmEtVu4qtEpgnvkL5GAqyCvdRUQgctvo+nrGI69Q7KBnyLVff8
   gfUPF+YDF36BUzW6eHBXpyLiC5UCEiX29hTEYcrUmG1zg+BYbxYj4j6W6
   AcEZUgmFUk8dIRIptd3a289orF7lgyLAp+GhmKMyYZl5eoZduGqPh7Lk3
   khSoRYOBMoEcFk7Uxy0GGHsdB65LndTMzokT92sL3PX7ZS5opHTYIL4Jo
   pN+xa5iRE1u4cejjWV6b1ksX0N0aHD/dQ2i3M054ycoh1SZqE7KgXLxvU
   HxLJth2q5upz0saA7hV6arhhZz2HmGyagoG3y0wfdgqkhnghMDzB04vgh
   Q==;
X-IronPort-AV: E=Sophos;i="5.60,466,1549900800"; 
   d="scan'208";a="113120665"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 14 May 2019 07:19:13 +0800
IronPort-SDR: j3cb0+6N1NG68qBQUPRxe8sjuhfSMpLDG2DU5upc3eAmxdcjWslYQU8qAOb6W9EWnzOHS0D6+P
 znVqVvNOu4Whr/U6AjnwIVMIznJe5sGLwDT1jUXVTdvheOUp7qNQtyRL8qOc+4zGiJ5VaOOhfh
 61p+rr5EscSWFnpPbKvwcfNovGDpjDcOUo+8iFqFSTMvL7RAYeU6lFlQneOrXA00XKuxwIFjxj
 KTrr3updcpoijEfKEHXdK74Pj87+rhsPL404OYATSOoFDOizuERCSYTqu1jQlP+lS4PTJU7IvM
 Pmz/49WWKiUoZKICyO/ITTF2
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep01.wdc.com with ESMTP; 13 May 2019 15:55:02 -0700
IronPort-SDR: 06Vi4gpOH0QgWmrXi+crv4qvXN/E/M6EWSeTgIr1Nuj03KINks0d3wWRouT3Cg6AeCPCjeOpSe
 a9ryK1V/QL9WoAcWNNPPYZisvZ+CiUTrFefNyFGj+g+w/gR+Mo6PYWZzA0NPyypb7JFVlfgVBT
 P/D8XYORs0aQH78XTZX2gLag83NTh+FkWe2ShRBV83AE0iCONJke+NbH4xQ6HMTS7RjBsiKtEx
 w9qifSCTY1n1OPREgE3nZUtb1y4Tt9/0zehYtgCFxYN0nkhT7H9xaY1CLzO9XSzShtrw5B/s8X
 Vic=
Received: from r6220.sdcorp.global.sandisk.com (HELO [192.168.1.6]) ([10.196.157.143])
  by uls-op-cesaip01.wdc.com with ESMTP; 13 May 2019 16:19:12 -0700
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
 <alpine.DEB.2.21.9999.1905131522370.21198@viisi.sifive.com>
From:   Atish Patra <atish.patra@wdc.com>
Message-ID: <a498967c-cdc8-637a-340b-202d216c5360@wdc.com>
Date:   Mon, 13 May 2019 16:18:47 -0700
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.14; rv:60.0)
 Gecko/20100101 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <alpine.DEB.2.21.9999.1905131522370.21198@viisi.sifive.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 5/13/19 3:31 PM, Paul Walmsley wrote:
> On Wed, 1 May 2019, Atish Patra wrote:
> 
>> Currently, last stage boot loaders such as U-Boot can accept only
>> uImage which is an unnecessary additional step in automating boot flows.
>>
>> Add a PE/COFF compliant image header that boot loaders can parse and
>> directly load kernel flat Image. The existing booting methods will continue
>> to work as it is.
>>
>> Another goal of this header is to support EFI stub for RISC-V in future.
>> EFI specification needs PE/COFF image header in the beginning of the kernel
>> image in order to load it as an EFI application. In order to support
>> EFI stub, code0 should be replaced with "MZ" magic string and res5(at
>> offset 0x3c) should point to the rest of the PE/COFF header (which will
>> be added during EFI support).
>>
>> Tested on both QEMU and HiFive Unleashed using OpenSBI + U-Boot + Linux.
>>
>> Signed-off-by: Atish Patra <atish.patra@wdc.com>
> 
> Seems like we're stuck with this basic format for EFI, etc.  Even though
> we may be stuck with it, I think we should take the opportunity to add the
> possibility to extending this header format by adding fields after the
> basic PE/COFF header ends.
> 
> In particular, at the very least, I'd suggest adding a u32 after the
> PE/COFF header ends, to represent a "RISC-V header format version number".
> Then if we add more fields that follow the PE/COFF header -- for example,
> to represent the RISC-V instruction set extensions that are required to
> run this binary -- we can just bump that RISC-V-specific version number
> field to indicate to bootloaders that there's more there.
> 
That would be inventing our RISC-V specific header format. However, we 
can always use the one of the reserved fields in proposed header (res4) 
for this purpose.

Do we need to add it now or add it later when we actually need a version 
number. My preference is to add it later based on requirement.

> One other observation - if what's here was copied from some other
> architecture, like ARM, please acknowledge the source in the patch
> description.
> 

Sure. I will update the patch.

Regards,
Atish
> thanks
> 
> - Paul
> 


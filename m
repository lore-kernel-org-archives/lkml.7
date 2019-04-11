Return-Path: <SRS0=BPXs=SN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9A964C10F13
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Apr 2019 18:14:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 659C52084D
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Apr 2019 18:14:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="S+q4HEJd"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726777AbfDKSOR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 11 Apr 2019 14:14:17 -0400
Received: from esa2.hgst.iphmx.com ([68.232.143.124]:52670 "EHLO
        esa2.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726538AbfDKSOQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Apr 2019 14:14:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1555006457; x=1586542457;
  h=subject:to:cc:references:from:message-id:date:
   mime-version:in-reply-to:content-transfer-encoding;
  bh=TA1nweJzazRcI8nGG0xaae8sgqSHrilFQeoJtWiH2Y8=;
  b=S+q4HEJdLGDC+LGyh+J/4YLaNRr7n+F9Q8/cSFBCrFaCMyUwCPQIjjEX
   Txqr9v8yKgMzkPwuKSXdmvVu/0DdoyvNrC5dSDPGmIOspYlPVDIplujSC
   GrqbCD6DUhq+4oVz0PHKbCwSuBgHHtFlhceWK4XBnrg2L+WfmPdE/s4Kh
   QCinwoHgFSi7SSdSVg793g+p3GzcNkUf6kqEDOEcCBu6zIQ4EB8gZjKFF
   GQw7urfGv4LWPPP6IUsVabM5Xhjpgv6OzXP54IipmkuS8+dDnFmsRDl6A
   u6kjKR11kzSigPFaIcfbNv3vNc2Z/2QpGiZWSdbNH3iJoL9bUqX1SSJnM
   Q==;
X-IronPort-AV: E=Sophos;i="5.60,338,1549900800"; 
   d="scan'208";a="204574358"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 12 Apr 2019 02:14:10 +0800
IronPort-SDR: ijQhTNZjDFqgqAnS3VY2Nem3JvEDlFzV+iul+1w4tHde89Lh14kUYMFWj5Cwt8hvsBFUN/p/xQ
 7lUr/HccH8hV20lmFg+9DdT+ilIFgyPKgka+HID8LmhgTmHs52IPDwj0ZfCSyTk5Jj+pW3LmDU
 KK22LTMwyNgdDcyV/3LDhmj4JdmE4mST7nQ69vRGKNjIqVdpmKnLJAb+PMUtXaKxKHhbglgavO
 94bzrxTkGVUm0Iz8X1Zp5bPzV3cs5iLpOICnvr3i6mSzRdUEPB/930PAMqGt4yRZ2pyMbx8sX8
 ildTM8Z7VB9DN3CIaDKyvnkp
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP; 11 Apr 2019 10:51:02 -0700
IronPort-SDR: ElvWdcaZMzVpcsef1OmngfWr+osjSLfdQXNLcrk/lNFkajTJlJZd9dBiZfXJkXZGHKYkAVSABB
 3LrXyxlWwgw9YtCu7ox59/ZX0UKof7p/fxMhFG4nipAy6B9o1KZlR2FJh2+zKNJpvhpLcc6vhH
 kUZEYx5bw4p54PBMkwmLGIvLEOzQe+2BiYaOU2UaaT7Ly5hQMulH0F/FiSV5YoRAE0B977Ijse
 I1qsLZIf5xMfwldJONebJi86MKM/W2gR7Syqf6BRVVNW32yi3ybGr7f9+vS34/8RJ3rM7XRPd7
 19Y=
Received: from r6220.sdcorp.global.sandisk.com (HELO [192.168.1.6]) ([10.196.157.143])
  by uls-op-cesaip02.wdc.com with ESMTP; 11 Apr 2019 11:14:10 -0700
Subject: Re: [PATCH v2 2/4] RISC-V: Fix of_get_cpu_node usage
To:     Christoph Hellwig <hch@infradead.org>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Andreas Schwab <schwab@suse.de>,
        Anup Patel <anup@brainfault.org>,
        Dmitriy Cherkasov <dmitriy@oss-tech.org>,
        Johan Hovold <johan@kernel.org>,
        "linux-riscv@lists.infradead.org" <linux-riscv@lists.infradead.org>,
        Palmer Dabbelt <palmer@sifive.com>,
        Paul Walmsley <paul.walmsley@sifive.com>
References: <20190410230443.15729-1-atish.patra@wdc.com>
 <20190410230443.15729-3-atish.patra@wdc.com>
 <20190411065904.GC29422@infradead.org>
From:   Atish Patra <atish.patra@wdc.com>
Message-ID: <2c078b17-625b-b3d0-7914-9cb2d05580e2@wdc.com>
Date:   Thu, 11 Apr 2019 11:14:09 -0700
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.14; rv:60.0)
 Gecko/20100101 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190411065904.GC29422@infradead.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/10/19 11:59 PM, Christoph Hellwig wrote:
> On Wed, Apr 10, 2019 at 04:04:41PM -0700, Atish Patra wrote:
>> of_get_cpu_node expects a logical cpu id not a hartid.
> 
> But only because you changed that with your patch 1, so it should
> be folded into that.
> 

Yes. I should merge this to patch 1. Otherwise, git bisect will have 
issues later with patch 1.

Regards,
Atish

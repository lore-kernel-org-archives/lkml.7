Return-Path: <SRS0=E/6H=U3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2C869C5B57A
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Jun 2019 16:37:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 058E7208E3
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Jun 2019 16:37:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="JCidRKGf"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726835AbfF1QhP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 28 Jun 2019 12:37:15 -0400
Received: from esa1.hgst.iphmx.com ([68.232.141.245]:14887 "EHLO
        esa1.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726618AbfF1QhO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Jun 2019 12:37:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1561739834; x=1593275834;
  h=subject:to:cc:references:from:message-id:date:
   mime-version:in-reply-to:content-transfer-encoding;
  bh=db7Orwu5Rlutfa6PAdjI+6aa+OUGxvhoykOatgCpUZc=;
  b=JCidRKGftKQlAM+INTD/sKTgfVwV5q4IHy7Cjnuhd153u3iyEfMIzmVi
   XOHtQ2IR3hsKYNsFs47QOUq0/JtTPPMc+bG5DbCHqsS4j8I9JdPJHge9I
   sDgQLe3ya3f9OOgVs9ldjR5DadUBnYexZ7jW7lxW/ztGj1B+8BVqpkzs8
   9LwF5U+YmtppzYrMcBe+j10b+VIK9L1O0p6NmbNiBs+IQlvPZwPsyDbz/
   1csdGAjUdjnwMA8h3g0s5B6FTBJ+TZoVputCg4l8aTadjtEhrfSDgCkQD
   bv4XTq0x4O+KVwIAhzGfeC1i7I62T0HteE4cvqeg6WPfs9zazSDiNbmPy
   Q==;
X-IronPort-AV: E=Sophos;i="5.63,428,1557158400"; 
   d="scan'208";a="218173581"
Received: from uls-op-cesaip02.wdc.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 29 Jun 2019 00:37:13 +0800
IronPort-SDR: JgkzVf6fnBIpNOc4cPTBOyOx35L+VzsGG4tec/2fVZ/jk+9QbOLClUSDSGFp9XHa96IybrVIqh
 4acpPHodb2XnPm5JVvZAe3dziQqpiFlsuDJTIBpd/WQ+MSXoFCc1Bs1LSR2qXXMyYS3Eu/svjt
 n9LB3DGaD9cfUU3waMKKAI7Jqnac0HKarXdZaXaq/junEJg6XZShIYs1yCUAm4UtjbNXy9lDJa
 rBjoU6qEtg/6fD1p5owfoz1hkEoqaluUVw3upmTyNpfRn+S3lB1cxitZKvpBN6uD7oDNrrxRJe
 Qe60bjtWRYku3g/6+RF83RYN
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep02.wdc.com with ESMTP; 28 Jun 2019 09:36:26 -0700
IronPort-SDR: zdGYV+32eoQxixNUhCnJQ/Jkykro8Xn/bw1cwETlQY+5R3YMoipyYF4pLZ5CWan9ZZ0xuUmf5t
 qvKj/D5Xi+512cbwiuTqO5mohj37tvnm5Q8WbAz256vDOi8FBrC8hKBw0/ASDs36/cS507X714
 B1WZ3E0J+7heFw+4mlijGA+unvPLtch5XoffCFGHJp/V5LcFy128Z+Bvr3M6xq1TJelIhbrWlS
 8IxpFhuQToMKTnJZ/q4EUpRepTkzQcTuSwfsj5XNdrAL3LHwYZtNSNttKp1nm31PaOsn8UjxPa
 mPk=
Received: from usa002665.ad.shared (HELO [10.225.100.130]) ([10.225.100.130])
  by uls-op-cesaip02.wdc.com with ESMTP; 28 Jun 2019 09:37:14 -0700
Subject: Re: [PATCH v3 3/3] RISC-V: Update tlb flush counters
To:     Paul Walmsley <paul.walmsley@sifive.com>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Christoph Hellwig <hch@infradead.org>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Thomas Gleixner <tglx@linutronix.de>,
        Kees Cook <keescook@chromium.org>,
        Changbin Du <changbin.du@intel.com>,
        Anup Patel <anup@brainfault.org>,
        Palmer Dabbelt <palmer@sifive.com>,
        "maintainer:X86 ARCHITECTURE 32-BIT AND 64-BIT" <x86@kernel.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Vlastimil Babka <vbabka@suse.cz>, Gary Guo <gary@garyguo.net>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        "linux-riscv@lists.infradead.org" <linux-riscv@lists.infradead.org>,
        Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
References: <20190429212750.26165-1-atish.patra@wdc.com>
 <20190429212750.26165-4-atish.patra@wdc.com>
 <alpine.DEB.2.21.9999.1906272243530.3867@viisi.sifive.com>
From:   Atish Patra <atish.patra@wdc.com>
Message-ID: <d79430e8-20c0-d9b1-c72c-6d116f9e03db@wdc.com>
Date:   Fri, 28 Jun 2019 09:37:12 -0700
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.14; rv:60.0)
 Gecko/20100101 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <alpine.DEB.2.21.9999.1906272243530.3867@viisi.sifive.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 6/27/19 10:47 PM, Paul Walmsley wrote:
> On Mon, 29 Apr 2019, Atish Patra wrote:
> 
>> The TLB flush counters under vmstat seems to be very helpful while
>> debugging TLB flush performance in RISC-V.
>>
>> Update the counters in every TLB flush methods respectively.
>>
>> Signed-off-by: Atish Patra <atish.patra@wdc.com>
> 
> This one doesn't apply any longer.  Care to update and repost?
> 
> 
> - Paul
> 

Yeah. The baseline patch (Gary's patch) was not accepted. I will rebase 
it on top of master and resend.

-- 
Regards,
Atish

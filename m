Return-Path: <SRS0=nVcb=SO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0E599C10F0E
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Apr 2019 20:15:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CB13C20869
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Apr 2019 20:15:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="GXNWiU1o"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726959AbfDLUPE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 12 Apr 2019 16:15:04 -0400
Received: from esa5.hgst.iphmx.com ([216.71.153.144]:51545 "EHLO
        esa5.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726894AbfDLUPD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Apr 2019 16:15:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1555100104; x=1586636104;
  h=subject:to:cc:references:from:message-id:date:
   mime-version:in-reply-to:content-transfer-encoding;
  bh=AnAdBTZRjx5A90BLOgiroTyfkrt0mXjK2u0A7ssjdCk=;
  b=GXNWiU1ou6KQszVqaI5fk5zrkEm6ZYlQ3n7Q48rgNdVW9IGkiAFozF8i
   6/UWvVy+t0+ws3WTqVJQ+G08TDy0u+TbQFe3qFPfLRv+hzXhX5btyrrvN
   dPoznNIzGau1l32leFM5MRwhWZADtEQM1xK7MFVG0pNFhqj5AWkiwKiBP
   slVfCytJM8Hw9xZNwSAkTi9rh2nOTXuk+RaBqiEpeOhXmcgAvLkE4NE13
   AIcw3Dy9087QelajFWSyhQ2FehOJnSM2WGag/b/I7tcpdVxBAvlDIqnb4
   SbjsdxCEV4BFBCr+/P7Yk4kNiX5s3OGU1673LvWC39WGkYWSf632KSXEQ
   g==;
X-IronPort-AV: E=Sophos;i="5.60,342,1549900800"; 
   d="scan'208";a="107059259"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 13 Apr 2019 04:14:56 +0800
IronPort-SDR: HMLusNMFBEkSkZ9Z3yRza5Uavat1mqlR5VaAuAAiIhyDnuov0lcf8RgR16xLBtDJS+XuuHK+UB
 cePpN5Jz68Z1C3zwKX3Om6gEhRBhKpAKmzqxv0RJpTcNTSQgW7xrkTYcqjnJR/6S4i2wVTH0l0
 frSyAsCC0lE1kSV7pSGaY/i6+clJkolw5neU+bKMiBy4sadkWrYgk/q78bZIRSItioZZrlnG22
 g7fILwR9ERd2aAi5KgQCFSN5ZaThGF8MtA8TVL+ukxai1D1b0Rs068llYicis1DpGrcF8W0oAh
 VozKmt5IcWbN0Jw0tK9EK7+D
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep01.wdc.com with ESMTP; 12 Apr 2019 12:51:46 -0700
IronPort-SDR: uQweWfHHotcEJPYRE7Xhysj/kojNBRM1zXXDs/iGiGayd+KFafTmwerMlYSjAOg7Veql7v5ySO
 LLNfFMd9oR4TG7d7mYYW+Efjhgs6qT572PrT2At5+pheATDy2I/1WEdJ3EddgdS0LKq2W3eUfS
 +CVDeZ9O52Qw719+noKxCDT87/9mOXBgC3vfz9TdALfhNp3UHYHOj0LbkzGZRMvjpWd+41woqm
 R3JUi4msFbG5KH+DtkDsQbFMRRyOPXk0ACN2OlVeDFrCbcZS5xazAk3KSG9C0N7yBwvKsiSDve
 oxM=
Received: from r6220.sdcorp.global.sandisk.com (HELO [192.168.1.6]) ([10.196.157.143])
  by uls-op-cesaip01.wdc.com with ESMTP; 12 Apr 2019 13:14:56 -0700
Subject: Re: [1/3] x86: Update DEBUG_TLBFLUSH options description.
To:     Christoph Hellwig <hch@infradead.org>
Cc:     "maintainer:X86 ARCHITECTURE (32-BIT AND 64-BIT)" <x86@kernel.org>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Anup Patel <anup@brainfault.org>,
        Palmer Dabbelt <palmer@sifive.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Gary Guo <gary@garyguo.net>, "H. Peter Anvin" <hpa@zytor.com>,
        "linux-riscv@lists.infradead.org" <linux-riscv@lists.infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
References: <20190410224449.10877-1-atish.patra@wdc.com>
 <20190410224449.10877-2-atish.patra@wdc.com>
 <20190411065617.GA29422@infradead.org>
From:   Atish Patra <atish.patra@wdc.com>
Message-ID: <580d95d1-224f-a372-c656-1d2cbb19d868@wdc.com>
Date:   Fri, 12 Apr 2019 13:14:54 -0700
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.14; rv:60.0)
 Gecko/20100101 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190411065617.GA29422@infradead.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/10/19 11:56 PM, Christoph Hellwig wrote:
> Given that this option enables generic code (which you reuse for RISC-V
> later in this series) please also move the config option to
> mm/Kconfig, proabbly keyed off another ARCH_HAVE_DEBUG_TLBFLUSH
> symbol that the architecture can select.
> 

Sure.

Regards,
Atish
> _______________________________________________
> linux-riscv mailing list
> linux-riscv@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-riscv
> 


Return-Path: <SRS0=vI2Y=WC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8200FC433FF
	for <linux-kernel@archiver.kernel.org>; Tue,  6 Aug 2019 16:42:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A587820B1F
	for <linux-kernel@archiver.kernel.org>; Tue,  6 Aug 2019 16:42:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b="EWEQt0a3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387905AbfHFQmR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 6 Aug 2019 12:42:17 -0400
Received: from mo4-p00-ob.smtp.rzone.de ([85.215.255.24]:26683 "EHLO
        mo4-p00-ob.smtp.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732048AbfHFQmR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Aug 2019 12:42:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1565109732;
        s=strato-dkim-0002; d=hartkopp.net;
        h=In-Reply-To:Date:Message-ID:From:References:Cc:To:Subject:
        X-RZG-CLASS-ID:X-RZG-AUTH:From:Subject:Sender;
        bh=KJ/hU+j/ewD+T3jhdhw81CeIOchxwYxcu7jDq+0evYc=;
        b=EWEQt0a3YmaP3YyjkblXoNj3lrfFCSJWLTd2aCDYSFxKJREXbnfoKWbzGabdRmXFqC
        +hTkuV0p3zxofX9Dm5CNyVvwTxmo7UXvMEzuLRjGGLy9b0yY3RiZ6s9Qd1+ItvtgmIHc
        +leSIWOj++VVD5FU6CNm9n6QRCtihSbRaZWAebrPug9MIj+b5/aaMG4s0n4ytI0apIO7
        zLBahmoGybPy0q95xJp/BAHrOZ3nqjupcdDGSWDmKotDe7eXxzWMz5tXk9eQMjd9WSq/
        p1mEcpQVhLUXnLbqkJTkl0/KYv/u+uMqcJUFUO2RPKeqiPAHIVnx+tc4RbWtpjwlt6jh
        5ArA==
X-RZG-AUTH: ":P2MHfkW8eP4Mre39l357AZT/I7AY/7nT2yrDxb8mjG14FZxedJy6qgO1o3PMaViOoLMJU8h5l0ix"
X-RZG-CLASS-ID: mo00
Received: from [192.168.1.177]
        by smtp.strato.de (RZmta 44.24 DYNA|AUTH)
        with ESMTPSA id k05d3bv76GfoJR9
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (curve secp521r1 with 521 ECDH bits, eq. 15360 bits RSA))
        (Client did not present a certificate);
        Tue, 6 Aug 2019 18:41:50 +0200 (CEST)
Subject: Re: [PATCH net-next] net: can: Fix compiling warning
To:     Dan Carpenter <dan.carpenter@oracle.com>
Cc:     Mao Wenan <maowenan@huawei.com>, davem@davemloft.net,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel-janitors@vger.kernel.org
References: <20190802033643.84243-1-maowenan@huawei.com>
 <0050efdb-af9f-49b9-8d83-f574b3d46a2e@hartkopp.net>
 <20190806135231.GJ1974@kadam>
From:   Oliver Hartkopp <socketcan@hartkopp.net>
Message-ID: <6e1c5aa0-8ed3-eec3-a34d-867ea8f54e9d@hartkopp.net>
Date:   Tue, 6 Aug 2019 18:41:44 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190806135231.GJ1974@kadam>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Dan,

On 06/08/2019 15.52, Dan Carpenter wrote:
> On Fri, Aug 02, 2019 at 10:10:20AM +0200, Oliver Hartkopp wrote:

>> Btw. what kind of compiler/make switches are you using so that I can see
>> these warnings myself the next time?
> 
> These are Sparse warnings, not from GCC.

I compiled the code (the original version), but I do not get that 
"Should it be static?" warning:

user@box:~/net-next$ make C=1
   CALL    scripts/checksyscalls.sh
   CALL    scripts/atomic/check-atomics.sh
   DESCEND  objtool
   CHK     include/generated/compile.h
   CHECK   net/can/af_can.c
./include/linux/sched.h:609:43: error: bad integer constant expression
./include/linux/sched.h:609:73: error: invalid named zero-width bitfield 
`value'
./include/linux/sched.h:610:43: error: bad integer constant expression
./include/linux/sched.h:610:67: error: invalid named zero-width bitfield 
`bucket_id'
   CC [M]  net/can/af_can.o
   CHECK   net/can/proc.c
./include/linux/sched.h:609:43: error: bad integer constant expression
./include/linux/sched.h:609:73: error: invalid named zero-width bitfield 
`value'
./include/linux/sched.h:610:43: error: bad integer constant expression
./include/linux/sched.h:610:67: error: invalid named zero-width bitfield 
`bucket_id'
   CC [M]  net/can/proc.o
   LD [M]  net/can/can.o
   CHECK   net/can/raw.c
./include/linux/sched.h:609:43: error: bad integer constant expression
./include/linux/sched.h:609:73: error: invalid named zero-width bitfield 
`value'
./include/linux/sched.h:610:43: error: bad integer constant expression
./include/linux/sched.h:610:67: error: invalid named zero-width bitfield 
`bucket_id'
   CC [M]  net/can/raw.o
   LD [M]  net/can/can-raw.o
   CHECK   net/can/bcm.c
./include/linux/sched.h:609:43: error: bad integer constant expression
./include/linux/sched.h:609:73: error: invalid named zero-width bitfield 
`value'
./include/linux/sched.h:610:43: error: bad integer constant expression
./include/linux/sched.h:610:67: error: invalid named zero-width bitfield 
`bucket_id'
   CC [M]  net/can/bcm.o
   LD [M]  net/can/can-bcm.o
   CHECK   net/can/gw.c
./include/linux/sched.h:609:43: error: bad integer constant expression
./include/linux/sched.h:609:73: error: invalid named zero-width bitfield 
`value'
./include/linux/sched.h:610:43: error: bad integer constant expression
./include/linux/sched.h:610:67: error: invalid named zero-width bitfield 
`bucket_id'
   CC [M]  net/can/gw.o
   LD [M]  net/can/can-gw.o
Kernel: arch/x86/boot/bzImage is ready  (#2)

I've seen that warning at different other code - but not in bcm.c & raw.c

I downloaded & compiled the latest sparse source. But still no "static" 
warning. Any idea?

Best regards,
Oliver

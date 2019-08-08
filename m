Return-Path: <SRS0=IWld=WE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 10302C0650F
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Aug 2019 22:21:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BEF9C2173C
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Aug 2019 22:21:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=shipmail.org header.i=@shipmail.org header.b="Js30zXpc"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404632AbfHHWVb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 8 Aug 2019 18:21:31 -0400
Received: from pio-pvt-msa1.bahnhof.se ([79.136.2.40]:49724 "EHLO
        pio-pvt-msa1.bahnhof.se" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2404589AbfHHWVa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Aug 2019 18:21:30 -0400
Received: from localhost (localhost [127.0.0.1])
        by pio-pvt-msa1.bahnhof.se (Postfix) with ESMTP id C00AF3F3CA;
        Fri,  9 Aug 2019 00:21:27 +0200 (CEST)
Authentication-Results: pio-pvt-msa1.bahnhof.se;
        dkim=pass (1024-bit key; unprotected) header.d=shipmail.org header.i=@shipmail.org header.b="Js30zXpc";
        dkim-atps=neutral
X-Virus-Scanned: Debian amavisd-new at bahnhof.se
Received: from pio-pvt-msa1.bahnhof.se ([127.0.0.1])
        by localhost (pio-pvt-msa1.bahnhof.se [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id aL-YyBR6tXjE; Fri,  9 Aug 2019 00:21:26 +0200 (CEST)
Received: from mail1.shipmail.org (h-205-35.A357.priv.bahnhof.se [155.4.205.35])
        (Authenticated sender: mb878879)
        by pio-pvt-msa1.bahnhof.se (Postfix) with ESMTPA id CD18A3F398;
        Fri,  9 Aug 2019 00:21:25 +0200 (CEST)
Received: from localhost.localdomain (h-205-35.A357.priv.bahnhof.se [155.4.205.35])
        by mail1.shipmail.org (Postfix) with ESMTPSA id 16C1136015E;
        Fri,  9 Aug 2019 00:21:25 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=shipmail.org; s=mail;
        t=1565302885; bh=RVaCu1C5tAq3VjSBjXkZ1UBuhKLiLy/Tpb94K/nrtEA=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=Js30zXpcy30+ZBx1NEVIkzvBdlmXRihLBZvVid2tt64zg/qVBCw5XIppSy+A4/doJ
         S/Q+ly9RkbBXM53IERB8Qzr0uGGHeOvMLz8hKp5L7qJTDmfveaf3yO1s/0j0tOGStZ
         5qDimRq6xCm3+fuzaPD+XJtHGufRdRJ3+QCW7L9g=
Subject: Re: cleanup the walk_page_range interface
To:     Christoph Hellwig <hch@lst.de>,
        Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Jerome Glisse <jglisse@redhat.com>,
        Jason Gunthorpe <jgg@mellanox.com>,
        Steven Price <steven.price@arm.com>,
        Linux-MM <linux-mm@kvack.org>,
        Linux List Kernel Mailing <linux-kernel@vger.kernel.org>
References: <20190808154240.9384-1-hch@lst.de>
 <CAHk-=wh3jZnD3zaYJpW276WL=N0Vgo4KGW8M2pcFymHthwf0Vg@mail.gmail.com>
 <20190808215632.GA12773@lst.de>
From:   Thomas Hellstrom <thomas@shipmail.org>
Message-ID: <c5e7dbac-2d40-60fa-00cc-a275b3aa8373@shipmail.org>
Date:   Fri, 9 Aug 2019 00:21:24 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190808215632.GA12773@lst.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/8/19 11:56 PM, Christoph Hellwig wrote:
> On Thu, Aug 08, 2019 at 10:50:37AM -0700, Linus Torvalds wrote:
>>> Note that both Thomas and Steven have series touching this area pending,
>>> and there are a couple consumer in flux too - the hmm tree already
>>> conflicts with this series, and I have potential dma changes on top of
>>> the consumers in Thomas and Steven's series, so we'll probably need a
>>> git tree similar to the hmm one to synchronize these updates.
>> I'd be willing to just merge this now, if that helps. The conversion
>> is mechanical, and my only slight worry would be that at least for my
>> original patch I didn't build-test the (few) non-x86
>> architecture-specific cases. But I did end up looking at them fairly
>> closely  (basically using some grep/sed scripts to see that the
>> conversions I did matched the same patterns). And your changes look
>> like obvious improvements too where any mistake would have been caught
>> by the compiler.
> I did cross compile the s390 and powerpc bits, but I do not have an
> openrisc compiler.
>
>> So I'm not all that worried from a functionality standpoint, and if
>> this will help the next merge window, I'll happily pull now.
> That would help with this series vs the others, but not with the other
> series vs each other.

Although my series doesn't touch the pagewalk code, it rather borrowed 
some concepts from it and used for the apply_to_page_range() interface.

The reason being that the pagewalk code requires the mmap_sem to be held 
(mainly for trans-huge pages and reading the vma->vm_flags if I 
understand the code correctly). That is fine when you scan the vmas of a 
process, but the helpers I wrote need to instead scan all vmas pointing 
into a struct address_space, and taking the mmap_sem for each vma will 
create lock inversion problems.

/Thomas



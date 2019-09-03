Return-Path: <SRS0=TDKO=W6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E3308C3A5A2
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Sep 2019 20:46:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B15032168B
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Sep 2019 20:46:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=shipmail.org header.i=@shipmail.org header.b="d5pyVlMA"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726810AbfICUqa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 Sep 2019 16:46:30 -0400
Received: from ste-pvt-msa2.bahnhof.se ([213.80.101.71]:55741 "EHLO
        ste-pvt-msa2.bahnhof.se" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725994AbfICUq3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Sep 2019 16:46:29 -0400
Received: from localhost (localhost [127.0.0.1])
        by ste-pvt-msa2.bahnhof.se (Postfix) with ESMTP id 5AF213F7AA;
        Tue,  3 Sep 2019 22:46:22 +0200 (CEST)
Authentication-Results: ste-pvt-msa2.bahnhof.se;
        dkim=pass (1024-bit key; unprotected) header.d=shipmail.org header.i=@shipmail.org header.b=d5pyVlMA;
        dkim-atps=neutral
X-Virus-Scanned: Debian amavisd-new at bahnhof.se
Authentication-Results: ste-ftg-msa2.bahnhof.se (amavisd-new);
        dkim=pass (1024-bit key) header.d=shipmail.org
Received: from ste-pvt-msa2.bahnhof.se ([127.0.0.1])
        by localhost (ste-ftg-msa2.bahnhof.se [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id cm5YpwMMBdsT; Tue,  3 Sep 2019 22:46:21 +0200 (CEST)
Received: from mail1.shipmail.org (h-205-35.A357.priv.bahnhof.se [155.4.205.35])
        (Authenticated sender: mb878879)
        by ste-pvt-msa2.bahnhof.se (Postfix) with ESMTPA id 8EA0F3F346;
        Tue,  3 Sep 2019 22:46:19 +0200 (CEST)
Received: from localhost.localdomain (h-205-35.A357.priv.bahnhof.se [155.4.205.35])
        by mail1.shipmail.org (Postfix) with ESMTPSA id 2309F360160;
        Tue,  3 Sep 2019 22:46:19 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=shipmail.org; s=mail;
        t=1567543579; bh=ReJ050/HhfY0Ips2NyF/JTyfejqDhdHoI69hGH+hQng=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=d5pyVlMAIlG8kSjxdJ6L4TE+ZbVRlWIQ0rnwBa/UmsyM4NifbUmke10ZyTcfAn3Zv
         vUi7fIUcBPjcDYXRdoH5OFN7o7UnEzFdVJpQg2EO1+5b7rwG/jYnHaN2xKjTSqk3Wn
         8CDZYzOZUAiaMay+Q4PbIPxy6QBIXcZs2oPHLRpc=
Subject: Re: [PATCH v2 1/4] x86/mm: Export force_dma_unencrypted
To:     Christoph Hellwig <hch@infradead.org>
Cc:     dri-devel@lists.freedesktop.org, pv-drivers@vmware.com,
        linux-graphics-maintainer@vmware.com, linux-kernel@vger.kernel.org,
        Thomas Hellstrom <thellstrom@vmware.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Andy Lutomirski <luto@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Heiko Carstens <heiko.carstens@de.ibm.com>,
        Christian Borntraeger <borntraeger@de.ibm.com>,
        Tom Lendacky <thomas.lendacky@amd.com>,
        =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>
References: <20190903131504.18935-1-thomas_os@shipmail.org>
 <20190903131504.18935-2-thomas_os@shipmail.org>
 <20190903134627.GA2951@infradead.org>
 <f85e7fa6-54e1-7ac5-ce6c-96349c7af322@shipmail.org>
 <20190903162204.GB23281@infradead.org>
From:   =?UTF-8?Q?Thomas_Hellstr=c3=b6m_=28VMware=29?= 
        <thomas_os@shipmail.org>
Organization: VMware Inc.
Message-ID: <558f1224-d157-5848-1752-1430a5b3947e@shipmail.org>
Date:   Tue, 3 Sep 2019 22:46:18 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190903162204.GB23281@infradead.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/3/19 6:22 PM, Christoph Hellwig wrote:
> On Tue, Sep 03, 2019 at 04:32:45PM +0200, Thomas Hellström (VMware) wrote:
>> Is this a layer violation concern, that is, would you be ok with a similar
>> helper for TTM, or is it that you want to force the graphics drivers into
>> adhering strictly to the DMA api, even when it from an engineering
>> perspective makes no sense?
> >From looking at DRM I strongly believe that making DRM use the DMA
> mapping properly makes a lot of sense from the engineering perspective,
> and this series is a good argument for that positions.

What I mean with "from an engineering perspective" is that drivers would 
end up with a non-trivial amount of code supporting purely academic 
cases: Setups where software rendering would be faster than gpu 
accelerated, and setups on platforms where the driver would never run 
anyway because the device would never be supported on that platform...

>   If DRM was using
> the DMA properl we would not need this series to start with, all the
> SEV handling is hidden behind the DMA API.  While we had occasional
> bugs in that support fixing it meant that it covered all drivers
> properly using that API.

That is not really true. The dma API can't handle faulting of coherent 
pages which is what this series is really all about supporting also with 
SEV active. To handle the case where we move graphics buffers or send 
them to swap space while user-space have them mapped.

To do that and still be fully dma-api compliant we would ideally need, 
for example, an exported dma_pgprot(). (dma_pgprot() by the way is still 
suffering from one of the bugs that you mention above).

Still, I need a way forward and my questions weren't really answered by 
this.

/Thomas






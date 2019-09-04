Return-Path: <SRS0=tMFY=W7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 12A08C3A5A8
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Sep 2019 17:28:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CAD4921883
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Sep 2019 17:28:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=shipmail.org header.i=@shipmail.org header.b="iERqBUul"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731852AbfIDR2i (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 4 Sep 2019 13:28:38 -0400
Received: from pio-pvt-msa2.bahnhof.se ([79.136.2.41]:41344 "EHLO
        pio-pvt-msa2.bahnhof.se" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729656AbfIDR2h (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Sep 2019 13:28:37 -0400
Received: from localhost (localhost [127.0.0.1])
        by pio-pvt-msa2.bahnhof.se (Postfix) with ESMTP id AFEFB40CFE;
        Wed,  4 Sep 2019 19:28:29 +0200 (CEST)
Authentication-Results: pio-pvt-msa2.bahnhof.se;
        dkim=pass (1024-bit key; unprotected) header.d=shipmail.org header.i=@shipmail.org header.b=iERqBUul;
        dkim-atps=neutral
X-Virus-Scanned: Debian amavisd-new at bahnhof.se
Received: from pio-pvt-msa2.bahnhof.se ([127.0.0.1])
        by localhost (pio-pvt-msa2.bahnhof.se [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id rBGq5zMsLeAq; Wed,  4 Sep 2019 19:28:28 +0200 (CEST)
Received: from mail1.shipmail.org (h-205-35.A357.priv.bahnhof.se [155.4.205.35])
        (Authenticated sender: mb878879)
        by pio-pvt-msa2.bahnhof.se (Postfix) with ESMTPA id 3031640CF9;
        Wed,  4 Sep 2019 19:28:16 +0200 (CEST)
Received: from localhost.localdomain (h-205-35.A357.priv.bahnhof.se [155.4.205.35])
        by mail1.shipmail.org (Postfix) with ESMTPSA id 7ADB6360160;
        Wed,  4 Sep 2019 19:28:16 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=shipmail.org; s=mail;
        t=1567618096; bh=g/YBsHGIYYFph7qo+7u1a+3fuQm1INNdutAJRrM12b0=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=iERqBUulThtpa34mSoRstP7r957CqdVD6ctHb8Ma8Wk2aPgzDiav67Q0WmgAvmG5b
         wXyLpgdeIgGXnAakCc+wuacTDhEZm8LymtGPX3t0ofQHAdrGGhux8O+sQGbp3hjbe8
         +f/GcL1KwCTpOmhi0+GC0ha3hNVowvOcwcVaXZsU=
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
 <558f1224-d157-5848-1752-1430a5b3947e@shipmail.org>
 <20190904065823.GA31794@infradead.org>
 <8698dc21-8679-b4a7-3179-71589fa33ab7@shipmail.org>
 <20190904122204.GA16937@infradead.org>
From:   =?UTF-8?Q?Thomas_Hellstr=c3=b6m_=28VMware=29?= 
        <thomas_os@shipmail.org>
Organization: VMware Inc.
Message-ID: <4cb5a2b4-cbd0-a86d-7881-f3d750df7d0e@shipmail.org>
Date:   Wed, 4 Sep 2019 19:28:16 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190904122204.GA16937@infradead.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/4/19 2:22 PM, Christoph Hellwig wrote:
> On Wed, Sep 04, 2019 at 09:32:30AM +0200, Thomas Hellström (VMware) wrote:
>> That sounds great. Is there anything I can do to help out? I thought this
>> was more or less a dead end since the current dma_mmap_ API requires the
>> mmap_sem to be held in write mode (modifying the vma->vm_flags) whereas
>> fault() only offers read mode. But that would definitely work.
> We'll just need to split into a setup and faul phase.  I have some
> sketches from a while ago, let me dust them off so that you can
> try them.

I'd be happy to.

Thanks,

Thomas



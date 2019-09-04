Return-Path: <SRS0=tMFY=W7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B6DD0C3A5A7
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Sep 2019 13:06:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8F72D2339D
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Sep 2019 13:06:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=shipmail.org header.i=@shipmail.org header.b="JXsQcDc8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730313AbfIDNGG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 4 Sep 2019 09:06:06 -0400
Received: from pio-pvt-msa1.bahnhof.se ([79.136.2.40]:54000 "EHLO
        pio-pvt-msa1.bahnhof.se" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727722AbfIDNGF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Sep 2019 09:06:05 -0400
Received: from localhost (localhost [127.0.0.1])
        by pio-pvt-msa1.bahnhof.se (Postfix) with ESMTP id B46D23F9C0;
        Wed,  4 Sep 2019 15:06:03 +0200 (CEST)
Authentication-Results: pio-pvt-msa1.bahnhof.se;
        dkim=pass (1024-bit key; unprotected) header.d=shipmail.org header.i=@shipmail.org header.b="JXsQcDc8";
        dkim-atps=neutral
X-Virus-Scanned: Debian amavisd-new at bahnhof.se
Received: from pio-pvt-msa1.bahnhof.se ([127.0.0.1])
        by localhost (pio-pvt-msa1.bahnhof.se [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id ZeLhbXyEuEdk; Wed,  4 Sep 2019 15:05:59 +0200 (CEST)
Received: from mail1.shipmail.org (h-205-35.A357.priv.bahnhof.se [155.4.205.35])
        (Authenticated sender: mb878879)
        by pio-pvt-msa1.bahnhof.se (Postfix) with ESMTPA id 746973F54E;
        Wed,  4 Sep 2019 15:05:53 +0200 (CEST)
Received: from localhost.localdomain (h-205-35.A357.priv.bahnhof.se [155.4.205.35])
        by mail1.shipmail.org (Postfix) with ESMTPSA id 8F26E360160;
        Wed,  4 Sep 2019 15:05:53 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=shipmail.org; s=mail;
        t=1567602353; bh=rscDBECHNl0CXKODIklLg5/3/ptNV8FCth57CkJf9VI=;
        h=Subject:From:To:Cc:References:Date:In-Reply-To:From;
        b=JXsQcDc898Uc90ArEPBLYz3yNnWhJDj0ppW4tgz92O7uS2UUd7RFH5AMPSwri9Zh/
         OeCGJr+V1oNeBOv/2nF7E0NAx3y5IdZC6UVYSdQceC9k4nij0GxDwcL5/Js2ivJYNR
         MDVrK0X2SVKRTBE1ieGdl56nbwfyQ1/zz03BaIl0=
Subject: Re: [PATCH v2 3/4] drm/ttm, drm/vmwgfx: Correctly support support AMD
 memory encryption
From:   =?UTF-8?Q?Thomas_Hellstr=c3=b6m_=28VMware=29?= 
        <thomas_os@shipmail.org>
To:     "Koenig, Christian" <Christian.Koenig@amd.com>,
        Dave Hansen <dave.hansen@intel.com>,
        Daniel Vetter <daniel@ffwll.ch>
Cc:     dri-devel <dri-devel@lists.freedesktop.org>,
        "pv-drivers@vmware.com" <pv-drivers@vmware.com>,
        VMware Graphics <linux-graphics-maintainer@vmware.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "Lendacky, Thomas" <Thomas.Lendacky@amd.com>,
        Thomas Hellstrom <thellstrom@vmware.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Heiko Carstens <heiko.carstens@de.ibm.com>,
        Christian Borntraeger <borntraeger@de.ibm.com>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Andy Lutomirski <luto@kernel.org>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Thomas Gleixner <tglx@linutronix.de>
References: <20190903131504.18935-1-thomas_os@shipmail.org>
 <20190903131504.18935-4-thomas_os@shipmail.org>
 <b54bd492-9702-5ad7-95da-daf20918d3d9@intel.com>
 <CAKMK7uFv+poZq43as8XoQaSuoBZxCQ1p44VCmUUTXOXt4Y+Bjg@mail.gmail.com>
 <6d0fafcc-b596-481b-7b22-1f26f0c02c5c@intel.com>
 <bed2a2d9-17f0-24bd-9f4a-c7ee27f6106e@shipmail.org>
 <7fa3b178-b9b4-2df9-1eee-54e24d48342e@intel.com>
 <ba77601a-d726-49fa-0c88-3b02165a9a21@shipmail.org>
 <cfe46eda-66b5-b40d-6721-84e6e0e1f5de@amd.com>
 <94113acc-1f99-2386-1d42-4b9930b04f73@shipmail.org>
 <7eec2c11-d0d4-4c81-6ed2-d0932bf5af33@amd.com>
 <9ca29de8-0c9b-65b2-52e8-8668a1517ac5@shipmail.org>
Organization: VMware Inc.
Message-ID: <e13accfc-cde8-754c-1730-0f2db4e2dd2e@shipmail.org>
Date:   Wed, 4 Sep 2019 15:05:53 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <9ca29de8-0c9b-65b2-52e8-8668a1517ac5@shipmail.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/4/19 2:35 PM, Thomas Hellström (VMware) wrote:
>
>>
>> I've already talked with Christoph that we probably want to switch TTM
>> over to using that instead to also get rid of the ttm_io_prot() hack.
>
> OK, would that mean us ditching other memory modes completely? And 
> on-the-fly caching transitions? or is it just for the special case of 
> cached coherent memory? Do we need to cache the coherent kernel 
> mappings in TTM as well, for ttm_bo_kmap()?

Reading this again, I wanted to point out that I'm not against this. 
Just curious.

/Thomas



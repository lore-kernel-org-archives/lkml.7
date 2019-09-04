Return-Path: <SRS0=tMFY=W7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 05E74C3A5A7
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Sep 2019 10:38:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B88892339D
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Sep 2019 10:38:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=shipmail.org header.i=@shipmail.org header.b="jmqI5tgg"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729335AbfIDKiC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 4 Sep 2019 06:38:02 -0400
Received: from pio-pvt-msa3.bahnhof.se ([79.136.2.42]:53786 "EHLO
        pio-pvt-msa3.bahnhof.se" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726304AbfIDKiC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Sep 2019 06:38:02 -0400
Received: from localhost (localhost [127.0.0.1])
        by pio-pvt-msa3.bahnhof.se (Postfix) with ESMTP id 8A1353F6E5;
        Wed,  4 Sep 2019 12:37:49 +0200 (CEST)
Authentication-Results: pio-pvt-msa3.bahnhof.se;
        dkim=pass (1024-bit key; unprotected) header.d=shipmail.org header.i=@shipmail.org header.b=jmqI5tgg;
        dkim-atps=neutral
X-Virus-Scanned: Debian amavisd-new at bahnhof.se
Received: from pio-pvt-msa3.bahnhof.se ([127.0.0.1])
        by localhost (pio-pvt-msa3.bahnhof.se [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id 5OXVNpQKvjjO; Wed,  4 Sep 2019 12:37:48 +0200 (CEST)
Received: from mail1.shipmail.org (h-205-35.A357.priv.bahnhof.se [155.4.205.35])
        (Authenticated sender: mb878879)
        by pio-pvt-msa3.bahnhof.se (Postfix) with ESMTPA id 194913F538;
        Wed,  4 Sep 2019 12:37:46 +0200 (CEST)
Received: from localhost.localdomain (h-205-35.A357.priv.bahnhof.se [155.4.205.35])
        by mail1.shipmail.org (Postfix) with ESMTPSA id 4A1BB36117F;
        Wed,  4 Sep 2019 12:37:46 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=shipmail.org; s=mail;
        t=1567593466; bh=akRBTXxMLQXPdPRml7vfcwvBwbf56SVhUOk6CAVkC7g=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=jmqI5tggrRqyalYT5qgVmkGv5E8PK0uoJAGge7hKl4hbNkmvoLq77PsUgXGd2drhA
         I/iSZLiecT2/xY1eWKLfVOepEryYzy3tLTAVvISoPgU2jKW+HJTBb3A32vn9GWQ6yV
         pCPMJEf5h0JyBbBhEIyiOqKdJBtPPg2R2PR6gDBc=
Subject: Re: [PATCH v2 3/4] drm/ttm, drm/vmwgfx: Correctly support support AMD
 memory encryption
To:     Daniel Vetter <daniel@ffwll.ch>
Cc:     Andy Lutomirski <luto@amacapital.net>,
        Andy Lutomirski <luto@kernel.org>,
        Dave Hansen <dave.hansen@intel.com>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        pv-drivers@vmware.com,
        VMware Graphics <linux-graphics-maintainer@vmware.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Tom Lendacky <thomas.lendacky@amd.com>,
        Thomas Hellstrom <thellstrom@vmware.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Heiko Carstens <heiko.carstens@de.ibm.com>,
        Christian Borntraeger <borntraeger@de.ibm.com>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>
References: <20190903131504.18935-1-thomas_os@shipmail.org>
 <20190903131504.18935-4-thomas_os@shipmail.org>
 <b54bd492-9702-5ad7-95da-daf20918d3d9@intel.com>
 <CAKMK7uFv+poZq43as8XoQaSuoBZxCQ1p44VCmUUTXOXt4Y+Bjg@mail.gmail.com>
 <6d0fafcc-b596-481b-7b22-1f26f0c02c5c@intel.com>
 <bed2a2d9-17f0-24bd-9f4a-c7ee27f6106e@shipmail.org>
 <7fa3b178-b9b4-2df9-1eee-54e24d48342e@intel.com>
 <ba77601a-d726-49fa-0c88-3b02165a9a21@shipmail.org>
 <CALCETrVnNpPwmRddGLku9hobE7wG30_3j+QfcYxk09hZgtaYww@mail.gmail.com>
 <44b094c8-63fe-d9e5-1bf4-7da0788caccf@shipmail.org>
 <6d122d62-9c96-4c29-8d06-02f7134e5e2a@shipmail.org>
 <B3C5DD1B-A33C-417F-BDDC-73120A035EA5@amacapital.net>
 <3393108b-c7e3-c9be-b65b-5860c15ca228@shipmail.org>
 <CAKMK7uH0jxaWJLxfXfGLyN-Rb=0ZKUFTkrEPdFCuGCh4ORCv9w@mail.gmail.com>
From:   =?UTF-8?Q?Thomas_Hellstr=c3=b6m_=28VMware=29?= 
        <thomas_os@shipmail.org>
Organization: VMware Inc.
Message-ID: <0fd10438-5da4-fb69-f40c-c9b4beea1977@shipmail.org>
Date:   Wed, 4 Sep 2019 12:37:45 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <CAKMK7uH0jxaWJLxfXfGLyN-Rb=0ZKUFTkrEPdFCuGCh4ORCv9w@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/4/19 9:53 AM, Daniel Vetter wrote:
> On Wed, Sep 4, 2019 at 8:49 AM Thomas Hellström (VMware)
> <thomas_os@shipmail.org> wrote:
>> On 9/4/19 1:15 AM, Andy Lutomirski wrote:
>>> But, reading this, I have more questions:
>>>
>>> Can’t you get rid of cvma by using vmf_insert_pfn_prot()?
>> It looks like that, although there are comments in the code about
>> serious performance problems using VM_PFNMAP / vmf_insert_pfn() with
>> write-combining and PAT, so that would require some serious testing with
>> hardware I don't have. But I guess there is definitely room for
>> improvement here. Ideally we'd like to be able to change the
>> vma->vm_page_prot within fault(). But we can
> Just a quick comment on this: It's the repeated (per-pfn/pte) lookup
> of the PAT tables, which are dead slow. If you have a struct
> io_mapping then that can be done once, and then just blindly inserted.
> See remap_io_mapping in i915.
> -Daniel

Thanks, Daniel.

Indeed looks a lot like remap_pfn_range(), but usable at fault time?

/Thomas



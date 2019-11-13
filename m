Return-Path: <SRS0=LLNM=ZF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 597C5C43331
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Nov 2019 13:44:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 34FF72245C
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Nov 2019 13:44:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727450AbfKMNom (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Nov 2019 08:44:42 -0500
Received: from mx2.suse.de ([195.135.220.15]:56052 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726186AbfKMNol (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Nov 2019 08:44:41 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 360A0AD79;
        Wed, 13 Nov 2019 13:44:40 +0000 (UTC)
Subject: Re: [Xen-devel] [PATCH 2/3] xen/mcelog: add PPIN to record when
 available
To:     Boris Ostrovsky <boris.ostrovsky@oracle.com>
Cc:     Juergen Gross <jgross@suse.com>,
        the arch/x86 maintainers <x86@kernel.org>,
        "xen-devel@lists.xenproject.org" <xen-devel@lists.xenproject.org>,
        lkml <linux-kernel@vger.kernel.org>
References: <a83f42ad-c380-c07f-7d22-7f19107db5d5@suse.com>
 <c1f58da4-0a05-5f77-13bd-a421582675d0@suse.com>
 <9466c080-9926-0d9f-435a-ddf0c3ec7812@oracle.com>
From:   Jan Beulich <jbeulich@suse.com>
Message-ID: <5f8bbcb2-2eb9-c9f4-622a-43a6d0814b94@suse.com>
Date:   Wed, 13 Nov 2019 14:44:56 +0100
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.1
MIME-Version: 1.0
In-Reply-To: <9466c080-9926-0d9f-435a-ddf0c3ec7812@oracle.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 13.11.2019 01:11, Boris Ostrovsky wrote:
> On 11/11/19 9:46 AM, Jan Beulich wrote:
>> --- a/arch/x86/include/asm/msr-index.h
>> +++ b/arch/x86/include/asm/msr-index.h
>> @@ -393,6 +393,8 @@
>>  #define MSR_AMD_PSTATE_DEF_BASE		0xc0010064
>>  #define MSR_AMD64_OSVW_ID_LENGTH	0xc0010140
>>  #define MSR_AMD64_OSVW_STATUS		0xc0010141
>> +#define MSR_AMD_PPIN_CTL		0xc00102f0
>> +#define MSR_AMD_PPIN			0xc00102f1
> 
> Which processors are these defined for? I looked at a couple (fam 15h
> and 17h) and didn't see those. And I don't see them in Linux.

Certain Fam17 ones, Rome in particular (which is where I've
tested this).

>> --- a/include/xen/interface/xen-mca.h
>> +++ b/include/xen/interface/xen-mca.h
>> @@ -332,7 +332,11 @@ struct xen_mc {
>>  };
>>  DEFINE_GUEST_HANDLE_STRUCT(xen_mc);
>>  
>> -/* Fields are zero when not available */
>> +/*
>> + * Fields are zero when not available. Also, this struct is shared with
>> + * userspace mcelog and thus must keep existing fields at current offsets.
>> + * Only add new fields to the end of the structure
>> + */
>>  struct xen_mce {
> 
> Why is this structure is part of the interface?

That's a question to whoever put it there. There look to have
been decisions (see also patch 1) to have the Linux clones of
Xen's public headers deviate far more from their original
than I would consider reasonable.

Jan

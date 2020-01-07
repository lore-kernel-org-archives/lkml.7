Return-Path: <SRS0=facv=24=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 72225C282DD
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Jan 2020 19:13:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4778C20715
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Jan 2020 19:13:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="gwTFOi3c"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728680AbgAGTN1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 Jan 2020 14:13:27 -0500
Received: from mail-wm1-f68.google.com ([209.85.128.68]:53826 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728633AbgAGTN1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Jan 2020 14:13:27 -0500
Received: by mail-wm1-f68.google.com with SMTP id m24so705447wmc.3
        for <linux-kernel@vger.kernel.org>; Tue, 07 Jan 2020 11:13:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=2YKA6wR3nfMoDoK29VnXJao01YmcZt+LYyNBVhw8COQ=;
        b=gwTFOi3cM1/db5Vr0KJRhw8Kl4Lj+1+NjeGnDQaUKV4tKAQBsZFYwn64nz8tF2+L7Q
         q2GfPPuJBzywpJt9uFuwTqYkJxamvx2vdtaW8Ac5mlS3+CYlapichVhXBFCFvf2MM/xs
         c5AwjzmLsVHc07kQCtWSFFkFpKhmei8/Hgpts=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=2YKA6wR3nfMoDoK29VnXJao01YmcZt+LYyNBVhw8COQ=;
        b=SjpJVrGl3dIFxZJ/2Ym9LnO/ZlmWflhs7KuTZ+huQeoLJ1jJr7VBT6RWfh75O56+Hy
         VdkMu0r53dMNqBR+m7bK5TaT14wqhe88ooeml2bWYVZHG9n4LRu+zCd56rKAemgrkACh
         4Oltn8RMGZvX2fky64uEhD+eozG+AyA9gOJ9fcmNueZyrUwGsyGIX854ixuQbQLcF8Cu
         BmvHZ9vFXoFqBCvDwQCAtAbjrrKAUR9SHk47zBpSHkPJh/4oOPN2AHXiW4KvD9+DpHxD
         EwDv+fnggfRf/6kLxSDKzBQbB1cwCI09TAqMOEHrTv4+6ziW9oNSRekAia3dmIGmQMbC
         9a8w==
X-Gm-Message-State: APjAAAVlc/9aIV4MMKNUULNbNvfA9HuULHQwYi8yjFi1mqbjLGdYyxjW
        jyUZHLbqAxF+aG/FRNREQjn09456wEuTAbL7ZX1BQvTmckjnrZmDYbPIN8eRi6Nh5UHoXzNoCo1
        igcb1lIciiJXISNW8XwnlXF7YTu7zDdr0RMeUlv1NkeHs1freArj/gWt/KkvaWcrWtsa1GJi9Nr
        K/Fa1CX/Wp
X-Google-Smtp-Source: APXvYqz9/DiYpCNC/CHgSqYlNqwotQFdLeZwNntFGvBJTzum/gQYW8w0acPfb+tCOgHdUb8FWBMQHg==
X-Received: by 2002:a1c:a406:: with SMTP id n6mr581706wme.40.1578424404657;
        Tue, 07 Jan 2020 11:13:24 -0800 (PST)
Received: from [10.136.13.65] ([192.19.228.250])
        by smtp.gmail.com with ESMTPSA id j12sm1083261wrw.54.2020.01.07.11.13.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 07 Jan 2020 11:13:24 -0800 (PST)
Subject: Re: EDAC driver for DMC520
To:     Shiping Ji <shiping.linux@gmail.com>,
        Borislav Petkov <bp@alien8.de>
Cc:     Mauro Carvalho Chehab <mchehab@kernel.org>,
        Tony Luck <tony.luck@intel.com>,
        Yuqing Shen <yuqing.shen@broadcom.com>,
        Lei Wang <lewan@microsoft.com>,
        James Morse <james.morse@arm.com>,
        Robert Richter <rrichter@marvell.com>,
        BCM Kernel Feedback <bcm-kernel-feedback-list@broadcom.com>,
        LKML <linux-kernel@vger.kernel.org>
References: <bdb29d6d-bc63-cf68-0e32-556740537cd8@broadcom.com>
 <20200107184926.GL29542@zn.tnic>
 <f56605f8-e49f-6b99-5735-b4bec75af9fd@broadcom.com>
 <5a3188d8-e23a-b0de-bef7-ff60dda339ab@gmail.com>
From:   Scott Branden <scott.branden@broadcom.com>
Message-ID: <9364cef0-73ff-0bde-8e50-7463d0c20707@broadcom.com>
Date:   Tue, 7 Jan 2020 11:13:20 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <5a3188d8-e23a-b0de-bef7-ff60dda339ab@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Shiping,

On 2020-01-07 11:01 a.m., Shiping Ji wrote:
> On 1/7/2020 10:55 AM, Scott Branden wrote:
>> Lei/Shiping,
>>
>> On 2020-01-07 10:49 a.m., Borislav Petkov wrote:
>>> On Tue, Jan 07, 2020 at 09:57:26AM -0800, Scott Branden wrote:
>>>> Hello EDAC Maintainers,
>>>>
>>>> Could somebody have a look at the DMC520 patch series that has been waiting
>>>> for a response since November:
>>>> https://patchwork.kernel.org/patch/11248785/
>>> Well, the dt bindings stuff is still being discussed:
>>>
>>> https://patchwork.kernel.org/patch/11248783/
Shiping, you also need to address the binding comment here.
>>>
>>> Also, looking at this again, the patch authorship looks really fishy:
>>>
>>> Sender is
>>>
>>> From: Shiping Ji <shiping.linux@gmail.com>
>>>
>>> however, he doesn't have his SOB in there and previous iterations were
>>> done with Lei Wang whose SOB *is* there so I dunno what's going on.
>>>
>>> *Especially* if Lei Wang is being added as a maintainer of that driver
>>> by the second patch but he's not sending this driver himself. If this
>>> driver is going to be orphaned the moment it lands upstream, I'm not
>>> going to take it.
>> Shiping/Lei could you please provide appropriate signed-off-by?
>> Also, if you do not have an appropriate maintainer for the driver
>> we have Yuqing Shen who can be maintainer of this driver.
> Yes, signed-off-by is still Lei Wang, who is still the official maintainer of the driver.
>
> Lei is currently in sick leave so I'm trying to complete the patches on her behalf. Please kindly let me know how to add my SOB there.
If Lei is coming back soon then it may be best to wait for her?

Either way, I highly suggest you read the kernel documentation on 
submitting patches in the source tree:
Documentation/process/submitting-patches.rst.

Also, some of your other coworkers must know how to upstream code and 
can help you follow the process?
> Thanks!
>
>>> So at least those two things need to be fixed/clarified first.
>>>
>>> HTH.
>>>


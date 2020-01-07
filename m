Return-Path: <SRS0=facv=24=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2E041C282DD
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Jan 2020 19:18:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F41512080A
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Jan 2020 19:18:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mPv6Xv/N"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728746AbgAGTSp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 Jan 2020 14:18:45 -0500
Received: from mail-pg1-f196.google.com ([209.85.215.196]:43487 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728307AbgAGTSp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Jan 2020 14:18:45 -0500
Received: by mail-pg1-f196.google.com with SMTP id k197so315343pga.10
        for <linux-kernel@vger.kernel.org>; Tue, 07 Jan 2020 11:18:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=kuEGh2Zlr+FGnLooxg1Ltm3amu+APIAHxYI74C0ZVf0=;
        b=mPv6Xv/NPZDH7S+Uagcba9E3ISUG6Fx2Fz0z1qRAj3ZVt2Xz2yizchDP2jvHn8yoDM
         dxEhuqalmleHEmSuEHkul2R9mEv5BfgsSeggvQ3Q+P75W2rRe3AL7d38mLyk6az5cf1P
         95PzoNZgCNh4B8VMCUR/9i9ibLnQ0pOP1d6upJWl4RAuXNJEqe73mLvIrL7mat3h95pR
         fsK8hWL74H9xPMfJ1u9n/i6PCUMYX4k0SvOnfeKXB8/uLobrZ486MyUNUJvXXbHl/bOO
         X9DcmogfVtnMXiHr6aICt762pC7BZffsUwTPF3S0AVZId0hjr1X6u3xwnAxqVrubhtP+
         O9zw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=kuEGh2Zlr+FGnLooxg1Ltm3amu+APIAHxYI74C0ZVf0=;
        b=C0OKUPmz668/AB1Mqq44lqR9r7kn8adCeOVR6ifmqdu1quaJT3D46HnqKB3gIasejp
         38sE8wcGq9TbiSbr3uDsRM9sxkkXcwUyvmd4+RwJk8oNzUsxw5B6uCbprFFBOgHhB1i7
         xJLHRhj6+Dwy8nbTvQ93CKMg524IISI14sye2CXCRfIyxbjK33uG/SCFGEw2NfRTN6N+
         xEk6D7fWgzEuY7dM/G6v6grobpMeb1Dn1V1tdJ8k3by/SETiEE1AxcTsiDmWo9TwqJTP
         Z+1meGIOO6qSQv+ZGMy21dO+2sDuyrChen+Eiiv1UBI8k5qRuOj2MbBeSButYXJibfK+
         AUJg==
X-Gm-Message-State: APjAAAUaFgaQfL4HsMyS4KYec68hNFebZDXkhy0bTjHaMkoIZ7XDefga
        XRcqtzzksLySyJoL6BtG0kO0729O
X-Google-Smtp-Source: APXvYqzdDL7LawtouQzHz/0VtYjZ4UB3OAiOaO50xXrD/6sxYFYEzNVVDBdAqTnMpiFOjMryilxAZA==
X-Received: by 2002:a62:f243:: with SMTP id y3mr842716pfl.146.1578424723975;
        Tue, 07 Jan 2020 11:18:43 -0800 (PST)
Received: from ?IPv6:2001:4898:d8:28:b920:9a21:10c:ddbd? ([2001:4898:80e8:0:3938:9a21:10c:ddbd])
        by smtp.gmail.com with ESMTPSA id e16sm496044pgk.77.2020.01.07.11.18.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 07 Jan 2020 11:18:43 -0800 (PST)
Subject: Re: EDAC driver for DMC520
To:     Scott Branden <scott.branden@broadcom.com>,
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
 <9364cef0-73ff-0bde-8e50-7463d0c20707@broadcom.com>
From:   Shiping Ji <shiping.linux@gmail.com>
Message-ID: <3dc9a736-16c9-7e87-b27c-bf3029d1a37f@gmail.com>
Date:   Tue, 7 Jan 2020 11:18:42 -0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.3.1
MIME-Version: 1.0
In-Reply-To: <9364cef0-73ff-0bde-8e50-7463d0c20707@broadcom.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Scott,

On 1/7/2020 11:13 AM, Scott Branden wrote:
> Hi Shiping,
> 
> On 2020-01-07 11:01 a.m., Shiping Ji wrote:
>> On 1/7/2020 10:55 AM, Scott Branden wrote:
>>> Lei/Shiping,
>>>
>>> On 2020-01-07 10:49 a.m., Borislav Petkov wrote:
>>>> On Tue, Jan 07, 2020 at 09:57:26AM -0800, Scott Branden wrote:
>>>>> Hello EDAC Maintainers,
>>>>>
>>>>> Could somebody have a look at the DMC520 patch series that has been waiting
>>>>> for a response since November:
>>>>> https://patchwork.kernel.org/patch/11248785/
>>>> Well, the dt bindings stuff is still being discussed:
>>>>
>>>> https://patchwork.kernel.org/patch/11248783/
> Shiping, you also need to address the binding comment here.

Yes, I'm currently working on the dt-binding changes.

>>>>
>>>> Also, looking at this again, the patch authorship looks really fishy:
>>>>
>>>> Sender is
>>>>
>>>> From: Shiping Ji <shiping.linux@gmail.com>
>>>>
>>>> however, he doesn't have his SOB in there and previous iterations were
>>>> done with Lei Wang whose SOB *is* there so I dunno what's going on.
>>>>
>>>> *Especially* if Lei Wang is being added as a maintainer of that driver
>>>> by the second patch but he's not sending this driver himself. If this
>>>> driver is going to be orphaned the moment it lands upstream, I'm not
>>>> going to take it.
>>> Shiping/Lei could you please provide appropriate signed-off-by?
>>> Also, if you do not have an appropriate maintainer for the driver
>>> we have Yuqing Shen who can be maintainer of this driver.
>> Yes, signed-off-by is still Lei Wang, who is still the official maintainer of the driver.
>>
>> Lei is currently in sick leave so I'm trying to complete the patches on her behalf. Please kindly let me know how to add my SOB there.
> If Lei is coming back soon then it may be best to wait for her?

It may take another couple of months for her to return, we'd like to complete the current patches since these have been active for quite long time (almost one year).

> Either way, I highly suggest you read the kernel documentation on submitting patches in the source tree:
> Documentation/process/submitting-patches.rst.
> 
> Also, some of your other coworkers must know how to upstream code and can help you follow the process?

Yes, I followed the notes but apparently have missed some important steps. I'll go the above document and get it fixed.

The new patches are expected in a couple of days.

>> Thanks!
>>
>>>> So at least those two things need to be fixed/clarified first.
>>>>
>>>> HTH.
>>>>
> 


-- 
Best regards,
Shiping Ji

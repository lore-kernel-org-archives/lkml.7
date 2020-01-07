Return-Path: <SRS0=facv=24=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7D0F1C282DD
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Jan 2020 19:59:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4DDB1206DB
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Jan 2020 19:59:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cLIIUUyY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728688AbgAGT7H (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 Jan 2020 14:59:07 -0500
Received: from mail-pf1-f181.google.com ([209.85.210.181]:42247 "EHLO
        mail-pf1-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728358AbgAGT7H (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Jan 2020 14:59:07 -0500
Received: by mail-pf1-f181.google.com with SMTP id 4so377398pfz.9
        for <linux-kernel@vger.kernel.org>; Tue, 07 Jan 2020 11:59:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=kDDOyGuLWN+g17UTe8i8iv4FVCbQKSGfjuGz9joiW90=;
        b=cLIIUUyY2moozr1++AAYH+6z0vAQKKufvi8yOn9LRneGL1z5lDnS/O6jQSmkxvhbcq
         dak042gmmco+YHd5zzNUUs0RErFWhnQ6HOiSVPCO5wT6g8qhJhONWVgzCna7xM+xkL+9
         zBtlC4t+pIYAv9qzOpYhlKDJioSqH588Fdvwlh9m7VPGfHEEzdCXwOmFFy/XW2xWONh+
         GaBbMMHfhBmZdxr1dPmC0X7NfJt5BrPm8GvY+TvE6dL00frF0h1r64EgeP1LOggheGvB
         wI6JIWELxPua77uULl4sLVlXEWUCUW0FcgBfxiLLT4Jq5WbCpHwXlYkrOeYa+G6N5luE
         O7Ow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=kDDOyGuLWN+g17UTe8i8iv4FVCbQKSGfjuGz9joiW90=;
        b=ZvUCyVMa21HyaOezGknixjAlkYG49Ixt9P4UhRyvNQVkMcf6G6yBk9WtMFo7rWqVlC
         hLknTZa9n+K5i4ZpfOpwZ2MxCVQUkfQOXmn3tXbOhkzLKyzUkLKQom29firHQIULlZ2n
         3XPj3dMD5mBMc0Aya1B/Wx+eAEY+W6N4aN5kVJRFEMnuPSYRHw/5DdTD1tHVAXB+O3xX
         VG1xjQnX/DO0E8beKrDFq9t5QNX1Qk0favqGTf+gbjcY+u4bbugesBdjSRTkBqN9RuRN
         a5W3+s5jnVlzBTbwXLfYCLVIFzqutQxYBBBSciQ3MMoJ+YlNEuLQpcQ51CdB1j0awVDW
         NLNw==
X-Gm-Message-State: APjAAAW5/+Kz9V9ebKANMIEy3JUJT9/FszUYBXfi2WTMFgk2Qh465E+D
        oBd9rfZK1vY73rNEffu7zMBM66wS
X-Google-Smtp-Source: APXvYqx216jN4hFGUZrxRgGknT+auzYOT/OmtAi6KSuG/KeqngXGWVQ+gyI6FIEg8Q02efVC+1XjeA==
X-Received: by 2002:a62:5343:: with SMTP id h64mr917254pfb.171.1578427146420;
        Tue, 07 Jan 2020 11:59:06 -0800 (PST)
Received: from ?IPv6:2001:4898:d8:28:b920:9a21:10c:ddbd? ([2001:4898:80e8:b:392d:9a21:10c:ddbd])
        by smtp.gmail.com with ESMTPSA id l14sm565712pgt.42.2020.01.07.11.59.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 07 Jan 2020 11:59:05 -0800 (PST)
Subject: Re: EDAC driver for DMC520
To:     Borislav Petkov <bp@alien8.de>
Cc:     Scott Branden <scott.branden@broadcom.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
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
 <3dc9a736-16c9-7e87-b27c-bf3029d1a37f@gmail.com>
 <20200107195606.GM29542@zn.tnic>
From:   Shiping Ji <shiping.linux@gmail.com>
Message-ID: <4d58e327-d732-8a6a-2606-728278ccf4d0@gmail.com>
Date:   Tue, 7 Jan 2020 11:59:05 -0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.3.1
MIME-Version: 1.0
In-Reply-To: <20200107195606.GM29542@zn.tnic>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 1/7/2020 11:56 AM, Borislav Petkov wrote:
> On Tue, Jan 07, 2020 at 11:18:42AM -0800, Shiping Ji wrote:
>>> If Lei is coming back soon then it may be best to wait for her?
> 
> Whoops, I made her a "he". Lei, sorry about that.
> 
> You add your SOB under the original author's one:
> 
> From: Lei Wang <leiwang_git@outlook.com>
> 
> <commit message>
> 
> Signed-off-by: Lei Wang <leiwang_git@outlook.com>
> Signed-off-by: you
> 
> The kernel tree is full of examples. git log is your friend.
>> Yes, I followed the notes but apparently have missed some important
>> steps. I'll go the above document and get it fixed.
> 
> Yes, it would be time well spent if you intend to deal with submitting
> patches to the kernel in the future.
> 
> Thx.
> 

Thanks Boris for the clear instructions! I went through the document and understood the rationale of SOB now. I'll add mine in my next patches.

-- 
Best regards,
Shiping Ji

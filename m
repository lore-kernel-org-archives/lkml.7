Return-Path: <SRS0=facv=24=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AF3BCC282DD
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Jan 2020 19:01:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 80A072087F
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Jan 2020 19:01:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FnS9kng3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728676AbgAGTBM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 Jan 2020 14:01:12 -0500
Received: from mail-pg1-f169.google.com ([209.85.215.169]:39648 "EHLO
        mail-pg1-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728358AbgAGTBM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Jan 2020 14:01:12 -0500
Received: by mail-pg1-f169.google.com with SMTP id b137so304927pga.6
        for <linux-kernel@vger.kernel.org>; Tue, 07 Jan 2020 11:01:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=KL7wPr21JfmH2ZrLmhxKNh5vypd3qs9aYYpVHeAk1PY=;
        b=FnS9kng3mIaaN7CIxp2b1cfAjU0Mq/Ife4FrJCVVNcV4FmuslfF8d5oJWZp7GOQTZY
         5o4j97s20kgGkUo9mDYKwil2XqLy34EauuWNN3J3yxdiRS/cj8qYnecL9EyrNfdDplxh
         FE+215BYvGVh5sjvx6XB8KoxaqO9gr+oNnORpSiq/gr+K4UEKI5Nd6jIDfuWPc8ajHN6
         eiKaxoN6XZU12DgzRLDuBWBLIQYhbm3StiMjE6/WQEXMA6KZ66ariw0W8KYYLtdvo5m9
         a6+9tZZLXNOW8uD8X3rr9XL7SzVhklAvUn0v4m9yhIyHVXANPCiYAjmkfrvGj4kJ/36M
         ViFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=KL7wPr21JfmH2ZrLmhxKNh5vypd3qs9aYYpVHeAk1PY=;
        b=bYD4W2GyCKUdoOH+RKT1PgNemOKlqfCrBCmEug5Yvp4nXMWnhnbiFimK5KNcHssvhk
         D4WzcUn4yqtgmxoZU1c2AruGgVmbMFavRyaaMgig1ddpEB5VRR2+i3Q5ZYvS0hh52cpP
         uEmvW4l3M8eKlTaHQct1PkJbAAb0/Ke3Ow0brlpqiM84TxFrkDU+KpoYquBd3UES+vzd
         RLBr6a/gb7LrOzE5ubBoqiWsn38GMG/keo3rp70l/fYce6DkLUy88Zg1NGwXvi6V15t6
         cfPiGKJ8II2ApYM9D1gfcVYmqzqYJlFnnxd30AIf1Av1oeTawKMRl1FXrZh9o+iiOTuI
         RjcQ==
X-Gm-Message-State: APjAAAVS+6Oprbq7AQyLZNmQlACnnCrZkcGuKwmzmk1QoWUNvIJvegv3
        bZSjzPpQF6aBlkX9JmykvFkJqksR
X-Google-Smtp-Source: APXvYqw9dIT+IpGNKBl1zL5+g7t+bCA9xcWW0de/UZRm+B56BreqrFzdp4uVD570JqWDDyLu6DcAxg==
X-Received: by 2002:a63:1908:: with SMTP id z8mr982840pgl.350.1578423671574;
        Tue, 07 Jan 2020 11:01:11 -0800 (PST)
Received: from ?IPv6:2001:4898:d8:28:b920:9a21:10c:ddbd? ([2001:4898:80e8:8:3930:9a21:10c:ddbd])
        by smtp.gmail.com with ESMTPSA id r14sm311554pfh.10.2020.01.07.11.01.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 07 Jan 2020 11:01:11 -0800 (PST)
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
From:   Shiping Ji <shiping.linux@gmail.com>
Message-ID: <5a3188d8-e23a-b0de-bef7-ff60dda339ab@gmail.com>
Date:   Tue, 7 Jan 2020 11:01:10 -0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.3.1
MIME-Version: 1.0
In-Reply-To: <f56605f8-e49f-6b99-5735-b4bec75af9fd@broadcom.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 1/7/2020 10:55 AM, Scott Branden wrote:
> Lei/Shiping,
> 
> On 2020-01-07 10:49 a.m., Borislav Petkov wrote:
>> On Tue, Jan 07, 2020 at 09:57:26AM -0800, Scott Branden wrote:
>>> Hello EDAC Maintainers,
>>>
>>> Could somebody have a look at the DMC520 patch series that has been waiting
>>> for a response since November:
>>> https://patchwork.kernel.org/patch/11248785/
>> Well, the dt bindings stuff is still being discussed:
>>
>> https://patchwork.kernel.org/patch/11248783/
>>
>> Also, looking at this again, the patch authorship looks really fishy:
>>
>> Sender is
>>
>> From: Shiping Ji <shiping.linux@gmail.com>
>>
>> however, he doesn't have his SOB in there and previous iterations were
>> done with Lei Wang whose SOB *is* there so I dunno what's going on.
>>
>> *Especially* if Lei Wang is being added as a maintainer of that driver
>> by the second patch but he's not sending this driver himself. If this
>> driver is going to be orphaned the moment it lands upstream, I'm not
>> going to take it.
> Shiping/Lei could you please provide appropriate signed-off-by?
> Also, if you do not have an appropriate maintainer for the driver
> we have Yuqing Shen who can be maintainer of this driver.

Yes, signed-off-by is still Lei Wang, who is still the official maintainer of the driver.

Lei is currently in sick leave so I'm trying to complete the patches on her behalf. Please kindly let me know how to add my SOB there.

Thanks!

>> So at least those two things need to be fixed/clarified first.
>>
>> HTH.
>>
> 

-- 
Best regards,
Shiping Ji

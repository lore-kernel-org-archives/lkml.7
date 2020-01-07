Return-Path: <SRS0=facv=24=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A0C43C282DD
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Jan 2020 18:55:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7AFA52072A
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Jan 2020 18:55:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="Q57iKVYV"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728674AbgAGSzj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 Jan 2020 13:55:39 -0500
Received: from mail-wm1-f68.google.com ([209.85.128.68]:51326 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728358AbgAGSzh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Jan 2020 13:55:37 -0500
Received: by mail-wm1-f68.google.com with SMTP id d73so673879wmd.1
        for <linux-kernel@vger.kernel.org>; Tue, 07 Jan 2020 10:55:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=gdW12zHykwT9gXQ2GutX9cXAWDnAxLstuAPg8msRCNo=;
        b=Q57iKVYVmYZRnAIEMlGhCUBR3dOB6QHScJxSyRgZtl+1+k0rbltUro8ovHrSt5eIJb
         nvsH1rNsY8+f3A5KuKFD/v9k+59v1HM9Bngq9/oybxnoI0DLd2Zd8lO2JNoIyhWHd4p7
         RA+jOX7KffLx9NcI1I4SawOJLsEl4pEHWsGN0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=gdW12zHykwT9gXQ2GutX9cXAWDnAxLstuAPg8msRCNo=;
        b=N8YdldyPPu7ifp9z/BYNN0OkifT6h0Svnl3eyLhN/Fsh9WOZq5BGvd5TwjMpGfL7ZW
         900ZoGuCPBuO2HKmuyTp8AT8KTQXjluejNuV18e0h0dvkjXHzOcR22ytFeoBgwge6JtO
         jX1Mr5fKnurQlxjSG+IOQNqanamD3mbmd2yUZaJSUKu4Nt9/V8v5fvcTS7FukSczkAgM
         cOZJClG0sateH+TG8k1qYCBGZvHs/GMItBysWqqb66MEQ50jPJzTP9TC/p7Uu7eiVyfw
         76mgAvhNVQbeX9yXEOXEtUEnDXdm8PWVOASYAoKr5Qm9vByTghQH1q9vlWw2rJycLyeo
         k2uQ==
X-Gm-Message-State: APjAAAXw2GC9A5xPAPIFubsHArfNS4oXVfMZL+XLn5ZN+TtUosfrbLq4
        J9rJngkcCKiGI4jXCHRU0ubqUw==
X-Google-Smtp-Source: APXvYqwgcvkyjoG1ZSHDuX6NjkGZEW/hWJo5H1F7/tqLVY1GuGlZN/QCIS9gB70daEzeriWuXlv8VQ==
X-Received: by 2002:a05:600c:294:: with SMTP id 20mr433999wmk.97.1578423333414;
        Tue, 07 Jan 2020 10:55:33 -0800 (PST)
Received: from [10.136.13.65] ([192.19.228.250])
        by smtp.gmail.com with ESMTPSA id g25sm30992623wmh.3.2020.01.07.10.55.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 07 Jan 2020 10:55:32 -0800 (PST)
Subject: Re: EDAC driver for DMC520
To:     Borislav Petkov <bp@alien8.de>
Cc:     Mauro Carvalho Chehab <mchehab@kernel.org>,
        Tony Luck <tony.luck@intel.com>,
        Yuqing Shen <yuqing.shen@broadcom.com>,
        Lei Wang <lewan@microsoft.com>,
        James Morse <james.morse@arm.com>,
        Robert Richter <rrichter@marvell.com>,
        BCM Kernel Feedback <bcm-kernel-feedback-list@broadcom.com>,
        LKML <linux-kernel@vger.kernel.org>, shiping.linux@gmail.com
References: <bdb29d6d-bc63-cf68-0e32-556740537cd8@broadcom.com>
 <20200107184926.GL29542@zn.tnic>
From:   Scott Branden <scott.branden@broadcom.com>
Message-ID: <f56605f8-e49f-6b99-5735-b4bec75af9fd@broadcom.com>
Date:   Tue, 7 Jan 2020 10:55:27 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <20200107184926.GL29542@zn.tnic>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Lei/Shiping,

On 2020-01-07 10:49 a.m., Borislav Petkov wrote:
> On Tue, Jan 07, 2020 at 09:57:26AM -0800, Scott Branden wrote:
>> Hello EDAC Maintainers,
>>
>> Could somebody have a look at the DMC520 patch series that has been waiting
>> for a response since November:
>> https://patchwork.kernel.org/patch/11248785/
> Well, the dt bindings stuff is still being discussed:
>
> https://patchwork.kernel.org/patch/11248783/
>
> Also, looking at this again, the patch authorship looks really fishy:
>
> Sender is
>
> From: Shiping Ji <shiping.linux@gmail.com>
>
> however, he doesn't have his SOB in there and previous iterations were
> done with Lei Wang whose SOB *is* there so I dunno what's going on.
>
> *Especially* if Lei Wang is being added as a maintainer of that driver
> by the second patch but he's not sending this driver himself. If this
> driver is going to be orphaned the moment it lands upstream, I'm not
> going to take it.
Shiping/Lei could you please provide appropriate signed-off-by?
Also, if you do not have an appropriate maintainer for the driver
we have Yuqing Shen who can be maintainer of this driver.
>
> So at least those two things need to be fixed/clarified first.
>
> HTH.
>


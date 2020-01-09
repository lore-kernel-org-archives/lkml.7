Return-Path: <SRS0=a4+J=26=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4ECDFC33CA2
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Jan 2020 23:51:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 24E252077C
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Jan 2020 23:51:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1578613863;
	bh=ykUXH8SJ7WQHHZwVpL8LUMNyjd4pVU2K+MG0Pbbo/3Q=;
	h=Subject:To:Cc:References:From:Date:In-Reply-To:List-ID:From;
	b=VFQ5sAspsLpt6RJgDeR6lEfjCnZVFAa60ZTMgbAbJKlYeT2sI89AGwlW8U7z4NKaz
	 qhT72OuUJSVUZvc9fPaoubHE0KU/EKjpwrgTGCcGyEhk8OkRi8I53BtOz/xFfxqPYI
	 DG3R+Ih2wErzWIHOykxP2wIAGaU8M5lgnn04T2TU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729640AbgAIXvC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 Jan 2020 18:51:02 -0500
Received: from mail-io1-f65.google.com ([209.85.166.65]:46709 "EHLO
        mail-io1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729493AbgAIXvC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Jan 2020 18:51:02 -0500
Received: by mail-io1-f65.google.com with SMTP id t26so44513ioi.13
        for <linux-kernel@vger.kernel.org>; Thu, 09 Jan 2020 15:51:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=XmSLE2UFRfRMrqOUD2/xcSkD1bd36np80kHR612bvjA=;
        b=Tb+WHFX8eVVfPBC61iOxKAVASqGYU9JQWNVjQrlKLC+NAZ0qiXroclVl84ojhXiFVq
         z0D/fXSrR06QaET9gf62ySqcq2NGTVRTlyzYZ+Kwhb1CbYyYmIAoczVX8P/rIOhtSSe+
         9Vp8kh/Kw1Ujt3pz8MG6SMP+kwtFqpkD9LlLw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=XmSLE2UFRfRMrqOUD2/xcSkD1bd36np80kHR612bvjA=;
        b=NhVDFEGFy2oeenCvWz0H36YkqUB1rM23gqP4zROQN8GG+/qdUzJ518fk3LNYf8OOH1
         G41UTwahSvfQwztCYby80zXFo9hoAf0tHd0jHJ+O5D2OWise/cEUh5bQWFeDY14rgBH5
         Z568emg+/WhPAG4kKEVX0sq63ubrZ/Gl9rM7QNIhRchmOljFoRsmK11EnssHF7toOpfu
         z1dZnCzJTwQeuO6kouFH4pGghnVDT5lo62TJ1V/Yxbsl3QnNqyjzboXyTFgOmGg5Rr8w
         y7leBE2tX3LM/lUSXoXSfZ7PXD+XM2ZPoTuT1xS9CmLFtJwfy61Bww7S8N2uKC/HQkq1
         LgIg==
X-Gm-Message-State: APjAAAV4wMgqFzaL4c0D2mCQtV9twM7xcwiPNQinrBPQXMIj7zerrbSK
        0OaUUTMPmUsvRH0hGYCdr2KJ7Q==
X-Google-Smtp-Source: APXvYqwQgkVIojpGrUKkXmQA4w8X/Zv+cpiI22CrfDWtEkvUmq5+SH0J8qNsc8FDqyGlkG6ReZ13cQ==
X-Received: by 2002:a6b:7117:: with SMTP id q23mr62004iog.153.1578613861421;
        Thu, 09 Jan 2020 15:51:01 -0800 (PST)
Received: from [192.168.1.112] (c-24-9-64-241.hsd1.co.comcast.net. [24.9.64.241])
        by smtp.gmail.com with ESMTPSA id u10sm130038ilq.1.2020.01.09.15.51.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 09 Jan 2020 15:51:00 -0800 (PST)
Subject: Re: [PATCH v2] media: dvb_dummy_tuner: implement driver skeleton
To:     "Daniel W. S. Almeida" <dwlsalmeida@gmail.com>, mchehab@kernel.org,
        sean@mess.org, tglx@linutronix.de, gregkh@linuxfoundation.org
Cc:     linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-kernel-mentees@lists.linuxfoundation.org,
        Shuah Khan <skhan@linuxfoundation.org>
References: <20200109233757.734008-1-dwlsalmeida@gmail.com>
From:   Shuah Khan <skhan@linuxfoundation.org>
Message-ID: <74d3acbc-fa3c-7d5b-4132-42c47909c4b9@linuxfoundation.org>
Date:   Thu, 9 Jan 2020 16:50:59 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <20200109233757.734008-1-dwlsalmeida@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 1/9/20 4:37 PM, Daniel W. S. Almeida wrote:
> From: "Daniel W. S. Almeida" <dwlsalmeida@gmail.com>
> 

> Implement a dummy DVB tuner as part of ongoing work
> on a virtual DVB test driver under the 2020 Spring Linux
> Kernel Mentorship Program.
> 

Get rid of the above. Not relevant for the patch. No need to spin
v3 just for this change and you can make the with other changes
as you get comments from others.

> The virtual DVB test driver serves as a reference DVB driver and helps
> validate the existing APIs in the media subsystem. It can also aid developers
>   working on userspace applications.
> 
> This dummy tuner should support common TV standards such as DVB-T/T2/S/S2,
> ISDB-T and ATSC when completed.
> 
> For now, only a basic skeleton is available, most functions do nothing
> whatsoever.
> 
> Signed-off-by: Daniel W. S. Almeida <dwlsalmeida@gmail.com>

thanks,
-- Shuah


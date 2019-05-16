Return-Path: <SRS0=AMXA=TQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DAA50C04AAF
	for <linux-kernel@archiver.kernel.org>; Thu, 16 May 2019 15:09:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A971620657
	for <linux-kernel@archiver.kernel.org>; Thu, 16 May 2019 15:09:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="QQtT3MUo"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727595AbfEPPJq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 May 2019 11:09:46 -0400
Received: from mail-lf1-f66.google.com ([209.85.167.66]:34014 "EHLO
        mail-lf1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726703AbfEPPJq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 May 2019 11:09:46 -0400
Received: by mail-lf1-f66.google.com with SMTP id v18so2949297lfi.1
        for <linux-kernel@vger.kernel.org>; Thu, 16 May 2019 08:09:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=7fB9DlcVFOAT6LcVvHuzjF9RuGghiAlLNT1Szy+bvHA=;
        b=QQtT3MUoecbgLPAJBmgi/HgcDX42oA2UghCthloNZ1C2laHkrmgiQ6Tq2ndgNPo9ic
         GdRJaWixE63tfWlJdp52gMDb6upAh9yovQfON37akDcrQmbGp/kkZeQOgXWwN2Y3uN3N
         O8CMY99TXMt+Oxj94Gu4swr6le0eyqrXa4wLt8KwitVjTfJIkXNR5Cgi2PNvr+2BE4bQ
         gThCSeHVJKwKWN5V8Nw63PG5AxV8CwuOkoBx7FezQb0hYPie76L+g1TlYiZUOiH3va+X
         YrZW1uMFeb4k4Fa0OUqoIDvwI2wbhNoiZ2/jnmUY2GVPHa6WyVixXuzLmK18vO/LMd6Y
         YEAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=7fB9DlcVFOAT6LcVvHuzjF9RuGghiAlLNT1Szy+bvHA=;
        b=X+q45yDWW9AhFBCsR1Xw+QiDWyox4DrqL4xc14WInrr2MalO80i7pa4AUr7j5+G3Vy
         DjeDihx6QMWxtJ/gM2X/5C1zda0CcJbSUZzEfrirctQWJkkVGbVlwSoFHYcQxkxs9kwU
         HlRVgnFT8HAlkA2hkCu2bPqgtGr9vor6M3pXnaXzOxJS6WmPkBY7L03O6oJi2VHSMQfY
         rtxU1Hoe/WXpI4/LhHb+iTjfUQ5K9igypbC0lzVhn5K451DtE6efcRbvgYbtpWlRpzwO
         ug+5cxLmJwdsAMQk50cr+RWi5exSzZvXnKFfEhnQavbQrq0zp0SAIM6FT83CcolchtqT
         6ciQ==
X-Gm-Message-State: APjAAAWytINZKSEl3vCkLauO+5EssSwNdlwccPFkSGyf5PYW4Y7HQzeG
        8Xo16AxfS6Bjb96I+FlXvFvkZSJzCEQ=
X-Google-Smtp-Source: APXvYqxwiNJLKxtxCmE2ST2AE9Lmu5H++j8eE4QkIdwsCoxfpJYEwyGO1xHpDzV9MtN/IwdAOuFNIQ==
X-Received: by 2002:a19:3f4b:: with SMTP id m72mr24201853lfa.32.1558019380002;
        Thu, 16 May 2019 08:09:40 -0700 (PDT)
Received: from [192.168.27.209] ([37.157.136.206])
        by smtp.googlemail.com with ESMTPSA id t23sm1148857lfk.9.2019.05.16.08.09.38
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 16 May 2019 08:09:38 -0700 (PDT)
Subject: Re: [PATCH v2] media/doc: Allow sizeimage to be set by v4l clients
To:     Hans Verkuil <hverkuil@xs4all.nl>,
        Tomasz Figa <tfiga@chromium.org>,
        Stanimir Varbanov <stanimir.varbanov@linaro.org>
Cc:     Linux Media Mailing List <linux-media@vger.kernel.org>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <20190412155915.16849-1-stanimir.varbanov@linaro.org>
 <a1807c37-99cf-d1fa-bcb9-67af2935abaf@xs4all.nl>
 <ca0e2c94-cca9-567f-5376-f302f79f4ba7@linaro.org>
 <CAAFQd5DBUUAPV0_=thmRBTFqJE+Nd4LZRzZE20rR0D8d7Cjz5g@mail.gmail.com>
 <cd7baea0-3893-7471-2e86-9cc6730843e3@xs4all.nl>
From:   Stanimir Varbanov <stanimir.varbanov@linaro.org>
Message-ID: <49fd2002-8723-2f00-c972-8d605561b29a@linaro.org>
Date:   Thu, 16 May 2019 18:09:35 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <cd7baea0-3893-7471-2e86-9cc6730843e3@xs4all.nl>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Hans,

On 5/16/19 1:40 PM, Hans Verkuil wrote:
> On 5/16/19 11:56 AM, Tomasz Figa wrote:
>> On Thu, May 16, 2019 at 5:09 PM Stanimir Varbanov
>> <stanimir.varbanov@linaro.org> wrote:
>>>
>>> Hi Hans,
>>>
>>> On 5/14/19 11:54 AM, Hans Verkuil wrote:
>>>> Hi Stanimir,
>>>>
>>>> On 4/12/19 5:59 PM, Stanimir Varbanov wrote:
>>>>> This changes v4l2_pix_format and v4l2_plane_pix_format sizeimage
>>>>> field description to allow v4l clients to set bigger image size
>>>>> in case of variable length compressed data.
>>>>
>>>> I've been reconsidering this change. The sizeimage value in the format
>>>> is the minimum size a buffer should have in order to store the data of
>>>> an image of the width and height as described in the format.
>>>>
>>>> But there is nothing that prevents userspace from calling VIDIOC_CREATEBUFS
>>>> instead of VIDIOC_REQBUFS to allocate larger buffers.
>>>
>>> Sometimes CREATEBUFS cannot be implemented for a particular fw/hw.
>>>
>>> CC: Tomasz for his opinion.
>>>
>>
>> Thanks Stanimir.
>>
>> Actually, if called at the same point in time as REQBUFS, CREATE_BUFS
>> doesn't really differ to much, except that it gives more flexibility
>> for allocating the buffers and that shouldn't depend on any specific
>> features of hardware or firmware.
>>
>> Actually, one could even allocate any buffers any time regardless of
>> hardware/firmware support, but the ability to use such buffers would
>> actually depend on such.
>>
>> Perhaps we should just let the drivers return -EBUSY from CREATE_BUFS
>> if called at the wrong time?
>>
>>>>
>>>> So do we really need this change?
>>>>
>>
>> Yes, because this has worked like this all the time, but it was just
>> not documented. Disallowing this would break quite a bit of existing
>> userspace.
> 
> Which drivers allow this today? I think that would be useful information
> for the commit log of a v4 of this patch.
> 

I'd say s5p-mfc and mtk-vcodec at least.

-- 
regards,
Stan

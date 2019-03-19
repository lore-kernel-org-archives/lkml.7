Return-Path: <SRS0=B1dt=RW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 66AEEC43381
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Mar 2019 02:26:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 33F3D20700
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Mar 2019 02:26:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mRdv/K0a"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727557AbfCSC0F (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Mar 2019 22:26:05 -0400
Received: from mail-pf1-f181.google.com ([209.85.210.181]:34018 "EHLO
        mail-pf1-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726884AbfCSC0F (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Mar 2019 22:26:05 -0400
Received: by mail-pf1-f181.google.com with SMTP id v64so12610923pfb.1;
        Mon, 18 Mar 2019 19:26:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=BJVdEsQwZZJCtbo/HrRHA1ZgB54q5sGlswTQWhaArbs=;
        b=mRdv/K0a0tq3pg6vwrjxjUTDcCmYnDfRZDUzziWxrDaDDV4Xzy9+bnz+djWz50lp1F
         Y58VKj9UT7HAB1KECkyxfxADE8OWjBxapDWmM8+SElyyAAMaN3L8sjPk+PDV5TptO6ta
         KMFSEUMaq8B0yxFtOu9joKUEYIOhJr1xUaJpWAFS5MHuXama3NCdf/lvoJc/eSIkwcBq
         PBgLY2VYAtoDsQ+1XffI8mvw2fgCFbJyDKe29W9/NNUNE2PBDO+Nh2cHMd6zWKIjFweT
         57caZ/w6TA63bs1DiwrgUxbhAEimfehqmIDefNSFmp0uNXxI7hqeKjeCM9yQQc3JDVXD
         yDnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:subject:to:cc:references:from:message-id
         :date:user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=BJVdEsQwZZJCtbo/HrRHA1ZgB54q5sGlswTQWhaArbs=;
        b=ORLwXWiJ+r9P9oKC8bp+OVCbYNWN6PWyvgRUYjzseaZrGwz0t+DD7/PorM4ZiYjq3/
         pqrsxSJwcu3SWns9/KFebS1NZvb0HLzbhE8PpKutjenvMrImb6Zz+Ks/JnAAtlD3JZJ0
         BTdYoAnvFONtjqYkALdBlo2FheKkobg3kOEI9eZ2Q+lmuvUqOalo3LZRnXnXwaV04wr5
         9YMenBIjAcmNlW/Vd8EmCow4RtSqi6+2O1mKzXqiXWIrIR7aiEehK7maJEkziKHXWzRi
         vGLIRIXxdDwzsghLDwVWejMktlrlJckdvdwMfPYiMc9n5Q6geHu8PzKUHQWTSo4DR0Ru
         AG5g==
X-Gm-Message-State: APjAAAXjUJQ3/ez0SCDB5fJaAKhHeuSOpNX3jEUbo6Lj86k9eGHq0YUr
        e60HVBrYRFsy3QLcNmSPiX1oBB9U
X-Google-Smtp-Source: APXvYqzkzjqklP9rq5fIgSP8rOkhg1YKuFv4jtiR/cvFaADhYF9VAbyrhX8IfcD2XnX8rCfXSKz+Iw==
X-Received: by 2002:a62:5c87:: with SMTP id q129mr21815791pfb.180.1552962364278;
        Mon, 18 Mar 2019 19:26:04 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id i10sm13977816pgs.26.2019.03.18.19.26.03
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 18 Mar 2019 19:26:03 -0700 (PDT)
Subject: Re: [PATCH 4.20 00/52] 4.20.17-stable review
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org
Cc:     torvalds@linux-foundation.org, akpm@linux-foundation.org,
        shuah@kernel.org, patches@kernelci.org,
        ben.hutchings@codethink.co.uk, lkft-triage@lists.linaro.org,
        stable@vger.kernel.org
References: <20190318083843.398913295@linuxfoundation.org>
From:   Guenter Roeck <linux@roeck-us.net>
Message-ID: <c00e74f6-b539-aaec-3754-58cdc934eb4a@roeck-us.net>
Date:   Mon, 18 Mar 2019 19:26:02 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.1
MIME-Version: 1.0
In-Reply-To: <20190318083843.398913295@linuxfoundation.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/18/19 2:24 AM, Greg Kroah-Hartman wrote:
> ------------------
> NOTE, this is going to be the LAST 4.20.y release.  After this one, 4.20
> will be end-of-life.  Please move to the 5.0.y tree at this point in
> time, or let me know why that is not possible.
> ------------------
> 
> This is the start of the stable review cycle for the 4.20.17 release.
> There are 52 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Wed Mar 20 08:38:27 UTC 2019.
> Anything received after that time might be too late.
> 

Build results:
	total: 159 pass: 159 fail: 0
Qemu test results:
	total: 345 pass: 345 fail: 0

Guenter

Return-Path: <SRS0=B1dt=RW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5D57FC43381
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Mar 2019 02:25:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2C84F20700
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Mar 2019 02:25:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="pyRnsViI"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727662AbfCSCZi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Mar 2019 22:25:38 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:38557 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726884AbfCSCZh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Mar 2019 22:25:37 -0400
Received: by mail-pf1-f196.google.com with SMTP id n125so12600167pfn.5;
        Mon, 18 Mar 2019 19:25:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=adTl3S5yUGVl7gawHx4d375DtvCwDWIN6qN1d8VjaTI=;
        b=pyRnsViIkTM5u4obBxrZL2q+EjzgNa4cBurLtpfcv5HC/6OIbKQvzwRNLlATLdorjX
         b2gYTZK9+z+8ZQqjyt9Soo7AT9uyxqhO3e5LT8xA6IAjUbyGCbzoTyS3U6+6iuVGSW+U
         prXuN4W7ofiCxKnFTb+eFV8A5QxgnET5wwWaUvS2b0v0bTfeHouf5yzSVCnLcUPS0URm
         yWFBInFDFD0l8himus2ZMUdRiTpkp/RPPKCbGgbpgOUzGcfxh26Q/hIy47Axuu+YU+Rl
         2ac4wnuOGv5Z/JoT/7ea7Fasvg4HhDgSEFWkUWPPiij73Fo3Uf86EiQc0MaO0b+BSPhr
         KKeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:subject:to:cc:references:from:message-id
         :date:user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=adTl3S5yUGVl7gawHx4d375DtvCwDWIN6qN1d8VjaTI=;
        b=NyqJaeIJB3fx2h5xux91nJewLvJtJCs1zxT7P7JuDLxDhEcSCtIA2J0tQx1vejcNTW
         jFHRB5B1ysBu81Fubz0OnHecnOvql/UAfIawWcpp/1ZItb69n3Uq94WF8l74e26F0mrw
         vAyLj88nUr10ZEk2hdMZjcK/xVNRCPYHKg04Xp6d9eaZytRH5hetsdvY+o0Q+cnNSMlo
         PijK3IGwak5b/Z3Bprgt5poO0YyggAYHhBHtCbk+MN+ZMg/asoHEvkGmc7Ha99jzk0nB
         upv+lGY6qm30JMlA1LbAGrAZPpFciJpUqTYuTCBRoil5AE/AqnvDQBAJ5A2IiY3j1GTL
         VC3Q==
X-Gm-Message-State: APjAAAWJsaxITcBgtEBl+cX4l9m7Oo2Vd2OTtU0gTzFwtFcOgCNpL9A2
        IoTJZGzxHGHpQA8lIn66u4CL9OzJ
X-Google-Smtp-Source: APXvYqwiCfHdSa2+QijrTGQjSgdR2r9nA5/7of/gSLmurXn8rIQ/jzEU/TGYqTgK2918CtR9QXK7Rw==
X-Received: by 2002:a17:902:234b:: with SMTP id n11mr23320232plg.89.1552962336511;
        Mon, 18 Mar 2019 19:25:36 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id h9sm21969890pgk.22.2019.03.18.19.25.35
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 18 Mar 2019 19:25:35 -0700 (PDT)
Subject: Re: [PATCH 4.19 00/52] 4.19.30-stable review
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org
Cc:     torvalds@linux-foundation.org, akpm@linux-foundation.org,
        shuah@kernel.org, patches@kernelci.org,
        ben.hutchings@codethink.co.uk, lkft-triage@lists.linaro.org,
        stable@vger.kernel.org
References: <20190318084013.532280682@linuxfoundation.org>
From:   Guenter Roeck <linux@roeck-us.net>
Message-ID: <746c3e08-c382-df46-70fd-dd72012c00ea@roeck-us.net>
Date:   Mon, 18 Mar 2019 19:25:34 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.1
MIME-Version: 1.0
In-Reply-To: <20190318084013.532280682@linuxfoundation.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/18/19 2:24 AM, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 4.19.30 release.
> There are 52 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Wed Mar 20 08:39:59 UTC 2019.
> Anything received after that time might be too late.
> 


Build results:
	total: 156 pass: 156 fail: 0
Qemu test results:
	total: 345 pass: 345 fail: 0

Guenter

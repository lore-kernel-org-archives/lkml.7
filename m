Return-Path: <SRS0=B1dt=RW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C4735C10F00
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Mar 2019 02:25:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9603B20700
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Mar 2019 02:25:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EOrryWLS"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727584AbfCSCZK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Mar 2019 22:25:10 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:43250 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726884AbfCSCZK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Mar 2019 22:25:10 -0400
Received: by mail-pg1-f196.google.com with SMTP id l11so12727527pgq.10;
        Mon, 18 Mar 2019 19:25:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=cj0BROTwWYZVVRLJZ/ByPyaQwjge1zj8VJ28ghnqvAA=;
        b=EOrryWLS/wv00Gsub5ttHJjzuLzBnaVV6Kf4/OTLgmDFpwKUR6m7sMvTJvxabd9gxL
         QMNp+GQb9twNRQexbnZghCoQ2IPawp0WhDPqeTws/syMGa8P/JPV+z5Vox2nu78inCLG
         6TZIZyNX3UsOhkdrdm5sx06aKDZW7OOOeEl56rD0pcjwBMJ3LaGK19mp3+aZzqgvKpZ6
         uRA7pphMt0BUP/uXyKs/Pl8NssQpcya4NnNSgGmaH7w0dV8cSRZ+Gb2wdDI1dxBq1Ycv
         OYA3KXdg6fkbl2weNLYX+x7JT7UNs5eb1fCHoOxzrgdlk2r1Cgy2hvJ2iqZV5CxPtlkH
         c2NA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:subject:to:cc:references:from:message-id
         :date:user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=cj0BROTwWYZVVRLJZ/ByPyaQwjge1zj8VJ28ghnqvAA=;
        b=VxxU3KER34qDok1zt6M4yq1po7omg8UfY73ZDnYmhLiK3x327G/3xd6TKDoBpxGJEY
         OBZ9AE4UaHT9KOZ4KmR4Y4hsC5T2xjoDv1KDrut8W47XbLZ8npgxuzAC4uZMv4FSApNs
         wt5rVrqx2qCTjsgAresz9T1CoJ8no4x1aeIhuK0w2xG7uSogwPiGPBMqtnrz/ENDBarF
         EAQuaSi0qB2iMt5TCGnjoZFsPaa2AVrFy8C5GFiIKrepLOjwmnZC2JXer0MQW1L3+8iz
         F20IE6rSh1zdFKiKhG/9msMph1+wKy6kngvf9KdaZcbmtEkqCVel8sUoFMfi3POQw/bJ
         maQg==
X-Gm-Message-State: APjAAAVTVqiHlbMqCpWrM+vjHTEzRLTAx233A2EKHata4UjmLSLdHf/U
        qDLAqwo0guD2yC42pyYia2CL+jrw
X-Google-Smtp-Source: APXvYqyiENVLeUCQ2BvE4RylRaidXdwNNVCto+Sdshhx4xpHTBeO5lvb5Pgg3ggsw3zmPXm2A1J7ew==
X-Received: by 2002:a17:902:2aa6:: with SMTP id j35mr22101213plb.56.1552962309370;
        Mon, 18 Mar 2019 19:25:09 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id v18sm14418101pfm.165.2019.03.18.19.25.08
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 18 Mar 2019 19:25:08 -0700 (PDT)
Subject: Re: [PATCH 4.14 00/34] 4.14.107-stable review
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org
Cc:     torvalds@linux-foundation.org, akpm@linux-foundation.org,
        shuah@kernel.org, patches@kernelci.org,
        ben.hutchings@codethink.co.uk, lkft-triage@lists.linaro.org,
        stable@vger.kernel.org
References: <20190318084144.657740413@linuxfoundation.org>
From:   Guenter Roeck <linux@roeck-us.net>
Message-ID: <09b796e0-0162-4e5f-5d63-e5e8fef07292@roeck-us.net>
Date:   Mon, 18 Mar 2019 19:25:07 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.1
MIME-Version: 1.0
In-Reply-To: <20190318084144.657740413@linuxfoundation.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/18/19 2:25 AM, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 4.14.107 release.
> There are 34 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Wed Mar 20 08:41:26 UTC 2019.
> Anything received after that time might be too late.
> 

Build results:
	total: 172 pass: 172 fail: 0
Qemu test results:
	total: 329 pass: 329 fail: 0

Guenter

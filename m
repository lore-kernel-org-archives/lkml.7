Return-Path: <SRS0=PPSE=ZM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F1330C432C3
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Nov 2019 14:17:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B3A81224B1
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Nov 2019 14:17:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=raspberrypi.org header.i=@raspberrypi.org header.b="iPk4YXi5";
	dkim=pass (2048-bit key) header.d=raspberrypi.org header.i=@raspberrypi.org header.b="UdB1lz8i"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731240AbfKTORx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Nov 2019 09:17:53 -0500
Received: from mx08-00252a01.pphosted.com ([91.207.212.211]:50934 "EHLO
        mx08-00252a01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729000AbfKTORx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Nov 2019 09:17:53 -0500
X-Greylist: delayed 362 seconds by postgrey-1.27 at vger.kernel.org; Wed, 20 Nov 2019 09:17:51 EST
Received: from pps.filterd (m0102629.ppops.net [127.0.0.1])
        by mx08-00252a01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id xAKE7rRP029655
        for <linux-kernel@vger.kernel.org>; Wed, 20 Nov 2019 14:11:48 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=raspberrypi.org; h=subject : to :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=pp;
 bh=/at8uXIrARqtgojJ1uqk2uttbAL7Vve/nUl5o5grkME=;
 b=iPk4YXi5TtZqqzZEnVHVh/T9CVXQQQW0vCtU71hnYjztWvelNo/ZaaAufROx85r7APhI
 ZgQZYopDUCJwclPTYmWYngInGSPF+/gRxb1UMqEj5u3PoHrbdheQ5yyO2IUkwZT2HQl4
 lbNcz9KIIjQ6HRpfNlJXvGFlQDGtaWT6ChP4KU8KMV8KfNn+cRNd/sJ3IJryeCM1EteJ
 zOTxER3V98drx3AdYBx+J752kCu0ipV9RyZV2fUGRnS0uCB+w3F8SiMUGNBR/+C/0JL/
 4nAsHn6XiqeZ8Q8cAryGJYtnl8ffr1SWIrcj3y0fLKC+teOYpmY23PAGoG+B0vUrNGHV pg== 
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com [209.85.128.72])
        by mx08-00252a01.pphosted.com with ESMTP id 2wa6fr24hb-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=OK)
        for <linux-kernel@vger.kernel.org>; Wed, 20 Nov 2019 14:11:48 +0000
Received: by mail-wm1-f72.google.com with SMTP id g14so5182773wmk.9
        for <linux-kernel@vger.kernel.org>; Wed, 20 Nov 2019 06:11:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=raspberrypi.org; s=google;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=/at8uXIrARqtgojJ1uqk2uttbAL7Vve/nUl5o5grkME=;
        b=UdB1lz8im6SBGQpcvQzeAhTAlmwVFuGiMZKvwLQx3xcB1KmaMmmhO5EczwU/6YUQyo
         l6VxSMUHLWSXfrlHjEBD8zaSxCimdN3I1/y2HuD3DR8aVtatPRGx4Tfuuwyx+o8KgezN
         wRH0LQXLZvXSu2hhXNc4RHcLjPygwY2ju9OW2Ppqm9Y2z5lbv4/SL6rhPKRCZ0vTJlnB
         6Ipfw41lIejaJ5MR/E8Vrtrqab5N3vNKa97FFUnZ9Wtvc/aEJCM8L9IO1N0ue29BMLgr
         TIBOY6N2LhXvEXLaKglqQa1k5UqK3JHGFVTe2RR+HhN1PoIj3HYMk7//t4+deyvr8h+x
         6PBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=/at8uXIrARqtgojJ1uqk2uttbAL7Vve/nUl5o5grkME=;
        b=h4z4eMbjd722KzFEL26cYQCW0/agHLzE/arLvNAzZ8gT61/4vNj0IExzBJJ1Ld/zJr
         71/LiVAjrqUtFfBqG9plP/LIgNC9DlQcZwsXcRvTn8PRDbY02ZNptOoGZeATZ0PGPHc2
         7v5f1yStUdkc5xojsO9z/bYkqz/ArlzUb7MLT4IKytk0AuZ9NhegyOUe1FKcmfOiXY2o
         XQ3CAS3gNGcq3BowxpnyOxUunPmrmVVj4X6m1t9XHdKnZwsLjpWolQXJAnF6FeMI2AEm
         aLR2B6OX2KO6zFDsldqjLaIk2p9VxHyZ9nl3TDRX57ExomY+Z5y4sesnDyVHK0D4NzpA
         qOyQ==
X-Gm-Message-State: APjAAAXdw5HbJ4cfTz4285rIadJL3bHRbkVJCL0ARQmNIymr3giznPXD
        tcx4eXDrDgHg1QJZY4j6ootdYDVhGJvnhLsFpbACLq5wsRafocHzstb/teVZBYrg/rgoaVUCSnT
        ard31yUtnFHo9yAUT6qKdKrdl
X-Received: by 2002:adf:9f52:: with SMTP id f18mr3505261wrg.51.1574259107298;
        Wed, 20 Nov 2019 06:11:47 -0800 (PST)
X-Google-Smtp-Source: APXvYqxZRI7Eod4HiL1Kayr9EEsJm+aehAb4aIL5/d8hMf6YjOsGz3IbTUtcXBU9l53Ogr+zvywRXQ==
X-Received: by 2002:adf:9f52:: with SMTP id f18mr3505217wrg.51.1574259106978;
        Wed, 20 Nov 2019 06:11:46 -0800 (PST)
Received: from ?IPv6:2a00:1098:3142:14:d54d:f6e0:3aef:f94? ([2a00:1098:3142:14:d54d:f6e0:3aef:f94])
        by smtp.gmail.com with ESMTPSA id 19sm35289172wrc.47.2019.11.20.06.11.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 20 Nov 2019 06:11:46 -0800 (PST)
Subject: Re: BCM2835 maintainership
To:     Stefan Wahren <wahrenst@gmx.net>, linux-kernel@vger.kernel.org,
        linux-rpi-kernel@lists.infradead.org
References: <68580738-4ecf-3bb7-5720-6e5b6dafcfeb@gmx.net>
From:   Phil Elwell <phil@raspberrypi.org>
Message-ID: <913cdc73-4b4e-5ea7-80c6-f32d0340f37c@raspberrypi.org>
Date:   Wed, 20 Nov 2019 14:11:46 +0000
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <68580738-4ecf-3bb7-5720-6e5b6dafcfeb@gmx.net>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.95,18.0.572
 definitions=2019-11-20_04:2019-11-15,2019-11-20 signatures=0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Stefan,

On 20/11/2019 11:38, Stefan Wahren wrote:
> Hello,
> 
> i need to announce that i step back as BCM2835 maintainer with the end
> of this year. Maintainership was a fun ride, but at the end i noticed
> that it needed more time for doing it properly than my available spare time.
> 
> Nicolas Saenz Julienne is pleased be my successor and i wish him all the
> best on his way.
> 
> Finally i want to thank all the countless contributors and maintainers
> for helping to integrate the Raspberry Pi into the mainline Kernel.

I'd like to take this opportunity to thank you for being such a champion 
of BCM2835+ and Raspberry Pi. It must have felt like a thankless task at 
times, but you leave the upstream Pi support in a much better state than 
when you started.

Welcome Nicolas - you've been contributing to the mainline kernel almost 
as long as I've been at Raspberry Pi, and you're no stranger to the Pi 
repos on GitHub. I look forward to working with you further.

Phil

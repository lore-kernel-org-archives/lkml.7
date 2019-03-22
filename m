Return-Path: <SRS0=oArh=RZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 01765C4360F
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 13:44:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C45F22147A
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 13:44:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZJCSqdsK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728199AbfCVNoM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Mar 2019 09:44:12 -0400
Received: from mail-pg1-f180.google.com ([209.85.215.180]:47026 "EHLO
        mail-pg1-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728010AbfCVNoM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Mar 2019 09:44:12 -0400
Received: by mail-pg1-f180.google.com with SMTP id a22so1538211pgg.13;
        Fri, 22 Mar 2019 06:44:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=JaIROm5iPV6migPVIuoFe+AYj8IES3tBlNMXrX9mZHo=;
        b=ZJCSqdsKyr552kXuRij2qJGRpMOeCJd68IJ41ABB4scm/gNpm8RK1B76E1rEWCZm3Y
         uFzLoReecEtiUPEAf0iGzxXypaPUzv5BllI+VPY7VWTZTNA6yfzXwwwcmrviBveZ/w5O
         xUNIK+sFhwynJPSRzhEXrz+t1T+A2R+ejSGO6Enq8hcW192wphZc20Crm2m9ntY9H8Rn
         oJyQTqD8l6fxKHNuYGCg0k21nI97J+50gfzutEWifq+D4dxfjS/qpdQcvAud61mW3k90
         K9A+IoI5YhbrrkFcKwAeo3lBkGfr04YylPBiDgyUfmGIBDRtND/bDHvzaI2R4/UmMM2e
         23NQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:subject:to:cc:references:from:message-id
         :date:user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=JaIROm5iPV6migPVIuoFe+AYj8IES3tBlNMXrX9mZHo=;
        b=Ym1dX37FHePvY2DOcokrH8I3hDoT5ByntifhJm+v8OsR11Jzqt63iwFEdzB58+XW5B
         K+LnkI9cSEA9vZpOZXsJzoYr6UbMgKFCp/QFj9QyQ3tTMmU5wI3XvVKSIyQIkVjIOS3X
         k32MQUjqSwWNsNbzxPIn8Tj31H5r3/D57CgeNQ7hjvce32UVhgA+Vt5TKtsoj2OdimQK
         gCY9A2jwcWsB+TSujHLlhQe/fRhwzj3gt5tNoHUdGWz0Qcjxa4+xp/AqLebDh4qZTIz8
         EEd40xax0n3sGt3vYfmH9BPk/0FxrbRXgCV/sm48kob0Jy6wcT72U1NxXaDy1hYMVPCv
         RPGA==
X-Gm-Message-State: APjAAAU3WxKlNDNKRG1mpboHglz5SLh1LX7hW8u1ski61ZdVLly+iNuR
        yI0mL80iNLuYC17CPWgolQY=
X-Google-Smtp-Source: APXvYqztxGqVZeyOelV2nX+uysbsLnobY2/S9sm7rJhcgxciVg7ALny4q0hjYpRwQHoe8G3MvhUXUg==
X-Received: by 2002:a63:2a86:: with SMTP id q128mr9043108pgq.424.1553262251396;
        Fri, 22 Mar 2019 06:44:11 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id c131sm6235960pfc.11.2019.03.22.06.44.09
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 22 Mar 2019 06:44:09 -0700 (PDT)
Subject: Re: [PATCH 3.16 00/16] 3.16.64-rc1 review
To:     Ben Hutchings <ben@decadent.org.uk>, linux-kernel@vger.kernel.org,
        stable@vger.kernel.org
Cc:     torvalds@linux-foundation.org, akpm@linux-foundation.org,
        Denis Kirjanov <kda@linux-powerpc.org>
References: <lsq.1553232017.771830163@decadent.org.uk>
From:   Guenter Roeck <linux@roeck-us.net>
Message-ID: <917fab4a-f8b1-760c-2e7d-22156f580276@roeck-us.net>
Date:   Fri, 22 Mar 2019 06:44:08 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.1
MIME-Version: 1.0
In-Reply-To: <lsq.1553232017.771830163@decadent.org.uk>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/21/19 10:20 PM, Ben Hutchings wrote:
> This is the start of the stable review cycle for the 3.16.64 release.
> There are 16 patches in this series, which will be posted as responses
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Mon Mar 25 18:00:00 UTC 2019.
> Anything received after that time might be too late.
> 

Build results:
	total: 137 pass: 136 fail: 1
Failed builds:
	i386:tools/perf
Qemu test results:
	total: 222 pass: 221 fail: 1
Failed tests:
	arm:midway:multi_v7_defconfig:mem2G:ecx-2000:initrd

The failed qemu test simply hangs. The test passes with v3.16.63.
I started a bisect.

Guenter


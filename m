Return-Path: <SRS0=GVTe=2R=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5E4B2C2D0C0
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Dec 2019 03:36:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1FA4420643
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Dec 2019 03:36:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="Qd30cIky"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727130AbfL0DgU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 26 Dec 2019 22:36:20 -0500
Received: from mail-pl1-f196.google.com ([209.85.214.196]:41110 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727000AbfL0DgU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Dec 2019 22:36:20 -0500
Received: by mail-pl1-f196.google.com with SMTP id bd4so11210764plb.8
        for <linux-kernel@vger.kernel.org>; Thu, 26 Dec 2019 19:36:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google;
        h=subject:to:cc:references:from:autocrypt:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=fLq96bOfsAzmbSOIUyDYSk8L7LxVPi35XEytAjg4LuM=;
        b=Qd30cIkyA8SKvQi0RvQCvKt7QvsnrdmHr6BufKwyWxkABdiHAMZ4LBivJLmuPDCP1O
         BEIVChvSf5TfrpEetcHbLhCg2OrdjBJuVff+9LRTg82UOLXroTPguXo33gQJ3+NAwwLB
         ltJBycTiwtWYaHF4F2ZgOg3au37yN9LB1GtvY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:autocrypt
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=fLq96bOfsAzmbSOIUyDYSk8L7LxVPi35XEytAjg4LuM=;
        b=CumWcNYnaaoWGFSnazutLeCfTu2Gc4xVTf9W1MrVx6m6JfdZ39T5EzpOgl+THR4qMp
         VvrPG9VFpAn2TzOSOoMGP0b/aEFuieDE3Q3Q0RnZfYHuW32cBPdg5aIZe+0e7XRge5ux
         gj2mz4WiWbc7lZDNGMemyidVyhnVqHFgtTiqJ+MjloAwXjOvHgmtVtE4Js2cEeNmqz7g
         xAoXneytJRgZSx84awSA3IUoHfBt0zuOZPqD8G/mPDxB3FZumzsYE/JiB1W0Z5e6Qz7r
         zNY+slsFIaUIQnsKJGq9K+szoSe9ItEWHzAVaYdp+wQ/pe6q3WnAS2e7M6djAIT8ojUF
         RXAQ==
X-Gm-Message-State: APjAAAWoeORAtZC+L8JFAqdWP9HMDiXdu981cqDR4fca6CGkR6fFBtuM
        y5nvenW3i4zTqa14+LBc8fv0tw==
X-Google-Smtp-Source: APXvYqz/z/s8kSHuJyZyHEjj+uFSNBXKEzYgNH9kRupx8P0DjqaQBacLL815WhavxOy1+Okpr3Ogdw==
X-Received: by 2002:a17:90a:8912:: with SMTP id u18mr23351899pjn.21.1577417779227;
        Thu, 26 Dec 2019 19:36:19 -0800 (PST)
Received: from [10.230.28.123] ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id d23sm37569846pfo.176.2019.12.26.19.36.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 26 Dec 2019 19:36:18 -0800 (PST)
Subject: Re: [PATCH 0/2] phy: brcm-sata: Support for 7216
To:     Florian Fainelli <f.fainelli@gmail.com>, kishon@ti.com
Cc:     Jens Axboe <axboe@kernel.dk>, Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Al Cooper <alcooperx@gmail.com>,
        Ray Jui <ray.jui@broadcom.com>, Tejun Heo <tj@kernel.org>,
        Fengguang Wu <fengguang.wu@intel.com>,
        Arnd Bergmann <arnd@arndb.de>,
        "open list:LIBATA SUBSYSTEM (Serial and Parallel ATA drivers)" 
        <linux-ide@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>,
        bcm-kernel-feedback-list@broadcom.com
References: <20191210200852.24945-1-f.fainelli@gmail.com>
From:   Florian Fainelli <florian.fainelli@broadcom.com>
Autocrypt: addr=florian.fainelli@broadcom.com; keydata=
 mQENBFPAG8ABCAC3EO02urEwipgbUNJ1r6oI2Vr/+uE389lSEShN2PmL3MVnzhViSAtrYxeT
 M0Txqn1tOWoIc4QUl6Ggqf5KP6FoRkCrgMMTnUAINsINYXK+3OLe7HjP10h2jDRX4Ajs4Ghs
 JrZOBru6rH0YrgAhr6O5gG7NE1jhly+EsOa2MpwOiXO4DE/YKZGuVe6Bh87WqmILs9KvnNrQ
 PcycQnYKTVpqE95d4M824M5cuRB6D1GrYovCsjA9uxo22kPdOoQRAu5gBBn3AdtALFyQj9DQ
 KQuc39/i/Kt6XLZ/RsBc6qLs+p+JnEuPJngTSfWvzGjpx0nkwCMi4yBb+xk7Hki4kEslABEB
 AAG0MEZsb3JpYW4gRmFpbmVsbGkgPGZsb3JpYW4uZmFpbmVsbGlAYnJvYWRjb20uY29tPokB
 xAQQAQIArgUCW382iBcKAAG/SMv+fS3xUQWa0NryPuoRGjsA3SAUAAAAAAAWAAFrZXktdXNh
 Z2UtbWFza0BwZ3AuY29tjjAUgAAAAAAgAAdwcmVmZXJyZWQtZW1haWwtZW5jb2RpbmdAcGdw
 LmNvbXBncG1pbWUICwkIBwMCAQoFF4AAAAAZGGxkYXA6Ly9rZXlzLmJyb2FkY29tLmNvbQUb
 AwAAAAMWAgEFHgEAAAAEFQgJCgAKCRCBMbXEKbxmoFYGB/9qN5VL6f/88+qtDaDhUKvwBgF8
 koryGCH/gw6FBW5h5hwW0m6946WnsBnqKnZ8OYr8qsCgeJewCh0BEN9rIg8SC5oU7WdcmNg5
 KTv4/V1CmBo6dQaSHA8yQoeHsrw0gQ9HK4EYjhAU60RYXxX7/LFAy0rJMLf0qGKdWW2f5EkN
 dS5GwWOrTp477WL2g+R0khhP57qpejxlMN+Mtvin52UjbAcr1PAx8Zt2rXpFIZsXVWADpZDd
 qIb6PZPdcP/lD1v5it4sTN7D27FgjvbvAgj/D3NmyOjIUsbN9ZDJDfgv431RsJ9LOd6ySaNr
 yuje7L0dbiYrcOi3CN6S+zE1UJsLuQENBFPAG8EBCACsa+9aKnvtPjGAnO1mn1hHKUBxVML2
 C3HQaDp5iT8Q8A0ab1OS4akj75P8iXYfZOMVA0Lt65taiFtiPT7pOZ/yc/5WbKhsPE9dwysr
 vHjHL2gP4q5vZV/RJduwzx8v9KrMZsVZlKbvcvUvgZmjG9gjPSLssTFhJfa7lhUtowFof0fA
 q3Zy+vsy5OtEe1xs5kiahdPb2DZSegXW7DFg15GFlj+VG9WSRjSUOKk+4PCDdKl8cy0LJs+r
 W4CzBB2ARsfNGwRfAJHU4Xeki4a3gje1ISEf+TVxqqLQGWqNsZQ6SS7jjELaB/VlTbrsUEGR
 1XfIn/sqeskSeQwJiFLeQgj3ABEBAAGJAkEEGAECASsFAlPAG8IFGwwAAADAXSAEGQEIAAYF
 AlPAG8EACgkQk2AGqJgvD1UNFQgAlpN5/qGxQARKeUYOkL7KYvZFl3MAnH2VeNTiGFoVzKHO
 e7LIwmp3eZ6GYvGyoNG8cOKrIPvXDYGdzzfwxVnDSnAE92dv+H05yanSUv/2HBIZa/LhrPmV
 hXKgD27XhQjOHRg0a7qOvSKx38skBsderAnBZazfLw9OukSnrxXqW/5pe3mBHTeUkQC8hHUD
 Cngkn95nnLXaBAhKnRfzFqX1iGENYRH3Zgtis7ZvodzZLfWUC6nN8LDyWZmw/U9HPUaYX8qY
 MP0n039vwh6GFZCqsFCMyOfYrZeS83vkecAwcoVh8dlHdke0rnZk/VytXtMe1u2uc9dUOr68
 7hA+Z0L5IQAKCRCBMbXEKbxmoLoHCACXeRGHuijOmOkbyOk7x6fkIG1OXcb46kokr2ptDLN0
 Ky4nQrWp7XBk9ls/9j5W2apKCcTEHONK2312uMUEryWI9BlqWnawyVL1LtyxLLpwwsXVq5m5
 sBkSqma2ldqBu2BHXZg6jntF5vzcXkqG3DCJZ2hOldFPH+czRwe2OOsiY42E/w7NUyaN6b8H
 rw1j77+q3QXldOw/bON361EusWHdbhcRwu3WWFiY2ZslH+Xr69VtYAoMC1xtDxIvZ96ps9ZX
 pUPJUqHJr8QSrTG1/zioQH7j/4iMJ07MMPeQNkmj4kGQOdTcsFfDhYLDdCE5dj5WeE6fYRxE
 Q3up0ArDSP1L
Message-ID: <9ede5ded-9ca2-e0c8-0b81-e43b08f99b29@broadcom.com>
Date:   Thu, 26 Dec 2019 19:36:16 -0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.3.1
MIME-Version: 1.0
In-Reply-To: <20191210200852.24945-1-f.fainelli@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 12/10/2019 12:08 PM, Florian Fainelli wrote:
> Hi Kishon,
> 
> This patch series adds support for our latest 7216 class of devices
> which are taped out in a 16nm process and use a different SATA PHY AFE
> that requires a custom initialization sequence.

Kishon, is this looking good to you for merging? Thanks!

> 
> Thanks!
> 
> Florian Fainelli (2):
>   dt-bindings: phy: Document BCM7216 SATA PHY compatible string
>   phy: brcm-sata: Implement 7216 initialization sequence
> 
>  .../devicetree/bindings/phy/brcm-sata-phy.txt |   1 +
>  drivers/phy/broadcom/phy-brcm-sata.c          | 120 ++++++++++++++++++
>  2 files changed, 121 insertions(+)
> 

-- 
Florian

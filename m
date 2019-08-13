Return-Path: <SRS0=Ecng=WJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8B1A3C433FF
	for <linux-kernel@archiver.kernel.org>; Tue, 13 Aug 2019 03:58:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 603A1206C1
	for <linux-kernel@archiver.kernel.org>; Tue, 13 Aug 2019 03:58:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726884AbfHMD6z (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 12 Aug 2019 23:58:55 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:35153 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726296AbfHMD6y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Aug 2019 23:58:54 -0400
Received: from mail-pf1-f200.google.com ([209.85.210.200])
        by youngberry.canonical.com with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
        (Exim 4.76)
        (envelope-from <kai.heng.feng@canonical.com>)
        id 1hxNxU-0002PH-KW
        for linux-kernel@vger.kernel.org; Tue, 13 Aug 2019 03:58:52 +0000
Received: by mail-pf1-f200.google.com with SMTP id y66so67594837pfb.21
        for <linux-kernel@vger.kernel.org>; Mon, 12 Aug 2019 20:58:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=0RN74NEyE4YfkXEtFGNzvr/832XZOZUykyHY7A5RitY=;
        b=ATuts+2UJ3HoI4PKH9TimJL8D7+Ypb8hl6vdDRg8ssD48slXnUSXlnrHqXZwBxnzIU
         dgz1mfiCe/hnP4B27lLbVtZ8lUp5VEd/3bFgpe2F2X4aGnosoQzZjOxpHUlFtO6Aki5z
         ZkQSCd/AaqcGGp0hImw+pcPn6C/iJ6lZAnXNarOv7VNQAekHnPkqFq1BgsHanHd8YmgR
         OUx6OHM267b2kgC3GJKxMXUtkq00sgv0179aKl6A1dMgi63FXyQRxPo6K5hERC+gdscA
         Y0Hz7IRf9CmVe5xUWP7w7WkOo6ec5HsadHdeag4nzm7sPwjz6FSWMG9XJHmw0rhkvjrb
         EtlQ==
X-Gm-Message-State: APjAAAW0UeT1C36Tpwee12ISd6/qLcySMi4XLXx/JPAkDXukKVO9JmMr
        7+SNU0DJhhpFfDNGmhWfdvg+3DrpSORhIh2+yvcCOXknnm4yfcL9bKO5XLGmx7uRBOqN8Tg5Eyj
        Fr67xmFZvS0Sy9op1PKBRiXLXeo4nrGE9OKfHg20Y5w==
X-Received: by 2002:a17:90a:d14a:: with SMTP id t10mr318816pjw.85.1565668731118;
        Mon, 12 Aug 2019 20:58:51 -0700 (PDT)
X-Google-Smtp-Source: APXvYqxxuV/Lcsw+F16jq6jQRQgKglOfoLNFaaDsBOz1aR2V7gfQF8jz13DYbzWHcSIR1MEo5JOeUg==
X-Received: by 2002:a17:90a:d14a:: with SMTP id t10mr318806pjw.85.1565668730881;
        Mon, 12 Aug 2019 20:58:50 -0700 (PDT)
Received: from 2001-b011-380f-37d3-6d14-cecd-5a43-d44b.dynamic-ip6.hinet.net (2001-b011-380f-37d3-6d14-cecd-5a43-d44b.dynamic-ip6.hinet.net. [2001:b011:380f:37d3:6d14:cecd:5a43:d44b])
        by smtp.gmail.com with ESMTPSA id y11sm116156829pfb.119.2019.08.12.20.58.49
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 12 Aug 2019 20:58:50 -0700 (PDT)
Content-Type: text/plain;
        charset=utf-8;
        delsp=yes;
        format=flowed
Mime-Version: 1.0 (Mac OS X Mail 12.4 \(3445.104.11\))
Subject: Re: [PATCH] iommu/amd: Override wrong IVRS IOAPIC on Raven Ridge
 systems
From:   Kai-Heng Feng <kai.heng.feng@canonical.com>
In-Reply-To: <20190809153931.GG12930@8bytes.org>
Date:   Tue, 13 Aug 2019 11:58:48 +0800
Cc:     iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 8bit
Message-Id: <9CDD544D-DE4C-4AC6-B0DC-CD30C99EA71C@canonical.com>
References: <20190808101707.16783-1-kai.heng.feng@canonical.com>
 <20190809153931.GG12930@8bytes.org>
To:     Joerg Roedel <joro@8bytes.org>
X-Mailer: Apple Mail (2.3445.104.11)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

at 23:39, Joerg Roedel <joro@8bytes.org> wrote:

> On Thu, Aug 08, 2019 at 06:17:07PM +0800, Kai-Heng Feng wrote:
>> Raven Ridge systems may have malfunction touchpad or hang at boot if
>> incorrect IVRS IOAPIC is provided by BIOS.
>>
>> Users already found correct "ivrs_ioapic=" values, let's put them inside
>> kernel to workaround buggy BIOS.
>
> Will that still work when a fixed BIOS for these laptops is released?

Do you mean that we should stop applying these quirks once a BIOS fix is  
confirmed?

We can modify the quirk to compare BIOS version, if there’s an unlikely  
BIOS update really fixes the issue.
Before that happens, I think it’s OK to let the quirks stay this way.

Kai-Heng

>
>
> 	Joerg



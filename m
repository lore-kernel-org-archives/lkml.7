Return-Path: <SRS0=Yvat=2B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 65521C43603
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Dec 2019 16:09:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 381E520836
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Dec 2019 16:09:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=cogentembedded-com.20150623.gappssmtp.com header.i=@cogentembedded-com.20150623.gappssmtp.com header.b="wcCk/jTn"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388936AbfLKQI7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 11 Dec 2019 11:08:59 -0500
Received: from mail-lf1-f65.google.com ([209.85.167.65]:39938 "EHLO
        mail-lf1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731164AbfLKQIz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Dec 2019 11:08:55 -0500
Received: by mail-lf1-f65.google.com with SMTP id i23so4674832lfo.7
        for <linux-kernel@vger.kernel.org>; Wed, 11 Dec 2019 08:08:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cogentembedded-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:organization:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=7tqplQQb9CHWGQTUQAovBElvDHnJZMbpYf+CcpC4kqQ=;
        b=wcCk/jTnkASJR6Sp/LYKO/aXJ7GWZ8rt2oRypmgmWabEkCBK/cKu2NrwVq/17FV8tI
         t8yWfb8AWXbvEC/SrExJq/b1iu5pzWFwfpyvs6DaxjS4mHCuqftAMSTM+KRfYHSxUwjv
         rGQaDG8b8/7PtjZd8u88TM+BiNgMFo7S/W8OZINIzpJJ4eRtGG5eCE6PmW8CmIaH5F8d
         XqRYgOE582W9iKhrrr8OR5UcKjnMscE3yjhUAou7rAYKCERvfVpsIBRG+djXzSoJgKlG
         eketxGshmv8KyDlmzBI1mFELQnNUOH9w8fYc2ITrvlY7hd9sLE55fL+XxkmcymfpWGaF
         /jhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:organization
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=7tqplQQb9CHWGQTUQAovBElvDHnJZMbpYf+CcpC4kqQ=;
        b=MC0XANGILo+zFsQoc2FvdPiV7GIId53PUq1fLJ2KOLE37wCMIf/c5x2d6NDlLInRRq
         vuXwJ7VBig3ObHdONW6hEjwoufgXFEwzlXKrSNqEb2cnqNomD1II//gYlNfrTJxRLhHT
         L35mdeHOSoDkg6H+RtCU3OBGUUXSglWK68Rt25wu0+28yeQdHxD0YfWLluu4ID+RD+DH
         Jd0RokOMp76d3WSTyKaquW8SssnfJjXn2itCuADnfTLzKgjDd8w1c5uSeRzN6voS6wyi
         DUp6OupSYyRhWVuAUcPpAjcTpgtmYIuyMykYdqSV9aVkGKE9idBVnvhOSKhGI29JUoZG
         RHIA==
X-Gm-Message-State: APjAAAV3AIpObQb4BqBvAi3r5H8thsWV7ZYZOLbEEJkv+z34ptQSqT3Q
        TqQ85/tw/omq7riWQHKI3OW4hw==
X-Google-Smtp-Source: APXvYqw6vroN4zWGsiE3et8xvPmJr20vyWmpeLQ82KdA0bF4KoKWTmc/RVLOq511WAvgGFLqkk/0uA==
X-Received: by 2002:ac2:5ec3:: with SMTP id d3mr2706348lfq.176.1576080533659;
        Wed, 11 Dec 2019 08:08:53 -0800 (PST)
Received: from wasted.cogentembedded.com ([2a00:1fa0:8d8:12fe:a87e:d4b8:621e:2b62])
        by smtp.gmail.com with ESMTPSA id h24sm1407649ljl.80.2019.12.11.08.08.52
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 11 Dec 2019 08:08:52 -0800 (PST)
Subject: Re: [PATCH RFC 0/2] Add Renesas RPC-IF support
To:     Chris Brandt <Chris.Brandt@renesas.com>,
        Rob Herring <robh+dt@kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>
Cc:     Mark Rutland <mark.rutland@arm.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Mason Yang <masonccyang@mxic.com.tw>,
        "linux-spi@vger.kernel.org" <linux-spi@vger.kernel.org>
References: <cb7022c9-0059-4eb2-7910-aab42124fa1c@cogentembedded.com>
 <TY1PR01MB156234F5B44BB43D3DCA98128A5A0@TY1PR01MB1562.jpnprd01.prod.outlook.com>
From:   Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Organization: Cogent Embedded
Message-ID: <03a630e2-280f-98b7-a9c8-6533716720e5@cogentembedded.com>
Date:   Wed, 11 Dec 2019 19:08:51 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.2.1
MIME-Version: 1.0
In-Reply-To: <TY1PR01MB156234F5B44BB43D3DCA98128A5A0@TY1PR01MB1562.jpnprd01.prod.outlook.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-MW
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

HEllo

On 12/11/2019 05:33 PM, Chris Brandt wrote:

>> Here's a set of 2 patches against Linus' repo. Renesas Reduced Pin Count
>> Interface (RPC-IF) allows a SPI flash or HyperFlash connected to the SoC to
>> be accessed via the external address space read mode or the manual mode.
> 
> Looking at this driver, all it is are APIs. Meaning another driver is 
> needed to sit in between the MTD layer and this HW driver layer.

   Between the hardware and SPI, and between the hardware and HyperFlash
infrastructure. There's a lot of the common hardware code common between
these 2 driver areas.

> In the driver that I did, if the "RPC" HW is going to be used to control
> a SPI Flash device, it registered a spi controller and then the MTD 
> layer could access the device just like any other SPI controller driver. No
> additional drivers are needed.

   We're already been thru that with Mason's patch -- I don't want the code
duplicated between 2 drivers.

> Looking at the hyperbus driver that is in drivers/mtd/hyperbus/, it 
> seems that if the "RPC" HW is going to be used to control HyperFlash, then 

   Sure. But the code controlling RPC hardware is largely the same b/w 2 cases.

> all you would need to do is register a hyperbus controller using 
> hyperbus_register_device(). Then the MTD layer could read/write the flash using 
> normal MTD CFI interface.

   That's what I do (the current realization makes too many assumptions about
the HF hardware (both direct read and write). 

> Why do you think you need another layer in between the HW driver and the
> MTD layer?

   Because we don't want any duplicated code. Also, think about DT -- it
describes the hardware, not the driver configuration.

> Is your goal to make a multi-layered system where the HW jumps back and forth
> in between operating modes at runtime? I'm not sure of the use case for all of
> this.

   My goal is to prevent the code duplication (and keep DT sane too).

> Chris

MBR, Sergei

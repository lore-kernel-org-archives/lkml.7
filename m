Return-Path: <SRS0=lMFC=TN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 49542C04AA7
	for <linux-kernel@archiver.kernel.org>; Mon, 13 May 2019 15:39:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1884321473
	for <linux-kernel@archiver.kernel.org>; Mon, 13 May 2019 15:39:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NmalT44E"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731377AbfEMPjj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 13 May 2019 11:39:39 -0400
Received: from mail-lf1-f41.google.com ([209.85.167.41]:33684 "EHLO
        mail-lf1-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728046AbfEMPjj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 May 2019 11:39:39 -0400
Received: by mail-lf1-f41.google.com with SMTP id x132so9450396lfd.0;
        Mon, 13 May 2019 08:39:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:subject:to:cc:message-id:date:user-agent:mime-version
         :content-transfer-encoding:content-language;
        bh=Im1JV8DmKWSE2P0cw0hdXGTTWoH4wIN3ko1j8EjIKGQ=;
        b=NmalT44E0CYo0cQoCmLmb7XQcTF/Tw6YKkRlahp7AFEH/JQq6QevaJwCk8OuHpaJA2
         iOcqFvECUAi6tYBr1oZXtAr3bbLO1zGFy38G2+zaxm4+ssdAuFoKDohxlrWjdOGJPgKz
         nWPcm/++RmCEOYJKnRCwCM0XCYjgBvOwkzLKHQDHY00ii1ZuPOpVHAfRYNfV+Qxhjba3
         vqYOVDyI8lFqScAVMKIUYq7vWjrp6wl4FqpHArFXRNkjo9T4FBINcMWAu5/KHZBEi+qe
         kavKmvcOawFgfmkvxeAygdnnSVRBzIrljq8bbZ+V88bbbFRNZQKP7lBa6DWyrHAx8yUm
         kAbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:subject:to:cc:message-id:date:user-agent
         :mime-version:content-transfer-encoding:content-language;
        bh=Im1JV8DmKWSE2P0cw0hdXGTTWoH4wIN3ko1j8EjIKGQ=;
        b=UPQ8Ls/GnaPbKYpvNpTwadWc/Qp36M7lHnONIqlu60UFrWz7z5n2SylD4iOTnF/AsY
         W+fMg1YEC1cXd240egFv0BjzP2+J2h0Mh4t/KdshDLNivITZT9tAfYdNbB37buQ6M3bc
         aeDyzIl++Js03Of5PW9OT6Tb62KNPaOETmYwxygMK7tfTDeiE1naEctm6zp7dcKoS/qj
         diwoc/4qsb95tyqQa+YfzzRxogq2O4RJa2XJXYc7M+fmp0zqir8buwnzjaOsz37OKjzX
         Ms5LKsBUAIejim4exqhpKKvBvhe3eihzuq+ySoofcGIXKLd3X+eIA6/602X23tCAVLqt
         KR0g==
X-Gm-Message-State: APjAAAXusOLw2TQqKAEZrMrtAg447A29J+aEw1khUQ4ymHRaLvcKOu2D
        dTV+XOM75dZsIfPkGfnOY+AiLF+/
X-Google-Smtp-Source: APXvYqxq7DiPUmvMARUX3uWlv0n6ibeaZkY1u2rWKy81j/pGxh+HWxQGS0eQ917yphwfRZfOeTDElA==
X-Received: by 2002:a19:5507:: with SMTP id n7mr14726777lfe.140.1557761976859;
        Mon, 13 May 2019 08:39:36 -0700 (PDT)
Received: from [192.168.1.10] ([95.174.107.249])
        by smtp.gmail.com with ESMTPSA id x6sm3261852lfn.74.2019.05.13.08.39.35
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 13 May 2019 08:39:36 -0700 (PDT)
From:   Igor Plyatov <plyatov@gmail.com>
Subject: Initialisation of SOC USB pads
To:     linux-usb@vger.kernel.org
Cc:     Alan Stern <stern@rowland.harvard.edu>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Message-ID: <607c6b4c-d53a-8115-aa60-2a8461607d40@gmail.com>
Date:   Mon, 13 May 2019 18:39:34 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Dear developers,

can you please explain who must configure AT91SAM9G20 SOC pads to 
operate as USB Host port? Is it AT91Bootstrap, U-Boot bootloader, Linux 
kernel or this is not required at all?

I ask, because during connection of USB disk, my board complains

usb 1-1: device descriptor read/64, error -62
usb 1-1: device descriptor read/64, error -62
usb 1-1: device descriptor read/64, error -62
usb 1-1: device descriptor read/64, error -62
usb 1-1: device not accepting address 4, error -62
usb 1-1: device not accepting address 5, error -62
usb usb1-port1: unable to enumerate USB device


Looks like there is no connectivity between USB Host module of SOC and 
USB device. Or am I wrong?


My setup is:


* AT91SAM9G20 based custom board;
* Linux kernel 4.9.36, from LINUX4SAM project.
* USB disk connected to USB Host port 0 (HDPA, HDMA pins of SOC). 39 Ohm 
series resistors and 15 Kohm pull-down resistors added at these lines. 
Connectivity between SOC and USB device confirmed by Ohmmeter.
* USB_VBUS voltage measured at USB connector = 4.96 VDC.

Best wishes
--
Igor Plyatov


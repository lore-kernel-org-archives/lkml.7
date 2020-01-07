Return-Path: <SRS0=facv=24=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A6898C33C8C
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Jan 2020 17:57:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 71D75206DA
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Jan 2020 17:57:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="XzbHZkHD"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728470AbgAGR5e (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 Jan 2020 12:57:34 -0500
Received: from mail-wr1-f51.google.com ([209.85.221.51]:41043 "EHLO
        mail-wr1-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728266AbgAGR5e (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Jan 2020 12:57:34 -0500
Received: by mail-wr1-f51.google.com with SMTP id c9so411526wrw.8
        for <linux-kernel@vger.kernel.org>; Tue, 07 Jan 2020 09:57:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google;
        h=to:cc:from:subject:message-id:date:user-agent:mime-version
         :content-transfer-encoding:content-language;
        bh=dO6NvWCib3bj7emzmJarRH/5ffgUsmEuz9rwZU2RyjA=;
        b=XzbHZkHDKE3s7RP16EWwN7oBfJfQJGlyD2eps1ljaBzLGEBPw1w5WefdbVrItigrWB
         GHJMFgYc4Mw0779Z1JZJe1P28sLxr7iScFTNa9bEqiGcYMUYB8DzGDG85RjAX04vMqZu
         X9Ew0HNa/hiNt5g1VJCDrMvaeBhcBz80xVuGs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:to:cc:from:subject:message-id:date:user-agent
         :mime-version:content-transfer-encoding:content-language;
        bh=dO6NvWCib3bj7emzmJarRH/5ffgUsmEuz9rwZU2RyjA=;
        b=jPXb2fSiU74RGtBF3hJv0NWx8focBfUrpvOA4ugPRmDGoWdaSxKDv3p1gJdUW44/yF
         sbO4YZN3LFPLuZH/H/GDPKJDUUp63iQSYrtglqIyJZGsUrdSPWwLRef79X1TvvtQZLf6
         1DN/HzRe+V3g/AMdIelQwmv+piiP8rHShdGLenZk/nTybf4O06wCFflswtwchQdX/BhX
         ySQFFXFx6aPVlqRsrUORqTpddVK6aWmKAqZmOkl/Q57iXeINsV7Mo0Ff1hMJ70IeeldA
         Pfi5qwE4ykiA2ZDHypq0zxSZkUQf9sBMQYcnOh68Up0TeA1Km4ngWH8Q16IztDeaWWVL
         yuIA==
X-Gm-Message-State: APjAAAXNJOdSymv4nT8VPC5/Wl3C9Q10b2POwRyTloQ5lQCE5MLQm+Y2
        W9ky6FiK78aR/jEMlOhIkYQtTjsbdamSzB6x0t99YUGNkKXifRuJzefB9HvVXTLR7Z0ipCnHhFx
        RTnWyyKyv4WZCj+mL3t8WQxf2phw8jajwuB9J7JH0pCHbN2TpeyyZJPA9zjsr2CjBFYrj8LG55z
        UCgz9XkbWJ
X-Google-Smtp-Source: APXvYqyTDa7r1ALZjmfNuIWkWsA1PapD5x9JiDB6TCAstx5Z194AzRJbzYKxWQJb8jOG3jwiM+zYtg==
X-Received: by 2002:adf:dd51:: with SMTP id u17mr284849wrm.290.1578419851749;
        Tue, 07 Jan 2020 09:57:31 -0800 (PST)
Received: from [10.136.13.65] ([192.19.228.250])
        by smtp.gmail.com with ESMTPSA id x6sm408101wmi.44.2020.01.07.09.57.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 07 Jan 2020 09:57:31 -0800 (PST)
To:     Borislav Petkov <bp@alien8.de>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Tony Luck <tony.luck@intel.com>,
        Yuqing Shen <yuqing.shen@broadcom.com>,
        Lei Wang <lewan@microsoft.com>
Cc:     James Morse <james.morse@arm.com>,
        Robert Richter <rrichter@marvell.com>,
        BCM Kernel Feedback <bcm-kernel-feedback-list@broadcom.com>,
        LKML <linux-kernel@vger.kernel.org>
From:   Scott Branden <scott.branden@broadcom.com>
Subject: EDAC driver for DMC520
Message-ID: <bdb29d6d-bc63-cf68-0e32-556740537cd8@broadcom.com>
Date:   Tue, 7 Jan 2020 09:57:26 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello EDAC Maintainers,

Could somebody have a look at the DMC520 patch series that has been 
waiting for a response since November:
https://patchwork.kernel.org/patch/11248785/

Regards,
  Scott

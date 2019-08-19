Return-Path: <SRS0=+RQC=WP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 63683C3A589
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Aug 2019 00:50:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 27EB72186A
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Aug 2019 00:50:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MMn2e5tx"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726366AbfHSAt7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 18 Aug 2019 20:49:59 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:36105 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726115AbfHSAt6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 18 Aug 2019 20:49:58 -0400
Received: by mail-pg1-f195.google.com with SMTP id l21so124891pgm.3;
        Sun, 18 Aug 2019 17:49:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=cucRnTBKV3jSYKkerT+mfhm7morlK8lS/0IZL03R4iw=;
        b=MMn2e5txwGSFG2EmCGNY6tqxfbyLy+gJc1fqVeiVPtdJUB24aStD2qEwmQQYkw4h23
         y7B9kdge30sjdM/gVDQEgkElS01Qqv3XkfCCqWolWp3mBBUyvlQy5+8DENSOIydFnPu5
         6wDxlr89RtapNbRKFh6IdUATJ85tCM+kYx0knnFc9bayczkoyiVrW/PULp17OvyM1Mhi
         /fzB56TwSqVL6LEX7NftPSmdlsyuaSguEgbAbTf1QaM7Iuh+Hfi/A8Gwm+aSnzA8GhB+
         DM7M7Zel3mtHwA+0tFBoXjsqXlDDFd62vYDlWNjKHsPdeFvfS1adpfmnnX8Pq4tS18Hl
         BG1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=cucRnTBKV3jSYKkerT+mfhm7morlK8lS/0IZL03R4iw=;
        b=qiDlV+L+cxfqTwiKGFDKspdcotZlRWXrQUydVQofb+0W1om7UlrPvQVb28pL2Ah9E4
         9dr1QAQ7weq8pvp+yKv277t29fxpR6TNRujDvj8tf+uj/AXKiMpMQ5ay/rWd64roF4FH
         GCuKLqXIJklqMnwZYZLBKmYhPFEhKZiinYqsD7bdSxlXPckWPBDpJVdi63awTeddVoF5
         yn2ytAFvxq2vKmflU3vckyPcCisxg1GP953dWvS8t6J1a1rTOEtyNFrvjaxyyzWzJSv/
         /FVrps68feILyKeevPv/Zzy2ONbWJaBBfJwSN2WzrhbNnoLiQEDSUnFbu1SNAOeoxbl1
         biog==
X-Gm-Message-State: APjAAAVpUVdkADemScEVdr0ERjbVhNzFWYXCaZURoRLLooUZpL5UG5Y0
        MvkvvoJZTqBHdqd5O8mRqoo=
X-Google-Smtp-Source: APXvYqwiKMA2YPLoYxJt2c5rD+Q9gp3S9SetoSaaV3CDHf2/V5tH+9zFrhVgTyG6ujQ0r0GCqXhf/A==
X-Received: by 2002:a17:90a:3465:: with SMTP id o92mr17801177pjb.20.1566175797963;
        Sun, 18 Aug 2019 17:49:57 -0700 (PDT)
Received: from [192.168.1.60] (59-120-186-245.HINET-IP.hinet.net. [59.120.186.245])
        by smtp.gmail.com with ESMTPSA id z4sm12913675pgp.80.2019.08.18.17.49.54
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 18 Aug 2019 17:49:56 -0700 (PDT)
Subject: Re: [PATCH V1 1/1] serial: 8250_pci: Add F81504A series Support
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     gregkh@linuxfoundation.org, jslaby@suse.com, jay.dolan@accesio.com,
        hslester96@gmail.com, je.yen.tam@ni.com, lkp@intel.com,
        kai.heng.feng@canonical.com, heikki.krogerus@linux.intel.com,
        linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org,
        peter_hong@fintek.com.tw,
        "Ji-Ze Hong (Peter Hong)" <hpeter+linux_kernel@gmail.com>
References: <1565933249-23076-1-git-send-email-hpeter+linux_kernel@gmail.com>
 <20190816112644.GF30120@smile.fi.intel.com>
From:   "Ji-Ze Hong (Peter Hong)" <hpeter@gmail.com>
Message-ID: <8e052919-b012-ff3f-f108-380d1ce5f7e7@gmail.com>
Date:   Mon, 19 Aug 2019 08:49:50 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190816112644.GF30120@smile.fi.intel.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Andy Shevchenko 於 2019/8/16 下午 07:26 寫道:
> On Fri, Aug 16, 2019 at 01:27:29PM +0800, Ji-Ze Hong (Peter Hong) wrote:
>> Fintek F81504A/508A/512A is PCIE to 4/8/12 UARTs device. It's support
>> IO/MMIO/PCIE conf to access all functions. The old F81504/508/512 is
>> only support IO.
> 
> We have 8250_fintek.
> Isn't it a right place to add these?
> 

The 8250_fintek implements PNP device with id PNP0501.
Should I also implements PCIe device in this file?

-- 
With Best Regards,
Peter Hong

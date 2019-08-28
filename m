Return-Path: <SRS0=kjqD=WY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ECB90C3A5A1
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Aug 2019 06:58:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C909F2080F
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Aug 2019 06:58:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726504AbfH1G6U (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 28 Aug 2019 02:58:20 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:60198 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726272AbfH1G6T (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Aug 2019 02:58:19 -0400
Received: from mail-pf1-f200.google.com ([209.85.210.200])
        by youngberry.canonical.com with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
        (Exim 4.76)
        (envelope-from <kai.heng.feng@canonical.com>)
        id 1i2ruL-0001cl-Pw
        for linux-kernel@vger.kernel.org; Wed, 28 Aug 2019 06:58:18 +0000
Received: by mail-pf1-f200.google.com with SMTP id a6so1346043pfk.11
        for <linux-kernel@vger.kernel.org>; Tue, 27 Aug 2019 23:58:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=lDeIrAUIfVo2Ua+qxn8ksD32RlhqrBouuBivl44BnRs=;
        b=YJSnCorpQUxUcEHoDPVNi7d8j6DMAThomzcUL6Fj1umEd2h5B1btuD3IdqSnxdkjGu
         JP2K2m/1p6wtE+xCISZgO1cC2DIrBNaJAPIvH7T9ftFESRaEoiqvqA30aSn1lwXKWVo8
         rOAPksy98DyYQWY7uIeu5AhvyAblHyj84ffNGRyurAzSc7sH6dfjrp7w4HHeVhzXuvi1
         oJx0fCGEvoTn0s2SndvInxdJYLAsEkhJxiySEd/dgpN5so0+MIOeVwo4bO54ygwfbuXk
         YsIang5gocPrEIC0wKmmtEEyeGOUziKDIAQe/TNAKNRh0GoqUFmRNIH5uZHTA2lRQ1yf
         M2Eg==
X-Gm-Message-State: APjAAAU3D4Fqn8BXvRx0KJS+72/kmveQDz8hdRdmvGDLXqtYKvZLoCHx
        9qZVsgCzCyqyvHViMrs50M8XWJrr/pPbQ5ZksADKR9NMg7C0zRfmEHLyzS4kzczGD39m7RsaMIg
        y013JUzQ32yBFb8Z6NS7auRQde92jiAsP79M9+r+XbQ==
X-Received: by 2002:aa7:9d07:: with SMTP id k7mr2913091pfp.94.1566975496477;
        Tue, 27 Aug 2019 23:58:16 -0700 (PDT)
X-Google-Smtp-Source: APXvYqykCOEs8kS8VQJdo5slAh1IdyDPUUB+YNVh1Kyy11Sk17bBpLbObwVJjU8oH1EfkmArl+qP1Q==
X-Received: by 2002:aa7:9d07:: with SMTP id k7mr2913079pfp.94.1566975496228;
        Tue, 27 Aug 2019 23:58:16 -0700 (PDT)
Received: from 2001-b011-380f-3c42-f8f8-a260-49a8-d1ed.dynamic-ip6.hinet.net (2001-b011-380f-3c42-f8f8-a260-49a8-d1ed.dynamic-ip6.hinet.net. [2001:b011:380f:3c42:f8f8:a260:49a8:d1ed])
        by smtp.gmail.com with ESMTPSA id p90sm2909164pjp.7.2019.08.27.23.58.14
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 27 Aug 2019 23:58:15 -0700 (PDT)
Content-Type: text/plain;
        charset=utf-8;
        delsp=yes;
        format=flowed
Mime-Version: 1.0 (Mac OS X Mail 12.4 \(3445.104.11\))
Subject: Re: Alps touchpad generates IRQ storm after S3
From:   Kai-Heng Feng <kai.heng.feng@canonical.com>
In-Reply-To: <TYXPR01MB1470902D804A47EE72013006C8A30@TYXPR01MB1470.jpnprd01.prod.outlook.com>
Date:   Wed, 28 Aug 2019 14:58:12 +0800
Cc:     Masaki Ota <masaki.ota@alpsalpine.com>,
        Mario Limonciello <mario.limonciello@dell.com>,
        "open list:HID CORE LAYER" <linux-input@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Naoki Saito <naoki.saito@alpsalpine.com>
Content-Transfer-Encoding: 8bit
Message-Id: <A118551C-A0D9-485F-91F7-44A5BE228B99@canonical.com>
References: <44F93018-5F13-4932-A5AC-9D288CDF68DD@canonical.com>
 <TYAPR01MB30223CB8A576C7809F6382C1ECA30@TYAPR01MB3022.jpnprd01.prod.outlook.com>
 <TYXPR01MB1470902D804A47EE72013006C8A30@TYXPR01MB1470.jpnprd01.prod.outlook.com>
To:     Xiaojian Cao <xiaojian.cao@cn.alps.com>
X-Mailer: Apple Mail (2.3445.104.11)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Xiaojian,

at 14:51, Xiaojian Cao <xiaojian.cao@cn.alps.com> wrote:

> Hi Ota-san,
>
> OK, we will look into it.
>
>
> Hi Kai-Heng,
>
> We will try to reproduce this issue first, could you please tell me the  
> target Ubuntu version?

It’s distro-agnostic, any distro with mainline Linux can reproduce the issue.

Kai-Heng

>
> Best regards,
> Jason
>
> -----Original Message-----
> From: 太田 真喜 Masaki Ota <masaki.ota@alpsalpine.com>
> Sent: Wednesday, August 28, 2019 2:35 PM
> To: 曹 曉建 Xiaojian Cao <xiaojian.cao@cn.alps.com>; Kai-Heng Feng  
> <kai.heng.feng@canonical.com>
> Cc: Mario Limonciello <mario.limonciello@dell.com>; open list:HID CORE  
> LAYER <linux-input@vger.kernel.org>; Linux Kernel Mailing List  
> <linux-kernel@vger.kernel.org>; 斉藤 直樹 Naoki Saito  
> <naoki.saito@alpsalpine.com>
> Subject: RE: Alps touchpad generates IRQ storm after S3
>
> Hi, Kai-Heng,
>
> Sorry, I'm not in charge of Linux task now.
>
> Hi, XiaoJian,
>
> Please check the following mail.
> If you have any question, please ask Kai-Heng.
>
> Best Regards,
> Masaki Ota
> -----Original Message-----
> From: Kai-Heng Feng <kai.heng.feng@canonical.com>
> Sent: Wednesday, August 28, 2019 3:22 PM
> To: 太田 真喜 Masaki Ota <masaki.ota@alpsalpine.com>
> Cc: Mario Limonciello <mario.limonciello@dell.com>; open list:HID CORE  
> LAYER <linux-input@vger.kernel.org>; Linux Kernel Mailing List  
> <linux-kernel@vger.kernel.org>
> Subject: Alps touchpad generates IRQ storm after S3
>
> Hi Masaki,
>
> The Alps touchpad (044E:1220) on Dell Precision 7530 causes IRQ storm  
> after system suspend (S3).
> Commit "HID: i2c-hid: Don't reset device upon system resume” which solves  
> the same issue for other vendors, cause the issue on Alps touchpad.
> So I’d like to know the correct command Alps touchpad expects after  
> system resume.
>
> Also Cc Mario because this could relate to BIOS.
>
> Kai-Heng



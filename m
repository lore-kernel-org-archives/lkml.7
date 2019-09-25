Return-Path: <SRS0=wETr=XU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2D934C432C1
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Sep 2019 10:01:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0109420872
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Sep 2019 10:01:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387513AbfIYKBM convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 25 Sep 2019 06:01:12 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:58634 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728713AbfIYKBL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Sep 2019 06:01:11 -0400
Received: from mail-pf1-f199.google.com ([209.85.210.199])
        by youngberry.canonical.com with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <kai.heng.feng@canonical.com>)
        id 1iD46f-0004TX-55
        for linux-kernel@vger.kernel.org; Wed, 25 Sep 2019 10:01:09 +0000
Received: by mail-pf1-f199.google.com with SMTP id w16so3602041pfj.9
        for <linux-kernel@vger.kernel.org>; Wed, 25 Sep 2019 03:01:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=qsjjdi3AsDVMQNpWMXhPgKXPZHKa39PHF7rhgE730OI=;
        b=rRm6ghtEluu2nblGUT4VnGVSFW+Gw5j/cbmfxpEe5cf4ZXhBGV4oPUTvr9nTV7Ix/e
         dAaKiA9wsHfAydC7s6ZBK4KtSxWKh8NQjyubfhRWJZUqggy8JxGiTk1c7qIhrY95pO/s
         OkmQ0HCwUl91RitNP5r2IjFkTP4msStuuRJMlyYBVj2uoJHgywezKnNVysTYYANzzz0Z
         6BLGN2J9RCC0LS0LHFelAXqzcoBF5vD0yhSGrBGFOiXqDq/IJ3Hbds59HZuojMeZxh/5
         bK1S1YgGIzfJenqCg/fSwDvRbhLygDJkf9buaa2EyQgSIytxOyj+IoPf5BB78nEXrvW3
         iOcA==
X-Gm-Message-State: APjAAAX+cCpbT1mDNyCHUS3l4vr1d9Mu2MBgVR7wqNvX0PRlAIvUDbRh
        4p1DLwl67hMrEiEJL5SIkOkvlpvSlELnkT5rVlThIm58Oo6kWIFwUrxw1S/UazBPdIrwosecz3i
        qa0ki62A+7ueuk9HwZwuOLExB9MS6EG2/Ds+LQdFIuQ==
X-Received: by 2002:a62:ed19:: with SMTP id u25mr8990173pfh.40.1569405667832;
        Wed, 25 Sep 2019 03:01:07 -0700 (PDT)
X-Google-Smtp-Source: APXvYqx32WbOzeHyTcRm5LkD/mic4uQBrzZt7i7Fd8cESaPmlnGAbKUaH3VegRto+H/s7U5zVgSw+A==
X-Received: by 2002:a62:ed19:: with SMTP id u25mr8990134pfh.40.1569405667508;
        Wed, 25 Sep 2019 03:01:07 -0700 (PDT)
Received: from 2001-b011-380f-3c42-54e4-e181-beb0-1245.dynamic-ip6.hinet.net (2001-b011-380f-3c42-54e4-e181-beb0-1245.dynamic-ip6.hinet.net. [2001:b011:380f:3c42:54e4:e181:beb0:1245])
        by smtp.gmail.com with ESMTPSA id b5sm4248775pgb.68.2019.09.25.03.01.05
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 25 Sep 2019 03:01:06 -0700 (PDT)
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 13.0 \(3594.4.13\))
Subject: Re: Alps touchpad generates IRQ storm after S3
From:   Kai-Heng Feng <kai.heng.feng@canonical.com>
In-Reply-To: <BFBB1DB9-00B6-497E-80D1-5168CF16B889@canonical.com>
Date:   Wed, 25 Sep 2019 18:01:03 +0800
Cc:     Xiaojian Cao <xiaojian.cao@cn.alps.com>, masaki.ota@alpsalpine.com,
        linux-input@vger.kernel.org, linux-kernel@vger.kernel.org,
        naoki.saito@alpsalpine.com
Content-Transfer-Encoding: 8BIT
Message-Id: <82884F1B-A4CD-44EF-9245-1143277484A6@canonical.com>
References: <44F93018-5F13-4932-A5AC-9D288CDF68DD@canonical.com>
 <TYAPR01MB30223CB8A576C7809F6382C1ECA30@TYAPR01MB3022.jpnprd01.prod.outlook.com>
 <TYXPR01MB1470902D804A47EE72013006C8A30@TYXPR01MB1470.jpnprd01.prod.outlook.com>
 <A118551C-A0D9-485F-91F7-44A5BE228B99@canonical.com>
 <39b2e63e339447e8b09b2601abf3d1ba@AUSX13MPC101.AMER.DELL.COM>
 <BFBB1DB9-00B6-497E-80D1-5168CF16B889@canonical.com>
To:     Mario.Limonciello@dell.com
X-Mailer: Apple Mail (2.3594.4.13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Xiaojian,

> On Aug 28, 2019, at 22:43, Kai-Heng Feng <kai.heng.feng@canonical.com> wrote:
> 
> Hi Mario,
> 
> at 21:25, <Mario.Limonciello@dell.com> <Mario.Limonciello@dell.com> wrote:
> 
>> KH,
>> 
>> Just make sure I understand details.
>> 
>>> Commit "HID: i2c-hid: Don't reset device upon system resume
>> 
>> If you revert this it's fixed on this system?
> 
> Yes. Once reset is used instead of  the issue is gone.

Do you figure out the correct command to use here?

Kai-Heng

> 
>> 
>> In that commit you had mentioned if this causes problems it might be worth
>> quirking just Raydium but commit afbb1169ed5b58cfca017e368b53e019cf285853
>> confirmed that it helped several other systems too.
>> 
>> If the conclusion from this investigation this is only fixable via touchpad FW update
>> it might be worth quirking this touchpad/touchpad FW/system combination.
> 
> Hopefully there’s a better solution from ALPS :)
> 
>> 
>>> Also Cc Mario because this could relate to BIOS.
>> 
>> Also I assume this is on current stable BIOS/EC release, right?
> 
> Yes. The BIOS version is 1.10.1.
> 
> The IRQ storm stops as soon as the touchpad gets touched.
> 
> Kai-Heng
> 
>> 
>> Thanks,
>> 
>>> -----Original Message-----
>>> From: Kai-Heng Feng <kai.heng.feng@canonical.com>
>>> Sent: Wednesday, August 28, 2019 1:58 AM
>>> To: Xiaojian Cao
>>> Cc: Masaki Ota; Limonciello, Mario; open list:HID CORE LAYER; Linux Kernel
>>> Mailing List; Naoki Saito
>>> Subject: Re: Alps touchpad generates IRQ storm after S3
>>> 
>>> 
>>> [EXTERNAL EMAIL]
>>> 
>>> Hi Xiaojian,
>>> 
>>> at 14:51, Xiaojian Cao <xiaojian.cao@cn.alps.com> wrote:
>>> 
>>>> Hi Ota-san,
>>>> 
>>>> OK, we will look into it.
>>>> 
>>>> 
>>>> Hi Kai-Heng,
>>>> 
>>>> We will try to reproduce this issue first, could you please tell me the
>>>> target Ubuntu version?
>>> 
>>> It’s distro-agnostic, any distro with mainline Linux can reproduce the issue.
>>> 
>>> Kai-Heng
>>> 
>>>> Best regards,
>>>> Jason
>>>> 
>>>> -----Original Message-----
>>>> From: 太田 真喜 Masaki Ota <masaki.ota@alpsalpine.com>
>>>> Sent: Wednesday, August 28, 2019 2:35 PM
>>>> To: 曹 曉建 Xiaojian Cao <xiaojian.cao@cn.alps.com>; Kai-Heng Feng
>>>> <kai.heng.feng@canonical.com>
>>>> Cc: Mario Limonciello <mario.limonciello@dell.com>; open list:HID CORE
>>>> LAYER <linux-input@vger.kernel.org>; Linux Kernel Mailing List
>>>> <linux-kernel@vger.kernel.org>; 斉藤 直樹 Naoki Saito
>>>> <naoki.saito@alpsalpine.com>
>>>> Subject: RE: Alps touchpad generates IRQ storm after S3
>>>> 
>>>> Hi, Kai-Heng,
>>>> 
>>>> Sorry, I'm not in charge of Linux task now.
>>>> 
>>>> Hi, XiaoJian,
>>>> 
>>>> Please check the following mail.
>>>> If you have any question, please ask Kai-Heng.
>>>> 
>>>> Best Regards,
>>>> Masaki Ota
>>>> -----Original Message-----
>>>> From: Kai-Heng Feng <kai.heng.feng@canonical.com>
>>>> Sent: Wednesday, August 28, 2019 3:22 PM
>>>> To: 太田 真喜 Masaki Ota <masaki.ota@alpsalpine.com>
>>>> Cc: Mario Limonciello <mario.limonciello@dell.com>; open list:HID CORE
>>>> LAYER <linux-input@vger.kernel.org>; Linux Kernel Mailing List
>>>> <linux-kernel@vger.kernel.org>
>>>> Subject: Alps touchpad generates IRQ storm after S3
>>>> 
>>>> Hi Masaki,
>>>> 
>>>> The Alps touchpad (044E:1220) on Dell Precision 7530 causes IRQ storm
>>>> after system suspend (S3).
>>>> Commit "HID: i2c-hid: Don't reset device upon system resume” which solves
>>>> the same issue for other vendors, cause the issue on Alps touchpad.
>>>> So I’d like to know the correct command Alps touchpad expects after
>>>> system resume.
>>>> 
>>>> Also Cc Mario because this could relate to BIOS.
>>>> 
>>>> Kai-Heng
> 
> 


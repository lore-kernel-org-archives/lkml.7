Return-Path: <SRS0=/Haq=WD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2C709C433FF
	for <linux-kernel@archiver.kernel.org>; Wed,  7 Aug 2019 17:44:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0741421E6E
	for <linux-kernel@archiver.kernel.org>; Wed,  7 Aug 2019 17:44:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388340AbfHGRol (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 7 Aug 2019 13:44:41 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:57920 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729278AbfHGRol (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Aug 2019 13:44:41 -0400
Received: from mail-pl1-f198.google.com ([209.85.214.198])
        by youngberry.canonical.com with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
        (Exim 4.76)
        (envelope-from <kai.heng.feng@canonical.com>)
        id 1hvPzK-0006QE-GT
        for linux-kernel@vger.kernel.org; Wed, 07 Aug 2019 17:44:38 +0000
Received: by mail-pl1-f198.google.com with SMTP id ci3so10686278plb.8
        for <linux-kernel@vger.kernel.org>; Wed, 07 Aug 2019 10:44:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=36m4ZV+EDZBauWhmbVgsGcG+yyAWwpaN1oKQZhgxKsQ=;
        b=QSrnDZBT4eCsZttviK+wPymcYY9K0D0hFF6XzeGi8pgzMSmDKTnemmTBNs9TJZ4PHH
         j94CfHLNvjhmm9exeQvsd0Py7XVb1WJSz1mYblMQQufQjy5z2sPyl+b6cTBZ2rcUdfrQ
         2k2EDTPNm5PpuUDS/M6gNm/9NnbwWybXFPdFFrsnOVBHDUH5XmBQ9SF4pJO/Bs/y6Dp4
         KjhQi3tilhYwMBxooxhTsIVL+gwWmsr5K5nPBsPqBJKOhZmD+pGXZEMRL7cCydNFPM8Z
         CiRE2f/UunLRhulsTYB5ax5QMz6dDQLGPFN+1EZSFj6KcQGL96eu5DSnf99/YQRpvRuo
         gGvg==
X-Gm-Message-State: APjAAAXqaPyU8IocLoHSUeFLG/cxkfzgj3f8IIVfA8tgwGMY+aSyOLST
        y/LjgP2hZk4jT2piUIamIOYbPXE+Fj4/JILkT5u79CpQaV80WM7lxUcn0j5aip21TVC+okREPIC
        2uyHqTfAg9pwpFd/50fYRaZJs/KAfLn9xeLpvtvAIow==
X-Received: by 2002:a63:3ec7:: with SMTP id l190mr8941772pga.334.1565199876731;
        Wed, 07 Aug 2019 10:44:36 -0700 (PDT)
X-Google-Smtp-Source: APXvYqzAjVzGaAHfi+Mx2RTAQF7DNZsnlHvJfIlucW5Pg3kOmc2JcioCuJG8VO3dWYSsyDV3OFW6Hg==
X-Received: by 2002:a63:3ec7:: with SMTP id l190mr8941755pga.334.1565199876307;
        Wed, 07 Aug 2019 10:44:36 -0700 (PDT)
Received: from 2001-b011-380f-37d3-744a-8654-5394-196d.dynamic-ip6.hinet.net (2001-b011-380f-37d3-744a-8654-5394-196d.dynamic-ip6.hinet.net. [2001:b011:380f:37d3:744a:8654:5394:196d])
        by smtp.gmail.com with ESMTPSA id 81sm140348480pfx.111.2019.08.07.10.44.33
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 07 Aug 2019 10:44:35 -0700 (PDT)
Content-Type: text/plain;
        charset=utf-8;
        delsp=yes;
        format=flowed
Mime-Version: 1.0 (Mac OS X Mail 12.4 \(3445.104.11\))
Subject: Re: [Regression] "drm/amdgpu: enable gfxoff again on raven series
 (v2)"
From:   Kai-Heng Feng <kai.heng.feng@canonical.com>
In-Reply-To: <MN2PR12MB330979BAFF5BCC758258D54CECD40@MN2PR12MB3309.namprd12.prod.outlook.com>
Date:   Thu, 8 Aug 2019 01:44:32 +0800
Cc:     "Deucher, Alexander" <Alexander.Deucher@amd.com>,
        "Koenig, Christian" <Christian.Koenig@amd.com>,
        "Zhou, David(ChunMing)" <David1.Zhou@amd.com>,
        amd-gfx list <amd-gfx@lists.freedesktop.org>,
        "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Anthony Wong <anthony.wong@canonical.com>
Content-Transfer-Encoding: 8bit
Message-Id: <624BFB8F-B586-492E-BEA6-4B138DAEC831@canonical.com>
References: <3EB0E920-31D7-4C91-A360-DBFB4417AC2F@canonical.com>
 <MN2PR12MB330979BAFF5BCC758258D54CECD40@MN2PR12MB3309.namprd12.prod.outlook.com>
To:     "Huang, Ray" <Ray.Huang@amd.com>
X-Mailer: Apple Mail (2.3445.104.11)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Ray,

at 00:03, Huang, Ray <Ray.Huang@amd.com> wrote:

> May I know the all firmware version in your system?

# cat amdgpu_firmware_info
VCE feature version: 0, firmware version: 0x00000000
UVD feature version: 0, firmware version: 0x00000000
MC feature version: 0, firmware version: 0x00000000
ME feature version: 40, firmware version: 0x00000099
PFP feature version: 40, firmware version: 0x000000ae
CE feature version: 40, firmware version: 0x0000004d
RLC feature version: 1, firmware version: 0x00000213
RLC SRLC feature version: 1, firmware version: 0x00000001
RLC SRLG feature version: 1, firmware version: 0x00000001
RLC SRLS feature version: 1, firmware version: 0x00000001
MEC feature version: 40, firmware version: 0x0000018b
MEC2 feature version: 40, firmware version: 0x0000018b
SOS feature version: 0, firmware version: 0x00000000
ASD feature version: 0, firmware version: 0x001ad4d4
TA XGMI feature version: 0, firmware version: 0x00000000
TA RAS feature version: 0, firmware version: 0x00000000
SMC feature version: 0, firmware version: 0x00001e44
SDMA0 feature version: 41, firmware version: 0x000000a9
VCN feature version: 0, firmware version: 0x0110901c
DMCU feature version: 0, firmware version: 0x00000000
VBIOS version: 113-RAVEN-103

Kai-Heng

>
> Thanks,
> Ray
>
> From: Kai-Heng Feng <kai.heng.feng@canonical.com>
> Sent: Wednesday, August 7, 2019 8:50 PM
> To: Huang, Ray
> Cc: Deucher, Alexander; Koenig, Christian; Zhou, David(ChunMing); amd-gfx  
> list; dri-devel@lists.freedesktop.org; LKML; Anthony Wong
> Subject: [Regression] "drm/amdgpu: enable gfxoff again on raven series  
> (v2)"
>
> Hi,
>
> After commit 005440066f92 ("drm/amdgpu: enable gfxoff again on raven series
> (v2)”), browsers on Raven Ridge systems cause serious corruption like this:
> https://launchpadlibrarian.net/436319772/Screenshot%20from%202019-08-07%2004-20-34.png
>
> Firmwares for Raven Ridge is up-to-date.
>
> Kai-Heng



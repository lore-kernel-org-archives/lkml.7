Return-Path: <SRS0=6YJq=VW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1468CC7618B
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Jul 2019 14:02:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E44AC217F4
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Jul 2019 14:02:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388381AbfGYOCp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Jul 2019 10:02:45 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:45775 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388098AbfGYOCp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Jul 2019 10:02:45 -0400
Received: from mail-pl1-f200.google.com ([209.85.214.200])
        by youngberry.canonical.com with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
        (Exim 4.76)
        (envelope-from <kai.heng.feng@canonical.com>)
        id 1hqeKR-0002tg-9V
        for linux-kernel@vger.kernel.org; Thu, 25 Jul 2019 14:02:43 +0000
Received: by mail-pl1-f200.google.com with SMTP id u10so26342873plq.21
        for <linux-kernel@vger.kernel.org>; Thu, 25 Jul 2019 07:02:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=dRGqqRdc8tkI0wtRj4b9pGjBs0cS4r9SniesDI0dk5k=;
        b=seRtLUuftmT5ECzzqWd+byZkMG0sDisMV09jX1GhLqOVygao9jkLTMt2zjoBSV1x2X
         gLuU+JwUhjypTaitvwPuuAYCGVhciE+pjOnlZPv3FDaZlV5xVh/i4LJdKHQmHazoMtbv
         A0sCVUASQKlsW97ShkHDPXZTDQLLL83kR6k/pmN7HVuUqIu1LKfZYOt0vtOGoAW09m+c
         mhwKGChrIrixXEldhkFlJbJVSc6aEj29VxU6Dk51OBxR5Qpj4qjBdiHDRGtx1SfZ0Cio
         i7OkYbFnGBZ62cQohE96pPsB3XGAHfJqGDXCbkC8G9MNX7fGts0j9i+I7R97R+zEAUtL
         Gi8Q==
X-Gm-Message-State: APjAAAWA6dEbMKTVstltOCmZCJ6C2CsWjA7U+V6OUKKs5cfYijt81rb6
        xFhFEGvMd2/IqWbB0ahr45+xESvl76+a3Pqr/fofAMPr0SrvoYPpOrqJcZYhIoKfFRPnywIWc1T
        W64HzvyOZ1VgmrRIV8Wzl04EhDgc952wU3FdsPEE+8A==
X-Received: by 2002:a63:9e54:: with SMTP id r20mr52056711pgo.64.1564063361878;
        Thu, 25 Jul 2019 07:02:41 -0700 (PDT)
X-Google-Smtp-Source: APXvYqzqyGieoMSzMW+cs+usTVtQ0tbDQ4xtlJACIElsyAMlDRT8SdSAUIjRG0amm82rcIJMkeA+5A==
X-Received: by 2002:a63:9e54:: with SMTP id r20mr52056676pgo.64.1564063361539;
        Thu, 25 Jul 2019 07:02:41 -0700 (PDT)
Received: from 2001-b011-380f-3c20-0160-ac1c-9209-b8ff.dynamic-ip6.hinet.net (2001-b011-380f-3c20-0160-ac1c-9209-b8ff.dynamic-ip6.hinet.net. [2001:b011:380f:3c20:160:ac1c:9209:b8ff])
        by smtp.gmail.com with ESMTPSA id e124sm80839839pfh.181.2019.07.25.07.02.39
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 25 Jul 2019 07:02:40 -0700 (PDT)
Content-Type: text/plain;
        charset=utf-8;
        delsp=yes;
        format=flowed
Mime-Version: 1.0 (Mac OS X Mail 12.4 \(3445.104.11\))
Subject: Re: [Regression] Commit "nvme/pci: Use host managed power state for
 suspend" has problems
From:   Kai-Heng Feng <kai.heng.feng@canonical.com>
In-Reply-To: <2332799.izEFUvJP67@kreacher>
Date:   Thu, 25 Jul 2019 22:02:37 +0800
Cc:     Keith Busch <keith.busch@intel.com>,
        Christoph Hellwig <hch@lst.de>,
        Sagi Grimberg <sagi@grimberg.me>,
        linux-nvme@lists.infradead.org,
        Mario Limonciello <Mario.Limonciello@dell.com>,
        Linux PM <linux-pm@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Transfer-Encoding: 8bit
Message-Id: <E62786E4-5DA9-4542-899A-658D0E021190@canonical.com>
References: <2332799.izEFUvJP67@kreacher>
To:     "Rafael J. Wysocki" <rjw@rjwysocki.net>
X-Mailer: Apple Mail (2.3445.104.11)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Rafael,

at 17:51, Rafael J. Wysocki <rjw@rjwysocki.net> wrote:

> Hi Keith,
>
> Unfortunately,
>
> commit d916b1be94b6dc8d293abed2451f3062f6af7551
> Author: Keith Busch <keith.busch@intel.com>
> Date:   Thu May 23 09:27:35 2019 -0600
>
>     nvme-pci: use host managed power state for suspend
>
> doesn't universally improve things.  In fact, in some cases it makes  
> things worse.
>
> For example, on the Dell XPS13 9380 I have here it prevents the processor  
> package
> from reaching idle states deeper than PC2 in suspend-to-idle (which, of  
> course, also
> prevents the SoC from reaching any kind of S0ix).
>
> That can be readily explained too.  Namely, with the commit above the  
> NVMe device
> stays in D0 over suspend/resume, so the root port it is connected to also  
> has to stay in
> D0 and that "blocks" package C-states deeper than PC2.
>
> In order for the root port to be able to go to D3, the device connected  
> to it also needs
> to go into D3, so it looks like (at least on this particular machine, but  
> maybe in
> general), both D3 and the NVMe-specific PM are needed.
>
> I'm not sure what to do here, because evidently there are systems where  
> that commit
> helps.  I was thinking about adding a module option allowing the user to  
> override the
> default behavior which in turn should be compatible with 5.2 and earlier  
> kernels.

I just briefly tested s2i on XPS 9370, and the power meter shows a 0.8~0.9W  
power consumption so at least I don’t see the issue on XPS 9370.

Can you please provide the output of `nvme id-ctrl /dev/nvme*` and I’ll  
test the NVMe controller on XPS 9380.

Kai-Heng

>
> Cheers,
> Rafael



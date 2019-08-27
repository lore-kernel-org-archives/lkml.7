Return-Path: <SRS0=qJmF=WX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B9607C3A5A3
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Aug 2019 14:50:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9BA03206BF
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Aug 2019 14:50:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729931AbfH0OuP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 27 Aug 2019 10:50:15 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:39645 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725811AbfH0OuP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Aug 2019 10:50:15 -0400
Received: from mail-pf1-f199.google.com ([209.85.210.199])
        by youngberry.canonical.com with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
        (Exim 4.76)
        (envelope-from <kai.heng.feng@canonical.com>)
        id 1i2cnU-00040w-6I
        for linux-kernel@vger.kernel.org; Tue, 27 Aug 2019 14:50:12 +0000
Received: by mail-pf1-f199.google.com with SMTP id y66so14784134pfb.21
        for <linux-kernel@vger.kernel.org>; Tue, 27 Aug 2019 07:50:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=QPtHqzYE2I3K6mA1W43Ow1hu2cfsdV6r/QSBv6PmVXE=;
        b=ZwdJpUTyWQJ7mSj/8i8BdMf1oHDQfvZpw0gitvjTAuLo2/Ri+utE5+CzgBVUMLQUhA
         6wSAL7uvv3k8zkpnN947oPUeUdCwSDjDEVZDI/APeolziz4ZQMciSVK+TgXM3sSfzaNV
         ttZjt17GcurVBXGQ4nmk1wTNJ88olWqWKLkpwFbikq3bmk6G3LqYbf8grNKhI3/SJhPU
         R7Wev194kOefw9NfnEuEWaeTb1ocee627oDJZ8ZhedqieX3IFWAsZ8h1/Y6ZTDzwivAE
         dLGtfSuQrBAXXPKx3myHG1BhnaHBnRvJYt2Fn8hBdfVQ3+mHBVt8Zv+jxKd7sf1qtgFX
         TAKA==
X-Gm-Message-State: APjAAAVjs6VdXJUuMqpOF5g3t5e0nGwxidBCI4jmmBGgiom44ixur+s7
        kpNjydWy1y1zrd0UeQqAJZShJ/9/Fatu1JNG7BI0gGQU180ZDUfLXYh39V31D72fzRiylUHMSmK
        sO7mEXH94HxXeVhLVGuBFAmQP91DagkglZwTPvfFNOw==
X-Received: by 2002:a17:90a:3b4f:: with SMTP id t15mr26629450pjf.45.1566917410960;
        Tue, 27 Aug 2019 07:50:10 -0700 (PDT)
X-Google-Smtp-Source: APXvYqxD/9UP/HN0ldJtPRSnTlHHh4+NxXjhXptKrorWOlvZ1KnXW9fodYpfoV5J9JPcZXw61pCu5A==
X-Received: by 2002:a17:90a:3b4f:: with SMTP id t15mr26629428pjf.45.1566917410640;
        Tue, 27 Aug 2019 07:50:10 -0700 (PDT)
Received: from 2001-b011-380f-3c42-843f-e5eb-ba09-2e70.dynamic-ip6.hinet.net (2001-b011-380f-3c42-843f-e5eb-ba09-2e70.dynamic-ip6.hinet.net. [2001:b011:380f:3c42:843f:e5eb:ba09:2e70])
        by smtp.gmail.com with ESMTPSA id q8sm2479848pjq.20.2019.08.27.07.50.09
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 27 Aug 2019 07:50:10 -0700 (PDT)
Content-Type: text/plain;
        charset=utf-8;
        delsp=yes;
        format=flowed
Mime-Version: 1.0 (Mac OS X Mail 12.4 \(3445.104.11\))
Subject: Re: [PATCH 2/2] ALSA: hda: Allow HDA to be runtime suspended when
 dGPU is not bound
From:   Kai-Heng Feng <kai.heng.feng@canonical.com>
In-Reply-To: <20190827134756.10807-2-kai.heng.feng@canonical.com>
Date:   Tue, 27 Aug 2019 22:50:03 +0800
Cc:     linux-pci@vger.kernel.org, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 8bit
Message-Id: <97D68761-4152-4D77-B222-14EA892503DB@canonical.com>
References: <20190827134756.10807-1-kai.heng.feng@canonical.com>
 <20190827134756.10807-2-kai.heng.feng@canonical.com>
To:     Bjorn Helgaas <bhelgaas@google.com>, tiwai@suse.com
X-Mailer: Apple Mail (2.3445.104.11)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

at 21:47, Kai-Heng Feng <kai.heng.feng@canonical.com> wrote:

> It's a common practice to let dGPU unbound and use PCI port PM to
> disable its power through _PR3. When the dGPU comes with an HDA
> function, the HDA won't be suspended if the dGPU is unbound, so the dGPU
> power can't be disabled.
>
> Commit 37a3a98ef601 ("ALSA: hda - Enable runtime PM only for
> discrete GPU") only allows HDA to be runtime-suspended once GPU is
> bound, to keep APU's HDA working.
>
> However, HDA on dGPU isn't that useful if dGPU is unbound. So let relax
> the runtime suspend requirement for dGPU's HDA function, to save lots of
> power.
>
> BugLink: https://bugs.launchpad.net/bugs/1840835
> Signed-off-by: Kai-Heng Feng <kai.heng.feng@canonical.com>
> —

Forgot to mention that for some platforms this issue happen after commit  
b516ea586d71 ("PCI: Enable NVIDIA HDA controllers”) which starts to unhide  
the “hidden” HDA.

Kai-Heng

>  sound/pci/hda/hda_intel.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/sound/pci/hda/hda_intel.c b/sound/pci/hda/hda_intel.c
> index 99fc0917339b..d4ee070e1a29 100644
> --- a/sound/pci/hda/hda_intel.c
> +++ b/sound/pci/hda/hda_intel.c
> @@ -1285,7 +1285,8 @@ static void init_vga_switcheroo(struct azx *chip)
>  		dev_info(chip->card->dev,
>  			 "Handle vga_switcheroo audio client\n");
>  		hda->use_vga_switcheroo = 1;
> -		hda->need_eld_notify_link = 1; /* cleared in gpu_bound op */
> +		/* cleared in gpu_bound op */
> +		hda->need_eld_notify_link = !pci_pr3_present(p);
>  		chip->driver_caps |= AZX_DCAPS_PM_RUNTIME;
>  		pci_dev_put(p);
>  	}
> -- 
> 2.17.1



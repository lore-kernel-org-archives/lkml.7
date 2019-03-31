Return-Path: <SRS0=KwB+=SC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2BE93C43381
	for <linux-kernel@archiver.kernel.org>; Sun, 31 Mar 2019 12:19:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EC0F320870
	for <linux-kernel@archiver.kernel.org>; Sun, 31 Mar 2019 12:19:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nR3bAymV"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731221AbfCaMT3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 31 Mar 2019 08:19:29 -0400
Received: from mail-wm1-f67.google.com ([209.85.128.67]:37248 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726734AbfCaMT3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 31 Mar 2019 08:19:29 -0400
Received: by mail-wm1-f67.google.com with SMTP id v14so8025447wmf.2;
        Sun, 31 Mar 2019 05:19:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=/DZE/2EGuiaVLm+bRyE9gV/EUNvDMXyHbxd6dVVKrW4=;
        b=nR3bAymVMeabgrfL3MxP504LAKNsEF77MmwHvQCOV+9cPHTSDR1Etdm4Xf72PcQM6b
         JKg6OAWrNoYCB1Cc2fj2Uheg+66ePVwYx3jDXLExzxz5Aq6mdU/dQESJleaySEDh2F2f
         S5nPxSlcDOHf+9lJqhXQGlKa2xUt0k2bqBYJxZ8UNyupY+nbZNLDhV5hIEtmENzZ9LwB
         zkySqi4xNRfDA92Tl2kEO/B3FO6Z+bbg/3TVno5zQhtMjU7P7wnEW6riiHTLmQFDYzaj
         LjCRgN5EeiKXqG+De+B4C/zZkBAMlD6PUGTWStCWC5cm9zFbvebCiyJnhZaoEhX1cPOs
         oJbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=/DZE/2EGuiaVLm+bRyE9gV/EUNvDMXyHbxd6dVVKrW4=;
        b=r1XlHseAA3S2j/fbX+2ZXl0BSvyE/enMtUQPwgt5numCOqCxmHaKf52wkGWc5uvXFI
         ieYFFuOjxzV0AZiEo+N62Asvvm8FJy0UrMkWDHr1Q+qylF4pjd4Uhvn9Fos/7orEOd1d
         jtuCbMUyAxHrv9pVTdfvE2MI0gPRMokGTb1yvs1DU0fOVTOU+Cmp+d8JhXkE6S7ipyIN
         wingt8quc20/6Dz8H4RwtVqGRLty7xkHYPO3zoHDb8zQ5aOGHaxSa57SyCMW4U3ngluW
         vCPyz1wU5saGq7rND/4iScwJw7tEYeAyYVBldKovCzElpGsKHEgHDAqMh/8PxLjxJFkw
         QnEA==
X-Gm-Message-State: APjAAAUidXKh2/28Et20PdwFPI7Uc7fw4Vva+mT0gSQAin14msC1fcVz
        X3wyh3T/4OgE4B2kDtJUra8=
X-Google-Smtp-Source: APXvYqwjg64iB0wTJeSRH/N0wMWAJRHCd+Q8lPmY0ok/5jmf+RQXozt5lqsR5VOK/SrcHidg5+ohMw==
X-Received: by 2002:a1c:2407:: with SMTP id k7mr9308785wmk.137.1554034767631;
        Sun, 31 Mar 2019 05:19:27 -0700 (PDT)
Received: from debian (cpc101300-bagu16-2-0-cust362.1-3.cable.virginm.net. [86.21.41.107])
        by smtp.gmail.com with ESMTPSA id v184sm18635897wma.6.2019.03.31.05.19.26
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 31 Mar 2019 05:19:26 -0700 (PDT)
Date:   Sun, 31 Mar 2019 13:19:24 +0100
From:   Sudip Mukherjee <sudipm.mukherjee@gmail.com>
To:     Yifeng Li <tomli@tomli.me>
Cc:     Teddy Wang <teddy.wang@siliconmotion.com>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH 3/8] fbdev: sm712fb: fix VRAM detection, don't set
 SR70/71/74/75.
Message-ID: <20190331121924.5wjhhjp2j2gom7zp@debian>
References: <20190316222504.27170-1-tomli@tomli.me>
 <20190316222504.27170-4-tomli@tomli.me>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190316222504.27170-4-tomli@tomli.me>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Mar 17, 2019 at 06:24:59AM +0800, Yifeng Li wrote:
> On a Thinkpad s30 (Pentium III / i440MX, Lynx3DM), the amount of Video
> RAM is not detected correctly by the xf86-video-siliconmotion driver.
> This is because sm712fb overwrites the GPR71 Scratch Pad Register, which
> is set by BIOS on x86 and used to indicate amount of VRAM.
> 
> Other Scratch Pad Registers, including GPR70/74/75, don't have the same
> side-effect, but overwriting to them is still questionable, as they are
> not related to modesetting.
> 
> Stop writing to SR70/71/74/75 (a.k.a GPR70/71/74/75).
> 
> Signed-off-by: Yifeng Li <tomli@tomli.me>
> Cc: stable@vger.kernel.org  # v4.4+

Tested-by: Sudip Mukherjee <sudipm.mukherjee@gmail.com>

--
Regards
Sudip

Return-Path: <SRS0=E/6H=U3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5BF12C4321A
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Jun 2019 13:10:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 39E8C208E3
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Jun 2019 13:10:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726916AbfF1NKm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 28 Jun 2019 09:10:42 -0400
Received: from mail-qt1-f196.google.com ([209.85.160.196]:39878 "EHLO
        mail-qt1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726587AbfF1NKm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Jun 2019 09:10:42 -0400
Received: by mail-qt1-f196.google.com with SMTP id i34so6151737qta.6
        for <linux-kernel@vger.kernel.org>; Fri, 28 Jun 2019 06:10:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=o2c7eqcB3k0o55ijnQbOy72m754FPugjxJ+siH2Ukek=;
        b=HJHOQ+KFxYkhc41w6OnmYcZnbCJCtYi0uDlLJ4HPtxr9h0l6gQC/FmNr5p98bMFsG8
         yqC1M/YAITTveY9JXX7HzJxeYPWeXAxQKvYVDfSFW8a0hyZ6BkRtG8716gBImGJMLJNF
         fTrDdE/BpYoJIBiRxHTFzhheMqrB34ULBflMkrefqsm7/sdCuhqnV+kvAytUC6YzIiGq
         hWiBSymAdb7ZfEi3SjV/I58Qo2StTr5el0HJTHdnwadioSEutC39QuvaeGbA/qyTOilv
         ijH1s/YvARZAAkQ6ktfAVgpzsmyo/8nGxmvlMABlW+MG/yD46ce99TgkBAd1O9dIOW9d
         iXVg==
X-Gm-Message-State: APjAAAVoELikLnMd3Et+tHn5RQtHLD7MucUx9OTS38QrXpfMcTBKxskW
        16BvI9nsDGb0blwKueMnMUIhrvc/55Io8d6aSSXXfqkm
X-Google-Smtp-Source: APXvYqz/s4dkECw2z/P+uA1hvyLBd3yUyH88Udt175wZ/fRy6rW3brojQZS2t73cDQNFyMgCM5vYR0cjyt88WHuexRA=
X-Received: by 2002:a0c:ba2c:: with SMTP id w44mr8171926qvf.62.1561727441607;
 Fri, 28 Jun 2019 06:10:41 -0700 (PDT)
MIME-Version: 1.0
References: <20190628103359.2516007-1-arnd@arndb.de> <20190628124832.cedpoabfiqgjhtkq@shell.armlinux.org.uk>
In-Reply-To: <20190628124832.cedpoabfiqgjhtkq@shell.armlinux.org.uk>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Fri, 28 Jun 2019 15:10:25 +0200
Message-ID: <CAK8P3a3=tf987CdTHWFxfXd2BAXwbwfmHDsLK3VjaKPpPP7zQA@mail.gmail.com>
Subject: Re: [PATCH] drm/armada: fix debugfs link error
To:     Russell King - ARM Linux admin <linux@armlinux.org.uk>
Cc:     David Airlie <airlied@linux.ie>, Daniel Vetter <daniel@ffwll.ch>,
        Sam Ravnborg <sam@ravnborg.org>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 28, 2019 at 2:48 PM Russell King - ARM Linux admin
<linux@armlinux.org.uk> wrote:
>
> On Fri, Jun 28, 2019 at 12:33:40PM +0200, Arnd Bergmann wrote:
> > Debugfs can be disabled at compile time, causing a link error
> > with the newly restructured code:
> >
> > drivers/gpu/drm/armada/armada_crtc.o: In function `armada_drm_crtc_late_register':
> > armada_crtc.c:(.text+0x974): undefined reference to `armada_drm_crtc_debugfs_init'
> >
> > Make the code into the debugfs init function conditional.
>
> Thanks Arnd, mind if I roll this into the original commit?

That would be best, please do so.

      Arnd

Return-Path: <SRS0=5O2B=VH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AD3F5C73C76
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Jul 2019 07:05:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8E43520651
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Jul 2019 07:05:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726692AbfGJHFx convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 10 Jul 2019 03:05:53 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:43557 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726151AbfGJHFw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Jul 2019 03:05:52 -0400
Received: from mail-wm1-f70.google.com ([209.85.128.70])
        by youngberry.canonical.com with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
        (Exim 4.76)
        (envelope-from <chia-lin.kao@canonical.com>)
        id 1hl6fm-0007KS-Ut
        for linux-kernel@vger.kernel.org; Wed, 10 Jul 2019 07:05:50 +0000
Received: by mail-wm1-f70.google.com with SMTP id n25so364411wmc.7
        for <linux-kernel@vger.kernel.org>; Wed, 10 Jul 2019 00:05:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=dN3J5bKVO8t1U0024RiGjSSKUlILA2QH4v/NEife78A=;
        b=WWIpBY+UI0WfTUNNgHM60OE6YJk51tuBkavwBxlLYgWomwbSNmdYNQ1IpLlFtkdjkR
         BC5xTP78yOlK6/Ra2TcZXBPtWpK92PMk2f325Pdf3OLFqyr8BBlPkasjuKETLVOu4MNe
         /RzrbPaI56ps5aFGUcFobjkSBbTjQz1x49k/lWDyoNBfshR4zrz09TCAfC+DJdOE7YDu
         fKg81d8i97CmJpOATz9LGSCsg/89StK6YAr6CQK6+KA9k6HpAThuhdxWAhcjDQNOvurz
         x4c8HQZ1OI+UOPOcV/xj619kyh2GmpVONTKZHG88arWrmCcqurwyvyrHSh8uL5BeG3Rc
         ofZw==
X-Gm-Message-State: APjAAAX0YvKHa24LvRZWie9n86d2IGbeZU1ax/mxzc1hpH6n8qoLVWwy
        Alw+agQ1FXKP3fnu+m4egwYnwYmDImlsR4l3QbIRGSWBvxMIdZ8Qyew2WLqTQX9qy3zYxgKXHGM
        pdS2XMqQiX0tVgxQJbqplEi9teLigxp0+16EFPj1Ok06zkn4llcgaHRQbfg==
X-Received: by 2002:a1c:6a11:: with SMTP id f17mr3184152wmc.110.1562742349472;
        Wed, 10 Jul 2019 00:05:49 -0700 (PDT)
X-Google-Smtp-Source: APXvYqzyE97uF612RbHirhkWKN+Vaod1qzbqXurrx8gvlnUkc4j5SZf9eLyoiVDMO5W9ZoO58P0L00rpzXNAO3twkSQ=
X-Received: by 2002:a1c:6a11:: with SMTP id f17mr3184108wmc.110.1562742349186;
 Wed, 10 Jul 2019 00:05:49 -0700 (PDT)
MIME-Version: 1.0
References: <20190708063751.16234-1-acelan.kao@canonical.com>
 <53f82481-ed41-abc5-2e4e-ac1026617219@gmail.com> <CAFv23Q=mA9t0j2F4fKdOkgG6sao0m7rR_9-d9OvAmSerZf_=ew@mail.gmail.com>
In-Reply-To: <CAFv23Q=mA9t0j2F4fKdOkgG6sao0m7rR_9-d9OvAmSerZf_=ew@mail.gmail.com>
From:   AceLan Kao <acelan.kao@canonical.com>
Date:   Wed, 10 Jul 2019 15:05:38 +0800
Message-ID: <CAFv23QmqjJtUD-iAwzsXg2MCNbe_p1zOcZ7C-ywG5n-iT-N-YA@mail.gmail.com>
Subject: Re: [PATCH] r8169: add enable_aspm parameter
To:     Heiner Kallweit <hkallweit1@gmail.com>
Cc:     Realtek linux nic maintainers <nic_swsd@realtek.com>,
        "David S. Miller" <davem@davemloft.net>, netdev@vger.kernel.org,
        "Linux-Kernel@Vger. Kernel. Org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Heiner,

I've tried and verified your PCI ASPM patches and it works well.
I've replied the patch thread and hope this can make it get some progress.

BTW, do you think we can revert commit b75bb8a5b755 ("r8169: disable
ASPM again") once the PCI ASPM patches get merged?

Best regards,
AceLan Kao.

AceLan Kao <acelan.kao@canonical.com> 於 2019年7月9日 週二 上午11:19寫道：
>
> Heiner Kallweit <hkallweit1@gmail.com> 於 2019年7月9日 週二 上午2:27寫道：
> >
> > On 08.07.2019 08:37, AceLan Kao wrote:
> > > We have many commits in the driver which enable and then disable ASPM
> > > function over and over again.
> > >    commit b75bb8a5b755 ("r8169: disable ASPM again")
> > >    commit 0866cd15029b ("r8169: enable ASPM on RTL8106E")
> > >    commit 94235460f9ea ("r8169: Align ASPM/CLKREQ setting function with vendor driver")
> > >    commit aa1e7d2c31ef ("r8169: enable ASPM on RTL8168E-VL")
> > >    commit f37658da21aa ("r8169: align ASPM entry latency setting with vendor driver")
> > >    commit a99790bf5c7f ("r8169: Reinstate ASPM Support")
> > >    commit 671646c151d4 ("r8169: Don't disable ASPM in the driver")
> > >    commit 4521e1a94279 ("Revert "r8169: enable internal ASPM and clock request settings".")
> > >    commit d64ec841517a ("r8169: enable internal ASPM and clock request settings")
> > >
> > > This function is very important for production, and if we can't come out
> > > a solution to make both happy, I'd suggest we add a parameter in the
> > > driver to toggle it.
> > >
> > The usage of a module parameter to control ASPM is discouraged.
> > There have been more such attempts in the past that have been declined.
> >
> > Pending with the PCI maintainers is a series adding ASPM control
> > via sysfs, see here: https://www.spinics.net/lists/linux-pci/msg83228.html
> Cool, I'll try your patches and reply on that thread.
>
> >
> > Also more details than just stating "it's important for production"
> > would have been appreciated in the commit message, e.g. which
> > power-savings you can achieve with ASPM on which systems.
> I should use more specific wordings rather than "important for
> production", thanks.

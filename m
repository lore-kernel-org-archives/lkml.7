Return-Path: <SRS0=bmbz=XS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CC372C432C1
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Sep 2019 22:12:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 98A0220673
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Sep 2019 22:12:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kudzu-us.20150623.gappssmtp.com header.i=@kudzu-us.20150623.gappssmtp.com header.b="F8ctJGLe"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2503256AbfIWWMm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 23 Sep 2019 18:12:42 -0400
Received: from mail-io1-f67.google.com ([209.85.166.67]:39382 "EHLO
        mail-io1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390504AbfIWWMm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Sep 2019 18:12:42 -0400
Received: by mail-io1-f67.google.com with SMTP id a1so37460086ioc.6
        for <linux-kernel@vger.kernel.org>; Mon, 23 Sep 2019 15:12:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kudzu-us.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=BxQAioENvWKeyWX2UgPIsVXz8z9Ck2G/PQ6H2v2Nkt4=;
        b=F8ctJGLewtJXdVkVW/sAHDjqnbpxrhr1ayqqYwBNe6EIar9iupYl0F/syQz26rCvrs
         x16xUKs3fRX1OPYQKkVgo5UbSDQsIZxW9WTuVP3tzMCWXRo67R3+LZTwx81yYuuxDHLD
         9FdK4TAv9ok5WDLF0+7PHI+LssgifEZYaNMAZaiAbu1Pk4N6BwlM6lWU63LN238YuYTu
         NqE9FDN7IJOVij+ApF9awMztFT1igiW486u/WpF2zaedxz3+g8fr320X+aauGyQirsxN
         nfdfbxf1HlhXMGNVUTMS/I/L1vHC1PxTSt2PPZyZPfHr8bufCbmPxztTvX5n+/Va1+mG
         AUjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=BxQAioENvWKeyWX2UgPIsVXz8z9Ck2G/PQ6H2v2Nkt4=;
        b=kjpS4NYxWgLUoQ6uyGgGlWHpd1EDV1+DEh6x46jRDk5pZOOQWTqe9YgvDSpv8Ewdip
         l0NICBsvBD7XGMSO/NsZi7Hzf425djuwr9EgaChhrOiB+qRFKK9Gnx0bY1tPhnkgLoAw
         5wlWg0IGoFI6v1OMgrFP+4BtMiCn+J8qcBi2ZNgOi4jo8nG/DWi6zOy0Er1OdldFD9mj
         22/tQANX/hqCJF5ZD/rOJkIMPt/895fIPLDuTEcgYvXxCY2RHy9hlU4Fs4Wodn584dKV
         j8ESDyMHwiNC57dEPRSeEAs5AOt0EW2O9Kg3xdRdzHkYUEjg5MiQOBftVk8d/6Baus21
         zCSA==
X-Gm-Message-State: APjAAAVPpqwMAMALcEeNDy9fRKIvJXeg8ePEdCfQXxOp1kfFp4ZG0Bak
        579Uzuw39oChalnDjGwCPT1Am4DWu+F9RvC90XbT+w==
X-Google-Smtp-Source: APXvYqx6j/1nDfdL4HH9dogDjsVjxbERB+URgdtCJ2QOh9KSptcnQ870q6RZ9okdgX6tr0Igb3wtrSxXnyLZjIs2L4g=
X-Received: by 2002:a6b:da06:: with SMTP id x6mr1956758iob.42.1569276761401;
 Mon, 23 Sep 2019 15:12:41 -0700 (PDT)
MIME-Version: 1.0
References: <55f2fb85-9d4d-f78d-e6dd-70b09d7667e4@infradead.org>
In-Reply-To: <55f2fb85-9d4d-f78d-e6dd-70b09d7667e4@infradead.org>
From:   Jon Mason <jdmason@kudzu.us>
Date:   Mon, 23 Sep 2019 15:12:30 -0700
Message-ID: <CAPoiz9zWo+LuzWG29kSYCrs9FdwvzDycWBEmg_GHL3W5c3QRuQ@mail.gmail.com>
Subject: Re: [PATCH] NTB: fix IDT Kconfig typos/spellos
To:     Randy Dunlap <rdunlap@infradead.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        linux-ntb <linux-ntb@googlegroups.com>,
        Dave Jiang <dave.jiang@intel.com>,
        Allen Hubbe <allenbh@gmail.com>,
        Serge Semin <fancer.lancer@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 18, 2019 at 1:58 PM Randy Dunlap <rdunlap@infradead.org> wrote:
>
> From: Randy Dunlap <rdunlap@infradead.org>
>
> Fix typos in drivers/ntb/hw/idt/Kconfig.
> Use consistent spelling and capitalization.
>
> Fixes: bf2a952d31d2 ("NTB: Add IDT 89HPESxNTx PCIe-switches support")
> Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
> Cc: Jon Mason <jdmason@kudzu.us>
> Cc: Dave Jiang <dave.jiang@intel.com>
> Cc: Allen Hubbe <allenbh@gmail.com>
> Cc: Serge Semin <fancer.lancer@gmail.com>
> Cc: linux-ntb@googlegroups.com

Pulled into the ntb branch.

Thanks,
Jon

> ---
>  drivers/ntb/hw/idt/Kconfig |    6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
>
> --- lnx-53.orig/drivers/ntb/hw/idt/Kconfig
> +++ lnx-53/drivers/ntb/hw/idt/Kconfig
> @@ -4,11 +4,11 @@ config NTB_IDT
>         depends on PCI
>         select HWMON
>         help
> -        This driver supports NTB of cappable IDT PCIe-switches.
> +        This driver supports NTB of capable IDT PCIe-switches.
>
>          Some of the pre-initializations must be made before IDT PCIe-switch
> -        exposes it NT-functions correctly. It should be done by either proper
> -        initialisation of EEPROM connected to master smbus of the switch or
> +        exposes its NT-functions correctly. It should be done by either proper
> +        initialization of EEPROM connected to master SMbus of the switch or
>          by BIOS using slave-SMBus interface changing corresponding registers
>          value. Evidently it must be done before PCI bus enumeration is
>          finished in Linux kernel.
>
>

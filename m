Return-Path: <SRS0=ATYp=YN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 51FF8CA9EA0
	for <linux-kernel@archiver.kernel.org>; Sun, 20 Oct 2019 07:56:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1B2B521929
	for <linux-kernel@archiver.kernel.org>; Sun, 20 Oct 2019 07:56:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="j8WdmtvH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726195AbfJTH4F (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 20 Oct 2019 03:56:05 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:37819 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725823AbfJTH4E (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 20 Oct 2019 03:56:04 -0400
Received: by mail-pg1-f195.google.com with SMTP id p1so5756369pgi.4;
        Sun, 20 Oct 2019 00:56:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=yLA2DAJLAdD0BPQ/P6UE13BcbkNCyocrAF+mtXGIWrg=;
        b=j8WdmtvHAaSmKz9JAZopxZmYm2S3zhIIeW5EY2zmf5v4BV6LoNOou5LRmo4ms0NpeS
         N8L744jtixqiUkdxuneHttt68OOKSyCWW6SGzRpil2q8VH3gsfq3gzla0WMKjVRUCxq/
         0PKDoi/odKVtqbU0Db2HoIAFsiluIGhsuDvhlWsmHmLW/o6LRXilP6Y5yDZX95IwIViz
         w7XhIOcKTG5htmDP20YGVgOybyu4Nck6ljHmyYS0sfhCWzJGNHVw74J6P9o7MimrtDV8
         EJdReUNC5plIV7uGkf+P5NdMt3D6TNBN1sAFmHhxAf87XCoDUZ/fSq5SdIHnpJVilO2c
         UxqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=yLA2DAJLAdD0BPQ/P6UE13BcbkNCyocrAF+mtXGIWrg=;
        b=CAQ9uaFtkvAEGy3RkuKVpBDj+68W1XXSNsdRiScG5hxIr+3ju6huj0g99llTxeE9Jt
         gPunj+HVPmnabGeSFJ7MMJiMTKju1MHoCyZRPPFPKWqfLy93H0nG04A7wd5mJdYOCLYF
         hi7AP/OKSaXuVKgXoCbU7w1UDsXTMPVvu/lR1nPhdCWtcKQjTBqm9HwhQx1i7JeRR6Ca
         HE87O2wMVqqOVlDakQNMFo7F0MerYEbJ95N62zf1Nu90kA8/OScY9a5nHJgbHV/xT0kp
         xvdMMuKYCrF19ujOMlDSgHYPDsIQ0HAHe20ePAtbW1JpXvlBRp0LXkPvep6H/U5ITqQB
         8SPg==
X-Gm-Message-State: APjAAAUoH/IpR44eLf5oa3Zw77Egg317jDhobwgdMCMEk4RGpKowI7wa
        gEqoa5yLAw9aghB2AK2d6asEm+qzyiiGIddTrBY=
X-Google-Smtp-Source: APXvYqwtn37wtByUfUQCBPYTxcfTjtJ6ewvFt9KnfIz3JdSOUlg4VmqpWQzU/4lSNmEQjdGiiVhkIRqDEDjMLvque84=
X-Received: by 2002:a17:90a:b391:: with SMTP id e17mr21932309pjr.132.1571558163520;
 Sun, 20 Oct 2019 00:56:03 -0700 (PDT)
MIME-Version: 1.0
References: <20191018224221.15495-1-ayman.bagabas@gmail.com>
 <20191019082855.GN21344@kadam> <058a2a50d9a819a5e87d526f986b8bf2017b9671.camel@gmail.com>
In-Reply-To: <058a2a50d9a819a5e87d526f986b8bf2017b9671.camel@gmail.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Sun, 20 Oct 2019 10:55:51 +0300
Message-ID: <CAHp75Vc77cEwst8UwFY7e-w2evJN08FLyJCj=BjBEa+X_+QW+g@mail.gmail.com>
Subject: Re: [PATCH 1/2] platform/x86: huawei-wmi: Stricter battery thresholds set
To:     Ayman Bagabas <ayman.bagabas@gmail.com>
Cc:     Dan Carpenter <dan.carpenter@oracle.com>,
        Darren Hart <dvhart@infradead.org>,
        Andy Shevchenko <andy@infradead.org>,
        Mattias Jacobsson <2pi@mok.nu>, Takashi Iwai <tiwai@suse.de>,
        kbuild test robot <lkp@intel.com>,
        Platform Driver <platform-driver-x86@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Oct 20, 2019 at 3:33 AM <ayman.bagabas@gmail.com> wrote:
> On Sat, 2019-10-19 at 11:31 +0300, Dan Carpenter wrote:
> > On Fri, Oct 18, 2019 at 06:42:13PM -0400, Ayman Bagabas wrote:
> > > Check if battery thresholds are within 0 and 100.

> > Don't forget to add your Signed-off-by: though.

Please, resend all three with properly tagged with Sob, Fixes, etc.

-- 
With Best Regards,
Andy Shevchenko

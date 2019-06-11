Return-Path: <SRS0=TvG7=UK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1D0F4C4321A
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Jun 2019 19:06:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DFE462173C
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Jun 2019 19:06:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="N5Olom/a"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2407451AbfFKTG2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Jun 2019 15:06:28 -0400
Received: from mail-pl1-f193.google.com ([209.85.214.193]:40912 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2406995AbfFKTG1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Jun 2019 15:06:27 -0400
Received: by mail-pl1-f193.google.com with SMTP id a93so5515000pla.7;
        Tue, 11 Jun 2019 12:06:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=3JZoAuRN+dQJFvqjiWMObWkX3snfaRON9kU780Nfc80=;
        b=N5Olom/a8uFFm4PubhWxMt99kaR7gf+b3J5IcNw7IK18tC0pMmxPBJ2/52lI6I6IG6
         0zuoU659YQGv6hsev5yyr7NHxfvFHkP1zhdnun8I5XHM2gLqzjxAA+3y7rfe06Tf7DAm
         UGZDsi/V2OEPRukCESO+aJTZ7CncoHhhDHkcgrdtFlb+8qdRRSJTfhER02bE2GgQBCDM
         A4bdKa05HeI3zvldIKzxLEUF+52zWlqw30iSnejKTt9BtWw5EgC6uBisO2wmUKrb4ldT
         /J4RpkVeruE+Tezflzwbxl24Q9fNA910w4Ghs5uDaAqBGAgRGplWKp+8xKZ/0z9lyveP
         br+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=3JZoAuRN+dQJFvqjiWMObWkX3snfaRON9kU780Nfc80=;
        b=Q19IR9UOY9GMco5LB3SSkkOmv0PtGeGVVDerGtsJKysT08+cR2lWyrH+/DzO5bY6Og
         +OcTJhr5A3NDEP2qGH0pmTBX4/15ktWYh9m2AXkw7SumbmYxOn5F7L2XmavZDCOLwnKb
         WmUbj99UMGhob+14gDRlXhyWQyhJSYwFOmO+UsrvxG3dSDV6l+8gBj7XTwvrhweH88ym
         B4mcGwE3VfvENDRK6gklO7SQoL9c92pBF7cn/2OLFj8aXOikDp1p/rTwlhSHVKARRDp/
         4LV4LP8tG28D6taUXRV20CkTNPPkoHzcNx24gldo51lh69N1AxQRMI9bNo5L6fsPXQOT
         E1kQ==
X-Gm-Message-State: APjAAAXou6XLD0fP0PwHs92uq/YAvPmQOWTw146UVYiKix2x63gkFeWe
        ZnAY5QW5bDW/icdmpLHjagkhQvcPY69lDgRRuSk=
X-Google-Smtp-Source: APXvYqzvTWDm8W9aZG/57fKfGCOTuPY9ZUxtdsJvoLUWPQO6Pz+3gESDxSCGbqD7DNjiVoKPSI/3+aHwEGQdVyYRmGY=
X-Received: by 2002:a17:902:934a:: with SMTP id g10mr66852970plp.18.1560279986322;
 Tue, 11 Jun 2019 12:06:26 -0700 (PDT)
MIME-Version: 1.0
References: <20190508173403.6088d0db@canb.auug.org.au> <fa0e68b2-b839-b187-150c-13391c197b99@infradead.org>
 <CAHp75Veq2=XA124rG8urt3eVE3pcaUm0VdsV7Mxr9zjMpa7mjg@mail.gmail.com> <CACK8Z6F2v8nyUYcnOrkp81WfK2D2NEmK=pcWybn1annrtqRwew@mail.gmail.com>
In-Reply-To: <CACK8Z6F2v8nyUYcnOrkp81WfK2D2NEmK=pcWybn1annrtqRwew@mail.gmail.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Tue, 11 Jun 2019 22:06:15 +0300
Message-ID: <CAHp75Ver=TNKxh8rdJs1xQYSLNsRLfEoFtcGG6hViug=cF6s_g@mail.gmail.com>
Subject: Re: linux-next: Tree for May 8 (drivers/platform/x86/intel_pmc_core_plat_drv.c)
To:     Rajat Jain <rajatja@google.com>
Cc:     Randy Dunlap <rdunlap@infradead.org>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Platform Driver <platform-driver-x86@vger.kernel.org>,
        Rajneesh Bhardwaj <rajneesh.bhardwaj@intel.com>,
        Vishwanath Somayaji <vishwanath.somayaji@intel.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 9, 2019 at 2:15 AM Rajat Jain <rajatja@google.com> wrote:

> OK, NP. Just to be sure I understand,
>
> 1) Please let me know if I should send in a fix (it would be
> #include/linux/module.h and also add MODULE_LICENSE() I believe)?
> 2) Would this be lined up for next version though?

Resend a complete series based on the latest stuff we have in our
for-next branch.

-- 
With Best Regards,
Andy Shevchenko

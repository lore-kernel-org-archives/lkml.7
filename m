Return-Path: <SRS0=QEJJ=XC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A97B4C43331
	for <linux-kernel@archiver.kernel.org>; Sat,  7 Sep 2019 17:42:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 771D4218AC
	for <linux-kernel@archiver.kernel.org>; Sat,  7 Sep 2019 17:42:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ocs8/0bk"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2406204AbfIGRmJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 7 Sep 2019 13:42:09 -0400
Received: from mail-pf1-f195.google.com ([209.85.210.195]:33266 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389269AbfIGRmI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 7 Sep 2019 13:42:08 -0400
Received: by mail-pf1-f195.google.com with SMTP id q10so6612656pfl.0;
        Sat, 07 Sep 2019 10:42:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=A6Yx4Q7ZNAktHMtoIkw9cxLVNxvnMooP+6PjQIzFBLc=;
        b=ocs8/0bksVzpQ95cJR3AwWOOV9i513yrPdmP6gDKvtyQvEXcoG71bn2ge1hJqtpafb
         tfWqJoBj7iR/Wor7Z3xKECddouy9Z8L+UZdcazQK/pQWia1N6UV4qH7K7uBBk3SElx9Y
         IlgPgsHN0XLa0c+Z7HapbhZKTtVViNB8hvxMvYbHssYfeCQclFUi+PlNW9sR3xSrRFNM
         nYlpLTgAOSCoaovHrZ1p3cEMv1v0EbUpWeKRg4VYyxeTL2sAf+0/kF3nr2h27su6Mp9Z
         m5ink4/eWgbxr2HIrt9ZkvHJ8iuxJJcIbLAYTEU/EgatG2Dm5m4yPA+OWpuxDuqNg43F
         lQVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=A6Yx4Q7ZNAktHMtoIkw9cxLVNxvnMooP+6PjQIzFBLc=;
        b=ILO0fyuRhsqvtjrWXotOPlD08el5l8i0R41p+zpNy+lIoS8G/EvZVzgtFdX5P5haKR
         EyJUDqJagocl6nItrIWUEQX/d4adSub7RsEwLzS9pWIyWWQtvUvbfAWWKT6WbJHeHDiA
         N3ExXjJkRBxhdOiGsD9XI1VHf6ZjaHH0jzoTN3w7qJO8A+aq86H9Ac0UZ2W6bKyMhXrX
         3uLaBOviSlrNnbjDNLvxZQLlwyXzUZ/POEL2yPs8xDH4CICXbGkXZq9fYCZ/HYuFdvSn
         gyHmfMrEJhAcda8bc/vpygowabrWZvlRj3E/q6lbciCpFEz5dgEI9GO4XVFGWdDFM9kH
         4MDQ==
X-Gm-Message-State: APjAAAUCN4BlTs19TpH9Nl+16To7AR21dB4JPmKOvUa7UinXdY4pM5gJ
        gbQd/ByAne2k5Qf6YnkcVk4Qn2tJwpr+ijYwJ4M=
X-Google-Smtp-Source: APXvYqzvmObvTUN4HY8G5nCEBvOUJFUN0TPumuiDt3SoNIdH2vPal13U8d3/ofd0kPyX4GXtuJs30GluvtL4ZAoNjTc=
X-Received: by 2002:a63:1020:: with SMTP id f32mr14018816pgl.203.1567878128129;
 Sat, 07 Sep 2019 10:42:08 -0700 (PDT)
MIME-Version: 1.0
References: <CAHp75Ver=TNKxh8rdJs1xQYSLNsRLfEoFtcGG6hViug=cF6s_g@mail.gmail.com>
 <20190628033413.8058-1-rajatja@google.com> <CACK8Z6GYwPhz-+7zxxe-aG673Tbin=GYUvVZyL9cTgjqk_EXqA@mail.gmail.com>
In-Reply-To: <CACK8Z6GYwPhz-+7zxxe-aG673Tbin=GYUvVZyL9cTgjqk_EXqA@mail.gmail.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Sat, 7 Sep 2019 20:41:57 +0300
Message-ID: <CAHp75VdPY83U5dWJbca_ZCJwT6z8L+V4R+fY0aZTOkM=vNweYQ@mail.gmail.com>
Subject: Re: [PATCH v7] platform/x86: intel_pmc_core: Attach using APCI HID "INT33A1"
To:     Rajat Jain <rajatja@google.com>
Cc:     Rajneesh Bhardwaj <rajneesh.bhardwaj@intel.com>,
        Vishwanath Somayaji <vishwanath.somayaji@intel.com>,
        Darren Hart <dvhart@infradead.org>,
        Andy Shevchenko <andy@infradead.org>,
        Platform Driver <platform-driver-x86@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Rafael J Wysocki <rafael.j.wysocki@intel.com>,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        Furquan Shaikh <furquan@google.com>,
        Evan Green <evgreen@google.com>,
        Rajat Jain <rajatxjain@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 23, 2019 at 1:44 AM Rajat Jain <rajatja@google.com> wrote:
>
> On Thu, Jun 27, 2019 at 8:34 PM Rajat Jain <rajatja@google.com> wrote:
> >
> > Most modern platforms already have the ACPI device "INT33A1" that could
> > be used to attach to the driver. Switch the driver to using that and
> > thus make the intel_pmc_core.c a pure platform_driver.
> >
> > Some of the legacy platforms though, may still not have this ACPI device
> > in their ACPI tables. Thus for such platforms, move the code to manually
> > instantiate a platform_device into a new file of its own. This would
> > instantiate the intel_pmc_core platform device and thus attach to
> > the driver, if the ACPI device for the same ("INT33A1") is not present
> > in a system where it should be. This was discussed here:
> > https://www.mail-archive.com/linux-kernel@vger.kernel.org/msg1966991.html
>
>
> HI Andy, Rajneesh, this seems to have fallen through the cracks. Any
> comments here on this patch?

% git tag --list v5.3* --contains b02f6a2ef0a1
v5.3-rc1

-- 
With Best Regards,
Andy Shevchenko

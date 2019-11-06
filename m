Return-Path: <SRS0=fWiu=Y6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 105FEC5DF62
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Nov 2019 07:04:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C941F217F4
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Nov 2019 07:04:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ae+CLWxd"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731324AbfKFHEr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 Nov 2019 02:04:47 -0500
Received: from mail-pg1-f196.google.com ([209.85.215.196]:44225 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731321AbfKFHEo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Nov 2019 02:04:44 -0500
Received: by mail-pg1-f196.google.com with SMTP id f19so7385781pgk.11;
        Tue, 05 Nov 2019 23:04:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=1tK6qAgSyW1KVyDgDREpaqmKGvD0WIXvKK/Qd6b0nDE=;
        b=ae+CLWxdJ3cYhTJypVyTMiKYRRBjtcupazQX7FhuFJgEqDORogowjNmDWmOLcAmf3D
         GotCPztGZjZW8WqD3qfU8baB4BYxEQ3rqzAyZya6Akj/Ixf2TRZyZ0h5O2mc3NdTjU0T
         RAF2UP80BV91SDlLUacf0n4+28QvsyB0XCIJbtTc2aqvIIiKP4LcUESt9URLbTN7XRGi
         Y2eX1QJMpis4kGBTmHXTBzsxs8PgML7Ul81JS8JNFt0/qUA3mXVyKitcaWwrFYSXgOa4
         iHPnvCdA1nVzxLUpYdZ4ECjok20iHKwwcLOuCsamCiNroVDCTAfjUClIfegTtyq/VPe/
         0QUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=1tK6qAgSyW1KVyDgDREpaqmKGvD0WIXvKK/Qd6b0nDE=;
        b=KVqoFEpAfdEoiNPpY962euGWhqnxDe5u/7xQ5N3WvD0rdpYW4GZhWh5nnhU0m02o2I
         hm0TOsDVXOlmn89W0HDm76f5zOvTLCPWzPdQebT0NeQkF9HJye0152em4RnHpXrOCaaA
         eiW7ci4/NoNs4w6qI3H2V40nG/0EQ+Gc2jDcWKyic0+sPe5gQh/U1i6n3Ss4r3BGcAOg
         dKxxKXNeVbnLClxFDA4MRD5w6kYAQt6Ic71NnoPCDy+8smLsn21CNwtT59ReWnG4QcPA
         f0EBHh5weWe8f+8IEbNKvLH5yJpVFIC6juBeURdKBo1cEGUPO2p6ecKN/mkQiIOYRAhO
         366w==
X-Gm-Message-State: APjAAAUUTiFCd+TQwFaZdnZbX/MWByBGqk4bd7GRqxo0yn2vxPkZFPJ5
        LdDYxzvUmX09j8CrAb7NDOrEa2QZP5rNhNAscjnjPdQJNig=
X-Google-Smtp-Source: APXvYqzc4zZKIjN/CYg0KVgxmIzcwQx4OV/6km/EjesoJzoAGNrpR9KJz6tgaXVSYgCHP/jXRqIizOArh/yNANwLH0o=
X-Received: by 2002:a65:5542:: with SMTP id t2mr1165282pgr.74.1573023882548;
 Tue, 05 Nov 2019 23:04:42 -0800 (PST)
MIME-Version: 1.0
References: <20191104213828.18278-1-leonmaxx@gmail.com> <201911050736.UAVD3aIV%lkp@intel.com>
In-Reply-To: <201911050736.UAVD3aIV%lkp@intel.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Wed, 6 Nov 2019 09:04:31 +0200
Message-ID: <CAHp75VdS5T8xVn_FFWX4DbAvP34CP3J2Ax_j9row9APQw0PY2w@mail.gmail.com>
Subject: Re: [PATCH v2 2/3] platform/x86: asus_wmi: Support fan boost mode on FX505DY/FX705DY
To:     kbuild test robot <lkp@intel.com>
Cc:     Leonid Maksymchuk <leonmaxx@gmail.com>, kbuild-all@lists.01.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Platform Driver <platform-driver-x86@vger.kernel.org>,
        acpi4asus-user <acpi4asus-user@lists.sourceforge.net>,
        Chris Chiu <chiu@endlessm.com>,
        Yurii Pavlovskyi <yurii.pavlovskyi@gmail.com>,
        Kristian Klausen <kristian@klausen.dk>,
        Andy Shevchenko <andy@infradead.org>,
        Darren Hart <dvhart@infradead.org>,
        Corentin Chary <corentin.chary@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 5, 2019 at 2:01 AM kbuild test robot <lkp@intel.com> wrote:
>
> Hi Leonid,
>
> Thank you for the patch! Yet something to improve:
>
> [auto build test ERROR on linus/master]
> [also build test ERROR on v5.4-rc6 next-20191031]

Leonid, I may not accept patches that contributor didn't even compile.
How had you tested?

-- 
With Best Regards,
Andy Shevchenko

Return-Path: <SRS0=wo+8=V5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3C356C32753
	for <linux-kernel@archiver.kernel.org>; Thu,  1 Aug 2019 23:40:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 12F5D206A3
	for <linux-kernel@archiver.kernel.org>; Thu,  1 Aug 2019 23:40:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="GfQD9FxP"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388522AbfHAXke (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 1 Aug 2019 19:40:34 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:34125 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732215AbfHAXke (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Aug 2019 19:40:34 -0400
Received: by mail-pg1-f193.google.com with SMTP id n9so28826034pgc.1
        for <linux-kernel@vger.kernel.org>; Thu, 01 Aug 2019 16:40:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=message-id:mime-version:content-transfer-encoding:in-reply-to
         :references:subject:from:cc:to:user-agent:date;
        bh=JKIoLFzzkXibS5O3zhs4gTdyl9Ps1+sukQExcGJaYsY=;
        b=GfQD9FxPIpykw+z4D8TSlVF/7q8v4ZmsP4UEn2Z8g8eP2JrYLJsiEugo+EGHUZys1/
         tKSUeFkfmYkyg/rp/r1r7oWrz7UlNkK1hMyzc2+KK7BOynxJn6VLNJNUfRE64/cficll
         daS5ql4z+Lk+3XFHDmErq2QSTvlcNnEkckyxU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:mime-version
         :content-transfer-encoding:in-reply-to:references:subject:from:cc:to
         :user-agent:date;
        bh=JKIoLFzzkXibS5O3zhs4gTdyl9Ps1+sukQExcGJaYsY=;
        b=kfCCkk9MpC2cPMIyrcNV0/3CWrUMf43vL9CYP4TNqU9C6krK8r+RweGIypyXlRQLlj
         B4qA1gDvvsQwh4xuvG2q/cpgBqxvXFD8y8tg71TPpzCxw6v28wwR3C888+OdzhHHxuSq
         BuCgc/HicdzbUPA51U/+2RJ84k19E9SQu+MoYs+jCpIMyp9kBcXk7F7N3J6TEwsCLO8+
         DaB+N+CaAj7vDBZxKdwsjp58EGcFGMzaKiSjBZFqEF+s5VfrpojU3OEshCoSXNhxaPJc
         jN2EC36A1lSJLDj6ET77cVuttWoxo/gUaheSSUUboLK8z5+CNH9+K6MXUOxKgcSXjJWn
         xj7Q==
X-Gm-Message-State: APjAAAXCK09tzTTs6C3yRd80OrQlw79P04U2gizeD6SmRNGMhBm3wIzU
        4NqdQIloFe79aJKfOkX3ooha4w==
X-Google-Smtp-Source: APXvYqwSHduDv9EQjTdZzw6hWDoJb/3GyyfQf2Cb+rry3j/DqDdLwZVycOZknpu7GCutuOc8L2CWig==
X-Received: by 2002:a63:c64b:: with SMTP id x11mr7215244pgg.319.1564702833651;
        Thu, 01 Aug 2019 16:40:33 -0700 (PDT)
Received: from chromium.org ([2620:15c:202:1:fa53:7765:582b:82b9])
        by smtp.gmail.com with ESMTPSA id o14sm5833555pjp.29.2019.08.01.16.40.32
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Thu, 01 Aug 2019 16:40:33 -0700 (PDT)
Message-ID: <5d437871.1c69fb81.74806.02ea@mx.google.com>
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <CAJZ5v0jTviWeJhrWHGrtQHrVXAPoHDyFs6-06paJPHX-mH33bg@mail.gmail.com>
References: <20190731215514.212215-1-trong@android.com> <6987393.M0uybTKmdI@kreacher> <CANA+-vAPpXF1=z1=OjOhr8HWQ=Qn39qtQ3+8bUeXNTuFFTxoJQ@mail.gmail.com> <CAJZ5v0go-qOTyQV4D2Sj_xQxT831PxJZP0uay67rG73Q3K2pHQ@mail.gmail.com> <5d42281c.1c69fb81.bcda1.71f5@mx.google.com> <CANA+-vCoCuMtSKCfnav9NSwrzX7of9iLbppNX+pcymBp19kgQQ@mail.gmail.com> <5d434a23.1c69fb81.c4201.c65b@mx.google.com> <CANA+-vCt3QJDykzbZWBDZyaiaMiz_SOJ+Htv7+G0czjL07MjmQ@mail.gmail.com> <5d4363ae.1c69fb81.b621e.65ed@mx.google.com> <CAJZ5v0jTviWeJhrWHGrtQHrVXAPoHDyFs6-06paJPHX-mH33bg@mail.gmail.com>
Subject: Re: [PATCH v6] PM / wakeup: show wakeup sources stats in sysfs
From:   Stephen Boyd <swboyd@chromium.org>
Cc:     Tri Vo <trong@android.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Hridya Valsaraju <hridya@google.com>,
        Sandeep Patil <sspatil@google.com>,
        Kalesh Singh <kaleshsingh@google.com>,
        Ravi Chandra Sadineni <ravisadineni@chromium.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        "Cc: Android Kernel" <kernel-team@android.com>
To:     "Rafael J. Wysocki" <rafael@kernel.org>
User-Agent: alot/0.8.1
Date:   Thu, 01 Aug 2019 16:40:32 -0700
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Rafael J. Wysocki (2019-08-01 15:46:33)
> On Fri, Aug 2, 2019 at 12:11 AM Stephen Boyd <swboyd@chromium.org> wrote:
> >
> > Ok. If the device name is going to be something generic like 'wakeupN',
> > then we need to make sure that the wakeup source name is unique.
> > Otherwise, I'm not able to see how userspace will differentiate between
> > two of the same named wakelocks. Before this patch the wakeup source
> > name looks to have been used for debugging, but now it's being used
> > programmatically to let userspace act upon it somehow.
>=20
> I'm not actually sure if this patch changes the situation with respect
> to wakeup source names.   User space still can use them for whatever
> it used to use the list in debugfs and that's it.
>=20
> That's what I mean by retaining the names for "backwards compatibility on=
ly".
>=20

Ok, got it. Maybe one day the name attribute will become unimportant if
we have a namespace and process aware wake lock API in userspace.


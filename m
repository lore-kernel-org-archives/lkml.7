Return-Path: <SRS0=Z4g5=TY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 00769C072B5
	for <linux-kernel@archiver.kernel.org>; Fri, 24 May 2019 19:54:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C801D217F9
	for <linux-kernel@archiver.kernel.org>; Fri, 24 May 2019 19:54:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=endlessm-com.20150623.gappssmtp.com header.i=@endlessm-com.20150623.gappssmtp.com header.b="mK/rlgCH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391774AbfEXTy4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 May 2019 15:54:56 -0400
Received: from mail-qk1-f194.google.com ([209.85.222.194]:45058 "EHLO
        mail-qk1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2391698AbfEXTy4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 May 2019 15:54:56 -0400
Received: by mail-qk1-f194.google.com with SMTP id j1so9240118qkk.12
        for <linux-kernel@vger.kernel.org>; Fri, 24 May 2019 12:54:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=endlessm-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Xt54DDre1TnEzFOMPDPIB0ZqDFDYOYSsZfmW1xx+YWQ=;
        b=mK/rlgCHAU31Ndy2/TknRICETkuDWRLiMDV9Ep2/UJnYqsLhT0+uhK5DQn2MjbacoA
         UtiSL81Y223VZ6hhlz7ZAYZwMZGNX4FAZAS3sZCi79fa/aqx+afEspIN8tBtToMwLpTG
         LvCmWMXmX5LwkMDAbCTY06fFTq4oiMdL4RDL+Ps5Ue+gI1cfOUjDMsIDc0Gptly9jdpl
         kIfzx+J9WwBJziJN+BTwFqTpoFKVpN6upMG7aSCuQLlMyscTSWU5if+RVptV9/uRtsGH
         Bl+ipk0QHHOZ0PFSEiHZ1P4IHxDGEcwlHB9F3JHxEygIOdGg9zASrzNFFvQDVt/GPfP9
         zj9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Xt54DDre1TnEzFOMPDPIB0ZqDFDYOYSsZfmW1xx+YWQ=;
        b=gL01nu0JDnBtkxd58DCLHHFPqghm/J7w8MCOYMV0nfH9J6DgzfVeMM0P5RJKwM4i3G
         i574I70V72OVWU5+WdKMugsv540KuBhhFZnsYGhoG1U5Stvr8dTrFeVHV+0X6gdEK21+
         nRGlODFhlNk2z+zsDGAiO8kOs7mNh3QSQVlRilTQbQFrTaulpMCqenDwMfa3vBbkH/Cx
         85sicJ9ALcWmWTmIjFtq8fqzFFU+mSi3Sj2G2gZtBfz7+/pRWXWTf1REhk4Y796eDK3Z
         Iw27ubvFlMUEB+Vt9seXMY0jlUxUUfwz082uiQu6m5lddj2RP9hcnyURvBaaNnRZ+dQz
         i9HQ==
X-Gm-Message-State: APjAAAVBUAK0KAf6IXJ+ic2ZVTLSo8hRCVArN31y4lc2JSHTa+JfkxLy
        mutfzVrlHyhVa6ujUWtJGzaGaO7fa2jYVSgr9DMZ7A==
X-Google-Smtp-Source: APXvYqyo8T2pI3L/tSaJN/dd+mXtWpM0a0rQ1acXLdl3BAB2msIrdC2JhDoRUg14bZemZDHN0lW9N0Qjfgk274/XaX0=
X-Received: by 2002:a0c:d4ee:: with SMTP id y43mr83514431qvh.26.1558727695449;
 Fri, 24 May 2019 12:54:55 -0700 (PDT)
MIME-Version: 1.0
References: <c8cdb347-e206-76b2-0d43-546ef660ffb7@gmail.com> <e0f78773-518b-b62d-3d95-12225724ea5f@gmail.com>
In-Reply-To: <e0f78773-518b-b62d-3d95-12225724ea5f@gmail.com>
From:   Daniel Drake <drake@endlessm.com>
Date:   Fri, 24 May 2019 13:54:44 -0600
Message-ID: <CAD8Lp45namPGpKjcBMo8ivQjzBdsVNM4_sThSaaXxGH=NrSRVQ@mail.gmail.com>
Subject: Re: [PATCH v4 01/13] platform/x86: asus-wmi: Fix hwmon device cleanup
To:     Yurii Pavlovskyi <yurii.pavlovskyi@gmail.com>
Cc:     Corentin Chary <corentin.chary@gmail.com>,
        Darren Hart <dvhart@infradead.org>,
        Andy Shevchenko <andy@infradead.org>,
        Chris Chiu <chiu@endlessm.com>,
        acpi4asus-user <acpi4asus-user@lists.sourceforge.net>,
        Platform Driver <platform-driver-x86@vger.kernel.org>,
        Linux Kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 14, 2019 at 12:50 PM Yurii Pavlovskyi
<yurii.pavlovskyi@gmail.com> wrote:
>
> The driver does not clean up the hwmon device on exit or error. To
> reproduce the bug, repeat rmmod, insmod to verify that device number
> /sys/devices/platform/asus-nb-wmi/hwmon/hwmon?? grows every time. Replace
> call for registering device with devm_* version that unregisters it
> automatically.
>
> Signed-off-by: Yurii Pavlovskyi <yurii.pavlovskyi@gmail.com>

Reviewed-by: Daniel Drake <drake@endlessm.com>

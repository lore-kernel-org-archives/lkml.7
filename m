Return-Path: <SRS0=vI2Y=WC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 01773C31E40
	for <linux-kernel@archiver.kernel.org>; Tue,  6 Aug 2019 22:10:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C72B221872
	for <linux-kernel@archiver.kernel.org>; Tue,  6 Aug 2019 22:10:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="S7Xmi1DI"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727252AbfHFWKY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 6 Aug 2019 18:10:24 -0400
Received: from mail-lj1-f196.google.com ([209.85.208.196]:39005 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726923AbfHFWKX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Aug 2019 18:10:23 -0400
Received: by mail-lj1-f196.google.com with SMTP id v18so83495680ljh.6
        for <linux-kernel@vger.kernel.org>; Tue, 06 Aug 2019 15:10:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=bgewXXxxhY/dAfBGFMPvrzGizAhrJK4ewhsHFFY/ZXc=;
        b=S7Xmi1DIjpcc1NyZ1euHM9kbzVqM1CVov4LeTusvdshoFAvVWX2NW0xhDTbpTxPMrD
         F7/LCPShWklAmxPw+ZcI2kxGXmv9K9+L08AoQI9dFlQYVFnOYSub7m4UKm1+siM0tYEg
         QVqSH1iJP+cLOAbmK71a2wYQT7CyhUoE2UeVA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=bgewXXxxhY/dAfBGFMPvrzGizAhrJK4ewhsHFFY/ZXc=;
        b=N8xHby6YWGJQxgQ7WHIv0GwpLQTPDm2yHqPTSUHCFNkPPckyTUPXdCmOdLx5+6WwbC
         1A/5kb1I27u6cW0+NKo1P8NA76mdnkkuJkI9DbA0VhnnEP5ArmwhRzMM4m6w0wHp5j5E
         GJJe0pAQoux3JWH3vH998l69/UIJxFXM2L/dRs4o4ClllsX6F5IsbJGgOye3eXOQb2wr
         w75n7eJH87OSjqDvqoIFNQa+18yRQMIv0xQSV/H1D105conVthVC5Y+xOIUGcSghj6v5
         TxQ+cI07OJZRTggaEiIqsU2SjiCW/zaNifbrY03/f11i6dyTX8c7uG6Bd1+vefwNeaUp
         M+1A==
X-Gm-Message-State: APjAAAUcGirW8lyhTW+vo8D4s/bCFJchgugh7C8yUQLIQFxTo0/A6fGS
        OR/xUmeJuKNZnN02EwlB0J9ZQvczRys=
X-Google-Smtp-Source: APXvYqzVONaeocq1PjqYfS1jUicJF+VxAiGmJK1YjdS+M2Ud5PDatKk4Dgc2+dL68dxlLxGJUW9qSA==
X-Received: by 2002:a2e:8744:: with SMTP id q4mr2924491ljj.77.1565129421064;
        Tue, 06 Aug 2019 15:10:21 -0700 (PDT)
Received: from mail-lj1-f174.google.com (mail-lj1-f174.google.com. [209.85.208.174])
        by smtp.gmail.com with ESMTPSA id u5sm2904041lfg.66.2019.08.06.15.10.17
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
        Tue, 06 Aug 2019 15:10:18 -0700 (PDT)
Received: by mail-lj1-f174.google.com with SMTP id i21so4305221ljj.3
        for <linux-kernel@vger.kernel.org>; Tue, 06 Aug 2019 15:10:17 -0700 (PDT)
X-Received: by 2002:a2e:3602:: with SMTP id d2mr3006585lja.112.1565129417010;
 Tue, 06 Aug 2019 15:10:17 -0700 (PDT)
MIME-Version: 1.0
References: <20190729204954.25510-1-briannorris@chromium.org>
In-Reply-To: <20190729204954.25510-1-briannorris@chromium.org>
From:   Brian Norris <briannorris@chromium.org>
Date:   Tue, 6 Aug 2019 15:10:05 -0700
X-Gmail-Original-Message-ID: <CA+ASDXPZxD6D2P_7vucseZS=Fe8KDEyNGvNQySvJYu_-fGxk5A@mail.gmail.com>
Message-ID: <CA+ASDXPZxD6D2P_7vucseZS=Fe8KDEyNGvNQySvJYu_-fGxk5A@mail.gmail.com>
Subject: Re: [PATCH] driver core: platform: return -ENXIO for missing GpioInt
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Linux Kernel <linux-kernel@vger.kernel.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Salvatore Bellizzi <salvatore.bellizzi@linux.seppia.net>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Enrico Granata <egranata@chromium.org>,
        Enrico Granata <egranata@google.com>,
        Enric Balletbo i Serra <enric.balletbo@collabora.com>,
        Gwendal Grignou <gwendal@chromium.org>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        Benson Leung <bleung@chromium.org>,
        stable <stable@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 29, 2019 at 1:50 PM Brian Norris <briannorris@chromium.org> wrote:
> Side note: it might have helped alleviate some of this pain if there
> were email notifications to the mailing list when a patch gets applied.
> I didn't realize (and I'm not sure if Enrico did) that v2 was already
> merged by the time I noted its mistakes. If I had known, I would have
> suggested a follow-up patch, not a v3.

I guess I'll be the bot this time: 'twas applied by Greg on Tuesday,
July 30 UTC-07:00.

Thanks,
Brian

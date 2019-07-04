Return-Path: <SRS0=IBEs=VB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6E98FC06515
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Jul 2019 07:41:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3D7012133F
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Jul 2019 07:41:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Gl0uZAl2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727298AbfGDHlm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Jul 2019 03:41:42 -0400
Received: from mail-lj1-f193.google.com ([209.85.208.193]:45650 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726698AbfGDHlm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Jul 2019 03:41:42 -0400
Received: by mail-lj1-f193.google.com with SMTP id m23so5126355lje.12
        for <linux-kernel@vger.kernel.org>; Thu, 04 Jul 2019 00:41:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=JtSGWtPnsqSX1qy+qOE/bF3OjtUMWO0hzBLVZbI64kA=;
        b=Gl0uZAl2rLycKWXswdE0hKAGnsELyqL2erOHGwEGn4LGDS69O/NYTzdXwx82qF6Mto
         y+D5vAOBcYpiLzMNWlmakK71/25Q4lpoytjb/TbodJbl3Xs/FfdF3tvWM8+JGDY4nrmz
         wW1QaHkN/H66xlJgGit1sPMJnTC66WcauYmUsUyEJo7LoQjMpX08T8MRjlP3hltZWzVD
         S/cjA0JbKcAJnMyXKlmgiLxwDZozXFVD28SFoDHXHAYybPffSh6o+MWL8NQOiyd5uFa6
         BrBnx07Xbb/KrXbEXW29rIP9T8XozdThfHEgiEwRtNqyJoPwK6finaLlN1m8VB/egY0J
         iqpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=JtSGWtPnsqSX1qy+qOE/bF3OjtUMWO0hzBLVZbI64kA=;
        b=CExyhcvpZvOI0PcmDxsLaYjEgZsflu69UfibkTSXCoS0BHpJdLOCRLl0YSFYJZI6/A
         ubBPnFW1RXeivAAllJWfx28kJQ4XsUfCyaUW15viwEcV2OcJP4n0+Yc4heCABXLHN1g7
         HIw7Hlg5idAG4fiFboAhSUYyK3qjblky/7RL6eC3G5CWZLRZntwwf+pi97hKj8UleYV3
         PPG/Mzg3e+Qt2eEa4Xq4UAKhCln0CDRt+q004VOSK218i6p8GsZdil6vzCDYYOutu7dl
         5cDVeOUtPZ7LuWawJSYE5csk5R5aAaVchB3/oNTEQNrt3cit63KeXnpj9PB/j2snnrA9
         lt+A==
X-Gm-Message-State: APjAAAVgibbA6cfDm9I/CsQubYzR2mc/ZubDXSa3l9Me3D81CIRw74/L
        FkupJu6+zsxr64Zd+DWxQf1oW9j0l16/Tt2uTbdhxbW2
X-Google-Smtp-Source: APXvYqxqI0SxqTCpnza6dJ3zLkQg0tGMx6p/W/BX79omMIjAQPchR7Hv2qy4lpBM6NGQKfImevFJRrvpmxEERxYge1g=
X-Received: by 2002:a2e:a0d5:: with SMTP id f21mr24150394ljm.69.1562226100168;
 Thu, 04 Jul 2019 00:41:40 -0700 (PDT)
MIME-Version: 1.0
References: <20190702223248.31934-1-martin.blumenstingl@googlemail.com> <20190702223248.31934-4-martin.blumenstingl@googlemail.com>
In-Reply-To: <20190702223248.31934-4-martin.blumenstingl@googlemail.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Thu, 4 Jul 2019 09:41:28 +0200
Message-ID: <CACRpkdZDicvUNg6P5m1t4G4-7yX77sfdU_spGb19tRoNzVMsfw@mail.gmail.com>
Subject: Re: [PATCH 3/4] gpio: stp-xway: get rid of the #include
 <lantiq_soc.h> dependency
To:     Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Cc:     John Crispin <blogic@openwrt.org>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        dev@kresin.me,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 3, 2019 at 12:33 AM Martin Blumenstingl
<martin.blumenstingl@googlemail.com> wrote:

> Use the xway_stp_{r,w}32 helpers in xway_stp_w32_mask instead of relying
> on ltq_{r,w}32 from the architecture specific <lantiq_soc.h>.
> This will allow the driver to be compile-tested on all architectures
> that support MMIO.
>
> Signed-off-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>

Patch applied.

Yours,
Linus Walleij

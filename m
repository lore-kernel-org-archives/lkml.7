Return-Path: <SRS0=EIds=SH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 26079C4360F
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Apr 2019 03:36:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E957920854
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Apr 2019 03:36:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="dW7MutkR"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729876AbfDEDgk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Apr 2019 23:36:40 -0400
Received: from mail-lj1-f196.google.com ([209.85.208.196]:46613 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729631AbfDEDgk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Apr 2019 23:36:40 -0400
Received: by mail-lj1-f196.google.com with SMTP id h21so3915258ljk.13
        for <linux-kernel@vger.kernel.org>; Thu, 04 Apr 2019 20:36:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=8HYtJNnTL1rydVt3yKyaIYNXoqgoDNkL+zXW+PVMBXQ=;
        b=dW7MutkREMGZjWeDGrfQNmpb5B8U3cid1xRYx788W1KHbKEVT2IYyyUqkXztrjF+Hb
         n2bS5aQ/Vsvq+gGj7G6pFQ9zp8DUrHz/GNiUVpc57FyacF5I+0/sMxl9U1+hPSzdI+N0
         NqdVyifOLmsD9+QbV+B007sO1x5d/OLmgrLW7M3QckQhza+CPNDTTu/D+wIw/Eire9+t
         +HXS3/VTaCxxYELyKTU2AoFwvWIh1P5UMP8vo0wVLh04gTgEjetZyyJx1+hOrjMVw9uM
         XoGaay3Ht7aRzzRtUBrdY3A76FgF1T2lbdVtE7wYAVt9jSECu6dSMytNEqipHOcC/SmM
         LA1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=8HYtJNnTL1rydVt3yKyaIYNXoqgoDNkL+zXW+PVMBXQ=;
        b=qwmb4zcEfeVozhJGeFzQRhwTl/j0DAwp0mgV9WLrlgDVegBHLrBcrFOgBnxbbZZDKC
         VMQJ5KzwNMcVmydMCiLTca5vuhIxw7PdXXJxAAvkZdixTNOFxS3xaCx0k8Obo0RGCeZx
         jQiOGn1JnfRRaux45PPGtLOCJiX0Apm2DwL0I8xTZNVfV8KCEbu9YY/bWxDdb0vMUOKm
         JhY6LYjaOLZ2j6qpr2XEaYrknUKdZZ7vcAdkS7BxK33lnX3EsW3BHld/XnSYb57NlS1F
         U7gJhFinUb/DMLqh+uSHRkcAIPLuEU7H9xw81hA0qdTech2iqtcYEHlphkuwrso05Sk8
         +9gw==
X-Gm-Message-State: APjAAAX7dTTCN11qaKPEg9CmBukeRYy6xal7cMGdWfLZcFnvcjArWLFW
        X7jDdl3Av/N29w1NQfd1J0gS9YeR8jcFjoRNyLsngA==
X-Google-Smtp-Source: APXvYqw8G1zf9p/fcHWApohiQYAb5sW1uaT6nsmNt/eVyXnXWcFRQ+8IGI72chaFZJ7tjItZSuSflD8LhBeuIBND810=
X-Received: by 2002:a2e:4a1a:: with SMTP id x26mr5346674lja.49.1554435397995;
 Thu, 04 Apr 2019 20:36:37 -0700 (PDT)
MIME-Version: 1.0
References: <20190312151911.2207-1-pakki001@umn.edu>
In-Reply-To: <20190312151911.2207-1-pakki001@umn.edu>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Fri, 5 Apr 2019 10:36:25 +0700
Message-ID: <CACRpkdbnD8-VWjx2_JvtAhgupEB3YX7KJ7frMwBbTujEyc9Q6w@mail.gmail.com>
Subject: Re: [PATCH] pinctrl: axp209: Fix NULL pointer dereference after allocation
To:     Aditya Pakki <pakki001@umn.edu>
Cc:     Kangjie Lu <kjlu@umn.edu>, Chen-Yu Tsai <wens@csie.org>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 12, 2019 at 10:19 PM Aditya Pakki <pakki001@umn.edu> wrote:

> axp20x_build_funcs_groups allocates groups via devm_kcalloc and tries to
> dereference without checking for NULL. This patch avoids such a
> scenario.
>
> Signed-off-by: Aditya Pakki <pakki001@umn.edu>

Patch applied.

Yours,
Linus Walleij

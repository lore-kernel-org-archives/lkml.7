Return-Path: <SRS0=6dNS=X4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EC282C10F14
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Oct 2019 12:02:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BE43B222C2
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Oct 2019 12:02:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="lcp1eFKe"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729073AbfJCMCs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 3 Oct 2019 08:02:48 -0400
Received: from mail-lj1-f196.google.com ([209.85.208.196]:36843 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725907AbfJCMCr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Oct 2019 08:02:47 -0400
Received: by mail-lj1-f196.google.com with SMTP id v24so2439657ljj.3
        for <linux-kernel@vger.kernel.org>; Thu, 03 Oct 2019 05:02:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=cTYlnAsOJ2TKlVRx7ETxjCGwXU7Jrh//3eORQWciV1I=;
        b=lcp1eFKeXAZyScuFc5xoJJSTTqPHQ8Do+3WrNy+47tu+ROcdW6yllR8HE/6xyxFI1C
         RIQ5vZJOjQSZuylhK/qu0sZ6QXr9SnHoXAHVl6r06m7jOM/BKGeXI4ZxGBKLdruYqNic
         U9qkExsWct/2LLNZFIbyHSfx+z5fEsvWd6jqyog+uXlaCXMjWHtYPVBFkumuVrAJwIN5
         MfbnIneby+9xiN7KIdGVjHFKO1LuanOdth7xQvHvCg2fdmk7Xs5lTNa5I/o+3FZZ7VyG
         ndi/b58SQIf3hMSo5Yw9QKJ3bwdLKcEIKcODFEkcliHkc9jkbPzsp3euz1Vz0kBvzkxe
         UIDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=cTYlnAsOJ2TKlVRx7ETxjCGwXU7Jrh//3eORQWciV1I=;
        b=N38OS+Vf0/u8gRd7o/1ahSMGmM+6IAhcbYHDby1Y9i1Y8RqnxvcaEkaeM8uc2ZBONk
         vAsMrkrpShOQPRMbuBjHwvsKmw2qogAIO2o3N+hd729Jwq0lYe/IwKwUmeJt40DpBBYK
         bX9511bpid/qp6bsa0ZdYw8MXBVObSu8Pt7L3Z6RvCj4EhSt5Dz3BFwvjd2Tvcf7Ur2Q
         E+7+j2qp9Qzf0vPqVpT1QO4o1WExuVZ8qqmvBVStNLZ1tSGYJG5PUxc2dXeqPHQ5qbod
         5S6+VIVbGDFGDYRTMNlD25Rc2PXBKhmBHk3bkrHKbMz68vmkWAFh9e/MIfVCcsMcwPiN
         WHkQ==
X-Gm-Message-State: APjAAAXa81uA/RFNSCUL8BRCTNhImfLH8Vx1pYh6tVVTeqBJKwSbQOK8
        QzDoxXDDYDzkQcSxkDTe6ZB3VBY7bQu87//lEzejIg==
X-Google-Smtp-Source: APXvYqxkigIHVqqJYtKMd8GkRG6qLd8hE5Cemc8HsFF9oQhJc0+1b5nvoxtB7OvKQsMw9/i59oJz1UG7zrLmwnmixDU=
X-Received: by 2002:a2e:894b:: with SMTP id b11mr5832443ljk.152.1570104165568;
 Thu, 03 Oct 2019 05:02:45 -0700 (PDT)
MIME-Version: 1.0
References: <1568411962-1022-1-git-send-email-ilina@codeaurora.org> <1568411962-1022-6-git-send-email-ilina@codeaurora.org>
In-Reply-To: <1568411962-1022-6-git-send-email-ilina@codeaurora.org>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Thu, 3 Oct 2019 14:02:33 +0200
Message-ID: <CACRpkdYO3ioakyrmv_2mTUuWCeBZ5goW28qr+y_M8qFv64FD4Q@mail.gmail.com>
Subject: Re: [PATCH RFC v2 05/14] of: irq: document properties for wakeup
 interrupt parent
To:     Lina Iyer <ilina@codeaurora.org>
Cc:     Stephen Boyd <swboyd@chromium.org>,
        Evan Green <evgreen@chromium.org>,
        Marc Zyngier <maz@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        MSM <linux-arm-msm@vger.kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        mkshah@codeaurora.org,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 13, 2019 at 11:59 PM Lina Iyer <ilina@codeaurora.org> wrote:

> Some interrupt controllers in a SoC, are always powered on and have a
> select interrupts routed to them, so that they can wakeup the SoC from
> suspend. Add wakeup-parent DT property to refer to these interrupt
> controllers.
>
> Cc: devicetree@vger.kernel.org
> Signed-off-by: Lina Iyer <ilina@codeaurora.org>
> Reviewed-by: Rob Herring <robh@kernel.org>

Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij

Return-Path: <SRS0=BPXs=SN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 12CC4C10F13
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Apr 2019 13:35:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C9A67217F4
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Apr 2019 13:35:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="sP8crLFj"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726841AbfDKNfB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 11 Apr 2019 09:35:01 -0400
Received: from mail-lj1-f194.google.com ([209.85.208.194]:37256 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726599AbfDKNfB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Apr 2019 09:35:01 -0400
Received: by mail-lj1-f194.google.com with SMTP id v13so5557106ljk.4
        for <linux-kernel@vger.kernel.org>; Thu, 11 Apr 2019 06:34:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=g6+CfmYFjxdIPu1/0X+F9GDYvx2LNwPDNU1LfXvwy+0=;
        b=sP8crLFjSpFAGHWU6tuNHyEISXn4vLskFmyND7NrMGqYWRZDti3VQs2B4UXBEEX/5R
         1tgDoPgQ+kcW15fB9XcjDCSO/gpzMT9xxLyz7a48C7ynBDMeb2Un7NArPKGwSZ9Zjo7n
         r/HkQB0k1l/+uIBvoQRYv7jeNPdZKo/s1P60+F6FgZib9rpLPADLwd8pZQm3YGNd0vAU
         0RPo/xlN3Qd9laky5Ymoru5EABzgHdKIDUuZr4fFcdm7Dk7iHjxv38+RUTBvK6KivsjS
         P/+fT1TPESz4NtQhz14uZ5hmNG8/RreyUHYONLQ0lY2Pp21b6FiE7xiMa0+Q6mIWgvef
         1wrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=g6+CfmYFjxdIPu1/0X+F9GDYvx2LNwPDNU1LfXvwy+0=;
        b=hxC+/r+101R/vPB/BDYohLauPA+RgUbdiBVr0y2oG42puT1ei0IqLk7AvKQuevvg8U
         9UvTinUfkdZg/5/hymzge455WYGFV8kgZVMuVM+Ymxmc44BLtJBn08yrdgRnj31Wlz3B
         7KcY5U7rEEfPzwKiJNH7HncP7v3bUR0NPmX+AoUztoiDzdsMntEdv1z+zRuLff8J7Kvl
         V1lopzkMAXqqlbmRPVEJqJ/ZlhQkSotkx4BiEZo3wo2E47YKc/tF0I8JK+Va3KJ0azGD
         mtYHqh9HwUgiunvrXCrd3nC48xKVRzkGknqV+j94YMKpklA8idlaCwRvSsg3cBi/5msB
         Er7Q==
X-Gm-Message-State: APjAAAVQZWrqKd7NY1iEnvCWWExqAHOs8Fwxehj5XE29+yxJ0vICst9N
        HjkPPDxW4jvt4P++JpjaaXma/Zqx+FK9BzLvBtcSvQ==
X-Google-Smtp-Source: APXvYqw/oQ72CNGz/eT7rcjjFI3zRIBCbj4K6cWqCLqvMwietvuJBMjUbxwC6FUkt4rHRcif/u+ItA3Q0QmC9DejzWw=
X-Received: by 2002:a2e:3512:: with SMTP id z18mr25957163ljz.25.1554989699186;
 Thu, 11 Apr 2019 06:34:59 -0700 (PDT)
MIME-Version: 1.0
References: <20190409123546.13960-1-alexandre.belloni@bootlin.com>
In-Reply-To: <20190409123546.13960-1-alexandre.belloni@bootlin.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Thu, 11 Apr 2019 15:34:47 +0200
Message-ID: <CACRpkdbn99RqpYUsgcq0bQ5qBfCg5-zP1szg1918x5ttFa63vA@mail.gmail.com>
Subject: Re: [PATCH 1/2] dt-bindings: gpio: pca953x: document the nxp,pca6416
To:     Alexandre Belloni <alexandre.belloni@bootlin.com>
Cc:     Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 9, 2019 at 2:35 PM Alexandre Belloni
<alexandre.belloni@bootlin.com> wrote:

> The NXP PCA6416 is a variant of the PCA GPIO expander, with 16 GPIOs.
>
> Signed-off-by: Alexandre Belloni <alexandre.belloni@bootlin.com>

Patch applied.

Yours,
Linus Walleij

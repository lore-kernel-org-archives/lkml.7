Return-Path: <SRS0=nCuq=XH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E8320C4CEC6
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Sep 2019 13:43:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B6085206CD
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Sep 2019 13:43:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="jm6q7ISk"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732220AbfILNnT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 12 Sep 2019 09:43:19 -0400
Received: from mail-lf1-f67.google.com ([209.85.167.67]:36161 "EHLO
        mail-lf1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732165AbfILNnS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Sep 2019 09:43:18 -0400
Received: by mail-lf1-f67.google.com with SMTP id x80so19430438lff.3
        for <linux-kernel@vger.kernel.org>; Thu, 12 Sep 2019 06:43:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=nZt0B3xrqHLHU4EvkiZMlrE7A5+KS8ARbT0ipn5PjfE=;
        b=jm6q7ISk/RfhVugAWF5YSK2afzSWJDBFxAi7oi9VZErcMD7Z1AukPdyibpKG5vTRe2
         jFmOIewoNoWhvEzTu8X+x7EZuqE5RgFfWm3QrjW9c7PRikJmv8w8KZZyC7lhn5ToHLsi
         8XpXAxjCiIU7RE4ufk8iJES4+77c9H0I6HlpdQdUX0nzjFrPt5P/AEtOMdDE48SUtVDA
         IMuBfP9lUYg0hfWM2zCvqW7YnBHHe1rBnGBF0zfYgc5u5c2j5sy9alNvTo/hs6te+GAa
         okus/w6Gb3Wa+mgHCt1IeKaxQmCg+St1kGqBkfGbyPfJQujHkOtvzQZ7U64Y+Q4RpTW6
         DYaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=nZt0B3xrqHLHU4EvkiZMlrE7A5+KS8ARbT0ipn5PjfE=;
        b=jIvi3BhFEZPqHCOrTFY3Db4+7p0Ce1BvZqV5qCtyonV+ca5f46bUaUAnZpdz/59ijc
         PGohs+qZL/le61a+oAl0bVFitKoSM0INLKyFpABf/lEeG2yqgFYZLJY5B415+/7S8jeY
         bH0WrRDzQPok4jIR9z/6jZgH5cE1BJb0Cyz0mgLmmpg75/7siwYChivjjFXHLp8PjYSt
         U6GUJtTCe9bPG+AKvRvJFZDF0DxQ09QNp9UqUGPlxNJlkaoYVVyOGofk+R+tT78wr6hR
         kuBCaTvMCicGufPwrKzP0KDRmp4iq+PMbyJOx8815Kr9plAaoTw1F9P8Pv2M8Qv/zkyG
         jg+g==
X-Gm-Message-State: APjAAAXnyYH6UPerYshYVFVBQ00AtS9HcmFTAtmjyRyBmUna7Uh0bAvk
        F9ppOuVmQCuZtaCe+xTSnfDzUITV11wRZ7WB6w3a3g==
X-Google-Smtp-Source: APXvYqwunbF7TyfIhMcANFX4yAMKAnnsZW2NFILSXWz0Zd7gn78zVLaU+lihiMnQ0FO7JFF52e8A7qNnUVzqrPH/nXc=
X-Received: by 2002:a19:48c3:: with SMTP id v186mr27989255lfa.141.1568295796494;
 Thu, 12 Sep 2019 06:43:16 -0700 (PDT)
MIME-Version: 1.0
References: <1567662796-25508-1-git-send-email-light.hsieh@mediatek.com> <1567663210.1324.3.camel@mtkswgap22>
In-Reply-To: <1567663210.1324.3.camel@mtkswgap22>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Thu, 12 Sep 2019 14:43:04 +0100
Message-ID: <CACRpkdbBMiHk4DV3r=aLU+T+9bPQBLUiTaW6L+L=J=ec0guBmA@mail.gmail.com>
Subject: Re: [PATCH v2 1/5] pinctrl: mediatek: Check gpio pin number and use
 binary search in mtk_hw_pin_field_lookup()
To:     Light Hsieh <light.hsieh@mediatek.com>
Cc:     "moderated list:ARM/Mediatek SoC support" 
        <linux-mediatek@lists.infradead.org>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Sean Wang <sean.wang@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 5, 2019 at 7:00 AM Light Hsieh <light.hsieh@mediatek.com> wrote:

> v2 is the same as v1 except that commit message is corrected according
> to Linus' comment for v1:
>
> 1. remove Change-Id lines
> 2. correct sysfs as debugfs

Patches applied with Sean's ACK.

Yours,
Linus Walleij

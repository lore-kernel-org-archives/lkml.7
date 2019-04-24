Return-Path: <SRS0=L2S5=S2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A6EE6C10F11
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 10:48:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7123B21773
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 10:48:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="qw6lxAXC"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728820AbfDXKs1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Apr 2019 06:48:27 -0400
Received: from mail-lf1-f65.google.com ([209.85.167.65]:32847 "EHLO
        mail-lf1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726831AbfDXKs0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Apr 2019 06:48:26 -0400
Received: by mail-lf1-f65.google.com with SMTP id j11so14275426lfm.0
        for <linux-kernel@vger.kernel.org>; Wed, 24 Apr 2019 03:48:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=XB2ByXEjwu+GeuD00siTHlVt4/gX8OkARg2NzSsJ9e8=;
        b=qw6lxAXC4j/1ABoK4XXSDz3VSTCYHB6gTiS/WPcca6amu2JJ6UU6HeWX9xTnNsZxu3
         5j4gYaKYt7WRaiOZ4MUpkn6kv73M63oy5utU3FhJoTf05HiVMqrSyZjtFXmu4hPXRa4i
         Gfkjs9MELLJCFNCNPUIFCKqiE3LG/SB2lGygz61jfXP/K81Syb/+Sswri2xwGicMWB56
         P0DLXgXj5leFt+9J1CGrwMrpaG3ia7mkE7ROeJJxKlYIo0NRx3YNZEE3T4GptgJ0nV1l
         Ktxm+6ZcYc6WaPoOUI2H2NLV8e+2Tb+QLR9UeMveXGDIPc24gSKhbtJENRePKHCsN6ME
         5YFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=XB2ByXEjwu+GeuD00siTHlVt4/gX8OkARg2NzSsJ9e8=;
        b=r0bZsVdMqQpHS35nt6gvWdrHRRTjcjGe47PMlhJ8TKi0lbw6VIehvyymnJh3VMx7+D
         7eJu+zsgZ9O289mdQca+OAp7NsPmwEe5XSvVx/vOpKq0exFSyuNfsVWH5w/jABTCjvYP
         0W6QqyyZww9aNah02hkqsH/10S81vby5oqOcuzFmo/WJ4kfgZs07wf9rW2+3pL+J/xNm
         S5cmAh8rqqltsOlUOdSWHocDaTpEf5HPdJFwmVXdtOthSO0I/3YSvOufBaqQLSpGBIN2
         1C6E8ZOVAoW+RiiN2c9fufmjgwzWkuUcSIPy0qSHzkctqoKPbmbZPmkyei1+1YQ7KpWu
         hntA==
X-Gm-Message-State: APjAAAVunEznHoDloQo6Ch7etfLdmYl9v4UXz2nwpbEMj/pFwB3Ewm2f
        Qn297Ussp18G/vIs4ovES7hmIzuD0gniOWOMgW8uaQ==
X-Google-Smtp-Source: APXvYqy2SRBdkY0tuNIucQX/0wltdoQh+DJT9X3Ri26KaL7qu4c5RbRCSIONYt/lu7cmSJz4NxCRsRqB/QEpZ9SMeDE=
X-Received: by 2002:ac2:5381:: with SMTP id g1mr16883585lfh.130.1556102904355;
 Wed, 24 Apr 2019 03:48:24 -0700 (PDT)
MIME-Version: 1.0
References: <1556093324-1008-1-git-send-email-fabien.dessenne@st.com>
In-Reply-To: <1556093324-1008-1-git-send-email-fabien.dessenne@st.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Wed, 24 Apr 2019 12:48:12 +0200
Message-ID: <CACRpkdZcp5CPL_wX0o0Dreu23Ky11XxbEpkAgU9fRYSeEHO6-w@mail.gmail.com>
Subject: Re: [PATCH] pinctrl: stm32: check irq controller availability at probe
To:     Fabien Dessenne <fabien.dessenne@st.com>
Cc:     Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@st.com>,
        Benjamin Gaignard <benjamin.gaignard@linaro.org>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        linux-stm32@st-md-mailman.stormreply.com,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 24, 2019 at 10:09 AM Fabien Dessenne <fabien.dessenne@st.com> wrote:

> It is not guaranteed that the IRQ controller driver is probed before
> the pin controller driver gets probed.
> Considering this, check for the irq domain availability during probe
> and return EPROBE_DEFER if needed.
>
> Signed-off-by: Fabien Dessenne <fabien.dessenne@st.com>

Patch applied with Alexandre's ACK!

Yours,
Linus Walleij

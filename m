Return-Path: <SRS0=8QAT=T3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D0FB1C07542
	for <linux-kernel@archiver.kernel.org>; Mon, 27 May 2019 09:10:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A554321734
	for <linux-kernel@archiver.kernel.org>; Mon, 27 May 2019 09:10:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="FhjjRkkX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726807AbfE0JK3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 27 May 2019 05:10:29 -0400
Received: from mail-lj1-f193.google.com ([209.85.208.193]:35105 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726282AbfE0JK3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 May 2019 05:10:29 -0400
Received: by mail-lj1-f193.google.com with SMTP id h11so14062910ljb.2
        for <linux-kernel@vger.kernel.org>; Mon, 27 May 2019 02:10:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=pEGlKR9cMXvIeUwusBglsYeiQ+SPB2PmHYL6y3sHsr0=;
        b=FhjjRkkXUEVnfVIt6bTqWSZJb/80sf15Ilad86TcxGXBhK8aK4E1Q8KTgK9nZ7a3Wc
         L+08R9RZF08RtWFv83jca1VyQfwi7ljQUoGUnI+MLWoxcugHRvse2TEQADWqDxxGDhkv
         03VruCzQb3H2EC7bW3VH9sYFSU1DSddBsVfvpbfT+VLY9BvT7GtBotmkm3OzN5YNmVAG
         kO6OSAhPlVJGlX/tgBr5UHCMZEYKdewpzcS9XDXgV/Z2rjnIc5B86w2RLERHCubNoixu
         uI8Dtj9y6WlZ2f+MIDty1Q5bXXvSPYBMYwABhThGOV8v6RJF3aNCo0+PFKpKf3EFP0+Z
         kd1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=pEGlKR9cMXvIeUwusBglsYeiQ+SPB2PmHYL6y3sHsr0=;
        b=OcLUmg/nZyXUpjb0ZcSKgxmqQ4AKa9Qz8UOfWzrDFlmyAopBG4RzGiPIzqpwdNGbz/
         vDhd458SuCbed3Qb+HY94Cd273MegWM6WjL7cr7WyIjZDvHJdpHvM8ZKGfornp4A3w4k
         Rdc/7t2DPcH/XxQuyHDseX0DDjcaPsOfWAvOvZg3jEuAwTTxkKBMSm6Bl4AReLKdXG2K
         QYU5R2vvpoLAt8+h+zOBvQltt98t66A01hIxPVaDneIjx5WSPoynw9/NfCUgsjWoySH0
         5Q24X1DmK6R3sJNc505Uflm5u5b+pemg5Sa3HFR02vUFcKtX7h6v8GuiBwmgHH87MBQ4
         BtEQ==
X-Gm-Message-State: APjAAAWYDC9zf0s18Xeav3uu/nvMCHEUuMlCu+6qOu/TeGrjBQg5Dv5o
        WbSi18dsqld/x76gZj3gwXZvEIPbjzv6+U2+Pw7Qqg==
X-Google-Smtp-Source: APXvYqx3PadhULZkWPFoOWBCluXUOl+KRGzn+HWRbMqV3BUzCYyZIRy5UR/oJ53rjISdwLm4eqiipmAdUSlkYMpbwu0=
X-Received: by 2002:a2e:5c1:: with SMTP id 184mr52626256ljf.94.1558948227212;
 Mon, 27 May 2019 02:10:27 -0700 (PDT)
MIME-Version: 1.0
References: <20190525204228.8546-1-colin.king@canonical.com>
In-Reply-To: <20190525204228.8546-1-colin.king@canonical.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Mon, 27 May 2019 11:10:15 +0200
Message-ID: <CACRpkdadikx9MPrVUQxXa6KYsmnuoakjYVTNEcv_HOoW0pCgZg@mail.gmail.com>
Subject: Re: [PATCH] dt-bindings: pinctrl: fix spelling mistakes in pinctl documentation
To:     Colin King <colin.king@canonical.com>
Cc:     Andy Gross <agross@kernel.org>,
        David Brown <david.brown@linaro.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        MSM <linux-arm-msm@vger.kernel.org>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>, kernel-janitors@vger.kernel.org,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, May 25, 2019 at 10:42 PM Colin King <colin.king@canonical.com> wrote:

> From: Colin Ian King <colin.king@canonical.com>
>
> The spelling of configured is incorrect in the documentation. Fix it.
>
> Signed-off-by: Colin Ian King <colin.king@canonical.com>

Patch applied with Bjorn's review tag.

Yours,
Linus Walleij

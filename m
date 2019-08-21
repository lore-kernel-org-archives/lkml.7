Return-Path: <SRS0=xaRW=WR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 58138C3A59E
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Aug 2019 04:07:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2B57E2332A
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Aug 2019 04:07:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727592AbfHUEHy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 21 Aug 2019 00:07:54 -0400
Received: from mail-ed1-f66.google.com ([209.85.208.66]:37374 "EHLO
        mail-ed1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727108AbfHUEHw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Aug 2019 00:07:52 -0400
Received: by mail-ed1-f66.google.com with SMTP id f22so1283876edt.4
        for <linux-kernel@vger.kernel.org>; Tue, 20 Aug 2019 21:07:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=2DH+Z8zu5DA8qxbFBSKsglzPr+woO5ZxUEZnrR+PcUs=;
        b=bZl9KqUOtrujBg1QJQWFIxQj51sk2oB6tSyggrdmICn5ccEfv5VF/a4U4yfnCSl7JY
         1FeIrZH/daAlzH9fAoA2AAdxr7yxpO8JB4WziIZe05IlRwIYDU+kOJcaM8oexqeE5F0e
         yi84evrYO3awI9Fx2CeC/d2NAF6UNz/ptM0SICvYHd6/dnIbeUoqHs3j1YZA0cdn5Y01
         k7ODXhg65AHvHifEKtkdsrtLfcF0CbSdqiQK8GScIjrYhMvjHtv5lS81Sp+vb5YrGMLW
         fXL2fMoWAVOk/8cfYR3GAmAEbptJYtMwhkViKutA3rpViuszKggkHeP5XnzKwhH6R2Wb
         2ffA==
X-Gm-Message-State: APjAAAV6uqmbu8ZOqXC4AudjI89M7hDicWpByUDBjYtrW3yLpLhiKjx1
        Ir2V+zBvkVfAlV9gVXCYV1IXGOlXQ9Y=
X-Google-Smtp-Source: APXvYqxwx8FZA+a9CHC4BXrxz8DOU3y0C0lpgNUSzHim5ksXU2gwcueO/rNA5NmbO1ammjU3WaE92w==
X-Received: by 2002:a50:ee0d:: with SMTP id g13mr34998002eds.113.1566360470438;
        Tue, 20 Aug 2019 21:07:50 -0700 (PDT)
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com. [209.85.128.51])
        by smtp.gmail.com with ESMTPSA id r27sm3892993edc.17.2019.08.20.21.07.49
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 20 Aug 2019 21:07:50 -0700 (PDT)
Received: by mail-wm1-f51.google.com with SMTP id g67so650472wme.1
        for <linux-kernel@vger.kernel.org>; Tue, 20 Aug 2019 21:07:49 -0700 (PDT)
X-Received: by 2002:a7b:c8c5:: with SMTP id f5mr3226423wml.25.1566360469671;
 Tue, 20 Aug 2019 21:07:49 -0700 (PDT)
MIME-Version: 1.0
References: <20190814060854.26345-1-codekipper@gmail.com> <20190814060854.26345-10-codekipper@gmail.com>
In-Reply-To: <20190814060854.26345-10-codekipper@gmail.com>
From:   Chen-Yu Tsai <wens@csie.org>
Date:   Wed, 21 Aug 2019 12:07:37 +0800
X-Gmail-Original-Message-ID: <CAGb2v65+-OB4zEyW8f7hcWHkL7DtfEB1YK2B1nOKdgNdNqC0kQ@mail.gmail.com>
Message-ID: <CAGb2v65+-OB4zEyW8f7hcWHkL7DtfEB1YK2B1nOKdgNdNqC0kQ@mail.gmail.com>
Subject: Re: [linux-sunxi] [PATCH v5 09/15] clk: sunxi-ng: h6: Allow I2S to
 change parent rate
To:     Code Kipper <codekipper@gmail.com>
Cc:     Maxime Ripard <maxime.ripard@free-electrons.com>,
        linux-sunxi <linux-sunxi@googlegroups.com>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Linux-ALSA <alsa-devel@alsa-project.org>,
        "Andrea Venturi (pers)" <be17068@iperbole.bo.it>,
        Jernej Skrabec <jernej.skrabec@siol.net>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 14, 2019 at 2:09 PM <codekipper@gmail.com> wrote:
>
> From: Jernej Skrabec <jernej.skrabec@siol.net>
>
> I2S doesn't work if parent rate couldn't be change. Difference between
> wanted and actual rate is too big.
>
> Fix this by adding CLK_SET_RATE_PARENT flag to I2S clocks.
>
> Signed-off-by: Jernej Skrabec <jernej.skrabec@siol.net>

This lacks your SoB. Please reply and I can add it when applying.

ChenYu

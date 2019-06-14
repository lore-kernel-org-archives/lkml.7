Return-Path: <SRS0=TKbG=UN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0CCAEC31E45
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Jun 2019 03:19:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DD87E2073F
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Jun 2019 03:19:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726613AbfFNDTT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Jun 2019 23:19:19 -0400
Received: from mail-ed1-f66.google.com ([209.85.208.66]:37692 "EHLO
        mail-ed1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725819AbfFNDTT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Jun 2019 23:19:19 -0400
Received: by mail-ed1-f66.google.com with SMTP id w13so1324875eds.4;
        Thu, 13 Jun 2019 20:19:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=NPwG/+sK6rrlYN0ObMy3YjCUZytnPkU+C+L+wuAauYY=;
        b=H0IWw6Cw1xDgvx1twE7WAHCT0moG8RFGnDdUYOn2dAMMyHyYz3Zjky76dF6pklZRqi
         R0Z6qxf9om9OtLw5gN7NlQTQuksIKdu952W3KspO/88oEHRkVM+ghgdUDG4YvC9tGeVO
         JT+KNFhFrCLC6Mv5RK4kac/EbWIgJSuG385p2qtmopTx5z10OeaU797gj/NGziOIHdFW
         cGrhUfteIAvmUc0DrIiSMiGbBr2gmwBMvILhuwL8btsIeriotHAAweQqrcWknIQNI2L2
         neOxaG1A8tn+uZPNj+ev/oFMNraMzrKeTV6cuEegK1P2nGyEHGDA6/R8lkO4LdWOfbW2
         Tgag==
X-Gm-Message-State: APjAAAUc1bsi40n0XPzotdxwXcrsh9m2kT2dgO3k5ftajsi4a91EK7Dz
        GJpkCMzhZjTG+sKSRmbt5kLAMVZKuPA=
X-Google-Smtp-Source: APXvYqwITARVTvOF/txRmfKZFDzXu1HmSUvVaVy/Q8Gc8d26YbmXl9cQT6dEYnSWLLpmpevrQWV0gQ==
X-Received: by 2002:a17:906:f0cd:: with SMTP id dk13mr31604991ejb.84.1560482356479;
        Thu, 13 Jun 2019 20:19:16 -0700 (PDT)
Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com. [209.85.221.54])
        by smtp.gmail.com with ESMTPSA id o93sm479766edd.46.2019.06.13.20.19.16
        (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
        Thu, 13 Jun 2019 20:19:16 -0700 (PDT)
Received: by mail-wr1-f54.google.com with SMTP id p11so871303wre.7;
        Thu, 13 Jun 2019 20:19:16 -0700 (PDT)
X-Received: by 2002:adf:fd01:: with SMTP id e1mr2697971wrr.167.1560482355808;
 Thu, 13 Jun 2019 20:19:15 -0700 (PDT)
MIME-Version: 1.0
References: <20190613185241.22800-1-jagan@amarulasolutions.com> <20190613185241.22800-3-jagan@amarulasolutions.com>
In-Reply-To: <20190613185241.22800-3-jagan@amarulasolutions.com>
From:   Chen-Yu Tsai <wens@csie.org>
Date:   Fri, 14 Jun 2019 11:19:04 +0800
X-Gmail-Original-Message-ID: <CAGb2v65xuXc4C1jOyM1GbEFVDam5P-6NN0ZhtzwzA7qU5F3nJQ@mail.gmail.com>
Message-ID: <CAGb2v65xuXc4C1jOyM1GbEFVDam5P-6NN0ZhtzwzA7qU5F3nJQ@mail.gmail.com>
Subject: Re: [linux-sunxi] [PATCH 2/9] drm/sun4i: tcon: Add TCON LCD support
 for R40
To:     Jagan Teki <jagan@amarulasolutions.com>
Cc:     Maxime Ripard <maxime.ripard@bootlin.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        devicetree <devicetree@vger.kernel.org>,
        Jernej Skrabec <jernej.skrabec@siol.net>,
        Michael Trimarchi <michael@amarulasolutions.com>,
        linux-sunxi <linux-sunxi@googlegroups.com>,
        linux-amarula@amarulasolutions.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 14, 2019 at 2:53 AM Jagan Teki <jagan@amarulasolutions.com> wrote:
>
> TCON LCD0, LCD1 in allwinner R40, are used for managing
> LCD interfaces like RGB, LVDS and DSI.
>
> Like TCON TV0, TV1 these LCD0, LCD1 are also managed via
> tcon top.
>
> Add support for it, in tcon driver.
>
> Signed-off-by: Jagan Teki <jagan@amarulasolutions.com>

Reviewed-by: Chen-Yu Tsai <wens@csie.org>

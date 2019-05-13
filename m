Return-Path: <SRS0=lMFC=TN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 384E0C04AB1
	for <linux-kernel@archiver.kernel.org>; Mon, 13 May 2019 07:43:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0825020B7C
	for <linux-kernel@archiver.kernel.org>; Mon, 13 May 2019 07:43:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="LvnhpyUO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727949AbfEMHnd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 13 May 2019 03:43:33 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:34192 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727671AbfEMHnd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 May 2019 03:43:33 -0400
Received: by mail-wm1-f65.google.com with SMTP id m20so10617773wmg.1
        for <linux-kernel@vger.kernel.org>; Mon, 13 May 2019 00:43:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=2SVkcixuV+vIKx8xDNZuyAT9UK0fzjYF/b5ce8pCl+U=;
        b=LvnhpyUOg/fe+RLGQXLz1XqoioBuGPsaZYetsZRYzhCP7PHiNcJAXKVPD3pg02fLCn
         H/TUqrAnssQmBiq4xA5XnuFUu01cp9MB7+7fYw/Ai+FxQbcMCexvAVfnVbmVNJQttTUe
         ael2fjcPqteB/83JAJjEIkEUBnerHvAhdN/+QJUjYVFX5ljyUuCsBNmEMr6ExStjRXaX
         jwUs9obpnSHdBZ8XrLQZJAOYwhEHxDPcEgEvVzlf0O+s8tGzhT3UXVum2YXsOTzhT3dv
         6q9FuQ3Vibk3KNcBC1FpBC3kc41XXNX/AB62vxLCAizVrIjoa9ciUMgs4enwYft749hd
         5qjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=2SVkcixuV+vIKx8xDNZuyAT9UK0fzjYF/b5ce8pCl+U=;
        b=cJWfhvG+4GrTwd6vUaLtzzmSXERPOH0SSe9nA4SVyUKX5OigYpdo+yTjft6Ob6PNAM
         zU4XMa+cU4e1rzR/BvY63dj+Pa3cMg+bgdXAIEj3O06+sFI6VAV79djaT/uJ3gSBlPu7
         3+04S0qnucfu6d19C2ygxd8+lkt0n1dwUIuwXM82LgSkNdyxFyCVzbrwBALdMB8AYKTE
         8J1C2vtLsclJHQKuUnXlkcxvdsgoe7nIkrcjUTY50/leKihn54/d3VsQNdNOHxPsNjJQ
         Q5qA0CWV2XYXQRI7YXs3BZcRYfCx63lQuJR+8+J9E1YVz4i/WVtxalfFXz/gaPXKkypH
         WueQ==
X-Gm-Message-State: APjAAAX0nYUxxjqvPZvojy8zHisuiHOmf5giNPJtiuBGifH3JLG4oedV
        55pBFqY/zAkzdVJl4MiWp3Z7iQ==
X-Google-Smtp-Source: APXvYqwp8nAXWcx1osFAjj9b+GA8DgpLgKaUzmyU2T2zcrbCMz9vA5t8VV7tfWYcz6KGhz3E6C8uYw==
X-Received: by 2002:a05:600c:247:: with SMTP id 7mr15179643wmj.31.1557733411492;
        Mon, 13 May 2019 00:43:31 -0700 (PDT)
Received: from dell ([2.27.167.43])
        by smtp.gmail.com with ESMTPSA id 24sm3859594wmo.3.2019.05.13.00.43.30
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 13 May 2019 00:43:30 -0700 (PDT)
Date:   Mon, 13 May 2019 08:43:29 +0100
From:   Lee Jones <lee.jones@linaro.org>
To:     Amelie Delaunay <amelie.delaunay@st.com>
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexandre Torgue <alexandre.torgue@st.com>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-stm32@st-md-mailman.stormreply.com
Subject: Re: [GIT PULL v3] Immutable branch between MFD and Pinctrl due for
 the v5.2 merge window
Message-ID: <20190513074329.GJ4319@dell>
References: <1557392336-28239-1-git-send-email-amelie.delaunay@st.com>
 <20190510072314.GC7321@dell>
 <20190510151556.GA4319@dell>
 <20190510151912.GB4319@dell>
 <20190513074237.GI4319@dell>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20190513074237.GI4319@dell>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 13 May 2019, Lee Jones wrote:

> Enjoy!

Should have said: now contains fixes for reported Smatch warnings.

> The following changes since commit e93c9c99a629c61837d5a7fc2120cd2b6c70dbdd:
> 
>   Linux 5.1 (2019-05-05 17:42:58 -0700)
> 
> are available in the Git repository at:
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/lee/mfd.git tags/ib-mfd-pinctrl-v5.2-2
> 
> for you to fetch changes up to d17ed797b8fd5c8765cd959ac44aaa2f090f5a89:
> 
>   pinctrl: stmfx: Fix 'warn: bitwise AND condition is false here' (2019-05-13 08:28:26 +0100)
> 
> ----------------------------------------------------------------
> Immutable branch between MFD and Pinctrl due for the v5.2 merge window
> 
> ----------------------------------------------------------------
> Amelie Delaunay (5):
>       dt-bindings: mfd: Add ST Multi-Function eXpander (STMFX) core bindings
>       mfd: Add ST Multi-Function eXpander (STMFX) core driver
>       dt-bindings: pinctrl: document the STMFX pinctrl bindings
>       pinctrl: Add STMFX GPIO expander Pinctrl/GPIO driver
>       pinctrl: Kconfig: Fix STMFX GPIO expander Pinctrl/GPIO driver dependencies
> 
> Lee Jones (2):
>       pinctrl: stmfx: Fix 'warn: unsigned <VAR> is never less than zero'
>       pinctrl: stmfx: Fix 'warn: bitwise AND condition is false here'
> 
>  Documentation/devicetree/bindings/mfd/stmfx.txt    |  28 +
>  .../devicetree/bindings/pinctrl/pinctrl-stmfx.txt  | 116 +++
>  drivers/mfd/Kconfig                                |  13 +
>  drivers/mfd/Makefile                               |   2 +-
>  drivers/mfd/stmfx.c                                | 545 ++++++++++++++
>  drivers/pinctrl/Kconfig                            |  14 +
>  drivers/pinctrl/Makefile                           |   1 +
>  drivers/pinctrl/pinctrl-stmfx.c                    | 819 +++++++++++++++++++++
>  include/linux/mfd/stmfx.h                          | 123 ++++
>  9 files changed, 1660 insertions(+), 1 deletion(-)
>  create mode 100644 Documentation/devicetree/bindings/mfd/stmfx.txt
>  create mode 100644 Documentation/devicetree/bindings/pinctrl/pinctrl-stmfx.txt
>  create mode 100644 drivers/mfd/stmfx.c
>  create mode 100644 drivers/pinctrl/pinctrl-stmfx.c
>  create mode 100644 include/linux/mfd/stmfx.h
> 

-- 
Lee Jones [李琼斯]
Linaro Services Technical Lead
Linaro.org │ Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog

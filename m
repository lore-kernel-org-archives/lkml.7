Return-Path: <SRS0=LehB=SZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 763F4C10F14
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Apr 2019 10:31:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 426D0214AE
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Apr 2019 10:31:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="PECJkUJe"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727402AbfDWKbW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Apr 2019 06:31:22 -0400
Received: from mail-lf1-f65.google.com ([209.85.167.65]:44817 "EHLO
        mail-lf1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726443AbfDWKbW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Apr 2019 06:31:22 -0400
Received: by mail-lf1-f65.google.com with SMTP id h18so11292436lfj.11
        for <linux-kernel@vger.kernel.org>; Tue, 23 Apr 2019 03:31:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=5ff2pEoGdc4KC0gtLxN5LhFvtzNseMixgxZGXIorO9w=;
        b=PECJkUJeHhLqmqqTFlJJhas8FoLk9SHl9PlZ6B0n/jYQnTU1tjLSp4cMtOSXEIIA68
         Ic+a1ZgxL2Baxw6dwD8T77rc7c0AyudJeFuflUU/FAw83nDEcUmyDN2LbrSxE2xyDhDx
         c00tdFkkkYd+cl74oDMh41fzVMbz7RaFd+sCBHwtKE5eq57gko6gWY4n73c+NJa+r+Nw
         N8fexd+YC3gVaV3fCxKhSvibYPbOtlCdqMj6G4kf5kDj+NqHCFQzgiFAr1ZY599L7B9O
         mgzH+AjV+DnfWNVFLqB8ZAb93Gz0YFTuocTAuE7DZdPy+NoXNLCSrPtVfbmLT2auMRwf
         2/QA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=5ff2pEoGdc4KC0gtLxN5LhFvtzNseMixgxZGXIorO9w=;
        b=XQ0BH3QRYKpHLuMrszEfbPVagOxKSPZCqrEv8CqEs4wrZRL7CakKvnkgrJ/636Ndh6
         JUgtyHefM3D6LDWRFkYlJFKB8fVTTkJLGCKztq19WSiyaHo9IF+eXgkMnyzxdKJcTm/K
         V4kCjVYnbhqejt1qRMYxGar6WhGxMGDxUrqjiK4o5FlY5J5Nmbk/hKBZWrH2wp2WuF6L
         4L4odrdHXMGITwfSQaZxSv+QkLD3lxcYfwlM6FbHMHLIbKR1/ofhocCGhSCEWinmsugU
         GDKmn9ES0jk9hO7WhEjbuAVD93u18BZnasxwIyBOgM/wjYTMugn3+GVnlu1PdxVJgG2s
         qagw==
X-Gm-Message-State: APjAAAVvhQhW8VruMn8+IQDkGNtX2Xly86nG/n4HxoApqDQiAzQn3GuJ
        1wLxFexX/4vRcqX2UWG0pYhEoJP+sG21VkUd28IIdg==
X-Google-Smtp-Source: APXvYqyNoegd8lkxkT9d5mhsmFbb3khTKqFN3+P/uPlZ8T4LbS+OAHUrytLJtVhwJvduVEEmu8tN4rEC1PkAFPtovZY=
X-Received: by 2002:a19:761a:: with SMTP id c26mr13237907lff.8.1556015480178;
 Tue, 23 Apr 2019 03:31:20 -0700 (PDT)
MIME-Version: 1.0
References: <20190413165418.27880-1-megous@megous.com> <20190413165418.27880-4-megous@megous.com>
In-Reply-To: <20190413165418.27880-4-megous@megous.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Tue, 23 Apr 2019 12:31:08 +0200
Message-ID: <CACRpkdaEptvNTQD+uNmX85kMsgSSiPBnkt3Kt-NzoWT_gioeMQ@mail.gmail.com>
Subject: Re: [PATCH v4 3/9] pinctrl: sunxi: Prepare for alternative bias
 voltage setting methods
To:     megous@megous.com
Cc:     linux-sunxi <linux-sunxi@googlegroups.com>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        Chen-Yu Tsai <wens@csie.org>, Rob Herring <robh+dt@kernel.org>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Mark Rutland <mark.rutland@arm.com>,
        Giuseppe Cavallaro <peppe.cavallaro@st.com>,
        Alexandre Torgue <alexandre.torgue@st.com>,
        Jose Abreu <joabreu@synopsys.com>,
        "David S. Miller" <davem@davemloft.net>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        "open list:DRM PANEL DRIVERS" <dri-devel@lists.freedesktop.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        netdev <netdev@vger.kernel.org>,
        linux-stm32@st-md-mailman.stormreply.com,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Apr 13, 2019 at 6:54 PM <megous@megous.com> wrote:

> From: Ondrej Jirman <megous@megous.com>
>
> H6 has a different I/O voltage bias setting method than A80. Prepare
> existing code for using alternative bias voltage setting methods.
>
> Signed-off-by: Ondrej Jirman <megous@megous.com>
> Acked-by: Maxime Ripard <maxime.ripard@bootlin.com>

This patch applied to the pinctrl tree for v5.2.

Yours,
Linus Walleij

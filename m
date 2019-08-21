Return-Path: <SRS0=xaRW=WR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BA485C3A59E
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Aug 2019 17:56:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8DC022070B
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Aug 2019 17:56:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1566410175;
	bh=O1oO7hBPokTOMjbBA1jwycaR+6b03oInAg14L2G/waU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=rEJvyU4jXNX/po+b6ed1QEmr/QCWi8XSWtq1ZWD34nL7RNfH9NXvBpSF4ds0K1ITS
	 SV1eUYzXupuKsJbC3E2g2kuKLtLm1V4ulbbwMkEaRPI6CvRhpLrHkuc6GJCx3fb9Ll
	 H5m+9KYFP46Fz4Xz06rR6x7DQUSt8n83i+Y7rImU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729700AbfHUR4O (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 21 Aug 2019 13:56:14 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:36883 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726330AbfHUR4O (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Aug 2019 13:56:14 -0400
Received: by mail-wr1-f67.google.com with SMTP id z11so2891680wrt.4;
        Wed, 21 Aug 2019 10:56:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=3QMcAbdO89j9hbCFCxKjPRn72B52n9H62i2qWyUrTKc=;
        b=snzrhD7EB4z6LYL/mp6+EUIR3cu1H/A2q7j+xjU2NXvQ36a15qGXC7vgV5VqppSn5/
         QJtApAFI86b3KbrAWO7c/U83+TGdisXtXTR2qo3EoBsMpQAJ9iQv4dzIh61vI1PyPg+r
         GrOJbatLNUJ74duYlFTaT1XVE8CcEDfudAO1Jj3Fnq4lq4uCf0zhSl0zSkY+IjOrJQ3D
         AefDg6teIbi094gV4UJ0l3jamRHluoj5yGcz/EYZpDV3dS7Hkonb6CaLCsy/j9JPl+n2
         G4tzRc2rVnrYVJc0fRhXOPDWMX7W9HeaRkSmq/otsMNxUHWyFgrPsse9IlhLhay1BCne
         6ziw==
X-Gm-Message-State: APjAAAVYYJ4k7rl5SLWt+o+aP9xAWtuLy6ffEqtqxbj3YPZ6yB93poFX
        ysvSNlGNizm5XdKA1g/RzVg=
X-Google-Smtp-Source: APXvYqyXIbUhXlGcLLVFLun1i20quC+8O/1XUZRT3UwzRWmduyZeM2r2J5aRsbF9VA1AfHqIAQiZ8g==
X-Received: by 2002:adf:f1cc:: with SMTP id z12mr4554250wro.125.1566410171806;
        Wed, 21 Aug 2019 10:56:11 -0700 (PDT)
Received: from kozik-lap ([194.230.147.11])
        by smtp.googlemail.com with ESMTPSA id g12sm25434578wrv.9.2019.08.21.10.56.10
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 21 Aug 2019 10:56:11 -0700 (PDT)
Date:   Wed, 21 Aug 2019 19:56:09 +0200
From:   Krzysztof Kozlowski <krzk@kernel.org>
To:     Masahiro Yamada <yamada.masahiro@socionext.com>
Cc:     Kukjin Kim <kgene@kernel.org>,
        linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Russell King <linux@armlinux.org.uk>,
        linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org
Subject: Re: [PATCH] ARM: s3c64xx: squash samsung_usb_phy.h into
 setup-usb-phy.c
Message-ID: <20190821175609.GA6768@kozik-lap>
References: <20190819155602.20843-1-yamada.masahiro@socionext.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190819155602.20843-1-yamada.masahiro@socionext.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 20, 2019 at 12:56:02AM +0900, Masahiro Yamada wrote:
> This is only used by arch/arm/mach-s3c64xx/setup-usb-phy.c
> 
> $ git grep samsung_usb_phy_type
> include/linux/usb/samsung_usb_phy.h:enum samsung_usb_phy_type {
> $ git grep USB_PHY_TYPE_DEVICE
> arch/arm/mach-s3c64xx/setup-usb-phy.c:  if (type == USB_PHY_TYPE_DEVICE)
> arch/arm/mach-s3c64xx/setup-usb-phy.c:  if (type == USB_PHY_TYPE_DEVICE)
> include/linux/usb/samsung_usb_phy.h:    USB_PHY_TYPE_DEVICE,
> $ git grep USB_PHY_TYPE_HOST
> include/linux/usb/samsung_usb_phy.h:    USB_PHY_TYPE_HOST,
> 
> Actually, 'enum samsung_usb_phy_type' is unused; the 'type' parameter
> has 'int' type. Anyway, there is no need to declare this enum in the
> globally visible header. Squash the header.
> 
> Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
> ---
> 
>  arch/arm/mach-s3c64xx/setup-usb-phy.c        |  5 +++++
>  arch/arm/plat-samsung/include/plat/usb-phy.h |  2 --
>  include/linux/usb/samsung_usb_phy.h          | 17 -----------------
>  3 files changed, 5 insertions(+), 19 deletions(-)

Thanks, applied.

Best regards,
Krzysztof


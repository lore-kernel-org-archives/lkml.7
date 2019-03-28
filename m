Return-Path: <SRS0=Qu8K=R7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CD96DC43381
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Mar 2019 09:06:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 944EB2082F
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Mar 2019 09:06:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eLHwGJXP"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726811AbfC1JGk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Mar 2019 05:06:40 -0400
Received: from mail-pl1-f194.google.com ([209.85.214.194]:36155 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725815AbfC1JGj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Mar 2019 05:06:39 -0400
Received: by mail-pl1-f194.google.com with SMTP id k2so4664552plt.3;
        Thu, 28 Mar 2019 02:06:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=lBjhFzGXXjuIGoD8b3dkSI7oAYYZZU8Z02rhPa+MRpA=;
        b=eLHwGJXPcqe+eK3M4h6B/Q8zF5Ra0hsmYDdp47+pa59Fr2QBE2EjQ/udU3VeULx/Fx
         oZz0JxvqcBixwLiZ4cwVwCD8dq+nEvIkdtmysojRlsZSvX3AXAmYtgyhbstYE6nxxB0e
         ebj+PckMIK/JWvEHH/BtRfM3Fxg8uUVtDMy5qLILTwlHnF7evGGJH1rxY0g4dty0Yl5U
         Z+OCHTkKdYUbYOwJW5busjbuy5VpSBBxC7eLmWDqTg3rzPBve3Vvbpk/Vo7c1Y5qt+PN
         fctRRcv9KKr7TPd3fC5d41AaWzue/Ui6hciB5mpbwsAXs9IHfT8auMOquimMUvNdZa9y
         stGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=lBjhFzGXXjuIGoD8b3dkSI7oAYYZZU8Z02rhPa+MRpA=;
        b=owXuhYgbspkITwNQ5Q9YXR9HBXXMVaK1PWIYe7tHNK/9FXxflzH2aliZ3vRNkXb2pA
         +1+rS9Hokaie8gLRgW99M5e0EfLGS1oEokqgCaitIgqkFh5EmGeeKXWwlJuByQ+5OROD
         W8oSAnCPOZ+PBAzoWwOFqPPKQk5Uu77LaZp5mTE9u3LrJTL96r+GeI2iYCu2fBuVHhgO
         wOBsX4U8euhjPvholJ20YgtK0NC/iXdAyAm2eT9XZuh8bv4yGzWZMNgDUT/jevhEVaHs
         OW6L1SIhvyvqAaS3S3DX8XSjlSrEnCO9nhmZh5YDyz3Z3nD/tcush3Yq40HDCVeqt8Ea
         LkFw==
X-Gm-Message-State: APjAAAVegcGXtrnL/hiiIyYwjTYihjotr96kzUr+ytgM/v4muyS3hWjy
        /7In8hnRLr8Lde7fI0a1fRxxCuajkNl8Bjtha6fAyjSD
X-Google-Smtp-Source: APXvYqyWhE02y+0/DZrEuSoz5ahmT4voaxuOrm5+SCmThW2G5faHPkmi+qvsf2vM1fmvWc6S+eo0XegEAm+Vodq4VbI=
X-Received: by 2002:a17:902:7289:: with SMTP id d9mr41310732pll.314.1553763999010;
 Thu, 28 Mar 2019 02:06:39 -0700 (PDT)
MIME-Version: 1.0
References: <20190327164339.31205-1-heikki.krogerus@linux.intel.com>
In-Reply-To: <20190327164339.31205-1-heikki.krogerus@linux.intel.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Thu, 28 Mar 2019 11:06:27 +0200
Message-ID: <CAHp75Ve7Q=msCpPSLzeJaNGfJmjU4+qQfz+4gMMsA9Xr16Ao=g@mail.gmail.com>
Subject: Re: [PATCH 0/3] device property: fwnode_is_compatible() helper
To:     Heikki Krogerus <heikki.krogerus@linux.intel.com>
Cc:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Chunfeng Yun <chunfeng.yun@mediatek.com>,
        Biju Das <biju.das@bp.renesas.com>,
        Hans de Goede <hdegoede@redhat.com>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        USB <linux-usb@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 27, 2019 at 6:43 PM Heikki Krogerus
<heikki.krogerus@linux.intel.com> wrote:
>
> Hi,
>
> Basically the helper is just a generic version of the function
> of_device_is_compatible() that should work also with ACPI and
> software nodes.
>
> As the first user for the helper, I'm converting in this series the
> USB role switch code to expect the "compatible" property to have the
> value "usb-role-switch" instead of expecting a boolean property named
> "usb-role-switch". I'm doing the same for the USB Type-C mux code.
>

FWIW,
Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>

> thanks,
>
> Heikki Krogerus (3):
>   device property: Add fwnode_is_compatible() and device_is_compatible()
>     helpers
>   usb: roles: Use the "compatible" property instead of a boolean
>     property
>   usb: typec: mux: Use the "compatible" property instead of a boolean
>     property
>
>  drivers/base/property.c   | 35 +++++++++++++++++++++++++++++++++++
>  drivers/usb/roles/class.c |  2 +-
>  drivers/usb/typec/mux.c   |  8 ++------
>  include/linux/property.h  |  3 +++
>  4 files changed, 41 insertions(+), 7 deletions(-)
>
> --
> 2.20.1
>


-- 
With Best Regards,
Andy Shevchenko

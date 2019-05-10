Return-Path: <SRS0=sufd=TK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 08DB7C04A6B
	for <linux-kernel@archiver.kernel.org>; Fri, 10 May 2019 16:09:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CB5322070D
	for <linux-kernel@archiver.kernel.org>; Fri, 10 May 2019 16:09:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="mqtjBvXv"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727631AbfEJQJZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 10 May 2019 12:09:25 -0400
Received: from mail-ot1-f65.google.com ([209.85.210.65]:37568 "EHLO
        mail-ot1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727471AbfEJQJZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 May 2019 12:09:25 -0400
Received: by mail-ot1-f65.google.com with SMTP id r10so5322896otd.4
        for <linux-kernel@vger.kernel.org>; Fri, 10 May 2019 09:09:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=hcYMIuHgqzn7kbADbR6bw4zWNeAK9h2IBwjyeGMNX18=;
        b=mqtjBvXvnB0NWBrBS4vmOWAyfgXiftln0/XRF/TQwg86h6sRbV5bPNcnLrDyJ85HFs
         0OZciYGzRkhSp+ZXHHN8a7fCI8c4RjyH7/GfFaCVmTJYgUl3inE37AqBP4ABvzXRaW2k
         NlQlNlMkQ/ghFTQxFHtrtDrOWnP+XlPViREao=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=hcYMIuHgqzn7kbADbR6bw4zWNeAK9h2IBwjyeGMNX18=;
        b=AjRLOuPN6s0TmtJ4Z1fpEZUzI8jqltjdLzJ36zih3flVo3fhpnc2zf0gwKruQRPzwZ
         FRT0YH9MIpOxytb5P2f/YwLUTZG8TpmMDaDhgxcm/Da/+kY1UdbgNTF8x+a7ByAfVgiL
         BPydR3pSUjK9ame5nTmVIaY+VPzGaRXnIhOto+eMrBlt/rUa9CMqg5gtUKIBiuGsfzVT
         3gw5ppDpfPT5iI1AcF+KK02sTtTKFPFJsheDA3mL4DAVJz6a0eBvwl7VDJF+QEgtMyfO
         lJeOhQvRvr7b8KOLiOKl0RAzJbvAIN+6d2cWxIzL7IsWUvPLChIjqcSdu94h0mVQVlaX
         foDQ==
X-Gm-Message-State: APjAAAUbURtotM3aGyHGuR/3Tp8ioo7KqBeQ7rdhSnGhl69Zsv3yPK6s
        UypACZ42CsagYBJy4utvDaOsRQKAhqs=
X-Google-Smtp-Source: APXvYqzklUC+auQr3g/qu2r/2ZWhqv/FFiQ3GY5/Kuc9jBo5NtY8U5lmd9XHUoRQQSyZIhh6ew1nnA==
X-Received: by 2002:a9d:3b06:: with SMTP id z6mr7160602otb.140.1557504564140;
        Fri, 10 May 2019 09:09:24 -0700 (PDT)
Received: from mail-oi1-f170.google.com (mail-oi1-f170.google.com. [209.85.167.170])
        by smtp.gmail.com with ESMTPSA id r15sm1426620oic.23.2019.05.10.09.09.22
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
        Fri, 10 May 2019 09:09:23 -0700 (PDT)
Received: by mail-oi1-f170.google.com with SMTP id k9so4899238oig.9
        for <linux-kernel@vger.kernel.org>; Fri, 10 May 2019 09:09:22 -0700 (PDT)
X-Received: by 2002:a05:6808:64f:: with SMTP id z15mr5574175oih.148.1557504562026;
 Fri, 10 May 2019 09:09:22 -0700 (PDT)
MIME-Version: 1.0
References: <20190417012048.87977-1-ncrews@chromium.org> <CAFqH_53L-rq3pGny90eAS1ho__vAxnLt5i_F1pvo+=PA1fO-HQ@mail.gmail.com>
In-Reply-To: <CAFqH_53L-rq3pGny90eAS1ho__vAxnLt5i_F1pvo+=PA1fO-HQ@mail.gmail.com>
From:   Nick Crews <ncrews@chromium.org>
Date:   Fri, 10 May 2019 10:09:10 -0600
X-Gmail-Original-Message-ID: <CAHX4x8506kfxeuk4n5Q=HjceT5zV-gifGXYNYfge_wV825ki4Q@mail.gmail.com>
Message-ID: <CAHX4x8506kfxeuk4n5Q=HjceT5zV-gifGXYNYfge_wV825ki4Q@mail.gmail.com>
Subject: Re: [PATCH v3 1/2] platform/chrome: wilco_ec: Add Boot on AC support
To:     Enric Balletbo Serra <eballetbo@gmail.com>
Cc:     Enric Balletbo i Serra <enric.balletbo@collabora.com>,
        Benson Leung <bleung@chromium.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Duncan Laurie <dlaurie@chromium.org>,
        Daniel Erat <derat@google.com>,
        Dmitry Torokhov <dtor@google.com>,
        Simon Glass <sjg@chromium.org>, bartfab@chromium.org,
        Oleh Lamzin <lamzin@google.com>,
        Jason Wong <jchwong@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Thanks for the review Enric!

I can resend the patch with the fixes, or if you think the fixes are
simple enough, you could tweak them as you apply them. Let
me know if you want me to resend a clean version.

> > +
> > +static DEVICE_ATTR_WO(boot_on_ac);
>
> Is not possible to read the flag? From the API description seems that it is.

It is not possible to read the flag. The API description is wrong,
I'll fix remove
the line about reading from the documentation.

> > +void wilco_ec_remove_sysfs(struct wilco_ec_device *ec)
> > +{
> > +       sysfs_create_group(&ec->dev->kobj, &wilco_dev_attr_group);
>
> As Guenter pointed:  sysfs_remove_group()

Yes, exactly.

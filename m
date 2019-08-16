Return-Path: <SRS0=MEBR=WM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9A448C3A59C
	for <linux-kernel@archiver.kernel.org>; Fri, 16 Aug 2019 13:46:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 619472064A
	for <linux-kernel@archiver.kernel.org>; Fri, 16 Aug 2019 13:46:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="U6WPf/Y0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727405AbfHPNqD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 16 Aug 2019 09:46:03 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:36333 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727261AbfHPNqD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Aug 2019 09:46:03 -0400
Received: by mail-pf1-f196.google.com with SMTP id w2so3174612pfi.3
        for <linux-kernel@vger.kernel.org>; Fri, 16 Aug 2019 06:46:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=nMoZTpZ/0htCIkx2wqL4wrQZszHJLD8O1/FaC7VV3IU=;
        b=U6WPf/Y0AtAZ3UmU0AFNoqstI7Sn4RT9H47GgKphd+YD44ZmbDnAWzxAmT5v5WxFMx
         hIFEN+v+xgOv6adi23MRuTwYLjNoNb+FMdPX0KN+8QckY+NSCHQ61uCUsdyiJSh5FP2q
         wqJJmv1VWP+aquVAzQnQD69/sKDdhstbHDgmcjg4Ge8Z8XSU9HtjG1eStx8ieuC7F3Eg
         ojTmK+Z7AdHrqIu2cttiMIFdc7O7DO3d1YzJwihqTkSWTtHOp1h9GciiaEIInVqrkJO2
         m2ASTTv/1MtzYmXe1V2ejUaRCUri65w6xBbm3Ro7AIfHYEoqNkZ9QCohbeSKZJ9uHt9s
         Lm5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=nMoZTpZ/0htCIkx2wqL4wrQZszHJLD8O1/FaC7VV3IU=;
        b=IUHv8fFMA6hMvcyFsMAad1NCuD7FMK3iR9qSyBaRhvQNYekay6pqwdETYAnqzNw2m+
         qVnjbcBXBd8bW2/QkoLWzFPU6m2IVVId8+TQ/uoHmYFa9EJJD6LexL2f4dJFfLoYhJNf
         Z/VX7fteLaTRAiE+Y5Mvo2vGUijCRJieQN/CGKKGxiYWO7kzIVTOW4xmaIZ3MhwnMML4
         oNVZ+NGK8nJs0Kqazy3bSxh+38Qrx1OCu/ruDo8ndBe/HRcEzhjXxmjvxUUri+xIbkvG
         PxIwCtV4XRH9iWUsIXvo+1pVUhiyysl8vi0xXtv9i2KHr2wYywZOEZP7nrSWFNXkp9rh
         4Tsw==
X-Gm-Message-State: APjAAAW8U3kTTWmGsQMwAHn+tyeuSDtyPCfQlG4iGNGLuzbjhuZE0dg2
        8kZHLl/iMTyaMDylw5kBwN1lZVQbbwhwFdDFXlQ=
X-Google-Smtp-Source: APXvYqzkbZv6quTimHQ62NzMriF92euV5wrPU7uRLMqE6oXWVQRuUd8TDY4js23DyYyI9GqAD8/p+FjlZFsm4fWlSME=
X-Received: by 2002:a63:e54f:: with SMTP id z15mr7860128pgj.4.1565963162464;
 Fri, 16 Aug 2019 06:46:02 -0700 (PDT)
MIME-Version: 1.0
References: <20190816104515.63613-1-heikki.krogerus@linux.intel.com> <20190816104515.63613-3-heikki.krogerus@linux.intel.com>
In-Reply-To: <20190816104515.63613-3-heikki.krogerus@linux.intel.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Fri, 16 Aug 2019 16:45:50 +0300
Message-ID: <CAHp75VcuR+X5=-+VQ9HxU5Nh-uexzDbmZzX_JbZZ2B6tYXQmAQ@mail.gmail.com>
Subject: Re: [PATCH v2 2/3] usb: roles: intel_xhci: Supplying software node
 for the role mux
To:     Heikki Krogerus <heikki.krogerus@linux.intel.com>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Andy Shevchenko <andy@infradead.org>,
        Hans de Goede <hdegoede@redhat.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Darren Hart <dvhart@infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 16, 2019 at 1:45 PM Heikki Krogerus
<heikki.krogerus@linux.intel.com> wrote:
>
> The primary purpose for this node will be to allow linking
> the users of the switch to it. The users will be for example
> USB Type-C connectors. By supplying a reference to this
> node in the software nodes representing the USB Type-C
> controllers or connectors, the drivers for those devices can
> access the switch.

> +       ret = software_node_register(&intel_xhci_usb_node);
> +       if (ret)
> +               return ret;
> +
> +       sw_desc.set = intel_xhci_usb_set_role,
> +       sw_desc.get = intel_xhci_usb_get_role,
> +       sw_desc.allow_userspace_control = true,
> +       sw_desc.fwnode = software_node_fwnode(&intel_xhci_usb_node);
> +
>         data->role_sw = usb_role_switch_register(dev, &sw_desc);
>         if (IS_ERR(data->role_sw))
>                 return PTR_ERR(data->role_sw);

Sounds to me like more fwnode_handle_put() calls are missed.

> @@ -164,6 +173,8 @@ static int intel_xhci_usb_remove(struct platform_device *pdev)
>         pm_runtime_disable(&pdev->dev);
>
>         usb_role_switch_unregister(data->role_sw);
> +       fwnode_handle_put(software_node_fwnode(&intel_xhci_usb_node));


-- 
With Best Regards,
Andy Shevchenko

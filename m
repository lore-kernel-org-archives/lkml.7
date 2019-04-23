Return-Path: <SRS0=LehB=SZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 45C27C10F14
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Apr 2019 09:17:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1583A206A3
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Apr 2019 09:17:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="bYx9V6Ka"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726650AbfDWJRr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Apr 2019 05:17:47 -0400
Received: from mail-lf1-f67.google.com ([209.85.167.67]:33637 "EHLO
        mail-lf1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725990AbfDWJRr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Apr 2019 05:17:47 -0400
Received: by mail-lf1-f67.google.com with SMTP id j11so11161968lfm.0
        for <linux-kernel@vger.kernel.org>; Tue, 23 Apr 2019 02:17:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=KLN23Hi5+Mqr8CBIdXRmqKhVlMBhrBywZBA4ft7XRKA=;
        b=bYx9V6KaiJJfsGowo6nqMSipbcj88T4c66hbOJZUP++IqSgRNQxdkxVl/x/CisDAkj
         5++XNdOreABp/TS3hzxGAZrTgRudeQ7R+VLVRwnJOjZqn9vIyzRVvUwce24zJupIL7ca
         6No8WJfcJPpA2/WOHuK1TzLuLWjmmBeB1nlQ6XTVT6bRnNqJ6nUEhBnpPckC+6U8Kv9U
         1pPDDbj2cwn6/BVjIzVJDJeIb7QUoEvlIRh6ywfv+FlAhehNkGK0Caqb57IR1BvcSdtB
         nxeGbxXW0RJBcJiiIKdrzJ+ghk2p9nlvIEhYbLb9fjqtQn1Nf/SrIfPnX7xvu2GNzjwc
         A3eg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=KLN23Hi5+Mqr8CBIdXRmqKhVlMBhrBywZBA4ft7XRKA=;
        b=mWjLwujY8KMHkcTlC/u3gfPW5j0M/Yw7+/cOZHYGoGqNL7kpr1glOKGmaCvbQzXQLA
         ndhw3lox0FZL74NDCHXnEY91qM+AkSeAajufXXRNfvnurktKhu6E4jlsfT820nuH2PQW
         zGgcQNByTzxP1HWEI23B9Wyfv5PfF0egQ46B6Pf14UpXxiscMID00+PXousQ18ZGm/fs
         TuhvY2EeigGhuvaETfD494xYwSYrk5cnnRYtRqwe/p2hmGpa+U19dNk6d5oUav37eZZZ
         e930lYmonqP4JzSEXURZnJxdYrgFnZ3vJdOo+XNNkuDJiubRcoQiVei3nLL4AW/AvKBp
         O8wA==
X-Gm-Message-State: APjAAAVC+W1KwwvTO0jiyMKWj9o7HQW3iiYoZ5TYGaIlmoEnNKSK5QgO
        gmlVxELyzA40IVSRFgWko2ifsRdiBF1eMkAiCUVOvQ==
X-Google-Smtp-Source: APXvYqyGimK2W/BrBPJLuEUa1Pmik2PQLW3g/Lkq/BlllUQH5xOpAegB0ijkpKQZ/jfC5J6rjFi9gCykGKT1zZXu87I=
X-Received: by 2002:ac2:5381:: with SMTP id g1mr13003078lfh.130.1556011064945;
 Tue, 23 Apr 2019 02:17:44 -0700 (PDT)
MIME-Version: 1.0
References: <20190405142112.26592-1-yuehaibing@huawei.com> <20190412151911.12084-1-yuehaibing@huawei.com>
In-Reply-To: <20190412151911.12084-1-yuehaibing@huawei.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Tue, 23 Apr 2019 11:17:32 +0200
Message-ID: <CACRpkda_xw2rdzSLcreHnfdwsmUMTR=+BRHJWjrE31COaZhtZw@mail.gmail.com>
Subject: Re: [PATCH v3] gpio: merrifield: Fix build err without CONFIG_ACPI
To:     Yue Haibing <yuehaibing@huawei.com>
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 12, 2019 at 5:20 PM Yue Haibing <yuehaibing@huawei.com> wrote:

> From: YueHaibing <yuehaibing@huawei.com>
>
> When building CONFIG_ACPI is not set
> gcc warn this:
>
> drivers/gpio/gpio-merrifield.c: In function mrfld_gpio_get_pinctrl_dev_name:
> drivers/gpio/gpio-merrifield.c:388:19: error: dereferencing pointer to incomplete type struct acpi_device
>    put_device(&adev->dev);
>                    ^~
>
> Reported-by: Hulk Robot <hulkci@huawei.com>
> Fixes:d00d2109c367 ("gpio: merrifield: Convert to use acpi_dev_get_first_match_dev()")
> Suggested-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> Signed-off-by: YueHaibing <yuehaibing@huawei.com>

This doesn't apply cleanly to any GPIO branch (devel or fixes)
so I assume it is supposed to be applied to the ACPI tree.
Acked-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij

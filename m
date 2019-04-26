Return-Path: <SRS0=fl2C=S4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5AB7AC43218
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Apr 2019 20:16:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0F7652086A
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Apr 2019 20:16:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lV4y4aKq"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726189AbfDZUQb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 26 Apr 2019 16:16:31 -0400
Received: from mail-oi1-f169.google.com ([209.85.167.169]:38982 "EHLO
        mail-oi1-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725966AbfDZUQb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Apr 2019 16:16:31 -0400
Received: by mail-oi1-f169.google.com with SMTP id n187so3927148oih.6;
        Fri, 26 Apr 2019 13:16:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Yu0wHV3LGsBqa0aMl6ZuBwB1+fSdjyEfI4Y/oLLQsL8=;
        b=lV4y4aKqFkETwNHatjcJFGHF9O/D7ODykZt0DDNCtCsTa4irzdllo8BcPomIk0O8pm
         /cPhU9RbTuHQZTcbYflmpe6brtUOkdG1h0XfvMjI0dYHOX7SDyzofn8zBDcig3L3asfN
         OGmszEgnglrW4yxsaLopB1hT0EMZpkjK7tFqN7qZkWBNrnGJ5eaE6ZyoLfAKK0hMr+va
         9kC+YgLthYWFXlRnBbEylZ4x7nPMWbSG4vETG/soaWIC4OvjLBqb9+N+KPWWmZaUtlHu
         OAN8oSBw7rw1EFgvpc4FzvJBSU0/OIM27w1fD0zlLopomSf7/6MoJy97vw1jZE233olP
         dcrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Yu0wHV3LGsBqa0aMl6ZuBwB1+fSdjyEfI4Y/oLLQsL8=;
        b=mOnoe4Q4jwzteRqYFu4wr/mUwv/EiEReDLdKdvGy8jqiMc4QjN0eP/I0tpww3UJRW/
         LYWVUyD/M/XtSF2sW+hYrqIKNxDptM+cc4sugW5Pws7Tl8kGydSTzLDJKrVOwRp2Rd0B
         GCa4GH4Dm9ZPaXwDHmGRGGxpiUaGRpb6I7HgOCa2mMqCd7HyNY/GCle1jO3AZzk4CyE1
         HGUkC0BApzK44nujh6mzTERS44FVCQPrB1u1WopWk5k1NB93S0RmS3MaV/QtiTsovPDX
         97vGzZym/5wEI8OULBi1SvyqvXS/apMRuFtH+uEEHWLfJ7OBqEKhqgM9ZuPWIaw+w609
         W3iQ==
X-Gm-Message-State: APjAAAVJ3YMQJ3/Ag6T3tQtGXJ33jkpIl7KvVQMvSYDtsEGrmeEDjZNH
        SHnGaLi9/0FCBvUN5Y/42T4r5PO6BOe809mdEDw=
X-Google-Smtp-Source: APXvYqz40aCy+CjzKR9mVDloBrGx+Zvo4p6qxm+n4lwf2K3BFxKalnugFOjUe7EHuM1f8hZjTY+5aQcdZbQC/GKKae8=
X-Received: by 2002:aca:3006:: with SMTP id w6mr1355669oiw.77.1556309790513;
 Fri, 26 Apr 2019 13:16:30 -0700 (PDT)
MIME-Version: 1.0
References: <1556305282-24148-1-git-send-email-info@metux.net> <1556305282-24148-3-git-send-email-info@metux.net>
In-Reply-To: <1556305282-24148-3-git-send-email-info@metux.net>
From:   Sven Van Asbroeck <thesven73@gmail.com>
Date:   Fri, 26 Apr 2019 16:16:19 -0400
Message-ID: <CAGngYiWGpCeJfBQraTidHLDGjNWsUkp0g4HD=0JRUwT8mX8txg@mail.gmail.com>
Subject: Re: [PATCH v2 2/3] input: keyboard: gpio_keys_polled: use gpio lookup table
To:     "Enrico Weigelt, metux IT consult" <info@metux.net>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        linux-input@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 26, 2019 at 3:03 PM Enrico Weigelt, metux IT consult
<info@metux.net> wrote:
>
> +static struct gpio_desc *gpio_keys_polled_get_gpiod_fwnode(
> +       struct device *dev,
> +       int idx,
> +       const char *desc)
> +{
> +       struct gpio_desc *gpiod;
> +       struct fwnode_handle *child;
> +       int x;
> +
> +       /* get the idx'th child node */
> +       child = device_get_next_child_node(dev, NULL);
> +       while (child && x) {
> +               child = device_get_next_child_node(dev, child);
> +               x--;
> +       }

x is uninitialized here.

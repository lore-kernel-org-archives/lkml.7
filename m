Return-Path: <SRS0=6OEZ=YL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EFEC1CA9EA9
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Oct 2019 18:41:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CBA3F20872
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Oct 2019 18:41:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="s/JGYncS"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392273AbfJRSl6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 18 Oct 2019 14:41:58 -0400
Received: from mail-il1-f194.google.com ([209.85.166.194]:40686 "EHLO
        mail-il1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728350AbfJRSl6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Oct 2019 14:41:58 -0400
Received: by mail-il1-f194.google.com with SMTP id o16so6447713ilq.7;
        Fri, 18 Oct 2019 11:41:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=tJXKGhc1AW/l0WKj0IcIOpG/c9m//aZTCOArzVW/AZw=;
        b=s/JGYncSzqI2bGxfMPGTrEU6YMN+uue1Pn3GVsKkV6CewWE7VwswNVssbghypg2B5r
         O4iy4KgD9IPaIpFP1Uuji4WcIqDJT35onsmfK/8ZfnRxgjJsluFIvQAdyj05RUO4yYWn
         H7HjIFAhkdyk24buc2FvoJdcOydo3D7fY/UyXBLwK5FpIvTu7RbaQzEn9jIHuObUYlp2
         oK487cyGVr2lFBqaJ2ttjFXOGKB7R4lDPOvMCsTCGzqExsRoh+Oo5Uh+Qmlt68zO8QeV
         YbgbC6FAgo6rUOqcP+bIWbmOMvA5jnoaldwbwttz2cDmoOkgNNZ/3xmBk/6q7AYUJ5uy
         PLNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=tJXKGhc1AW/l0WKj0IcIOpG/c9m//aZTCOArzVW/AZw=;
        b=NVlGuxJfvM/8PuMo3ediHtIIALkbs332SdT1EMjA37bc3Nuc7vdCM893mKCU7R61Ck
         aP+bpgG7pmJxAqYRQMN1QiuIFK49KigTQLrLCmr+ZLHoGCCeAUb5CTKwa4C/T6gA81Hn
         QRKCcKYuowBEFXx7dJmln/crAHAwQYV7Ciaru3iks7KeP9iOWFGf2ZAF9nm3bWMs/JCg
         DZFqaAaPo12Gx8wwCDGIoXq5zlQqMNiqjM+guMQFlZY7KIAA4pnBgNYh0VA6BExns3hf
         g0p3kvrRfZSyMSwdXqjb/KN/+XIcOb4Jnim8U5E8BdX8hB4kC8+IaOZh9BGy167yjFkP
         1c0w==
X-Gm-Message-State: APjAAAVReqOq3wtIE6nQ51lGMW9GDaMCjgDEg/WcKvTC5/LeBOvm4W8K
        GRBSs7Uta27KZpIDA4otBtKNwqPj5g3p9cOnz9w=
X-Google-Smtp-Source: APXvYqzVGnrRdxkCssJMUgVLUGTgfJ2Oe03f70oC9SJo+hLMFSxkpBPACOQ7WecE05oJWVeLVBFKMSyBLSuR6dgWN3A=
X-Received: by 2002:a92:b682:: with SMTP id m2mr11544098ill.64.1571424117434;
 Fri, 18 Oct 2019 11:41:57 -0700 (PDT)
MIME-Version: 1.0
References: <20191015141945.16067-1-ben.dooks@codethink.co.uk>
In-Reply-To: <20191015141945.16067-1-ben.dooks@codethink.co.uk>
From:   Sylvain Lemieux <slemieux.tyco@gmail.com>
Date:   Fri, 18 Oct 2019 14:41:46 -0400
Message-ID: <CA+rxa6q3M_o9E95-W5DrtNkzhuuVRBjS74U_TQKLCOde+nG0vw@mail.gmail.com>
Subject: Re: [PATCH] usb: ohci-nxp: fix use of integer as pointer
To:     Ben Dooks <ben.dooks@codethink.co.uk>
Cc:     linux-kernel@lists.codethink.co.uk,
        Vladimir Zapolskiy <vz@mleia.com>,
        Alan Stern <stern@rowland.harvard.edu>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "moderated list:ARM PORT" <linux-arm-kernel@lists.infradead.org>,
        USB list <linux-usb@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 15, 2019 at 10:19 AM Ben Dooks <ben.dooks@codethink.co.uk> wrote:
>
> The hcd pointer in ohci_hcd_nxp_probe() is
> being initialised with a 0, so fix to NULL to
> avoid the following sparse warning:
>
> drivers/usb/host/ohci-nxp.c:153:31: warning: Using plain integer as NULL pointer
>
> Signed-off-by: Ben Dooks <ben.dooks@codethink.co.uk>
> ---
[...]

> --- a/drivers/usb/host/ohci-nxp.c
> +++ b/drivers/usb/host/ohci-nxp.c
> @@ -150,7 +150,7 @@ static void ohci_nxp_stop_hc(void)
>
>  static int ohci_hcd_nxp_probe(struct platform_device *pdev)
>  {
> -       struct usb_hcd *hcd = 0;
> +       struct usb_hcd *hcd = NULL;
>         const struct hc_driver *driver = &ohci_nxp_hc_driver;
>         struct resource *res;
>         int ret = 0, irq;
> --
> 2.23.0
>
Acked-by: Sylvain Lemieux <slemieux.tyco@gmail.com>

Return-Path: <SRS0=eZ3S=UF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8C456C04AB5
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Jun 2019 06:31:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5D82D20883
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Jun 2019 06:31:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eAykI5I2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726605AbfFFGbt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Jun 2019 02:31:49 -0400
Received: from mail-pl1-f194.google.com ([209.85.214.194]:34444 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725766AbfFFGbt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Jun 2019 02:31:49 -0400
Received: by mail-pl1-f194.google.com with SMTP id i2so516983plt.1;
        Wed, 05 Jun 2019 23:31:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ZuYL6lN4ovNLZelnmpwF2tE/28tuu9kcDrW6nhfoTIY=;
        b=eAykI5I2cit6kpAF5jKD+nZ+aVqSXA3rMhKtgNRgXHtVFldg6wBTALZUH+Fj1//dcO
         qvBs7E48tli/uSpkLJ9vpSavSok1SXWOCmVAw2ihUDXP4fW3ZO8EKJBv09sHO1nTngW1
         ZxglCPmZw2XWGuaZiJx/v4jpvzkJqGG/yKzITiB91BHPg7PRB8nUMOgj/US0LkccUlQi
         5o1CSPZ4iD4eSpqoNYNYRRijiwD12ZV3luQUBMdYROiAtu7ZSwWWj3yoswcHPQr+mM6z
         jT0MFhki13yCIcTqLcPywQQJQpCq4FG1t49eCJXz9w7a5TpuFkHlcTaY4gyLGOiZQaER
         QmXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ZuYL6lN4ovNLZelnmpwF2tE/28tuu9kcDrW6nhfoTIY=;
        b=lTMLrmSixKAf2p2KjMCNp/hvKkvoPf8enedePUI6m2bTnBdD0xUqyaGHSl1efKwU9G
         sYfWsYKQWF6bvkNWLiwxOWpHpzUrWMkRCopJvfudWmLxLx6q2Mnr67oZNAfO//eGy3QH
         qb197/7svE+QpJqpjK/vlmJAaIiZbtmj3KYfzowDYq8N2JZ8PFpRrCn5liKA4f1Yb1Sv
         lI01fO3l5C9f0fnmSjC36UMhDpU0SrGWlamb6HX0YInZs2mm7cjK+E4PPuYZcN6peEUf
         cGW+amiRirN/vGY2PmD1JB1CYGpzApTOPYyDM31oRMa24QD+rI0OFazy54/sGq/wcypy
         jh9g==
X-Gm-Message-State: APjAAAWnDCJtSdhyjsNDQSu8/SWVg081M3BRvMw2Ouu5Bo/gJXXYt1+6
        RBwvqUw5MqNUHiW55+I20rnUtBE5bumm7kB7gno=
X-Google-Smtp-Source: APXvYqzmTJjr3etXxZab8gtdLS3HlllT9X2yzuaibx9FNwUj6+wOU1xURYpITcK+CDPHMjIoMhfLuS/5NDX9FVoeE7w=
X-Received: by 2002:a17:902:ab90:: with SMTP id f16mr47819648plr.262.1559802708652;
 Wed, 05 Jun 2019 23:31:48 -0700 (PDT)
MIME-Version: 1.0
References: <1559115828-19146-1-git-send-email-chunfeng.yun@mediatek.com>
 <1559115828-19146-10-git-send-email-chunfeng.yun@mediatek.com>
 <CAHp75VcbZwd0e6r38C2x7HLEHLr4oR7TjwdDXnDxRPRs3anwgA@mail.gmail.com> <1559789630.8487.111.camel@mhfsdcap03>
In-Reply-To: <1559789630.8487.111.camel@mhfsdcap03>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Thu, 6 Jun 2019 09:31:37 +0300
Message-ID: <CAHp75VeWu+8H2=PRNud_MAoD9zozb2Ugh9b=9TCtYmGLVyCTpQ@mail.gmail.com>
Subject: Re: [PATCH v6 09/10] usb: roles: add USB Type-B GPIO connector driver
To:     Chunfeng Yun <chunfeng.yun@mediatek.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Adam Thomson <Adam.Thomson.Opensource@diasemi.com>,
        Li Jun <jun.li@nxp.com>,
        Badhri Jagan Sridharan <badhri@google.com>,
        Hans de Goede <hdegoede@redhat.com>,
        Min Guo <min.guo@mediatek.com>,
        devicetree <devicetree@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        USB <linux-usb@vger.kernel.org>,
        linux-arm Mailing List <linux-arm-kernel@lists.infradead.org>,
        "moderated list:ARM/Mediatek SoC support" 
        <linux-mediatek@lists.infradead.org>,
        Biju Das <biju.das@bp.renesas.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Yu Chen <chenyu56@huawei.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 6, 2019 at 5:53 AM Chunfeng Yun <chunfeng.yun@mediatek.com> wrote:
>
> On Wed, 2019-06-05 at 11:45 +0300, Andy Shevchenko wrote:
> > On Wed, May 29, 2019 at 10:44 AM Chunfeng Yun <chunfeng.yun@mediatek.com> wrote:
> > >
> > > Due to the requirement of usb-connector.txt binding, the old way
> > > using extcon to support USB Dual-Role switch is now deprecated
> > > when use Type-B connector.
> > > This patch introduces a driver of Type-B connector which typically
> > > uses an input GPIO to detect USB ID pin, and try to replace the
> > > function provided by extcon-usb-gpio driver
> >
> > > +static SIMPLE_DEV_PM_OPS(usb_conn_pm_ops,
> > > +                        usb_conn_suspend, usb_conn_resume);
> > > +
> > > +#define DEV_PMS_OPS (IS_ENABLED(CONFIG_PM_SLEEP) ? &usb_conn_pm_ops : NULL)
> >
> > Why this macro is needed?
> Want to set .pm as NULL when CONFIG_PM_SLEEP is not enabled.

Doesn't SIMPLE_DEV_PM_OPS do this for you?

-- 
With Best Regards,
Andy Shevchenko

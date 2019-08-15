Return-Path: <SRS0=gp+X=WL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1627EC3A589
	for <linux-kernel@archiver.kernel.org>; Thu, 15 Aug 2019 12:57:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DD02E208C2
	for <linux-kernel@archiver.kernel.org>; Thu, 15 Aug 2019 12:57:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cj4O6vp4"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731977AbfHOM5P (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 15 Aug 2019 08:57:15 -0400
Received: from mail-pl1-f196.google.com ([209.85.214.196]:44403 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730087AbfHOM5O (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Aug 2019 08:57:14 -0400
Received: by mail-pl1-f196.google.com with SMTP id t14so1035471plr.11
        for <linux-kernel@vger.kernel.org>; Thu, 15 Aug 2019 05:57:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=cz1MzjYMzX4D9CL1r4WIIDgSC+c8JyxTOfGaxa1b0zw=;
        b=cj4O6vp4Eukds5YXbbO7pQY+yJMcHVcww8QLY1Vwp37C3JJcTy1Qp4qXpJJAtXWtY3
         W8vrGcz9aUUYDKH3cJCTjgoVzyCCD5U/gl13JkYFORoIeyEql0Anw5Wb4/YvWa8UEDdC
         H7k15MyLo/sl5B1K4VvE/rJfj96EyLvlMaCWgqCz7sjBTvMSdtYbgLAubg9zPjjkKzSR
         2IOeh27V/7HM2+v4S4UvFgbUs9vPLKl18lM9FqSTP+oFxDDkorhEXr7nlkjqhRSB05l9
         NAmJoR4JKxsjMvz1FuxpomI7dNndPG0WV9NrisRIb+ulKcA1FDffwpOuyvb6zy3TRkML
         cV8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=cz1MzjYMzX4D9CL1r4WIIDgSC+c8JyxTOfGaxa1b0zw=;
        b=XDvy4TYdIqz5Z8s3cR+BUDKflVrLaGzCYqUiaNz9fj52xEEBaP7k1LyLqy1SUZ9poJ
         MzMowKf3GOJOJPuL0bLNX0eCkN7xP7+hoSFDy+tLJIDn9ASy7L9YJJPCgmo8v75+QTdk
         yZaG8jpj8bpSudz1kG97sE06xFT8VwiPALL/4O2Bk6A3mHGW0EwkVH5+itIED8GF9okJ
         p295u3iG+H0H24uk28sYyTpFxpfDTPP2hsN4+cJPVXDMLtXVDPXnx5mKgFwgxwkJw4hi
         eVYty7Z+E1PUpTXsngFviGPzNLKn/5rBd4lZMJAyMy2N5wFVENMHx+W3DRQCpQkqDPmY
         WzKQ==
X-Gm-Message-State: APjAAAUp5fBeqzIGEBSAAJS0kyA82cOVkvl2tqusH77H+dNerje63yk8
        FIe3i/unDTPA/iz6PnVlZwxGEzSiwT2zXB1Y1gM=
X-Google-Smtp-Source: APXvYqzF+djrzTK3h1BgNnvKjeyGw4DDDWA7fM8n3nU29bJPJPPhF05ukbXUPh5tCvDQR6i1TcLRnYnIbr9bzt1Qu/Q=
X-Received: by 2002:a17:902:9349:: with SMTP id g9mr4137313plp.262.1565873833959;
 Thu, 15 Aug 2019 05:57:13 -0700 (PDT)
MIME-Version: 1.0
References: <20190815112826.81785-1-heikki.krogerus@linux.intel.com> <20190815112826.81785-3-heikki.krogerus@linux.intel.com>
In-Reply-To: <20190815112826.81785-3-heikki.krogerus@linux.intel.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Thu, 15 Aug 2019 15:57:02 +0300
Message-ID: <CAHp75Ve6PXtP3D94B1iDB5TcO6etqX9uCrQ7HSn1wSes-B3FPQ@mail.gmail.com>
Subject: Re: [PATCH 2/3] usb: roles: intel_xhci: Supplying software node for
 the role mux
To:     Heikki Krogerus <heikki.krogerus@linux.intel.com>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Darren Hart <dvhart@infradead.org>,
        Andy Shevchenko <andy@infradead.org>,
        Hans de Goede <hdegoede@redhat.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 15, 2019 at 2:28 PM Heikki Krogerus
<heikki.krogerus@linux.intel.com> wrote:
>
> The primary purpose for this node will be to allow linking
> the users of the switch to it. The users will be for example
> USB Type-C connectors. By supplying a reference to this
> node in the software nodes representing the USB Type-C
> controllers or connectors, the drivers for those devices can
> access the switch.

> -static const struct usb_role_switch_desc sw_desc = {
> +static struct usb_role_switch_desc sw_desc = {

I dunno what is better, but usual approach I'm using in other drivers
is to kmemdup() input constant structures in order to have originals
untouched.

-- 
With Best Regards,
Andy Shevchenko

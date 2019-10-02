Return-Path: <SRS0=zem1=X3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4D6EFC35280
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Oct 2019 12:20:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1622921A4A
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Oct 2019 12:20:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=endlessm-com.20150623.gappssmtp.com header.i=@endlessm-com.20150623.gappssmtp.com header.b="An5AsPzQ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727111AbfJBMUX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 2 Oct 2019 08:20:23 -0400
Received: from mail-qk1-f195.google.com ([209.85.222.195]:33526 "EHLO
        mail-qk1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726062AbfJBMUW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Oct 2019 08:20:22 -0400
Received: by mail-qk1-f195.google.com with SMTP id x134so14742126qkb.0
        for <linux-kernel@vger.kernel.org>; Wed, 02 Oct 2019 05:20:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=endlessm-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=C1s9Qnx4QYX1Pe4YvbI9Mrmen/6O6spmAXKtAR6a1ZE=;
        b=An5AsPzQ4GR89OtegxJb25YpLgigqWoWCZiR6bHJ3Oy8G7LBFQ9lHWHv97ZAOvUMRf
         qBFoIIkJBF+lGTGRADqXCQnQv0dJaQ2Tb3simsA0gp/q7XK87lnc/I6Wb4hCrsL9cr2U
         tnWFx1OSik5XrzVuMTGjNbGDd9gVKtHxu5iQ5kgXr9zINb3tz18A91zKydbJEYyeX1jg
         j6CPcHp/e6Gs6xMaXa0S87DG++j5DyklgYFQNdvOm57ylruD9P2xJlnRk+wMLEqlCy4L
         mJX2IcfNwDDViWo4vKL+Rv3ig7gfVLQE5+QqKxAV6w2qdCg4/8JIaWw4fTGT2tF0GkL/
         cHkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=C1s9Qnx4QYX1Pe4YvbI9Mrmen/6O6spmAXKtAR6a1ZE=;
        b=Ecz8rPS0yjPe9EVj3bHgSa41CvEXHpP2flUcO5SkKfWSkYMOH34+g5Q+AuyQzKoEa4
         L8719eILcinIdXI+lxuAvKhpxRaWjqtmv0AONcYNwYSKaixcLCyMHZ0KOlNpRL2lDGqI
         LtoxeZXIUawE0Z91kYAmr2pMwY6IzENtY2DFk6ujRRte4vzcZ30L8WMigSYxv6qdu5RS
         XDatveEi8y6vtU8BOOMJeQUOFsiTrdYf8cjN/15Dy965Fc1ykWL05mjkgfMybwqPZDjH
         VCad7nSCIARE8SvoiVbYOnuIOAzO3kPmFEVAMncd9PS1sTYF5urzwVWY+Mx8SYaz3zWC
         u8Fw==
X-Gm-Message-State: APjAAAU1ur22vjAJCd9ZPiCTDoL+iS2WIVT8aU07ECVmcEjk96lPVz46
        Zg2vTidy9C5Aq1vBp2fYw2gAYO0Y9OLh2C8OYg/FeQ==
X-Google-Smtp-Source: APXvYqySws1GAC2DEPn4qcev8riMOaMww0CmrYHzV/wKuehgOE3MUUOakPXd6Z5eg0QtzaNjHsPHjYFRsekMDu+WfOc=
X-Received: by 2002:ae9:e30a:: with SMTP id v10mr3437798qkf.369.1570018821860;
 Wed, 02 Oct 2019 05:20:21 -0700 (PDT)
MIME-Version: 1.0
References: <20190917074007.92259-1-chiu@endlessm.com> <20191002043018.65FD86118F@smtp.codeaurora.org>
In-Reply-To: <20191002043018.65FD86118F@smtp.codeaurora.org>
From:   Chris Chiu <chiu@endlessm.com>
Date:   Wed, 2 Oct 2019 20:20:11 +0800
Message-ID: <CAB4CAwfQB5V59xdO_70-tVMWLKTZ3_4x_atkBD+i16GSFjQjRw@mail.gmail.com>
Subject: Re: [PATCH v7] rtl8xxxu: Improve TX performance of RTL8723BU on
 rtl8xxxu driver
To:     Kalle Valo <kvalo@codeaurora.org>
Cc:     Jes Sorensen <Jes.Sorensen@gmail.com>,
        David Miller <davem@davemloft.net>,
        linux-wireless <linux-wireless@vger.kernel.org>,
        netdev <netdev@vger.kernel.org>,
        Linux Kernel <linux-kernel@vger.kernel.org>,
        Linux Upstreaming Team <linux@endlessm.com>,
        Daniel Drake <drake@endlessm.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 2, 2019 at 12:30 PM Kalle Valo <kvalo@codeaurora.org> wrote:
> New warning:
>
> drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_core.c: In function 'rtl8xxxu_refresh_rate_mask':
> drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_core.c:5907:7: warning: this statement may fall through [-Wimplicit-fallthrough=]
>     if (priv->tx_paths == 2 && priv->rx_paths == 2)
>        ^
> drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_core.c:5911:3: note: here
>    case (WIRELESS_MODE_B | WIRELESS_MODE_G | WIRELESS_MODE_N_24G):
>    ^~~~
>
> Patch set to Changes Requested.
>
> --
> https://patchwork.kernel.org/patch/11148163/
>
> https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches
>

Thanks for pointing this out, I've sent a v8 version to fix it.

Chris

Return-Path: <SRS0=6dNS=X4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E4429C4360C
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Oct 2019 01:19:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B510B21A4C
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Oct 2019 01:19:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=endlessm-com.20150623.gappssmtp.com header.i=@endlessm-com.20150623.gappssmtp.com header.b="TtbR+j7b"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727107AbfJCBTa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 2 Oct 2019 21:19:30 -0400
Received: from mail-qk1-f195.google.com ([209.85.222.195]:33291 "EHLO
        mail-qk1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726887AbfJCBT3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Oct 2019 21:19:29 -0400
Received: by mail-qk1-f195.google.com with SMTP id x134so738026qkb.0
        for <linux-kernel@vger.kernel.org>; Wed, 02 Oct 2019 18:19:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=endlessm-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ZWwUSoBB6gPOq9lnD1cBoM5LQLFJ2M8ddN6o2uZdkWw=;
        b=TtbR+j7bCceltYjMDybfhgl9NBDRpqKI3x9SzVu/Ck1CYDrWFvuQccT0+GXkXC/d3d
         s3pS8/a52lZ8olBRj5vpC7LeStougDvvJUaSvC5JtY2ceNHlQPCSEWme0wVvVSFbTLhb
         1oNkIhnkAb/w46tA+MCBLJXnsRQ5uqRBUzqEe9gmIHcq0yWjZKJTwJgnvpXK5CBUICiC
         84Ayn8J42A8zg63ElSrwspKODJTWwu4/4I4xAuyI+aPJcanmFvcUqKdHkj3zYw2t4EyC
         NNIp2CCXK4jszQ4YYKsAIcNdV43r6aMefhLFxIySOsGm8U1YaVPUmt/cGBGMee0/iwTP
         0kdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ZWwUSoBB6gPOq9lnD1cBoM5LQLFJ2M8ddN6o2uZdkWw=;
        b=OM74i2wBODIAb7PMPx8KCtbMbb5uwOQHSKEiYnjJuFOErP8VWouNRGLlqF+yT7XnCX
         MVobQhzI9oTIxnOpVzmX9TyicCEq/UjTnaekIh0XwWUNexTov8LBvGR6qeV6AbrBjaVk
         rtarF07HZTNWqVsnfHFoEJQpMjawIDiSrnhNGlAEvy2ZCTj9ID4UM4cBfFreBxLIfNY4
         RmxlBN+9/JACdSCCSfpIH6TTccIHS/5nozD3saeS+Op6rfMWAVW3m5GH05FTHF/Yl61O
         +RqwLJga1r5ua5l8npGezVYOS+yl/dWzX+EjyGL45pMRmlaa+NzEg6Qtyxv13RwRk6PA
         PQdw==
X-Gm-Message-State: APjAAAXvi0q/M7MVRqhS7nrogqHgpudSOA5QC4ckIxTm0+ldemJZ2A7B
        KhbvQBm/bQQw0tmWH+zx5jyP/GEYwtQQbZ771QSlOw==
X-Google-Smtp-Source: APXvYqz22sL8lrOMniBjvPKW06rVYdNY/jhvEGd6Z/Ys5kj0SD18SNJe3n7BydCu6WyxGhKRdzXC/7sePQYUNSSVqoU=
X-Received: by 2002:a05:620a:5ad:: with SMTP id q13mr1877015qkq.297.1570065566949;
 Wed, 02 Oct 2019 18:19:26 -0700 (PDT)
MIME-Version: 1.0
References: <20190911025045.20918-1-chiu@endlessm.com> <0c049f46-fb15-693e-affe-a84ea759b5d7@gmail.com>
In-Reply-To: <0c049f46-fb15-693e-affe-a84ea759b5d7@gmail.com>
From:   Chris Chiu <chiu@endlessm.com>
Date:   Thu, 3 Oct 2019 09:19:15 +0800
Message-ID: <CAB4CAweXfhLc8ATWg87ydadCKVqj3SnG37O5Hyz8uP8EkPrg9w@mail.gmail.com>
Subject: Re: [PATCH v2] rtl8xxxu: add bluetooth co-existence support for
 single antenna
To:     Jes Sorensen <jes.sorensen@gmail.com>
Cc:     Kalle Valo <kvalo@codeaurora.org>,
        David Miller <davem@davemloft.net>,
        linux-wireless <linux-wireless@vger.kernel.org>,
        netdev <netdev@vger.kernel.org>,
        Linux Kernel <linux-kernel@vger.kernel.org>,
        Linux Upstreaming Team <linux@endlessm.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 2, 2019 at 11:04 PM Jes Sorensen <jes.sorensen@gmail.com> wrote:
>
>
> In general I think it looks good! One nit below:
>
> Sorry I have been traveling for the last three weeks, so just catching up.
>
>
> > +void rtl8723bu_set_coex_with_type(struct rtl8xxxu_priv *priv, u8 type)
> > +{
> > +     switch (type) {
> > +     case 0:
> > +             rtl8xxxu_write32(priv, REG_BT_COEX_TABLE1, 0x55555555);
> > +             rtl8xxxu_write32(priv, REG_BT_COEX_TABLE2, 0x55555555);
> > +             rtl8xxxu_write32(priv, REG_BT_COEX_TABLE3, 0x00ffffff);
> > +             rtl8xxxu_write8(priv, REG_BT_COEX_TABLE4, 0x03);
> > +             break;
> > +     case 1:
> > +     case 3:
>
> The one item here, I would prefer introducing some defined types to
> avoid the hard coded type numbers. It's much easier to read and debug
> when named.
>
Honestly, I also thought of that but there's no meaningful description for these
numbers in the vendor driver. Even based on where they're invoked, I can merely
give a rough definition on 0. So I left it as it is for the covenience
if I have to do
cross-comparison with vendor driver in the future for some possible
unknown bugs.

> If you shortened the name of the function to rtl8723bu_set_coex() you
> won't have problems with line lengths at the calling point.
>
I think the rtl8723bu_set_ps_tdma() function would cause the line length problem
more than rtl8723bu_set_coex_with_type() at the calling point. But as the same
debug reason as mentioned, I may like to keep it because I don't know how to
categorize the 5 magic parameters. I also reference the latest rtw88
driver code,
it seems no better solution so far. I'll keep watching if there's any
better idea.

Chris

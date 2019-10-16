Return-Path: <SRS0=S2At=YJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D50C5FA372A
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Oct 2019 18:37:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ACFA52067D
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Oct 2019 18:37:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XqDRvNd4"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2394252AbfJPShq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 16 Oct 2019 14:37:46 -0400
Received: from mail-io1-f66.google.com ([209.85.166.66]:46676 "EHLO
        mail-io1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726776AbfJPShq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Oct 2019 14:37:46 -0400
Received: by mail-io1-f66.google.com with SMTP id c6so54989287ioo.13;
        Wed, 16 Oct 2019 11:37:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Zun78x40rxA6oXkp7P8ox+V+kFyjr09OHfYGtzA93W4=;
        b=XqDRvNd4FToVzeegzLak6NFnxgwkRmPWZJPC22qCqwURa+tKhHF4eTIxEIDwfJKXGE
         BKDPTwSZmANEspdgw2ZsUNFZT5bWibIlnUVogRJvuBrAuNGuel2LcYSOnGMMm5frQ4qR
         fI26RspgltkmPkt2uP524B6xwBYRH47vLyiqrEck3dsq8JQK29hfST0oSUKBTMe3kIER
         FPFpgOHBO4RaiqWCitDDg3IV712GAsBelfcPSXBk1MTwf1990D4FM8vlHym3qad0kMyh
         RvqdbfOKfyrBJjBdd+28BNSyBs1suVSFM0SYX+ZjrylJr8fL0GAUl00toRsN/oyWthg0
         Zzeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Zun78x40rxA6oXkp7P8ox+V+kFyjr09OHfYGtzA93W4=;
        b=VKExN429VGs5h/gkvchJxaIPUyJ4HRXoZdSIEkl+Y07SBGdt4u0VEQy3on8JuvLoMw
         E/ysilLY7DDxn7W5IkQB2UuHq5K6HhoGAC6DjVM/1m5tMzP8zeVpYtvGzfyt5LWKeavK
         SownBaXaj3lRQCzGfo+yJ+Pcp5ug02Rikx/sn+bH9j3t8TyR61uSRPuwd+vIWKHcF1n7
         6io2QZ3L90+gYLZvGdLyLkW0WECOmiQ45CcSeO5U2VZmRXN7PeGj0pt5x0TEnmhH65sv
         C9+L8oh94SCJO06B44rSat1Wc4q2s161z4s6apXqsd6ljB94Iw+DG2no01viFSoEziQg
         xrow==
X-Gm-Message-State: APjAAAXGF/c/DgjWA52I/nxNlIq13V1hb1IWbs7V7ZvhdD1UixoEr+sD
        PdZeXfxUSy5Zk+h6TmwKuxDRMQaiZChI8H+iHlw=
X-Google-Smtp-Source: APXvYqzx90LkMT7B4GXcuKFTRQuszpRe5bukeFt49VVgWsttubuNZcB8xB4bHRosAFUaCPwkluF/zAGpFrYvuJbr5Cc=
X-Received: by 2002:a5d:9952:: with SMTP id v18mr26959174ios.58.1571251064984;
 Wed, 16 Oct 2019 11:37:44 -0700 (PDT)
MIME-Version: 1.0
References: <20191002114626.12407-1-aford173@gmail.com> <1550E9D9-43ED-4345-A9AF-6D9F097FC64E@holtmann.org>
In-Reply-To: <1550E9D9-43ED-4345-A9AF-6D9F097FC64E@holtmann.org>
From:   Adam Ford <aford173@gmail.com>
Date:   Wed, 16 Oct 2019 13:37:32 -0500
Message-ID: <CAHCN7x+i=fafJpezSEgD6LMzPBNKS2YZ0zwx9+vYODLUkgT3Yg@mail.gmail.com>
Subject: Re: [PATCH] Revert "Bluetooth: hci_ll: set operational frequency earlier"
To:     Marcel Holtmann <marcel@holtmann.org>
Cc:     "open list:BLUETOOTH DRIVERS" <linux-bluetooth@vger.kernel.org>,
        Johan Hedberg <johan.hedberg@gmail.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Adam Ford <adam.ford@logicpd.com>,
        Sebastian Reichel <sre@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 16, 2019 at 1:36 PM Marcel Holtmann <marcel@holtmann.org> wrote:
>
> Hi Adam,
>
> > As nice as it would be to update firmware faster, that patch broke
> > at least two different boards, an OMAP4+WL1285 based Motorola Droid
> > 4, as reported by Sebasian Reichel and the Logic PD i.MX6Q +
> > WL1837MOD.
> >
> > This reverts commit a2e02f38eff84f199c8e32359eb213f81f270047.
> >
> > Signed-off-by: Adam Ford <aford173@gmail.com>
>
> patch has been applied to bluetooth-next tree.

Thank you very much!

adam
>
> Regards
>
> Marcel
>

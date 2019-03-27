Return-Path: <SRS0=95/N=R6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 94559C43381
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Mar 2019 13:08:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5D7D5206DF
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Mar 2019 13:08:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20150623.gappssmtp.com header.i=@bgdev-pl.20150623.gappssmtp.com header.b="XcDpHi8y"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730080AbfC0NID (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Mar 2019 09:08:03 -0400
Received: from mail-it1-f196.google.com ([209.85.166.196]:51219 "EHLO
        mail-it1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727488AbfC0NIC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Mar 2019 09:08:02 -0400
Received: by mail-it1-f196.google.com with SMTP id e24so25327184itl.1
        for <linux-kernel@vger.kernel.org>; Wed, 27 Mar 2019 06:08:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=zRPvbuZEmC01kLvG2YBZzieIw8Cti3aYh1nOKIsStdE=;
        b=XcDpHi8y+dWn8+Y6tBwzVNF8ZXt5mgYAt+1C/F3GKariBbKrGlivgZygZnH8Urd1bZ
         peXuePcx6UnmpIJRnC7AuazMQvlsaQ2FaPCLFhVvfnzfZhqdt28/Nat/kMihqzPwUXC9
         tQZZsyoQicNsm8QT+FjR6mmFxQS2QklKCaczhX42xbFUWXqGsylVIJEDeV68CFo6+8tR
         LmAk3RjR68PDOVBPjbRUXWp2rFjOyel+jz4iUE6c74I7Kh+8YSBsCXj2PVDeXHGdAFw0
         RuybTl+0dzPnFoQGiC2b5C8EHrmHGhxCCWCo0BObjQ88H8RrgxV/B0HVtjEEg8q6roQf
         0tQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=zRPvbuZEmC01kLvG2YBZzieIw8Cti3aYh1nOKIsStdE=;
        b=tzKNgIZiZNoRGWNBgvSMlHr/dKPS9E9Fs6YoZbbZJfXEH6QcqFJE82kds0hICm5Qm5
         XgK4tiO5xG5wUmGFmi+jPvqUMJgw8tiv36XODz4n5830du9FFASn3B+dNgdMfYlkzONH
         x2hTIf0YZ0tBUkhdTItuv4uGsOVRSN8bQi3nbOJL7xB53RnNW02rrpcGM+t62zQ4rY/8
         TqNoUHEKDF++rpQ0SKq5MEtKbiWYaTSugbT58ab60Ctkz/QyaRUDvm2X0UyiB7G3W122
         8HHdySbVFc+V2hwoW7krYFAnWZ1qmntiqftAnRfrHmbGuWYib3MAOVjZHGyJBvSR+Rpo
         TxTg==
X-Gm-Message-State: APjAAAV1b/eQR6evfelnyFFxjrt3L48MFzJBKLAdOsgYKCcMBg1EbRRE
        fROzq23sXhZsA/C0sr59JStYWow7F3bqS0xNwUSfDg==
X-Google-Smtp-Source: APXvYqzH9it436rVW1tu7eOG2Gv0nAjt2pTuGE/F9+s9y9hh6+r52spj18crUn5AQO73+GRQRd+hIJBxMSLmSpNd7EQ=
X-Received: by 2002:a02:924d:: with SMTP id y13mr17508891jag.24.1553692081845;
 Wed, 27 Mar 2019 06:08:01 -0700 (PDT)
MIME-Version: 1.0
References: <20190325135557.3423-1-axel.lin@ingics.com> <CAMRc=MfvguEhfqXBWa8o12WF6xbHM7yEiOZC+N01UDAQYQs7Zg@mail.gmail.com>
 <CAFRkauAkN=QAdqF4Qrq=PRS29yifLegrjPTU2=ngZtrkLbY58w@mail.gmail.com>
In-Reply-To: <CAFRkauAkN=QAdqF4Qrq=PRS29yifLegrjPTU2=ngZtrkLbY58w@mail.gmail.com>
From:   Bartosz Golaszewski <brgl@bgdev.pl>
Date:   Wed, 27 Mar 2019 14:07:51 +0100
Message-ID: <CAMRc=MeN4W3iOc5+t+9b7knRJVx8vA+eb95bRHFBGZJvC0ffuQ@mail.gmail.com>
Subject: Re: [PATCH] regulator: max77650: Convert MAX77651 SBB1 to pickable
 linear range
To:     Axel Lin <axel.lin@ingics.com>
Cc:     Mark Brown <broonie@kernel.org>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

=C5=9Br., 27 mar 2019 o 11:17 Axel Lin <axel.lin@ingics.com> napisa=C5=82(a=
):
>
> > Hi,
> >
> > what tree is this patch based on, because it doesn't apply on top of v5=
.1-rc2.
> Hi Bart,
> You can use linux-next or regulator tree.
> However,  due to build dependency you need to manually apply max77650
> mfd drvier manually  because it's not exist in these tree.
>
> Alternatively, you can check the difference of your tree with
> linux-next regarding max77650-regulator.c changes.
> Then pickup related patches first so you can cleanly apply this patch.
>
> Regards,
> Axel

Can you push a branch you used somewhere public? It'll be faster that way.

Bart

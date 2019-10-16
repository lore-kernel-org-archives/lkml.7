Return-Path: <SRS0=S2At=YJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 488C2FA372A
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Oct 2019 11:25:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 171832067B
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Oct 2019 11:25:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Q52LV5dh"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404876AbfJPLZE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 16 Oct 2019 07:25:04 -0400
Received: from mail-lj1-f196.google.com ([209.85.208.196]:36792 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2403863AbfJPLZC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Oct 2019 07:25:02 -0400
Received: by mail-lj1-f196.google.com with SMTP id v24so23602829ljj.3
        for <linux-kernel@vger.kernel.org>; Wed, 16 Oct 2019 04:25:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=MlGfNW+ZwLIIrjx2RXVhFO36vcxe4kSh91BJi93HZos=;
        b=Q52LV5dhAqKzb9M3AlTjL0SI4SrXZTZ7kHbwa/KvZkyNXw1KEUisSwTAXlpIvFyRdI
         KZiKfo3O1ks0VJDd0N/wkc7Ll6JDLeWwNr/0QBlFH5gqq1+RctHDwfwinZW4e9pdndBr
         BbRGJjbRM9bgDlYtQfeDJzqVnb/xQoZ9P5ZfIiS3zawD51hz1HWegt5fsZGcN4zndXxN
         TRROJuvs14Ed8UkRTfUI1SYUbVaCBK3jvcp18AsgekZjEdBtMs1SiWdsyKL0h6z8/1Iv
         05ehbl7PL7whK0ZfPc2Hj6+RqoIxmtSpm3wX0mwz1+MbwOhFBunRogMaJ+BMaoEGmC4r
         ijzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=MlGfNW+ZwLIIrjx2RXVhFO36vcxe4kSh91BJi93HZos=;
        b=tl5ytmyT8S0LEjhPkzy0tuVEaEVq7652EWjhvGldY5NUEFu9UrrSf2twED4uZXw5IL
         KGWiaGra8yWYWlgRaGsnanuimZMFOIlptZcAIYGlQ9IV3hiRijdfYFxDp+G3mc7dJ5zG
         s+MZQhPj/6hV9gJdpsM491rnyFUmdZ4wktUBCukFU1n4V3Cmlnk7lZFkkUGC/sAojf0r
         DS8T/6/cAyrOeNjIHS0fJWhmna69VBIUQGY0vka+fcFzwNE/23hAvdelmTjN4yZ/6Go7
         p3HFMjZYoKCmPR6osmqCBbsJr0GeNeEaidQwM8qwQCzam4MbHnaIpTGmEmSYxLClRkPp
         o4yg==
X-Gm-Message-State: APjAAAUv/sn6doji/foiMJYv3QQEuck/Zpgviz2wn6XXg5tQwSJUrtBd
        djGA7sVYJOKAiKVL96It51+34RRULSEV8VA1+gvOnA==
X-Google-Smtp-Source: APXvYqxHJCsCiOB07sfl//pV88Ji6ehsYnvrh50L4VAxJJIWuK8+6oBcB8+7Hgh2P49tJS+pXeAJM7bhEsUVTSP1i4o=
X-Received: by 2002:a2e:81cf:: with SMTP id s15mr5591377ljg.99.1571225100228;
 Wed, 16 Oct 2019 04:25:00 -0700 (PDT)
MIME-Version: 1.0
References: <20191008204800.19870-1-dmurphy@ti.com> <20191008204800.19870-12-dmurphy@ti.com>
In-Reply-To: <20191008204800.19870-12-dmurphy@ti.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Wed, 16 Oct 2019 13:24:48 +0200
Message-ID: <CACRpkdZnJttsw-mpV3cZY51nE6reHqhuwiCH48_k49b=A9NGQg@mail.gmail.com>
Subject: Re: [PATCH v11 11/16] ARM: dts: ste-href: Add reg property to the
 LP5521 channel nodes
To:     Dan Murphy <dmurphy@ti.com>
Cc:     Jacek Anaszewski <jacek.anaszewski@gmail.com>,
        Pavel Machek <pavel@ucw.cz>,
        Linux LED Subsystem <linux-leds@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 8, 2019 at 10:48 PM Dan Murphy <dmurphy@ti.com> wrote:

> Add the reg property to each channel node.  This update is
> to accomodate the multicolor framework.  In addition to the
> accomodation this allows the LEDs to be placed on any channel
> and allow designs to skip channels as opposed to requiring
> sequential order.
>
> Signed-off-by: Dan Murphy <dmurphy@ti.com>
> CC: Linus Walleij <linus.walleij@linaro.org>

Patch applied to the Ux500 tree.

Yours,
Linus Walleij

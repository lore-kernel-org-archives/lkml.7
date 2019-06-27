Return-Path: <SRS0=pEez=U2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 49FE8C48BD7
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Jun 2019 18:06:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 262AD20B7C
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Jun 2019 18:06:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eMcOXyso"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726741AbfF0SGR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Jun 2019 14:06:17 -0400
Received: from mail-pf1-f195.google.com ([209.85.210.195]:35094 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726562AbfF0SGQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Jun 2019 14:06:16 -0400
Received: by mail-pf1-f195.google.com with SMTP id d126so1624032pfd.2
        for <linux-kernel@vger.kernel.org>; Thu, 27 Jun 2019 11:06:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=lpDteih+7Mwk3qi3q2DEXwZhCQnN7OcR40EX+t/sQPg=;
        b=eMcOXysocU25goHi5fJUxWVNFCuesp/pFiguhDcfzZlpefOu5w+4IycyjOMGmgrgTO
         IvvfmvXUoRWx+EuSILhTiKPTeUVuvIysGzKd6zhALcABgStEbnnY5coA734vFNhgTVxE
         C+XHdi0kGfceLr5ikCzl5fbBY2m9R3hV2MaGu12mTrpTqavE2e4AV30BiD2mIG/a6J27
         b05wQnK/3RS1sg1hcqWLGZawBFcu5PKBCT39QxQZqlcYc8DbeVubrr+yn8fgE0o161mH
         Qq4UosfC4BtH626F11kde/qyCI2/HTV+HcLTr7jjr2w/FIR6vrf367H15VKMRgTL4Elu
         XD4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=lpDteih+7Mwk3qi3q2DEXwZhCQnN7OcR40EX+t/sQPg=;
        b=qkUyAz6hz4d+wvtDwRS8+8WCLqg2XjEMoefeHBPviaWR304iNy9JtAIT20hwNmohYQ
         VUA+1nRA5AZRTmPGCs8cQv0f5OUzoVCxjBhhZUGiBGKlOOHlhTw5EGJzD02AcCmPiWgs
         Xfmn3FiJ8utrBegTiZrOZqeSYjz9o11/ohliLpmefPxGy+9O5q9DurVMqRkAt9Xg14Gt
         xOQsGN9hueW7TppyMPHRa1ijOzZ0VZk1tlcfn2pRspW05vH+xErzdFEsZPXBJSFbBQkj
         gtpF87EQBJolCLg72pzxjFbckrxem/ixkB9/rjVRsg7PX9FPAl7jS5FSb5V5gnyOI+Jc
         4I5A==
X-Gm-Message-State: APjAAAXTIS/ZVRqHBVT3sqyzkW2rIXpu13QphFywYAnXIlcb+Pyyt4Vb
        o/Q3z+MkOnAf4Nhu47fEesVZK5GSJYm2AbF7ARQ=
X-Google-Smtp-Source: APXvYqzub2uqR+XZxgbgN0+2ECwb6yE2KqcgaKCTFRxCn8WIcsRCskSLPnsMHOSzwwcv6Wie2xg7zu/ZVmvq3wTxOrg=
X-Received: by 2002:a63:c0e:: with SMTP id b14mr4979692pgl.4.1561658775935;
 Thu, 27 Jun 2019 11:06:15 -0700 (PDT)
MIME-Version: 1.0
References: <20190627174147.4504-1-huangfq.daxian@gmail.com>
In-Reply-To: <20190627174147.4504-1-huangfq.daxian@gmail.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Thu, 27 Jun 2019 21:06:03 +0300
Message-ID: <CAHp75VfRAfJc3498v7qf_X1H8R5ErrZCRPS+ppY3rGe95U62CA@mail.gmail.com>
Subject: Re: [PATCH 48/87] rtl8723bs: os_dep: replace rtw_malloc and memset
 with rtw_zmalloc
To:     Fuqian Huang <huangfq.daxian@gmail.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Larry Finger <Larry.Finger@lwfinger.net>,
        Omer Efrat <omer.efrat@tandemg.com>,
        Michael Straube <straube.linux@gmail.com>,
        Mamta Shukla <mamtashukla555@gmail.com>,
        Emanuel Bennici <benniciemanuel78@gmail.com>,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
        Payal Kshirsagar <payal.s.kshirsagar.98@gmail.com>,
        Jia-Ju Bai <baijiaju1990@gmail.com>,
        Wen Yang <wen.yang99@zte.com.cn>, devel@driverdev.osuosl.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 27, 2019 at 8:41 PM Fuqian Huang <huangfq.daxian@gmail.com> wrote:
>
> rtw_malloc + memset(0) -> rtw_zmalloc

I have a feeling that everything under os_dep folder should be
replaced with native kernel APIs.

>  drivers/staging/rtl8723bs/os_dep/ioctl_cfg80211.c |  8 ++------
>  drivers/staging/rtl8723bs/os_dep/ioctl_linux.c    | 12 +++---------

-- 
With Best Regards,
Andy Shevchenko

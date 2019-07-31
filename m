Return-Path: <SRS0=cgli=V4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F1AC6C32751
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Jul 2019 13:20:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C4D6120693
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Jul 2019 13:20:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lixom-net.20150623.gappssmtp.com header.i=@lixom-net.20150623.gappssmtp.com header.b="SS1frxnB"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729436AbfGaNUn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 31 Jul 2019 09:20:43 -0400
Received: from mail-io1-f66.google.com ([209.85.166.66]:44390 "EHLO
        mail-io1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729361AbfGaNUl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Jul 2019 09:20:41 -0400
Received: by mail-io1-f66.google.com with SMTP id s7so136008195iob.11
        for <linux-kernel@vger.kernel.org>; Wed, 31 Jul 2019 06:20:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lixom-net.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=uiJuwZiymlEb9kJ2URB/qON8yQUNY8MIwM0Qk6MZ00E=;
        b=SS1frxnBsvEYqQ9PkeQtYGNQgRQYmycAW3dEtWmFlhjk2/ZiVnf0aKFPyZv6VXdQ9g
         JFv6UbF9X/+/lUq3RWA+SC81hijNvXH1RQPeve+613wWX5RP//rfOWNDskOL9rqHG87F
         65OdOfqOJTx/sYfcmAolfdThTEno9o6F9KensMlglqchm+1hUdX93sFV+J5FGxNdKOXm
         Jwfgc4W85+EknuqcW0wbypg5fr/X3k0oHFkN56T3PAiqXAlWNvUmcIPIXzi9x3lOBT8r
         hOr8uCEsz9W7WgDlYJwcTKfuNPEbsTAbmwyY9Hi2YUG/JdYDRH5Ca1AlA+EoyJrE8aD0
         k5bA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=uiJuwZiymlEb9kJ2URB/qON8yQUNY8MIwM0Qk6MZ00E=;
        b=AkUqTMFOyxaSSkmBD+YkxSXv8pG/BeKj7hMYOfeaYz6JBy6W1tst++jEU2b2Kz/L9z
         S30nVfN2vuxNubmfDNC9g5nFw5Wyoo2MvsOSJ45jeM8+Bs83L3CELL1SX9OmphI84tus
         Sq8kYyEEH8jMg0Y1w42rlHv+s8A3n3gr1zm3ur0kuALApuRQJTa6gYrpReRuI/14L6iB
         egeQLUZI38560/KxxGxsK861D5iskPf4T4b/LeY73UccLB7otDES+VzeQLpuApCZwhxx
         A1bhS7E2ZF+VTPaoBz1wvRyr5ZofI3BwLW13K4F/wUKFNqUEnp0WRom1ecvVwkdqQh0M
         St9A==
X-Gm-Message-State: APjAAAVR5JWkeed5OhEsPXkVhFjo/JikjiOUySsikf4FwT1ixL9Kd+v6
        AkyNtmgi76jTnh0Kzb/hDaVsS/rGKLdFYMyAdoc=
X-Google-Smtp-Source: APXvYqy110YP4z9YGjyJCXUWIQe2bV7DMu+WU5DQ0hrRwBoddF/3YS3yVQYKaputJMUd9/exV5xavgrEbbw2HT/b5jM=
X-Received: by 2002:a5d:94d0:: with SMTP id y16mr73259624ior.123.1564579240224;
 Wed, 31 Jul 2019 06:20:40 -0700 (PDT)
MIME-Version: 1.0
References: <20190729135505.15394-1-patrice.chotard@st.com>
 <CAOesGMg-3xt2qjjZ569pUE+d6tn7nz264AN9ARkBT_Ej4TFC2A@mail.gmail.com> <de6ab910-380e-6271-88d8-6fe670525e60@st.com>
In-Reply-To: <de6ab910-380e-6271-88d8-6fe670525e60@st.com>
From:   Olof Johansson <olof@lixom.net>
Date:   Wed, 31 Jul 2019 15:20:27 +0200
Message-ID: <CAOesGMgi2cLUZGZnzKY+4i2tZSFyLe2TEK5SPY5yu0qSh_BRxg@mail.gmail.com>
Subject: Re: ARM: multi_v7_defconfig: Enable SPI_STM32_QSPI support
To:     Alexandre Torgue <alexandre.torgue@st.com>
Cc:     Patrice CHOTARD <patrice.chotard@st.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Russell King <linux@armlinux.org.uk>,
        Linux ARM Mailing List <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-stm32@st-md-mailman.stormreply.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Wed, Jul 31, 2019 at 8:48 AM Alexandre Torgue
<alexandre.torgue@st.com> wrote:
>
> Hi Olof
>
> On 7/30/19 7:36 PM, Olof Johansson wrote:
> > Hi Patrice,
> >
> > If you cc soc@kernel.org on patches you want us to apply, you'll get
> > them automatically tracked by patchwork.
> >
>
> Does it means that you will take it directly in arm-soc tree ?
> I mean, I used to take this kind of patch (multi-v7_defconfig patch
> linked to STM32 driver) in my stm32 branch and to send PR for them.

You can do that too -- it was unclear to me whether you posted the
patch with us in the To: line because you wanted it applied or not.


-Olof

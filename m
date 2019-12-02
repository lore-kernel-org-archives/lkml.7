Return-Path: <SRS0=LniW=ZY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1155BC43215
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Dec 2019 13:49:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DA4DB2070B
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Dec 2019 13:49:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="F9VhBriE"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727563AbfLBNtR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 2 Dec 2019 08:49:17 -0500
Received: from mail-lj1-f195.google.com ([209.85.208.195]:44399 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727362AbfLBNtR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Dec 2019 08:49:17 -0500
Received: by mail-lj1-f195.google.com with SMTP id c19so13188963lji.11;
        Mon, 02 Dec 2019 05:49:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=cLrt8YlKggUQkK/Axpll/L9fEHuQ6vyj3K902vDGR24=;
        b=F9VhBriEGMrpURhG7CrgqJaU40ICmCakl8hs2/+rvQaBpE8JU2XFM9876KI55XisqW
         6+KzJD0F/JTZg9SiMgwQtdXIPtJPf+DmGBAblkUyZV9OtfEViz6uQOaSSnJ61A0QZqX1
         SZjRFGp2RcePhNLhb5pxpq3OkXpGBRc+3oBXTftHWav70wbXZ9GTRJU8Y29eEElfYv03
         evv9YiDroQ9SxD4Dr7dBuu6eu+M2cxDalqxbWqmv+kESMmClUSEZIPX5in5GdQm55toE
         pnMo9fks03z0gcZeNWFHh4UsZ6xomiVfPXt891viP2qJb69wBPN8dsG0nDB7f3u4HOan
         g+SQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=cLrt8YlKggUQkK/Axpll/L9fEHuQ6vyj3K902vDGR24=;
        b=PZCXyXjEeJKe9y6s1hx83LvgWncWtUv9iEkHSNOhQoaqpdhJyKOIPOcJVTv/EbWElt
         G1LfqwnVlA3GGBr8AAl8hZUItoIleXl5dmBGA/ULgVey3p+M3Tkwy8LQcAKfOwGd3FRQ
         KVcOJZXPqKzxNISDMqyjqTqljM53Qa2wTFbgiFgP2uvzoL5eObMnDHPGqoPXfktqtDsX
         wUm288RyVNLnKjuzUIUcOP2h3Sc+O4gQDU1spazzowI9wtPMcr7bsPa8381xJ82Tn+X9
         XeK2wI+s/cSMe6Aq9oLeZM5ijqImphBLzwnu7Wd+CG/jzL2/lRMQySbdmoSUA+zhKe79
         b0XA==
X-Gm-Message-State: APjAAAWfQ0z4jeJupAQGHt0sNzHLbUy8aSngCq+OT+d2nrZ/VHB40R56
        2lPXCJ6VxFcWbMJJi8oLmYjqdviI/PNXA22QplA=
X-Google-Smtp-Source: APXvYqyk0aoNW/8zVHupZBl3J/SZQl2I6lH2KJlenDC1l4ew984JmECm3M+q0uuTFooct8ULB9J0o5xubmtkl43z3n8=
X-Received: by 2002:a2e:2c1a:: with SMTP id s26mr46935451ljs.239.1575294555096;
 Mon, 02 Dec 2019 05:49:15 -0800 (PST)
MIME-Version: 1.0
References: <de442143-568d-5fbf-ed0c-d169e33e5d66@gmail.com>
In-Reply-To: <de442143-568d-5fbf-ed0c-d169e33e5d66@gmail.com>
From:   Fabio Estevam <festevam@gmail.com>
Date:   Mon, 2 Dec 2019 10:49:29 -0300
Message-ID: <CAOMZO5Aoj9pUpMdqVTG2pOUBUpnHsxA-Kduhia7_EJZvdEGjwQ@mail.gmail.com>
Subject: Re: Issue with imx_get_temp()
To:     Igor Plyatov <plyatov@gmail.com>
Cc:     Zhang Rui <rui.zhang@intel.com>,
        Eduardo Valentin <edubezval@gmail.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Amit Kucheria <amit.kucheria@verdurent.com>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        NXP Linux Team <linux-imx@nxp.com>, linux-pm@vger.kernel.org,
        "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Igor,

On Mon, Dec 2, 2019 at 10:44 AM Igor Plyatov <plyatov@gmail.com> wrote:
>
> Dear all,
>
> please  look at back-trace below. It happens on Freescale i.MX6 Quad.
>
> Found a few of those during power on/off stress test in the climate chamber:
>
> [    0.657596] ------------[ cut here ]------------
> [    0.657626] WARNING: CPU: 3 PID: 150 at /home/geosig/development/oe-core-toradex-cr7/build/tmp-glibc/work-shared/cr7/kernel-source/kernel/irq/chip.c:242 __irq_startup+0x94/0xa8
> [    0.657630] Modules linked in:
> [    0.657643] CPU: 3 PID: 150 Comm: kworker/3:1 Not tainted 5.1.1 #1

Are you able to reproduce this issue with a 5.4.1 kernel?

Thanks

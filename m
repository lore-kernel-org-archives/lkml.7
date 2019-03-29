Return-Path: <SRS0=SA5R=SA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CB9E2C43381
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Mar 2019 16:49:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8ECEE218D0
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Mar 2019 16:49:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mjkRAoG4"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729847AbfC2QtK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 29 Mar 2019 12:49:10 -0400
Received: from mail-pf1-f195.google.com ([209.85.210.195]:36525 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728936AbfC2QtI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Mar 2019 12:49:08 -0400
Received: by mail-pf1-f195.google.com with SMTP id z5so300152pfn.3;
        Fri, 29 Mar 2019 09:49:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=bmsUoaQwQFPlLNCg51ZXGRiakmRt5XIoAXlPZ07aVLM=;
        b=mjkRAoG4h9EHjGBbpgScdHS+g9rxJKv4rGUCudQoYet4KBvoRu4JQfLJPBCxz+gwc3
         DYi1nkk2OFRj6M3wJ1/9MPKeth1H7NUXJdC7WD4zwHELZqR+9xVwwnhwnSxAXriC9PEd
         6bF/pU6Ol52+/XZHwSoE7VDmO7nLsLC+5oU5TKhRNpcMW3Ao77YMc1P6uB7yViJinkCG
         WrH3SMrao1G++tO/c2f03Ixyf+Chq1tLbO9YoKBTd7T5AxbPczN+jk5fYID5B9t1y+y1
         KYakWjKlZrjO0vQXBQf/1GB4pcOyOfMbuERSNvfL71khG9wU5lgxt/lqcWWU7Ql/smCs
         rC1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition
         :content-transfer-encoding:in-reply-to:user-agent;
        bh=bmsUoaQwQFPlLNCg51ZXGRiakmRt5XIoAXlPZ07aVLM=;
        b=iQ1tvmq94uc9UduT/ovlB3kxkvEvFUiqDLxjg0TrZ4u+FFmdWAlmB17h90uhJZspxh
         49cLjl7aUR5Xbg5ZtIpwIn2edROC6PhGZkXqSY3H0cjG2oksW6Z2eRvrnfeRuqePpzdQ
         q/JnCTkgMOfzVy3DRHHBCQY5Gp8p1QCG1Y9kdbQqWaeit/Dy5wzx6qLldTnkzlRCEChu
         5zbWbflHjpNzorRCKarLmeF24Jw8TeT3vB/CD5njeV5aIIL94mYAqgGY2pq18gSy3hvK
         RYSVFS+1nUm8AUN+0a8fHuej38bM1t66Sx7g7B+jFV+2FyeWXo3+EcH3+LP2WUBhajid
         dpZA==
X-Gm-Message-State: APjAAAVHS0Jhrv7b0oz6eZJRcrY63t/yDE6BvFDKFXt/QOB7yuX09YAR
        2+DSZy5gWQs+tzYm9Zs7D0o=
X-Google-Smtp-Source: APXvYqzOq+KyrQbcw4CUi2lwSSP6GhATj4ns4NLZV53ZAXsf4yT4pW8S/4h//Zs7Cw5LsyD83k379w==
X-Received: by 2002:a65:64cf:: with SMTP id t15mr32276722pgv.322.1553878148029;
        Fri, 29 Mar 2019 09:49:08 -0700 (PDT)
Received: from localhost ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id j16sm3562786pfi.58.2019.03.29.09.49.06
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 29 Mar 2019 09:49:06 -0700 (PDT)
Date:   Fri, 29 Mar 2019 09:49:05 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     Anson Huang <anson.huang@nxp.com>
Cc:     "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "wim@linux-watchdog.org" <wim@linux-watchdog.org>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        "festevam@gmail.com" <festevam@gmail.com>,
        "catalin.marinas@arm.com" <catalin.marinas@arm.com>,
        "will.deacon@arm.com" <will.deacon@arm.com>,
        Aisheng Dong <aisheng.dong@nxp.com>,
        Daniel Baluta <daniel.baluta@nxp.com>,
        "horms+renesas@verge.net.au" <horms+renesas@verge.net.au>,
        "heiko@sntech.de" <heiko@sntech.de>,
        "maxime.ripard@bootlin.com" <maxime.ripard@bootlin.com>,
        Andy Gross <andy.gross@linaro.org>,
        "jagan@amarulasolutions.com" <jagan@amarulasolutions.com>,
        "bjorn.andersson@linaro.org" <bjorn.andersson@linaro.org>,
        "enric.balletbo@collabora.com" <enric.balletbo@collabora.com>,
        "ezequiel@collabora.com" <ezequiel@collabora.com>,
        "stefan.wahren@i2se.com" <stefan.wahren@i2se.com>,
        "marc.w.gonzalez@free.fr" <marc.w.gonzalez@free.fr>,
        "olof@lixom.net" <olof@lixom.net>,
        "linux-watchdog@vger.kernel.org" <linux-watchdog@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        dl-linux-imx <linux-imx@nxp.com>
Subject: Re: [PATCH V9 1/4] dt-bindings: watchdog: add i.MX system controller
 watchdog
Message-ID: <20190329164905.GA7537@roeck-us.net>
References: <1553134884-1720-1-git-send-email-Anson.Huang@nxp.com>
 <1553134884-1720-2-git-send-email-Anson.Huang@nxp.com>
 <20190325203727.GA27661@bogus>
 <DB3PR0402MB39161467D49348DC550CA28AF55A0@DB3PR0402MB3916.eurprd04.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <DB3PR0402MB39161467D49348DC550CA28AF55A0@DB3PR0402MB3916.eurprd04.prod.outlook.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 29, 2019 at 07:44:21AM +0000, Anson Huang wrote:
> Hi, Guenter/Shawn
> 	Since DT has been acked, would you pick up this patch series if no additional comments?
> 

I added patch 1 and 2 of the series to my watchdog-next tree.
Wim usually picks it up from there.

Guenter

> Best Regards!
> Anson Huang
> 
> > -----Original Message-----
> > From: Rob Herring [mailto:robh@kernel.org]
> > Sent: 2019年3月26日 4:37
> > To: Anson Huang <anson.huang@nxp.com>
> > Cc: wim@linux-watchdog.org; linux@roeck-us.net; mark.rutland@arm.com;
> > shawnguo@kernel.org; s.hauer@pengutronix.de; kernel@pengutronix.de;
> > festevam@gmail.com; catalin.marinas@arm.com; will.deacon@arm.com;
> > Aisheng Dong <aisheng.dong@nxp.com>; Daniel Baluta
> > <daniel.baluta@nxp.com>; horms+renesas@verge.net.au; heiko@sntech.de;
> > maxime.ripard@bootlin.com; Andy Gross <andy.gross@linaro.org>;
> > jagan@amarulasolutions.com; bjorn.andersson@linaro.org;
> > enric.balletbo@collabora.com; ezequiel@collabora.com;
> > stefan.wahren@i2se.com; marc.w.gonzalez@free.fr; olof@lixom.net; linux-
> > watchdog@vger.kernel.org; devicetree@vger.kernel.org; linux-arm-
> > kernel@lists.infradead.org; linux-kernel@vger.kernel.org; dl-linux-imx
> > <linux-imx@nxp.com>
> > Subject: Re: [PATCH V9 1/4] dt-bindings: watchdog: add i.MX system
> > controller watchdog
> > 
> > On Thu, Mar 21, 2019 at 02:26:38AM +0000, Anson Huang wrote:
> > > Add i.MX system controller watchdog binding doc.
> > >
> > > Signed-off-by: Anson Huang <Anson.Huang@nxp.com>
> > > ---
> > > Changes since V8:
> > > 	- add optional property "timeout-sec" according to driver change.
> > > ---
> > >  .../bindings/watchdog/fsl-imx-sc-wdt.txt           | 24
> > ++++++++++++++++++++++
> > >  1 file changed, 24 insertions(+)
> > >  create mode 100644 Documentation/devicetree/bindings/watchdog/fsl-
> > imx-sc-wdt.txt
> > 
> > I still think what's in ATF should be discoverable, but:
> > 
> > Acked-by: Rob Herring <robh@kernel.org>

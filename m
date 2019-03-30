Return-Path: <SRS0=yJb2=SB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6CDF8C43381
	for <linux-kernel@archiver.kernel.org>; Sat, 30 Mar 2019 22:04:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 32AEE2184C
	for <linux-kernel@archiver.kernel.org>; Sat, 30 Mar 2019 22:04:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YED4npkp"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730974AbfC3WEc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 30 Mar 2019 18:04:32 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:39349 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730582AbfC3WEc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 30 Mar 2019 18:04:32 -0400
Received: by mail-pf1-f196.google.com with SMTP id i17so2687509pfo.6;
        Sat, 30 Mar 2019 15:04:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=Mr49L7u6qcnUj2D6soIZ51bioEseLHSAnqnRrrZqhyc=;
        b=YED4npkp1Mpz5N+R67itVu31jYuwbo0uc3MarxmKCsV4EMmtaG0rNxFfJTMVrudpmU
         eL3NCvnpjNVl7zgT+viXKoYgzUw5D0KfVrUA2pR+0Ca9vjaPOuPUbnPXd2iXeqNLdU1q
         jIIdxeKiepK0yZ7sFhx/HRzALZ/ekbJ7p6JmNteqpaqtJbIWpoug5vB4qALiULFxYs+x
         Rj/guvDPTHggwh8SB34Sel6nIczCMV09iyvSz/Z3nFFWegtiKW4fntqd+ChNaP0XxyO2
         3nE5EOvwOo1zuIke3T+JEra7DhpI0Ok4b4Yg2Yz4Vi+yDvd6s+nqxnIyf4FGUJQn7KYl
         ODHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=Mr49L7u6qcnUj2D6soIZ51bioEseLHSAnqnRrrZqhyc=;
        b=ujB+kMo7pcQyZT85Y3UIXYDNpq/wWUXhl/emxTvUDyVzud+7bDy2ZIOx8QhfdN9xE1
         IUIcIRB/QAQrQ2dmQLZXB5+M9ddROR5HXQc0nlMqQ1pJZQqU6+tJShbySmbEjPYdLfzk
         89Ub8KSX1i+/JkqN+Ix86ww0f0U8sH6MfWaVPxVCRNNDjxqMaIrB6evDzU4A3XcxfHOv
         gz1QfpEfI62K8IWVgiv2POBsjYhFrwEtSmfO80XMJud/tYaBn9LsGo18aUbgLGBPVL17
         YC30M99EB4YXDzaX8aiEkU3oAcBZDPM8G6OX8rX/kNa5qyHNrC+6QFZG1QWrolv8zRXB
         LeEw==
X-Gm-Message-State: APjAAAWMjglq8YH2zt8Jf7pyvshIkXwTOOb1S/ba6YCM2df+I2ZbG9wu
        ocsak87Bu+rs3crACb+ydAg=
X-Google-Smtp-Source: APXvYqyongpVTTKP0iN3ndIiQrbA7PWRmcnxJztXDvOz656WainjX6sra4Xj1mN7SINb/i+y70a6gw==
X-Received: by 2002:aa7:9286:: with SMTP id j6mr53570520pfa.47.1553983471520;
        Sat, 30 Mar 2019 15:04:31 -0700 (PDT)
Received: from nishad (p640014-ipngn8201hodogaya.kanagawa.ocn.ne.jp. [60.46.49.14])
        by smtp.gmail.com with ESMTPSA id v6sm7765867pgv.92.2019.03.30.15.04.27
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sat, 30 Mar 2019 15:04:30 -0700 (PDT)
Date:   Sun, 31 Mar 2019 03:34:23 +0530
From:   Nishad Kamdar <nishadkamdar@gmail.com>
To:     Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Joe Perches <joe@perches.com>,
        Mark Rutland <mark.rutland@arm.com>,
        devicetree@vger.kernel.org, Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        linux-kernel@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        NXP Linux Team <linux-imx@nxp.com>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH] ARCH: Use the correct style for SPDX License Identifier
Message-ID: <20190330220422.GA11775@nishad>
References: <20190323132808.GA10547@nishad>
 <20190323205937.wkrqmjfk4jycejdo@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20190323205937.wkrqmjfk4jycejdo@pengutronix.de>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Mar 23, 2019 at 09:59:37PM +0100, Uwe Kleine-König wrote:
> Hello,
> 
> On Sat, Mar 23, 2019 at 06:58:14PM +0530, Nishad Kamdar wrote:
> > This patch corrects the SPDX License Identifier style
> > in the Hardware Architecture subsystem.
> > 
> > Changes made by using a script provided by Joe Perches here:
> > https://lkml.org/lkml/2019/2/7/46
> > and making some manual changes.
> 
> Adding a note here that for C header files
> Documentation/process/license-rules.rst mandates C-like comments
> (opposed to C source files where C++ style should be used) would be a
> good idea I think.
> 
> Best regards
> Uwe
> 
> -- 
> Pengutronix e.K.                           | Uwe Kleine-König            |
> Industrial Linux Solutions                 | http://www.pengutronix.de/  |

Sorry for the late reply.

Ok, I'll do that.

Thanks for the review.

Thanks and regards,
Nishad

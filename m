Return-Path: <SRS0=oArh=RZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AB3D7C43381
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 02:24:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 662FC21900
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 02:24:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="pzgRDKFv"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727429AbfCVCYP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Mar 2019 22:24:15 -0400
Received: from mail-lj1-f194.google.com ([209.85.208.194]:36738 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726695AbfCVCYO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Mar 2019 22:24:14 -0400
Received: by mail-lj1-f194.google.com with SMTP id v10so733753lji.3;
        Thu, 21 Mar 2019 19:24:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ucc1AKeYkjjP//biM0sOqPUN9HdNv0BHHwO/CAaK3Gk=;
        b=pzgRDKFv0Mu2hR9SLpDmUZ4NuDTyi6CvU1htdnOCHUpFvS68TGRwlPXjjeng9syKhg
         buxw+NM+XabKQLDQl0wF8Mo41NelyZSJ6mjB6JQXnbR0qJI2NjLr7w6yeYpdV+q9BOwi
         fM/AVxvABjez4Xh7a7JYAi4YAjRWjlCcoPtmSF6fJQxFWahoiq42mCYRUc/kjq23fh7m
         I6ArA7ilbIfVHNi70cu8Es6kb4xPx2/h5LZFHALKQstL0vZFYAnoVheJalUxKBnOABif
         0QrgHCQB+zF4uGmq+aUCB2XfKbGqyRzDAHyBXxNizSRd/QlT/+3KYgd5njRxGFLhr0A5
         9BUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ucc1AKeYkjjP//biM0sOqPUN9HdNv0BHHwO/CAaK3Gk=;
        b=VNLjwTkIAVxQtIb+0fEk8fXYdvxo4OxN+TvuvDBJuXYkGpeGjjrJv5KT9aOooElFDk
         UUejT9hfPdA/CcPwhiAiMqfixe+WQ/manPOOsjkxTtsWdMr8X0JwsgkUXlnJ8D2G8PaB
         WTdONqubStJkWHpuvv64OZNumKckVxIfy0JJXNUeC2G7xHC8BgqCTRwTbu9EHgC0pdPV
         oLeTnsi3Dcs/7XL0LzflVWaFTTeC5+dTsIGCDifqwqddK6eeNyjIsfJBKcDD0S7pg3Nu
         kRpKd+olvw4Kmn+O5QYrGM8/pYsY/VS7q/mhNWShcAA01E12DvZiHg8s/wGEaV/c2wNF
         HVrA==
X-Gm-Message-State: APjAAAWbtMYpjwSUS4a29t907qZpDZE4KTmCE3oj3iZWAYG2gvASuok2
        tqwdIPt31J3SLRuMWbrhN7D/i4zsqW+eXIgtCW4=
X-Google-Smtp-Source: APXvYqwupy6wqX8Kc6F5tlNtOjG9kDKkWoRtpVDgzWdIfYZtW5+aGv+X7HcUnzFwndPLb8bMta5R5p8tDMqv5fuwFns=
X-Received: by 2002:a2e:960b:: with SMTP id v11mr4003865ljh.174.1553221452139;
 Thu, 21 Mar 2019 19:24:12 -0700 (PDT)
MIME-Version: 1.0
References: <20190320120604.7D99B3FBE9@swsrvapps-01.diasemi.com>
 <CAOMZO5AHzQJzz3vd5MzYgSSxzPjU9xan1dFh9473BXeiRCOzzg@mail.gmail.com>
 <VI1PR10MB2352C3A55BE8FABAF3B02681FE410@VI1PR10MB2352.EURPRD10.PROD.OUTLOOK.COM>
 <CAOMZO5By8=j7gZRAdf2-h-5ak-Qo34rqwDL4+HA_97cMXTAnEQ@mail.gmail.com>
 <20190321084240.fveqkhfrbtg7qr4q@fsr-ub1664-175> <CAOMZO5Cz0A19P9E61dy79BFF+V2WsAjobqQ1g9TeiJSCY2Nt4A@mail.gmail.com>
 <20190322011155.GO12513@dragon> <CAOMZO5CBjG_xZWjZof_VOKaLLOCxFz3g7Gz1uTVzD=D5GeQb4g@mail.gmail.com>
 <20190322021521.GY12513@dragon>
In-Reply-To: <20190322021521.GY12513@dragon>
From:   Fabio Estevam <festevam@gmail.com>
Date:   Thu, 21 Mar 2019 23:24:08 -0300
Message-ID: <CAOMZO5CRRg9XD9VovcO5+fdM1DBp12P33T9xgW=cEvTES8yDPA@mail.gmail.com>
Subject: Re: [PATCH] ARM: dts: imx6qdl-sabresd: change phy-mode to use rgmii-id
To:     Shawn Guo <shawnguo@kernel.org>
Cc:     Abel Vesa <abel.vesa@nxp.com>,
        Steve Twiss <stwiss.opensource@diasemi.com>,
        Andrew Lunn <andrew@lunn.ch>, Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        dl-linux-imx <linux-imx@nxp.com>,
        DEVICETREE <devicetree@vger.kernel.org>,
        LINUX-ARM-KERNEL <linux-arm-kernel@lists.infradead.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Support Opensource <Support.Opensource@diasemi.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 21, 2019 at 11:15 PM Shawn Guo <shawnguo@kernel.org> wrote:

> > Unfortunately, just by looking at the dts files we do not know if a
> > board uses an AR803x PHY or not, so I am afraid we can not do an
> > automatic conversion.
>
> At least for those we already know?

Yes, I can help preparing a patch that fixes the i.MX boards we know
use AR8031 PHY.

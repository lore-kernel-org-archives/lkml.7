Return-Path: <SRS0=vL1f=RL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2B8D7C43381
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Mar 2019 12:06:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EDE2F20684
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Mar 2019 12:06:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FSyLZZXI"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726586AbfCHMGJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 Mar 2019 07:06:09 -0500
Received: from mail-ot1-f67.google.com ([209.85.210.67]:43670 "EHLO
        mail-ot1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726286AbfCHMGI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Mar 2019 07:06:08 -0500
Received: by mail-ot1-f67.google.com with SMTP id n71so17116899ota.10;
        Fri, 08 Mar 2019 04:06:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=zFJbvd+Dlnc2KqvpwBRSuvQIpkfMt7NQNJ9XCfl/K58=;
        b=FSyLZZXIzual1QplWYH9faCIu5Fcg56QEJaFUImlMZfL8kvnVjDYwtI3fqBFyOZ+PE
         kdvUDYzk6OGK3QjQYswuWvNAcImII0JbVvkQ8fryuurZV5dx9UX6jtKit1Z0DfCtG5+q
         8UcBQPo36W+gVwxkdHr6+WmkT7jR81yega+4vgstT4g3cLS4n67kaUsNQ0vBHWiNTrsP
         UwLcQRuj/ssW3GcA8xAyzl/LMbOnfHl3MI2Geir4yinVnqiDMHvubvjTgR5cKF1r7BYD
         8maft6MK2Xek9yLWl5qYuWKtM1TGnq3/fkhB3fz7vrkjuMsW8GxDLv1GUf4R6UjY4aOf
         9SgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=zFJbvd+Dlnc2KqvpwBRSuvQIpkfMt7NQNJ9XCfl/K58=;
        b=cs2GosQTy94ssWNXALlwaEYZAaSDX7fUZvMpxQXC6sGLGovL5jP90lFieMekVzfKZm
         jhKNIfJqMnRAqXOJjwQn5JRld3eB5pJrtxfKNjPohz31wyCZAVPhVb7yCVnyPl/wx6l7
         JK/Bxnvw2ksOQ3hASKpqgR5pGSnh5Nmuhr9EyGzUKoEtmWPvAQmQea2/cxdu5jVA4LPe
         pbLZ6yyaJ6CHwJeH4k4u//iHDt9vzYPJA9qg3UNbBdZkNva0eudGYc4IemxbqjiZ/hpe
         5LxxNgHcNSNN2KVljPXShUpe7+3sb9SBtbLBVkIi+OmNKCXE/nwcrYND6UU+rrH8GwgG
         u7uQ==
X-Gm-Message-State: APjAAAWMwWzq6AYq+BU5gNKOLpTpgbqtFVym88OWBjSrSfvp4/7KuT3K
        oczMW2j5myFRtcBrh4jXznaQpCLa+4VpnXS5j1g=
X-Google-Smtp-Source: APXvYqxgQMq+gpA9HBpVNkJzWGINZfDrcC7PlAGsg5OcVyFZs0yn0/DCPc8V3D6LnT6zmt/Mqs6TgCtdFIZOmFXiJdw=
X-Received: by 2002:a9d:6d94:: with SMTP id x20mr10968690otp.78.1552046767822;
 Fri, 08 Mar 2019 04:06:07 -0800 (PST)
MIME-Version: 1.0
References: <20190308120141.3698-1-daniel.baluta@nxp.com> <20190308120141.3698-4-daniel.baluta@nxp.com>
In-Reply-To: <20190308120141.3698-4-daniel.baluta@nxp.com>
From:   Fabio Estevam <festevam@gmail.com>
Date:   Fri, 8 Mar 2019 09:06:09 -0300
Message-ID: <CAOMZO5C7H5Bb=oef6eptD=hXoQeYcHxtNO4n+zxnX7oKyw6-Ag@mail.gmail.com>
Subject: Re: [PATCH v6 3/4] arm64: dts: imx8mq: Add SAI2 node
To:     Daniel Baluta <daniel.baluta@nxp.com>
Cc:     "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "S.j. Wang" <shengjiu.wang@nxp.com>,
        "angus@akkea.ca" <angus@akkea.ca>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        "l.stach@pengutronix.de" <l.stach@pengutronix.de>,
        Abel Vesa <abel.vesa@nxp.com>,
        "ccaione@baylibre.com" <ccaione@baylibre.com>,
        "baruch@tkos.co.il" <baruch@tkos.co.il>,
        "agx@sigxcpu.org" <agx@sigxcpu.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        dl-linux-imx <linux-imx@nxp.com>,
        Aisheng Dong <aisheng.dong@nxp.com>,
        "kuninori.morimoto.gx@renesas.com" <kuninori.morimoto.gx@renesas.com>,
        "spencercw@gmail.com" <spencercw@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 8, 2019 at 9:02 AM Daniel Baluta <daniel.baluta@nxp.com> wrote:
>
> SAI2 is part of AIPS-3 memory region.
>
> Signed-off-by: Daniel Baluta <daniel.baluta@nxp.com>

Reviewed-by: Fabio Estevam <festevam@gmail.com>

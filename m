Return-Path: <SRS0=embV=XF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 23058C49ED6
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Sep 2019 11:50:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EEDF82168B
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Sep 2019 11:50:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="sa7HyIV0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731883AbfIJLu1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 10 Sep 2019 07:50:27 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:40549 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725981AbfIJLu0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Sep 2019 07:50:26 -0400
Received: by mail-wr1-f66.google.com with SMTP id w13so19576782wru.7;
        Tue, 10 Sep 2019 04:50:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Mp/+xh4B3lpSZPmUYL9dk1fTpKxVKAigwQspDwbteG4=;
        b=sa7HyIV0cMMHhgL1oWqjGwgDx6yJ6vvqgaCRI6+aVF6/EOgson57KX5taONf0xwhZc
         1tj9JmDKUINzY4o7P0ZhBW9gvdwuWFZoa5FraxRlX46Y3xbGIUiXtBz8bmJl3e4YVsN2
         KaLQXi4gy1N2kMStAOhOee9ajNjA2xn2QelLNQ3G76kGH/XIyjvf8QFDakFhQ3a8oViO
         foT1pNIPDEE+6AtOWPfcLkTx06a67K0AzOG6LqpRXIbptk9eHupVpHni78cO9Y6Ff31d
         RpmzI6X7ksKaQUorQnu+Fatg5ziWPviVAjqiYPCCzHsoX1xJ0TIF0P1Qa3NhxDdHIn9T
         tZhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Mp/+xh4B3lpSZPmUYL9dk1fTpKxVKAigwQspDwbteG4=;
        b=Wj8eCn9JVviq4SVCNXkfUoET2CikTJTfUnFc+fGTn/RKwRv3DBSemGYFMZ6whYnP5Q
         1OiLzNS3rlREOAKzaTOsFmsnOHOxYzyXj4mnKD6+PCfB5+8N3i13ICe999ZgtgWopfhW
         cXExPnnCDe4SxbNfSLUR3R5A4Lc9oZY8NBjjhBvpM4I/g/yijCIn4lvl2I03HiEK01UE
         FYJGMiAuGNsr6ldWPY3Bf05gfzeVmXqI861ueMroN3RnZgeK1Eg6cRJQiHIfnY4i1qQ5
         t9+TlQk9LwxeRuCBEid7iYWt5N6Hi54bUPvuXT9GroLbK/WRdbqhgYFrNMPgBxmvo0Dj
         IggQ==
X-Gm-Message-State: APjAAAVJYX2/inNIOoiRF87kAwTzysDXflpTXk/c9KwaUgyX6A/meVCS
        1dPB8dTbxTLWS7wYGv8voUzK7rhqSTKhblb+CM0=
X-Google-Smtp-Source: APXvYqy/r75bH4ygY8YmMgMk2X4bmFVs4CUIe5R1fGiV9fEib8ljRft33b37v8rwJrOA1FWZgNDjwW6HapTyAN886xw=
X-Received: by 2002:a05:6000:142:: with SMTP id r2mr2208566wrx.212.1568116224155;
 Tue, 10 Sep 2019 04:50:24 -0700 (PDT)
MIME-Version: 1.0
References: <1566936978-28519-1-git-send-email-peng.fan@nxp.com>
 <20190906172044.B99FB20838@mail.kernel.org> <CAA+hA=To9B0H1z6Hh1eSZN9_rcextT_Oe-CTMmz9fC9CDNUBTQ@mail.gmail.com>
 <DB3PR0402MB3916906683B58843B459ABE1F5B60@DB3PR0402MB3916.eurprd04.prod.outlook.com>
In-Reply-To: <DB3PR0402MB3916906683B58843B459ABE1F5B60@DB3PR0402MB3916.eurprd04.prod.outlook.com>
From:   Daniel Baluta <daniel.baluta@gmail.com>
Date:   Tue, 10 Sep 2019 14:50:12 +0300
Message-ID: <CAEnQRZCAWa61dj+0=iTBQOrntZ-8mk=YB_jtRV4LAEGTfwZuHQ@mail.gmail.com>
Subject: Re: [PATCH] clk: imx: lpcg: write twice when writing lpcg regs
To:     Anson Huang <anson.huang@nxp.com>
Cc:     Dong Aisheng <dongas86@gmail.com>, Stephen Boyd <sboyd@kernel.org>,
        Peng Fan <peng.fan@nxp.com>,
        "festevam@gmail.com" <festevam@gmail.com>,
        "mturquette@baylibre.com" <mturquette@baylibre.com>,
        "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        Aisheng Dong <aisheng.dong@nxp.com>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        dl-linux-imx <linux-imx@nxp.com>, Jacky Bai <ping.bai@nxp.com>,
        Abel Vesa <abel.vesa@nxp.com>,
        "linux-clk@vger.kernel.org" <linux-clk@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 10, 2019 at 1:40 PM Anson Huang <anson.huang@nxp.com> wrote:
>
>
>
> > On Sat, Sep 7, 2019 at 9:47 PM Stephen Boyd <sboyd@kernel.org> wrote:
> > >
> > > Quoting Peng Fan (2019-08-27 01:17:50)
> > > > From: Peng Fan <peng.fan@nxp.com>
> > > >
> > > > There is hardware issue that:
> > > > The output clock the LPCG cell will not turn back on as expected,
> > > > even though a read of the IPG registers in the LPCG indicates that
> > > > the clock should be enabled.
> > > >
> > > > The software workaround is to write twice to enable the LPCG clock
> > > > output.
> > > >
> > > > Signed-off-by: Peng Fan <peng.fan@nxp.com>
> > >
> > > Does this need a Fixes tag?
> >
> > Not sure as it's not code logic issue but a hardware bug.
> > And 4.19 LTS still have not this driver support.
>
> Looks like there is an errata for this issue, and Ranjani just sent a patch for review internally,
>
> Back-to-back LPCG writes can be ignored by the LPCG register due to a
> HW bug. The writes need to be separated by atleast 4 cycles of the gated clock.
> The workaround is implemented as follows:
> 1. For clocks running greater than 50MHz no delay is required as the
> delay in accessing the LPCG register is sufficient.
> 2. For clocks running greater than 23MHz, a read followed by the write
> will provide the sufficient delay.
> 3. For clocks running below 23MHz, LPCG is not used.

Lets add this information in the commit message and also
enhance the comment before the double write.

Also, why can't we add a udelay after the first write and remove
the second write as having two writes for writing a value looks
very un-natural.

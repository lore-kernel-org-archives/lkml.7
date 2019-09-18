Return-Path: <SRS0=HfRD=XN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7F9C1C4CEC9
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Sep 2019 14:23:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 502B52067B
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Sep 2019 14:23:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="tiaefsAe"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729768AbfIROXG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 18 Sep 2019 10:23:06 -0400
Received: from mail-io1-f67.google.com ([209.85.166.67]:33938 "EHLO
        mail-io1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726330AbfIROXG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Sep 2019 10:23:06 -0400
Received: by mail-io1-f67.google.com with SMTP id q1so16638767ion.1;
        Wed, 18 Sep 2019 07:23:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=8hOkftNxCx/aWELaDJaTVsr1hHwRKS/6DkQyi3nkXNo=;
        b=tiaefsAejMqIgoXecf2HVZ6uIEzJD89WgVfxPiUxd2wHa6nLzUze9o9GVpjummntml
         7WwLZ0MXTA59q4jDtNtRrYrkAdCLRVZ7nfYDR58y4svtOoPHkCSLbXxcbMkyCtErkmIM
         9gCBiErpQ8rA/lOYi6jn6wu0tl86UdRkk8Fjaxyw97vvX2IbE/bIqTs+43mniCCVwgd+
         QDgVKIeAchxQSDqjl8U6m2m7i4mRywfVhQtu6dcanIX09OKAWLNWNlIdwhJ1n/DJ9fmM
         MlLOjQwo40B4150GKMdJgMsYej5F+af/4uNUWja8Nd9FAsf9r+cuTOBrXeABpjfrgzue
         LKqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=8hOkftNxCx/aWELaDJaTVsr1hHwRKS/6DkQyi3nkXNo=;
        b=GMCLneJzFp1hfcWNHqqTBDymWpfJdq7O9FQ/RbBNJSt69Q/ZFhLVDs56SxwWNJQdtQ
         g2HE9FB81/ONwdOtuvC/tK6DZ+v7lzW4UY0kGleTFQ5KjXlreSj1/w45nVb5rDJQlJsq
         hB7b0SpzD40g14wkz0oh0DxSeVohk6AMZbhCwrTLzRipWpDqagjnzbizfLbSp9DSno5o
         cnZ5OMHF8ckUZUoV4TWMRguHvbsRcMOelDL9A02xXv0Vi8qW1uF3PEoOTBeWLY3acUiA
         EXSeZt+K9D2Vt+9TB2eeD/nBbUlSsMhRJCT/aNdFYgE3qFxwIdv2flhWJTY73RcplbfK
         HWfQ==
X-Gm-Message-State: APjAAAW3J9l3xcNJAbfe1sL2wqOQeu27K64IH27RUszcfMFq9JRWlhbg
        RL99qPHdYiI037v9SCiOtUw5RcABgeGd2/+hV1V74sxq
X-Google-Smtp-Source: APXvYqxiBAlP+n9Q7FILgic2xGszsDwFKNDSkihvLtOowMxpoCcjP8dfA+h9rXTnJorshM46ixQcptHHt7Al/USCw3Y=
X-Received: by 2002:a5d:8a0f:: with SMTP id w15mr5572006iod.239.1568816585433;
 Wed, 18 Sep 2019 07:23:05 -0700 (PDT)
MIME-Version: 1.0
References: <1568626884-5189-1-git-send-email-peng.fan@nxp.com>
 <1568626884-5189-3-git-send-email-peng.fan@nxp.com> <20190917183856.2342beed@donnerap.cambridge.arm.com>
 <AM0PR04MB44813D62FF7E6762BB17460E888E0@AM0PR04MB4481.eurprd04.prod.outlook.com>
 <20190918110037.4edefb2f@donnerap.cambridge.arm.com> <CABb+yY2G8s9gV8Pu+f__8-bubjCJsVQrQikbVMZXmpTwSMBxiQ@mail.gmail.com>
 <20190918145832.0bb72e16@donnerap.cambridge.arm.com>
In-Reply-To: <20190918145832.0bb72e16@donnerap.cambridge.arm.com>
From:   Jassi Brar <jassisinghbrar@gmail.com>
Date:   Wed, 18 Sep 2019 09:22:54 -0500
Message-ID: <CABb+yY3irsE0U-bex4G60Lwpewea6=pE1vSzi72Z+5DafmC8Xg@mail.gmail.com>
Subject: Re: [PATCH V6 2/2] mailbox: introduce ARM SMC based mailbox
To:     Andre Przywara <andre.przywara@arm.com>
Cc:     Peng Fan <peng.fan@nxp.com>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "sudeep.holla@arm.com" <sudeep.holla@arm.com>,
        "f.fainelli@gmail.com" <f.fainelli@gmail.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        dl-linux-imx <linux-imx@nxp.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 18, 2019 at 8:58 AM Andre Przywara <andre.przywara@arm.com> wrote:
>

> > > Also there is mbox_chan_txdone() with which a controller driver can signal TX completion explicitly.
> > >
> > No. Controller can use that only if it has specified txdone_irq, which
> > is not the case here.
>
> I see. So does the framework handle the case where both txdone_poll and txdone_irq are false?
>
Of course. If there is no IRQ or POLL mechanism for controller to
detect tx-done, the only way left is for client driver to know by some
'ack' response (if any). The client should call mbox_client_txdone()

Thanks

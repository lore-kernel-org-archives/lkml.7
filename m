Return-Path: <SRS0=g5d9=RD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 79044C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Feb 2019 01:32:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 464A12186A
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Feb 2019 01:32:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="W7zv95HL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730681AbfB1Bci (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Feb 2019 20:32:38 -0500
Received: from mail-oi1-f193.google.com ([209.85.167.193]:46461 "EHLO
        mail-oi1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730234AbfB1Bch (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Feb 2019 20:32:37 -0500
Received: by mail-oi1-f193.google.com with SMTP id j135so15199991oib.13;
        Wed, 27 Feb 2019 17:32:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=+2K8pmrQaZcSNxPqZM9qhQ7Rr6/eVDA8+Sj3cqthSBM=;
        b=W7zv95HLHonLhXh8CICzz7U6WKQY1G4Ce5BQklJfvz8nhj7Xl2Zd4JAWznFQTzhy8T
         RwcUemKKuEm/hDWenYqnZv621mzgAwg75TA/J9ILGHGQRJK7nmIh3TOUzETIKbN1XtxU
         AT39c+gD3/bZwiiqOnAt0QkroPf9DTXtAJ3/PR5jIv8yKyBAfo9f9LEJabMueywt5RWn
         kplgkA7i88M/WwLRuxKRTnM0AxQSyaI1TCrk8iMdPtoWoF/wSurd/6urS7Z5avDC3hFm
         r6pRdMsgUPLDOW3/c/x+0y25KGdabIGMLhbdZBVXM692omSEqXieMkbTDT2zwgGxGi1N
         9coQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=+2K8pmrQaZcSNxPqZM9qhQ7Rr6/eVDA8+Sj3cqthSBM=;
        b=k6SVtI1bj79UwuTCc5kYwTFqUycWpWJw6usoSgveGjbrn8sOshOq+3FfOYgAn57LjS
         Eu33GHGIAz0P/ERCilGVoj8X57ttn1Va+NienORN7MfFpB0/vz+ZirmO0DgIHSebxAt3
         hAscpE80M/nqhHjUlELQk17VGdsjl6jXONMZbzU7Tv62zL91SRFEZNMWQO5j9M58lJjk
         caO2p4lxFvLbfNRjuSxGbEJZS5OobU8iGue6AMbjmcDxrDfwzOpZSd/RUk1XIMEYEHU3
         KY/XkzS0J1ictIoM01qc2gulDPTO6b7ZaPO0EwsRUli7vJXYIPnucKrSCjJ1o0wUWE1M
         LWWg==
X-Gm-Message-State: AHQUAubpvCTkQHsZRwD5B6uOI7cz05zYQm72KLIUxvxsRNNRXPI2+y0T
        A9X/4kfhTbDEBg3MVmg6J1kaTRADvzL1Xts+sLI=
X-Google-Smtp-Source: APXvYqxoK1w/Ve0ntC5Krk4TvPzoNIgxEYS8vjKeZHvtQ0kVWA0U1RPaxU+jG7/AoC8TB0Qv7a4pZWvTFTI005/AB1Y=
X-Received: by 2002:aca:ecd7:: with SMTP id k206mr1468238oih.67.1551317556801;
 Wed, 27 Feb 2019 17:32:36 -0800 (PST)
MIME-Version: 1.0
References: <1551316741-7848-1-git-send-email-Anson.Huang@nxp.com> <1551316741-7848-2-git-send-email-Anson.Huang@nxp.com>
In-Reply-To: <1551316741-7848-2-git-send-email-Anson.Huang@nxp.com>
From:   Fabio Estevam <festevam@gmail.com>
Date:   Wed, 27 Feb 2019 22:32:26 -0300
Message-ID: <CAOMZO5DQM0-rBbWuWa7dZw8es1NbY8DwCGmU4_ZJ2FdFEXYC6Q@mail.gmail.com>
Subject: Re: [PATCH V2 2/3] ARM: dts: imx7ulp: add mmdc support
To:     Anson Huang <anson.huang@nxp.com>
Cc:     "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
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

Hi Anson,

On Wed, Feb 27, 2019 at 10:23 PM Anson Huang <anson.huang@nxp.com> wrote:
>
> i.MX7ULP has a MMDC module to control DDR, it reuses
> i.MX6Q's MMDC module, add support for it.
>
> Signed-off-by: Anson Huang <Anson.Huang@nxp.com>
> ---
> Changes since V1:
>         - use "memory-controller" as MMDC node name to make it more generic.
> ---
>  arch/arm/boot/dts/imx7ulp.dtsi | 6 ++++++
>  1 file changed, 6 insertions(+)
>
> diff --git a/arch/arm/boot/dts/imx7ulp.dtsi b/arch/arm/boot/dts/imx7ulp.dtsi
> index fca6e50..78f6117 100644
> --- a/arch/arm/boot/dts/imx7ulp.dtsi
> +++ b/arch/arm/boot/dts/imx7ulp.dtsi
> @@ -286,6 +286,12 @@
>                         status = "disabled";
>                 };
>
> +               mmdc: memory-controller@40ab0000 {

It seems that the 'mmdc' label is not neeed.

You could make it simpler as:

memory-controller@40ab0000 {

Return-Path: <SRS0=XKeO=YB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 15EACECE58C
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Oct 2019 01:43:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DF5B6206BB
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Oct 2019 01:43:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fhaQXeUX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729566AbfJHBng (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 7 Oct 2019 21:43:36 -0400
Received: from mail-lf1-f66.google.com ([209.85.167.66]:37150 "EHLO
        mail-lf1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726917AbfJHBng (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Oct 2019 21:43:36 -0400
Received: by mail-lf1-f66.google.com with SMTP id w67so10672106lff.4;
        Mon, 07 Oct 2019 18:43:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=vAyTNFHXf10lpyOvysT1VF7d3x/O+fWSY3A10NGv1+g=;
        b=fhaQXeUXSNiSeZY5bpAmAFT0Z0rSkXSbIdGcJ3hGOrqWKRonP2jvNanO8N9gdQfsFT
         us5TFT4PUoNgxNGjSST0bRyPNEWOap1Dnnq9XiNI807181jfrE6dx1RtDZW2Drwlvv31
         GfQAmS/P2wFcd3ve4uWGSr8zvitnNwkD4ueN6WLtLt0bfB2Jsi2wuAkmFiRlltGmjsts
         qK88JQYLhbqw0RRh66/b4q3cReqprBMckimSmgv9RckZbTOeAiJweOKzNd+p1FXVstUh
         w3iyYnX1w0H8g9l6z5H1HL7BmyquUMOvxC3um1ZOQoH9DAGVfVZNSwdMzH48nUB7XW1J
         rs2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=vAyTNFHXf10lpyOvysT1VF7d3x/O+fWSY3A10NGv1+g=;
        b=DHWOrJCpfPjHEmPdm2ZwhxQQB8t0L7rBuAEgmhB6nEnkdSr13Q/gW0nTWaU+xKSapm
         T+A3D6q2sZNF05RlZ/ltWStKGRugUwqC6DpOq1oDRkl+eTbxXZ/baHHSufK7MhuZX8Kj
         QzLcRPogwQf/2GZpvziOCTaf0gdiOLSyIpmMcqRgUua1HfnYOyt1Uv4Ij2DZ23bSO9aV
         lpzDPgAXpi3GTuALkpOUb6MxPEi0ZWqTyXkQN0499COH8LTD4jK6WpNZNfoQORknknET
         ErQH776ts8uS2Fc3310FAx/WNWLWMQmbLg0zfD/wAUYDe6xAYALMakCCGlGg2DGm4pcM
         y6bA==
X-Gm-Message-State: APjAAAV5fh0pcVnbWrTwdnSPa9ouGn2Pd0i5LXOLyzE3Hw0zg4dwKX+V
        zfS2ot9c06W6DzlZKgruBva+1L8kS9w8ED1z46E=
X-Google-Smtp-Source: APXvYqz9e9tCBlWunRh4SZKyuWL1gJxlFab/Iiq3JIRTRQVjWEaz3naMs0mijLfOl4pC0rTPCzaNKOtaOnS4jrq002s=
X-Received: by 2002:a19:f11c:: with SMTP id p28mr18140862lfh.44.1570499013898;
 Mon, 07 Oct 2019 18:43:33 -0700 (PDT)
MIME-Version: 1.0
References: <1570497955-19481-1-git-send-email-Anson.Huang@nxp.com> <1570497955-19481-2-git-send-email-Anson.Huang@nxp.com>
In-Reply-To: <1570497955-19481-2-git-send-email-Anson.Huang@nxp.com>
From:   Fabio Estevam <festevam@gmail.com>
Date:   Mon, 7 Oct 2019 22:43:22 -0300
Message-ID: <CAOMZO5Ax+FTfWzkzqY6CH-1_5W8Gk6auEjKtCMEPq+=Ui6643Q@mail.gmail.com>
Subject: Re: [PATCH V2 2/3] arm64: dts: imx8mm-evk: Add i2c3 support
To:     Anson Huang <Anson.Huang@nxp.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Sascha Hauer <kernel@pengutronix.de>, Li Jun <jun.li@nxp.com>,
        Daniel Baluta <daniel.baluta@nxp.com>,
        Ping Bai <ping.bai@nxp.com>,
        Leonard Crestez <leonard.crestez@nxp.com>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        NXP Linux Team <Linux-imx@nxp.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Anson,

On Mon, Oct 7, 2019 at 10:28 PM Anson Huang <Anson.Huang@nxp.com> wrote:
>
> Enable i2c3 for i.MX8MM EVK board.
>
> Signed-off-by: Anson Huang <Anson.Huang@nxp.com>

You could combine this patch with 3/3.

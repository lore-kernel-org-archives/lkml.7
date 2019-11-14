Return-Path: <SRS0=RWM+=ZG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9ED58C43141
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Nov 2019 11:43:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7B283206E1
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Nov 2019 11:43:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lUaH7bFR"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727137AbfKNLnb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Nov 2019 06:43:31 -0500
Received: from mail-wr1-f67.google.com ([209.85.221.67]:37794 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726115AbfKNLna (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Nov 2019 06:43:30 -0500
Received: by mail-wr1-f67.google.com with SMTP id t1so6099468wrv.4;
        Thu, 14 Nov 2019 03:43:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=nQNqrubOlUUYZPppnjrDT5gghOk1RD7VpCkLrJlKMDQ=;
        b=lUaH7bFRd2dhXRSlw+qcr3GHuOtqyG8vd8F0OdlZgPharmpXM3PwpHtGslEKKUTnHM
         27t6qBaIXKh9gGWzxI5rYY4nIBq7FD+trKsQmmL3xDJejBQR3R4DdVL8nb1tzR//uvRj
         kGodRl0qd5Q7uRKoUBYwmpofXZllW0DYzt235GAxRyTrvti+8qVzddQ9by8x7pKAmRXe
         oZzTv0uZpVpOU9vJGgVyUzS9zVrpykUkJv2/nPbOl5lSLoPCAhCrpVCqmDjSKuRW/Vca
         5ZAbUDA5YTxZWn7QJi75URZ097xjC0+ScXkUI3I8/F9Gox0VW4ha0L4O0TMPn8yj+xst
         /b6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=nQNqrubOlUUYZPppnjrDT5gghOk1RD7VpCkLrJlKMDQ=;
        b=Js1wr8OSdiJYBUxbPYTxYW/tANdSpb4Ua5UGb1H2M37cEaSyWr7vfm25cthq8O/haU
         sFTMHcm2G9ZBYauH1zFledHMLUfypGe0Xmh+lqb+GUwKYiTd+wBs8PU1ggOY2+QkgOIH
         dwztktaApI7HynmIoIg6ezDVfZVNVQtTvyIYQcGNsZA7G/DLacWCrj9K4WVg4hVCDM6V
         U8OAgbj+U+rC2I7jhNntEFSVUdJ+VszTBU/7KRWAYzlipddRxrkJdXZDnvv4IxgALTaz
         6GH9TMVyTsl63Zjj2hr/Gfbu2Mb0QqqqW02FVPmTv3RpzckawiuIcGs8bxMBV/4rPVSa
         lJmw==
X-Gm-Message-State: APjAAAXAcs8p0W0MvvsaGNs0QK2GTeOcmVbFSGE7Bn7tWUbPPCsBDZaV
        g3t20awvmXmMzDpHSlqU2OI=
X-Google-Smtp-Source: APXvYqy88aC3vqt2wu5quF6h4AmdgM/VgNut4bo25B9uywblwPxT9Fv0GJagE45hAuflHj5UsL2a4A==
X-Received: by 2002:adf:ef91:: with SMTP id d17mr7505042wro.145.1573731807811;
        Thu, 14 Nov 2019 03:43:27 -0800 (PST)
Received: from localhost ([193.47.161.132])
        by smtp.gmail.com with ESMTPSA id w18sm7021172wrp.31.2019.11.14.03.43.26
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 14 Nov 2019 03:43:26 -0800 (PST)
Date:   Thu, 14 Nov 2019 11:48:48 +0100
From:   "oliver.graute@gmail.com" <oliver.graute@gmail.com>
To:     "shawnguo@kernel.org" <shawnguo@kernel.org>
Cc:     "aisheng.dong@nxp.com" <aisheng.dong@nxp.com>,
        "peng.fan@nxp.com" <peng.fan@nxp.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Li Yang <leoyang.li@nxp.com>,
        Lucas Stach <l.stach@pengutronix.de>,
        Pramod Kumar <pramod.kumar_1@nxp.com>,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        Anson Huang <Anson.Huang@nxp.com>,
        Bhaskar Upadhaya <bhaskar.upadhaya@nxp.com>,
        Stoica Cosmin-Stefan <cosmin.stoica@nxp.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>
Subject: Re: [RFC PATCH 1/1] arm64: dts: added basic DTS for qmx8 congatec
 board
Message-ID: <20191114104848.GH4147@optiplex>
References: <20191029122026.14208-1-oliver.graute@kococonnector.com>
 <20191029122026.14208-2-oliver.graute@kococonnector.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191029122026.14208-2-oliver.graute@kococonnector.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 29/10/19, Oliver Graute wrote:
> Add basic dts support for a Congatec iMX8QM Qseven Board
> 
> Product Page: https://www.congatec.com/de/produkte/qseven/conga-qmx8x.html

just noticed that above product link is wrong. The right one is this:

https://www.congatec.com/de/produkte/qseven/conga-qmx8.html

Best regards,

Oliver

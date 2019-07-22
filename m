Return-Path: <SRS0=CEgE=VT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E6370C7618F
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Jul 2019 23:56:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A432520840
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Jul 2019 23:56:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1563839790;
	bh=5Aig1OFWwSe0PxEpy5jpbRx1PToL6awKWzce7tnSvjk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=nUNaZbhYVZ1PqH3YYQ9wNSiqXDPYymEOMSc4ufuImBQn7ag5wx7sVJBaZfnNvDGMP
	 I3UGiUzS4C0aOUdBwLRHGcQsV3AADoGiZ4wUkevPZbRjLOsCcYK86n616ZMRtMu5Qd
	 7FhQJfxoLcTXrvYScxOdZl4JUAFjSVzlszq5CIic=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387550AbfGVX43 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 22 Jul 2019 19:56:29 -0400
Received: from mail-io1-f68.google.com ([209.85.166.68]:44694 "EHLO
        mail-io1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726070AbfGVX43 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Jul 2019 19:56:29 -0400
Received: by mail-io1-f68.google.com with SMTP id s7so77827554iob.11;
        Mon, 22 Jul 2019 16:56:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=XUUEucdf5T/q+oP9Dd4eyb+UhdjwkWdUVolZWtaE55M=;
        b=Pr2HiyiT+TCTywWpik6ujigtjeM+bOt7dbx/lPbkS5RVoc2uy7c55qcYdy/A2RSn+5
         biZNZatNfSgg0N9IfYqLbOBJx6E8+wCjc/ueg/l3S/p1ePkvbjOJ75ma4x6YzbNtD3Pt
         TBKn+KwDvTXXCIjObJcz15Kz37FSvjPYHPftbZTPXCGeYCeXuY4gQc9gIvMurgMgOtWr
         02DtRV35LGA9Sv2JkVdhQLUcU61ZICuDPMFtv6ptepGWb2iaMNaLSKwqmlEbT7QXQ3vo
         zidwCl/oIM4m0faFMNnbjWtagxC29WvSuRtLdAWpi26CG8QQtGEqCzFL+ayWcv/6dxEA
         Vlew==
X-Gm-Message-State: APjAAAUzDUjp5MbFO0wCFCqhIfUCkL82E0QkON10cVOyZdvjTHXdjitn
        kO2EPvsMuMC361Nhy1CS2A==
X-Google-Smtp-Source: APXvYqzG3dQHFCuA6ypYHdFZwx9UhmEjXjrpCvFnOpu8YvQ597D8wid4CFtIc1uEUSwyP3Pb43rAkQ==
X-Received: by 2002:a6b:bf87:: with SMTP id p129mr59307174iof.253.1563839788473;
        Mon, 22 Jul 2019 16:56:28 -0700 (PDT)
Received: from localhost ([64.188.179.254])
        by smtp.gmail.com with ESMTPSA id y20sm32775270ion.77.2019.07.22.16.56.27
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Mon, 22 Jul 2019 16:56:27 -0700 (PDT)
Date:   Mon, 22 Jul 2019 17:56:27 -0600
From:   Rob Herring <robh@kernel.org>
To:     Anson.Huang@nxp.com
Cc:     p.zabel@pengutronix.de, robh+dt@kernel.org, mark.rutland@arm.com,
        shawnguo@kernel.org, s.hauer@pengutronix.de, kernel@pengutronix.de,
        festevam@gmail.com, leonard.crestez@nxp.com,
        viresh.kumar@linaro.org, daniel.baluta@nxp.com, ping.bai@nxp.com,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, Linux-imx@nxp.com
Subject: Re: [PATCH V4 1/2] dt-bindings: reset: imx7: Add support for i.MX8MM
Message-ID: <20190722235627.GA3749@bogus>
References: <20190705085406.22483-1-Anson.Huang@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190705085406.22483-1-Anson.Huang@nxp.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri,  5 Jul 2019 16:54:05 +0800, Anson.Huang@nxp.com wrote:
> From: Anson Huang <Anson.Huang@nxp.com>
> 
> i.MX8MM can reuse i.MX8MQ's reset driver, update the compatible
> property and related info to support i.MX8MM.
> 
> Signed-off-by: Anson Huang <Anson.Huang@nxp.com>
> ---
> Changes since V3:
> 	- Add comments to those reset indices to indicate which are NOT supported on i.MX8MM.
> ---
>  .../devicetree/bindings/reset/fsl,imx7-src.txt     |  6 +++--
>  include/dt-bindings/reset/imx8mq-reset.h           | 28 +++++++++++-----------
>  2 files changed, 18 insertions(+), 16 deletions(-)
> 

Reviewed-by: Rob Herring <robh@kernel.org>

Return-Path: <SRS0=BTkm=YO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2B0DECA9EB7
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Oct 2019 10:53:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EAFBC2084C
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Oct 2019 10:53:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1571655185;
	bh=vR9XEaMi7TLXC56PpEUV67so/BvHCnADajU0Dcf+bjc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=VjEYaxmbvrWe3OE48HXf2C6AIZI6QIv7K8NiEMJDOrcu3IFZ7W+jGNAEG8iVChJfU
	 ji7h2clrhFcgr4SbzoBhOG/QwJwDIjCFXHGbinAYuHT0lwYGfPO0QYKKlI/LcIhnml
	 0FnSaaTu79G2ViGBv6QmlLU/F+4DvvR/THU8GnHk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728217AbfJUKxD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 21 Oct 2019 06:53:03 -0400
Received: from mail-ed1-f66.google.com ([209.85.208.66]:36508 "EHLO
        mail-ed1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726767AbfJUKxD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Oct 2019 06:53:03 -0400
Received: by mail-ed1-f66.google.com with SMTP id h2so9655015edn.3;
        Mon, 21 Oct 2019 03:53:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=1TgtWs4DJV+Q7PKm3m20XxcpK+EeU8BJOWEpeeqxE5M=;
        b=uGe9mqCoXb7TLZRTqC7aL2cTHY4se14+w0cwxDoo0HWRf/Vy9xhy1xWR7cjc/x7mk3
         YMzuDDnge/gY4nxTwo5qtFvpAegRhpNG8XFcwjxlboCY0BV442A7KHuo3ufaM8b/GeEF
         MGNpdESC4abNmVX8WA82hCNmGFYvsu/PN8elCC5J8l++kjXC8V315HhdD6oz9vNtbZed
         /9L+ITfDVUYGD9H/pHqKhjV5G2tMysLLVi/2ZpQ9I/PttqvvvHg5M11o9QkBN4FA8CZL
         GCkq5J57I47s+vFKo+2JwbRBqURVr9bHOp4Ww2ihb+PwgPs/dOqsHlaKyoiEBp03tKto
         ZyJQ==
X-Gm-Message-State: APjAAAWNRcPut/SDJMoLEVCeLdWs+7M08TDm5Sv8TVB0cits0TqSpD7S
        uMQe+Hq0J0dxDf/v1n26L7E=
X-Google-Smtp-Source: APXvYqyn3T6TPNnfeaVJZoBwWoGAgZgv5UKwL8hq/5/+A3Y7v6R5GsY3E9ElucI70tnAiJFoFzuFZg==
X-Received: by 2002:a50:ee12:: with SMTP id g18mr23842734eds.114.1571655181681;
        Mon, 21 Oct 2019 03:53:01 -0700 (PDT)
Received: from pi3 ([194.230.155.217])
        by smtp.googlemail.com with ESMTPSA id a3sm594352edk.51.2019.10.21.03.53.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Oct 2019 03:53:01 -0700 (PDT)
Date:   Mon, 21 Oct 2019 12:52:58 +0200
From:   "krzk@kernel.org" <krzk@kernel.org>
To:     Schrempf Frieder <frieder.schrempf@kontron.de>
Cc:     "robh+dt@kernel.org" <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 05/10] ARM: dts: imx6ul-kontron-n6x1x: Add 'chosen' node
 with 'stdout-path'
Message-ID: <20191021105258.GA2089@pi3>
References: <20191016150622.21753-1-frieder.schrempf@kontron.de>
 <20191016150622.21753-6-frieder.schrempf@kontron.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20191016150622.21753-6-frieder.schrempf@kontron.de>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 16, 2019 at 03:07:28PM +0000, Schrempf Frieder wrote:
> From: Frieder Schrempf <frieder.schrempf@kontron.de>
> 
> The Kontron N6x1x SoMs all use uart4 as a debug serial interface.
> Therefore we set in the 'chosen' node.
> 
> Signed-off-by: Frieder Schrempf <frieder.schrempf@kontron.de>
> ---
>  arch/arm/boot/dts/imx6ul-kontron-n6x1x-som-common.dtsi | 6 ++++++
>  1 file changed, 6 insertions(+)

Reviewed-by: Krzysztof Kozlowski <krzk@kernel.org>

Best regards,
Krzysztof


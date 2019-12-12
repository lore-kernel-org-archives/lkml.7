Return-Path: <SRS0=kgnc=2C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 92AB0C2D0C6
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Dec 2019 01:33:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5F20421655
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Dec 2019 01:33:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1576114417;
	bh=aSqr1hJWtMMxzd/mwd+f6S41xyu3LdRpaMI+0ZpCGUc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=fPLtsTEB8qzut/jOAfWru6DdVlEpeXI9TylTFFYtiAckScGE+Isa+VFbwWEBemjCR
	 UiX7JOn/tpTxQHfTWF7xeY8OI0dGTcWusYCMU/JO0q7ryi1pJfmEee7fEYeUOJzlUv
	 bK9Tf6Y4mbcjUmFlU6Z0C2KjvC+sIjLEh8+5uH4w=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727555AbfLLBdg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 11 Dec 2019 20:33:36 -0500
Received: from mail.kernel.org ([198.145.29.99]:41766 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727351AbfLLBdg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Dec 2019 20:33:36 -0500
Received: from dragon (98.142.130.235.16clouds.com [98.142.130.235])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 549D9208C3;
        Thu, 12 Dec 2019 01:33:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1576114415;
        bh=aSqr1hJWtMMxzd/mwd+f6S41xyu3LdRpaMI+0ZpCGUc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=1vpHfeD2zMadp8x5qUWBBf90jxFhkBdc9CaL0TRS1bCzQ1/+U11pfQylXrfw2SK4n
         /bNtLqWf4qaay373ZTwnNwPcKukmOonId+f2uJANg7NOFiJrLwqAPn15lBN/09g+xD
         uHd1y5UKet/dkOYTJDRqjZQM0biLerXEEBMqWtYo=
Date:   Thu, 12 Dec 2019 09:33:24 +0800
From:   Shawn Guo <shawnguo@kernel.org>
To:     Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Philippe Schenker <philippe.schenker@toradex.com>,
        Lucas Stach <l.stach@pengutronix.de>
Subject: Re: linux-next: build failure after merge of the imx-mxs tree
Message-ID: <20191212013323.GZ15858@dragon>
References: <20191212083556.1b98ece7@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191212083556.1b98ece7@canb.auug.org.au>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Stephen,

On Thu, Dec 12, 2019 at 08:35:56AM +1100, Stephen Rothwell wrote:
> Hi all,
> 
> After merging the imx-mxs tree, today's linux-next build (arm
> multi_v7_defconfig) failed like this:

Sorry for the breakage.

> 
> Error: arch/arm/boot/dts/imx6ull-colibri.dtsi:536.4-5 syntax error
> FATAL ERROR: Unable to parse input tree
> make[2]: *** [scripts/Makefile.lib:285: arch/arm/boot/dts/imx6ull-colibri-wifi-eval-v3.dtb] Error 1
> Error: arch/arm/boot/dts/imx6ull-colibri.dtsi:536.4-5 syntax error
> FATAL ERROR: Unable to parse input tree
> make[2]: *** [scripts/Makefile.lib:285: arch/arm/boot/dts/imx6ull-colibri-eval-v3.dtb] Error 1
> arch/arm/boot/dts/imx6qdl-zii-rdu2.dtsi:422.28-424.7: Warning (graph_endpoint): /soc/aips-bus@2100000/i2c@21a0000/edp-bridge@68/ports/port@2/endpoint: graph connection to node '/panel/port/endpoint' is not bidirectional
> arch/arm/boot/dts/imx6qdl-zii-rdu2.dtsi:422.28-424.7: Warning (graph_endpoint): /soc/aips-bus@2100000/i2c@21a0000/edp-bridge@68/ports/port@2/endpoint: graph connection to node '/panel/port/endpoint' is not bidirectional
> 
> Caused by commit
> 
>   e7ebb215cb78 ("ARM: dts: colibri-imx6ull: correct wrong pinmuxing and add comments")
> 
> The warning was (probably) introduced by commit
> 
>   e79295edf1df ("ARM: dts: imx6: RDU2: link eDP bridge to panel")

I have just taken these two commits out.

> 
> I have used the imx-mxs tree from next-20191211 for today.

Thanks.

Shawn

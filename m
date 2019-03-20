Return-Path: <SRS0=4Jrr=RX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0F0A8C43381
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Mar 2019 14:57:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D36B72184E
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Mar 2019 14:57:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1553093877;
	bh=T0v3mC9gcjZco22oC2GtkruAbqGtQdlJ6jnw55IJ6GI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=DBNzfhwahRmtjYl5hRrRDixS4LUAQR3FePlkB44+uLitKBSe5OQQj7nHpULLDPIyI
	 P2Nz1AfR9DtvfpPQFevq/Zjfr9+39KlJDFdnGwaBOupRXoiTUyisWimOswFCzYLnk2
	 oXvkiLuQyIWVyCTB7q44hJDEqtAbgtKjGemwq7T0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728382AbfCTO54 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Mar 2019 10:57:56 -0400
Received: from mail.kernel.org ([198.145.29.99]:54444 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726686AbfCTO54 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Mar 2019 10:57:56 -0400
Received: from dragon (98.142.130.235.16clouds.com [98.142.130.235])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5C0202146E;
        Wed, 20 Mar 2019 14:57:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1553093876;
        bh=T0v3mC9gcjZco22oC2GtkruAbqGtQdlJ6jnw55IJ6GI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Y88DFhQ9w/2i5vAndYVhVq4E68epUb3PVlWKsjHBErQbCu31AVKIf8XjhUsirCatU
         HwmetE+ahbdrIFscyeSGcxqC7ZtjIH+dpzptQcgwN+0VjOmioD5XlHHRlMzqRLOspN
         vtzfhlz0fQfFmgnUDK+D/g9RialJU7LzQxgs4LCA=
Date:   Wed, 20 Mar 2019 22:57:25 +0800
From:   Shawn Guo <shawnguo@kernel.org>
To:     Adam Ford <aford173@gmail.com>
Cc:     arm-soc <linux-arm-kernel@lists.infradead.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        devicetree <devicetree@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 2/3] ARM: DTS: imx6q-logicpd: Reduce inrush current on
 start
Message-ID: <20190320145723.GE8337@dragon>
References: <20190306140402.17122-1-aford173@gmail.com>
 <20190306140402.17122-2-aford173@gmail.com>
 <20190320124446.GO4980@dragon>
 <CAHCN7x+DKh8bR17C90o-zKKnFqWe_Yz5EM68xEiSY0W6ufNARA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHCN7x+DKh8bR17C90o-zKKnFqWe_Yz5EM68xEiSY0W6ufNARA@mail.gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 20, 2019 at 08:41:27AM -0500, Adam Ford wrote:
> On Wed, Mar 20, 2019 at 7:45 AM Shawn Guo <shawnguo@kernel.org> wrote:
> >
> > On Wed, Mar 06, 2019 at 08:04:00AM -0600, Adam Ford wrote:
> > > The main 3.3V regulator sources a series of additional regulators.
> > > This patch adds a small delay, so when the 3.3V regulator comes
> > > on it delays a bit before the subsequent regulators can come on.
> > > This reduces the inrush current a bit on the external DC power
> > > supply.
> > >
> > > Fixes: 1c207f911fe9 ("ARM: dts: imx: Add support for Logic PD
> > > i.MX6QD EVM")
> >
> > Same comment as patch #1.
> 
> The sourcing regulator occasionally cuts out because the inrush is so
> high.  I would argue that preventing a hardware issue like that would
> be a 'fix' and if it helps, I could add that to the description.

Yes, if you would like to get it in as a fix, please elaborate the real
world issue it fixes.

Shawn

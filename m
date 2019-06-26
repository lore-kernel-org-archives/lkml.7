Return-Path: <SRS0=hRvo=UZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7813EC48BD6
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Jun 2019 16:09:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4D242216FD
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Jun 2019 16:09:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=animalcreek.com header.i=@animalcreek.com header.b="Rg7zOvfi";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="1DI51m1d"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726478AbfFZQJh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Jun 2019 12:09:37 -0400
Received: from new4-smtp.messagingengine.com ([66.111.4.230]:48037 "EHLO
        new4-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726320AbfFZQJg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Jun 2019 12:09:36 -0400
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailnew.nyi.internal (Postfix) with ESMTP id 5FE46159D;
        Wed, 26 Jun 2019 12:09:35 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute3.internal (MEProxy); Wed, 26 Jun 2019 12:09:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=animalcreek.com;
         h=date:from:to:cc:subject:message-id:references:mime-version
        :content-type:content-transfer-encoding:in-reply-to; s=mesmtp;
         bh=UP9Jtb98ATwN3hSuXszNgoQd5vNoaG1jrBI+gVsRe+o=; b=Rg7zOvfioVGQ
        bAU/QB7jkqq3sywB0OidJQfTUXkUVo02+sP6Fs9FaUGu2euTFXNw5TVVS76L1D+y
        RSk80oJlaSRXjODpWsDSKsVBYFKaHl6MKQZ/qR4mVlN2um9bGep1nzcPPgcfVhv2
        D+gH1d8OVHNfM8n2DhxPMN3lOY9tbVU=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:content-type
        :date:from:in-reply-to:message-id:mime-version:references
        :subject:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm3; bh=UP9Jtb98ATwN3hSuXszNgoQd5vNoaG1jrBI+gVsRe
        +o=; b=1DI51m1dqlPROi0LYunyNniDnOUUdpwcCrHvUxwwjIB/Vb6BKSZK/X2GN
        K2EpjhcppZOu3UoCen+ySDMqftxM3igLzR3ZZIgW1KZDWqZJfkxyWmCVIyCDmHgP
        JZLgzZU9rHXAMIQz5kHWZPkuvS5LQt6JtF+VCUWT08bB9hafQC9tgdV7r8XM/3c1
        NJkoVMDN3epXGZyO+esZGI6jb7AdM2QSEYwjZ8HWUHAR3VvZDXXYJaU7wOj88xNu
        1rUH2bQYYeI9yWI3Xv7kK28rns5z+zOsMgiSpFK/1X7UK2J8yZN/Z6+DpQJ8Zy6a
        OfgLJVK9ZQhvDyTjQtbYmwgXyrk5A==
X-ME-Sender: <xms:vpgTXbO-LW4RNDxGD7f9wNUWyu34SKdHAR_iz80Er86svLrtiuCraA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduvddrudeigdellecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpeffhffvuffkfhggtggugfgjohgfsehtkeertddtreejnecuhfhrohhmpeforghr
    khcuifhrvggvrhcuoehmghhrvggvrhesrghnihhmrghltghrvggvkhdrtghomheqnecukf
    hppeeikedrvddrkeejrdelheenucfrrghrrghmpehmrghilhhfrhhomhepmhhgrhgvvghr
    segrnhhimhgrlhgtrhgvvghkrdgtohhmnecuvehluhhsthgvrhfuihiivgeptd
X-ME-Proxy: <xmx:vpgTXcejQG_pJqDnTRZCZS63okZImP3YD6svvUH8Q1B__WViFQ3q5g>
    <xmx:vpgTXYSQCJhjfmgebXssCxu1nG0Tw3qaYXqCYHofgFe1ddnwumRBww>
    <xmx:vpgTXSds1ixUKfmqdhW0ly5FMSygZPcodcGFu0K61V2mmzw8aJmAiA>
    <xmx:v5gTXfFaYeZf_KBM2Z5DgejBifD9zi-qk7KBcVvDOVdihrzvfY6RPA>
Received: from blue.animalcreek.com (ip68-2-87-95.ph.ph.cox.net [68.2.87.95])
        by mail.messagingengine.com (Postfix) with ESMTPA id C7E6E8005C;
        Wed, 26 Jun 2019 12:09:33 -0400 (EDT)
Received: by blue.animalcreek.com (Postfix, from userid 1000)
        id 2FFDDA2233F; Wed, 26 Jun 2019 09:09:33 -0700 (MST)
Date:   Wed, 26 Jun 2019 09:09:33 -0700
From:   Mark Greer <mgreer@animalcreek.com>
To:     Christoph Hellwig <hch@lst.de>
Cc:     Mark Greer <mgreer@animalcreek.com>,
        Paul Gortmaker <paul.gortmaker@windriver.com>,
        Dale Farnsworth <dale@farnsworth.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org
Subject: Re: DMA coherency in drivers/tty/serial/mpsc.c
Message-ID: <20190626160933.GA28939@animalcreek.com>
References: <20190625122641.GA4421@lst.de>
 <20190625163722.GA18626@animalcreek.com>
 <20190626064837.GA24531@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20190626064837.GA24531@lst.de>
Organization: Animal Creek Technologies, Inc.
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 26, 2019 at 08:48:37AM +0200, Christoph Hellwig wrote:
> On Tue, Jun 25, 2019 at 09:37:22AM -0700, Mark Greer wrote:
> > Yeah, the mpsc driver had lots of ugly cache related hacks because of
> > cache coherency bugs in the early version of the MV64x60 bridge chips
> > that it was embedded in.  That chip is pretty much dead now and I've
> > removed core support for it from the powerpc tree.  Removing the mpsc
> > driver is on my todo list but I've been busy and lazy.  So, to sum it
> > up, don't spend any more time worrying about it as it should be removed.
> > 
> > I'll post a patch to do that tonight and I'm sorry for any time you've
> > spent looking at it so far.
> 
> No problem.  And if future such broken chips show up we now have
> support for per-device DMA coherency settings and could actually
> handle it in a reaѕonably clean way.

Ah, good to know - thanks.

BTW, I just submitted a patch to remove the driver.

Mark
--

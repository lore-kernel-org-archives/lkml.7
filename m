Return-Path: <SRS0=CEgE=VT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4D48AC76190
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Jul 2019 14:23:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1D37820449
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Jul 2019 14:23:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1563805384;
	bh=cmeknv+ms+SGcXgCwrtlqmuRDH1GTIq39zwqMIJiiXo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=TWtF+8bxpwuyFVCJlZZatkOonrigJ41tN8RLy8aXFWFw56ePnuKRc+MQCnOGp8A5i
	 JRFqlKFHf/Y2gywWqSP7JeAyURGsFz7sTDi8ano/VRyNlmF45X4H3Hn6P9uqcjwTHE
	 MZSQAkeAu5HIgkBQaRaGQBPG1pWkifHQVqaseqs8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730670AbfGVOXD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 22 Jul 2019 10:23:03 -0400
Received: from mail.kernel.org ([198.145.29.99]:54180 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728083AbfGVOXC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Jul 2019 10:23:02 -0400
Received: from localhost (unknown [223.226.98.106])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 24CC2217D6;
        Mon, 22 Jul 2019 14:23:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1563805381;
        bh=cmeknv+ms+SGcXgCwrtlqmuRDH1GTIq39zwqMIJiiXo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=zAewChpdqo3yoTZoj5XSDwyLeuv1n5gaKyp4cDy0ltGITn+FHZ0MpF8OK+fz3nihW
         +vPDYEMZ46I9chAcK0gBR2BzCmVnnaGfnAlx6SC43iEPJJGHPjAImLjqLEPHoTFO4p
         G8CY35nRdFh95P1EArFDL4KcrOuDAC/kHgdlyb6U=
Date:   Mon, 22 Jul 2019 19:51:49 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     Gustavo Pimentel <gustavo.pimentel@synopsys.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Russell King <rmk+kernel@armlinux.org.uk>,
        Joao Pinto <jpinto@synopsys.com>, dmaengine@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/3] [v2] dmaengine: dw-edma: fix unnecessary stack usage
Message-ID: <20190722142149.GU12733@vkoul-mobl.Dlink>
References: <20190722124457.1093886-1-arnd@arndb.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190722124457.1093886-1-arnd@arndb.de>
User-Agent: Mutt/1.11.3 (2019-02-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 22-07-19, 14:44, Arnd Bergmann wrote:
> Putting large constant data on the stack causes unnecessary overhead
> and stack usage:
> 
> drivers/dma/dw-edma/dw-edma-v0-debugfs.c:285:6: error: stack frame size of 1376 bytes in function 'dw_edma_v0_debugfs_on' [-Werror,-Wframe-larger-than=]
> 
> Mark the variable 'static const' in order for the compiler to move it
> into the .rodata section where it does no such harm.

Applied all, thanks

Please do note the link was pointing to older rev, I have updated them
to this revision.

-- 
~Vinod

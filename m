Return-Path: <SRS0=xa+R=Y4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1691BCA9EB5
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Nov 2019 14:32:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DD4E221D7D
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Nov 2019 14:32:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1572877940;
	bh=0ENEPJRxHYImUF1CtW2GanU1wL7Gpw0hrwnmI/y9upI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=MWJnEA4vc9zT0h3P4Z++qur0IUMFOZBTlpAPd1/z7tzx3bNGyhS/ELg9Zwin/YBSB
	 c6+TI16RcN2z30BeFhNVhYzb+OSotGldrOUfvka9ftPssveYv87mRi0pFWE9QOAnF0
	 4KfMD3LF4EpXL3jRpeXDp85t+OX4QrBPXiPE2XKg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728806AbfKDOcU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 Nov 2019 09:32:20 -0500
Received: from mail.kernel.org ([198.145.29.99]:46014 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728683AbfKDOcT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Nov 2019 09:32:19 -0500
Received: from localhost (unknown [62.119.166.9])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 815AF21D71;
        Mon,  4 Nov 2019 14:32:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1572877938;
        bh=0ENEPJRxHYImUF1CtW2GanU1wL7Gpw0hrwnmI/y9upI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=XrhXtgtPN6QSS4XSLXhTP/e6sx9fYrzdi1MQibtX50Gp3mPs+Yb6LEPHOdxq1EoP/
         0RKqxjOFb1Fe7+d/8Scmv81ag/NVkxe0EPfhQVss5Szi+crnaI7EPlHOTKURoMTvxc
         O96jjyN0VAL2fImgfeRMAJw+42/MpcTqmeCXp5Jk=
Date:   Mon, 4 Nov 2019 15:31:57 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Mika Westerberg <mika.westerberg@linux.intel.com>
Cc:     linux-usb@vger.kernel.org,
        Andreas Noever <andreas.noever@gmail.com>,
        Michael Jamet <michael.jamet@intel.com>,
        Yehezkel Bernat <YehezkelShB@gmail.com>,
        Rajmohan Mani <rajmohan.mani@intel.com>,
        Nicholas Johnson <nicholas.johnson-opensource@outlook.com.au>,
        Lukas Wunner <lukas@wunner.de>,
        Alan Stern <stern@rowland.harvard.edu>,
        Mario.Limonciello@dell.com,
        Anthony Wong <anthony.wong@canonical.com>,
        Oliver Neukum <oneukum@suse.com>,
        Christian Kellner <ckellner@redhat.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 00/25] thunderbolt: Add support for USB4
Message-ID: <20191104143157.GA2183186@kroah.com>
References: <20191023112154.64235-1-mika.westerberg@linux.intel.com>
 <20191101114318.GO2593@lahna.fi.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191101114318.GO2593@lahna.fi.intel.com>
User-Agent: Mutt/1.12.2 (2019-09-21)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 01, 2019 at 01:43:18PM +0200, Mika Westerberg wrote:
> On Wed, Oct 23, 2019 at 02:21:29PM +0300, Mika Westerberg wrote:
> > Mika Westerberg (22):
> >   thunderbolt: Introduce tb_switch_is_icm()
> >   thunderbolt: Log switch route string on config read/write timeout
> >   thunderbolt: Log error if adding switch fails
> >   thunderbolt: Convert basic adapter register names to follow the USB4 spec
> >   thunderbolt: Convert PCIe adapter register names to follow the USB4 spec
> >   thunderbolt: Convert DP adapter register names to follow the USB4 spec
> >   thunderbolt: Make tb_sw_write() take const parameter
> >   thunderbolt: Add helper macro to iterate over switch ports
> >   thunderbolt: Refactor add_switch() into two functions
> >   thunderbolt: Add support for lane bonding
> >   thunderbolt: Add default linking between lane adapters if not provided by DROM
> >   thunderbolt: Expand controller name in tb_switch_is_xy()
> >   thunderbolt: Add downstream PCIe port mappings for Alpine and Titan Ridge
> >   thunderbolt: Add Display Port CM handshake for Titan Ridge devices
> >   thunderbolt: Add Display Port adapter pairing and resource management
> >   thunderbolt: Add bandwidth management for Display Port tunnels
> >   thunderbolt: Do not start firmware unless asked by the user
> >   thunderbolt: Make tb_find_port() available to other files
> >   thunderbolt: Call tb_eeprom_get_drom_offset() from tb_eeprom_read_n()
> >   thunderbolt: Add initial support for USB4
> >   thunderbolt: Update Kconfig entry to USB4
> >   thunderbolt: Update documentation with the USB4 information
> > 
> > Rajmohan Mani (3):
> >   thunderbolt: Make tb_switch_find_cap() available to other files
> >   thunderbolt: Add support for Time Management Unit
> >   thunderbolt: Add support for USB 3.x tunnels
> > 
> 
> I queued patches 1-17 for v5.5. I'll leave the rest of USB4 patches to
> cook for a while and hopefully we can get them in for v5.6.

No objection from me, nice work!

greg k-h

Return-Path: <SRS0=PjNn=RI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C7561C43381
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Mar 2019 17:31:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 63A0620661
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Mar 2019 17:31:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="tWl3OtUc"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728256AbfCERb0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 5 Mar 2019 12:31:26 -0500
Received: from pandora.armlinux.org.uk ([78.32.30.218]:46614 "EHLO
        pandora.armlinux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726120AbfCERbW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Mar 2019 12:31:22 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=armlinux.org.uk; s=pandora-2019; h=Sender:Content-Type:MIME-Version:
        Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-Transfer-Encoding:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=NtBcnjSm0T7KhO3ATpEfCz8Tr1Odp+WUtOVD7jNdUOo=; b=tWl3OtUcsU9r/D5gkDlEzGZjS
        SKAqJF8yd7+gMtk2mhE6MU8mb3/Cb4hG82V0e9Gh169qKKEat6VTWQUq/11+9WR9K7DlBt2tL9T8X
        CKG+QIPdI560+yG6D35meAhyvnAf/dwV25wPIkzIKhZzRxx5ecgRk45yE33j5Plq+HxQccWs6WEeu
        6DjwzdoWq7bmXNN8sHzkJMI1oLTn33oS5/ZFBMnFFLmVhJ8g2ynz+wPCNzJIepnOlMh9M3Kol8bmC
        oa2Uwug/oNqfXb9DJBqvg4PGltiqk9I9SYAOVlaqdmvnxSNS+M9op9FwrxX0l/a4HbCWqPZCjv//i
        XQtAMkb0A==;
Received: from shell.armlinux.org.uk ([2002:4e20:1eda:1:5054:ff:fe00:4ec]:37262)
        by pandora.armlinux.org.uk with esmtpsa (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.90_1)
        (envelope-from <linux@armlinux.org.uk>)
        id 1h1DuP-0002ad-EY; Tue, 05 Mar 2019 17:31:17 +0000
Received: from linux by shell.armlinux.org.uk with local (Exim 4.89)
        (envelope-from <linux@shell.armlinux.org.uk>)
        id 1h1DuK-0003NW-45; Tue, 05 Mar 2019 17:31:12 +0000
Date:   Tue, 5 Mar 2019 17:31:12 +0000
From:   Russell King - ARM Linux admin <linux@armlinux.org.uk>
To:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     Lucas Stach <l.stach@pengutronix.de>,
        Peng Hao <peng.hao2@zte.com.cn>,
        Mark Rutland <mark.rutland@arm.com>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Smarter Kconfig help
Message-ID: <20190305173111.t3n6ycktht7kxuhq@shell.armlinux.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Guys,

We need to be smarter when writing Kconfig help.  I'm just going
through updating my build trees with the results of 5.0 development,
and a number of the help texts are next to useless.  For example,

PVPANIC - is this something that should be enabled for a host or
guest kernel?  Answer: you have to read the driver code to find out.

IMX_IRQSTEER - which i.MX SoCs does this apply to?  The help text
just says:

  "Support for the i.MX IRQSTEER interrupt multiplexer/remapper."

which doesn't say which SoCs this should be enabled for - it turns
out that grepping for the driver's DT compatible string, none of
the 32-bit ARM cores have support for this, yet we still default
it to enabled there.  It seems the help text should at the very
least tell the user that this is not applicable to i.MX SoCs with
32-bit ARM cores.

I'm sure there's many other instances of this... I suspect that
it's caused by review concentrating mostly on the technical aspects
of the code and the Kconfig help text just gets forgotten about.

Can we at least improve these two options please?

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTC broadband for 0.8mile line in suburbia: sync at 12.1Mbps down 622kbps up
According to speedtest.net: 11.9Mbps down 500kbps up

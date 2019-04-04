Return-Path: <SRS0=oHH8=SG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_NEOMUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A676EC4360F
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Apr 2019 10:35:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 443E020820
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Apr 2019 10:35:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="zJcjMBJC"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729253AbfDDKf1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Apr 2019 06:35:27 -0400
Received: from pandora.armlinux.org.uk ([78.32.30.218]:48476 "EHLO
        pandora.armlinux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728818AbfDDKf1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Apr 2019 06:35:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=armlinux.org.uk; s=pandora-2019; h=Sender:Content-Type:MIME-Version:
        Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-Transfer-Encoding:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=WYVH4ZnI/cOZDsP8P2C9NKGb4KWltKeucjUrOFeo1Io=; b=zJcjMBJCEZ42voZPEGAJTb2Xo
        ctCc4YI+K+NA1z/4q5EalSXM1UpVrRijgjABBQpxnDRB89MBuZ42cjSUtXMvgLUL+xSH8iuxRo2db
        hHJuO49LuTMGzVFhKAqmvbK1HvwodOnWTjCSZtqy37yz9OMEeVGErfIKxQBkNATs6g5AFXqO2KtPr
        QzGwSJ0kDTA7i4YqMhkDrEVRizp4BTWgv+qiW+d9VcB/dDV1J5acE7Cr4SSx8uRjwUr/MdnxjuXxu
        120neIwPwOiFkp1g0rZ83cGjRqZAxv2WXiV0G6tYiEFXZhe765cNj2OS/0wdbiPz3XHxRpuqfOV6l
        1eC4RhTXQ==;
Received: from shell.armlinux.org.uk ([2001:4d48:ad52:3201:5054:ff:fe00:4ec]:55310)
        by pandora.armlinux.org.uk with esmtpsa (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.90_1)
        (envelope-from <linux@armlinux.org.uk>)
        id 1hBziN-0001GQ-Mv; Thu, 04 Apr 2019 11:35:23 +0100
Received: from linux by shell.armlinux.org.uk with local (Exim 4.89)
        (envelope-from <linux@shell.armlinux.org.uk>)
        id 1hBziL-0005mv-Ge; Thu, 04 Apr 2019 11:35:21 +0100
Date:   Thu, 4 Apr 2019 11:35:21 +0100
From:   Russell King - ARM Linux admin <linux@armlinux.org.uk>
To:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     Matthew Wilcox <willy@infradead.org>,
        Ben Dooks <ben-linux-arm@fluff.org>,
        Stuart Swales <stuart.swales.croftnuisk@gmail.com>
Subject: fs/adfs - keep or kill it?
Message-ID: <20190404103521.pklwk4efp2zccjzc@shell.armlinux.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Recently, a couple of issues have been identified in fs/adfs:

1. Filename truncation may not work as it should, and Linus has
   apparently expressed a desire to kill this off.

2. Scanning the ADFS map for disc object fragments may mistakenly
   find free space fragments in addition to real disc object fragments,
   leading to chunks of free space appearing in files or directories.

No one has reported any issues with the filesystem module, so the
question has to be asked whether there are any users of this code?

I'm aware that there were some users about ten or more years ago.  I've
only touched it when problems have been reported to me that needed me
to investigate something, otherwise I haven't used it myself - so the
code largely just sits there, mostly untouched except for the odd
cross-filesystem patch.

The last "feature" patch was in 2011 by Stuart Swales (copied) adding
the filetype suffix to filenames.

That leads on to the question about whether this should be fixed in
mainline or whether we should put the code out of its misery and remove
it from the kernel.

Fixing both issues is fairly trivial, and I already have some fixes
available, along with some improvements to the rest of the code.
However, I see little point in pushing that upstream if the code is
not being used.

Searching the web, there does seem to be some interest on some forums,
but that dates from about three years ago, but it also seems that more
functional solutions (using fuse, with different format support) are
available.

Posting to Linux lists probably isn't the best way to find out whether
there are users of this, so if there are people involved in the Acorn
communities, please pass this on to more appropriate forums, thanks.
Please ensure that replies reach me as I don't monitor random web
forums for example (a reply on a web forum that I don't see is not
helpful.)

If I hear nothing positive towards keeping it, then I'll schedule
fs/adfs for deletion, probably for 5.3.

Thanks.

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTC broadband for 0.8mile line in suburbia: sync at 12.1Mbps down 622kbps up
According to speedtest.net: 11.9Mbps down 500kbps up

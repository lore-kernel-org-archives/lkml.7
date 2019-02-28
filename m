Return-Path: <SRS0=g5d9=RD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6BFFBC43381
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Feb 2019 14:17:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 38D00214D8
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Feb 2019 14:17:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="eIIytkDc"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732506AbfB1ORJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Feb 2019 09:17:09 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:39954 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728092AbfB1ORJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Feb 2019 09:17:09 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=TLQHLE9rRd13OypqLRwJDvPJOba+66nl6LBftU+TYok=; b=eIIytkDcPIojBLcO7XkyjwDYP
        kNqHAmHb+9JnwHrtHkc/kal8f+HCFzDRZ7zgkIWCrt045p6U+dbv9sl4AqMpomzVcbMAPok3Zt5MC
        5c5rLCA0qRPRCWXoRWIqM7sMU74EIGTr/pga/DZ9KhTa6rYth3cTCsAn9Yq5Rco1wnNyL8gr73WEv
        l44LKnzFCa01CZ7M7EK6Y3CjDmcfd+TRXcws88dIfhaqSoqOnxZ+UYjo1wcYFI1QzG9HnzqWOllU+
        VdZ8IOqlW8TEUGLosvGIjBZV6HPU9kXFe9Y/kulZuNtm15s5vGfBw6lvJhuLtxNWaZB1Hg/OojW2N
        Is9deVdzA==;
Received: from hch by bombadil.infradead.org with local (Exim 4.90_1 #2 (Red Hat Linux))
        id 1gzMUa-0006Lp-0K; Thu, 28 Feb 2019 14:16:56 +0000
Date:   Thu, 28 Feb 2019 06:16:55 -0800
From:   Christoph Hellwig <hch@infradead.org>
To:     Austin.Bolen@dell.com
Cc:     Alex_Gagniuc@Dellteam.com, torvalds@linux-foundation.org,
        keith.busch@intel.com, sagi@grimberg.me,
        linux-kernel@vger.kernel.org, linux-nvme@lists.infradead.org,
        axboe@fb.com, mr.nuke.me@gmail.com, hch@lst.de,
        jonathan.derrick@intel.com
Subject: Re: [PATCH] nvme-pci: Prevent mmio reads if pci channel offline
Message-ID: <20190228141655.GA18319@infradead.org>
References: <CAHk-=wjmjHyovjtzaq=HSegEpiO2SXWaYfJ6qsJrZhXg_YSx5g@mail.gmail.com>
 <2b7d8f45d11c47e69f56ad1bc3324dd1@ausx13mps321.AMER.DELL.COM>
 <CAHk-=wg_e5M0b5aJJf8V_UYaqX12YYA9MEg=gHNp6ALE5fK23w@mail.gmail.com>
 <cbe2ed1562a64609be6538f5816ec1b6@ausx13mps321.AMER.DELL.COM>
 <20190225155501.GI10237@localhost.localdomain>
 <b35ebf928ed743cca6649a191c76957b@ausx13mps321.AMER.DELL.COM>
 <CAHk-=wgRdATtsBzo-LDkWn_sW-PJvq95SahZcsTxxDMPzLWxKA@mail.gmail.com>
 <940d608e1a044a54abcb9d65923951f3@ausx13mps317.AMER.DELL.COM>
 <f6704855445b44639f023a48f3003309@AUSX13MPC131.AMER.DELL.COM>
 <443262761d0e41fbb46a46dab28759c2@AUSX13MPC131.AMER.DELL.COM>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <443262761d0e41fbb46a46dab28759c2@AUSX13MPC131.AMER.DELL.COM>
User-Agent: Mutt/1.9.2 (2017-12-15)
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 27, 2019 at 08:04:35PM +0000, Austin.Bolen@dell.com wrote:
> Confirmed this issue does not apply to the referenced Dell servers so I 
> don't not have a stake in how this should be handled for those systems. 
> It may be they just don't support surprise removal.  I know in our case 
> all the Linux distributions we qualify (RHEL, SLES, Ubuntu Server) have 
> told us they do not support surprise removal.  So I'm guessing that any 
> issues found with surprise removal could potentially fall under the 
> category of "unsupported".
> 
> Still though, the larger issue of recovering from other types of PCIe 
> errors that are not due to device removal is still important.  I would 
> expect many system from many platform makers to not be able to recover 
> PCIe errors in general and hopefully the new DPC CER model will help 
> address this and provide added protection for cases like above as well.

FYI, a related issue I saw about a year two ago with Dell servers was
with a dual ported NVMe add-in (non U.2) card, is that once you did
a subsystem reset, which would cause both controller to retrain the link
you'd run into Firmware First error handling issue that would instantly
crash the system.  I don't really have the hardware anymore, but the
end result was that I think the affected product ended up shipping
with subsystem resets only enabled for the U.2 form factor.

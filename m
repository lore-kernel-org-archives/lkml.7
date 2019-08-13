Return-Path: <SRS0=Ecng=WJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8E359C32750
	for <linux-kernel@archiver.kernel.org>; Tue, 13 Aug 2019 07:29:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5E02620663
	for <linux-kernel@archiver.kernel.org>; Tue, 13 Aug 2019 07:29:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="uMn/U8H3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727729AbfHMH35 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 13 Aug 2019 03:29:57 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:60556 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726789AbfHMH34 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Aug 2019 03:29:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=JDyPbXOL4+Scz6VgjAtsI+naStzvCwRDzpVpMAFBAHI=; b=uMn/U8H3zrIV2tIc9UgLlEve5
        fJhfGhmoEMI9c084C4eKIpHD1on8+nX6WMXnoHs8vZ0V9uUGZIHln8bPsE8XUSH2lmAriApxAo4b3
        xMpQEU8yXhDa+1JuhUh090/Lu5N80OU089VA+4f6KrkwsV9Ajtfzox2HocIV72EnGZLePpH5+crlM
        R8E9cBn7HVWmAlkg8czmhpsFZepRYQGtwheFpIhHFZXSrT3Pz2Cjq8SK9XWJ8mZm7lOs3LefMTKdy
        F6pibnazFCFvuUiv8q1KZlPzUKbiccrQ4i95E1YVU1zOmLB8FkiXgQNKZ1Lyj1Etupc4tgSoLyCiw
        AOPuyzdAg==;
Received: from hch by bombadil.infradead.org with local (Exim 4.92 #3 (Red Hat Linux))
        id 1hxRFi-0008Cd-5S; Tue, 13 Aug 2019 07:29:54 +0000
Date:   Tue, 13 Aug 2019 00:29:54 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Dan Williams <dan.j.williams@intel.com>
Cc:     Christoph Hellwig <hch@infradead.org>,
        Stephen Douthit <stephend@silicom-usa.com>,
        Jens Axboe <axboe@kernel.dk>,
        "linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] ata: ahci: Lookup PCS register offset based on PCI
 device ID
Message-ID: <20190813072954.GA23417@infradead.org>
References: <20190808202415.25166-1-stephend@silicom-usa.com>
 <20190810074317.GA18582@infradead.org>
 <abfa4b20-2916-d89a-f4d3-b27fca5906b2@silicom-usa.com>
 <CAPcyv4g+PdbisZd8=FpB5QiR_FCA2OQ9EqEF9yMAN=XWTYXY1Q@mail.gmail.com>
 <051cb164-19d5-9241-2941-0d866e565339@silicom-usa.com>
 <20190812180613.GA18377@infradead.org>
 <CAA9_cme3saBAJEyob3B1tX=t8keTodWJZMUd1j_v7vPMRU+aXA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAA9_cme3saBAJEyob3B1tX=t8keTodWJZMUd1j_v7vPMRU+aXA@mail.gmail.com>
User-Agent: Mutt/1.11.4 (2019-03-13)
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 12, 2019 at 12:31:35PM -0700, Dan Williams wrote:
> It seems platforms / controllers that fail to run the option-rom
> should be quirked by device-id, but the PCS register twiddling be
> removed for everyone else. "Card BIOS" to me implies devices with an
> Option-ROM BAR which I don't think modern devices have, so that might
> be a simple way to try to phase out this quirk going forward without
> regressing working setups that might be relying on this.
> 
> Then again the driver is already depending on the number of enabled
> ports to be reliable before PCS is written, and the current driver
> does not attempt to enable ports that were not enabled previously.
> That tells me that if the PCS quirk ever mattered it would have
> already regressed when the driver switched from blindly writing 0xf to
> only setting the bits that were already set in ->port_map.

But how do we find that out?

A compromise to me seems that we just do the PCS quirk for all Intel
devices explicitly listed in the PCI Ids based on new board_* values
as long as they have the old PCS location, and assume anything new
enough to have the new location won't need to quirk, given that it
never properly worked.  This might miss some intel devices that were
supported with the class based catchall, though.

Return-Path: <SRS0=OvUS=X5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CBA9AC47404
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Oct 2019 09:12:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 77721215EA
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Oct 2019 09:12:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="UxFVRJC5"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731200AbfJDJM2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 4 Oct 2019 05:12:28 -0400
Received: from pandora.armlinux.org.uk ([78.32.30.218]:56548 "EHLO
        pandora.armlinux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730350AbfJDJM2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Oct 2019 05:12:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=qtILDKeXE+NCWyeY17J+cqlMaH7cJ64zwiZoTKzK//c=; b=UxFVRJC5SVp6RefPuhEn6OkIb
        ZoCa7/ug258G0mGIdFg3KwWzhohmWmqewT5hV4i/PEddZI7ERhiLfwJ2vOUqMohrz2GnwYTr//+nn
        9ySEqyKpm1VlmQJJikR8lJJBWk+V5rD5yoDDdOXQ1dnQVDEdbWjo6/f4yOkl35aF+cbuvQFvXriQT
        wOVHlRINtBS5/mwtcxdSQfS6oDjE8jE/gxqW/LR5rkcMAmhIA63kq/ct61ue6pIrvW8PSFlEfjhgz
        WgHQi6WayK1YcbHfrOsoIDd11aSLdOrn4ZCYqt0r/4TcOJTYNhMe+C7hbBNbrfifDGsMXHix4xc3v
        HSsqSLyFg==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:51566)
        by pandora.armlinux.org.uk with esmtpsa (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.90_1)
        (envelope-from <linux@armlinux.org.uk>)
        id 1iGJdL-0003GJ-Mr; Fri, 04 Oct 2019 10:12:19 +0100
Received: from linux by shell.armlinux.org.uk with local (Exim 4.92)
        (envelope-from <linux@shell.armlinux.org.uk>)
        id 1iGJdG-0002eU-9X; Fri, 04 Oct 2019 10:12:14 +0100
Date:   Fri, 4 Oct 2019 10:12:14 +0100
From:   Russell King - ARM Linux admin <linux@armlinux.org.uk>
To:     Chris Healy <cphealy@gmail.com>
Cc:     Mike Rapoport <rppt@linux.ibm.com>, Adam Ford <aford173@gmail.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        The etnaviv authors <etnaviv@lists.freedesktop.org>,
        Linux Memory Management List <linux-mm@kvack.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Fabio Estevam <festevam@gmail.com>,
        Christoph Hellwig <hch@lst.de>,
        arm-soc <linux-arm-kernel@lists.infradead.org>,
        Lucas Stach <l.stach@pengutronix.de>
Subject: Re: [PATCH v2 00/21] Refine memblock API
Message-ID: <20191004091214.GW25745@shell.armlinux.org.uk>
References: <20190926160433.GD32311@linux.ibm.com>
 <CAHCN7xL1sFXDhKUpj04d3eDZNgLA1yGAOqwEeCxedy1Qm-JOfQ@mail.gmail.com>
 <20190928073331.GA5269@linux.ibm.com>
 <CAHCN7xJEvS2Si=M+BYtz+kY0M4NxmqDjiX9Nwq6_3GGBh3yg=w@mail.gmail.com>
 <CAHCN7xKLhWw4P9-sZKXQcfSfh2r3J_+rLxuxACW0UVgimCzyVw@mail.gmail.com>
 <20191002073605.GA30433@linux.ibm.com>
 <CAHCN7xL1MkJh44N3W_1+08DHmX__SqnfH6dqUzYzr2Wpg0kQyQ@mail.gmail.com>
 <20191003053451.GA23397@linux.ibm.com>
 <20191003084914.GV25745@shell.armlinux.org.uk>
 <CAFXsbZrLkjsda8oM4SG6LOpfu7a=vwJ7eGM-FL8dzCKb0yzy5w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAFXsbZrLkjsda8oM4SG6LOpfu7a=vwJ7eGM-FL8dzCKb0yzy5w@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 03, 2019 at 07:46:06AM -0700, Chris Healy wrote:
> >
> > The iMX6 does not have MMUv2 hardware, it has MMUv1.  With MMUv1
> > hardware requires command buffers within the first 2GiB of physical
> > RAM.
> >
> I thought that the i.MX6q has the MMUv1 and GC2000 GPU while the
> i.MX6qp has the MMUv2 and GC3000?  Meaning the i.MX6 has both MMUv1
> and MMUv2 depending on which i.MX6 part we are talking about.

The report says iMX6Q with GC2000 - which is what I was referring to
here.  I'm not aware of what the later SoCs use, since I've never used
them.

Thanks.

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTC broadband for 0.8mile line in suburbia: sync at 12.1Mbps down 622kbps up
According to speedtest.net: 11.9Mbps down 500kbps up

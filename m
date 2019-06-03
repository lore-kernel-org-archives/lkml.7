Return-Path: <SRS0=cV2B=UC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7D749C04AB5
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Jun 2019 22:59:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4781526A6E
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Jun 2019 22:59:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="U6ZHS++b"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726547AbfFCW74 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Jun 2019 18:59:56 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:37432 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726102AbfFCW74 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Jun 2019 18:59:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=Zh2rbwzJtCS0hdh0iU79UP0L/f138/RqU/9B02MMUPo=; b=U6ZHS++bQ07fcxKbuvFYpWDCS
        BVG48d/I0fYPuJ8P3Yrs3xEXLj0eqwHDsplk/Uddbus88I8g32FU4ckATqQ7JFYPL+4wTNaR6+NYh
        +UTl4NyGzlZaA93py2Syrr/JOK8gskrKjpnyuIKr+XWFc41jTJZ+S3/jnYOZe9qeydTK9BlpThlEp
        bRdCx+AoeTAGYOiy1bY3vH60Icpo5ZFtsQ+4rN6f/5+F/yU8QBGD70h6eGvE3lRJ7/DvxX0/YaVPq
        l1mgttK/MDncXc8N0maQ2jUzTLjJIfZCLnRGp0ktoMxfeXaIkl3DQBa0p1ZoZstOHn/p9DH5+tmEE
        fIdKiG/ww==;
Received: from willy by bombadil.infradead.org with local (Exim 4.90_1 #2 (Red Hat Linux))
        id 1hXvvm-0000GP-NA; Mon, 03 Jun 2019 22:59:54 +0000
Date:   Mon, 3 Jun 2019 15:59:54 -0700
From:   Matthew Wilcox <willy@infradead.org>
To:     Dave Hansen <dave.hansen@intel.com>
Cc:     Stephen Rothwell <sfr@canb.auug.org.au>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: linux-next: runtime failure of next-20190603
Message-ID: <20190603225954.GD23346@bombadil.infradead.org>
References: <20190603162215.6390707f@canb.auug.org.au>
 <a6c98d75-078a-797f-a582-9687324e8c02@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a6c98d75-078a-797f-a582-9687324e8c02@intel.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 03, 2019 at 02:07:26PM -0700, Dave Hansen wrote:
> On 6/2/19 11:22 PM, Stephen Rothwell wrote:
> > My qemu powerpc_pseries_le_defconfig boots failed today with the
> > following output at shutdown time:
> ...
> > [   32.112430] NIP [c000000000bbeb38] xas_load+0x8/0xd0
> ...
> > Reverting commit
> > 
> > fa858b6eec3f ("XArray: Add xas_replace")
> > 
> > made the failure go away.
> 
> I'm seeing a similar softlockup:

I've taken that commit out of my xarray tree.  It's only a performance
optimisation, so I don't mind dropping it until it's debugged.


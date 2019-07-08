Return-Path: <SRS0=4ODY=VF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BAB11C606BD
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Jul 2019 18:45:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8CD9221874
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Jul 2019 18:45:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="B2yWPiAU"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732494AbfGHSpv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Jul 2019 14:45:51 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:52282 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728109AbfGHSpu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Jul 2019 14:45:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=fDTsx57A5ljyef/Z0ObEceBOWN7WpuZYSRjbJ+qHv1c=; b=B2yWPiAUb+yf9SLWpl5bLJBQF
        SZqDjuKnAXTB/CVlfY7qFVDAMEbrKhNQuFf2TFOWnjTybHm4qKwSfUIfly864W/tg+zyMcB6a4bn4
        YcV5FeDI3a8MsDHV7AFKSNYXswgVQt/TKecNpc1QX29RHInTk99aepyiugbVKUjrXnc2ryYSykW38
        xo8kgC7/lN0I/MlZ800pDLZaqaTDu29t8XazzquPo7xXy5DFK48q951HQqs6lQzPFQUljCD52gXFt
        qt42jy7TRqVhb6HE+jfuaVeWXoWk77h93wfW0XhEzHoDtvnaHeMwB1Z/ZbrgxBI7AcfQJPqx8tQc3
        QeppdfzFg==;
Received: from hch by bombadil.infradead.org with local (Exim 4.92 #3 (Red Hat Linux))
        id 1hkYe2-0007Qu-MT; Mon, 08 Jul 2019 18:45:46 +0000
Date:   Mon, 8 Jul 2019 11:45:46 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Loic PALLARDY <loic.pallardy@st.com>
Cc:     Christoph Hellwig <hch@infradead.org>,
        Clement Leger <cleger@kalray.eu>,
        Ohad Ben-Cohen <ohad@wizery.com>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        "linux-remoteproc@vger.kernel.org" <linux-remoteproc@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2] remoteproc: copy parent dma_pfn_offset for vdev
Message-ID: <20190708184546.GA20670@infradead.org>
References: <20190612095521.4703-1-cleger@kalray.eu>
 <20190701070245.32083-1-cleger@kalray.eu>
 <20190702132229.GA8100@infradead.org>
 <58c8b8bd30a949678c027eb42a1b1bbb@SFHDAG7NODE2.st.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <58c8b8bd30a949678c027eb42a1b1bbb@SFHDAG7NODE2.st.com>
User-Agent: Mutt/1.11.4 (2019-03-13)
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 02, 2019 at 03:36:56PM +0000, Loic PALLARDY wrote:
> Agree there is definitively an issue with the way virtio device are defined.
> Today definition is based on rproc firmware ressource table and rproc 
> framework is in charge of vdev creation.
> Device tree definition was discarded as vdev is not HW but SW definition.

Well, it appears to be a firmware interface description.

> One solution would be to associate both resource table (which provides
> Firmware capabilities) and some virtio device tree nodes (declared as sub nodes
> of remote processor with associated resources like memory carveout).
> When we have a match between resource table and rproc DT sub node, we
> can register virtio device via of_platform_populate.
> Then need to adapt virtio_rpmsg or to create a virtio_rproc to be DT probe compliant
> like virtio_mmio is.
> 
> But that's breaking legacy as all platforms will have to add a virtio device node in
> their DT file...
> 
> Is it aligned with your view ?

Yes, that is how I'd assume it works.  But given that until recently
you did now have these subdevices for dma coherent purposes we can't
really break anything older than that, so I might still be missing
something.

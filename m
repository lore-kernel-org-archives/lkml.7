Return-Path: <SRS0=3iFO=VV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3FC2BC7618B
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jul 2019 10:00:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 11BBB229F3
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jul 2019 10:00:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="ZZcd7Ka0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726830AbfGXKAc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Jul 2019 06:00:32 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:40254 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726300AbfGXKAc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Jul 2019 06:00:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=/MAFxUXpNzbi4KjfrTLt3NyDxXRqZOCjaS3pKnzg3rU=; b=ZZcd7Ka0dorUDDVUfi1UN4o90
        ehVjn6m3vk7MR8Ua7fhH+bVC3Zlb1KGryiDONAa8oLUk8nB9/sTDkh0Y2kNacQmbcSIm2TBnySXRr
        okBBjJe5S4tOwVJxq07I/I/BvjqhYxDmsXxaAorTlC6dAUG3Bg/DbcKevXJn12r+6/7THzEVZ/Sem
        V9pwTBvi1nvgWUPttOJLeOwhK/aZphrhxqjXRjPN5FNtxHfTbfuxNRAmbtqWh7SG0lPzgsIj46zY3
        J2pwtxrHDmAIyWdEwrswzselJRaRh4Cy5Ad05+oNkzxyD9g614WCLy/SWJ0LElxfuWAfzLCZmEeVu
        5lsXZ0jEQ==;
Received: from hch by bombadil.infradead.org with local (Exim 4.92 #3 (Red Hat Linux))
        id 1hqE4U-000222-Nc; Wed, 24 Jul 2019 10:00:30 +0000
Date:   Wed, 24 Jul 2019 03:00:30 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Jia-Ju Bai <baijiaju1990@gmail.com>
Cc:     rpeterso@redhat.com, agruenba@redhat.com, cluster-devel@redhat.com,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] fs: gfs2: Fix a null-pointer dereference in
 gfs2_alloc_inode()
Message-ID: <20190724100030.GA2239@infradead.org>
References: <20190724084303.1236-1-baijiaju1990@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190724084303.1236-1-baijiaju1990@gmail.com>
User-Agent: Mutt/1.11.4 (2019-03-13)
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 24, 2019 at 04:43:03PM +0800, Jia-Ju Bai wrote:
> index 0acc5834f653..c07c3f4f8451 100644
> --- a/fs/gfs2/super.c
> +++ b/fs/gfs2/super.c
> @@ -1728,8 +1728,9 @@ static struct inode *gfs2_alloc_inode(struct super_block *sb)
>  		memset(&ip->i_res, 0, sizeof(ip->i_res));
>  		RB_CLEAR_NODE(&ip->i_res.rs_node);
>  		ip->i_rahead = 0;
> -	}
> -	return &ip->i_inode;
> +		return &ip->i_inode;
> +	} else
> +		return NULL;
>  }

No need for an else after a return.  You probably just want to
return early for the NULL case.

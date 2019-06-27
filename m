Return-Path: <SRS0=pEez=U2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 02135C48BD6
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Jun 2019 13:52:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C45502084B
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Jun 2019 13:52:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="eeUqC7Ve"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726994AbfF0Nwc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Jun 2019 09:52:32 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:47824 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726370AbfF0Nwc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Jun 2019 09:52:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=0y2co1VtuxLtMunicbtPfuwjgsotxyaSHzNDNuerVo8=; b=eeUqC7Ve8Xb/qAFsrHqClbMU6
        DZqThUX2x9UJ6jKy5pgAgPxueD/kNHyHgYSfZZgdpRXYbjVr5y5u1Qph2fGwHas1kECz5SRU4nEgn
        /bGmDmgaODaRZchFEJSUoqToDvz9GRJNNE3Nk3+gaSmIiJJ2nA5lrojBSYbPSlp/d4vIrolvmrf2z
        DZdS9a3XaofxCos7TJu3pUpFLcoT4Gojob3n3AApUFNrHs60C6TiYWqUNbREjqUyr3nLDrXOXkBek
        RZr2ZCjuNFt8QRh/OmfI58prGws+ZCls6SOoa/rRuvvQl4zpBvIur2Ku0H7OF/ka2vyxyhW0iHSOL
        iyY487GKg==;
Received: from hch by bombadil.infradead.org with local (Exim 4.92 #3 (Red Hat Linux))
        id 1hgUp7-00069z-Rw; Thu, 27 Jun 2019 13:52:25 +0000
Date:   Thu, 27 Jun 2019 06:52:25 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     syzbot <syzbot+b75afdbe271a0d7ac4f6@syzkaller.appspotmail.com>
Cc:     darrick.wong@oracle.com, linux-kernel@vger.kernel.org,
        linux-xfs@vger.kernel.org, syzkaller-bugs@googlegroups.com
Subject: Re: KASAN: use-after-free Read in xlog_alloc_log
Message-ID: <20190627135225.GA22423@infradead.org>
References: <000000000000783d99058c489257@google.com>
 <20190627110654.GA13946@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190627110654.GA13946@infradead.org>
User-Agent: Mutt/1.11.4 (2019-03-13)
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 27, 2019 at 04:06:54AM -0700, Christoph Hellwig wrote:
> It seems like this is the xlog_alloc_log error path.  We didn't
> really change anything in the circular ioclogs queue handling, so
> maybe thish has been there before, but xfs_buf wasn't wired up to
> kasan to catch it?
> 
> Either way I suspect the right thing to do is to replace the list
> with an array based lookup.  I'll look into that, maybe a reproducer
> appears until then.

Actually, the iclog allocations are obviously too small.  A patch will
be on its way soon.

Return-Path: <SRS0=S2At=YJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 76145C4360C
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Oct 2019 07:40:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4EA0B20854
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Oct 2019 07:40:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="hHypW5ck"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391118AbfJPHkh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 16 Oct 2019 03:40:37 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:52484 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732599AbfJPHke (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Oct 2019 03:40:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=nAVrUYNo7z77xNN8BPUYDjArRLCzHJySHwl8SGXWxtA=; b=hHypW5ckFDh6HXlPU8J/DBxPn
        3ysSaC4VkVmMb6n21hYpS5DUSbe9/K5xvXF4Ap3889f9kKtk/nSi7OvWLMDBgl1wEu4Jm2ZfK2ADD
        R4JWlr1saxV7trRst+fFBqaygEgFaSgDr3sebg2JytNGZGt+nhgIPthLFGGt7kAIrz6zcxn1z+CKW
        HP9HAFKCmx7NQVzWOPwVeejyiyDcMGlh8GAvWdRLMPp48jrM439trEfzWnZOmtIg9UMq19pHcT1CM
        xTpwYQER629OMMcYz5XFzwb+hzl0ZdkH7WOiH5bK1ooaGcdCf881Npq0aJUCB8+clohzyWdBLFq6q
        YAOnj2P/Q==;
Received: from hch by bombadil.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1iKdv2-0007jR-Lh; Wed, 16 Oct 2019 07:40:28 +0000
Date:   Wed, 16 Oct 2019 00:40:28 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Ben Dooks <ben.dooks@codethink.co.uk>
Cc:     Christoph Hellwig <hch@infradead.org>,
        linux-kernel@lists.codethink.co.uk,
        Marek Behun <marek.behun@nic.cz>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] bus: moxtet: declare moxtet_bus_type
Message-ID: <20191016074028.GA25140@infradead.org>
References: <20191015122535.5439-1-ben.dooks@codethink.co.uk>
 <20191015163205.GB11160@infradead.org>
 <ec914ca4-53c6-ef4d-b0db-82852cdd9bbe@codethink.co.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ec914ca4-53c6-ef4d-b0db-82852cdd9bbe@codethink.co.uk>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 16, 2019 at 08:34:06AM +0100, Ben Dooks wrote:
> On 15/10/2019 17:32, Christoph Hellwig wrote:
> > On Tue, Oct 15, 2019 at 01:25:35PM +0100, Ben Dooks wrote:
> > > The moxtet_bus_type object is exported from the bus
> > > driver, but not declared. Add a declaration for use
> > > and to silence the following warning:
> > 
> > The symbol can be marked static instead.
> 
> Then it would have to be un-exported as it's listed as
> EXPORT_SYMBOL_GPL(moxtet_bus_type);

Yes, once you mark it static you should also remove the export.

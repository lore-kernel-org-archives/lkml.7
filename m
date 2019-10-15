Return-Path: <SRS0=fSNO=YI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9B16AC10F14
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Oct 2019 08:08:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6CF7C20873
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Oct 2019 08:08:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="mU4Da2tW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728483AbfJOIID (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 15 Oct 2019 04:08:03 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:38268 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728295AbfJOIIC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Oct 2019 04:08:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=wnuAl5JtsHUOid65Qy+G3kdgjasueY+xYrNILl9pjkw=; b=mU4Da2tWWcMEckNczgZ1z+WoI
        mRQ0tEYXnCz+1Ra7zuTZM7GKnu7rMWAKxtt84xsyg90LIA+pPbxXB+mFQqyAt2moMyX4NW/8zgNlU
        njYvPTLyTAG+3JUF7cvf09nFWET0miMV4HntSodqCG0xrAxJ4Ey1VTl5pgsgsbNfZ4m2PHCanA2Ck
        uCUg/F3CJF8ruBWG8C99DGa6QVVnEkmIk6gHPLoE01wUO+1QfpX0xpWNAxQhAsrq1HnmPigIBnzd3
        56tykTjPAwk1ybJUCjWgnOSaPY2Z8plGtztzQ2TdrGfne9n4oHRdVh7DHFftEDgAha/nTgx9esFUp
        GK1x/FRrw==;
Received: from hch by bombadil.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1iKHsA-0004Sx-7E; Tue, 15 Oct 2019 08:08:02 +0000
Date:   Tue, 15 Oct 2019 01:08:02 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Daniel Colascione <dancol@google.com>
Cc:     linux-api@vger.kernel.org, linux-kernel@vger.kernel.org,
        lokeshgidra@google.com, nnk@google.com, nosh@google.com,
        timmurray@google.com
Subject: Re: [PATCH 1/7] Add a new flags-accepting interface for anonymous
 inodes
Message-ID: <20191015080802.GA16814@infradead.org>
References: <20191012191602.45649-1-dancol@google.com>
 <20191012191602.45649-2-dancol@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191012191602.45649-2-dancol@google.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Oct 12, 2019 at 12:15:56PM -0700, Daniel Colascione wrote:
> Add functions forwarding from the old names to the new ones so we
> don't need to change any callers.

Independent of the usefulness of the interface (I'll let other comment,
but you defintively want to talk to Al Viro), adding a second interface
for only 17 callers total is a bad idea.  Just switch the existing
interface to pass flags.

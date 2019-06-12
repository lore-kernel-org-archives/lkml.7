Return-Path: <SRS0=n7Fw=UL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BFE1AC31E46
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Jun 2019 17:00:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9130A20896
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Jun 2019 17:00:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="YrZ7aTZf"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730538AbfFLRAg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Jun 2019 13:00:36 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:37132 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728377AbfFLRAg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Jun 2019 13:00:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Transfer-Encoding
        :Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:
        Sender:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=ntWDNfgCNc/sndoYBEa1e+idBiANLDkzcnLcfROE1SY=; b=YrZ7aTZf2lH6dOw36x7OfJ7HZG
        JDXb9QvjQqfl8BtXA9x04yG6aQl/qTNDN8eCSI0VqNbXzJIC81iw+vy9B/fhS3uM0sNd9txORD+s4
        oJJGz+SZAOxxCX5aQUNvk7y09p9YfwfabsIcNusBi59Eu2YYn0Okw1D3drqE+J/v24+EAre78/vdj
        2MRLls7NG9naeJ0Lp+pU/yE+7bw0wlEPDkmOb6UkgFu28+cSXU+MAvjhTFU8F6Ag4a8Mo4sDavAv9
        1CvnVSf1wiqL+le77gmkRpOmyJ62SBr8T/izEXJtUnEQ232zgWapdXoINmv6sMXJuwV/6xfdh9yUK
        YBepZjxw==;
Received: from willy by bombadil.infradead.org with local (Exim 4.92 #3 (Red Hat Linux))
        id 1hb6by-0003OL-Vj; Wed, 12 Jun 2019 17:00:34 +0000
Date:   Wed, 12 Jun 2019 10:00:34 -0700
From:   Matthew Wilcox <willy@infradead.org>
To:     Michal =?iso-8859-1?Q?Koutn=FD?= <mkoutny@suse.com>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        gorcunov@gmail.com, Laurent Dufour <ldufour@linux.ibm.com>,
        Kirill Tkhai <ktkhai@virtuozzo.com>
Subject: Re: [RFC PATCH] binfmt_elf: Protect mm_struct access with mmap_sem
Message-ID: <20190612170034.GE32656@bombadil.infradead.org>
References: <20190612142811.24894-1-mkoutny@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20190612142811.24894-1-mkoutny@suse.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 12, 2019 at 04:28:11PM +0200, Michal Koutný wrote:
> -	/* N.B. passed_fileno might not be initialized? */
> +

Why did you delete this comment?

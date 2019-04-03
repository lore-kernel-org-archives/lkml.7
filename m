Return-Path: <SRS0=7x1k=SF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 766BBC10F06
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Apr 2019 15:24:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 31F9C206B7
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Apr 2019 15:24:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="jLEUlmhS"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726495AbfDCPYL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Apr 2019 11:24:11 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:53934 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725959AbfDCPYL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Apr 2019 11:24:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=hFeBLOZeBtjEsKXGsqRA4gQsMvEg/4klMc4N3IGv0Tk=; b=jLEUlmhSfFViL2DU0i7klJ1oJ
        NTnazxywHhBSCrYsetjdi77DhswL2Z1O8vFwXNRCWx0o1VKE9v10fxMnEVEEl59FYaTWLA2T15mvM
        pf6tbVKihYUJ2fROl0nWwZdQNXi/BLII3drZVJOhs/ihz9kR2Nlrck80f2cMC28sK/cliapce1/vm
        f4nIFyKImWw1HfwgGtynTAoYhJwOyrFAWL5fD2F9LsxxhI14J4h4J/rVUoUoBKisKQU54ciIC8UGJ
        phkuvMWS4zalMTta+QXXpfCoVlsMbYI/RZ7KCJObpXIb14RxHEWojKS/EW2VszqPxzswYCN8h2p5l
        dKUTT2pPQ==;
Received: from willy by bombadil.infradead.org with local (Exim 4.90_1 #2 (Red Hat Linux))
        id 1hBhkF-0000g2-Fm; Wed, 03 Apr 2019 15:24:07 +0000
Date:   Wed, 3 Apr 2019 08:24:07 -0700
From:   Matthew Wilcox <willy@infradead.org>
To:     Nick Desaulniers <ndesaulniers@google.com>
Cc:     Tri Vo <trong@android.com>, Randy Dunlap <rdunlap@infradead.org>,
        Peter Oberparleiter <oberpar@linux.ibm.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Greg Hackmann <ghackmann@android.com>,
        Linux Memory Management List <linux-mm@kvack.org>,
        kbuild-all@01.org, kbuild test robot <lkp@intel.com>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2] gcov: fix when CONFIG_MODULES is not set
Message-ID: <20190403152407.GG22763@bombadil.infradead.org>
References: <eea3ce6a-732b-5c1d-9975-eddaeee21cf5@infradead.org>
 <20190329181839.139301-1-ndesaulniers@google.com>
 <83226cfb-afa7-0174-896c-d9f7a6193cf4@infradead.org>
 <CANA+-vAcW0VfAZmZWi84s1pQQ+tFx8VyzYsWi5_gj7vHT3Ao6Q@mail.gmail.com>
 <CAKwvOd=PstHEm_Vxtx_SGanKhAJSjoQiCb3kgCVeK4peUF2k-g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAKwvOd=PstHEm_Vxtx_SGanKhAJSjoQiCb3kgCVeK4peUF2k-g@mail.gmail.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 02, 2019 at 09:54:50AM +0700, Nick Desaulniers wrote:
> Looks like the format is:
> Fixes: <first 12 characters of commit sha> ("<first line of commit>")
> so:
> Fixes: 8c3d220cb6b5 ("gcov: clang support")
> 
> We should update:
> https://www.kernel.org/doc/html/v5.0/process/stable-kernel-rules.html
> to include this information.

It's in Documentation/process/submitting-patches.rst already.

Return-Path: <SRS0=Pa1K=VP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 64DCBC76195
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Jul 2019 10:08:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 303FC2173B
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Jul 2019 10:08:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="N0ZidmIX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389901AbfGRKIl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Jul 2019 06:08:41 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:48328 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726423AbfGRKIk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Jul 2019 06:08:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=DpK9cOcCwnUVV4wvwsvR2lMiWF49CzbDhGh6JuclBck=; b=N0ZidmIXza582uq6AOkTmKwVd
        /pAdJMRaAkAg+n5RmnYcvCefp+QmiAhy0eouDYAefXZZVW/uHuUv1D1+t7EUzLp7X0c7dc0OMX1or
        eRFs8aL6FnLebWJxVeqVN/MxqF61Y5sqE3S6nNR1IZC/bTOeMOtreCxxJu79t2SdSgeI+rcM+4RBs
        iBYr3b/Jb83J5h88exyvMYO36IWiZV7/erAGPIPAJ9PaMx5n7w2+7KIK+8E8rgQpdgYnZZ/4L72jC
        QjO/P1EjSYczct5HRSKb1NYUn1BjAN+jPVWcA732DjRoIKf6w7luaejig+A88rnPJnsPUnpmjyRqC
        B46KwMX/Q==;
Received: from hch by bombadil.infradead.org with local (Exim 4.92 #3 (Red Hat Linux))
        id 1ho3L6-0000Rb-14; Thu, 18 Jul 2019 10:08:40 +0000
Date:   Thu, 18 Jul 2019 03:08:40 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     John Stultz <john.stultz@linaro.org>
Cc:     lkml <linux-kernel@vger.kernel.org>,
        Laura Abbott <labbott@redhat.com>,
        Benjamin Gaignard <benjamin.gaignard@linaro.org>,
        Sumit Semwal <sumit.semwal@linaro.org>,
        Liam Mark <lmark@codeaurora.org>,
        Pratik Patel <pratikp@codeaurora.org>,
        Brian Starkey <Brian.Starkey@arm.com>,
        Vincent Donnefort <Vincent.Donnefort@arm.com>,
        Sudipto Paul <Sudipto.Paul@arm.com>,
        "Andrew F . Davis" <afd@ti.com>,
        Xu YiPing <xuyiping@hisilicon.com>,
        "Chenfeng (puck)" <puck.chen@hisilicon.com>,
        butao <butao@hisilicon.com>,
        "Xiaqing (A)" <saberlily.xia@hisilicon.com>,
        Yudongbin <yudongbin@hisilicon.com>,
        Christoph Hellwig <hch@infradead.org>,
        Chenbo Feng <fengc@google.com>,
        Alistair Strachan <astrachan@google.com>,
        dri-devel@lists.freedesktop.org
Subject: Re: [PATCH v6 4/5] dma-buf: heaps: Add CMA heap to dmabuf heaps
Message-ID: <20190718100840.GB19666@infradead.org>
References: <20190624194908.121273-1-john.stultz@linaro.org>
 <20190624194908.121273-5-john.stultz@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190624194908.121273-5-john.stultz@linaro.org>
User-Agent: Mutt/1.11.4 (2019-03-13)
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This and the previous one seem very much duplicated boilerplate
code.  Why can't just normal branches for allocating and freeing
normal pages vs cma?  We even have an existing helper for that
with dma_alloc_contiguous().

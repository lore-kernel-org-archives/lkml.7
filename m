Return-Path: <SRS0=HHJ+=YV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ED27CCA9EA0
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Oct 2019 07:46:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C054720650
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Oct 2019 07:46:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="gpwTNv9L"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731105AbfJ1Hqq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 28 Oct 2019 03:46:46 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:46488 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729695AbfJ1Hqq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Oct 2019 03:46:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=70HmlurglAAJniJsVRSXqyyvPjG5hWGb7QIptsE5/dw=; b=gpwTNv9LlrjBzgxTbn2JJCgfx
        yo2KmFz4Ql2+VRN6InGivZiXsCqgEFHRSaL2RwSgnPt+LasNjvuxfNE8gkKzxXPqUP933RsJKgkUM
        C2g5gPcOEfgE7Zz12IVRJQQzVBKmH+APEObKsCMvxwGX4VWd95Gq/Vz8MTv7zMm8Ukya9w22hZhI8
        sNZX2S5hXFKY9tFdNPz8fH7qnZ86sXFXxW+ruKzTXNq93h/t/PlGKKIwU7bhotVwanxjJ1eZCtzL5
        SI+hDOOs+atLJNmFcStMa1H/Huuo3YjPXoKGuID+95tSMpMkBY5G5Jr56UI2gVx8NnZLMI7pvbcoN
        BMB783yiw==;
Received: from hch by bombadil.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1iOzje-0001kr-Sp; Mon, 28 Oct 2019 07:46:42 +0000
Date:   Mon, 28 Oct 2019 00:46:42 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     John Stultz <john.stultz@linaro.org>
Cc:     lkml <linux-kernel@vger.kernel.org>,
        Sandeep Patil <sspatil@google.com>,
        Laura Abbott <labbott@redhat.com>,
        Benjamin Gaignard <benjamin.gaignard@linaro.org>,
        Sumit Semwal <sumit.semwal@linaro.org>,
        Liam Mark <lmark@codeaurora.org>,
        Pratik Patel <pratikp@codeaurora.org>,
        Brian Starkey <Brian.Starkey@arm.com>,
        "Andrew F . Davis" <afd@ti.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Yue Hu <huyue2@yulong.com>, Mike Rapoport <rppt@linux.ibm.com>,
        Chenbo Feng <fengc@google.com>,
        Alistair Strachan <astrachan@google.com>,
        Hridya Valsaraju <hridya@google.com>,
        dri-devel@lists.freedesktop.org
Subject: Re: [RFC][PATCH 1/2] mm: cma: Export cma symbols for cma heap as a
 module
Message-ID: <20191028074642.GB31867@infradead.org>
References: <20191025234834.28214-1-john.stultz@linaro.org>
 <20191025234834.28214-2-john.stultz@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191025234834.28214-2-john.stultz@linaro.org>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 25, 2019 at 11:48:33PM +0000, John Stultz wrote:
>  struct cma *dma_contiguous_default_area;
> +EXPORT_SYMBOL(dma_contiguous_default_area);

Please CC the dma maintainer.  And no, you have no business using this.

Even if you did, internals like this should always be EXPORT_SYMBOL_GPL.

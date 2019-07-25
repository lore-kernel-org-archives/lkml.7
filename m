Return-Path: <SRS0=6YJq=VW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 639E7C7618B
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Jul 2019 14:04:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 39824217F4
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Jul 2019 14:04:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="d+3dJJOK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728620AbfGYOEu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Jul 2019 10:04:50 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:58382 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727209AbfGYOEt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Jul 2019 10:04:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=1joWEMQcLM+9YSoj5rlIs3pivlXRiqlH0/8S4ycCPoY=; b=d+3dJJOKVxgyE0HGPBv/Ub5Pi
        8ZNkwfm17H8avnq/qSh4DobZVl7b7s1ZASqKjtlBKPGsmk3wRI5Qbbxkys/kZkcWYg02Ip0OvTkdI
        ZZduotlcoq7vXMJVf15h9y6rWTGMsMqxV8Gwwdlg2Z/S2DxY74ljHi0t7VfeuayMnPd2WfLhxDM2y
        /h2ahK0mluNJuNPPZGti+5N44cQZ25hE7yq+yp8VaAcbbL7mYtRnNf/dGml1G0XxeSNHoRwGzIWT8
        FCig2SBsHjq5u8eK48GGbnVYchinTcnWgcTF25ouC1sPoI7zvrIHrSpsHLdGGaOTKIeCc8VR8FtMD
        qRAjbM+xA==;
Received: from hch by bombadil.infradead.org with local (Exim 4.92 #3 (Red Hat Linux))
        id 1hqeMS-0007lj-1V; Thu, 25 Jul 2019 14:04:48 +0000
Date:   Thu, 25 Jul 2019 07:04:48 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     "Andrew F. Davis" <afd@ti.com>
Cc:     Christoph Hellwig <hch@infradead.org>,
        John Stultz <john.stultz@linaro.org>,
        lkml <linux-kernel@vger.kernel.org>,
        Laura Abbott <labbott@redhat.com>,
        Benjamin Gaignard <benjamin.gaignard@linaro.org>,
        Sumit Semwal <sumit.semwal@linaro.org>,
        Liam Mark <lmark@codeaurora.org>,
        Pratik Patel <pratikp@codeaurora.org>,
        Brian Starkey <Brian.Starkey@arm.com>,
        Vincent Donnefort <Vincent.Donnefort@arm.com>,
        Sudipto Paul <Sudipto.Paul@arm.com>,
        Xu YiPing <xuyiping@hisilicon.com>,
        "Chenfeng (puck)" <puck.chen@hisilicon.com>,
        butao <butao@hisilicon.com>,
        "Xiaqing (A)" <saberlily.xia@hisilicon.com>,
        Yudongbin <yudongbin@hisilicon.com>,
        Chenbo Feng <fengc@google.com>,
        Alistair Strachan <astrachan@google.com>,
        dri-devel <dri-devel@lists.freedesktop.org>
Subject: Re: [PATCH v6 4/5] dma-buf: heaps: Add CMA heap to dmabuf heaps
Message-ID: <20190725140448.GA25010@infradead.org>
References: <20190624194908.121273-1-john.stultz@linaro.org>
 <20190624194908.121273-5-john.stultz@linaro.org>
 <20190718100840.GB19666@infradead.org>
 <CALAqxLWLx_tHVjZqrSNWfQ_M2RGGqh4qth3hi9GGRdSPov-gcw@mail.gmail.com>
 <20190724065958.GC16225@infradead.org>
 <8e6f8e4f-20fc-1f1f-2228-f4fd7c7c5c1f@ti.com>
 <20190725125014.GD20286@infradead.org>
 <0eae0024-1fdf-bd06-a8ff-1a41f0af3c69@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0eae0024-1fdf-bd06-a8ff-1a41f0af3c69@ti.com>
User-Agent: Mutt/1.11.4 (2019-03-13)
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 25, 2019 at 09:31:50AM -0400, Andrew F. Davis wrote:
> But that's just it, dma-buf does not assume buffers are backed by normal
> kernel managed memory, it is up to the buffer exporter where and when to
> allocate the memory. The memory backed by this SRAM buffer does not have
> the normal struct page backing. So moving the map, sync, etc functions
> to common code would fail for this and many other heap types. This was a
> major problem with Ion that prompted this new design.

The code clearly shows it has page backing, e.g. this:

+	sg_set_page(table->sgl, pfn_to_page(PFN_DOWN(buffer->paddr)), buffer->len, 0);

and the fact that it (and the dma-buf API) uses scatterlists, which 
requires pages.

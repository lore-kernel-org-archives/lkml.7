Return-Path: <SRS0=XcGb=25=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 340D2C33C99
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Jan 2020 02:27:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F2140206F0
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Jan 2020 02:27:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="R842ZIDz"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726368AbgAHC1o (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 Jan 2020 21:27:44 -0500
Received: from mail-pj1-f68.google.com ([209.85.216.68]:39969 "EHLO
        mail-pj1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725812AbgAHC1n (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Jan 2020 21:27:43 -0500
Received: by mail-pj1-f68.google.com with SMTP id bg7so399156pjb.5
        for <linux-kernel@vger.kernel.org>; Tue, 07 Jan 2020 18:27:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=TxCBIIGREavpCVrRs9QNlaW6niSLc1GB+TRhNf+Qpmo=;
        b=R842ZIDzQUYEND1R5s7cntI/r/5WU1Mlc62dtk1Wrbk7IdDkynyqhS/SeUXFyzPXUN
         1Nk47N4euErxEnpMFOUkTdtGvi/lQ41Dwo0VbusHkEI+5/LaHz45hTiKDFAap8hgdFg4
         CEB/UqMZtUqwfpExLHBKwe2lYBXPb0fMW5L4A=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=TxCBIIGREavpCVrRs9QNlaW6niSLc1GB+TRhNf+Qpmo=;
        b=HWltELONXdXV5E0akv7tyC16SMAd7Eyakg3YJWPhj6eCrg80q0UNKgZb17/sXXKV4q
         hImL4svkSHuNa4+81Gs/tLQl4J54Hu32aKqLU3aKuXetqp1blnz3R7TWfSfcDtFVrSN7
         GoU5/TM3k1rUFlKh3FlVcGB0bV1FaC3DIBZRUiaDA2k+igmPmgoVk8lY16SmlNohcsnv
         BxyBXBkcfpaMZT71mNpds+SWBbinxNmE6ti384SVV1vjmoRPyyTQEvdaHCd2Xrr2Ll6W
         b4bba72M47qf4OOCTVMTypexZ5YQB6VOrpPwCI4rxs2J9NZGtNuodbTtoD+30+PLPpIX
         QF5g==
X-Gm-Message-State: APjAAAVv98HXDsJUl0SwVj2I0AjcL8ZPR0hUP/zBtoQ7jFp8mThaVmVr
        yTf2zX5SyjSqrwAc4TBDtj/rgQ==
X-Google-Smtp-Source: APXvYqyApuWFuZqGIyOf5rbM7brHnaEX2kHU+YLA3DErCW/+r7iApFECfrvpBxwUNNbksYTQ0nXytg==
X-Received: by 2002:a17:90b:f0f:: with SMTP id br15mr1822086pjb.138.1578450463118;
        Tue, 07 Jan 2020 18:27:43 -0800 (PST)
Received: from localhost ([2401:fa00:8f:203:250d:e71d:5a0a:9afe])
        by smtp.gmail.com with ESMTPSA id b15sm925307pft.58.2020.01.07.18.27.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Jan 2020 18:27:42 -0800 (PST)
Date:   Wed, 8 Jan 2020 11:27:41 +0900
From:   Sergey Senozhatsky <senozhatsky@chromium.org>
To:     Sergey Senozhatsky <senozhatsky@chromium.org>
Cc:     Hans Verkuil <hans.verkuil@cisco.com>,
        Tomasz Figa <tfiga@chromium.org>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Kyungmin Park <kyungmin.park@samsung.com>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Sakari Ailus <sakari.ailus@iki.fi>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Pawel Osciak <posciak@chromium.org>,
        linux-media@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [RFC][PATCH 00/15] Implement V4L2_BUF_FLAG_NO_CACHE_* flags
Message-ID: <20200108022741.GA7366@google.com>
References: <20191217032034.54897-1-senozhatsky@chromium.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20191217032034.54897-1-senozhatsky@chromium.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On (19/12/17 12:20), Sergey Senozhatsky wrote:
> Hello,
> 
> 	RFC
> 
> 	This is a reworked version of the vb2 cache hints
> (V4L2_BUF_FLAG_NO_CACHE_INVALIDATE / V4L2_BUF_FLAG_NO_CACHE_CLEAN)
> support patch series which previsouly was developed by Sakari and
> Laurent [0].
> 
> The patch set attempts to preserve the existing behvaiour - cache
> sync is performed in ->prepare() and ->finish() (unless the buffer
> is DMA exported). User space can request “default behavior” override
> with cache management hints, which are handled on a per-buffer basis
> and should be supplied with v4l2_buffer ->flags during buffer
> preparation. There are two possible hints:
> 
> - V4L2_BUF_FLAG_NO_CACHE_INVALIDATE
> 	No cache sync on ->finish()
> 
> - V4L2_BUF_FLAG_NO_CACHE_CLEAN
> 	No cache sync on ->prepare()
> 
> In order to keep things on the safe side, we also require driver
> to explicitly state which of its queues (if any) support user space
> cache management hints (such queues should have ->allow_cache_hints
> bit set).
> 
> The patch set also (to some extent) simplifies allocators' ->prepare()
> and ->finish() callbacks. Namely, we move cache management decision
> making to the upper - core - layer. For example, if, previously, we
> would have something like this
> 
> 	vb2_buffer_done()
> 	  vb2_dc_finish()
> 	    if (buf->db_attach)
> 	       return;
> 
> where each allocators' ->finish() callback would either bail
> out (DMA exported buffer, for instance) or sync, now that "bail
> out or sync" decision is made before we call into the allocator.
> 
> Along with cache management hints, user space is also able to
> adjust queue's memory consistency attributes. Memory consistency
> attribute (dma_attrs) is per-queue, yet it plays its role on the
> allocator level, when we allocate buffers’ private memory (planes).
> For the time being, only one consistency attribute is supported:
> DMA_ATTR_NON_CONSISTENT.

Gentle ping.

	-ss

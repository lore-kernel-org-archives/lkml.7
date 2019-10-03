Return-Path: <SRS0=6dNS=X4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9F191C4360C
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Oct 2019 00:03:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6C81A222C6
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Oct 2019 00:03:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="Jr2s+a1r"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729199AbfJCADN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 2 Oct 2019 20:03:13 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:42124 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727327AbfJCADN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Oct 2019 20:03:13 -0400
Received: by mail-pg1-f195.google.com with SMTP id z12so581710pgp.9
        for <linux-kernel@vger.kernel.org>; Wed, 02 Oct 2019 17:03:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=KhRAPRqFky/Twme7rRpazN2EJx68CVDyfTsQWc0na50=;
        b=Jr2s+a1rz0D0GDCFf6FmcbiezAPoqvv++8pYb9rM96BOWy1LjM1uCe08ZsS5f/RrrM
         88Dw7g6RUOU2bLLM8zwP5bBNK+R/1k9U5WfLPKrmkASsdIZ9tvfYKL9delhD++zjTiTD
         v7/5JGchy5dEJWgZJ8hR79DRlOJFYT+59JZa4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=KhRAPRqFky/Twme7rRpazN2EJx68CVDyfTsQWc0na50=;
        b=oMqlstfLLxrqrWeQG5IiveFY4jdGN91yOe1jXZouib2lKUs/1RrfdtT4uz2anywZti
         Ip7K7F56YjhCyH2culCcfW3ddvgdii2//KNZFBZb8eDp4d7eh5kTUeaLZzW4m8xcBIV3
         3BCgDsQ1Z0MeW554/uM+UeqYzhWizfCxsAXvpCSV95oLJogPK57OgTQtvrek60vHAUnn
         BRx2VfIK2d4/JbTBZ+LZtQft/yGoB5xy4GzNCnSn02dhdZcMp7SQBtVXNFVo6q2GKSzt
         Ixla5kklv2uux9WAV+3c7rMcqr+iA7ONFc6S67W12reG19qTv2qTPiG7MrLSigTO6yY8
         8r/Q==
X-Gm-Message-State: APjAAAVk0eccPkB8LbMpg/g6o3CEkU4oykcAjhU7WYxXY/WIAsGE4Te9
        8PmBqE/sffX+DJ/fdfk9feQyaw==
X-Google-Smtp-Source: APXvYqyaX4YrbwSWFAdl7mDjfBV92NHPW2JrFBqt88faJkZxLNYM/3lTBXzq+fIn8WJ+7uKkPQoCSQ==
X-Received: by 2002:a62:2ad6:: with SMTP id q205mr7626671pfq.46.1570060990969;
        Wed, 02 Oct 2019 17:03:10 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id 20sm546342pfp.153.2019.10.02.17.03.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Oct 2019 17:03:09 -0700 (PDT)
Date:   Wed, 2 Oct 2019 17:03:08 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Robin Murphy <robin.murphy@arm.com>
Cc:     Christoph Hellwig <hch@lst.de>, Laura Abbott <labbott@redhat.com>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Jesper Dangaard Brouer <brouer@redhat.com>,
        Allison Randal <allison@lohutok.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Stephen Boyd <swboyd@chromium.org>,
        Dan Carpenter <dan.carpenter@oracle.com>,
        Semmle Security Reports <security-reports@semmle.com>,
        iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] dma-mapping: Lift address space checks out of debug code
Message-ID: <201910021659.96269C05@keescook>
References: <201910021341.7819A660@keescook>
 <7a5dc7aa-66ec-0249-e73f-285b8807cb73@arm.com>
 <201910021643.75E856C@keescook>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <201910021643.75E856C@keescook>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 02, 2019 at 04:58:39PM -0700, Kees Cook wrote:
> In the USB case, it'll actually refuse to do the operation. Should
> dma_map_single() similarly fail? I could push these checks down into
> dma_map_single(), which would be a no-change on behavior for USB and
> gain the checks on all other callers...

Which begs the question: are all callers actually checking the result of
dma_map_single(). Many are paired with dma_mapping_error(), but lots
more aren't...

-- 
Kees Cook

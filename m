Return-Path: <SRS0=S2At=YJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CB601FA3728
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Oct 2019 19:15:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A23A4205C9
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Oct 2019 19:15:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Rj82Cq//"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2436746AbfJPTP4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 16 Oct 2019 15:15:56 -0400
Received: from mail-qk1-f196.google.com ([209.85.222.196]:36517 "EHLO
        mail-qk1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731321AbfJPTP4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Oct 2019 15:15:56 -0400
Received: by mail-qk1-f196.google.com with SMTP id y189so23876532qkc.3
        for <linux-kernel@vger.kernel.org>; Wed, 16 Oct 2019 12:15:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=xnrlXCUOxPmSFsn1bWubDV9XvYWU9LUg2fS/Ow1fciQ=;
        b=Rj82Cq//18jPhF0pi6MNplx4cOskXy0n0aw/eznpjWaGwS63ytn99+9Qc4xLZUjwkP
         xteAaR03e3Y/bKdUAqk565VMocSxmdG9/0av+ok7OIGnf5A3Cczz/YYi9bBfKHzmioKu
         3cmC+XYnr36Banvyh/tOwZ+Eezz9r0ALIIgh+AiTMNT5f2GqrC6bFd1Oy2VMSN7wCBSA
         M8W8nkkefkd2+IGjepJtjkIMFcylj36eUS2epO+6uhH26fB8nJkxxmn9Y7pu4JnuCnDV
         BFNSigNojrX6Hh5yTCxBE0EpjLWIbCzABYNSFVn8VMSu5zmusfOmIBwrmODqjjA4Ns+N
         fUlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:date:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=xnrlXCUOxPmSFsn1bWubDV9XvYWU9LUg2fS/Ow1fciQ=;
        b=qrj1dvoMujqt+XJ0BlD3P1cJRyaQMVroNb5Z6o9P4X+8PBECFwjZFQ+XigULI1gjqC
         9qsMxNgtVejZyYzcAVKamC8NNIXkK/0Y5DlWvydBuVoNOQA8SpQIhw0lcmADLa6uKdMk
         CuyRWDBMa/0wONBZith8T7ryEZD4DEDaDs1EefILhWc6EC+SwSHIp7447ZqYTBv+NxMA
         krYNurHIgonCkQNZyqS4OL12q8ypSSBS8YZCoJt11QT8IfeVnMgl0y7Vq/mVbx/Q9fDn
         83ureVxQTpi+Xi682ipFviV0DpSUcfkJWfQKIZ42NkaeFzg/skx8gQz/LQv+M4evdPHw
         20Mg==
X-Gm-Message-State: APjAAAUXpMXZx077K67IafzXrg4nNS3HO9bzRREDRoZ+OGI4iQvZ0szl
        hJVGH07HXNWVWskDEHkiTIg=
X-Google-Smtp-Source: APXvYqyBMR1WqAeDUfLBy35tm2PHVTI9UTu1jc1IfB2/mNFozHSTnEBVbVqTfVDiMxXSqV8YNtTjTQ==
X-Received: by 2002:a37:ac1a:: with SMTP id e26mr42356788qkm.20.1571253354818;
        Wed, 16 Oct 2019 12:15:54 -0700 (PDT)
Received: from rani ([2001:470:1f07:5f3:9e5c:8eff:fe50:ac29])
        by smtp.gmail.com with ESMTPSA id z20sm14607110qtu.91.2019.10.16.12.15.54
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 16 Oct 2019 12:15:54 -0700 (PDT)
From:   Arvind Sankar <nivedita@alum.mit.edu>
X-Google-Original-From: Arvind Sankar <arvind@rani>
Date:   Wed, 16 Oct 2019 15:15:52 -0400
To:     Lu Baolu <baolu.lu@linux.intel.com>
Cc:     Arvind Sankar <nivedita@alum.mit.edu>,
        linux-kernel@vger.kernel.org, Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH] iommu/vt-d: Return the correct dma mask when we are
 bypassing the IOMMU
Message-ID: <20191016191551.GA2692557@rani>
References: <20191008143357.GA599223@rani.riverdale.lan>
 <85123533-2e9c-af73-3014-782dd6f925cb@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <85123533-2e9c-af73-3014-782dd6f925cb@linux.intel.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 10, 2019 at 09:26:37AM +0800, Lu Baolu wrote:
> Hi,
> 
> On 10/8/19 10:33 PM, Arvind Sankar wrote:
> > We must return a mask covering the full physical RAM when bypassing the
> > IOMMU mapping. Also, in iommu_need_mapping, we need to check using
> > dma_direct_get_required_mask to ensure that the device's dma_mask can
> > cover physical RAM before deciding to bypass IOMMU mapping.
> > 
> > Fixes: 249baa547901 ("dma-mapping: provide a better default ->get_required_mask")
> > Reported-by: Arvind Sankar <nivedita@alum.mit.edu>
> > Tested-by: Arvind Sankar <nivedita@alum.mit.edu>
> > Originally-by: Christoph Hellwig <hch@lst.de>
> > Signed-off-by: Christoph Hellwig <hch@lst.de>
> > Fixed-by: Arvind Sankar <nivedita@alum.mit.edu>
> > Signed-off-by: Arvind Sankar <nivedita@alum.mit.edu>
> 
> This patch looks good to me.
> 
> Reviewed-by: Lu Baolu <baolu.lu@linux.intel.com>
> 

Hi Christoph, will you be taking this through your dma-mapping branch?

Thanks.

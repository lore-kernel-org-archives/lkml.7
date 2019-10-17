Return-Path: <SRS0=WVJ0=YK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 39D36FA372A
	for <linux-kernel@archiver.kernel.org>; Thu, 17 Oct 2019 15:55:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0C19221835
	for <linux-kernel@archiver.kernel.org>; Thu, 17 Oct 2019 15:55:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="la2N7oWB"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2395400AbfJQPzT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 17 Oct 2019 11:55:19 -0400
Received: from mail-qt1-f196.google.com ([209.85.160.196]:37204 "EHLO
        mail-qt1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727793AbfJQPzT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Oct 2019 11:55:19 -0400
Received: by mail-qt1-f196.google.com with SMTP id n17so4310442qtr.4
        for <linux-kernel@vger.kernel.org>; Thu, 17 Oct 2019 08:55:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=v2tCNwGEk6Hjl0LVhFHVd3Y+5ewmpDEB16+jIqUYLmA=;
        b=la2N7oWBGDwB71vWDqJ0B6DpfSrpV/6/nxqHcXbWr9c5lMtwcdAm0qDsQ2fkOleyDm
         TnOLIGFe/xMF8FXyfRM+Fxkoib50RO3x6hnBqmju1HV3ySEy3CAAuAxvP9OXEkvL5tKc
         AEEEeeMA5LFLJjse3erMdt7lFnrEO9hD6r1lrozefqzkUpJuG0wUD0DOOlSexR2C4O0N
         xmkXhgtmUojqNjediux9Nj/2z1U4xiP0cxbc58uatUUxPwdKp7ke61LWkHA3VGw3z8Pj
         A0sSrGQc1p//YaK3OlG2kqqu10j/on8G86TiNKtKt36ix4qD6FsbJmmsVXwIotQxARPE
         /o/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:date:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=v2tCNwGEk6Hjl0LVhFHVd3Y+5ewmpDEB16+jIqUYLmA=;
        b=ndYkIx9jVRZ2BrCX8aIYLul0XWhoIqljg2qmn0MARQxVdXQAsizzIChfXMDWtut3n6
         rx3FCcre+9XdU7DV/xp1boMitaGzGJAFBc/JIoJ63rGElfu6IgBQ8Xqq3L6Q3oNOEvf9
         6Z9RZYsiOj5PjHihD4LEyJLjofgixHmx/cDqHBY8zJg7BIbxUyCSoCdosKXIZ8/yBXjz
         maP3k+LgGsFKk0yAbw+GJ+2fFFaMQ3inOsJBAmUHXZ/n7LwKb+HWmHHayAYViTPovPBd
         cRgno5Ikqr/ILO2hir/+Y8RrZxz5VwHDDXBua3fZaADlgZJfpHcaHvECsOvPGBNHZMNl
         x/5g==
X-Gm-Message-State: APjAAAUGzLof15wVJoVGtPyjb8fuOV0cFWhJz1HMcxRUe2gSGgnCLT1q
        HiFJtMUpH4dkxaozxjEVhl0=
X-Google-Smtp-Source: APXvYqxYON5/T5tIf8O+GgRotfnKOER2WgXep3Qjk6LvCgXXSSZGdWVEmJHPRG4QuI/ba9RxX7xFMg==
X-Received: by 2002:ad4:4c8c:: with SMTP id bs12mr4484849qvb.171.1571327718324;
        Thu, 17 Oct 2019 08:55:18 -0700 (PDT)
Received: from rani ([2001:470:1f07:5f3:9e5c:8eff:fe50:ac29])
        by smtp.gmail.com with ESMTPSA id z46sm2019850qth.62.2019.10.17.08.55.17
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 17 Oct 2019 08:55:17 -0700 (PDT)
From:   Arvind Sankar <nivedita@alum.mit.edu>
X-Google-Original-From: Arvind Sankar <arvind@rani>
Date:   Thu, 17 Oct 2019 11:55:16 -0400
To:     Christoph Hellwig <hch@lst.de>
Cc:     Arvind Sankar <nivedita@alum.mit.edu>,
        Lu Baolu <baolu.lu@linux.intel.com>,
        linux-kernel@vger.kernel.org, Joerg Roedel <joro@8bytes.org>,
        David Woodhouse <dwmw2@infradead.org>,
        iommu@lists.linux-foundation.org
Subject: Re: [PATCH] iommu/vt-d: Return the correct dma mask when we are
 bypassing the IOMMU
Message-ID: <20191017155515.GA3571354@rani>
References: <20191008143357.GA599223@rani.riverdale.lan>
 <85123533-2e9c-af73-3014-782dd6f925cb@linux.intel.com>
 <20191016191551.GA2692557@rani>
 <20191017070847.GA15037@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20191017070847.GA15037@lst.de>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 17, 2019 at 09:08:47AM +0200, Christoph Hellwig wrote:
> On Wed, Oct 16, 2019 at 03:15:52PM -0400, Arvind Sankar wrote:
> > > > Reported-by: Arvind Sankar <nivedita@alum.mit.edu>
> > > > Tested-by: Arvind Sankar <nivedita@alum.mit.edu>
> > > > Originally-by: Christoph Hellwig <hch@lst.de>
> > > > Signed-off-by: Christoph Hellwig <hch@lst.de>
> > > > Fixed-by: Arvind Sankar <nivedita@alum.mit.edu>
> > > > Signed-off-by: Arvind Sankar <nivedita@alum.mit.edu>
> > > 
> > > This patch looks good to me.
> > > 
> > > Reviewed-by: Lu Baolu <baolu.lu@linux.intel.com>
> > > 
> > 
> > Hi Christoph, will you be taking this through your dma-mapping branch?
> 
> Given this is a patch to intel-iommu I expect Joerg to pick it up.
> But if he is fine with that I can also queue it up instead.

David Woodhouse is listed as maintainer for intel-iommu. Cc'ing him as
well.

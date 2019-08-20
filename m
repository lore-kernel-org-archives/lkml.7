Return-Path: <SRS0=Exau=WQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 67C98C3A5A0
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Aug 2019 02:22:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2F078218BA
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Aug 2019 02:22:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=intel-com.20150623.gappssmtp.com header.i=@intel-com.20150623.gappssmtp.com header.b="zKdVom0N"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728981AbfHTCWx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 19 Aug 2019 22:22:53 -0400
Received: from mail-ot1-f67.google.com ([209.85.210.67]:43604 "EHLO
        mail-ot1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728615AbfHTCWx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Aug 2019 22:22:53 -0400
Received: by mail-ot1-f67.google.com with SMTP id e12so3616387otp.10
        for <linux-kernel@vger.kernel.org>; Mon, 19 Aug 2019 19:22:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=dGaKAdU7Kzz4IRqMPbeMcHc/uvSVrliEnlndetCK0L4=;
        b=zKdVom0NZGDuaHrgxklgUVhp5ExnznDDaFFfOxYdgCUPF9H/QOmK2okCnSBv7TG1iD
         8VgVkvB+roi1O3wId/DNGT8ohuOBrvtAfFus1UIgy09kWcIHqe6sdGmcCfrddDiGjVfQ
         Afc6z9YQXk8loHn3UQOdSWjNKRrrWri2tNd/Ct3340IOvPhfEVjetCZPcUMPwssOPcPh
         gcT9UtKBwAP+mwb+m6SX2ozuyxus2NlfyohT9yJ4NcRTRyeoKama6VEntAVh0vYxR8l2
         sRgjoQgP2IKMeZVgEwTLIZ62YZ8rqzp3S2/EPPh3bvEnEXheYWNfsqDls665h3cp2/Xk
         liEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=dGaKAdU7Kzz4IRqMPbeMcHc/uvSVrliEnlndetCK0L4=;
        b=FEe6hFnGRpyH1PssCxlXZ+eV47x2FUmBXb8iCmqPVt3YmxDNy+kKCEfpilEzEs2H38
         hTYttte5o+IrcMlyMIKSXbZWmC1nJXY4uhpveqA8Zh1Oz56ajt14qhgiWDFFy2NqGxsc
         4ZPis9ivpU7qi9tvXxEUvePhGl+btqaJkjzQKlB/Q+tW3pj/o6TuxNaAIPaj6WlFoxU3
         QaMJjVrcBr/9MZYlOnkRdR4s3azM3GRSpDIBcqUoREzGu3Z6Y/vNDFx9wtYMA//7stmq
         mK5OWGp2DLQBWFejx5PQTrWETMIPZJ177inqbB+ALEA1o+wygxp1jhMmcpanyY1Et1o0
         pBEA==
X-Gm-Message-State: APjAAAVu+TJAPURjRTf525GjHaFojSl4Z/NWEcRkJL9w7RQy0Y9duB/0
        nSRzXlhHjvCzCHs+htLazmOel+qqt2gX/EaD39mHfA==
X-Google-Smtp-Source: APXvYqxMJSoi3xcOuG4kdSjiGcLdWTp8DOPjIJI3WHkmC8gPmnKQsuPiwRsZyF/AEjqfvhoUMKVUtbKpNU6WT1lmw68=
X-Received: by 2002:a05:6830:458:: with SMTP id d24mr19986229otc.126.1566267772164;
 Mon, 19 Aug 2019 19:22:52 -0700 (PDT)
MIME-Version: 1.0
References: <20190818090557.17853-1-hch@lst.de> <20190818090557.17853-4-hch@lst.de>
In-Reply-To: <20190818090557.17853-4-hch@lst.de>
From:   Dan Williams <dan.j.williams@intel.com>
Date:   Mon, 19 Aug 2019 19:22:41 -0700
Message-ID: <CAPcyv4h9Bp=D4oHEb-v9U7-aZE3VazmsTK3Ou3iC3s3FTYc4Dg@mail.gmail.com>
Subject: Re: [PATCH 3/4] memremap: don't use a separate devm action for devmap_managed_enable_get
To:     Christoph Hellwig <hch@lst.de>
Cc:     Jason Gunthorpe <jgg@mellanox.com>,
        Bharata B Rao <bharata@linux.ibm.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linux MM <linux-mm@kvack.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-nvdimm <linux-nvdimm@lists.01.org>,
        Ira Weiny <ira.weiny@intel.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Aug 18, 2019 at 2:12 AM Christoph Hellwig <hch@lst.de> wrote:
>
> Just clean up for early failures and then piggy back on
> devm_memremap_pages_release.  This helps with a pending not device
> managed version of devm_memremap_pages.
>
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> Reviewed-by: Ira Weiny <ira.weiny@intel.com>

Looks good,

Reviewed-by: Dan Williams <dan.j.williams@intel.com>

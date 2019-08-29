Return-Path: <SRS0=brkd=WZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D0CF5C3A59F
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Aug 2019 17:53:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 975632173E
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Aug 2019 17:53:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=netronome-com.20150623.gappssmtp.com header.i=@netronome-com.20150623.gappssmtp.com header.b="tT4DAN9g"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727891AbfH2RxE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 29 Aug 2019 13:53:04 -0400
Received: from mail-ed1-f67.google.com ([209.85.208.67]:39948 "EHLO
        mail-ed1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727495AbfH2RxE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Aug 2019 13:53:04 -0400
Received: by mail-ed1-f67.google.com with SMTP id h8so4986124edv.7
        for <linux-kernel@vger.kernel.org>; Thu, 29 Aug 2019 10:53:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=netronome-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:in-reply-to:references
         :organization:mime-version:content-transfer-encoding;
        bh=rQe28KLlHDvRerbTckpdwu9z06KjBNQSCvgEdw6K0Eg=;
        b=tT4DAN9gN76+WHbhh4TG+YpgAKU/LKtZGbtUHvgNZpZPWwwxb3Pwgp9gY7KmU56bpy
         Xv1Oq1K0lQufSYgylVI+058laygeoiV6N89ge00rHLiXwHGiNADSAFMw+IREzVPLdmbm
         29QRSeWyqEjtFKzgmU/Oh4LEis0bpqKyTEXryAK2+G74ogQAz2rvUVehVUUgTm3guAGR
         tc0wT9c1rWjzmZScMBFDvQx8095V+I/Peg6OfokDBFRF8hCJTN3fBKPdwPvp0YW3qq/0
         OTHoEIVl0PKVOAilqTaxbMVHTpX3mKVBd8whSWyym6Whg2ycKCFrqVDXraFG8/Rltggo
         Dqsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:in-reply-to
         :references:organization:mime-version:content-transfer-encoding;
        bh=rQe28KLlHDvRerbTckpdwu9z06KjBNQSCvgEdw6K0Eg=;
        b=un5iAW32SwDOrHhUIp7iCs13SI0t+ajcAxHePT/HYd8xt5NDMQEEn0hjnjW+Mey42f
         T2KijGpqLoMaArrQo9HIDRyLoc0XdkTt2YvhExB2iBh++HydZM3rKTYxNnl1c9hpq84G
         sbWXY0wmloB8AKEhFEiJUL3j52oI1C0Y1OtT5xhrvjTlevbFPFZQOgnGCvXcFnCvQXxM
         LuoHTKPtTjKgd1oJL9N9EH8Rv5iH7LV9P2TViUlNM97NXRQhRLD4IY4nQb4/x0GGukMB
         6CPi3cUsrlxiPQaGsDB/1AUqexkc6mBQ7B0hZ8JauL5uX0Bk9pqXaCCRKor6fpg5LDxk
         QafA==
X-Gm-Message-State: APjAAAV+Y0MkJ1Jm4J7RBVIsrjdXu7GuOKD9oUHT7IZoH6rlJOum7Zgl
        msjG/1ZTrqe/04tep2SriCR4AQ==
X-Google-Smtp-Source: APXvYqxnC2uMVrjennbToNj8VdCMI+ckmVLgKgzd1CJo3FT41fg7GQyb9+ZSHDwMlxZVGV+MZnKiFQ==
X-Received: by 2002:a50:b155:: with SMTP id l21mr11232219edd.186.1567101182497;
        Thu, 29 Aug 2019 10:53:02 -0700 (PDT)
Received: from cakuba.netronome.com ([66.60.152.14])
        by smtp.gmail.com with ESMTPSA id w3sm562294edq.12.2019.08.29.10.53.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Aug 2019 10:53:02 -0700 (PDT)
Date:   Thu, 29 Aug 2019 10:52:37 -0700
From:   Jakub Kicinski <jakub.kicinski@netronome.com>
To:     YueHaibing <yuehaibing@huawei.com>
Cc:     <thomas.lendacky@amd.com>, <davem@davemloft.net>,
        <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] amd-xgbe: Fix error path in xgbe_mod_init()
Message-ID: <20190829105237.196722f9@cakuba.netronome.com>
In-Reply-To: <20190829024600.16052-1-yuehaibing@huawei.com>
References: <20190829024600.16052-1-yuehaibing@huawei.com>
Organization: Netronome Systems, Ltd.
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 29 Aug 2019 10:46:00 +0800, YueHaibing wrote:
> In xgbe_mod_init(), we should do cleanup if some error occurs
> 
> Reported-by: Hulk Robot <hulkci@huawei.com>
> Fixes: efbaa828330a ("amd-xgbe: Add support to handle device renaming")
> Fixes: 47f164deab22 ("amd-xgbe: Add PCI device support")
> Signed-off-by: YueHaibing <yuehaibing@huawei.com>

Looks correct.

For networking fixes please try to use [PATCH net] as a tag ([PATCH
net-next] for normal, non-fix patches).

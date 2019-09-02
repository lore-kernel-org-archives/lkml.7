Return-Path: <SRS0=8hmg=W5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7AE36C41514
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Sep 2019 14:26:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 506BE21897
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Sep 2019 14:26:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1567434404;
	bh=MmPv0bpf5MFyxonDTK0AA6EWX4f0C8YUPBnOuzMJwT4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=l6AbkO7arHpoK1E1UiE2Db/yWXyFON2U/z4/ECJBVtw8HdfTNdtPrCvxpQQXIxbQe
	 aJOCMDB5umS5fzyCQLTq9dcIDYnljubtU/5SbsNBORx438GbQfvGU/UONejtwGZ23W
	 a/VOJFkwUBH3cGr/2udIgIZHB1n7UqeGCQnyrhJw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731527AbfIBO0n (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 2 Sep 2019 10:26:43 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:47047 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726421AbfIBO0n (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Sep 2019 10:26:43 -0400
Received: by mail-wr1-f68.google.com with SMTP id h7so12896435wrt.13;
        Mon, 02 Sep 2019 07:26:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=ot30V47/iBS0yHDmKdi6h92CwtoqCpzSIGyUdC23LBs=;
        b=DKmJBL62s4BKsitaQZYkjhwsrKPx4BZxwQTWRBG58jPBxXLwKX7n4+LG+aWksU14vn
         3b8HC0m8/d3X1dLfm2GU79CtibBrL6RLL3hpdh6wIFEY64HQcmGj4H+A4T1Ap3ZBeAUb
         IFafW5Q1yHVYSGwMi7g+AdVE9Z29Jpk5demO6o/nWosIehBTi3KnfsVpzome14dmii6m
         RRCnwM3Nec593Y41DZeDdIC6VnRtzn/bTOtM4UrQNU50pssgiJE7mW/L3QjL1DIHFyCv
         Dec9nRkDXpnHomOEUMJQDLA+n5XP7gWwfv8bQDkPs+ICJ9xaeDtr6D4XMim8yvjwF2Fw
         /MrQ==
X-Gm-Message-State: APjAAAWsvCY51Q2D8k+sykQjIW8T25UjuD4h79WuKFynR0/pb8rULcvs
        8SchQ4XvQfjViZmpMIFh7Q==
X-Google-Smtp-Source: APXvYqwrcoUbjAf10BUlLBhioq2RZCRuSUEHDKWeG20TWt9K0tZHjtvEfqHEbFfZ7g0NKNH+PmgRKg==
X-Received: by 2002:a5d:6811:: with SMTP id w17mr1391676wru.181.1567434400948;
        Mon, 02 Sep 2019 07:26:40 -0700 (PDT)
Received: from localhost ([212.187.182.166])
        by smtp.gmail.com with ESMTPSA id h125sm33788405wmf.31.2019.09.02.07.26.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Sep 2019 07:26:40 -0700 (PDT)
Date:   Mon, 2 Sep 2019 15:26:39 +0100
From:   Rob Herring <robh@kernel.org>
To:     Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= 
        <u.kleine-koenig@pengutronix.de>
Cc:     Frank Rowand <frowand.list@gmail.com>, devicetree@vger.kernel.org,
        iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org,
        linux-mediatek@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, kernel@pengutronix.de,
        Will Deacon <will@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>,
        Joerg Roedel <joro@8bytes.org>,
        Matthias Brugger <matthias.bgg@gmail.com>
Subject: Re: [PATCH v1 2/2] of: Let of_for_each_phandle fallback to
 non-negative cell_count
Message-ID: <20190902142639.GA13947@bogus>
References: <20190824132846.8589-1-u.kleine-koenig@pengutronix.de>
 <20190824132846.8589-2-u.kleine-koenig@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20190824132846.8589-2-u.kleine-koenig@pengutronix.de>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Aug 24, 2019 at 03:28:46PM +0200, Uwe Kleine-König wrote:
> Referencing device tree nodes from a property allows to pass arguments.
> This is for example used for referencing gpios. This looks as follows:
> 
> 	gpio_ctrl: gpio-controller {
> 		#gpio-cells = <2>
> 		...
> 	}
> 
> 	someothernode {
> 		gpios = <&gpio_ctrl 5 0 &gpio_ctrl 3 0>;
> 		...
> 	}
> 
> To know the number of arguments this must be either fixed, or the
> referenced node is checked for a $cells_name (here: "#gpio-cells")
> property and with this information the start of the second reference can
> be determined.
> 
> Currently regulators are referenced with no additional arguments. To
> allow some optional arguments without having to change all referenced
> nodes this change introduces a way to specify a default cell_count. So
> when a phandle is parsed we check for the $cells_name property and use
> it as before if present. If it is not present we fall back to
> cells_count if non-negative and only fail if cells_count is smaller than
> zero.
> 
> Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
> ---
>  drivers/of/base.c | 25 +++++++++++++++++--------
>  1 file changed, 17 insertions(+), 8 deletions(-)

Looks fine to me. I can apply with an ack from the iommu folks on patch 
1.

Rob

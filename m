Return-Path: <SRS0=lq4r=TU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 95448C04AAC
	for <linux-kernel@archiver.kernel.org>; Mon, 20 May 2019 11:28:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6B12520863
	for <linux-kernel@archiver.kernel.org>; Mon, 20 May 2019 11:28:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1558351721;
	bh=oXq5PmrUR+iri82vJveI8uZ0P0yyBXZCj0puouX9vZI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=q4QAmQGwOKwtY3jsUiYhnSGsRgvFth5hqP2TTr+IxPwT/iPc1TvY9TSzW4srf2+46
	 IyTuJfxxHNB8liUDJsV/Of6BaMUbZKeUFSTSqSCfTKvPQ6TPdgPN+D5F/XIhsVuRqG
	 +lscBPMBNcSkJ96PaEsOMNS4/OESLwnwB8LQNrsw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732772AbfETL2k (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 May 2019 07:28:40 -0400
Received: from mail.kernel.org ([198.145.29.99]:37352 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731297AbfETL2j (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 May 2019 07:28:39 -0400
Received: from localhost (unknown [37.142.3.125])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B68B920644;
        Mon, 20 May 2019 11:28:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1558351719;
        bh=oXq5PmrUR+iri82vJveI8uZ0P0yyBXZCj0puouX9vZI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=1rOSQagg8SmW4bYkEQNIVOBHEltRE3PqS6FY2keMLz5NJ5q/ax4NwdZZPl4g75t8i
         nD7ytc8d1o7pWYc3410uE4URPt2d7uR+MNo//sqInjI6Vp8zpzGXirDabNUapoeCvY
         wPuj5ccLd3T+UNotAzio3FKWJWUIoHrtBQuKqAGA=
Date:   Mon, 20 May 2019 14:28:35 +0300
From:   Leon Romanovsky <leon@kernel.org>
To:     Michal Kubecek <mkubecek@suse.cz>
Cc:     Doug Ledford <dledford@redhat.com>, Jason Gunthorpe <jgg@ziepe.ca>,
        Ariel Levkovich <lariel@mellanox.com>,
        linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mlx5: avoid 64-bit division
Message-ID: <20190520112835.GF4573@mtr-leonro.mtl.com>
References: <20190520111902.7104DE0184@unicorn.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190520111902.7104DE0184@unicorn.suse.cz>
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 20, 2019 at 01:19:02PM +0200, Michal Kubecek wrote:
> Commit 25c13324d03d ("IB/mlx5: Add steering SW ICM device memory type")
> breaks i386 build by introducing three 64-bit divisions. As the divisor
> is MLX5_SW_ICM_BLOCK_SIZE() which is always a power of 2, we can replace
> the division with bit operations.

Interesting, we tried to solve it differently.
I added it to our regression to be on the same side.

Thanks

Return-Path: <SRS0=21RF=YY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6D2DACA9ECF
	for <linux-kernel@archiver.kernel.org>; Thu, 31 Oct 2019 13:29:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 399E620873
	for <linux-kernel@archiver.kernel.org>; Thu, 31 Oct 2019 13:29:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1572528561;
	bh=CZwLCQC08Yd2rFJN0WaEwbxJ61oj5DVAAFsImEubPO4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=oCMEahMYwZYwnXuAkH/uzrNBvAcNacJdHb5xnzADgNSpSX4FgXglVCQXbTJpAkVaV
	 JuQ2PsA7gxqkvDMRsNWGIpThhIVqst+cxzyHxdeHeyj5uZ2PG8akf8I4AInHmhMLNC
	 qxeoN3utqMr7yac08dOhTWqzBjdNqOMVaxd9oKoI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727257AbfJaN3U (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 31 Oct 2019 09:29:20 -0400
Received: from mail.kernel.org ([198.145.29.99]:40606 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726836AbfJaN3T (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Oct 2019 09:29:19 -0400
Received: from willie-the-truck (236.31.169.217.in-addr.arpa [217.169.31.236])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 34B5520862;
        Thu, 31 Oct 2019 13:29:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1572528559;
        bh=CZwLCQC08Yd2rFJN0WaEwbxJ61oj5DVAAFsImEubPO4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=brqxESrJ8f9jGx5TG2+yTUCdTfm7FBHUPr4S/hC9c9wHbr1cLV+wpLNLgH7jusJPs
         9ttfVk4cbmaCG/yePe3MMuR2pXV3WfEJRQY9sOxPFxGpCYgGNAnJg9n2xwBOZjcewE
         vhqOlEG0CzOxG0LyOLbZi+JCViuZtYUkaO8zG3VU=
Date:   Thu, 31 Oct 2019 13:29:15 +0000
From:   Will Deacon <will@kernel.org>
To:     Bjorn Andersson <bjorn.andersson@linaro.org>, jhugo@codeaurora.org
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org
Subject: Re: [PATCH v2] arm64: cpufeature: Enable Qualcomm Falkor errata 1009
 for Kryo
Message-ID: <20191031132914.GD27196@willie-the-truck>
References: <20191029232738.1483923-1-bjorn.andersson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191029232738.1483923-1-bjorn.andersson@linaro.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[+Jeffrey]

On Tue, Oct 29, 2019 at 04:27:38PM -0700, Bjorn Andersson wrote:
> The Kryo cores share errata 1009 with Falkor, so add their model
> definitions and enable it for them as well.
> 
> Signed-off-by: Bjorn Andersson <bjorn.andersson@linaro.org>
> ---
> 
> Changes since v1:
> - Use is_kryo_midr(), rather than listing each individual model.

Cheers, I've queued this up as a fix.

I also updated the E1009 entry in silicon-errata.rst but, in doing so, I
noticed that E1041 is listed there which apparently also affects
Kry^H^H^HHydra [1].

At which point, maybe we should rename both Kryo and Falkor in the tree
so that we consistently refer to Hydra as the underlying micro-architecture.
Obviously not something for 5.4, but it would sure help me to understand
what's doing on here.

Thoughts?

Will

[1] https://lore.kernel.org/kvmarm/20171115010505.GO11955@codeaurora.org/

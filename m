Return-Path: <SRS0=X8En=XO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7794EC4CEC4
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Sep 2019 03:18:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 454DD21925
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Sep 2019 03:18:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="jKQfI+tv";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="jKQfI+tv"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731062AbfISDSa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 18 Sep 2019 23:18:30 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:50480 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727165AbfISDSa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Sep 2019 23:18:30 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id E216361418; Thu, 19 Sep 2019 03:18:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1568863109;
        bh=QsV/8fQdOXJe1K2A9PF7ZFpmLj/7hgXHE/kdC5ZdvrM=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=jKQfI+tvCa6szr1MwLs9kgRzRydN4ZMHgSp0irIcw2NAA1qCNGRVw79A7UKZmLD/U
         MTL72gi0jyfWJVlRVSr2SxGn8xweI7870oC8l5dAKQ0P28QBW3NTk5n5NAtTDtx/o0
         B22o7hnRcqKlwWE+A0YcdTcaaL77gHmZdGenEvKA=
Received: from mail.codeaurora.org (localhost.localdomain [127.0.0.1])
        by smtp.codeaurora.org (Postfix) with ESMTP id 07A3360767;
        Thu, 19 Sep 2019 03:18:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1568863109;
        bh=QsV/8fQdOXJe1K2A9PF7ZFpmLj/7hgXHE/kdC5ZdvrM=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=jKQfI+tvCa6szr1MwLs9kgRzRydN4ZMHgSp0irIcw2NAA1qCNGRVw79A7UKZmLD/U
         MTL72gi0jyfWJVlRVSr2SxGn8xweI7870oC8l5dAKQ0P28QBW3NTk5n5NAtTDtx/o0
         B22o7hnRcqKlwWE+A0YcdTcaaL77gHmZdGenEvKA=
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Thu, 19 Sep 2019 08:48:28 +0530
From:   Sai Prakash Ranjan <saiprakash.ranjan@codeaurora.org>
To:     Bjorn Andersson <bjorn.andersson@linaro.org>
Cc:     Robin Murphy <robin.murphy@arm.com>, Will Deacon <will@kernel.org>,
        Joerg Roedel <joro@8bytes.org>,
        iommu@lists.linux-foundation.org,
        Stephen Boyd <swboyd@chromium.org>,
        Vivek Gautam <vivek.gautam@codeaurora.org>,
        Andy Gross <agross@kernel.org>, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Rajendra Nayak <rnayak@codeaurora.org>
Subject: Re: [PATCHv6 3/3] iommu: arm-smmu-impl: Add sdm845 implementation
 hook
In-Reply-To: <20190919002501.GA20859@builder>
References: <cover.1568712606.git.saiprakash.ranjan@codeaurora.org>
 <1513424ecec891d19c1aa3c599ec67db7964b6b2.1568712606.git.saiprakash.ranjan@codeaurora.org>
 <20190919002501.GA20859@builder>
Message-ID: <a45e8fb6fe1a8cc914fedbfac65af009@codeaurora.org>
X-Sender: saiprakash.ranjan@codeaurora.org
User-Agent: Roundcube Webmail/1.2.5
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2019-09-19 05:55, Bjorn Andersson wrote:
> In the transition to this new design we lost the ability to
> enable/disable the safe toggle per board, which according to Vivek
> would result in some issue with Cheza.
> 
> Can you confirm that this is okay? (Or introduce the DT property for
> enabling the safe_toggle logic?)
> 

Hmm, I don't remember Vivek telling about any issue on Cheza because of 
this logic.
But I will test this on Cheza and let you know.

Thanks,
Sai

-- 
QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a 
member
of Code Aurora Forum, hosted by The Linux Foundation






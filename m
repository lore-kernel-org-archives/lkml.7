Return-Path: <SRS0=avfD=SQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 828AAC10F13
	for <linux-kernel@archiver.kernel.org>; Sun, 14 Apr 2019 10:23:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4048920848
	for <linux-kernel@archiver.kernel.org>; Sun, 14 Apr 2019 10:23:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1555237403;
	bh=VBnDI7BuWXi79RPGd/VAuHoe7Sz1HcKTrEXRsnuPP0g=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=KtrE8aM74uMdhXiLq4qM0nsWP04t38efh3Ew2hEbB6BxXKpkkeZwSEGI5rfJy0Buy
	 r4RW/HgGFldFYfCzRFigBqjxNrLt9JvLyh+WCgUf/qumHrVSCQibCXiJ08ao9K5liq
	 fhKDeWTwZOMN1nV+mgislPoUXpgT9Q1C8pGVh7QM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726359AbfDNKXW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 14 Apr 2019 06:23:22 -0400
Received: from mail.kernel.org ([198.145.29.99]:39672 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726126AbfDNKXV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 14 Apr 2019 06:23:21 -0400
Received: from localhost (unknown [106.199.53.94])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8E68C20848;
        Sun, 14 Apr 2019 10:23:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1555237401;
        bh=VBnDI7BuWXi79RPGd/VAuHoe7Sz1HcKTrEXRsnuPP0g=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=P7+Kbjqko+9dzBMOKsy5mO/H08KF1OLzAx3n4e1RpMriqSw4CKNrdW0Wx9spk/yDX
         hKnLHiuMy3LdqmMGF2qKBnc1E5zqgu9wppWBajpj4Q6DKAypUvpb4BorWQdR4Zq7uv
         OPy0ZPBdXOS64XM/3HW5mKTfw2ked6OReV8GTnnM=
Date:   Sun, 14 Apr 2019 15:53:14 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Paul Gortmaker <paul.gortmaker@windriver.com>
Cc:     linux-kernel@vger.kernel.org,
        Sanyog Kale <sanyog.r.kale@intel.com>,
        Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Subject: Re: [PATCH] soundwire: intel: fix implicit header use of
 module.h/export.h
Message-ID: <20190414102314.GL28103@vkoul-mobl>
References: <1555168372-15171-1-git-send-email-paul.gortmaker@windriver.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1555168372-15171-1-git-send-email-paul.gortmaker@windriver.com>
User-Agent: Mutt/1.11.3 (2019-02-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 13-04-19, 11:12, Paul Gortmaker wrote:
> These two files are implicitly relying on an instance of including
> module.h from <linux/acpi.h>.
> 
> Ideally, header files under include/linux shouldn't be adding
> includes of other headers, in anticipation of their consumers,
> but just the headers needed for the header itself to pass
> parsing with CPP.
> 
> The module.h is particularly bad in this sense, as it itself does
> include a whole bunch of other headers, due to the complexity of
> module support.
> 
> Here, we make those includes explicit, in order to allow a future
> removal of module.h from linux/acpi.h without causing build breakage.

Applied, thanks

-- 
~Vinod

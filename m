Return-Path: <SRS0=TxL2=YH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 51588ECE587
	for <linux-kernel@archiver.kernel.org>; Mon, 14 Oct 2019 16:43:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 27F25217D9
	for <linux-kernel@archiver.kernel.org>; Mon, 14 Oct 2019 16:43:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1571071400;
	bh=jUkpYa09cbg1NzerOrin8aZ7t3IhBLvxGwVjSWwxP/4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=lOvrZ4RtNPgyuUv1gRZe6G5zTjC9F1r0fvYYjIJ4SzmSc+LVAADdnktka2233Pvx9
	 kD/usixtvuZF7HD6KSM3xUyyjG87IHy2Sv5Z4kR/5sgKj0E2xqze3lTXMKL4sC7FHs
	 b4O+RtAH468Ohcthb0M6aosAZOlsKMIpIQGyLzy4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388166AbfJNQnT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 14 Oct 2019 12:43:19 -0400
Received: from mail.kernel.org ([198.145.29.99]:41286 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727038AbfJNQnS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Oct 2019 12:43:18 -0400
Received: from willie-the-truck (236.31.169.217.in-addr.arpa [217.169.31.236])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 198E020663;
        Mon, 14 Oct 2019 16:43:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1571071398;
        bh=jUkpYa09cbg1NzerOrin8aZ7t3IhBLvxGwVjSWwxP/4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=c/Zw+j9iow5A3WE1EqcqrrZM1mcChVGUdIlChBTLsWqihd5EbBNpKFtHUO82WI21j
         H1RdbzXkdW8CARvqTt7gJaoWHEVzeBtJ5MkhsI8TKYUS5uX1YydYJ8qjh5DMLV0351
         hvZ7PCqAJPZIY2Xl0EV7mknvJX2/l9RBzNySfwjY=
Date:   Mon, 14 Oct 2019 17:43:14 +0100
From:   Will Deacon <will@kernel.org>
To:     Julien Grall <julien.grall@arm.com>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        catalin.marinas@arm.com, suzuki.poulose@arm.com,
        Dave.Martin@arm.com
Subject: Re: [PATCH] arm64: cpufeature: Don't expose ZFR0 to userspace when
 SVE is not enabled
Message-ID: <20191014164313.hu2dnf5rokntzhhp@willie-the-truck>
References: <20191014102113.16546-1-julien.grall@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191014102113.16546-1-julien.grall@arm.com>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 14, 2019 at 11:21:13AM +0100, Julien Grall wrote:
> The kernel may not support SVE if CONFIG_ARM64_SVE is not set and
> will hide the feature from the from userspace.

I don't understand this sentence.

> Unfortunately, the fields of ID_AA64ZFR0_EL1 are still exposed and could
> lead to undefined behavior in userspace.

Undefined in what way? Generally, we can't stop exposing things that
we've exposed previously in case somebody has started relying on them, so
this needs better justification.

Will

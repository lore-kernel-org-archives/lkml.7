Return-Path: <SRS0=1LW7=ZA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 123D8FA372C
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Nov 2019 10:54:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D35C6218AE
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Nov 2019 10:53:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1573210439;
	bh=buqRYk91CqloV76evPL2h1lSIokb0ciicaCxu+V6YwU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=d0vsh38jycgK+jRzQaht2NVWF6Q3HVFOiZ36q0aeLixHj5URi2tdGBkaqNx9Kkk6r
	 gawoo1spsSysVpTIijFCWyuFhhrNst2zkJ8mHmDqwI4FDy1kbvKdAkoQa+zSkz2WyJ
	 7lChiHb4ZiX976CmMqGkj4algc0F217pOw+53aj8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731378AbfKHKx7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 Nov 2019 05:53:59 -0500
Received: from mail.kernel.org ([198.145.29.99]:36020 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726180AbfKHKx6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Nov 2019 05:53:58 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9A414218AE;
        Fri,  8 Nov 2019 10:53:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1573210438;
        bh=buqRYk91CqloV76evPL2h1lSIokb0ciicaCxu+V6YwU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=NVUpSeKMJL7hqL3XLCQCJdJCm3URp4Xc9BEKczdiaWfbatykKJURNZwQYqdDy6ZHb
         8tgJQFYXj0Ro+REVyLpeOMxlmrstDqSTIKLP7TYUp9CEVt2o9LvLhrYFrTDTe1P1eW
         1aO5l2+mP5Qa/BWr7BTyH1Zo1Tq4V/9Byz3adNe8=
Date:   Fri, 8 Nov 2019 11:53:55 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Georgi Djakov <georgi.djakov@linaro.org>
Cc:     Linux PM list <linux-pm@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [GIT PULL v2] interconnect changes for 5.5
Message-ID: <20191108105355.GA683899@kroah.com>
References: <dd4ff7e3-920d-979b-c29b-7535d84d360f@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <dd4ff7e3-920d-979b-c29b-7535d84d360f@linaro.org>
User-Agent: Mutt/1.12.2 (2019-09-21)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 08, 2019 at 10:59:11AM +0200, Georgi Djakov wrote:
> Hi Greg,
> 
> This is the updated pull request with interconnect patches for the 5.5 merge
> window. The details are in the signed tag. Please pull into char-misc-next.

Ugh, ok, can we just go back to sending patches instead?

The first two patches have "Fixes:" tags for older kernels, yet no
stable tags.  That's not ok.

For patch 5, you are playing "chicken" with what module gets loaded
first, and in the end you're not going to win, only delay the
inevitable.  We now have the driver core framework to support
dependencies like this, please use that instead.

So, can you drop patch 5, fix up patches 1 and 2, and go back to sending
patches instead of pull requests as if these were patches, I could have
fixed up 1 and 2 myself.

thanks,

greg k-h

Return-Path: <SRS0=TDKO=W6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C21DBC3A5A7
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Sep 2019 17:03:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8FA4822CF8
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Sep 2019 17:03:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1567530231;
	bh=bUxrgGlb8IHuXCYAMMq77/WS81cga4wFl4/4NHV4vUY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=lvyXkMaORkcodONydh+DhtJUtr65uZ5hVcp9kA5mVJRTCRq2032FBVW9KA3RotKcP
	 +QLAIuK6V86t5LTq9tA4I51dFKihKvNP12lNDmsc+Qhf3RYP1xR6sv5VBn0HglG5Sy
	 EM1W8T/ntaH0hZhMTLMvOcvZmaFaqFX24+3NecgQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729983AbfICRDv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 Sep 2019 13:03:51 -0400
Received: from mail.kernel.org ([198.145.29.99]:43528 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728571AbfICRDu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Sep 2019 13:03:50 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0D5D420870;
        Tue,  3 Sep 2019 17:03:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1567530229;
        bh=bUxrgGlb8IHuXCYAMMq77/WS81cga4wFl4/4NHV4vUY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=OHKxoV8KAhi5j/+jXWiyEvFrA4baZFbh5q/p80iksz40TIwAQH7c/RXWhKo52vBlJ
         896IW37U3vdTzP4AddqJjMiST0edVTl3lJX1xhlGZi0AtwvLaNZE3PbT2TwVVgP6sH
         U74lxkE6ropWeeWaoWiaRHE3jgt9Sub63wsQyZAg=
Date:   Tue, 3 Sep 2019 19:03:47 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Michel =?iso-8859-1?Q?D=E4nzer?= <michel@daenzer.net>
Cc:     Sasha Levin <sashal@kernel.org>, linux-kernel@vger.kernel.org,
        stable@vger.kernel.org, Yu Zhao <yuzhao@google.com>,
        dri-devel@lists.freedesktop.org, amd-gfx@lists.freedesktop.org,
        Alex Deucher <alexander.deucher@amd.com>
Subject: Re: [PATCH AUTOSEL 4.19 044/167] drm/amdgpu: validate user pitch
 alignment
Message-ID: <20190903170347.GA24357@kroah.com>
References: <20190903162519.7136-1-sashal@kernel.org>
 <20190903162519.7136-44-sashal@kernel.org>
 <7957107d-634f-4771-327e-99fdd5e6474e@daenzer.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <7957107d-634f-4771-327e-99fdd5e6474e@daenzer.net>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 03, 2019 at 06:40:43PM +0200, Michel Dänzer wrote:
> On 2019-09-03 6:23 p.m., Sasha Levin wrote:
> > From: Yu Zhao <yuzhao@google.com>
> > 
> > [ Upstream commit 89f23b6efef554766177bf51aa754bce14c3e7da ]
> 
> Hold your horses!
> 
> This commit and c4a32b266da7bb702e60381ca0c35eaddbc89a6c had to be
> reverted, as they caused regressions. See commits
> 25ec429e86bb790e40387a550f0501d0ac55a47c &
> 92b0730eaf2d549fdfb10ecc8b71f34b9f472c12 .
> 
> 
> This isn't bolstering confidence in how these patches are selected...

The patch _itself_ said to be backported to the stable trees from 4.2
and newer.  Why wouldn't we be confident in doing this?

If the patch doesn't want to be backported, then do not add the cc:
stable line to it...

greg k-h

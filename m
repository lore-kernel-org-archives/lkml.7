Return-Path: <SRS0=54v9=YS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 64322CA9EA0
	for <linux-kernel@archiver.kernel.org>; Fri, 25 Oct 2019 16:18:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2D29421872
	for <linux-kernel@archiver.kernel.org>; Fri, 25 Oct 2019 16:18:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1572020293;
	bh=zsbdQvfJ8+q2pzusFNOjjDgO2fdiHgeruyB2BpqAhfI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=oNuF9QhWUBhqfxfOtzhlmkwpFPt2+QxQs9A5QYK/oNH2F5Nanaiakb2QUKJkWVAI1
	 3qy9rivIyYCOL+yrrQyelrNRU9k6qlgw/rJaK4CC2q1GgqwZWisACOa9UzVArWkFZB
	 1A4hr0hKu2qc7UttXUAXtBYTrw7JicT/YJpa1NaM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2505397AbfJYQSL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 25 Oct 2019 12:18:11 -0400
Received: from mail.kernel.org ([198.145.29.99]:53948 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2502249AbfJYQSK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Oct 2019 12:18:10 -0400
Received: from willie-the-truck (236.31.169.217.in-addr.arpa [217.169.31.236])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id BD2C52070B;
        Fri, 25 Oct 2019 16:18:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1572020290;
        bh=zsbdQvfJ8+q2pzusFNOjjDgO2fdiHgeruyB2BpqAhfI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=xZzvdjENaVD+2lcGJUR9ncW0e/IAWYPqJbGh8SjuU974cfTjPci7a1yS7CbMd1/wW
         OxngfQ0N1MCIciK9J5iEWHkLlUnuii6I/QMRQ73fJf4JWT0jxhWvyPNN+nna6rVeuQ
         S2hUAUno8hbubl5rLAD8IF9rI4t2+Ney4qYUA7Io=
Date:   Fri, 25 Oct 2019 17:18:05 +0100
From:   Will Deacon <will@kernel.org>
To:     Michel =?iso-8859-1?Q?D=E4nzer?= <michel@daenzer.net>
Cc:     amd-gfx@lists.freedesktop.org, David Airlie <airlied@linux.ie>,
        linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
        Nicolas Waisman <nico@semmle.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        Christian =?iso-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>
Subject: Re: [PATCH] drm/radeon: Handle workqueue allocation failure
Message-ID: <20191025161804.GA12335@willie-the-truck>
References: <20191025110450.10474-1-will@kernel.org>
 <5d6a88a2-2719-a859-04df-10b0d893ff39@daenzer.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <5d6a88a2-2719-a859-04df-10b0d893ff39@daenzer.net>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 25, 2019 at 06:06:26PM +0200, Michel Dänzer wrote:
> On 2019-10-25 1:04 p.m., Will Deacon wrote:
> > In the highly unlikely event that we fail to allocate the "radeon-crtc"
> > workqueue, we should bail cleanly rather than blindly march on with a
> > NULL pointer installed for the 'flip_queue' field of the 'radeon_crtc'
> > structure.
> > 
> > This was reported previously by Nicolas, but I don't think his fix was
> > correct:
> 
> Neither is this one I'm afraid. See my feedback on
> https://patchwork.freedesktop.org/patch/331534/ .

Thanks. Although I agree with you wrt the original patch, I don't think
the workqueue allocation failure is distinguishable from the CRTC allocation
failure with my patch. Are you saying that the error path there is broken
too?

Will

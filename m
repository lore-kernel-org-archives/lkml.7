Return-Path: <SRS0=rNeM=SR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 171DEC282DA
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Apr 2019 10:50:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D190720848
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Apr 2019 10:50:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1555325433;
	bh=JD5n8gS0SRDb1g7rxAZgjdC9oGr8jTO7DkLLkKVx/NQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=Mbx0PbIKbKM+74mpZwd3FIE1gc24/5Zf09hGyIKZHSv7CQlpPLfoUPY1DxYeCy3lL
	 IubJl60BVpJWOiSvU/OS3PWpCyHIqZUSMiAF5u7CouDPTxzbuQ7oR3HiWRuYFcGTrz
	 +U1cYvicHw7U/JwoCHwiP3WliIC3QDEUvQ42dUB4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727246AbfDOKuc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Apr 2019 06:50:32 -0400
Received: from mail.kernel.org ([198.145.29.99]:52798 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725939AbfDOKuc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Apr 2019 06:50:32 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4EB85206B6;
        Mon, 15 Apr 2019 10:50:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1555325431;
        bh=JD5n8gS0SRDb1g7rxAZgjdC9oGr8jTO7DkLLkKVx/NQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=1V7be9OyllFGkwhxjBZusNJBOQx7ceKOFhveI/+J9zWUmqW3bPsDQLs8bIph0F378
         1L3TXddVbbOY7NSlFwnmL5qrqJn2beql2eM9l8lyzXeEgoy5hduq4OrbdxJwE+LaQB
         IjheV9Kfynv9LIxkZ4Dml/436LeUI9+vYWrQSCjk=
Date:   Mon, 15 Apr 2019 12:50:29 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Mathias =?iso-8859-1?Q?Fr=F6hlich?= <Mathias.Froehlich@gmx.net>
Cc:     linux-kernel@vger.kernel.org, stable@vger.kernel.org,
        Leo Li <sunpeng.li@amd.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH 5.0 072/246] drm/amd/display: Fix reference counting for
 struct dc_sink.
Message-ID: <20190415105029.GC9397@kroah.com>
References: <20190404084619.236418459@linuxfoundation.org>
 <20190404084621.660309707@linuxfoundation.org>
 <4990954.l4Ku8jBaGM@notebook.internal>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <4990954.l4Ku8jBaGM@notebook.internal>
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 05, 2019 at 07:12:47AM +0200, Mathias Fröhlich wrote:
> Greg,
> 
> as I mentioned in the commit message, I saw more fixes to that area in Alex
> Deuchers queue when I fed that to Alex. There is one fix that I can think of
> that interacts with my fixes. Means, we may get unwanted side effects of my
> patch without the fix mentioned below. With that below patch also selected,
> I think we should be ok for stable.
> Alex, AMD people, your opinion?
> 
> The one that I can spot not already in linux-5.0.y is:
> 
> commit 3f01f098a4e2ef30ef628497c43a3d568e720376
> Author: Jerry (Fangzhi) Zuo <Jerry.Zuo@amd.com>
> Date:   Thu Jan 24 11:46:49 2019 -0500
> 
>     drm/amd/display: Clear dc_sink after it gets released
>     
>     [Why]
>     The dc_sink was released but the pointer on the aconnector was
>     not cleared.
>     
>     [How]
>     Clear it.

This patch does not apply to the 5.0.y tree, so I can not queue it up :(

thanks,

greg k-h

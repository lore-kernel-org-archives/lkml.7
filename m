Return-Path: <SRS0=Qu8K=R7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 37AC6C10F03
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Mar 2019 10:13:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 122EB20811
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Mar 2019 10:13:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726441AbfC1KNx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Mar 2019 06:13:53 -0400
Received: from atrey.karlin.mff.cuni.cz ([195.113.26.193]:37918 "EHLO
        atrey.karlin.mff.cuni.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725779AbfC1KNw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Mar 2019 06:13:52 -0400
Received: by atrey.karlin.mff.cuni.cz (Postfix, from userid 512)
        id EDC6E8041A; Thu, 28 Mar 2019 11:13:42 +0100 (CET)
Date:   Thu, 28 Mar 2019 11:13:42 +0100
From:   Pavel Machek <pavel@ucw.cz>
To:     Sasha Levin <sashal@kernel.org>
Cc:     linux-kernel@vger.kernel.org, stable@vger.kernel.org,
        Douglas Anderson <dianders@chromium.org>,
        Steven Rostedt <rostedt@goodmis.org>
Subject: Re: [PATCH AUTOSEL 5.0 011/262] tracing: kdb: Fix ftdump to not sleep
Message-ID: <20190328101342.GD19456@atrey.karlin.mff.cuni.cz>
References: <20190327180158.10245-1-sashal@kernel.org>
 <20190327180158.10245-11-sashal@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190327180158.10245-11-sashal@kernel.org>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> From: Douglas Anderson <dianders@chromium.org>
> 
> [ Upstream commit 31b265b3baaf55f209229888b7ffea523ddab366 ]
> 
> As reported back in 2016-11 [1], the "ftdump" kdb command triggers a
> BUG for "sleeping function called from invalid context".
> 
> kdb's "ftdump" command wants to call ring_buffer_read_prepare() in
> atomic context.  A very simple solution for this is to add allocation
> flags to ring_buffer_read_prepare() so kdb can call it without
> triggering the allocation error.  This patch does that.

I see solution is simple, but now we have a loop with GFP_ATOMIC
allocations inside. How many "tracing spus" is this expected to loop
over? Will not it exhaust atomically available pages and reliably fail
in common configurations?  
								Pavel

-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html

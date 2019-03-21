Return-Path: <SRS0=/BZh=RY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9B799C10F00
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Mar 2019 08:49:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 69171218D4
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Mar 2019 08:49:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1553158187;
	bh=5KQPm2auJSmNWxdsP45ZefV2O/Vrn282EUGoowkq2bY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=VyQlZUAQT2wOzw5GVy3gj6B8iIJ0mD5yNKvpoVVFyb2hkHGcnp9s67hi0ldkCnIpp
	 3lzZs/e2Pfqtf0G0c3uxKbKXoLIdmzvKKJligVsf9pCZSy9cbTjE61kdzFVI1Y6aQ9
	 Ztzqb4SyHH1VC/JIWCW88Ntgn3JAdQep+LG6gJsM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728213AbfCUItp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Mar 2019 04:49:45 -0400
Received: from mx2.suse.de ([195.135.220.15]:41176 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728040AbfCUItn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Mar 2019 04:49:43 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 35A5FACBC;
        Thu, 21 Mar 2019 08:49:42 +0000 (UTC)
Date:   Thu, 21 Mar 2019 09:49:40 +0100
From:   Michal Hocko <mhocko@kernel.org>
To:     Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
Cc:     Petr Mladek <pmladek@suse.com>,
        Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        John Ogness <john.ogness@linutronix.de>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org
Subject: Re: ratelimit API: was: [RFC PATCH] printk: Introduce "store now but
 print later" prefix.
Message-ID: <20190321084940.GL8696@dhcp22.suse.cz>
References: <6b97b4bb-a9b9-75b3-17a2-bff99ae7c526@i-love.sakura.ne.jp>
 <20190304142339.mfno5mmjxxsrf47q@pathway.suse.cz>
 <201903050123.x251N312025685@www262.sakura.ne.jp>
 <20190306100404.jzfk7oqsh3turqth@pathway.suse.cz>
 <0fc95fee-8b6e-5ff0-9a91-9e0ea66028f3@i-love.sakura.ne.jp>
 <20190320152516.3gbmaj5xoyxkivyt@pathway.suse.cz>
 <0316a449-e7ef-7ca5-2569-f3f2ebebbde9@i-love.sakura.ne.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0316a449-e7ef-7ca5-2569-f3f2ebebbde9@i-love.sakura.ne.jp>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu 21-03-19 17:13:54, Tetsuo Handa wrote:
> On 2019/03/21 0:25, Petr Mladek wrote:
> >> This requires serialization among threads using "rs". I already
> >> proposed ratelimit_reset() for memcg's OOM problem at
> >> https://lkml.kernel.org/r/201810180246.w9I2koi3011358@www262.sakura.ne.jp
> >> but it was not accepted.
> > 
> > IMHO, the main problem was that the patch tried to work around
> > the ratelimit API weakness by a custom code.
> > 
> > I believe that using an improved/extended ratelimit API with
> > a sane semantic would be more acceptable.
> > 
> 
> Michal, are you OK to use ratelimit_reset() in out_of_memory()
> if ratelimit_reset() is accepted?

I do not know what ratelimit_reset is but if that is a new API for
a more reasonable ratelimiting then sure, I do not have any objections.
I have been objecting to one-off hacks to workaround problems of the
existing api.

-- 
Michal Hocko
SUSE Labs

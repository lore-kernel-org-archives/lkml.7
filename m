Return-Path: <SRS0=WRlz=SV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	USER_AGENT_MUTT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7BD47C282DF
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Apr 2019 18:32:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 40FDD20449
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Apr 2019 18:32:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1555698726;
	bh=+3MCTwdWw5c6rXVxCKBn8p5OSb2Kx/KJ7WrMR9gfXg0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=qKdmEBYcEI5xH600WjwxYp++kxbsHcPruUbylwRxW2XjnwQn+Tfn+VhplJUE7c5TF
	 DbOZC4NEfsLoQPfYQwkFlwTH1OHZ/DCkkmurVdQ5F8NkocJTp2i9gyMyqVssqf2G4f
	 0yGdnhDiCXX4w2F9LBuaIXUBL1f/w9VTHmIQOBHM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727950AbfDSScF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 19 Apr 2019 14:32:05 -0400
Received: from mail.kernel.org ([198.145.29.99]:53916 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727827AbfDSS3R (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Apr 2019 14:29:17 -0400
Received: from localhost (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B7616222AE;
        Fri, 19 Apr 2019 13:32:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1555680751;
        bh=+3MCTwdWw5c6rXVxCKBn8p5OSb2Kx/KJ7WrMR9gfXg0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ru6q5BuvRuJEYc0Lt/wzKh77J/z20FBCSRgghM1i4Z1WF+lTixU3gNL6yfWjDzO1m
         XvAjixFxOPhteMdTJhPLk9L8C7lX8sxe2VWTx6ARNLMRCvQoPuLcxKtHttpqc8e9nI
         mHkKyadnu6dKwEDkxGjx2ENy55J8AL4SCMgnDBpg=
Date:   Fri, 19 Apr 2019 09:32:29 -0400
From:   Sasha Levin <sashal@kernel.org>
To:     nobuhiro1.iwamatsu@toshiba.co.jp
Cc:     gregkh@linuxfoundation.org, stable@vger.kernel.org,
        rdunlap@infradead.org, axboe@kernel.dk,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 5.0 19/93] paride/pcd: cleanup queues when detection fails
Message-ID: <20190419133229.GD17719@sasha-vm>
References: <20190418160436.781762249@linuxfoundation.org>
 <20190418160438.746819159@linuxfoundation.org>
 <TYAPR01MB418948D3F208E92CB2C6B32692270@TYAPR01MB4189.jpnprd01.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <TYAPR01MB418948D3F208E92CB2C6B32692270@TYAPR01MB4189.jpnprd01.prod.outlook.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 19, 2019 at 07:13:07AM +0000, nobuhiro1.iwamatsu@toshiba.co.jp wrote:
>Hi,
>
>> [ Upstream commit 81b74ac68c28fddb3589ad5d4d5e587baf4bb781 ]
>>
>> The driver allocates queues for all the units it potentially
>> supports. But if we fail to detect any drives, then we fail
>> loading the module without cleaning up those queues. This is
>> now evident with the switch to blk-mq, though the bug has
>> been there forever as far as I can tell.
>>
>> Also fix cleanup through regular module exit.
>>
>> Reported-by: Randy Dunlap <rdunlap@infradead.org>
>> Tested-by: Randy Dunlap <rdunlap@infradead.org>
>> Signed-off-by: Jens Axboe <axboe@kernel.dk>
>> Signed-off-by: Sasha Levin <sashal@kernel.org>
>
>This commit causes a new problem. And the commit that made the fix
>is f0d1762554014ce0ae347b9f0d088f2c157c8c72.
>I think this commit needs to be applied together.

Queued up this fix, thanks!

--
Thanks,
Sasha

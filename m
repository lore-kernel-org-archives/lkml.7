Return-Path: <SRS0=WRlz=SV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 26C55C282DA
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Apr 2019 18:33:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E03CC204EC
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Apr 2019 18:33:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1555698806;
	bh=LCByuqS9q3i5zn3DMZgsq0fNEVO8mhG+k2JFsvdFVL4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=s5kO6HmsiM3dhSIZZyM84qVOx+pVsaC9kzW9TnZL58pNFTFnfzRBRv13wuFXm0AG0
	 a6fL4/o/H38a0QYKPO7S8z/NYlNGtuUt4iXW1NIfN5NSta/ZEvR7cVcDeCXKerd3we
	 oedYDGRYHqa/0BmGflbbPqivZK/XmsG21Ae21V4E=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728090AbfDSSdX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 19 Apr 2019 14:33:23 -0400
Received: from mail.kernel.org ([198.145.29.99]:53874 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727651AbfDSS3Q (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Apr 2019 14:29:16 -0400
Received: from localhost (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7D51D222AA;
        Fri, 19 Apr 2019 13:30:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1555680657;
        bh=LCByuqS9q3i5zn3DMZgsq0fNEVO8mhG+k2JFsvdFVL4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=jHcGvVsGdWwDm1LERUBg35Jwx1ivtGCk9Eyvv9UMpf1qGjWsihW/i0lDG/WoVmd+I
         Sz0K/J+0KYbqZAPuxewCL45ispv8UvzhcZQAHzjJ+ZN9BWcODibLCKyQgTHF3KYJ2F
         L6B7sNgBozewvM0muyBdk0s3xzQwE3vzG7vV7M94=
Date:   Fri, 19 Apr 2019 09:30:56 -0400
From:   Sasha Levin <sashal@kernel.org>
To:     nobuhiro1.iwamatsu@toshiba.co.jp
Cc:     gregkh@linuxfoundation.org, stable@vger.kernel.org,
        rdunlap@infradead.org, axboe@kernel.dk,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 5.0 18/93] paride/pf: cleanup queues when detection fails
Message-ID: <20190419133056.GC17719@sasha-vm>
References: <20190418160436.781762249@linuxfoundation.org>
 <20190418160438.663257972@linuxfoundation.org>
 <TYAPR01MB4189C6A8BFFF81A47F6FE92792270@TYAPR01MB4189.jpnprd01.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <TYAPR01MB4189C6A8BFFF81A47F6FE92792270@TYAPR01MB4189.jpnprd01.prod.outlook.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 19, 2019 at 07:13:40AM +0000, nobuhiro1.iwamatsu@toshiba.co.jp wrote:
>Hi,
>
>> [ Upstream commit 6ce59025f1182125e75c8d121daf44056b65dd1f ]
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
>is 58ccd2d31e502c37e108b285bf3d343eb00c235b.
>I think this commit needs to be applied together.

I've queued up this fix, thank you!

--
Thanks,
Sasha

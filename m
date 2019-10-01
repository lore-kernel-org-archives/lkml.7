Return-Path: <SRS0=YRFP=X2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4460FC352AA
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Oct 2019 14:30:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0B4E721906
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Oct 2019 14:30:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1569940238;
	bh=tP7RCvEbzIaJlmJdGGsTmP87zeFxDfN1vsHcqjIyPqk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=jSlECp9vJL9meloIU2GX7XUCdn2zne6V8wvwFe7JoyGNSlSPCv5ShiDcE6zYHXGG4
	 ZM4btsWlRJXcC3K8tZCqWhEyW2k6ygw9rnet9YiM+50hHYaiODtsS2CvBu7oVx530C
	 jBhkEtyKfed4JKlzXt03RIrWHkE65r13/adEGSZQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389030AbfJAOah (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 1 Oct 2019 10:30:37 -0400
Received: from mail.kernel.org ([198.145.29.99]:39420 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388891AbfJAOah (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Oct 2019 10:30:37 -0400
Received: from localhost (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 247152086A;
        Tue,  1 Oct 2019 14:30:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1569940236;
        bh=tP7RCvEbzIaJlmJdGGsTmP87zeFxDfN1vsHcqjIyPqk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=lZvD4CnX8ONT4otE5cDFdiaurTDkXerUxA0fiPduF44DCg0bvnCsjNkGU0XT72XTo
         /EXwMZyWn45/h+cQ2YPzvsd0SCbbCacA60bopujwzjcpfIa3CyDGyiakSyL1Jzo3CK
         QG7ozMk8Ux9eVQx6k3v4uxJvXUHc/z3Y4kdVFejc=
Date:   Tue, 1 Oct 2019 10:30:35 -0400
From:   Sasha Levin <sashal@kernel.org>
To:     Sakari Ailus <sakari.ailus@iki.fi>
Cc:     linux-kernel@vger.kernel.org, stable@vger.kernel.org,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        linux-media@vger.kernel.org
Subject: Re: [PATCH AUTOSEL 5.3 084/203] media: omap3isp: Don't set streaming
 state on random subdevs
Message-ID: <20191001143035.GV8171@sasha-vm>
References: <20190922184350.30563-1-sashal@kernel.org>
 <20190922184350.30563-84-sashal@kernel.org>
 <20190923071942.GJ5525@valkosipuli.retiisi.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20190923071942.GJ5525@valkosipuli.retiisi.org.uk>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 23, 2019 at 10:19:42AM +0300, Sakari Ailus wrote:
>Hi Sasha,
>
>On Sun, Sep 22, 2019 at 02:41:50PM -0400, Sasha Levin wrote:
>> From: Sakari Ailus <sakari.ailus@linux.intel.com>
>>
>> [ Upstream commit 7ef57be07ac146e70535747797ef4aee0f06e9f9 ]
>>
>> The streaming state should be set to the first upstream sub-device only,
>> not everywhere, for a sub-device driver itself knows how to best control
>> the streaming state of its own upstream sub-devices.
>>
>> Signed-off-by: Sakari Ailus <sakari.ailus@linux.intel.com>
>> Reviewed-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
>> Signed-off-by: Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
>> Signed-off-by: Sasha Levin <sashal@kernel.org>
>
>I don't disagree with this going to the stable trees as well, but in that
>case it *must* be accompanied by commit e9eb103f0277 ("media: omap3isp: Set
>device on omap3isp subdevs") or the driver will mostly cease to work.
>
>Could you pick that up as well?

Sure, I've queued it as well, thank you.

--
Thanks,
Sasha

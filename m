Return-Path: <SRS0=TDKO=W6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 181F2C3A5A7
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Sep 2019 20:01:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D515421897
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Sep 2019 20:01:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1567540903;
	bh=8IoII2n9C/TCOkc678nbcBwVHhhtTdLM2AVpeiA6uaI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=yM4PdgbZe5IX3JT2WEZcEuHyCxz5q2qHEfcGb8jchThpyu7QEwYljg3brC/4c/c6O
	 6xq/kKFCcNdZ6TWX4XrYXqyzzG4kpYKNc0S7968mQ5JRfEKNEAXxq3P4TrNcZ4eTmz
	 I1JnFICCO+L6ahzeWVBOLRKEbUiaapl7ZnMDShpw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726649AbfICUBm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 Sep 2019 16:01:42 -0400
Received: from mail.kernel.org ([198.145.29.99]:47600 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725939AbfICUBl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Sep 2019 16:01:41 -0400
Received: from localhost (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9A84821881;
        Tue,  3 Sep 2019 20:01:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1567540900;
        bh=8IoII2n9C/TCOkc678nbcBwVHhhtTdLM2AVpeiA6uaI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=l5SKO1WB6Tt9zijJa1tqc7RReLLGhR8WvGG0eq5XOUZ52tbbmNzgLVyNe5svU9CQd
         091vLYWKFeESf2N+GDEXSWANWJJBTfatlbv+/8w7AV+JOMZnTdCw3hSGWfQijUBY4y
         E30ECyBZYkC6HiikEzSXx34mtJs05AUj05QyNFmk=
Date:   Tue, 3 Sep 2019 16:01:39 -0400
From:   Sasha Levin <sashal@kernel.org>
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     Michel =?iso-8859-1?Q?D=E4nzer?= <michel@daenzer.net>,
        linux-kernel@vger.kernel.org, stable@vger.kernel.org,
        Yu Zhao <yuzhao@google.com>, dri-devel@lists.freedesktop.org,
        amd-gfx@lists.freedesktop.org,
        Alex Deucher <alexander.deucher@amd.com>
Subject: Re: [PATCH AUTOSEL 4.19 044/167] drm/amdgpu: validate user pitch
 alignment
Message-ID: <20190903200139.GJ5281@sasha-vm>
References: <20190903162519.7136-1-sashal@kernel.org>
 <20190903162519.7136-44-sashal@kernel.org>
 <7957107d-634f-4771-327e-99fdd5e6474e@daenzer.net>
 <20190903170347.GA24357@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1; format=flowed
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20190903170347.GA24357@kroah.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 03, 2019 at 07:03:47PM +0200, Greg KH wrote:
>On Tue, Sep 03, 2019 at 06:40:43PM +0200, Michel Dänzer wrote:
>> On 2019-09-03 6:23 p.m., Sasha Levin wrote:
>> > From: Yu Zhao <yuzhao@google.com>
>> >
>> > [ Upstream commit 89f23b6efef554766177bf51aa754bce14c3e7da ]
>>
>> Hold your horses!
>>
>> This commit and c4a32b266da7bb702e60381ca0c35eaddbc89a6c had to be
>> reverted, as they caused regressions. See commits
>> 25ec429e86bb790e40387a550f0501d0ac55a47c &
>> 92b0730eaf2d549fdfb10ecc8b71f34b9f472c12 .
>>
>>
>> This isn't bolstering confidence in how these patches are selected...
>
>The patch _itself_ said to be backported to the stable trees from 4.2
>and newer.  Why wouldn't we be confident in doing this?
>
>If the patch doesn't want to be backported, then do not add the cc:
>stable line to it...

This patch was picked because it has a stable tag, which you presumably
saw as your Reviewed-by tag is in the patch. This is why it was
backported; it doesn't take AI to backport patches tagged for stable...

The revert of this patch, however:

 1. Didn't have a stable tag.
 2. Didn't have a "Fixes:" tag.
 3. Didn't have the usual "the reverts commit ..." string added by git
 when one does a revert.

Which is why we still kick patches for review, even though they had a
stable tag, just so people could take a look and confirm we're not
missing anything - like we did here.

I'm not sure what you expected me to do differently here.

--
Thanks,
Sasha

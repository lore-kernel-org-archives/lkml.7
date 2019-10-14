Return-Path: <SRS0=TxL2=YH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F397EECE58C
	for <linux-kernel@archiver.kernel.org>; Mon, 14 Oct 2019 04:20:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CC78620854
	for <linux-kernel@archiver.kernel.org>; Mon, 14 Oct 2019 04:20:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1571026826;
	bh=UH2FJJjoCiU1qjfvJdipEMpbtiUAiR4aZAvbE8vj8tk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=Bu5Sz88zwCuhuOd3+KVLcfFf4JZILiLwi8PL7Yk8OnuVwes1Bv6fIJrOqJSphq6po
	 c0d3n4oc1Fs3OVTpV77m1Dq312437zi1e66Y/LKV6544CHU60VjyVbvNePfXahylyJ
	 CuNQkQjOVaOeA/awtUv5JJ5rJNZPgrVpoSPcL8Uw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726582AbfJNEUZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 14 Oct 2019 00:20:25 -0400
Received: from mail.kernel.org ([198.145.29.99]:39452 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725798AbfJNEUZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Oct 2019 00:20:25 -0400
Received: from localhost (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 801A720854;
        Mon, 14 Oct 2019 04:20:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1571026824;
        bh=UH2FJJjoCiU1qjfvJdipEMpbtiUAiR4aZAvbE8vj8tk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=H0+Wh8I+gixteWTFO3OBe8C0/dCgOvHBarOR15vWaTFaD6rszavLVIUgcIsB/xuTH
         /MZVojICmdgwgD9ehm8/FFMy0DFII0E8Wus1OD7/ufAi59bVBlcXTIRj+MqsNN+gUU
         KZgmDbPnr5btDxg+PEjLNXjJO3EUfgye3B8UqQlg=
Date:   Mon, 14 Oct 2019 00:20:23 -0400
From:   Sasha Levin <sashal@kernel.org>
To:     Andrew Macks <andypoo@gmail.com>
Cc:     stable@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: Regression in 4.14.147, 4.19.76, 5.2.18 leading to kernel panic
 on btrfs root fs mount
Message-ID: <20191014042023.GA31224@sasha-vm>
References: <CAFeYvHUoZdM5kY6LCfUiy6pVVf4VU_SWHtKeyevYenC3FZ7mng@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <CAFeYvHUoZdM5kY6LCfUiy6pVVf4VU_SWHtKeyevYenC3FZ7mng@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Oct 13, 2019 at 07:04:12PM +0300, Andrew Macks wrote:
>Was not sure the correct way to escalate this quickly enough.  I
>unfortunately discovered this issue while upgrading a server (remotely) to
>4.19.78 (longterm).
>
>*Bug 205181* <https://bugzilla.kernel.org/show_bug.cgi?id=205181> - kernel
>panic when accessing btrfs root device with f2fs in kernel
>https://bugzilla.kernel.org/show_bug.cgi?id=205181

Okay, I've backported 38fb6d0ea3429 ("f2fs: use EINVAL for superblock
with invalid magic") to 4.19 and 4.14. It'll be great if someone could
ack that backport.

Sorry for the breakage.

-- 
Thanks,
Sasha

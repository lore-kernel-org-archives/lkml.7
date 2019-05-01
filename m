Return-Path: <SRS0=0OOB=TB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2323AC46460
	for <linux-kernel@archiver.kernel.org>; Wed,  1 May 2019 13:06:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DD5902063F
	for <linux-kernel@archiver.kernel.org>; Wed,  1 May 2019 13:06:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1556716000;
	bh=mWDgcErDmrO9VVcSvv6nC8Aw+nUSRyl0jzDQfSP+YXs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=SNEZ6qahBUxVvEK2vWSNp98gt16C3VVTwf+zFj/YbPdh9lfxzBk1+D8IGAQd39PLF
	 LJlPvJvm+asMrT3huuLoSt6yTRKQQG/laQ0a5JCRKr7sV5hO9gEhu9AGcr79VH1sa4
	 HfNIzVO1eqZC4msOKUQccdHSwHghkxkO4GZzfYW0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726434AbfEANGi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 May 2019 09:06:38 -0400
Received: from mail.kernel.org ([198.145.29.99]:35452 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725993AbfEANGi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 May 2019 09:06:38 -0400
Received: from localhost (adsl-173-228-226-134.prtc.net [173.228.226.134])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5E6912063F;
        Wed,  1 May 2019 13:06:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1556715997;
        bh=mWDgcErDmrO9VVcSvv6nC8Aw+nUSRyl0jzDQfSP+YXs=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=zyAV5sfw8dopLhf3Gweepcu7gTpk+bzzUelRVq0wdG/5oJBzp6D9GZouBMnAjpwAm
         BPmwHRE0LnETxK3GB78uEVzlDMtfnxXgLpCpUdWxDsycCXkIptX8etIYmyHgi9HUh1
         ZmozLCxTGLMXVZbMDMRtG7irej/TSaIA/k6TXaFw=
Date:   Wed, 1 May 2019 09:06:35 -0400
From:   Sasha Levin <sashal@kernel.org>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-kernel@vger.kernel.org, stable@vger.kernel.org,
        Dave Airlie <airlied@redhat.com>
Subject: Re: [PATCH 5.0 44/89] Revert "drm/i915/fbdev: Actually configure
 untiled displays"
Message-ID: <20190501130635.GB3929@sasha-vm>
References: <20190430113609.741196396@linuxfoundation.org>
 <20190430113611.821040876@linuxfoundation.org>
 <20190501130208.GA3929@sasha-vm>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20190501130208.GA3929@sasha-vm>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 01, 2019 at 09:02:08AM -0400, Sasha Levin wrote:
>On Tue, Apr 30, 2019 at 01:38:35PM +0200, Greg Kroah-Hartman wrote:
>>From: Dave Airlie <airlied@redhat.com>
>>
>>commit 9fa246256e09dc30820524401cdbeeaadee94025 upstream.
>>
>>This reverts commit d179b88deb3bf6fed4991a31fd6f0f2cad21fab5.
>>
>>This commit is documented to break userspace X.org modesetting driver in certain configurations.
>>
>>The X.org modesetting userspace driver is broken. No fixes are available yet. In order for this patch to be applied it either needs a config option or a workaround developed.
>>
>>This has been reported a few times, saying it's a userspace problem is clearly against the regression rules.
>>
>>Bugzilla: https://bugs.freedesktop.org/show_bug.cgi?id=109806
>>Signed-off-by: Dave Airlie <airlied@redhat.com>
>>Cc: <stable@vger.kernel.org> # v3.19+
>>Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
>
>This commit has a follow-up fix as abbc0697d5fbf ("drm/fb: revert the
>i915 Actually configure untiled displays from master").

Uh, sorry, ignore that. I mixed stuff up. Not enough coffee.

--
Thanks,
Sasha

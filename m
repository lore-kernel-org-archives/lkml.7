Return-Path: <SRS0=kjqD=WY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1CD05C3A5A1
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Aug 2019 08:43:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CBD2F23403
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Aug 2019 08:43:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kroah.com header.i=@kroah.com header.b="pvwkJthY";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Aqr4ZgqW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726550AbfH1In5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 28 Aug 2019 04:43:57 -0400
Received: from wout1-smtp.messagingengine.com ([64.147.123.24]:57267 "EHLO
        wout1-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726272AbfH1In5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Aug 2019 04:43:57 -0400
Received: from compute6.internal (compute6.nyi.internal [10.202.2.46])
        by mailout.west.internal (Postfix) with ESMTP id 14CBE57E;
        Wed, 28 Aug 2019 04:43:54 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute6.internal (MEProxy); Wed, 28 Aug 2019 04:43:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kroah.com; h=
        date:from:to:cc:subject:message-id:references:mime-version
        :content-type:in-reply-to; s=fm1; bh=rumnT8PB1U+TKISd1jlKYXHcz26
        okE+Slyp0rl77a20=; b=pvwkJthYa+T4WMfjiwYK2l1kOBmd/Sp1ZDbeI7k/LPz
        J9FFyQ3zeA5mgbqJNEQeiJfZlDDhUKJpVvz3LimgLEGKXDUs9u6XPZV7u7bs55Fo
        ch9U86g5oKGQQqTTSAKbdt7T4ZF9s/F1PXUyRSmnVTRQYrg510OBiYTa3Q+uuCxv
        cLkfifdzun0c7jKJVhThv4Lvgn8HSdIfPkhw/EvqpCaV9EUsA4c9oH2th+SUIGmk
        F+tDiuKPyzpJOoaBW0exr5aN0TaJZWDicN1ysDKZLcrmz8j5mWJt4U7AQdSBZek5
        eYHxsYogAC7XPEK1SqYhXQb47ZPCz1Lfa/wQAQvZuxA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; bh=rumnT8
        PB1U+TKISd1jlKYXHcz26okE+Slyp0rl77a20=; b=Aqr4ZgqWRVbRWHpkplNUS7
        80KJX3K6HLMRDf9HAfZsy+f+KiT43SED8jqW0/ISFRTwBsjRZ8iIl9F0yDDdc3HE
        TC1GDlrY/Hyyf/rfCE6UsDlWbq03pvWYVcS2IaNGZWjyrRQkS7UFq5miKL79Q69n
        P9jcTG8qSFa17MBZlWVTLctyPDpIeMd6CuvnXbZWcVjp+yv7Lmjw7jwzp2uTQZsQ
        L7t71RvrqgLiH5IMeCfBhqcgXD+2XoViQFZuTzzHxjAyWKYEFXmcqLizd8hBU2i7
        hrUV+a7I4lYbLa3Qagn5dGZwlFRsQ7JHN/FMZmRMXcQBSY3+L5EGFcVrIXt7zfvw
        ==
X-ME-Sender: <xms:yT5mXeqsglSjVNnJeKnX4u8vdx-J40Lf0VeNx9MGKHMtqM7Rkrtfbw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduvddrudeitddgtdejucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvffukfhfgggtuggjfgesthdtredttdervdenucfhrhhomhepifhrvghg
    ucfmjfcuoehgrhgvgheskhhrohgrhhdrtghomheqnecuffhomhgrihhnpehkvghrnhgvlh
    drohhrghenucfkphepkeefrdekiedrkeelrddutdejnecurfgrrhgrmhepmhgrihhlfhhr
    ohhmpehgrhgvgheskhhrohgrhhdrtghomhenucevlhhushhtvghrufhiiigvpedt
X-ME-Proxy: <xmx:yT5mXYUS5YRiakT_ydSgHxhy4wF-uGeM2i63tSX0OY_E7cpljAuEMA>
    <xmx:yT5mXbNUeD28nQBHLk6We30-q_9i2C2iGCSje8gPjjuu3-uivmKt_w>
    <xmx:yT5mXcBxE9zV_ZGd_WwleW7Zrd8UpWzpFRriZshXWTtAjkFB_Ev8Ow>
    <xmx:yT5mXZ8tmtHKXuxsAZmiahmKVKlKSJOufx9Crs2SlecZmWBFmTjV_w>
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        by mail.messagingengine.com (Postfix) with ESMTPA id 25BC78005A;
        Wed, 28 Aug 2019 04:43:53 -0400 (EDT)
Date:   Wed, 28 Aug 2019 10:43:51 +0200
From:   Greg KH <greg@kroah.com>
To:     Sasha Levin <sashal@kernel.org>
Cc:     linux-kernel@vger.kernel.org, yu.c.chen@intel.com,
        stable-commits@vger.kernel.org
Subject: Re: Patch "x86/pm: Introduce quirk framework to save/restore extra
 MSR registers around suspend/resume" has been added to the 4.4-stable tree
Message-ID: <20190828084351.GC29927@kroah.com>
References: <20190828041240.12F5221883@mail.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190828041240.12F5221883@mail.kernel.org>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 28, 2019 at 12:12:39AM -0400, Sasha Levin wrote:
> This is a note to let you know that I've just added the patch titled
> 
>     x86/pm: Introduce quirk framework to save/restore extra MSR registers around suspend/resume
> 
> to the 4.4-stable tree which can be found at:
>     http://www.kernel.org/git/?p=linux/kernel/git/stable/stable-queue.git;a=summary
> 
> The filename of the patch is:
>      x86-pm-introduce-quirk-framework-to-save-restore-ext.patch
> and it can be found in the queue-4.4 subdirectory.
> 
> If you, or anyone else, feels it should not be added to the stable tree,
> please let <stable@vger.kernel.org> know about it.
> 
> 
> 
> commit d63273440aa0fdebc30d0c931f15f79beb213134
> Author: Chen Yu <yu.c.chen@intel.com>
> Date:   Wed Nov 25 01:03:41 2015 +0800
> 
>     x86/pm: Introduce quirk framework to save/restore extra MSR registers around suspend/resume
>     
>     A bug was reported that on certain Broadwell platforms, after
>     resuming from S3, the CPU is running at an anomalously low
>     speed.
>     
>     It turns out that the BIOS has modified the value of the
>     THERM_CONTROL register during S3, and changed it from 0 to 0x10,
>     thus enabled clock modulation(bit4), but with undefined CPU Duty
>     Cycle(bit1:3) - which causes the problem.
>     
>     Here is a simple scenario to reproduce the issue:
>     
>      1. Boot up the system
>      2. Get MSR 0x19a, it should be 0
>      3. Put the system into sleep, then wake it up
>      4. Get MSR 0x19a, it shows 0x10, while it should be 0
>     
>     Although some BIOSen want to change the CPU Duty Cycle during
>     S3, in our case we don't want the BIOS to do any modification.
>     
>     Fix this issue by introducing a more generic x86 framework to
>     save/restore specified MSR registers(THERM_CONTROL in this case)
>     for suspend/resume. This allows us to fix similar bugs in a much
>     simpler way in the future.
>     
>     When the kernel wants to protect certain MSRs during suspending,
>     we simply add a quirk entry in msr_save_dmi_table, and customize
>     the MSR registers inside the quirk callback, for example:
>     
>       u32 msr_id_need_to_save[] = {MSR_ID0, MSR_ID1, MSR_ID2...};
>     
>     and the quirk mechanism ensures that, once resumed from suspend,
>     the MSRs indicated by these IDs will be restored to their
>     original, pre-suspend values.
>     
>     Since both 64-bit and 32-bit kernels are affected, this patch
>     covers the common 64/32-bit suspend/resume code path. And
>     because the MSRs specified by the user might not be available or
>     readable in any situation, we use rdmsrl_safe() to safely save
>     these MSRs.
>     
>     Reported-and-tested-by: Marcin Kaszewski <marcin.kaszewski@intel.com>
>     Signed-off-by: Chen Yu <yu.c.chen@intel.com>
>     Acked-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
>     Acked-by: Pavel Machek <pavel@ucw.cz>
>     Cc: Andy Lutomirski <luto@amacapital.net>
>     Cc: Borislav Petkov <bp@alien8.de>
>     Cc: Brian Gerst <brgerst@gmail.com>
>     Cc: Denys Vlasenko <dvlasenk@redhat.com>
>     Cc: H. Peter Anvin <hpa@zytor.com>
>     Cc: Linus Torvalds <torvalds@linux-foundation.org>
>     Cc: Peter Zijlstra <peterz@infradead.org>
>     Cc: Thomas Gleixner <tglx@linutronix.de>
>     Cc: bp@suse.de
>     Cc: len.brown@intel.com
>     Cc: linux@horizon.com
>     Cc: luto@kernel.org
>     Cc: rjw@rjwysocki.net
>     Link: http://lkml.kernel.org/r/c9abdcbc173dd2f57e8990e304376f19287e92ba.1448382971.git.yu.c.chen@intel.com
>     [ More edits to the naming of data structures. ]
>     Signed-off-by: Ingo Molnar <mingo@kernel.org>

No git id of the patch in Linus's tree, or your signed-off-by?

Sasha, did your scripts trigger this unintentionally somehow?

thanks,

greg k-h

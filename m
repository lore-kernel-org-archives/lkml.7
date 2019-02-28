Return-Path: <SRS0=g5d9=RD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	FAKE_REPLY_C,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 30E8FC43381
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Feb 2019 17:47:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 06009218AE
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Feb 2019 17:47:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ifC58hYS"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388028AbfB1Rrp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Feb 2019 12:47:45 -0500
Received: from mail-pl1-f193.google.com ([209.85.214.193]:43572 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732473AbfB1Rro (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Feb 2019 12:47:44 -0500
Received: by mail-pl1-f193.google.com with SMTP id m10so10076992plt.10
        for <linux-kernel@vger.kernel.org>; Thu, 28 Feb 2019 09:47:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=3D/6ss/O/zezzIitfO/J74VG24dqSswkeviuRpIN8Ks=;
        b=ifC58hYSd9pq8IlXz+wyXp+1amqFvKAkzN6pnE+RcIJrIHRi5/EkpOIJ0Kih03Ru4C
         fSGMxdNHshtE7VWomwvyuIeqY6boIjcSsTDk0n7NtKODTu8B/7ID+B2l5oShrNAv5+Fm
         7vFPAdJh1rSLMLBsWqtigGdu/ZyrCQTfzSY+R1qc1Ci5C/2qN3REvtIvjkZA9bivWe2e
         1gp8/0aKVlui5NDVw1VKGMPQfJ/QGEIp3aySDXI+fCQMlL4Y39QUvyOOUuM0jbNCtlzA
         +Bo5kRSkeYib/lSeTOknc15hVKVjx5mAnyWrZWZxdKbQVQf+PoXIwfV7TmgPS7XF6zHK
         ES6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :mime-version:content-disposition:user-agent;
        bh=3D/6ss/O/zezzIitfO/J74VG24dqSswkeviuRpIN8Ks=;
        b=HmL9QYEWivASsVByPqMhcqcXk+E1pmSNsbSUIis0wQU/m3BCTzQZH/uTbgfQyJpikT
         XQ0OYAzkEQsRFdJSsS14YWSEETuJeISBvBsR9e0DvA/EdOXlfeBi2ak4OtK9pkUheqz1
         8Ta12EaW2FGzvUOZx4+icgokQV6eDP9Y+kBQYZBoNX6xOTQmTkdewWQOoLpM14RmWcQI
         QLj4RFtLFop8Ri0MK3XWs3YfanM34Y7KCM2uTWcuWRD0vXXP9aY0nXJddnhjTdGbFz3q
         oaZGLXuO4/XN29Uy6TjsXo6bCS3t13Zc834hq6k/LybvLnkdDx7I4nVnS74I7NfvOQrV
         aFzg==
X-Gm-Message-State: APjAAAUFmBNkQn3ocvuQiVpraWw4RlNrnDywRDAprsG7wNwo/aaKOT6Z
        tMvDopHofTHRHZHKmagv+GM=
X-Google-Smtp-Source: APXvYqxRTfCi4/gsdN3ncBCpPhzVMg+p7/I22sUKBquBOGR5ZvHKyw50OsIiHjJ7V0bRUckwNXH5XA==
X-Received: by 2002:a17:902:22f:: with SMTP id 44mr528395plc.249.1551376063848;
        Thu, 28 Feb 2019 09:47:43 -0800 (PST)
Received: from localhost ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id h75sm31320900pfd.150.2019.02.28.09.47.42
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 28 Feb 2019 09:47:43 -0800 (PST)
Date:   Thu, 28 Feb 2019 09:47:42 -0800
From:   Guenter Roeck <linux@roeck-us.net>
To:     Eugeniy Paltsev <eugeniy.paltsev@synopsys.com>
Cc:     Vineet Gupta <vgupta@synopsys.com>,
        linux-snps-arc@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ARCv2: Add explcit unaligned access support (and ability
 to disable too)
Message-ID: <20190228174742.GA18868@roeck-us.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 30, 2019 at 07:32:41PM +0300, Eugeniy Paltsev wrote:
> As of today we enable unaligned access unconditionally on ARCv2.
> Do this under a Kconfig option to allow disable it for test, benchmarking
> etc. Also while at it
> 
>   - Select HAVE_EFFICIENT_UNALIGNED_ACCESS
>   - Although gcc defaults to unaligned access (since GNU 2018.03), add the
>     right toggles for enabling or disabling as appropriate
>   - update bootlog to prints both HW feature status (exists, enabled/disabled)
>     and SW status (used / not used).
>   - wire up the relaxed memcpy for unaligned access
> 
> Signed-off-by: Eugeniy Paltsev <Eugeniy.Paltsev@synopsys.com>
> Signed-off-by: Vineet Gupta <vgupta@synopsys.com>
> [vgupta: squashed patches, handle gcc -mno-unaligned-access quick]

Hi,

with my brand-new gcc-8.3.0, built from upstream gcc, this patch
results in

arch/arc/kernel/setup.c: In function 'arc_cpu_mumbojumbo.constprop':
include/linux/compiler.h:348:38: error:
	call to '__compiletime_assert_326' declared with attribute error: gcc doesn't support -mno-unaligned-access

when trying to build allnoconfig or tinyconfig. I get the same results
with gcc-8.2.0.

Do I need some special compiler configuration flag when building the
arcv2 toolchain ? Or am I simply out of luck for using upstream gcc ?

Thanks,
Guenter

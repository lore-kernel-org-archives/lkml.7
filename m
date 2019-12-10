Return-Path: <SRS0=jko7=2A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C8755C2D0BF
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Dec 2019 13:32:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 94BAE2073B
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Dec 2019 13:32:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1575984727;
	bh=5Kp7u4wjBjYIMAOigXKp0rSdPdVZYCQGCYAOXxbS8k0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=X5FSwOl2IFmu/HaRr4n5u052i2+Zyf/4LirQB/TcEp5/gCydxAxkTc0Oi6ZaXjQTw
	 LAC0lyN0zO6PsbouASYEILOcbgF26swTJ5SxIkrECHW6NRJOb12BQq89e7EqMbimRa
	 nAnJNvhesck6zUcYI30LvGef9dU++CL/ElULM6H8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727494AbfLJNcG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 10 Dec 2019 08:32:06 -0500
Received: from mail-wm1-f68.google.com ([209.85.128.68]:35973 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727359AbfLJNcG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Dec 2019 08:32:06 -0500
Received: by mail-wm1-f68.google.com with SMTP id p17so3220850wma.1
        for <linux-kernel@vger.kernel.org>; Tue, 10 Dec 2019 05:32:05 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=sLGCAePB0WCD0CcHo22bI6VRtDcHK5yA0M15WiUs63E=;
        b=NyLnWC7FEv3JAPTALUQHMnedFYNjVlqfxqiHSMdW24njP5oqfqd35r87kKscIYq6db
         30C6H/1QzqZ6brnYOuo06U0fzm6/J2EuOinv+uQSbNXlyrRupJ7UkmAwFxA7qpbXgW7z
         OPlvEOxwRyYfNs2d3GZx2nhkCHhwihz64gL8rYYHQ/MUWHyVY/xjn2s4shOTEhX9eWez
         KKkMfFmWYuewovGLw6kEkSHR1ZV/6jtYlWuITjD0KMMSS++35Jbts2mAziNITlLFw/gn
         2TNej7dtYZOtXKDRM7Lzd8YTv45VJmRuM4JjdlJ7Y1NXWIGIGAx8ZvK2GZ6UjxbMYWRK
         sAaQ==
X-Gm-Message-State: APjAAAUxWdZL6IAsup7pKOD+EuBqfbzOQHVLd/gR/YlMEWY6nKm8rMJ6
        l7mMpXQw1XWRhkUdxmZf5fo=
X-Google-Smtp-Source: APXvYqxxfs6esQxTNXX9Wje3aNo9nzgksPCuQs0crWNfohnjc19G+i78e4E90onkNlPTlF5uX75Rmg==
X-Received: by 2002:a05:600c:218f:: with SMTP id e15mr5137202wme.124.1575984724418;
        Tue, 10 Dec 2019 05:32:04 -0800 (PST)
Received: from localhost (prg-ext-pat.suse.com. [213.151.95.130])
        by smtp.gmail.com with ESMTPSA id n1sm3264821wrw.52.2019.12.10.05.32.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Dec 2019 05:32:03 -0800 (PST)
Date:   Tue, 10 Dec 2019 14:32:02 +0100
From:   Michal Hocko <mhocko@kernel.org>
To:     Baoquan He <bhe@redhat.com>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org, jgross@suse.com,
        william.kucharski@oracle.com, mingo@kernel.org,
        akpm@linux-foundation.org
Subject: Re: [PATCH] mm/hotplug: Only respect mem= parameter during boot stage
Message-ID: <20191210133202.GJ10404@dhcp22.suse.cz>
References: <20191206150524.14687-1-bhe@redhat.com>
 <20191209100717.GC6156@dhcp22.suse.cz>
 <20191210072453.GI2984@MiWiFi-R3L-srv>
 <20191210102834.GE10404@dhcp22.suse.cz>
 <20191210104303.GN2984@MiWiFi-R3L-srv>
 <20191210113341.GG10404@dhcp22.suse.cz>
 <20191210125557.GA28917@MiWiFi-R3L-srv>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191210125557.GA28917@MiWiFi-R3L-srv>
User-Agent: Mutt/1.12.2 (2019-09-21)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue 10-12-19 20:55:57, Baoquan He wrote:
[...]
> Btw, as you said at above, I am confused by the '[KNL,BOOT]', what does
> the 'BOOT' mean in the documentation of 'mem='? I checked all parameters
> with 'BOOT', still don't get it clearly.

This is a good question indeed. I have checked closer and this is what
documentation says
Documentation/admin-guide/kernel-parameters.rst
"
        BOOT    Is a boot loader parameter.

Parameters denoted with BOOT are actually interpreted by the boot
loader, and have no meaning to the kernel directly.
"

and that really doesn't fit, right? So I went to check the full history
git tree just to get to 2.4.0-test5 and no explanation whatsoever.
Fun, isn't it? ;)
-- 
Michal Hocko
SUSE Labs

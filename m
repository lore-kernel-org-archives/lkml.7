Return-Path: <SRS0=rNeM=SR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_NEOMUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E27A5C10F0E
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Apr 2019 04:42:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AC172206B7
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Apr 2019 04:42:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="u7p1Ztk9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725840AbfDOEmE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Apr 2019 00:42:04 -0400
Received: from mail-pg1-f178.google.com ([209.85.215.178]:33200 "EHLO
        mail-pg1-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725765AbfDOEmD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Apr 2019 00:42:03 -0400
Received: by mail-pg1-f178.google.com with SMTP id k19so7956287pgh.0;
        Sun, 14 Apr 2019 21:42:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=kKjI2P2/iurFJOV+5OPymQnFOwELGo5tfQBN0AXJV5Y=;
        b=u7p1Ztk9tC3KSsXwOdtoCNnCKl+8T2jbI+z10PtziX3YrfW2MZzrYguUMkfd/5kCu4
         D52d3ag9u3Zn2W1087SvPPlc1XQuavsaYAMJBvkAoUuM9M9J+HogBLWiQEX+CpSbC5w/
         nfk6fCKL2nOHQfC1az403fpAFweC6WnSYEyqPzowxV2K6Ynpvfy255HA/uO+i9KpHZxi
         4u++eStaufwLF+hTKyspm24oWV7vc+KTLYUao9bfaBI6+x7my9Imxgv1jEWht2xwGgVQ
         MPmWBESyyFrvbv+cnJB4N9u0PXNwU7etacvY/m7r3uY8b8y/TzFK5VBpGyjSnUNiKtlI
         Je/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=kKjI2P2/iurFJOV+5OPymQnFOwELGo5tfQBN0AXJV5Y=;
        b=kWQu+DV9R2h+tucVKkqAMM5D21gGj7o5sz1CUF5mV26sF1/Q/pCre7mCXXKJF3glAL
         643LVekeRzU+dGJ0EekN2a6NgvIiGKe/EUEVT+UgMFB/tuLZDCLUJbkN42AEfzTRxBnQ
         9VjDCYKZFvZ7Wr5LXF2sXx/w6PiKmjeCAppJUbyqXs19XvfszPEh9nA751v1u5Q73N3r
         On03iUXZ5PkRXTtRTp2u51bqi+2aQ4oii//Yzv7yHUBgd1HjB7fP3SpeWa95IOqG8YYE
         EL8QFB1Hhlv9/63ICos0RfGb5eBAq5+UWZbcU3On5X3MJXaYG8qRqyBWuV+P98i23Rxb
         EKeg==
X-Gm-Message-State: APjAAAVNViYXmv6ildohfSjsf87SP8m95ELYMjEnwXdMHVEqRDzoVr6h
        EqKERW5gHDIGFdPBaejkqLw=
X-Google-Smtp-Source: APXvYqwO8Y2kCRECL4o1ls66qybRkgKmwm9oX7GhZ72YJo15ykW2o3SCA00ZVw4x2v66uX8memBIvg==
X-Received: by 2002:a65:47c6:: with SMTP id f6mr67603139pgs.173.1555303322878;
        Sun, 14 Apr 2019 21:42:02 -0700 (PDT)
Received: from ast-mbp.dhcp.thefacebook.com ([2620:10d:c090:180::ca32])
        by smtp.gmail.com with ESMTPSA id p7sm84915648pfp.70.2019.04.14.21.42.01
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 14 Apr 2019 21:42:01 -0700 (PDT)
Date:   Sun, 14 Apr 2019 21:42:00 -0700
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
To:     Al Viro <viro@zeniv.linux.org.uk>
Cc:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        peterz@infradead.org, tj@kernel.org
Subject: Re: misuse of fget_raw() in perf_event_get()
Message-ID: <20190415044158.5goa2je57j63kwaz@ast-mbp.dhcp.thefacebook.com>
References: <20190413210242.GP2217@ZenIV.linux.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190413210242.GP2217@ZenIV.linux.org.uk>
User-Agent: NeoMutt/20180223
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Apr 13, 2019 at 10:02:42PM +0100, Al Viro wrote:
> 	What's the point of using fget_raw(), if you do
> _not_ accept O_PATH descriptors?  That should be fget()...

I think you're talking about commit e03e7ee34fdd ("perf/bpf: Convert perf_event_array to use struct file")
I don't really remember why we went with this instead of fget().
There was a bunch of back and forth back then with Peter.
Now it looks like that it can be fget just fine.
I think cgroup_get_from_fd() should do the same too?


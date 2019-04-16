Return-Path: <SRS0=BZT9=SS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2B58CC10F13
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Apr 2019 16:28:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EDBA620821
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Apr 2019 16:28:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=maine.edu header.i=@maine.edu header.b="e+MVs7DE"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729828AbfDPQ2G (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Apr 2019 12:28:06 -0400
Received: from mail-qt1-f195.google.com ([209.85.160.195]:45112 "EHLO
        mail-qt1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726860AbfDPQ2G (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Apr 2019 12:28:06 -0400
Received: by mail-qt1-f195.google.com with SMTP id v20so23951861qtv.12
        for <linux-kernel@vger.kernel.org>; Tue, 16 Apr 2019 09:28:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=maine.edu; s=google;
        h=from:date:to:cc:subject:in-reply-to:message-id:references
         :user-agent:mime-version;
        bh=Hbq+cj0kC2CgcN1sfaQg89cNt6bp/FWiwQZ/y/75Yrg=;
        b=e+MVs7DEl9pMknHJp2ULh6x0xG554YmlN9KPgj/g7GE/hh3FP7sD5tvbsBKxZUp2yz
         fWUsPuckbpnTzsgIdRONt2ZsbvHOhI+O8uv5jv/SjohRWKbHyURTbFnM2Yb03/G6bPpk
         GFmAamuOkhxrSqi+3xXlbvQ4VFqu1+AQa4A7I=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:in-reply-to:message-id
         :references:user-agent:mime-version;
        bh=Hbq+cj0kC2CgcN1sfaQg89cNt6bp/FWiwQZ/y/75Yrg=;
        b=ewKgPs8CeCWubVc5VewSBu/D5CAt8+pXKKdLz/GanHMYwA8YgB61cHPG6iHdjlYzqx
         DBo73UH949g2QDuz0T1Ii9cRZuI27lQv9gLv4KF7XtMQ+MQzPUI0OdUZrtYTRG6cHJVR
         0zfMHUlSxysdgn3syP1/lonvVxr4YIdq0MYJgYI3QDle3e5HhglNqiQ5fsRUz/QewE3i
         j69A71hMLSAQI/b3byD9bz2tUdJeE93yKPzoZ4KL0Gq2MzGyapt07ZWAeOgnXQO9+zG8
         XAHXGHAP2XZCnIklMFsQGX2OJfWRN1PfKQjqF821Nw0RgVTeEpyovlguPjbJSLSkz2qZ
         gDLw==
X-Gm-Message-State: APjAAAU/CQPlgW7LhvqpJNBSccMrcp9QtsuwAltAtbGfcrbY7v0PTfsf
        JLnxwIeuwNtUD7awqN1Er6UUIA==
X-Google-Smtp-Source: APXvYqypqGPacDCwA5sK33jUO1jgCMNrbBKeagAr+Y2WgjlFGcEAn9bov9i1MY8JAOAPsXyprkoOug==
X-Received: by 2002:a0c:f806:: with SMTP id r6mr64322040qvn.188.1555432085802;
        Tue, 16 Apr 2019 09:28:05 -0700 (PDT)
Received: from macbook-air (weaver.eece.maine.edu. [130.111.218.23])
        by smtp.gmail.com with ESMTPSA id 46sm37538023qtz.87.2019.04.16.09.28.03
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 16 Apr 2019 09:28:04 -0700 (PDT)
From:   Vince Weaver <vincent.weaver@maine.edu>
X-Google-Original-From: Vince Weaver <vince@maine.edu>
Date:   Tue, 16 Apr 2019 12:28:00 -0400 (EDT)
X-X-Sender: vince@macbook-air
To:     vincent.weaver@maine.edu, mingo@kernel.org, eranian@google.com,
        peterz@infradead.org, alexander.shishkin@linux.intel.com,
        acme@redhat.com, hpa@zytor.com, torvalds@linux-foundation.org,
        tglx@linutronix.de, linux-kernel@vger.kernel.org, jolsa@redhat.com
cc:     linux-tip-commits@vger.kernel.org
Subject: Re: [tip:perf/core] perf/x86/intel: Force resched when TFA sysctl
 is modified
In-Reply-To: <tip-f447e4eb3ad1e60d173ca997fcb2ef2a66f12574@git.kernel.org>
Message-ID: <alpine.DEB.2.21.1904161227001.20764@macbook-air>
References: <20190408173252.37932-3-eranian@google.com> <tip-f447e4eb3ad1e60d173ca997fcb2ef2a66f12574@git.kernel.org>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 16 Apr 2019, tip-bot for Stephane Eranian wrote:

> Commit-ID:  f447e4eb3ad1e60d173ca997fcb2ef2a66f12574
> Gitweb:     https://git.kernel.org/tip/f447e4eb3ad1e60d173ca997fcb2ef2a66f12574
> Author:     Stephane Eranian <eranian@google.com>
> AuthorDate: Mon, 8 Apr 2019 10:32:52 -0700
> Committer:  Ingo Molnar <mingo@kernel.org>
> CommitDate: Tue, 16 Apr 2019 12:19:35 +0200
> 
> perf/x86/intel: Force resched when TFA sysctl is modified

What's TFA?  Tuna-fish-alarm?  Nowhere in the commit or in the code does 
it ever say what a TFA is or why we'd want to resched when it is modified.

Vince

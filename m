Return-Path: <SRS0=K12x=T4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 76FDDC04AB6
	for <linux-kernel@archiver.kernel.org>; Tue, 28 May 2019 15:51:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3FDFE2166E
	for <linux-kernel@archiver.kernel.org>; Tue, 28 May 2019 15:51:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=cmpxchg-org.20150623.gappssmtp.com header.i=@cmpxchg-org.20150623.gappssmtp.com header.b="MbCgM+uu"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726728AbfE1Pvh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 May 2019 11:51:37 -0400
Received: from mail-pl1-f194.google.com ([209.85.214.194]:38269 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726362AbfE1Pvh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 May 2019 11:51:37 -0400
Received: by mail-pl1-f194.google.com with SMTP id f97so8521270plb.5
        for <linux-kernel@vger.kernel.org>; Tue, 28 May 2019 08:51:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=dsL/8BpLj54WzcwU9lA3tyWUUF9Wxnm/30yw4mZ1tyw=;
        b=MbCgM+uuboSRTMuXJWeTUpgN2WFc5/X4Dc4fFWWLthvlCgFt+H/q0c7MBnqyRO7Z73
         w7T0dnWfCYPRON17hleGt5B//BaJJ6P+/svHaSMANSgZFw4vDArgF7z9xMnQXaa6t1dO
         04htcAMNkhBSLk8WJByTHg5qLbgRJIRtYzPiCo4TYXjLU44z5ybaQ8J6GQu4WgKUV3d2
         jshy7wZUxxJDCiA37j8Ddy/fCvVbsApXG4DSLEjIEyQ85zf041ZF18M69u9hcckGBRkm
         1ryDB+ODoSp4BBE1iTWsrO4LN+YTnvwGe8/vzwMvAwNjIL6/Zh9sRGlzcvWo0U8K+hf4
         oghw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=dsL/8BpLj54WzcwU9lA3tyWUUF9Wxnm/30yw4mZ1tyw=;
        b=hHK29vJ28WaAfbw2+q5B1Idutu/4TIYt+4gm/ZSLTHIaQUDadX6/vKSCRFqRZzBwku
         Xvr6HTLGhconrKG4HYQ2YN34Nq2GJSbXnqcD/U8W0WCfjjICt/10kSJhxxSMb3nSBqwF
         7e5eWsfsc467Cv5KzD19+JPJydU8I1WsnKzZ1FcPZ5jTb3fwppCfQ+dWJ04PGcX4sy/1
         xGLwyCVDWa0x1acPtugTiZydkR5AwJN80pK474pheAUPy+mvl6N9mM14vcW0t8mzB3Dj
         +1wTBVwfavODsgFSa3Lp+DwLicPMeSIcbZHC25l9NTV7onNWw5QgpJA0KqWFvDEnIit8
         NTzA==
X-Gm-Message-State: APjAAAX3B1W182ONewSQwdM4WvhcuBp4n6Zr40WmPPEhnyuwPP8UO7GP
        ZR/lfvkDvWTLeoKZ657+Hx11Yw==
X-Google-Smtp-Source: APXvYqyCPuhVHIxRFHyQfClQ2dTMU+08Qh2WIkGk1uZKDPtC7EX9dh0rLthtc16TUF6CW08MeVEZeQ==
X-Received: by 2002:a17:902:b615:: with SMTP id b21mr72986281pls.12.1559058696744;
        Tue, 28 May 2019 08:51:36 -0700 (PDT)
Received: from localhost ([2620:10d:c091:500::1234])
        by smtp.gmail.com with ESMTPSA id k2sm2903202pjl.23.2019.05.28.08.51.35
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 28 May 2019 08:51:35 -0700 (PDT)
Date:   Tue, 28 May 2019 11:51:34 -0400
From:   Johannes Weiner <hannes@cmpxchg.org>
To:     Kirill Tkhai <ktkhai@virtuozzo.com>
Cc:     akpm@linux-foundation.org, daniel.m.jordan@oracle.com,
        mhocko@suse.com, linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH REBASED 1/4] mm: Move recent_rotated pages calculation to
 shrink_inactive_list()
Message-ID: <20190528155134.GA14663@cmpxchg.org>
References: <155290113594.31489.16711525148390601318.stgit@localhost.localdomain>
 <155290127956.31489.3393586616054413298.stgit@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <155290127956.31489.3393586616054413298.stgit@localhost.localdomain>
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 18, 2019 at 12:27:59PM +0300, Kirill Tkhai wrote:
> @@ -1945,6 +1942,8 @@ shrink_inactive_list(unsigned long nr_to_scan, struct lruvec *lruvec,
>  		count_memcg_events(lruvec_memcg(lruvec), PGSTEAL_DIRECT,
>  				   nr_reclaimed);
>  	}
> +	reclaim_stat->recent_rotated[0] = stat.nr_activate[0];
> +	reclaim_stat->recent_rotated[1] = stat.nr_activate[1];

Surely this should be +=, right?

Otherwise we maintain essentially no history of page rotations and
that wreaks havoc on the page cache vs. swapping reclaim balance.

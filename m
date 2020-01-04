Return-Path: <SRS0=lTpO=2Z=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 855B5C2D0CE
	for <linux-kernel@archiver.kernel.org>; Sat,  4 Jan 2020 00:35:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5C60821835
	for <linux-kernel@archiver.kernel.org>; Sat,  4 Jan 2020 00:35:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Pe+JvrhB"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727198AbgADAf2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 3 Jan 2020 19:35:28 -0500
Received: from mail-pf1-f194.google.com ([209.85.210.194]:40297 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726697AbgADAf2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Jan 2020 19:35:28 -0500
Received: by mail-pf1-f194.google.com with SMTP id q8so24203657pfh.7;
        Fri, 03 Jan 2020 16:35:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=0FeJsQCW8mOlSS3IAGDGeSDz6EFOBAfSnpTVUbJ/CcA=;
        b=Pe+JvrhBVcnH/QgurCh/bCtFgT69K3nPua37Yh0GkzuzUC3mGEnLv9PxU7Lbln9Bg8
         OclxtQpvDZbg0iwxOzkQSDXn7V2gGJSJvbOJ5+K1c2/cDcDkvSBUQhuSEvotiACo03AG
         EXAXZlCu3SMTamgvr3NATzz16GqDr93/qMW1AKF/L6b6VZ90QMOBJimjIGNtZODlP/9R
         cSl/PxVWl2GcmVVE8nX39y2MEjKTtsx08k5JcXm+Dcvjmuw33YhN6jlvInp9mWifo4ai
         f0pBJjhKaQNdvxo9vFLaqRmRJxFu391QA50Jo3LhM+26SqprKggKg4ytzfzEXlnHw+5l
         zBvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=0FeJsQCW8mOlSS3IAGDGeSDz6EFOBAfSnpTVUbJ/CcA=;
        b=mFtkire9xpX2lyjFwUyj85/AVEgbUQJsyMRofJZavytQqOc7xuBm8ByakTUSzjoAyz
         gb5Vcoi8EOt0ZgPLzNoayw1K5boMVBPGQMCCZ2V96wwQrefnLNbYBs4pr8ef+IikSB7f
         B7WL3wDFIvW7amd9On9fQj6rJtok4Zutu5icwhNgy1CwnuTWyuOxL815qWz9I2Wt+pm5
         MmtOU7V+0/3iz4sTyYMwOYhKMP3eSF//EkjKruWzdO35I+6jfHtrlCeId93T/7zCqtmz
         Hrh+OsO0WKMZFB6NyIeRgIO2boLTgK/dBKdvHqvpiOO9cOAebi4+0VJucfUWde9kfVeC
         t9Ug==
X-Gm-Message-State: APjAAAXApXT7DBwP0vgY0qW3C/wWSPGTyE0+05E26XZs9aLnOp4VDiNq
        Ryzjd3RmDmuq+60eDo1kLsg3ovE9
X-Google-Smtp-Source: APXvYqygvWuLJRzXmYofvMGVP0Kzs5BW8aRNk2YICK61NMLb1BUG24l1C8Av1F4y6BbNEdpWgIeSqQ==
X-Received: by 2002:aa7:9ec9:: with SMTP id r9mr97508349pfq.85.1578098127504;
        Fri, 03 Jan 2020 16:35:27 -0800 (PST)
Received: from ast-mbp ([2620:10d:c090:200::3:4269])
        by smtp.gmail.com with ESMTPSA id o19sm16578944pjr.2.2020.01.03.16.35.26
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 03 Jan 2020 16:35:26 -0800 (PST)
Date:   Fri, 3 Jan 2020 16:35:25 -0800
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
To:     Roman Gushchin <guro@fb.com>
Cc:     bpf@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        linux-kernel@vger.kernel.org, kernel-team@fb.com,
        netdev@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH bpf] bpf: cgroup: prevent out-of-order release of cgroup
 bpf
Message-ID: <20200104003523.rfte5rw6hbnncjes@ast-mbp>
References: <20191227215034.3169624-1-guro@fb.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191227215034.3169624-1-guro@fb.com>
User-Agent: NeoMutt/20180223
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 27, 2019 at 01:50:34PM -0800, Roman Gushchin wrote:
> Before commit 4bfc0bb2c60e ("bpf: decouple the lifetime of cgroup_bpf
> from cgroup itself") cgroup bpf structures were released with
> corresponding cgroup structures. It guaranteed the hierarchical order
> of destruction: children were always first. It preserved attached
> programs from being released before their propagated copies.
> 
> But with cgroup auto-detachment there are no such guarantees anymore:
> cgroup bpf is released as soon as the cgroup is offline and there are
> no live associated sockets. It means that an attached program can be
> detached and released, while its propagated copy is still living
> in the cgroup subtree. This will obviously lead to an use-after-free
> bug.
...
> @@ -65,6 +65,9 @@ static void cgroup_bpf_release(struct work_struct *work)
>  
>  	mutex_unlock(&cgroup_mutex);
>  
> +	for (p = cgroup_parent(cgrp); p; p = cgroup_parent(p))
> +		cgroup_bpf_put(p);
> +

The fix makes sense, but is it really safe to walk cgroup hierarchy
without holding cgroup_mutex?


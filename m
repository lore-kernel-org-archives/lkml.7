Return-Path: <SRS0=g5d9=RD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7AB01C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Feb 2019 04:45:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 48EC521850
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Feb 2019 04:45:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VdAJ8jKE"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730744AbfB1EpY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Feb 2019 23:45:24 -0500
Received: from mail-pl1-f193.google.com ([209.85.214.193]:44139 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727672AbfB1EpY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Feb 2019 23:45:24 -0500
Received: by mail-pl1-f193.google.com with SMTP id c4so9089498pls.11
        for <linux-kernel@vger.kernel.org>; Wed, 27 Feb 2019 20:45:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=fgAty79c/lcTaOsIWZQePEkdQgJCu7xgRPDwcH+fVr0=;
        b=VdAJ8jKEkysg0W4tEP6OepXy9a85wkqBr2+SdikdbgRN9wtPzn8CvDsiDswiKvN3tg
         5DIYKmgOg3sKbObRSFqDnpQJSnrF1lWv0ypOdbdhErhoc8R95t/qG7CmwtaNOF/r+c6O
         yvvLRqMtlq3vAXZWze43Bvq9D8KbtoPKXmi6DLbWGyPux8xQAQjudmruzzSDyFsUQXLe
         qP+MznCe8HZui9mZqYzcmGI8FklqNcJ7Lda/v8f0gdEqYvDfY9QdkUmsKqCUjxSLZ4oz
         dN6fq+gtNREHj4xu48tUo0SbRUAENoZ0r0nvBeOQVkznEZ0CoMZJtXLu3JirvkI/vREe
         h7Qg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=fgAty79c/lcTaOsIWZQePEkdQgJCu7xgRPDwcH+fVr0=;
        b=XAMbo9Ryx3Trat5EW17+8DJGpLHGEvLoPO6JFt1bmaRhUe7vNpnkVffZl8YpTIkZa0
         0Bh+dU0MqwpueNJW2L0r97CWBCPgZsX9hE97zXJcLlC7v2H1aqnBZHoDRzls9XPa40un
         sSrLIkiVjrih/KDMCVm1hCAgjVGZxYpikXcb8guJAl6gJ4lz+F6b3RQwIUMJnxWQYCun
         6MOnX0YKZozQ2lie4FzdYsSVpPaQxf0wWslbKutsRL194fQWdFPUPF8kSilBvMMrkF2Z
         6yXoQ0swVpLlMRyDky7clyqilP9pPrLD//MIgJisS4CAfoP4xgtgSIhsSYKsf/4vFWhP
         Cz7w==
X-Gm-Message-State: AHQUAuaU3/sOJMtoG5rUhRoOCkayEBheIKqkB4v8LbZ//hu1oq/NS/Vs
        VHGNhRRayqcAkNy1q99+T2riqrHN
X-Google-Smtp-Source: AHgI3IbmcnpWIW0bdA25pVX5YJj7DOMRjR3ZgFouaOsl6Zr+zykJpsNmSY/QARG7ODwR3pnNUGNZTA==
X-Received: by 2002:a17:902:b591:: with SMTP id a17mr6109349pls.228.1551329123575;
        Wed, 27 Feb 2019 20:45:23 -0800 (PST)
Received: from localhost ([110.70.46.182])
        by smtp.gmail.com with ESMTPSA id i10sm5388057pgs.26.2019.02.27.20.45.21
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 27 Feb 2019 20:45:22 -0800 (PST)
Date:   Thu, 28 Feb 2019 13:45:19 +0900
From:   Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>
To:     Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
Cc:     Petr Mladek <pmladek@suse.com>,
        Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        akpm@linux-foundation.org, linux-mm@kvack.org,
        Peter Zijlstra <peterz@infradead.org>, Jan Kara <jack@suse.cz>,
        Tejun Heo <tj@kernel.org>, linux-kernel@vger.kernel.org,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>
Subject: Re: [PATCH] printk: Ratelimit messages printed by console drivers
Message-ID: <20190228044519.GA32563@jagdpanzerIV>
References: <20180420145720.hb7bbyd5xbm5je32@pathway.suse.cz>
 <20180420111307.44008fc7@gandalf.local.home>
 <20180423103232.k23yulv2e7fah42r@pathway.suse.cz>
 <20180423073603.6b3294ba@gandalf.local.home>
 <20180423124502.423fb57thvbf3zet@pathway.suse.cz>
 <20180425053146.GA25288@jagdpanzerIV>
 <20180426094211.okftwdzgfn72rik3@pathway.suse.cz>
 <20180427102245.GA591@jagdpanzerIV>
 <20180509120050.eyuprdh75grhdsh4@pathway.suse.cz>
 <63adb127-bb4b-d952-73f4-764d0cd78c52@i-love.sakura.ne.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <63adb127-bb4b-d952-73f4-764d0cd78c52@i-love.sakura.ne.jp>
User-Agent: Mutt/1.11.3 (2019-02-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On (02/26/19 19:24), Tetsuo Handa wrote:
> Does memory allocation by network stack / driver while trying to emit
> the messages include __GFP_DIRECT_RECLAIM flag (e.g. GFP_KERNEL) ?
> Commit 400e22499dd92613821 handles only memory allocations with
> __GFP_DIRECT_RECLAIM flag. If memory allocation when trying to emit
> the messages does not include __GFP_DIRECT_RECLAIM flag (e.g.
> GFP_ATOMIC / GFP_NOWAIT), doesn't this particular problem still exist?

Console drivers are always called from atomic contexts (including
IRQ->printk->console_driver paths); if any console driver does a
GFP_KERNEL allocation then it should be fixed.

	-ss

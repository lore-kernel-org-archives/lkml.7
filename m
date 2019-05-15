Return-Path: <SRS0=FrXW=TP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7761CC04E53
	for <linux-kernel@archiver.kernel.org>; Wed, 15 May 2019 19:41:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 37D0821734
	for <linux-kernel@archiver.kernel.org>; Wed, 15 May 2019 19:41:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BZfYFguX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727969AbfEOTk7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 15 May 2019 15:40:59 -0400
Received: from mail-qk1-f193.google.com ([209.85.222.193]:44141 "EHLO
        mail-qk1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727927AbfEOTk7 (ORCPT
        <rfc822;Linux-kernel@vger.kernel.org>);
        Wed, 15 May 2019 15:40:59 -0400
Received: by mail-qk1-f193.google.com with SMTP id w25so743452qkj.11
        for <Linux-kernel@vger.kernel.org>; Wed, 15 May 2019 12:40:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=aXpxd4a79fcfVqLxkskReUgy/Rl3Pd6pqIUAKCO54xQ=;
        b=BZfYFguX/CCLWpISY9P83xd0JZ6m5oon4hcHqdXAZewaGuhvB7Ix+zwiXyyIIH+G66
         tLp3yF705azLPCi4DffXx5f7U4tAmwbPVRLyakA6XJOjEVX0BwGXBkxlatqZekuFgLNP
         2qL+Jd9XhUa0VqZyQiBaNT2p6HL6ljx92VoJXuPQdwW4tBGZJTNlxIkM1ikL6zYUz7Xp
         DYQ2RK+hs+ffW8+T+P4RkzX6AUvuujpuKSrrMO/2twEWEyzoyrXmszjYz6IZKQjUwYAT
         e4WwnFQMxYf5ht0S5SIuUkA0xaKkrGysxOgsyg3b2Mq9Fx2sF2POyStb2D6DR+A8MlNk
         /Kmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=aXpxd4a79fcfVqLxkskReUgy/Rl3Pd6pqIUAKCO54xQ=;
        b=luC7FrWf9VpXYAwHpBmWp7Z3Z424JPtBA1cp3Z1uIFT6AtPxxLIc0LG8uSa8aC9FRM
         GLDdB7Y96r5r4ZpdynOgNSOzeImh3jwhu5Vv4URF+bglIy1y5fJ+bWKQN+obO3XvGz5J
         Zy4+fjmRJ1aVkxo830DkUwW43SlJhLEJX4/xaz5uDrX4/wuhCrBgTwA5NrpmWYPaMcd+
         2vcwBJ/koBm7uPBGralJyQoeJbNzI2WpGvoi0rM+D8DOAzfNMsVZFr8XOX4Wk+FgdBOZ
         72wYu/CDxShvv1acABIHY2QpOAm5/+SEEJMxT22KPBSgGrkMEno/jaWYShGudj7Kk1B+
         N5dA==
X-Gm-Message-State: APjAAAVL8f4l4AS2nP6cWuNxGfTI69TrlfVvbwkkoptkBTjSpb9dDFvZ
        zFwX+Jawk07XUOQEt38uBoU=
X-Google-Smtp-Source: APXvYqyZAwqDaYRrfXH3a+M8Aef3z0ERk3DUr2qaNiisUN6fAs0whCl/9kVSxz4rIZa0M6Rmv39TSw==
X-Received: by 2002:a37:67c6:: with SMTP id b189mr8684760qkc.331.1557949258441;
        Wed, 15 May 2019 12:40:58 -0700 (PDT)
Received: from quaco.ghostprotocols.net ([179.97.35.11])
        by smtp.gmail.com with ESMTPSA id e4sm1392996qkl.17.2019.05.15.12.40.57
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 15 May 2019 12:40:57 -0700 (PDT)
From:   Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>
X-Google-Original-From: Arnaldo Carvalho de Melo <acme@kernel.org>
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 834E6404A1; Wed, 15 May 2019 16:40:54 -0300 (-03)
Date:   Wed, 15 May 2019 16:40:54 -0300
To:     Jin Yao <yao.jin@linux.intel.com>
Cc:     jolsa@kernel.org, peterz@infradead.org, mingo@redhat.com,
        alexander.shishkin@linux.intel.com, Linux-kernel@vger.kernel.org,
        ak@linux.intel.com, kan.liang@intel.com, yao.jin@intel.com
Subject: Re: [PATCH v4 0/4] perf: Support a new 'percore' event qualifier
Message-ID: <20190515194054.GH23162@kernel.org>
References: <1555077590-27664-1-git-send-email-yao.jin@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1555077590-27664-1-git-send-email-yao.jin@linux.intel.com>
X-Url:  http://acmel.wordpress.com
User-Agent: Mutt/1.11.3 (2019-02-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Fri, Apr 12, 2019 at 09:59:46PM +0800, Jin Yao escreveu:
> The 'percore' event qualifier which sums up the event counts for both
> hardware threads in a core. For example,
> 
> perf stat -e cpu/event=0,umask=0x3,percore=1/,cpu/event=0,umask=0x3/
> 
> In this example, we count the event 'ref-cycles' per-core and per-CPU in
> one perf stat command-line.
> 
> We can already support per-core counting with --per-core, but it's
> often useful to do this together with other metrics that are collected
> per CPU (per hardware thread). So this patch series supports this
> per-core counting on a event level.
> 
>  v4:
>  ---
>  Add percore qualifier to documantation.
>  Rebase to latest perf/core branch

Thanks, applied.

- Arnaldo

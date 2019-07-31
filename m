Return-Path: <SRS0=cgli=V4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7D032C32751
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Jul 2019 10:32:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4D211206A2
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Jul 2019 10:32:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="rBqIcmbS"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387754AbfGaKcI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 31 Jul 2019 06:32:08 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:43696 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387732AbfGaKcH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Jul 2019 06:32:07 -0400
Received: by mail-pg1-f194.google.com with SMTP id r22so4157194pgk.10
        for <linux-kernel@vger.kernel.org>; Wed, 31 Jul 2019 03:32:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=SMJmGTgTJx1puVVfsJJ42fe0H9d4/Gw6mkpPH+rSO4k=;
        b=rBqIcmbStzTQ3oTeeSyL8wL6EwXxdtrSctbr5lA9P6czOOigYpjzqy8J8Nq+bhr4Qj
         CNwBMpTE3g2fLvTd5v2PjReVOofIolugw6o+cOiRsegVjnQqgXcnVc7KlxvzURD+3eL8
         NTdszFzmnx4PykIQhKPJhywLGuoAKRAB2BrBTeDLmX86VuWNbCaOWOcRnsfSZokv1ZhS
         SR1Ru7muAtIICdQJBYXGODspggZYb6oOS6S0pCoThW622RbSb5yY8JV4bBfToJHpVMR8
         xTSpxTkizttHr6erR2rHWtMN9Z3jClZSwHIEpmaQhTuQJp5Y0qWjYq7j+y2SU5tRVEXj
         ii7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=SMJmGTgTJx1puVVfsJJ42fe0H9d4/Gw6mkpPH+rSO4k=;
        b=M5FvO9XEClNP/mYrglWkfs3u5su0zyOgUiEd6O5lnyCh58+6Jnzevx1ubhrMJAzgIM
         XM3ZMXs7QSkR7tXOuI3yriiCYMVUTNZvq4vY3BsvHZAXodNHpv4s2WjSUshtKvbdXbr1
         1tQ2wRIda8OkIhjH7Njdaa6K8C2XuJoRwrEvJWUBNnM37juGMk9vOOfg76Y7IpV1dduj
         Rv122UAwezwztOVfaA1SE+TN02rTwgYUimTVPrHWEA0rPb/Q7bas61SqtlYPMfZB6/qN
         LPPI7UZyOUAsRxgxbL97tSMICWymJ/gAD0Dv6btb8fcFYB+OFdOl4XWw83MqJq4C+TAq
         0ybw==
X-Gm-Message-State: APjAAAUO5q6dhJVDwMekcxGww+C6o+LXqEpIDsbt8kAJXVLm68z9WDBz
        nMXBEkRhyiNJTZuwYBEWGlU=
X-Google-Smtp-Source: APXvYqwtKdGDQiPyK3jfLve03Gkv/raLCsHia1CehBco7S+qsecgbS4UpLo7p/nm5kXylF8XGFgO5A==
X-Received: by 2002:a17:90b:8c8:: with SMTP id ds8mr2275481pjb.89.1564569127210;
        Wed, 31 Jul 2019 03:32:07 -0700 (PDT)
Received: from mail.google.com ([149.28.153.17])
        by smtp.gmail.com with ESMTPSA id v14sm72424656pfm.164.2019.07.31.03.31.52
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Wed, 31 Jul 2019 03:32:06 -0700 (PDT)
Date:   Wed, 31 Jul 2019 18:31:45 +0800
From:   Changbin Du <changbin.du@gmail.com>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     Changbin Du <changbin.du@gmail.com>,
        Ingo Molnar <mingo@redhat.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] fgraph: Remove redundant ftrace_graph_notrace_addr() test
Message-ID: <20190731103143.ear4erai6yvt4ct6@mail.google.com>
References: <20190730140850.7927-1-changbin.du@gmail.com>
 <20190730121527.13f600f5@gandalf.local.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190730121527.13f600f5@gandalf.local.home>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 30, 2019 at 12:15:27PM -0400, Steven Rostedt wrote:
> On Tue, 30 Jul 2019 22:08:50 +0800
> Changbin Du <changbin.du@gmail.com> wrote:
> 
> > We already have tested it before. The second one should be removed.
> > With this change, the performance should have little improvement.
> > 
> > Fixes: 9cd2992f2d6c ("fgraph: Have set_graph_notrace only affect function_graph tracer")
> 
> Thanks! I think this should even be marked for stable. Not really a bad
> bug, but a bug none the less.
>
Steven, need I resend this patch and cc stable mailist?

> -- Steve
> 
> 
- 
Cheers,
Changbin Du

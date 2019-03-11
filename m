Return-Path: <SRS0=FxTY=RO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_MUTT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A8DBEC43381
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Mar 2019 17:27:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7B5522063F
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Mar 2019 17:27:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=cmpxchg-org.20150623.gappssmtp.com header.i=@cmpxchg-org.20150623.gappssmtp.com header.b="NWdY7zDW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728106AbfCKR1O (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Mar 2019 13:27:14 -0400
Received: from mail-yw1-f66.google.com ([209.85.161.66]:44756 "EHLO
        mail-yw1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727988AbfCKR1L (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Mar 2019 13:27:11 -0400
Received: by mail-yw1-f66.google.com with SMTP id c4so4530291ywa.11
        for <linux-kernel@vger.kernel.org>; Mon, 11 Mar 2019 10:27:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=Qz2LSTrCowWdInggZExDyZ73I7go08ROist2vGyWaAs=;
        b=NWdY7zDWCp8h9yZobxfgQ2nm/lUfyHtUSPWMw0WZPCqLMsiXwFFwG4vXXTFg0zM8h1
         unavAhXD7dRhuHZJcZ3Jwcs0RjcXY8Mmgl2vHp+VAwVTXffG1I6t/tpSJSoxThbS8u6i
         LVtNP2btdhq77rK/oI0+3cwtBW1cTDHjD2Qq/UEVN6QWW9tfSZyHEDjcO8ch+mE2aefc
         dSPa581sRwD9Qr6UejYn4LR4YfjON0s1xyJ+yB8772cu9PrQJNW0nuf+pEKqR25k7nSd
         OpexzMRyvGlnhplgnBbl5kUzReJz+8fMl0ezJ21NRqkbG4DdzBuYCVLKiF3KETyQyjeY
         8qpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=Qz2LSTrCowWdInggZExDyZ73I7go08ROist2vGyWaAs=;
        b=C/R2gE1c/XJh5PZjj66iSRV8kQb68SnC3wiCm31ZqVt2l3kMSkZMzlMH70hAd5kZws
         OAWX8AgIVrqnJeOgw1zHSu1AX4sT5kLVxyPsDn329eacmcV7BfkSeF5f8He1NT9qsXWc
         6/ODnZHP/A59T48LnnpoS7jtrbqJSO0IGppI/iHcxz7fstnDUylj9Hp51rr73+u6btue
         E6a4HztRC6sBvQpbhfal6Qk1d0/fHDyvj1JiopIgXnF9rDoE65VxLslG+BSGsaghoKjk
         etigceBfC+x0kF10Si/J+JwyQXRDHlr/+oX6Cl2eH8Q/OjL0ADofmUiFV/uo7g1UH03e
         dd8A==
X-Gm-Message-State: APjAAAVYP7Eh2wv3bWXVCsQiP004mOndFbDP0cUOouU6D/n4CN9+JmvQ
        NuKHtmOkuQUVdRqSYcwvnoym+Q==
X-Google-Smtp-Source: APXvYqyIB/mcNEO7gcVIKGHcUe3j33jfoK4LxvNW6DCh9WkpK2nTDMYfPZRFjTeFxP/5nIDj1ROi0w==
X-Received: by 2002:a81:180b:: with SMTP id 11mr24926060ywy.431.1552325230276;
        Mon, 11 Mar 2019 10:27:10 -0700 (PDT)
Received: from localhost ([2620:10d:c091:200::1:3c60])
        by smtp.gmail.com with ESMTPSA id q7sm3187834ywl.68.2019.03.11.10.27.08
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 11 Mar 2019 10:27:09 -0700 (PDT)
Date:   Mon, 11 Mar 2019 13:27:08 -0400
From:   Johannes Weiner <hannes@cmpxchg.org>
To:     Roman Gushchin <guroan@gmail.com>
Cc:     linux-mm@kvack.org, kernel-team@fb.com,
        linux-kernel@vger.kernel.org, Tejun Heo <tj@kernel.org>,
        Rik van Riel <riel@surriel.com>,
        Michal Hocko <mhocko@kernel.org>, Roman Gushchin <guro@fb.com>
Subject: Re: [PATCH 4/5] mm: release per-node memcg percpu data prematurely
Message-ID: <20190311172708.GD10823@cmpxchg.org>
References: <20190307230033.31975-1-guro@fb.com>
 <20190307230033.31975-5-guro@fb.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190307230033.31975-5-guro@fb.com>
User-Agent: Mutt/1.11.3 (2019-02-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 07, 2019 at 03:00:32PM -0800, Roman Gushchin wrote:
> Similar to memcg-level statistics, per-node data isn't expected
> to be hot after cgroup removal. Switching over to atomics and
> prematurely releasing percpu data helps to reduce the memory
> footprint of dying cgroups.
> 
> Signed-off-by: Roman Gushchin <guro@fb.com>

Acked-by: Johannes Weiner <hannes@cmpxchg.org>

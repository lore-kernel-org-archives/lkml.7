Return-Path: <SRS0=camR=ZD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 07FC9C43331
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Nov 2019 23:31:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9F08D21872
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Nov 2019 23:31:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=firstfloor.org header.i=@firstfloor.org header.b="yJSRUbmi"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727312AbfKKXb2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Nov 2019 18:31:28 -0500
Received: from one.firstfloor.org ([193.170.194.197]:57802 "EHLO
        one.firstfloor.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726845AbfKKXb2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Nov 2019 18:31:28 -0500
Received: by one.firstfloor.org (Postfix, from userid 503)
        id B30C9868A0; Tue, 12 Nov 2019 00:31:25 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=firstfloor.org;
        s=mail; t=1573515085;
        bh=/YG7iYvKQcvQld0zxP+iPdp8eOlj2RsC4YoG4jWbczM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=yJSRUbmiU3bFUZW6AOnkY2T5QOZeza/9fERK5ybf1nevjDwK6eTGX7KNn9XtXvm/J
         6U4OyngwlFxc2GjNNNLgTGCaDkms9TtSEdoR+GjE3XIQj7VG2xDvrXqOJJGFx0HqR/
         wDVa3F78xyB/Ag1wdA2IJBaLzsG98g8uhCJWcxuI=
Date:   Mon, 11 Nov 2019 15:31:25 -0800
From:   Andi Kleen <andi@firstfloor.org>
To:     Jiri Olsa <jolsa@redhat.com>
Cc:     Andi Kleen <ak@linux.intel.com>, Andi Kleen <andi@firstfloor.org>,
        jolsa@kernel.org, acme@kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5 13/13] perf stat: Use affinity for enabling/disabling
 events
Message-ID: <20191111233124.sg4g7rkwa4g4u7al@two.firstfloor.org>
References: <20191107181646.506734-1-andi@firstfloor.org>
 <20191107181646.506734-14-andi@firstfloor.org>
 <20191111140415.GA26980@krava>
 <20191111165028.GC573472@tassilo.jf.intel.com>
 <20191111200655.GB31193@krava>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191111200655.GB31193@krava>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> then let's have some assert or BUG_ON on !all_cpus
> and remove the fallback code from close path

I tried it again, but in record mode evsel->cpus is usually NULL,
resulting in various crashes.

I think fixing this beyond the scope of this patchkit, so i will
keep the fallback checks for now. I'll add better comments though.

-Andi

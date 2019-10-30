Return-Path: <SRS0=iR9I=YX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3ECDFCA9EC5
	for <linux-kernel@archiver.kernel.org>; Wed, 30 Oct 2019 19:03:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DA75B20856
	for <linux-kernel@archiver.kernel.org>; Wed, 30 Oct 2019 19:03:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=firstfloor.org header.i=@firstfloor.org header.b="vLJPm3DV"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726826AbfJ3TDb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 30 Oct 2019 15:03:31 -0400
Received: from one.firstfloor.org ([193.170.194.197]:35448 "EHLO
        one.firstfloor.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726261AbfJ3TDb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Oct 2019 15:03:31 -0400
Received: by one.firstfloor.org (Postfix, from userid 503)
        id ECFE98675A; Wed, 30 Oct 2019 20:03:28 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=firstfloor.org;
        s=mail; t=1572462208;
        bh=mYGzCanGJbm0EEw0nfPmJ1uAjjZgWBai/S1s0YfyrI8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=vLJPm3DVd6ULcfZOpqisGNldgvSmKHIATLy09mAQgF8J9YTva0JSoCfaHyhg+yyni
         F2DMWum494N3b3syeNqBcWjh9vahpBJfEXSEkiR/WdOyaxchezg/atkNHadsMSYrkw
         mkex/WXnUQGGvTm5iDKsGNuA034fkVepl8PWze+o=
Date:   Wed, 30 Oct 2019 12:03:28 -0700
From:   Andi Kleen <andi@firstfloor.org>
To:     Jiri Olsa <jolsa@redhat.com>
Cc:     Andi Kleen <andi@firstfloor.org>, acme@kernel.org,
        jolsa@kernel.org, eranian@google.com, linux-kernel@vger.kernel.org,
        Andi Kleen <ak@linux.intel.com>
Subject: Re: [PATCH v3 3/7] perf evsel: Add iterator to iterate over events
 ordered by CPU
Message-ID: <20191030190328.fhsv7e2fqqvfpsit@two.firstfloor.org>
References: <20191025181417.10670-1-andi@firstfloor.org>
 <20191025181417.10670-4-andi@firstfloor.org>
 <20191030100606.GG20826@krava>
 <20191030155108.taqo2kbuaro3idhe@two.firstfloor.org>
 <20191030181552.GM20826@krava>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191030181552.GM20826@krava>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> 
> > The exists evlist->cpus cannot be used (I tried that)
> > I also don't think we have an existing function to merge
> > two maps, so that would need to be added to create it.
> > Just using ->cpu_index is a much simpler change.
> 
> I dont think that would be lot of code
> and it would simplify this one

AFAIK they're not guaranteed to be sorted, which makes merging
complicated. I'm not sure it's safe to just sort existing maps
because someone might have a index.

So you'll need to create temporary maps, sort them and then 
merge. Won't be simple.

-Andi

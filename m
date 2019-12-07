Return-Path: <SRS0=Iet2=Z5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 235ABC43603
	for <linux-kernel@archiver.kernel.org>; Sat,  7 Dec 2019 00:13:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B23842245C
	for <linux-kernel@archiver.kernel.org>; Sat,  7 Dec 2019 00:13:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1575677603;
	bh=cRJyhwcrWWoggU0a/DQMLsTC6qlKaCboNpZR+V9cItk=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=1bck4Ab6caT74aELP9Jq1r4+b3TChsWB2IluSeCyfgPUprvhp354E+GnuZ+wzDiZH
	 IYbz6Hf84rsfokh74H/FofNJ5qF9xRo7zmgfDInq8y+T54pmU0P2pFV2msL7mcnwx8
	 egjExLn1LXg0duMSrKhIqg7Qotps5sed5ysTCo64=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726418AbfLGANW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 6 Dec 2019 19:13:22 -0500
Received: from mail.kernel.org ([198.145.29.99]:33966 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726375AbfLGANW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Dec 2019 19:13:22 -0500
Received: from localhost.localdomain (c-73-231-172-41.hsd1.ca.comcast.net [73.231.172.41])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id AEDBC21835;
        Sat,  7 Dec 2019 00:13:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1575677601;
        bh=cRJyhwcrWWoggU0a/DQMLsTC6qlKaCboNpZR+V9cItk=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=0NLnKdpqGtCiPZQVLL8zg+mDF5bzkCi2vuMbjbTJ48EwR9W0cjwchH9j4Il96rQBo
         /rX8rPzKURxZY4272i9kUur/ez97JpHvQrLTvtdzm/zFl+20Q2dRanUDw6zxEAx6A8
         WktX4tWKdP6+H9fkVTlV9ZoUNJ6RxJ5wrEOeEZ08=
Date:   Fri, 6 Dec 2019 16:13:21 -0800
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Shakeel Butt <shakeelb@google.com>
Cc:     Roman Gushchin <guro@fb.com>, linux-mm@kvack.org,
        Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@suse.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] memcg: account security cred as well to kmemcg
Message-Id: <20191206161321.35ec9a9dc0ed50222a06fee3@linux-foundation.org>
In-Reply-To: <20191205223721.40034-1-shakeelb@google.com>
References: <20191205223721.40034-1-shakeelb@google.com>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu,  5 Dec 2019 14:37:21 -0800 Shakeel Butt <shakeelb@google.com> wrote:

> The cred_jar kmem_cache is already memcg accounted in the current
> kernel but cred->security is not. Account cred->security to kmemcg.
> 
> Recently we saw high root slab usage on our production and on further
> inspection, we found a buggy application leaking processes. Though that
> buggy application was contained within its memcg but we observe much
> more system memory overhead, couple of GiBs, during that period. This
> overhead can adversely impact the isolation on the system. One of source
> of high overhead, we found was cred->secuity objects.

A bit of an oversight and the fix is simple.  Is it worth a cc:stable?

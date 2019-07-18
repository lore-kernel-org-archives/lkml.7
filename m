Return-Path: <SRS0=Pa1K=VP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 385A1C76196
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Jul 2019 11:39:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0DAF42184B
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Jul 2019 11:39:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amazonses.com header.i=@amazonses.com header.b="FDFQtZ4z"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390223AbfGRLjd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Jul 2019 07:39:33 -0400
Received: from a9-37.smtp-out.amazonses.com ([54.240.9.37]:33408 "EHLO
        a9-37.smtp-out.amazonses.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2389994AbfGRLjd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Jul 2019 07:39:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple;
        s=6gbrjpgwjskckoa6a5zn6fwqkn67xbtw; d=amazonses.com; t=1563449972;
        h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:MIME-Version:Content-Type:Feedback-ID;
        bh=3iT/OaO0Q2X3P8RhjupPqyY23NtLVrvRLicg+uM8g44=;
        b=FDFQtZ4zf6FgI43zUELi6/Zg+fvJYbr4Qi8Uy1KRexi8MISbZNS8UXYwlbwZtKjr
        ZIcLsvcRKg0taoqGZ17XIpRSbXCYzGRGkp10Y+jcpW8bkQDY7U0lVrCEYNhOxWMj9fc
        tr6WLHoRK9d2cxDtjdaAcHLtgqjGMyN9te7rG0NQ=
Date:   Thu, 18 Jul 2019 11:39:32 +0000
From:   Christopher Lameter <cl@linux.com>
X-X-Sender: cl@nuc-kabylake
To:     Waiman Long <longman@redhat.com>
cc:     Pekka Enberg <penberg@kernel.org>,
        David Rientjes <rientjes@google.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, Michal Hocko <mhocko@kernel.org>,
        Roman Gushchin <guro@fb.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Shakeel Butt <shakeelb@google.com>,
        Vladimir Davydov <vdavydov.dev@gmail.com>
Subject: Re: [PATCH v2 2/2] mm, slab: Show last shrink time in us when
 slab/shrink is read
In-Reply-To: <20190717202413.13237-3-longman@redhat.com>
Message-ID: <0100016c04e1562a-e516c595-1d46-40df-ab29-da1709277e9a-000000@email.amazonses.com>
References: <20190717202413.13237-1-longman@redhat.com> <20190717202413.13237-3-longman@redhat.com>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-SES-Outgoing: 2019.07.18-54.240.9.37
Feedback-ID: 1.us-east-1.fQZZZ0Xtj2+TD7V5apTT/NrT6QKuPgzCT/IC7XYgDKI=:AmazonSES
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 17 Jul 2019, Waiman Long wrote:

> The show method of /sys/kernel/slab/<slab>/shrink sysfs file currently
> returns nothing. This is now modified to show the time of the last
> cache shrink operation in us.

What is this useful for? Any use cases?

> CONFIG_SLUB_DEBUG depends on CONFIG_SYSFS. So the new shrink_us field
> is always available to the shrink methods.

Aside from minimal systems without CONFIG_SYSFS... Does this build without
CONFIG_SYSFS?

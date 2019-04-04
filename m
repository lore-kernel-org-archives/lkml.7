Return-Path: <SRS0=oHH8=SG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A9804C10F0E
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Apr 2019 16:40:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 797EC206DF
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Apr 2019 16:40:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amazonses.com header.i=@amazonses.com header.b="QCkR8nbv"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729520AbfDDQky (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Apr 2019 12:40:54 -0400
Received: from a9-92.smtp-out.amazonses.com ([54.240.9.92]:33912 "EHLO
        a9-92.smtp-out.amazonses.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727051AbfDDQkx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Apr 2019 12:40:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple;
        s=6gbrjpgwjskckoa6a5zn6fwqkn67xbtw; d=amazonses.com; t=1554396052;
        h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:MIME-Version:Content-Type:Feedback-ID;
        bh=28+09XFOqkmUno0MP/WfSRXRXy04JRnokQl+mHKKxO4=;
        b=QCkR8nbvGPc46188u3FKsmfoRKR+C8SJcpzLMQepDco+/v/jNbIM1i9oRzKcsRGJ
        u4bwBFfxfBEwpyaeWRQUN77Wh7CMdEUPsGcX/QH5IPyDlUTiZjZS9yRsV10kZfiS1On
        C2yv3QO2mEYO/RwYRw5MUIOZhGdUdYfLEenOnXIk=
Date:   Thu, 4 Apr 2019 16:40:52 +0000
From:   Christopher Lameter <cl@linux.com>
X-X-Sender: cl@nuc-kabylake
To:     Vlastimil Babka <vbabka@suse.cz>
cc:     linux-mm@kvack.org, Pekka Enberg <penberg@kernel.org>,
        David Rientjes <rientjes@google.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Mel Gorman <mgorman@techsingularity.net>,
        linux-kernel@vger.kernel.org
Subject: Re: [RFC 2/2] mm, slub: add missing kmem_cache_debug() checks
In-Reply-To: <20190404091531.9815-3-vbabka@suse.cz>
Message-ID: <01000169e9397c8b-5e09e11d-50f7-4622-b369-d684d17856c9-000000@email.amazonses.com>
References: <20190404091531.9815-1-vbabka@suse.cz> <20190404091531.9815-3-vbabka@suse.cz>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-SES-Outgoing: 2019.04.04-54.240.9.92
Feedback-ID: 1.us-east-1.fQZZZ0Xtj2+TD7V5apTT/NrT6QKuPgzCT/IC7XYgDKI=:AmazonSES
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 4 Apr 2019, Vlastimil Babka wrote:

> Some debugging checks in SLUB are not hidden behind kmem_cache_debug() check.
> Add the check so that those places can also benefit from reduced overhead
> thanks to the the static key added by the previous patch.

Hmmm... I would not expect too much of a benefit from these changes since
most of the stuff is actually not on the hot path.

Return-Path: <SRS0=WcLH=XI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 66C11C49ED7
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Sep 2019 14:58:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3145C20830
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Sep 2019 14:58:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amazonses.com header.i=@amazonses.com header.b="cWJEtaKY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390183AbfIMO6x (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 13 Sep 2019 10:58:53 -0400
Received: from a9-92.smtp-out.amazonses.com ([54.240.9.92]:42196 "EHLO
        a9-92.smtp-out.amazonses.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2388734AbfIMO6x (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Sep 2019 10:58:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple;
        s=6gbrjpgwjskckoa6a5zn6fwqkn67xbtw; d=amazonses.com; t=1568386731;
        h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:MIME-Version:Content-Type:Feedback-ID;
        bh=Goi0pBynSANamO6sTU161ewP9+QZv8oVwAm3jBmdO0U=;
        b=cWJEtaKYNZrlYAzqOAoWpjRP6vbJ+T2ICB8RBSUIcjzY8rfpYslXS94P4fm2+2um
        F8FykUozRy0/DelRQ0U2zHZsjxeTmxZwnfBkrzY926zHv2q5Ns5buB8tEaA0mr2V14l
        AdyviHsmn3NT3ijwlvQK4kxwlZ2lf2htFRpdF5Tc=
Date:   Fri, 13 Sep 2019 14:58:51 +0000
From:   Christopher Lameter <cl@linux.com>
X-X-Sender: cl@nuc-kabylake
To:     Yu Zhao <yuzhao@google.com>
cc:     Pekka Enberg <penberg@kernel.org>,
        David Rientjes <rientjes@google.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        "Kirill A . Shutemov" <kirill@shutemov.name>,
        Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 4/4] mm: lock slub page when listing objects
In-Reply-To: <20190912023111.219636-4-yuzhao@google.com>
Message-ID: <0100016d2b224ef4-8660f7e9-3093-48fa-bc40-63d20e9f2444-000000@email.amazonses.com>
References: <20190912004401.jdemtajrspetk3fh@box> <20190912023111.219636-1-yuzhao@google.com> <20190912023111.219636-4-yuzhao@google.com>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-SES-Outgoing: 2019.09.13-54.240.9.92
Feedback-ID: 1.us-east-1.fQZZZ0Xtj2+TD7V5apTT/NrT6QKuPgzCT/IC7XYgDKI=:AmazonSES
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 11 Sep 2019, Yu Zhao wrote:

> Though I have no idea what the side effect of such race would be,
> apparently we want to prevent the free list from being changed
> while debugging the objects.

process_slab() is called under the list_lock which prevents any allocation
from the free list in the slab page. This means that new objects can be
added to the freelist which occurs by updating the freelist pointer in the
slab page with a pointer to the newly free object which in turn contains
the old freelist pointr.

It is therefore possible to safely traverse the objects on the freelist
after the pointer has been retrieved

NAK.


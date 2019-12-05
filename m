Return-Path: <SRS0=yQuH=Z3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2D73CC43603
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Dec 2019 02:59:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DB101206DB
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Dec 2019 02:59:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ellerman.id.au header.i=@ellerman.id.au header.b="fr7eUK9Z"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728711AbfLEC7y (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 4 Dec 2019 21:59:54 -0500
Received: from bilbo.ozlabs.org ([203.11.71.1]:47053 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728321AbfLEC7x (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Dec 2019 21:59:53 -0500
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 47T0nK6BZ1z9sNx;
        Thu,  5 Dec 2019 13:59:49 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ellerman.id.au;
        s=201909; t=1575514791;
        bh=RhwaeUVtdgvUjr2JVRfHFkjO1wjCt04eFE+iY69n+iE=;
        h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
        b=fr7eUK9Z+zL6LRB5A77Gky2KVZfX4gfedoY+B5Amafeac65cxStIkN2mfaWUPM//A
         5FwzcBHqe+kxxJIGpuGbGYuzPXsP9mTmFNgSKxjrhfLtCDpABObb9XGx028mkNtOHT
         O8KGO9SvEydlFUPXwe2v23jjS4lchVmwDPyMvprobOvWZlHGSe+d6gp1YjJnwjqQWv
         yWGQIuzOoPZZcO80jh2OgbFnovcVbzBvOYmCNIcG9QpJkda5ES0zEl/vKZHOPDEgYH
         nltcb2DIhaxx34to55oa18r3Jho6wVGcNIBFvc+tE4Is4GXrcVHWZi6UL5AsMwPUfV
         8u708CkeqAXWw==
From:   Michael Ellerman <mpe@ellerman.id.au>
To:     David Hildenbrand <david@redhat.com>, linux-kernel@vger.kernel.org
Cc:     linux-mm@kvack.org,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Richard Fontana <rfontana@redhat.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Arun KS <arunks@codeaurora.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH] powerpc/pseries/cmm: fix wrong managed page count when migrating between zones
In-Reply-To: <7edce293-0ee2-3c2a-8cd9-a3db85465ba7@redhat.com>
References: <20191204205309.8319-1-david@redhat.com> <7edce293-0ee2-3c2a-8cd9-a3db85465ba7@redhat.com>
Date:   Thu, 05 Dec 2019 13:59:49 +1100
Message-ID: <87h82feau2.fsf@mpe.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

David Hildenbrand <david@redhat.com> writes:
> Forgot to rename the subject to
>
> "powerpc/pseries/cmm: fix managed page counts when migrating pages
> between zones"
>
> If I don't have to resend, would be great if that could be adjusted when
> applying.

I can do that.

I'm inclined to wait until the virtio_balloon.c change is committed, in
case there's any changes to it during review, and so we can refer to
it's SHA in the change log of this commit.

Do you want to ping me when that happens?

cheers

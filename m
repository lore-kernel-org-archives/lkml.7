Return-Path: <SRS0=FHjv=VA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 80C05C0650E
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Jul 2019 16:57:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4F12521882
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Jul 2019 16:57:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=bobcopeland-com.20150623.gappssmtp.com header.i=@bobcopeland-com.20150623.gappssmtp.com header.b="nTN2F0rR"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726993AbfGCQ5I (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Jul 2019 12:57:08 -0400
Received: from mail-io1-f66.google.com ([209.85.166.66]:46218 "EHLO
        mail-io1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725847AbfGCQ5H (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Jul 2019 12:57:07 -0400
Received: by mail-io1-f66.google.com with SMTP id i10so6353931iol.13
        for <linux-kernel@vger.kernel.org>; Wed, 03 Jul 2019 09:57:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bobcopeland-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=dWgiLETKBcNIsRn9BLbrSpw0mjUeM+j1jybdOXQhDgc=;
        b=nTN2F0rRwI4TOnWn8TahWBvSdrjRV/t++BXg5hMQrxzEy0drrfRIbBIF2SZHhQF7Kg
         Ag4XjFhRlcnz8OBwZp8GS4PwCJF0pmXfgioGT+8+uX0P5JsHZJAHcqudkX2GVsLPq0xR
         QrgSh7q2jLD7VBajnJt3Bd/VA2wTK+VoI2qvUGi1El4AQHmyYyadHbgWBejM9DPoRynD
         KdelXawDUHAcANTwDX4Tpmprtf8dSyt2DM/NYdOx9DDOJC2bvsST4YeUpVRIjp7GVyIt
         BUulyK2Xea8b5doQ5GC1//SlnjG2PRVysNPg5IJgkb8d/Pnl65BF7nGlt/okCjbsqf1e
         GxFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=dWgiLETKBcNIsRn9BLbrSpw0mjUeM+j1jybdOXQhDgc=;
        b=rNFQXppSVTQSlRwLtEPYhWoWVXJcBMQCCaw818IR/WumfE3gsj0lLilY2OigsuO6uR
         AmvyYgB3lI73205zgwni1z4SCe3h7MxQdVfVJoFRo1J8pIPKLDZ4j3HovOaLevwr4NVE
         fO3wJmNSoZiuJVHKMAA7imzOXqNnUdJW+qSXBc7xfhuuEkZhfVamvlA/X1I/E0mLY/L3
         bpuMmSj6e+W5Avjlnrbo+l36ifxRFAJ7ZD9wWaEJrPRoBe8cVhNCgyLvait6pk6Rw5GP
         liqarJK1oOly+ICemJogLqhsImdg9i/BOYrG9TRfvMZsIRJUTdGyMASg/7P3+2yjD7u0
         IG4g==
X-Gm-Message-State: APjAAAWU6sVBWSn9Pb5i52z4uPH8qkrpKc/W8b3gMLzkZYVow+EDEm5U
        bUx34ST3aWR2NvY2tw/1IV05NQ==
X-Google-Smtp-Source: APXvYqys43jjoBmCxaefnVGj1EpND6ed84mcfOkEiV2XPcdjMNiuF2bQfffsaKsZvrq4jD10J22Xwg==
X-Received: by 2002:a6b:e203:: with SMTP id z3mr8477498ioc.23.1562173026769;
        Wed, 03 Jul 2019 09:57:06 -0700 (PDT)
Received: from hash ([2607:fea8:5ac0:1dd8:230:48ff:fe9d:9c89])
        by smtp.gmail.com with ESMTPSA id l11sm2003323ioj.32.2019.07.03.09.57.05
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Wed, 03 Jul 2019 09:57:05 -0700 (PDT)
Received: from bob by hash with local (Exim 4.92)
        (envelope-from <me@bobcopeland.com>)
        id 1hiiZ7-0003tB-0u; Wed, 03 Jul 2019 12:57:05 -0400
Date:   Wed, 3 Jul 2019 12:57:04 -0400
From:   Bob Copeland <me@bobcopeland.com>
To:     Fuqian Huang <huangfq.daxian@gmail.com>
Cc:     linux-karma-devel@lists.sourceforge.net,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 32/35] omfs: Use kmemdup rather than duplicating its
 implementation
Message-ID: <20190703165704.GC4930@localhost>
References: <20190703163158.937-1-huangfq.daxian@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190703163158.937-1-huangfq.daxian@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 04, 2019 at 12:31:58AM +0800, Fuqian Huang wrote:
> kmemdup is introduced to duplicate a region of memory in a neat way.
> Rather than kmalloc/kzalloc + memcpy, which the programmer needs to
> write the size twice (sometimes lead to mistakes), kmemdup improves
> readability, leads to smaller code and also reduce the chances of mistakes.
> Suggestion to use kmemdup rather than using kmalloc/kzalloc + memcpy.

Acked-by: Bob Copeland <me@bobcopeland.com>

-- 
Bob Copeland %% https://bobcopeland.com/

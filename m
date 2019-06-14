Return-Path: <SRS0=TKbG=UN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 055F9C31E44
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Jun 2019 12:15:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CF798208CA
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Jun 2019 12:15:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lca.pw header.i=@lca.pw header.b="MwtAFV5y"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727878AbfFNMPp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Jun 2019 08:15:45 -0400
Received: from mail-qk1-f195.google.com ([209.85.222.195]:44723 "EHLO
        mail-qk1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727825AbfFNMPm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Jun 2019 08:15:42 -0400
Received: by mail-qk1-f195.google.com with SMTP id p144so1461713qke.11
        for <linux-kernel@vger.kernel.org>; Fri, 14 Jun 2019 05:15:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lca.pw; s=google;
        h=message-id:subject:from:to:cc:date:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=NyPPbZhNfqDmfzBJP+Zyu4+7by3zecVFnafl9bsTygQ=;
        b=MwtAFV5yKDZjuENka2cZ5Jk7AlcHqmJVvy0inE9n2UrHXv6Yj8vPyzIczqRRsPQB27
         BXZNXoSJ2asYEv3DXU1qY1m8POHEK2cReZLmvV9kMpkk91hs9Vc0TXy9slEzlW9pJTqq
         wYCQXJcJCzP7MLDmYZmoG+lIP5lo7ndpiazZx78N76/6QelZ8XrgRTgM1yZ4tLP41Xgf
         dwAKdY8Qi5IZhJxvLiYYSqAnBTNJ3KiUU0r6bPbzaxmVkLxiZgFT6DHx8/jm7J1zAC/S
         Lov76Ss/4eSiZYZBiWTtqVxluPsPVup5ZjZbQs+Sp5IG4CdrCrILC0OPRiH5mxo+Udxq
         VpbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=NyPPbZhNfqDmfzBJP+Zyu4+7by3zecVFnafl9bsTygQ=;
        b=ht3y7c/ecWaBgkvlTed6SeXZ+HBnVOQuct53de3DE8IrWmQt0+ZFXX9tNyjtRX8fxe
         Xtp6rixikJ0bRiPLo3xJVKivtRPdiH6u8MpoM6dofHbRniwVfhdT7mvkAO9FSbvWoxU/
         HSLxYSDPtSU++bW8EhxWAIjEEHiLmoZRmn4FyAbSWJDlfR2u/Yi1jv6ebY1tu3Tr3dG6
         2q2HnF8fAAYZJFSC4jVkGeM163d66llyis+uqbOuQ24f96L+R++K43Z7sihGPCXQIxqr
         dX9EwFl243rUV9L5/M2WBs4aVeJunXyn+EYXtkPKMLmdRZXAuqT406aRM7bYxXAaBwyl
         /5kA==
X-Gm-Message-State: APjAAAWkI+VQbJMQ3C8OPDlQRn3M7WRSjEMf6EJHATBlIfGt4ssBUtgR
        pz+oqi7CZQAsdUkV45eU/Htw2w==
X-Google-Smtp-Source: APXvYqySndvqdRYK4kC/2Q6riAnaWd2ljn8NHp1bqjNlFAW1l2MJtgQLIQJYpItdU3dRO8CgSWdUEw==
X-Received: by 2002:a37:be41:: with SMTP id o62mr64866623qkf.356.1560514541702;
        Fri, 14 Jun 2019 05:15:41 -0700 (PDT)
Received: from dhcp-41-57.bos.redhat.com (nat-pool-bos-t.redhat.com. [66.187.233.206])
        by smtp.gmail.com with ESMTPSA id y6sm1334495qki.67.2019.06.14.05.15.40
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 14 Jun 2019 05:15:41 -0700 (PDT)
Message-ID: <1560514539.5154.20.camel@lca.pw>
Subject: Re: LTP hugemmap05 test case failure on arm64 with linux-next
 (next-20190613)
From:   Qian Cai <cai@lca.pw>
To:     Will Deacon <will.deacon@arm.com>
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
        Anshuman Khandual <anshuman.khandual@arm.com>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        linux-arm-kernel@lists.infradead.org
Date:   Fri, 14 Jun 2019 08:15:39 -0400
In-Reply-To: <20190614102017.GC10659@fuggles.cambridge.arm.com>
References: <1560461641.5154.19.camel@lca.pw>
         <20190614102017.GC10659@fuggles.cambridge.arm.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.22.6 (3.22.6-10.el7) 
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2019-06-14 at 11:20 +0100, Will Deacon wrote:
> Hi Qian,
> 
> On Thu, Jun 13, 2019 at 05:34:01PM -0400, Qian Cai wrote:
> > LTP hugemmap05 test case [1] could not exit itself properly and then degrade
> > the
> > system performance on arm64 with linux-next (next-20190613). The bisection
> > so
> > far indicates,
> > 
> > BAD:  30bafbc357f1 Merge remote-tracking branch 'arm64/for-next/core'
> > GOOD: 0c3d124a3043 Merge remote-tracking branch 'arm64-fixes/for-next/fixes'
> 
> Did you finish the bisection in the end? Also, what config are you using
> (you usually have something fairly esoteric ;)?

No, it is still running.

https://raw.githubusercontent.com/cailca/linux-mm/master/arm64.config

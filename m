Return-Path: <SRS0=bo2+=SE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2F99CC4360F
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Apr 2019 21:18:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C3C602075E
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Apr 2019 21:18:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=cmpxchg-org.20150623.gappssmtp.com header.i=@cmpxchg-org.20150623.gappssmtp.com header.b="GwcNpY4h"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726263AbfDBVSy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Apr 2019 17:18:54 -0400
Received: from mail-yb1-f196.google.com ([209.85.219.196]:42490 "EHLO
        mail-yb1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725842AbfDBVSy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Apr 2019 17:18:54 -0400
Received: by mail-yb1-f196.google.com with SMTP id x84so2940499ybg.9
        for <linux-kernel@vger.kernel.org>; Tue, 02 Apr 2019 14:18:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=4fczxbybzOS+xXNu+Sbb6XyvMGrUo9head3Dw/Kumxw=;
        b=GwcNpY4hgB0cZqJleZoLMgbMadRlRvC6VtmChihSWjY4W/kaunkihTqQmpmoS1YoLD
         BzYo/6a1AHwtZBtDWT/SQK+fSNEgeL3YGNf0Od9S8T73xbAHpWiFPNToOqe+eqFXZcUO
         FkZs4sfOBNpVQDSHhQrLFivW2LfCondKbnP81yo2JxZsLhYkJ5ORch690Sptj+XktHvq
         QO04WZ/rN0xRHpmEBeFe8y3Y/8adS52oZNSseOtqri6l0SUzZNc2y0cHE2pR2Y/ngBTG
         qOnZn4VbdBAFsIshwGOQtmwhNMpwbNeeBMH3We1PXBVwuXkTWyCNMr1lmfgpJ8xvJxEf
         mE5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=4fczxbybzOS+xXNu+Sbb6XyvMGrUo9head3Dw/Kumxw=;
        b=eApokX+BrI8z+K3d/p/yC80yxpp8Dmntio2ECgkeS+gTH+xDAsyUodycZTO2uQ7NyE
         7xyEFAa9Y+0LCY2F3njU/eKvyLHfjYlNhN4BCInp7X9mbAf8/Rk6BUCvTJKhnEkPBvYL
         yImr3+VILxByO9usTd3BoUH5RXZ3uxJYam4/XNaWEvAR1woRPvs/c73O3xCZvjllg4+X
         zPEnQxNXGwZHOdPcUAvYmKrdIFklEsikT+2KXrW4SnkNDRGK1R/+W/7S4y1MOZ3or+2u
         JTWYAD4lQ7azVcaO1rCIhYAOQbCPHG0naI8Zr3Wf6vps4uIZAgBSJTV/2gF2yFPwASwR
         K9Qw==
X-Gm-Message-State: APjAAAWAoiICk2tlj9wFSniTcGEw0/uT1CvKhEtxfYJY4YBtgYIqeqpb
        A1muvQPKGxM5j8ObWsqc2ko9wA==
X-Google-Smtp-Source: APXvYqz756ApciuBlxiY9nRcFafoOD5oKomuZNFIW8mTGGnd/8k3MqHMZ15UlGA9x49Ks18BmEIWMw==
X-Received: by 2002:a25:7102:: with SMTP id m2mr20704482ybc.383.1554239907982;
        Tue, 02 Apr 2019 14:18:27 -0700 (PDT)
Received: from localhost ([2620:10d:c091:200::2:99bf])
        by smtp.gmail.com with ESMTPSA id x13sm10058927ywx.63.2019.04.02.14.18.26
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 02 Apr 2019 14:18:27 -0700 (PDT)
Date:   Tue, 2 Apr 2019 17:18:26 -0400
From:   Johannes Weiner <hannes@cmpxchg.org>
To:     Waiman Long <longman@redhat.com>
Cc:     Jonathan Corbet <corbet@lwn.net>, linux-kernel@vger.kernel.org,
        linux-doc@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Tejun Heo <tj@kernel.org>
Subject: Re: [PATCH] psi: Clarify the units used in pressure files
Message-ID: <20190402211825.GA16779@cmpxchg.org>
References: <20190402193810.3450-1-longman@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190402193810.3450-1-longman@redhat.com>
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 02, 2019 at 03:38:10PM -0400, Waiman Long wrote:
> The output of the PSI files show a bunch of numbers with no unit.
> The psi.txt documentation file also does not indicate what units
> are used.  One can only find out by looking at the source code. The
> units are percentage for the averages and useconds for the total.
> Make the information easier to find by documenting the units in psi.txt.
> 
> Signed-off-by: Waiman Long <longman@redhat.com>

Acked-by: Johannes Weiner <hannes@cmpxchg.org>

Thanks Waiman!

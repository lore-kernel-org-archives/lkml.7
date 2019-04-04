Return-Path: <SRS0=oHH8=SG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CBFA2C4360F
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Apr 2019 10:34:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9739A20657
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Apr 2019 10:34:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ctfGXMNE"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729179AbfDDKeV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Apr 2019 06:34:21 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:33679 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726269AbfDDKeU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Apr 2019 06:34:20 -0400
Received: by mail-wr1-f67.google.com with SMTP id q1so3137743wrp.0
        for <linux-kernel@vger.kernel.org>; Thu, 04 Apr 2019 03:34:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=xlM2KYRf0E+/OSkziWargZzvnW3c+Z58HEWwE11EBzE=;
        b=ctfGXMNEMppSyX6GQILDmvw2EuNdAv/bwx2AO5o6J6izZVMIhCZ3IRtQpwjyuRtdf0
         A2awBuwjZkD/wQVDtIdfXeExIYycaISbD0NwHNqcmHbzlidexIx958k4duc8LI1A9trU
         wN95ulT+yMH0KXNhcCFUOkAkIvXGa4YMaAux7Bk6ens1sw9eHErqVISaaGts3d6DTYk3
         AS/SuFvIRijFLfITVrNuYOI7uosiLveGIw6/b67b84a2Ndfyp3ZlvwJtZb5Cp4cMgAIy
         PMNNC2HvcENrLftgWH9ceyg9VZN8yOc/yQ3mjVPWdbN2IRK7VIYcpTOmAFpK4aZgN8pO
         kkfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=xlM2KYRf0E+/OSkziWargZzvnW3c+Z58HEWwE11EBzE=;
        b=qbz3yXup9CZ7pG4S52vXgrybfIoP3gGBYnOZostHqBF7bsUlf97W0622H/guwnBF3w
         y9h69kOK+oCbrTJm9XH4fQOdEDu6ZgwEEcVOCFMOYk9XxTqPmTeiWapeguFZUd+RIQSB
         RBAn+Rix/LOx/FZ4SEfkvltyeMJA7dNRNKjSW647DwlYAs54iJEXPNnGBtgsYy8OA9U0
         /vgb+25QFLDPI/QaECpjlJYD2G6TuCLeuyUJqVrGFeYKI63E4M0vJxpX6DW4gJuN/YkN
         SB7GC4Of1GATVyCK1VqoQwpqsx9RV6BfGWBlaZzBZuxC/yxEB3bi59aJZR1+sP76ShTB
         AUJQ==
X-Gm-Message-State: APjAAAXS8rFOjuPC9I9NiM9IvAFEGbb6GeQ0azpzVq9rTjEQvznhQP0p
        92xks91ztxLyUizBlb4Cfrs=
X-Google-Smtp-Source: APXvYqwMmMJ9FD9WA7uwTHRAoUBjVP21MtZYultFL5Bm+C4dbXbJ5EO7xZPTex2WqdkFJ89WJLCfTw==
X-Received: by 2002:adf:ec0a:: with SMTP id x10mr3460697wrn.193.1554374059292;
        Thu, 04 Apr 2019 03:34:19 -0700 (PDT)
Received: from Red ([2a01:cb1d:147:7200:2e56:dcff:fed2:c6d6])
        by smtp.googlemail.com with ESMTPSA id x192sm23571511wmf.48.2019.04.04.03.34.17
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 04 Apr 2019 03:34:18 -0700 (PDT)
Date:   Thu, 4 Apr 2019 12:34:15 +0200
From:   Corentin Labbe <clabbe.montjoie@gmail.com>
To:     Robin Murphy <robin.murphy@arm.com>
Cc:     will.deacon@arm.com, mark.rutland@arm.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        tglx@linutronix.de, suzuki.poulose@arm.com, bigeasy@linutronix.de,
        peterz@infradead.org, Meng.Li@windriver.com
Subject: Re: [PATCH v2 0/2] Fix Arm system PMU hotplug issues
Message-ID: <20190404103415.GA8093@Red>
References: <cover.1554310292.git.robin.murphy@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1554310292.git.robin.murphy@arm.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 03, 2019 at 06:08:58PM +0100, Robin Murphy wrote:
> Hi all,
> 
> After a converstaion with Thomas a while back, it felt like the best way
> forward here is just to resolve the pressing preemption violation, and
> not make things more complicated by trying to manage theoretical races
> within perf core from a distance.
> 
> Thus v2 simply nukes the offending logic and brings those drivers in
> line with the status quo. Due to the abrupt change in tactic I've not
> kept the review tags given for v1.
> 
> Robin.
> 
> 
> Robin Murphy (2):
>   perf/arm-cci: Remove broken race mitigation
>   perf/arm-ccn: Remove broken race mitigation
> 
>  drivers/perf/arm-cci.c | 16 +++++++---------
>  drivers/perf/arm-ccn.c | 23 +++++++++++------------
>  2 files changed, 18 insertions(+), 21 deletions(-)
> 
> -- 
> 2.21.0.dirty
> 

Hello

Tested-by: Corentin Labbe <clabbe.montjoie@gmail.com>
Tested-on: sun8i-a83t-bananapi-m3

Thanks for having fixed this problem.
Regards

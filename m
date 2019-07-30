Return-Path: <SRS0=Iew4=V3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=0.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MALFORMED_FREEMAIL,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4D1FDC76186
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jul 2019 02:21:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2326720578
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jul 2019 02:21:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="afk/T4FZ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731195AbfG3CVi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Jul 2019 22:21:38 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:44289 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729020AbfG3CVi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Jul 2019 22:21:38 -0400
Received: by mail-pg1-f194.google.com with SMTP id i18so29199335pgl.11;
        Mon, 29 Jul 2019 19:21:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:date:to:cc:subject:in-reply-to:message-id:references
         :user-agent:mime-version;
        bh=0MOGeuua5cDgk1wyC8caLbfQOiznE0pJ1lOBP7T+nyQ=;
        b=afk/T4FZVHCkLSM8QM6uwClRhAGo4uj5u76cdwhohU0BjXIz+etBByLUd199bvLGZy
         MUnl6g7vMha0S0+Ys5j2BTAtxyWmr7BzGAzy9ABU3qKfzNe6LiI7kN3p+oWwh+Mv0CvK
         pfCJ/forSbJk2e5flf8AZ7O2eb/fssFTc9ljkjPWDpolPCsoWmLnASEK0G3a4NOpcQ90
         WF1TdmXRPPNKvRY47lwYpI5Fy7PCsOmw0Ha05PA07025uBVjQ9JjDJ6HGPC1OKPjHh2g
         IAmLRBOcJxJjp2fXGA4CVlDljs9IcWwKMA/d1q51EgcvLxbc5JxQKhzOij+IGO5IUFp6
         NIVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:in-reply-to:message-id
         :references:user-agent:mime-version;
        bh=0MOGeuua5cDgk1wyC8caLbfQOiznE0pJ1lOBP7T+nyQ=;
        b=VtIDF4sgL77nyvP9Pg1tKOj+Mrs70ftOn09LnvBYj2n0rMMG4G7kzg68QV9oDiOXnr
         bkslwoap3LQrEyyO6KQ6ni3RojkGgUA2mhUqmSu7BBhU5l73LpnM3tDv3GiKdKr3zTgS
         2GFbxvR0fmxXZmbF9A9kgF6mxFjX5Nqriqft6yMaQyZbyZxfiN0ZNtsdIBzEB+6QOuhi
         gyOrgmH2Gmb2DuljxKZue5PzqEvRdiHI1hPvIGu3WRVcevx9OeoXNnOnpvWTwENfn/++
         zHS8FfmGPKiisIiSg1CzzJ21Uc+JYAZdsWvztRWqupJRko6Xfak6atgxmHusPwkMslBR
         Igbw==
X-Gm-Message-State: APjAAAUs7zeXfBjoV0ugZI3EGy+EKoExVvP1WRoSPpoGG56/fE1u2Fqn
        iN4ebHsCiHcfWygP0No0i2M=
X-Google-Smtp-Source: APXvYqzmHNiAf2mn+7lldUmTRjWDG/BtWOcSnyVMvKF79mbdzG1o8SibKedPpOXVp/snpkVbjxKOyg==
X-Received: by 2002:a17:90b:8cd:: with SMTP id ds13mr109026438pjb.141.1564453297954;
        Mon, 29 Jul 2019 19:21:37 -0700 (PDT)
Received: from mbalantz-desktop (d206-116-172-62.bchsia.telus.net. [206.116.172.62])
        by smtp.gmail.com with ESMTPSA id x9sm39958232pgp.75.2019.07.29.19.21.37
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Mon, 29 Jul 2019 19:21:37 -0700 (PDT)
From:   Mark Balantzyan <mbalant3@gmail.com>
X-Google-Original-From: Mark Balantzyan <mbalantz@mbalantz-desktop>
Date:   Mon, 29 Jul 2019 19:21:33 -0700 (PDT)
To:     Guenter Roeck <linux@roeck-us.net>
cc:     Mark Balantzyan <mbalant3@gmail.com>, linux-kernel@vger.kernel.org,
        linux-watchdog@vger.kernel.org, wim@linux-watchdog.org
Subject: Re: [PATCH] watchdog device drivers:pc87413_wdt: Rewriting of
 pc87413_wdt driver to utilize common watchdog interface (fwd)
In-Reply-To: <c28680b5-d262-97ae-5bdc-5cce9169e2da@roeck-us.net>
Message-ID: <alpine.DEB.2.21.1907291917540.67851@mbalantz-desktop>
References: <alpine.DEB.2.21.1907291614270.2893@mbalantz-desktop> <8e159e06-023e-6e20-ced5-3a645c0a1242@roeck-us.net> <alpine.DEB.2.21.1907291732130.20898@mbalantz-desktop> <c28680b5-d262-97ae-5bdc-5cce9169e2da@roeck-us.net>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; format=flowed; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all, Guenter,

Sure, it'd be great to work on ib700, doing both, if we may. I feel it's 
worth a shot in case somebody out there has the hardware to test the 
pc87413_wdt driver, though I'm doing my best building the individual 
module and checking for compilation errors (as best I can).

I just sent off via git send-email a quad-chain of patches for the driver.

Thanks + regards,
Mark


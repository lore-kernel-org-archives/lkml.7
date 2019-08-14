Return-Path: <SRS0=cDsG=WK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,USER_IN_DEF_DKIM_WL autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5B90AC32750
	for <linux-kernel@archiver.kernel.org>; Wed, 14 Aug 2019 00:36:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2A8A120843
	for <linux-kernel@archiver.kernel.org>; Wed, 14 Aug 2019 00:36:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="agaAlbCO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726780AbfHNAgC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 13 Aug 2019 20:36:02 -0400
Received: from mail-pg1-f202.google.com ([209.85.215.202]:35522 "EHLO
        mail-pg1-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726316AbfHNAgB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Aug 2019 20:36:01 -0400
Received: by mail-pg1-f202.google.com with SMTP id q1so11776848pgt.2
        for <linux-kernel@vger.kernel.org>; Tue, 13 Aug 2019 17:36:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=Cu+36JF78r6qebD+fzAIMoP3auw3DHa5JgHDYnbOQS4=;
        b=agaAlbCOXwpWZ1rEpbIgzA1nhq8apU3jhz4rB11Ox7zK2Akab4jmWCwf1eFEYcSdqk
         6vSzssiCyk0/Re2v8sDIDWJ0TNqu3TPrBbrYEhpamBw7VPCYw0DtfRLzMGPGZ3ryAuIY
         +qHlW4a7XJ9GTFQfBxavwd5WnKw8JvZ+DRo4ZAw1+MRqM6Zpxjwrt8YWX1/zQBy8AeXw
         N8cmA2+as9UuCYoxAgtnQ7vA8hs3USlmTxaGwekpWHOaWHSMUJ8nqvq5B1nzDcS1y1kD
         OjjMABjUm1UW60sNRsPCd+Rrebhhd9kq7lHrLZbpzG36YubdO0UzANYILQCGIsskE5Ud
         R7uQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=Cu+36JF78r6qebD+fzAIMoP3auw3DHa5JgHDYnbOQS4=;
        b=j8yQOH6Rl2zF+7WkDiJAVJfL0Xb2TYLav1sCJ0ph7OvOJLZODFREQ8I0F9O2k3miRA
         ilMWOlj6AdboBwZCGXyDmo/x8rohw21h8vV1Mc/ne7sZ4GAyzjtCFH8DKSOAxanGw1yX
         KKksdIjseePHjPWOKZTbVfyhUcnWirpLpeKpmTiJ51f+xQ4e0P7MwfSP8mYmDBEE9NXj
         OHsK7zt3ID+tgzTjtvTBSX0IDEigrEBZ/E9JzhCsUI9gs03FH5nGCw6AhR551ZbHi3ZA
         BLO0olKDy4pO0o3ciXf/wh3qlCQ/hVJxBoRCWPbct40F0iG7JSwbCNeIoFB4fPqXV9/i
         5FgA==
X-Gm-Message-State: APjAAAWRmfiKm2OWhTidpDLjIdl2rOaZkzZYXmusKSmxKzPGaeaTU+pB
        rc5V46Segv1UlztUkOrQIMZqnPLIJw==
X-Google-Smtp-Source: APXvYqx9gRONA4IxsGp99a+6zL2GKJFiLbvPKafeGJacjMPJ8nB+SZ7n6psXm+8vxgexYBchbRllgwxBVdM=
X-Received: by 2002:a63:5f01:: with SMTP id t1mr9981095pgb.200.1565742960704;
 Tue, 13 Aug 2019 17:36:00 -0700 (PDT)
Date:   Tue, 13 Aug 2019 17:35:57 -0700
In-Reply-To: <CANLsYkzH-ZWV3qF4p4Yvfy3EfBvZUYyDH+SDdUyuS3fGw9h_Fw@mail.gmail.com>
Message-Id: <20190814003557.97004-1-yabinc@google.com>
Mime-Version: 1.0
References: <CANLsYkzH-ZWV3qF4p4Yvfy3EfBvZUYyDH+SDdUyuS3fGw9h_Fw@mail.gmail.com>
X-Mailer: git-send-email 2.23.0.rc1.153.gdeed80330f-goog
Subject: Re: [PATCH v3] coresight: Serialize enabling/disabling a link device.
From:   Yabin Cui <yabinc@google.com>
To:     Mathieu Poirier <mathieu.poirier@linaro.org>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Yabin Cui <yabinc@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> The patch isn't difficult to do but does go deeper in each link
> drivers (ETF, funnel, replicator).  Let me know if you are not
> comfortable with the idea and I will see what I can do on my side.

I am comfortable with the idea. I chose to add lock in coresight_enable_link() just because it
is the smallest change. But a refactor probably is better for maintainance.

Feel free to upload a new patch fixing the problem. I can help to test it.

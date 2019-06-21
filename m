Return-Path: <SRS0=s1fu=UU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,USER_IN_DEF_DKIM_WL autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3D5CCC43613
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Jun 2019 01:19:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 127642084A
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Jun 2019 01:19:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="uJA8GXH0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726203AbfFUBTs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Jun 2019 21:19:48 -0400
Received: from mail-pl1-f202.google.com ([209.85.214.202]:44571 "EHLO
        mail-pl1-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726106AbfFUBTr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Jun 2019 21:19:47 -0400
Received: by mail-pl1-f202.google.com with SMTP id n1so2661384plk.11
        for <linux-kernel@vger.kernel.org>; Thu, 20 Jun 2019 18:19:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=kxQz0Fl6z9VQMt6gH+UCTNHqWLDkknyKLbiNKZTb/0E=;
        b=uJA8GXH0tWNxWQqjFS6Ap0uI6ZKu38NASgDmqpItDDXYKTj8gwId0lUB1VZGgD41y/
         6m7/wysFDtuvXJARZSB6k7rXCMu51J69uqR/34U0Y/AunpvNNSzrHAvrsBnD3YDD9CVq
         TqlyBLSBPvuC8Zbo1sb8Aw6aB/iY6TOFYTNdJYGrAZ+En2qZdwu0mFB5aVCk91wS6NUQ
         qXrTq8SX8fyCgqibF9XK7XaIy5bXRHi+uzz2Y1dwI8/G26tKo2G5SRyyA/eyL5R6C2q1
         VRcEFw6OFqExjYqMoC/p5LcMtNwFl/waDeFjZL3jt88mwekmHM63N7hGCIsl0ORVSyP7
         ToAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=kxQz0Fl6z9VQMt6gH+UCTNHqWLDkknyKLbiNKZTb/0E=;
        b=ec1DwUZDO18FOCVBWVZz8z9RlEI2+olNw330sA0+UP0aX58eWDjmvkOVJAw3drB5TH
         PyLPYtV4td2wVXadpQpqhzKphZENWCQCkTEEBAhDYZ+Mh2/wC1KvNKot/WOP4MevZcls
         qPhzTJOBmJSO3G2yNHNaE9aIwdK6fkgI6dBu5b5BXlsE7BA/mKJq0ykY6/EfT5WrZKhl
         sSxUTFTiL9KDuX261rSEN1mCKq9e/+E3JUMsefVGbD2ygkYoX+As+MZjgV8MiJwkURpd
         NS359Zr0MxJzrTd8rTtbWulkHmcOuMV4Id2fjvEPq40Kw5JEpr+S1g+vmhOHQHhSjijO
         39TA==
X-Gm-Message-State: APjAAAXL7vQlDpwtk3g+xzQnY985aTZYgLMu+LPpF2XwdBWpPUPBR8lz
        U0ffBNpWCF469X3zfdnqCL7prpW2VSGTfZG/X2dh2Q==
X-Google-Smtp-Source: APXvYqzCqvqrSBU1rWllCKWD+rrWgnjsFL1Z8JVckf99ZQFnKjoteOyh2Q0WrbeKLoF2vcQWiBqU02kbE3KzlWeGN+9lSw==
X-Received: by 2002:a63:4c1c:: with SMTP id z28mr15423435pga.122.1561079986483;
 Thu, 20 Jun 2019 18:19:46 -0700 (PDT)
Date:   Thu, 20 Jun 2019 18:19:11 -0700
Message-Id: <20190621011941.186255-1-matthewgarrett@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.22.0.410.gd8fdbe21b5-goog
Subject: [PATCH V33 00/30] Lockdown as an LSM
From:   Matthew Garrett <matthewgarrett@google.com>
To:     jmorris@namei.org
Cc:     linux-security@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-api@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi James,

Let's see how this one goes. I've moved the lockdown code into an LSM
hook and provided an internal enum of lockdown reasons that LSMs can
either group or expose at whatever level of granularity is appropriate.
I've also included a static LSM that mimics the behaviour of the
existing patchset. I think there's a reasonable discussion to have about
what sort of granularity other LSMs might want to offer, but I don't
think that necessarily needs to be a blocker to merging this.

As with the last implementation, this can be enabled via static kernel
configuration, the kernel command line or via securityfs, depending on
usecase. Distributions may wish to tie it to UEFI Secure Boot state, but
we can save that conversation to later.

Thoughts?



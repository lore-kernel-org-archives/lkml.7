Return-Path: <SRS0=YpA9=XT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6115AC432C1
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Sep 2019 23:02:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2F5E0207FD
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Sep 2019 23:02:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="hKzkVvwR"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2411087AbfIXXCP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 24 Sep 2019 19:02:15 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:42653 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2410730AbfIXXCP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Sep 2019 19:02:15 -0400
Received: by mail-pg1-f195.google.com with SMTP id z12so2075287pgp.9
        for <linux-kernel@vger.kernel.org>; Tue, 24 Sep 2019 16:02:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=875aexvD7cUCg4vLDozHani2eFwWcaXl/i/C7NyBK9s=;
        b=hKzkVvwRGb4znyJN+vH3wu91+Ba0HRbUn/79qk0j4/Qc5P+f830chLC7pKfsie/kG/
         jGE6cuPi8mSCPtwYQuw6v1H1tHOfaaSx0YshnHQxAIL5Ohr7LPxY0xY/hmhQqICg6hBo
         pN2BU7ZrUdtJFDOfdOS3nkWJvNB1awluzkuYE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=875aexvD7cUCg4vLDozHani2eFwWcaXl/i/C7NyBK9s=;
        b=Vd/eKFVmCzc+DkCT5CTxk6ovT5bfUuJXqPZR7X402dfnTx+IxkAlNKSquFiKG5zDj3
         66aKOLNJK+p66WSKyWz8R+/e67tb6KEILJvz1nrPY5BFCZoFwVvwaFEz6+pnuMQF2BJ6
         sYKSglXlaQlrtccPNaAQVMSdRYrBVzqi6JPZ7EdnnBHKDjb6tNrXWZ0W2ocQcY9eZ19r
         i2fbM6R7gd+14LgpGaMEdUp2lMl2lXDkNmhpWAvpndPRsH80bo65QShjVZO6rQYz0626
         zX6K6vr7GKYbrutRXefcJvGDJBwXRoJODx+tUvYeUEk1ExMjE6Rz9i334HMpm4W6G8Sd
         jTVw==
X-Gm-Message-State: APjAAAVwLm9jVl+0qc0PQ3PGSWfW/ryTcPESi4cQY/M2IGxEw3+b+ssD
        vCh8cOt2AnbcUne72jEuU4WIww==
X-Google-Smtp-Source: APXvYqy77rLagnu3Wdk8EcVrrG/YEwpXEWLr/l86uQs5tIglvvkz7LtqXowdfJ8AIHNk3Or6OKo/HA==
X-Received: by 2002:a63:4566:: with SMTP id u38mr5426355pgk.448.1569366132160;
        Tue, 24 Sep 2019 16:02:12 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id q3sm3234073pgj.54.2019.09.24.16.02.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Sep 2019 16:02:10 -0700 (PDT)
From:   Kees Cook <keescook@chromium.org>
To:     Jonathan Corbet <corbet@lwn.net>
Cc:     Kees Cook <keescook@chromium.org>,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        Jani Nikula <jani.nikula@linux.intel.com>,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 0/2] docs: Programmatically render MAINTAINERS into ReST
Date:   Tue, 24 Sep 2019 16:02:06 -0700
Message-Id: <20190924230208.12414-1-keescook@chromium.org>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit log from Patch 2 repeated here for cover letter:

In order to have the MAINTAINERS file visible in the rendered ReST
output, this makes some small changes to the existing MAINTAINERS file
to allow for better machine processing, and adds a new Sphinx directive
"maintainers-include" to perform the rendering.

Features include:
- Per-subsystem reference links: subsystem maintainer entries can be
  trivially linked to both internally and external. For example:
  https://www.kernel.org/doc/html/latest/process/maintainers.html#secure-computing

- Internally referenced .rst files are linked so they can be followed
  when browsing the resulting rendering. This allows, for example, the
  future addition of maintainer profiles to be automatically linked.

- Field name expansion: instead of the short fields (e.g. "M", "F",
  "K"), use the indicated inline "full names" for the fields (which are
  marked with "*"s in MAINTAINERS) so that a rendered subsystem entry
  is more human readable. Email lists are additionally comma-separated.
  For example:

    SECURE COMPUTING
        Mail:     Kees Cook <keescook@chromium.org>
        Reviewer: Andy Lutomirski <luto@amacapital.net>,
                  Will Drewry <wad@chromium.org>
        SCM:      git git://git.kernel.org/pub/scm/linux/kernel/git/kees/linux.git seccomp
        Status:   Supported
        Files:    kernel/seccomp.c include/uapi/linux/seccomp.h
                  include/linux/seccomp.h tools/testing/selftests/seccomp/*
                  tools/testing/selftests/kselftest_harness.h
                  userspace-api/seccomp_filter
        Content regex:  \bsecure_computing \bTIF_SECCOMP\b

---
Kees Cook (2):
  doc-rst: Reduce CSS padding around Field
  doc-rst: Programmatically render MAINTAINERS into ReST

 Documentation/conf.py                         |   3 +-
 Documentation/process/index.rst               |   1 +
 Documentation/process/maintainers.rst         |   1 +
 .../sphinx-static/theme_overrides.css         |  10 +
 Documentation/sphinx/maintainers_include.py   | 194 ++++++++++++++++++
 MAINTAINERS                                   |  62 +++---
 6 files changed, 240 insertions(+), 31 deletions(-)
 create mode 100644 Documentation/process/maintainers.rst
 create mode 100755 Documentation/sphinx/maintainers_include.py

-- 
2.17.1


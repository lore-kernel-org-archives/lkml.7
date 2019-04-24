Return-Path: <SRS0=L2S5=S2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 18416C282CE
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 16:38:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CBFF0218B0
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 16:38:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="UOSnsuM7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732672AbfDXQiM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Apr 2019 12:38:12 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:37943 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732639AbfDXQiH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Apr 2019 12:38:07 -0400
Received: by mail-pg1-f195.google.com with SMTP id j26so9645268pgl.5
        for <linux-kernel@vger.kernel.org>; Wed, 24 Apr 2019 09:38:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=r/S1LhAqeQOBmkCpNjxYl/1Zvm5KV9actcRZTIkTSLw=;
        b=UOSnsuM7mNy+HX/4CvM9pdVLj6fJp9GTYGyXWyF2eqObvSiWLaC2VIg6NDlet6IQCl
         6aJA58O8chedSxf51sAZHD63RnP5FO+qhd+SIFBIA0cZNfLT5dfzr6OdMsQnDDO9dOd5
         G+QkKYWg889R602vk6SyUsVpXl+EToTTcTmhM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=r/S1LhAqeQOBmkCpNjxYl/1Zvm5KV9actcRZTIkTSLw=;
        b=HJJkJg1EbddbrbNPxjGlLQlltMjg8riA4sYSED0iZsjYkoWDSF8NrnCN0ZlXj/9x27
         flqZIrhveBfAgSiIBd2E7snTTyUIT3ex51BCQ5eawuG17FhZOsX+ZqAxUmr5m3NN2D5v
         pZommlwjRqtBtt60Gljrs2aYjxynnatQ4tUBjP0kqECAEfG0eGdG+UNsbbn055sgJY7c
         AtE1UBFNOnSqs++5fHDzFx8KqqbkV8cBPGShSFiNSaYf1U1VU1/cl2RZkxVfTNH7VGdF
         miOw8O9VE3et2EtKhFUZ6fne5bfiNpReLl0vLSTQFiqpKzak7Tu21mMTVgyj+RKZ8M+r
         3qWg==
X-Gm-Message-State: APjAAAVky39OrcaEBvQUotIbcVKVEN8vSffkdUwFq5ijJnDccUoio8HI
        GDDB66NY3HAoTexnRNP9SdLCIo6rY/s=
X-Google-Smtp-Source: APXvYqxsc7xy5bD6y8nu0RLXFkIzCBcIcsXjHfsCxI31Y29ZN2uYkroVm59OAGBKlkgJ1uri8jLQ3w==
X-Received: by 2002:a63:d1f:: with SMTP id c31mr30469736pgl.353.1556123887179;
        Wed, 24 Apr 2019 09:38:07 -0700 (PDT)
Received: from www.outflux.net (173-164-112-133-Oregon.hfc.comcastbusiness.net. [173.164.112.133])
        by smtp.gmail.com with ESMTPSA id k186sm34923306pfc.137.2019.04.24.09.38.04
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 24 Apr 2019 09:38:04 -0700 (PDT)
From:   Kees Cook <keescook@chromium.org>
To:     Tycho Andersen <tycho@tycho.ws>
Cc:     Kees Cook <keescook@chromium.org>,
        James Morris <jmorris@namei.org>,
        Andy Lutomirski <luto@amacapital.net>,
        Will Drewry <wad@chromium.org>,
        linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 0/2] seccomp: Make NEW_LISTENER and TSYNC flags exclusive
Date:   Wed, 24 Apr 2019 09:37:54 -0700
Message-Id: <20190424163756.40001-1-keescook@chromium.org>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is just sending out the tweaked fix from Tycho and the selftest
changes needed to support it. I intend to send this to Linus directly
after it's been in -next for a few days for v5.1 fixes.

Thanks!

-Kees

Kees Cook (1):
  selftests/seccomp: Prepare for exclusive seccomp flags

Tycho Andersen (1):
  seccomp: Make NEW_LISTENER and TSYNC flags exclusive

 kernel/seccomp.c                              | 17 ++++++++--
 tools/testing/selftests/seccomp/seccomp_bpf.c | 34 ++++++++++++++-----
 2 files changed, 40 insertions(+), 11 deletions(-)

-- 
2.17.1


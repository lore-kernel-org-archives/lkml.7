Return-Path: <SRS0=G/Om=ZT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT,USER_IN_DEF_DKIM_WL autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E6DD3C432C0
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Nov 2019 02:52:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BC761207DD
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Nov 2019 02:52:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="FwpBrdMx"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726858AbfK0CwT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Nov 2019 21:52:19 -0500
Received: from linux.microsoft.com ([13.77.154.182]:46224 "EHLO
        linux.microsoft.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725916AbfK0CwT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Nov 2019 21:52:19 -0500
Received: from nramas-ThinkStation-P520.corp.microsoft.com (unknown [131.107.174.108])
        by linux.microsoft.com (Postfix) with ESMTPSA id 1914F20B7185;
        Tue, 26 Nov 2019 18:52:18 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 1914F20B7185
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1574823138;
        bh=5NAfEhRtIEbYB3sZQhH1wdDrrAoygkICB/b+f2Pif8Y=;
        h=From:To:Cc:Subject:Date:From;
        b=FwpBrdMxjpmskLNKYPt2BHzMJ9kKsMp3v7k869peyKZgBYEX4Sl99gUang9A6gIMm
         mW380/LFnK6xkH6jLwLmMtd4vTUmxm/VBh7+h/Ha1lONigDNMPdWO99hEDCqwkon2j
         XN5Xjw7mlnR0vgukP3GZBaBB2Qk0IhAATbpk6wVs=
From:   Lakshmi Ramasubramanian <nramas@linux.microsoft.com>
To:     zohar@linux.ibm.com, linux-integrity@vger.kernel.org
Cc:     eric.snowberg@oracle.com, dhowells@redhat.com,
        matthewgarrett@google.com, sashal@kernel.org,
        jamorris@linux.microsoft.com, linux-kernel@vger.kernel.org,
        keyrings@vger.kernel.org
Subject: [PATCH v0 0/2] IMA: Deferred measurement of keys
Date:   Tue, 26 Nov 2019 18:52:10 -0800
Message-Id: <20191127025212.3077-1-nramas@linux.microsoft.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patchset extends the previous version[1] by adding support for
deferred processing of keys.

With the patchset referenced above, the IMA subsystem supports
measuring keys when the key is created or updated. But the keys
created or updated before IMA subsystem is initialized are not
handled. This includes keys added to, for instance,
.builtin_trusted_keys which happens very early in the boot process.

This change adds support for queuing keys when IMA is not ready
and process the keys (including queued keys) when IMA is initialized.

[1] https://lore.kernel.org/linux-integrity/20191127015654.3744-1-nramas@linux.microsoft.com/

Testing performed:

  * Booted the kernel with this change.
  * Added .builtin_trusted_keys in "keyrings=" option in
    the IMA policy and verified the keys added to this
    keyring are measured.
  * Specified only func=KEY_CHECK and not "keyrings=" option,
    and verified the keys added to builtin_trusted_keys keyring
    are processed.
  * Added keys at runtime and verified they are measured
    if the IMA policy permitted.
      => For example, added keys to .ima keyring and verified.

Changelog:

  v0

  => Based changes on v5.4-rc8
  => The following patchsets should be applied in that order
     https://lore.kernel.org/linux-integrity/1572492694-6520-1-git-send-email-zohar@linux.ibm.com
     https://lore.kernel.org/linux-integrity/20191127015654.3744-1-nramas@linux.microsoft.com/
  => Added functions to queue and dequeue keys, and process
     the queued keys when custom IMA policies are applied.

Lakshmi Ramasubramanian (2):
  IMA: Defined queue functions
  IMA: Call queue and dequeue functions to measure keys

 security/integrity/ima/ima.h                 |  15 ++
 security/integrity/ima/ima_asymmetric_keys.c | 151 ++++++++++++++++++-
 security/integrity/ima/ima_policy.c          |  12 ++
 3 files changed, 174 insertions(+), 4 deletions(-)

-- 
2.17.1


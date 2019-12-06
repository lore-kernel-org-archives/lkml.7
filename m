Return-Path: <SRS0=xBSd=Z4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT,USER_IN_DEF_DKIM_WL autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CDAEEC43603
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Dec 2019 01:29:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9514F2245C
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Dec 2019 01:29:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="Fc8OwaK3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726209AbfLFB3n (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 5 Dec 2019 20:29:43 -0500
Received: from linux.microsoft.com ([13.77.154.182]:47348 "EHLO
        linux.microsoft.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725959AbfLFB3m (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Dec 2019 20:29:42 -0500
Received: from nramas-ThinkStation-P520.corp.microsoft.com (unknown [131.107.174.108])
        by linux.microsoft.com (Postfix) with ESMTPSA id EE1F82010BBB;
        Thu,  5 Dec 2019 17:29:41 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com EE1F82010BBB
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1575595782;
        bh=KYKqmpyu2/KqQw/Kgh5Hw9D6cv4w2gT1WEMOUZ51dOU=;
        h=From:To:Cc:Subject:Date:From;
        b=Fc8OwaK3Uno1CtieRVB5j2+9/MR0KfBD4iqD6bdydfWV/06dTYbAc326ZmZNyCZ+P
         HcjAxnPxr5RQNMuaI4YZxAttMv+WHChxbziMLS4o6DCd1lWdAPCPIVmIZE2vvMv51m
         J1LE/HZBwRrty/aOxKrOlHHfaoALuSF+cPzqE+LM=
From:   Lakshmi Ramasubramanian <nramas@linux.microsoft.com>
To:     zohar@linux.ibm.com, linux-integrity@vger.kernel.org
Cc:     eric.snowberg@oracle.com, dhowells@redhat.com,
        mathew.j.martineau@linux.intel.com, matthewgarrett@google.com,
        sashal@kernel.org, jamorris@linux.microsoft.com,
        linux-kernel@vger.kernel.org, keyrings@vger.kernel.org
Subject: [PATCH v1 0/2] IMA: Deferred measurement of keys
Date:   Thu,  5 Dec 2019 17:29:34 -0800
Message-Id: <20191206012936.2814-1-nramas@linux.microsoft.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patchset extends the previous version[1] by adding support for
deferred processing of keys.

With the patchset referenced above, the IMA subsystem supports
measuring asymmetric keys when the key is created or updated.
But keys created or updated before a custom IMA policy is loaded
are currently not measured. This includes keys added to, for instance,
.builtin_trusted_keys which happens early in the boot process.

This change adds support for queuing keys created or updated before
a custom IMA policy is loaded. The queued keys are processed when
a custom policy is loaded. Keys created or updated after a custom policy
is loaded are measured immediately (not queued).

If the kernel is built with both CONFIG_IMA and
CONFIG_ASYMMETRIC_PUBLIC_KEY_SUBTYPE enabled then the IMA policy
must be applied as a custom policy. Not providing a custom policy
in the above configuration would result in asymmeteric keys being queued
until a custom policy is loaded. This is by design.

[1] https://lore.kernel.org/linux-integrity/20191204224131.3384-1-nramas@linux.microsoft.com/

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

  v1

  => Code cleanup

  v0

  => Based changes on v5.4-rc8
  => The following patchsets should be applied in that order
     https://lore.kernel.org/linux-integrity/1572492694-6520-1-git-send-email-zohar@linux.ibm.com
     https://lore.kernel.org/linux-integrity/20191204224131.3384-1-nramas@linux.microsoft.com/
  => Added functions to queue and dequeue keys, and process
     the queued keys when custom IMA policies are applied.

Lakshmi Ramasubramanian (2):
  IMA: Define workqueue for early boot "key" measurements
  IMA: Call workqueue functions to measure queued keys

 security/integrity/ima/ima.h                 |  15 +++
 security/integrity/ima/ima_asymmetric_keys.c | 134 +++++++++++++++++++
 security/integrity/ima/ima_policy.c          |   6 +
 3 files changed, 155 insertions(+)

-- 
2.17.1


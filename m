Return-Path: <SRS0=uyI7=RK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A5997C43381
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Mar 2019 15:58:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7964720652
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Mar 2019 15:58:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726626AbfCGP6s (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 Mar 2019 10:58:48 -0500
Received: from mx07-00178001.pphosted.com ([62.209.51.94]:5471 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726249AbfCGP6s (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Mar 2019 10:58:48 -0500
Received: from pps.filterd (m0046037.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x27FkSNF025831;
        Thu, 7 Mar 2019 16:58:42 +0100
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com with ESMTP id 2r315usxvn-1
        (version=TLSv1 cipher=ECDHE-RSA-AES256-SHA bits=256 verify=NOT);
        Thu, 07 Mar 2019 16:58:42 +0100
Received: from zeta.dmz-eu.st.com (zeta.dmz-eu.st.com [164.129.230.9])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id D1C4B31;
        Thu,  7 Mar 2019 15:58:40 +0000 (GMT)
Received: from Webmail-eu.st.com (Safex1hubcas24.st.com [10.75.90.94])
        by zeta.dmz-eu.st.com (STMicroelectronics) with ESMTP id B4345531C;
        Thu,  7 Mar 2019 15:58:40 +0000 (GMT)
Received: from SAFEX1HUBCAS23.st.com (10.75.90.47) by Safex1hubcas24.st.com
 (10.75.90.94) with Microsoft SMTP Server (TLS) id 14.3.361.1; Thu, 7 Mar 2019
 16:58:40 +0100
Received: from localhost (10.129.4.33) by webmail-ga.st.com (10.75.90.48) with
 Microsoft SMTP Server (TLS) id 14.3.361.1; Thu, 7 Mar 2019 16:58:40 +0100
From:   Fabien Dessenne <fabien.dessenne@st.com>
To:     Ohad Ben-Cohen <ohad@wizery.com>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Jonathan Corbet <corbet@lwn.net>,
        <linux-remoteproc@vger.kernel.org>, <linux-doc@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
CC:     Fabien Dessenne <fabien.dessenne@st.com>,
        Benjamin Gaignard <benjamin.gaignard@st.com>,
        Alexandre Torgue <alexandre.torgue@st.com>
Subject: [PATCH 1/2] hwspinlock: document the hwspinlock 'raw' API
Date:   Thu, 7 Mar 2019 16:58:22 +0100
Message-ID: <1551974303-24542-2-git-send-email-fabien.dessenne@st.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1551974303-24542-1-git-send-email-fabien.dessenne@st.com>
References: <1551974303-24542-1-git-send-email-fabien.dessenne@st.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.129.4.33]
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-03-07_08:,,
 signatures=0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Document the hwspin_lock_timeout_raw(), hwspin_trylock_raw() and
hwspin_unlock_raw() API.

Signed-off-by: Fabien Dessenne <fabien.dessenne@st.com>
---
 Documentation/hwspinlock.txt | 42 ++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 42 insertions(+)

diff --git a/Documentation/hwspinlock.txt b/Documentation/hwspinlock.txt
index ed640a2..c3403f9 100644
--- a/Documentation/hwspinlock.txt
+++ b/Documentation/hwspinlock.txt
@@ -136,6 +136,23 @@ The function will never sleep.
 
 ::
 
+  int hwspin_lock_timeout_raw(struct hwspinlock *hwlock, unsigned int timeout);
+
+Lock a previously-assigned hwspinlock with a timeout limit (specified in
+msecs). If the hwspinlock is already taken, the function will busy loop
+waiting for it to be released, but give up when the timeout elapses.
+
+Caution: User must protect the routine of getting hardware lock with mutex
+or spinlock to avoid dead-lock, that will let user can do some time-consuming
+or sleepable operations under the hardware lock.
+
+Returns 0 when successful and an appropriate error code otherwise (most
+notably -ETIMEDOUT if the hwspinlock is still busy after timeout msecs).
+
+The function will never sleep.
+
+::
+
   int hwspin_trylock(struct hwspinlock *hwlock);
 
 
@@ -186,6 +203,21 @@ The function will never sleep.
 
 ::
 
+  int hwspin_trylock_raw(struct hwspinlock *hwlock);
+
+Attempt to lock a previously-assigned hwspinlock, but immediately fail if
+it is already taken.
+
+Caution: User must protect the routine of getting hardware lock with mutex
+or spinlock to avoid dead-lock, that will let user can do some time-consuming
+or sleepable operations under the hardware lock.
+
+Returns 0 on success and an appropriate error code otherwise (most
+notably -EBUSY if the hwspinlock was already taken).
+The function will never sleep.
+
+::
+
   void hwspin_unlock(struct hwspinlock *hwlock);
 
 Unlock a previously-locked hwspinlock. Always succeed, and can be called
@@ -222,6 +254,16 @@ the given flags. This function will never sleep.
 
 ::
 
+  void hwspin_unlock_raw(struct hwspinlock *hwlock);
+
+Unlock a previously-locked hwspinlock.
+
+The caller should **never** unlock an hwspinlock which is already unlocked.
+Doing so is considered a bug (there is no protection against this).
+This function will never sleep.
+
+::
+
   int hwspin_lock_get_id(struct hwspinlock *hwlock);
 
 Retrieve id number of a given hwspinlock. This is needed when an
-- 
2.7.4


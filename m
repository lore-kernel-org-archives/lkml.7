Return-Path: <SRS0=7jSw=YF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C8F1EC4360C
	for <linux-kernel@archiver.kernel.org>; Sat, 12 Oct 2019 05:50:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 901FA21850
	for <linux-kernel@archiver.kernel.org>; Sat, 12 Oct 2019 05:50:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=colorfullife-com.20150623.gappssmtp.com header.i=@colorfullife-com.20150623.gappssmtp.com header.b="dn0m6L3t"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728473AbfJLFuL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 12 Oct 2019 01:50:11 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:35100 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728089AbfJLFuL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 12 Oct 2019 01:50:11 -0400
Received: by mail-wr1-f66.google.com with SMTP id v8so14007581wrt.2
        for <linux-kernel@vger.kernel.org>; Fri, 11 Oct 2019 22:50:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=colorfullife-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=4RVkmPk1zjHN7V2kqY3dY8wJO3urCzgFUHU3uX34ibw=;
        b=dn0m6L3tD5/Dwg21Q07nlkdbGSYvokPqdBHO+FcPcHJblDWLFVd6rn24gCnUvlT4Ds
         mD1mfCc9pbUSJjGaUUSp/Sq4icG+m+LFPe725gEb3DrqHpc4S4AzZ134/ukPG6FsrNud
         L98xN2+Eu6LjUHmaI+TQPcVXuNW1ijUNnT5bNO5pokS4lb+FAk3Xw7jIPO+71n3gIOXQ
         7QMiiF6Gd2tnhDvPDWd6CVvOqOQt3k7hdioI1CK3ybQzI4ZtnsJtuLr44Nv0MOI7/y5i
         5wxBNveg2nsVb9ou8tUA5EIb84uA4/xuhURZtZYPckTeuSAf/sFpW3X8xT27FkXxYhb/
         6rdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=4RVkmPk1zjHN7V2kqY3dY8wJO3urCzgFUHU3uX34ibw=;
        b=RAvP2CyWXw05/qDN+6jJvSNUFNIFnOFqaRI1Fg0+J8oBI51KCYBZiIH+s3VVAfLI/p
         +id11uTToFZ9LRfJKazVmAO8b+r/fsCfF0IgzNGbR8MjyraEZ3oPRJsoASyzAKYKEqd8
         TMP5qVoX4SvM8/W/2KxCTEG0yAmiGwx8sxoHaYs6T4vR7OlhoBx09d+5tdcSwfM49twS
         j9Ws/TkNxhXB0amDeJnxqgVmO1xA51wvrqFUPypXbCM0LX4tlKt/1qw2oy8yNJoe17yG
         Svv4L5tyIKWYJdbY7F5ainEa2svu85BZm5xRyzDFjVRQxpjz1SA7/6baxYWBM0CLJFKa
         SoLg==
X-Gm-Message-State: APjAAAWzr3kIFlDh8IVsuDKt864pUIqj8OvbrJCM2obuBkQa+7SEgLge
        6wMiaxTlOJbCHpbLnJHErhiNs9XkZLLsAQ==
X-Google-Smtp-Source: APXvYqyRD/VfuNPvDntC59R287sXmqD5kpNS+p3Wn8/pU00075e0FeN8UGjufnqS+M1eV9z17AUS0Q==
X-Received: by 2002:a5d:6408:: with SMTP id z8mr15647075wru.108.1570859408717;
        Fri, 11 Oct 2019 22:50:08 -0700 (PDT)
Received: from linux.fritz.box (p200300D9973AD600F159A589C745B52A.dip0.t-ipconnect.de. [2003:d9:973a:d600:f159:a589:c745:b52a])
        by smtp.googlemail.com with ESMTPSA id z4sm9344955wrh.93.2019.10.11.22.50.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Oct 2019 22:50:07 -0700 (PDT)
From:   Manfred Spraul <manfred@colorfullife.com>
To:     LKML <linux-kernel@vger.kernel.org>,
        Davidlohr Bueso <dave@stgolabs.net>,
        Waiman Long <longman@redhat.com>
Cc:     1vier1@web.de, Andrew Morton <akpm@linux-foundation.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Manfred Spraul <manfred@colorfullife.com>
Subject: [PATCH 0/6] V2: Clarify/standardize memory barriers for ipc
Date:   Sat, 12 Oct 2019 07:49:52 +0200
Message-Id: <20191012054958.3624-1-manfred@colorfullife.com>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Updated series, based on input from Davidlohr:

- Mixing WRITE_ONCE(), when not holding a lock, and "normal" writes,
  when holding a lock, makes the code less readable.
  Thus use _ONCE() everywhere, for both WRITE_ONCE() and READ_ONCE().

- According to my understanding, wake_q_add() does not contain a barrier
  that protects the refount increase. Document that, and add the barrier
  to the ipc code

- and, based on patch review: The V1 patch for ipc/sem.c is incorrect,
  ->state must be set to "-EINTR", not EINTR.

From V1:

The memory barriers in ipc are not properly documented, and at least
for some architectures insufficient:
Reading the xyz->status is only a control barrier, thus
smp_acquire__after_ctrl_dep() was missing in mqueue.c and msg.c
sem.c contained a full smp_mb(), which is not required.

Patches:
Patch 1: Document the barrier rules for wake_q_add().

Patch 2: remove code duplication
@Davidlohr: There is no "Signed-off-by" in your mail, otherwise I would
list you as author.

Patch 3-5: Update the ipc code, especially add missing
           smp_mb__after_ctrl_dep().

Clarify that smp_mb__{before,after}_atomic() are compatible with all
RMW atomic operations, not just the operations that do not return a value.

Patch 6: Documentation for smp_mb__{before,after}_atomic().

Open issues:
- Is my analysis regarding the refcount correct?

- Review other users of wake_q_add().

- More testing. I did some tests, but doubt that the tests would be
  sufficient to show issues with regards to incorrect memory barriers.

- Should I add a "Fixes:" or "Cc:stable"? The issues that I see are
  the missing smp_mb__after_ctrl_dep(), and WRITE_ONCE() vs.
  "ptr = NULL", and a risk regarding the refcount that I can't evaluate.


What do you think?

--
	Manfred

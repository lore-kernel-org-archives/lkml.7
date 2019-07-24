Return-Path: <SRS0=3iFO=VV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 670A1C76186
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jul 2019 22:54:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 237E52190F
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jul 2019 22:54:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KFuMDgJj"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729639AbfGXWy6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Jul 2019 18:54:58 -0400
Received: from mail-pf1-f195.google.com ([209.85.210.195]:41794 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726178AbfGXWy5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Jul 2019 18:54:57 -0400
Received: by mail-pf1-f195.google.com with SMTP id m30so21666400pff.8
        for <linux-kernel@vger.kernel.org>; Wed, 24 Jul 2019 15:54:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=LMV3mZpI4uZO3eufaBXx4tYIVpWw0HCRWZPE7psY0dM=;
        b=KFuMDgJjMMAgX+sCp1zMLuxx3cfvRPxOJZUOAFQteB767xLPCaMunY7VDuBYdQEhk8
         RI2sTVVXV6m4A+NeINpcUNzDFdahUf+KGxPwnvkSKapuHml0re/CbF88y4cGmtatL873
         ZJNk4pN0sfdQTR47G2OJkpy2VhqattBfsIcI2gj2jMP9s1VhUvoKZ+/ICLj/yzK5eZ21
         +70tiuIo2cTzm6GSafSG7xjXgb9G5fDpyf327TrD2mPvPh2nIqjkco6OF24Z/T6s9f7G
         H5tHgKi/6ki7HmdH5r2uMiRrRfj/aqPPFKKXrE+Vt5lSfRK3n6QtlvAfGKlty6GQAvAP
         RnBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=LMV3mZpI4uZO3eufaBXx4tYIVpWw0HCRWZPE7psY0dM=;
        b=QIIUX1m1u/vSRnwg/itcm8XcqhJg6HXx9vHiL2SXPYRmxSEpoKVBpJ9X031kArjyfs
         sk1do0jLFUr3YEuoQX5dfLfm0k8saHTleJfsToXqZeRiAwTqKMMsplxO3md1LDApbLnQ
         3hnxtLMI3Kpgo+HMSrgpYujnmMp7poR8kf9dTr53Czx3fmhtrv9pN5PoQp6wR37UKIR9
         tfZA0eore5666mqPBsR5qMOyK6GWTuKHD+K6Xa1Os02pgk360ZhtbD60ZCGMDeS2mCIm
         3OOONQjMsyG/ZDAIRAdXr6IKcjfVuea2NnAGYG/dRC7vx9wJYpttLzwQiBfyz3xwhbPi
         tB5A==
X-Gm-Message-State: APjAAAW+7rF+VKPiSiqdW88Nx7EH5Jd+H5ZoDmPB8ppvB4bDeqlvcQMa
        TmeiFBZmk8a4gRE0PjSS4Ko=
X-Google-Smtp-Source: APXvYqxGU0ESw4AJH7px3+Qj/psivUUtl53abXXzjZ7Rx56DwXnNSLw1Bji+/vY9dhMpyIUZ3xQZ7A==
X-Received: by 2002:a65:4c4d:: with SMTP id l13mr42496611pgr.156.1564008896845;
        Wed, 24 Jul 2019 15:54:56 -0700 (PDT)
Received: from blueforge.nvidia.com (searspoint.nvidia.com. [216.228.112.21])
        by smtp.gmail.com with ESMTPSA id d14sm59526525pfo.154.2019.07.24.15.54.55
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Wed, 24 Jul 2019 15:54:56 -0700 (PDT)
From:   john.hubbard@gmail.com
X-Google-Original-From: jhubbard@nvidia.com
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Ingo Molnar <mingo@redhat.com>, Will Deacon <will@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        John Hubbard <jhubbard@nvidia.com>
Subject: [PATCH 0/1] lockdep: fix an unused variable warning
Date:   Wed, 24 Jul 2019 15:54:51 -0700
Message-Id: <20190724225452.24503-1-jhubbard@nvidia.com>
X-Mailer: git-send-email 2.22.0
MIME-Version: 1.0
X-NVConfidentiality: public
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: John Hubbard <jhubbard@nvidia.com>

Hi,

I just ran into this while building other things against today's linux.git.

For the !CONFIG_PROVE_LOCKING case, the "class" variable is left unused.
Rather than tease apart the functionality in lockdep_stats_show(), where
class is used to increment up to 15 local variables, this patch merely
adds yet another ifdef to fix the build warning.

I'll leave it to a larger cleanup effort (which is probably not
worth the churn, actually) to avoid all of the ifdef slicing up
of these routines.

John Hubbard (1):
  lockdep: fix an unused variable warning

 kernel/locking/lockdep_proc.c | 2 ++
 1 file changed, 2 insertions(+)

-- 
2.22.0


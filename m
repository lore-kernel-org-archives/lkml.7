Return-Path: <SRS0=nVcb=SO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C2117C10F14
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Apr 2019 10:27:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9198220850
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Apr 2019 10:27:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="m1LT+h/H"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727300AbfDLK14 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 12 Apr 2019 06:27:56 -0400
Received: from mail-ot1-f67.google.com ([209.85.210.67]:46644 "EHLO
        mail-ot1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726697AbfDLK14 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Apr 2019 06:27:56 -0400
Received: by mail-ot1-f67.google.com with SMTP id s24so7898886otk.13
        for <linux-kernel@vger.kernel.org>; Fri, 12 Apr 2019 03:27:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=ak0sXwHrqDU6b08LnOyUh/QXVY4o/qkE5aK7erGO0HQ=;
        b=m1LT+h/HJjFW/2By8A45j9Lp2DjMWa6fB207dicHx8bGapA7JDGSs4nb8HIjEhKYDr
         cuUmcTyMx7HiEU+KSAOO/BzzJNc9zvTaOio9fgf09IpU150NWri8qdfImF3kwTJaFN8M
         EHPoeOtvG/DolFmXn4TvLWq7/dHfutvsL1P7PvO21EgPovQyJJE/KDFqN903S1UZxEwu
         cx3rFhXM9A6HwLi5Q2/KuudR9Of9tUzoGpOPmhsYOexXQqFnTLElN0p6QXBqE0Xsnm3q
         +JrsPWh39ah1vCThUfH0zE67O6FeLmdQKf0DJ+y2Ob9IyPltF4A7DolO+AXSsVYXGkPF
         WdoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=ak0sXwHrqDU6b08LnOyUh/QXVY4o/qkE5aK7erGO0HQ=;
        b=HcQm8c5zJ+23zwmO+eFqWk16ZPhgt4UP1r2BH2tenEgMt5Feoq/zfNTaoOUTySUCHO
         SSEf2nAccBE8WVCDfjUwp2Pjdxb6K1/VIz45FgoHdIosLI//vKgm6tU1uLoRCnIz4J91
         AAVXyqpUc3Kgl2BQc5HdUqWevC/iUsNStIc0Ok+5tHEGuuXZpXQp+0cenV8en0bM6yQZ
         T4A/M0nNVciM5Ol8nwwSx/lpcJ1Icxx0mX7EHnXgqnVbAMRgIuignJNBimNtY9os11si
         XaWwnIdqfOEgAdyruddmc+0YsnZl6W+iWJ7QCAh6/ZzC/5aLZrbKcXYl8eRTzN2JH55J
         acUA==
X-Gm-Message-State: APjAAAWgq302YunSmOgUWji7cLdituUTYBmErSWTtKHzRFKudo//a/vy
        5x1rUK3HLFgUnkG9Mg+uRLYSCw==
X-Google-Smtp-Source: APXvYqwvT9XGDxe/h02vLl5VGNg7LugajFUZ+DPSrGwAcsMh7t5yusNAzJyOXFBFpHmiQXQvWWvOjA==
X-Received: by 2002:a05:6830:2113:: with SMTP id i19mr37069404otc.33.1555064875278;
        Fri, 12 Apr 2019 03:27:55 -0700 (PDT)
Received: from localhost.localdomain (li808-42.members.linode.com. [104.237.132.42])
        by smtp.gmail.com with ESMTPSA id 88sm17530692otj.3.2019.04.12.03.27.51
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 12 Apr 2019 03:27:54 -0700 (PDT)
From:   Leo Yan <leo.yan@linaro.org>
To:     Mathieu Poirier <mathieu.poirier@linaro.org>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Leo Yan <leo.yan@linaro.org>
Subject: [PATCH v5 0/4] CoreSight: Support static funnel with DT binding consolidation
Date:   Fri, 12 Apr 2019 18:27:34 +0800
Message-Id: <20190412102738.12679-1-leo.yan@linaro.org>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Since before there have no platforms use static funnel in mainline
kernel (though maybe some in-house SoC has used it but didn't upstream
for mainline kernel yet so we don't be aware for it), when enable
CoreSight DT binding for hikey960, we found the SoC uses the static
funnel in the link path and but it's not supported in CoreSight funnel
driver.

When support static funnel it's found the DT binding compatible string
doesn't follow the same fashion between replicator and funnel; so the
first two patches are firstly to refine the replicator DT binding and
correspondingly, change the replicator driver to support new DT binding
compatible.

Patch 0003 is to update DT documentation to support static funnel (we
call it as non-configurable funnel in documentation) and unify the
compatible string with the same fashion for replicator and funnel.

Patch 0004 is to support the static funnel in the CoreSight funnel
driver.

The consolidated DT binding compatible strings are as below:

  Dynamic replicator:
    "arm,coresight-dynamic-replicator", "arm,primecell";

  Static replicator:
    "arm,coresight-static-replicator";
    "arm,coresight-replicator"; (obsolete)

  Static funnel:
    "arm,coresight-static-funnel";

  Dynamic funnel:
    "arm,coresight-dynamic-funnel", "arm,primecell";
    "arm,coresight-funnel", "arm,primecell"; (obsolete)

This patch set has been rebased on CoreSight next branch [1] with
latest commit d5d246a56af0 ("coresight: Merge the static and dynamic
replicator drivers") and tested on Hikey960/Hikey with perf commands:

  Hikey960:

  # perf record -e cs_etm/@ec033000.etr/ --per-thread ./main
  # perf report --tui

  Hikey:

  # perf record -e cs_etm/@f6404000.etr/ --per-thread uname
  # perf report --tui

[1] https://git.linaro.org/kernel/coresight.git/log/?h=next

== Changes for v5 ==
* Marked the the obsolete compatible strings to be more abvious
  (Suzuki).
* Used pr_warn_once() to print out warning if DT binding uses
  the  obsolete compatible string (Suzuki).

== Changes for v4 ==
* Consolidate the DT binding compatible strings for replicator and
  funnel (Mathieu).
* Changed replicator driver to support new compatible string.


Leo Yan (4):
  dt-bindings: arm: coresight: Add new compatible for static replicator
  coresight: replicator: Add new device id for static replicator
  dt-bindings: arm: coresight: Unify funnel DT binding
  coresight: funnel: Support static funnel

 .../devicetree/bindings/arm/coresight.txt     |  60 +++++++--
 .../hwtracing/coresight/coresight-funnel.c    | 116 ++++++++++++++----
 .../coresight/coresight-replicator.c          |   6 +-
 3 files changed, 147 insertions(+), 35 deletions(-)

-- 
2.17.1


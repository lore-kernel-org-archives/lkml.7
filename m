Return-Path: <SRS0=Ybdz=SI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EF968C10F06
	for <linux-kernel@archiver.kernel.org>; Sat,  6 Apr 2019 11:22:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BBB2E2087F
	for <linux-kernel@archiver.kernel.org>; Sat,  6 Apr 2019 11:22:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="fbRbu2iw"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726475AbfDFLWQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 6 Apr 2019 07:22:16 -0400
Received: from mail-yw1-f67.google.com ([209.85.161.67]:44622 "EHLO
        mail-yw1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726036AbfDFLWQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 6 Apr 2019 07:22:16 -0400
Received: by mail-yw1-f67.google.com with SMTP id c4so3254331ywa.11
        for <linux-kernel@vger.kernel.org>; Sat, 06 Apr 2019 04:22:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=zK7fvSVQMj/07ORfWmLuBaritLRIGJovrhUIsFGapPk=;
        b=fbRbu2iwKv+K20JLz22HqAZm14hdsYGYK7Lc5WVsAaxtynFF8PO7AqqBSfh2siPEOt
         ZjdOuJbawPSSHXEQvK5ifO67gecMAcAVTipRaLyNAVkPikpJ6zEJSDhieOwyi3uZRQIa
         AXcNE+jT+9RZzJnbRAYJT1gbXNVhyr0Ql82wFN2FshBZGHaUV8vplP2RY95x8I5eAGBr
         9R1Cbuol1cKXrLrjsp2Izc1f0d/q2493hsv8/OvLZy0bTkLTjnpX3HDYY2orE/MXB5w8
         VTX6X1sWA7eVHzjexjqjm5vrTvUb5QZ0w6sDRorOzkXWe0MwF6YR/Nqp2gVtIhnyLAuE
         pYDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=zK7fvSVQMj/07ORfWmLuBaritLRIGJovrhUIsFGapPk=;
        b=gwdkv1/nB38S1Xc/J18O9i3rx1Ri9j3eC9DgbEqRG2aU6t8+oitSHE3/06KeLbwwhg
         iThJP30p85XEkrMQdTyKjaD3KatxhjVjYXpXzMNhk4Yr8iHuP4bXZhMLaAJrXjVoVygx
         KZlEsBRKvO9FUAv4C8TIGOuFFuDUjftb6tEFDYnxBotUsG3u1OjxLQvuFf2tbcS10Syi
         XtUJg3rR/ofcDGSGj1NeT4EYVyj8iGNRTnZXtjw085LakOYhddS+q7QSd/uPghv6C3XW
         P6+oBmO4ZgS0WncpDo6pk3iLDtarc4s2scXar2SrbliKro90P3433FQEqybxEZ0uskUt
         s2xg==
X-Gm-Message-State: APjAAAWqni8nBx/OMAB/89p4n2JZkofJ0jyv+YmjmmNDbR18J4KftrQP
        fclyAWdCafrFoHtg4lc7qRu3OQ==
X-Google-Smtp-Source: APXvYqxKmV6zZtWJrNWP0dJ872MM50J+UCx4TxD1Y+z48T758pZiEkxAPSPeteswZxPfuSo0OFEh2A==
X-Received: by 2002:a81:3611:: with SMTP id d17mr14945559ywa.344.1554549735546;
        Sat, 06 Apr 2019 04:22:15 -0700 (PDT)
Received: from localhost.localdomain (li931-65.members.linode.com. [45.56.113.65])
        by smtp.gmail.com with ESMTPSA id w22sm12729360yww.58.2019.04.06.04.22.09
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 06 Apr 2019 04:22:14 -0700 (PDT)
From:   Leo Yan <leo.yan@linaro.org>
To:     Mathieu Poirier <mathieu.poirier@linaro.org>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Wanglai Shi <shiwanglai@hisilicon.com>,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Leo Yan <leo.yan@linaro.org>
Subject: [PATCH v4 0/4] CoreSight: Support static funnel with DT binding consolidation
Date:   Sat,  6 Apr 2019 19:21:41 +0800
Message-Id: <20190406112145.15184-1-leo.yan@linaro.org>
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

This patch set has been rebased on CoreSight next branch [1] with
latest commit d5d246a56af0 ("coresight: Merge the static and dynamic
replicator drivers") and tested on Hikey960/Hikey with perf commands:

  Hikey960:

  # perf record -e cs_etm/@ec033000.etr/ --per-thread ./main
  # perf report --tui

  Hikey:
  # perf record -e cs_etm/@f6404000.etr/ --per-thread uname
  # perf report --tui

P.s. in this version, Hikey960 CoreSight DT binding has not been
included and will be sent out separately.

[1] https://git.linaro.org/kernel/coresight.git/log/?h=next

== Changes for v4 ==
* Consolidate the DT binding compatible strings for replicator and
  funnel (Mathieu).
* Changed replicator driver to support new compatible string.


Leo Yan (4):
  dt-bindings: arm: coresight: Add new compatible for static replicator
  coresight: replicator: Add new device id for static replicator
  dt-bindings: arm: coresight: Unify funnel DT binding
  coresight: funnel: Support static funnel

 .../devicetree/bindings/arm/coresight.txt     |  60 +++++++++-
 .../hwtracing/coresight/coresight-funnel.c    | 112 +++++++++++++-----
 .../coresight/coresight-replicator.c          |   3 +-
 3 files changed, 141 insertions(+), 34 deletions(-)

-- 
2.17.1


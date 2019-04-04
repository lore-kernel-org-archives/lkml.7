Return-Path: <SRS0=oHH8=SG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 94CBDC4360F
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Apr 2019 23:25:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5DC7920882
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Apr 2019 23:25:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="I51mJ5YW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730063AbfDDXZv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Apr 2019 19:25:51 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:38912 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728211AbfDDXZu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Apr 2019 19:25:50 -0400
Received: by mail-pf1-f193.google.com with SMTP id i17so2163238pfo.6
        for <linux-kernel@vger.kernel.org>; Thu, 04 Apr 2019 16:25:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=7iuw9YQln7/aZQqkPLTkR36Rx2X+o2a4yMhfJDEGRf8=;
        b=I51mJ5YWVh5eTISPIxaEcpJgjTp/BnaYezPVGNBFzWoq2d9pEvQPooL0W66G00LpZn
         5KPPpsM1oL3A90xuhKnbk+GvV6TYl4mbCznx1v50f/Bzr13rkve3hHtbn0cY3DIy2CZ1
         n7/JkhSCNqX53fFTOouoaXFtD1sZVDF4kM+PcdYFuXngAv6vZxnpvjYOH/pwrHcKRrcO
         iuq1eRNgn+oBBfsCWiMWwG57f4jr94lh6xbOQmUlMjGekYEiQUXPqocE3y4Lc45gZIxx
         J5lNqdz+RX7aYAQVLn09/JLPOyK75Fzs6NMa49l7w4ZDnRqVd0w3rEb+dj9vt0+OgGIY
         iAuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=7iuw9YQln7/aZQqkPLTkR36Rx2X+o2a4yMhfJDEGRf8=;
        b=YjBf8g+caZKObrY+TFzwbdn+BZu0av7uikEg9uj+ki97xqWCBU197shd8Z6sRdOm2Z
         W3x3z4ENMV5qnFIJkS99RO31M4gYlf5hYq0qyQCCMTsXyPMQLvf31O+j0HlwKAAL/7Qe
         hbWuC9BMyCYlAt7+TYGmyUGl+ohvIvtIFtqJgPj5EeKZXIG907WkvukGkLXB5Ts1EOOo
         EWGSiC9ruO3fcL7ortvpzykPgTXSaYGaeRn7/BFaLXaADNx92B80dAswOGIDdOOhwjsa
         1TFmn4uPMgErYLJyQLBN0UenyitO3Iy3mfjHisX9Wt8jjzrnfCN+zI7N/1hTi2V5LeuS
         K7Rw==
X-Gm-Message-State: APjAAAXw9Ka9ii18yAnNMv8sHfrSDQ9bDTFVTjZ2Rpu0c/Xa2uyUiGr4
        sqyyKx2Ik4dkyKuiVR3dkPk=
X-Google-Smtp-Source: APXvYqxHuwHhTWBlCEJlWstPBdZzOzBX/h1GWfHQuTiLT53IiVi6gzym3rg8frLbDJo9NRjLs9HiXw==
X-Received: by 2002:a62:3892:: with SMTP id f140mr8818387pfa.128.1554420349312;
        Thu, 04 Apr 2019 16:25:49 -0700 (PDT)
Received: from fainelli-desktop.igp.broadcom.net ([192.19.223.250])
        by smtp.gmail.com with ESMTPSA id e23sm28750036pfd.11.2019.04.04.16.25.47
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 04 Apr 2019 16:25:48 -0700 (PDT)
From:   Florian Fainelli <f.fainelli@gmail.com>
To:     linux-arm-kernel@lists.infradead.org
Cc:     Florian Fainelli <f.fainelli@gmail.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Will Deacon <will.deacon@arm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        linux-kernel@vger.kernel.org (open list:PERFORMANCE EVENTS SUBSYSTEM)
Subject: [PATCH 0/2] arm64: perf: Expose Cortex-A53 micro architectural events
Date:   Thu,  4 Apr 2019 16:25:43 -0700
Message-Id: <20190404232545.2627-1-f.fainelli@gmail.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,

This patch series adds support for the Cortex-A53 micro architectural
events that I recently had to use for some debugging exercise.

Events from 0xC0 - 0xD2 are exposed, others could easily be added later
if we wanted to.

Thanks!

Florian Fainelli (2):
  arm64: perf: Group common ARMv8 v3 PMU events in a macro
  arm64: perf: Expose Cortex-A53 micro architectural events

 arch/arm64/kernel/perf_event.c | 241 ++++++++++++++++++++++++---------
 1 file changed, 179 insertions(+), 62 deletions(-)

-- 
2.17.1


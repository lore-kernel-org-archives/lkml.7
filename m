Return-Path: <SRS0=S2At=YJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B80B8FA3728
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Oct 2019 10:48:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 99F9B2168B
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Oct 2019 10:48:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404658AbfJPKsJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 16 Oct 2019 06:48:09 -0400
Received: from cloudserver094114.home.pl ([79.96.170.134]:46265 "EHLO
        cloudserver094114.home.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388377AbfJPKsG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Oct 2019 06:48:06 -0400
Received: from 79.184.255.51.ipv4.supernova.orange.pl (79.184.255.51) (HELO kreacher.localnet)
 by serwer1319399.home.pl (79.96.170.134) with SMTP (IdeaSmtpServer 0.83.292)
 id 55930553095aead4; Wed, 16 Oct 2019 12:48:04 +0200
From:   "Rafael J. Wysocki" <rjw@rjwysocki.net>
To:     Linux PM <linux-pm@vger.kernel.org>
Cc:     Linux ACPI <linux-acpi@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Dmitry Osipenko <digetx@gmail.com>
Subject: [RFT][PATCH 0/3] cpufreq / PM: QoS: Introduce frequency QoS and use it in cpufreq
Date:   Wed, 16 Oct 2019 12:37:58 +0200
Message-ID: <2811202.iOFZ6YHztY@kreacher>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi All,

The motivation for this series is to address the problem discussed here:

https://lore.kernel.org/linux-pm/5ad2624194baa2f53acc1f1e627eb7684c577a19.1562210705.git.viresh.kumar@linaro.org/T/#md2d89e95906b8c91c15f582146173dce2e86e99f

and also reported here:

https://lore.kernel.org/linux-pm/20191015155735.GA29105@bogus/

Plus, generally speaking, using the policy CPU as a proxy for the policy
with respect to PM QoS does not feel particularly straightforward to me
and adds extra complexity.

Anyway, the first patch adds frequency QoS that is based on "raw" PM QoS (kind
of in analogy with device PM QoS) and is just about min and max frequency
requests (no direct relationship to devices).

The second patch switches over cpufreq and its users to the new frequency QoS.
[The Fixes: tag has been tentatively added to it.]

The third one removes frequency request types from device PM QoS.

Unfortunately, the patches are rather big, but also they are quite
straightforward.

I didn't have the time to test this series, so giving it a go would be much
appreciated.

Thanks,
Rafael




Return-Path: <SRS0=S2At=YJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DECE9FA3728
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Oct 2019 22:06:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B66DD20650
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Oct 2019 22:06:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1571263564;
	bh=jphSXo0H1nebo1iEBpk4uSYr10SEphXsBJeMQa/Sj7Y=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=qJQ4JWUC+EwXisYrYjSbHNPpl5Iu/Yt/drCuIa3gclmMCuJghdkJigO8fjlW63tRQ
	 7k/h5S3Nb4qTTXgQFP0dksJbAyGhYOsDNrHuNEQujQ6KVcovLsv0skJy6WZDly/7z7
	 tVAKjoJ5e8RV/OvriFX3XX3uJ+cb75q2mfPXa4dQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2438212AbfJPV6i (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 16 Oct 2019 17:58:38 -0400
Received: from mail.kernel.org ([198.145.29.99]:50816 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2395540AbfJPV5u (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Oct 2019 17:57:50 -0400
Received: from localhost (unknown [192.55.54.58])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 24C7821928;
        Wed, 16 Oct 2019 21:57:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1571263070;
        bh=jphSXo0H1nebo1iEBpk4uSYr10SEphXsBJeMQa/Sj7Y=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=X3sqMyLXMEsxH0/HYrJODRXuU0tTuQn6e2DTcH62XUmKGlV1oCBJynFkG98W5zwuj
         NsbiIaC62ArILMWeAeNN/u6yMbtn8ADE3rQoCqtoEhQChDW2ryVjZoAEEzfIGg6JHK
         ZZ3VC1iqOjNU8p46r9H5yEcncj8p/mMxD42FAFTY=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Jeremy Linton <jeremy.linton@arm.com>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Robert Richter <rrichter@marvell.com>,
        Will Deacon <will@kernel.org>,
        John Garry <john.garry@huawei.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.19 70/81] arm64: topology: Use PPTT to determine if PE is a thread
Date:   Wed, 16 Oct 2019 14:51:21 -0700
Message-Id: <20191016214846.320148933@linuxfoundation.org>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20191016214805.727399379@linuxfoundation.org>
References: <20191016214805.727399379@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jeremy Linton <jeremy.linton@arm.com>

Commit 98dc19902a0b2e5348e43d6a2c39a0a7d0fc639e upstream.

ACPI 6.3 adds a thread flag to represent if a CPU/PE is
actually a thread. Given that the MPIDR_MT bit may not
represent this information consistently on homogeneous machines
we should prefer the PPTT flag if its available.

Signed-off-by: Jeremy Linton <jeremy.linton@arm.com>
Reviewed-by: Sudeep Holla <sudeep.holla@arm.com>
Reviewed-by: Robert Richter <rrichter@marvell.com>
[will: made acpi_cpu_is_threaded() return 'bool']
Signed-off-by: Will Deacon <will@kernel.org>
Signed-off-by: John Garry <john.garry@huawei.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/arm64/kernel/topology.c | 19 +++++++++++++++----
 1 file changed, 15 insertions(+), 4 deletions(-)

diff --git a/arch/arm64/kernel/topology.c b/arch/arm64/kernel/topology.c
index 0825c4a856e33..6106c49f84bc8 100644
--- a/arch/arm64/kernel/topology.c
+++ b/arch/arm64/kernel/topology.c
@@ -340,17 +340,28 @@ void remove_cpu_topology(unsigned int cpu)
 }
 
 #ifdef CONFIG_ACPI
+static bool __init acpi_cpu_is_threaded(int cpu)
+{
+	int is_threaded = acpi_pptt_cpu_is_thread(cpu);
+
+	/*
+	 * if the PPTT doesn't have thread information, assume a homogeneous
+	 * machine and return the current CPU's thread state.
+	 */
+	if (is_threaded < 0)
+		is_threaded = read_cpuid_mpidr() & MPIDR_MT_BITMASK;
+
+	return !!is_threaded;
+}
+
 /*
  * Propagate the topology information of the processor_topology_node tree to the
  * cpu_topology array.
  */
 static int __init parse_acpi_topology(void)
 {
-	bool is_threaded;
 	int cpu, topology_id;
 
-	is_threaded = read_cpuid_mpidr() & MPIDR_MT_BITMASK;
-
 	for_each_possible_cpu(cpu) {
 		int i, cache_id;
 
@@ -358,7 +369,7 @@ static int __init parse_acpi_topology(void)
 		if (topology_id < 0)
 			return topology_id;
 
-		if (is_threaded) {
+		if (acpi_cpu_is_threaded(cpu)) {
 			cpu_topology[cpu].thread_id = topology_id;
 			topology_id = find_acpi_cpu_topology(cpu, 1);
 			cpu_topology[cpu].core_id   = topology_id;
-- 
2.20.1




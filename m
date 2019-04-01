Return-Path: <SRS0=/BGd=SD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D2AC4C43381
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Apr 2019 17:09:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9FE7E21939
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Apr 2019 17:09:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1554138571;
	bh=53zGgi1ILFiW6vvRVzFjf/VVR+zGQ2I+AQZQcO07nx0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=BefBPtKAclMs/1SCjjsugRoHCsHOrE8AuqbAa9gQqg8gdGIKC1Evqh9KUnxr0lSj2
	 6W/Hc/dbA2NPgxqVOMDhWJNHnUua298v5rKNTmu4LwjCmrCfuBO58kfaEc1l+igW1J
	 rn7J7Ajr7nEMVJv0NuYPkFKBS+JAiyj7BaeC/d7Q=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729797AbfDARJa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Apr 2019 13:09:30 -0400
Received: from mail.kernel.org ([198.145.29.99]:56472 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729181AbfDARJ3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Apr 2019 13:09:29 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id CB277206B8;
        Mon,  1 Apr 2019 17:09:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1554138568;
        bh=53zGgi1ILFiW6vvRVzFjf/VVR+zGQ2I+AQZQcO07nx0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=tE+NVSwdj2wXM5Buia54rWZg+uyRCjb85MMaIilYNCNIYp22E6SYmRLl7fYrvDx/g
         nZWcZIhPdERozKoWNYdmyC5Vp0TFVHCgFOF6d1nHnNyQje1ECtCuzLDyZSQ4tvMEYk
         5ONul2pRqJCSb0Mh3sCX2/VmkEsTMQ5O8tu25ydg=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Subject: [PATCH 5.0 104/146] cpufreq: intel_pstate: Also use CPPC nominal_perf for base_frequency
Date:   Mon,  1 Apr 2019 19:01:56 +0200
Message-Id: <20190401170057.447743455@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190401170048.449559024@linuxfoundation.org>
References: <20190401170048.449559024@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

5.0-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>

commit 92a3e426ec06e72b1c363179c79d30712447ff76 upstream.

The ACPI specification states that if the "Guaranteed Performance
Register" is not implemented, the OSPM assumes guaranteed performance
to always be equal to nominal performance.

So for invalid or unimplemented guaranteed performance register, use
nominal performance as guaranteed performance.

This change will fall back to nominal_perf when guranteed_perf is
invalid.  If nominal_perf is also invalid or not present, fall back
to the existing implementation, which is to read from HWP Capabilities
MSR.

Fixes: 86d333a8cc7f ("cpufreq: intel_pstate: Add base_frequency attribute")
Suggested-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
Signed-off-by: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Cc: 4.20+ <stable@vger.kernel.org> # 4.20+
Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/cpufreq/intel_pstate.c |    5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

--- a/drivers/cpufreq/intel_pstate.c
+++ b/drivers/cpufreq/intel_pstate.c
@@ -383,7 +383,10 @@ static int intel_pstate_get_cppc_gurante
 	if (ret)
 		return ret;
 
-	return cppc_perf.guaranteed_perf;
+	if (cppc_perf.guaranteed_perf)
+		return cppc_perf.guaranteed_perf;
+
+	return cppc_perf.nominal_perf;
 }
 
 #else /* CONFIG_ACPI_CPPC_LIB */



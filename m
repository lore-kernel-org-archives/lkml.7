Return-Path: <SRS0=G/Om=ZT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 37764C432C0
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Nov 2019 20:45:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0E898217C3
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Nov 2019 20:45:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1574887558;
	bh=50i4I2T/7l/ynEJyTnOcPsG7iI9gScwuaVHdCL2UJjA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=BkOjoxJM/Ru2hdiI0+0j/yBY2b2vhHhPrfH2UCshRphSUZRY1xxBjSx+IzDL6vDJu
	 UoLPdDh3cCyWhdhiFGWk04s9ceCo+2eTwQV1QdqKGK1e8CCD31ghX3J23/9LUu7MCa
	 hkfd19dnyh57bJYhTo6Lioz01LsQltx3z+WTMkmo=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729156AbfK0Up4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Nov 2019 15:45:56 -0500
Received: from mail.kernel.org ([198.145.29.99]:57230 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729799AbfK0Upy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Nov 2019 15:45:54 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 757CC2158A;
        Wed, 27 Nov 2019 20:45:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1574887553;
        bh=50i4I2T/7l/ynEJyTnOcPsG7iI9gScwuaVHdCL2UJjA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=OkyV9Zb7P7DYdsgU8K4YkG+8LDBYlAbObWNitLlBfugIKRFfDIP8EE/1nxSNHuZzV
         nqKARpJHQOzKZt1s1ypYdCqkJOTrE67GaWWzVzfO9234yGS7gC4KZVKnmexV73y/0l
         eIOEK0jOV/LPa5b26va2Una4jAGRLd01REHEMbAo=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Bo Yan <byan@nvidia.com>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        Lee Jones <lee.jones@linaro.org>
Subject: [PATCH 4.9 115/151] cpufreq: Skip cpufreq resume if its not suspended
Date:   Wed, 27 Nov 2019 21:31:38 +0100
Message-Id: <20191127203044.013113893@linuxfoundation.org>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <20191127203000.773542911@linuxfoundation.org>
References: <20191127203000.773542911@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Bo Yan <byan@nvidia.com>

commit 703cbaa601ff3fb554d1246c336ba727cc083ea0 upstream.

cpufreq_resume can be called even without preceding cpufreq_suspend.
This can happen in following scenario:

    suspend_devices_and_enter
       --> dpm_suspend_start
          --> dpm_prepare
              --> device_prepare : this function errors out
          --> dpm_suspend: this is skipped due to dpm_prepare failure
                           this means cpufreq_suspend is skipped over
       --> goto Recover_platform, due to previous error
       --> goto Resume_devices
       --> dpm_resume_end
           --> dpm_resume
               --> cpufreq_resume

In case schedutil is used as frequency governor, cpufreq_resume will
eventually call sugov_start, which does following:

    memset(sg_cpu, 0, sizeof(*sg_cpu));
    ....

This effectively erases function pointer for frequency update, causing
crash later on. The function pointer would have been set correctly if
subsequent cpufreq_add_update_util_hook runs successfully, but that
function returns earlier because cpufreq_suspend was not called:

    if (WARN_ON(per_cpu(cpufreq_update_util_data, cpu)))
		return;

The fix is to check cpufreq_suspended first, if it's false, that means
cpufreq_suspend was not called in the first place, so do not resume
cpufreq.

Signed-off-by: Bo Yan <byan@nvidia.com>
Acked-by: Viresh Kumar <viresh.kumar@linaro.org>
[ rjw: Dropped printing a message ]
Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
Signed-off-by: Lee Jones <lee.jones@linaro.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/cpufreq/cpufreq.c |    3 +++
 1 file changed, 3 insertions(+)

--- a/drivers/cpufreq/cpufreq.c
+++ b/drivers/cpufreq/cpufreq.c
@@ -1646,6 +1646,9 @@ void cpufreq_resume(void)
 	if (!cpufreq_driver)
 		return;
 
+	if (unlikely(!cpufreq_suspended))
+		return;
+
 	cpufreq_suspended = false;
 
 	if (!has_target() && !cpufreq_driver->resume)



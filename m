Return-Path: <SRS0=J4ZE=RP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2AFBDC43381
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Mar 2019 04:57:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CA5152084F
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Mar 2019 04:57:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="b66kJJle"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726996AbfCLE52 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Mar 2019 00:57:28 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:38962 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726292AbfCLE52 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Mar 2019 00:57:28 -0400
Received: by mail-pg1-f194.google.com with SMTP id h8so876429pgp.6
        for <linux-kernel@vger.kernel.org>; Mon, 11 Mar 2019 21:57:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=4fS+u+j2vJWkUtKW4y5uHGMbNcpwR75hPCIfVWq0nZE=;
        b=b66kJJlensvV/bpjn7a2poBrs/8aKSP+OWF8ekClmVoIhdNn2ywzUiN5wQt64UyL7+
         /6CQg297Ai46AjgNW4NTvMvGO0bgAf4n0IOkdEJMC+HOKxR4aVhq16yCvjRyDGiHGa/T
         bcSDiyC7ivD8Mb2SG55iSZGCO6Oe9xQr1IZgyIQMs9fc7SHaet8XZNvTgNST9c+Ay3qk
         f69qU3Ay4VwZaim071YxVSyOCIDWM3zkSqzWAd+KpCUcM3wTj2CQHLGdWuN6/InWlwvI
         07FXlGPtJHNyu4GZteloam2GJISCQFtYJgJ9TEQGWsqgJTjeZW+rIRlvAIJBCKcUvgT7
         WZsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=4fS+u+j2vJWkUtKW4y5uHGMbNcpwR75hPCIfVWq0nZE=;
        b=J8eLLIfsRIGozw5YUNhDp9fUG4vu7wiXaLPClp4ZlaQzM6QpQAfF0q5Ui2cZM7u+9T
         nSQtxT3koszgNmoJo3EHTqSBtLr1bwXPlS5jYt3TjaaJ0iKCccE7R0f9TYxMmoe71m1/
         3RDVfeL3TUPSO8VgrdL+RLCxsrIJRq9v3IbxK0p/OGkOZDO1Hb81ANPGhkNgif/eeI1D
         o3lRJCM1CA9C+7U0xm20I0XvCrM/dllfTbcyZX21/d36CpGdkqVHAWxkv/IATgxt/+aQ
         YXoOuD2olegaOEHohdNqLjXe9rD+WWjZ+6IYoIWrpTat+28dAnttWednm6lFJfjgcqWk
         3I2w==
X-Gm-Message-State: APjAAAU0c2uL0PhlGXBZiv4nM84aiqB0/RYZxVOeCwFskNmYwRFXFU+b
        Tr59JP+EYm/fiONkKmLhCzCnhA==
X-Google-Smtp-Source: APXvYqwfs5lLgKQEWyyDprzM1klAqSS7lOW64zT5DPyQZrcPGQmKOeM0l1mIyTcYIUdNIvviVx3EGg==
X-Received: by 2002:aa7:8299:: with SMTP id s25mr36844809pfm.56.1552366647056;
        Mon, 11 Mar 2019 21:57:27 -0700 (PDT)
Received: from localhost ([122.166.134.37])
        by smtp.gmail.com with ESMTPSA id m64sm16802318pfi.149.2019.03.11.21.57.25
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 11 Mar 2019 21:57:25 -0700 (PDT)
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Rafael Wysocki <rjw@rjwysocki.net>,
        Viresh Kumar <vireshk@kernel.org>, Nishanth Menon <nm@ti.com>,
        Stephen Boyd <sboyd@kernel.org>
Cc:     Viresh Kumar <viresh.kumar@linaro.org>, linux-pm@vger.kernel.org,
        Vincent Guittot <vincent.guittot@linaro.org>,
        jorge.ramirez-ortiz@linaro.org, "v5 . 0" <stable@vger.kernel.org>,
        Niklas Cassel <niklas.cassel@linaro.org>,
        linux-kernel@vger.kernel.org
Subject: [PATCH] PM / OPP: Update performance state when freq == old_freq
Date:   Tue, 12 Mar 2019 10:27:18 +0530
Message-Id: <5a0c96bebb52c1ae34a2d0df63517b2d2938369c.1552366620.git.viresh.kumar@linaro.org>
X-Mailer: git-send-email 2.21.0.rc0.269.g1a574e7a288b
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

At boot up, CPUfreq core performs a sanity check to see if the system is
running at a frequency defined in the frequency table of the CPU. If so,
we try to find a valid frequency (lowest frequency greater than the
currently programmed frequency) from the table and set it. When the call
reaches dev_pm_opp_set_rate(), it calls _find_freq_ceil(opp_table,
&old_freq) to find the previously configured OPP and this call also
updates the old_freq. This eventually sets the old_freq == freq (new
target requested by cpufreq core) and we skip updating the performance
state in this case.

Fix this by also updating the performance state when the old_freq ==
freq.

Fixes: ca1b5d77b1c6 ("OPP: Configure all required OPPs")
Cc: v5.0 <stable@vger.kernel.org> # v5.0
Reported-by: Niklas Cassel <niklas.cassel@linaro.org>
Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
---
 drivers/opp/core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/opp/core.c b/drivers/opp/core.c
index d7f97167cac3..0420f7e8ad5b 100644
--- a/drivers/opp/core.c
+++ b/drivers/opp/core.c
@@ -760,7 +760,7 @@ int dev_pm_opp_set_rate(struct device *dev, unsigned long target_freq)
 		old_freq, freq);
 
 	/* Scaling up? Configure required OPPs before frequency */
-	if (freq > old_freq) {
+	if (freq >= old_freq) {
 		ret = _set_required_opps(dev, opp_table, opp);
 		if (ret)
 			goto put_opp;
-- 
2.21.0.rc0.269.g1a574e7a288b


Return-Path: <SRS0=GGWy=XB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5B901C00307
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Sep 2019 15:23:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3F6532082C
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Sep 2019 15:23:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2394764AbfIFPX3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 6 Sep 2019 11:23:29 -0400
Received: from foss.arm.com ([217.140.110.172]:58326 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726019AbfIFPX3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Sep 2019 11:23:29 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 7E0ED1576;
        Fri,  6 Sep 2019 08:23:28 -0700 (PDT)
Received: from [10.1.196.133] (e112269-lin.cambridge.arm.com [10.1.196.133])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 8D3603F59C;
        Fri,  6 Sep 2019 08:23:27 -0700 (PDT)
From:   Steven Price <steven.price@arm.com>
Subject: Re: [PATCH] drm/panfrost: Fix regulator_get_optional() misuse
To:     Mark Brown <broonie@kernel.org>, Rob Herring <robh@kernel.org>,
        Tomeu Vizoso <tomeu.vizoso@collabora.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>
Cc:     linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org
References: <20190904123032.23263-1-broonie@kernel.org>
Message-ID: <ccd81530-2dbd-3c02-ca0a-1085b00663b5@arm.com>
Date:   Fri, 6 Sep 2019 16:23:26 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190904123032.23263-1-broonie@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 04/09/2019 13:30, Mark Brown wrote:
> The panfrost driver requests a supply using regulator_get_optional()
> but both the name of the supply and the usage pattern suggest that it is
> being used for the main power for the device and is not at all optional
> for the device for function, there is no meaningful handling for absent
> supplies.  Such regulators should use the vanilla regulator_get()
> interface, it will ensure that even if a supply is not described in the
> system integration one will be provided in software.
> 
> Signed-off-by: Mark Brown <broonie@kernel.org>

Tested-by: Steven Price <steven.price@arm.com>

Looks like my approach to this was wrong - so we should also revert the
changes I made previously.

----8<----
From fe20f8abcde8444bb41a8f72fb35de943a27ec5c Mon Sep 17 00:00:00 2001
From: Steven Price <steven.price@arm.com>
Date: Fri, 6 Sep 2019 15:20:53 +0100
Subject: [PATCH] drm/panfrost: Revert changes to cope with NULL regulator

Handling a NULL return from devm_regulator_get_optional() doesn't seem
like the correct way of handling this. Instead revert the changes in
favour of switching to using devm_regulator_get() which will return a
dummy regulator instead.

Reverts commit 52282163dfa6 ("drm/panfrost: Add missing check for pfdev->regulator")
Reverts commit e21dd290881b ("drm/panfrost: Enable devfreq to work without regulator")

Signed-off-by: Steven Price <steven.price@arm.com>
---
 drivers/gpu/drm/panfrost/panfrost_devfreq.c | 13 +++++++------
 1 file changed, 7 insertions(+), 6 deletions(-)

diff --git a/drivers/gpu/drm/panfrost/panfrost_devfreq.c b/drivers/gpu/drm/panfrost/panfrost_devfreq.c
index a1f5fa6a742a..076983071e58 100644
--- a/drivers/gpu/drm/panfrost/panfrost_devfreq.c
+++ b/drivers/gpu/drm/panfrost/panfrost_devfreq.c
@@ -39,7 +39,7 @@ static int panfrost_devfreq_target(struct device *dev, unsigned long *freq,
 	 * If frequency scaling from low to high, adjust voltage first.
 	 * If frequency scaling from high to low, adjust frequency first.
 	 */
-	if (old_clk_rate < target_rate && pfdev->regulator) {
+	if (old_clk_rate < target_rate) {
 		err = regulator_set_voltage(pfdev->regulator, target_volt,
 					    target_volt);
 		if (err) {
@@ -53,14 +53,12 @@ static int panfrost_devfreq_target(struct device *dev, unsigned long *freq,
 	if (err) {
 		dev_err(dev, "Cannot set frequency %lu (%d)\n", target_rate,
 			err);
-		if (pfdev->regulator)
-			regulator_set_voltage(pfdev->regulator,
-					      pfdev->devfreq.cur_volt,
-					      pfdev->devfreq.cur_volt);
+		regulator_set_voltage(pfdev->regulator, pfdev->devfreq.cur_volt,
+				      pfdev->devfreq.cur_volt);
 		return err;
 	}
 
-	if (old_clk_rate > target_rate && pfdev->regulator) {
+	if (old_clk_rate > target_rate) {
 		err = regulator_set_voltage(pfdev->regulator, target_volt,
 					    target_volt);
 		if (err)
@@ -138,6 +136,9 @@ int panfrost_devfreq_init(struct panfrost_device *pfdev)
 	int ret;
 	struct dev_pm_opp *opp;
 
+	if (!pfdev->regulator)
+		return 0;
+
 	ret = dev_pm_opp_of_add_table(&pfdev->pdev->dev);
 	if (ret == -ENODEV) /* Optional, continue without devfreq */
 		return 0;
-- 
2.20.1


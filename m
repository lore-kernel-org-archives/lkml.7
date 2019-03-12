Return-Path: <SRS0=J4ZE=RP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0D2F3C43381
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Mar 2019 11:56:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D10EA20657
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Mar 2019 11:56:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="GChF3YJo"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726670AbfCLL4C (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Mar 2019 07:56:02 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:35988 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725887AbfCLL4C (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Mar 2019 07:56:02 -0400
Received: by mail-wr1-f67.google.com with SMTP id g18so2392770wru.3
        for <linux-kernel@vger.kernel.org>; Tue, 12 Mar 2019 04:56:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=sP1UMbnvXffQFvwNd2Kjky712sNdl4eU3YJAbGKjznc=;
        b=GChF3YJos7jICxEpgt1qCMpaR0U4BrV05oTTishBHMbSLq1KNQXY5WE0v0RpAdAMHE
         QCdqAkOr8Rw2m/UorsIgozuH9ZT3SA6FYR4ODWKoRme5IAOEnBEIRDqqmCe4N/j+oa3q
         BKadL0GjhUp5u0FtnirgNZKB/YZW/F3i+zxQfFzk3kOJv6Htq5a2OfVHvmj6AZXfqsPo
         /2Reiig3neOd5+04a3w2EbAbapE4CKSHMlBVvNoDdvk2g0Ke0TkDgfFOBRcnQUuVH+bL
         kGN2vl51KFW+c+PrglW6p1LCFurTR9mkfK608cF2LzwgWmpXpvIBzrNizgi9SHM17DD5
         z5xQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=sP1UMbnvXffQFvwNd2Kjky712sNdl4eU3YJAbGKjznc=;
        b=nHhSRNVajoPiwBPj7t3KMlBJSptYeAjfYmCR7x6mRk0JJCQlltV2eF8yoSZD1Fnh20
         tG6t41hFXE5yNHpaAxw73C+CwNPZls7Hb5ojjjigkVWH9tnMPcxg5Xpa0RkAwzReS8hR
         DfSglhViLyBUcIWZkhckSpie+FcOLV6cmBtoGizODRnWDCOF2zbBzUdLRICqd74iFcuo
         /XG8cdsDidlDJgBqXMFx5/eosSSdy1e+lQbioITjnrljJilW/ZThH4coG+ecmQGVK71n
         N19khjqBvUdfnhDDjxPNbylmjzZ+/b68ZMaL4ZXf/9FL1MM6UYg6+NpZqGFxfRsY6gzt
         lesw==
X-Gm-Message-State: APjAAAWxLI+scq+bsmq2CnYiXcc1djhBIEL/xU0EiElTmz55I1ovfEJL
        CQ/kiEO2NupfzJlCknc/h5LhHQ==
X-Google-Smtp-Source: APXvYqxP1fqkxdH3SMt1UhyP3rAzpRcs/W5gu+FiNtIcwHS2o+AOzxgI6S0Bj6Ty4h/8sLFSIzZ95g==
X-Received: by 2002:adf:fd01:: with SMTP id e1mr18313385wrr.204.1552391760145;
        Tue, 12 Mar 2019 04:56:00 -0700 (PDT)
Received: from mms-0440.qualcomm.mm-sol.com ([37.157.136.206])
        by smtp.gmail.com with ESMTPSA id x22sm2064990wmc.19.2019.03.12.04.55.58
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 12 Mar 2019 04:55:59 -0700 (PDT)
From:   Stanimir Varbanov <stanimir.varbanov@linaro.org>
To:     linux-media@vger.kernel.org
Cc:     linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Hans Verkuil <hverkuil@xs4all.nl>,
        Stanimir Varbanov <stanimir.varbanov@linaro.org>
Subject: [PATCH] venus: hfi_parser: fix Source Matcher errors
Date:   Tue, 12 Mar 2019 13:55:42 +0200
Message-Id: <20190312115542.15638-1-stanimir.varbanov@linaro.org>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This fixes following Smatch errors:

hfi_parser.c:103 parse_profile_level() error: memcpy() 'proflevel'
too small (8 vs 128)

hfi_parser.c:129 parse_caps() error: memcpy() 'cap'
too small (16 vs 512)

Signed-off-by: Stanimir Varbanov <stanimir.varbanov@linaro.org>
---
 drivers/media/platform/qcom/venus/hfi_parser.c | 12 ++++++++++--
 1 file changed, 10 insertions(+), 2 deletions(-)

diff --git a/drivers/media/platform/qcom/venus/hfi_parser.c b/drivers/media/platform/qcom/venus/hfi_parser.c
index 2293d936e49c..d8b34a7a825f 100644
--- a/drivers/media/platform/qcom/venus/hfi_parser.c
+++ b/drivers/media/platform/qcom/venus/hfi_parser.c
@@ -96,11 +96,15 @@ parse_profile_level(struct venus_core *core, u32 codecs, u32 domain, void *data)
 	struct hfi_profile_level_supported *pl = data;
 	struct hfi_profile_level *proflevel = pl->profile_level;
 	struct hfi_profile_level pl_arr[HFI_MAX_PROFILE_COUNT] = {};
+	unsigned int i;
 
 	if (pl->profile_count > HFI_MAX_PROFILE_COUNT)
 		return;
 
-	memcpy(pl_arr, proflevel, pl->profile_count * sizeof(*proflevel));
+	for (i = 0; i < pl->profile_count; i++) {
+		pl_arr[i] = *proflevel;
+		proflevel++;
+	}
 
 	for_each_codec(core->caps, ARRAY_SIZE(core->caps), codecs, domain,
 		       fill_profile_level, pl_arr, pl->profile_count);
@@ -122,11 +126,15 @@ parse_caps(struct venus_core *core, u32 codecs, u32 domain, void *data)
 	struct hfi_capability *cap = caps->data;
 	u32 num_caps = caps->num_capabilities;
 	struct hfi_capability caps_arr[MAX_CAP_ENTRIES] = {};
+	unsigned int i;
 
 	if (num_caps > MAX_CAP_ENTRIES)
 		return;
 
-	memcpy(caps_arr, cap, num_caps * sizeof(*cap));
+	for (i = 0; i < num_caps; i++) {
+		caps_arr[i] = *cap;
+		cap++;
+	}
 
 	for_each_codec(core->caps, ARRAY_SIZE(core->caps), codecs, domain,
 		       fill_caps, caps_arr, num_caps);
-- 
2.17.1


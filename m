Return-Path: <SRS0=wfQU=S6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CE870C43219
	for <linux-kernel@archiver.kernel.org>; Sun, 28 Apr 2019 08:32:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9EE94206BF
	for <linux-kernel@archiver.kernel.org>; Sun, 28 Apr 2019 08:32:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="aJgC+ktE"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726659AbfD1Icv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 28 Apr 2019 04:32:51 -0400
Received: from mail-pl1-f194.google.com ([209.85.214.194]:45154 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726466AbfD1Icv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 28 Apr 2019 04:32:51 -0400
Received: by mail-pl1-f194.google.com with SMTP id o5so3598680pls.12
        for <linux-kernel@vger.kernel.org>; Sun, 28 Apr 2019 01:32:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=za5L9TH7RfVFEUEVo+b+Xe+/+fVMc7D24YekrWmKylM=;
        b=aJgC+ktE44qrl5zRP84bJJagrrWxh9plDl7AkXkHZjy0goL6aE1PC0dJYg8ZIvnA3A
         +SeyCgowcSpuVPm2b9an/EFpBwk1uP/QHaXT5n52kcAGYzziXy0YkvRcsDyz8H+CfFbr
         ARKRvaIPlHZRQfSy8uk9CSGNt7SLbRYo7XvYq0VivFYyPJhV25nxCS00wim2Y7zX9gmf
         gXf2OFzrhB2a4KBUJM4+rvcyd0pR12w9B2PGqTlVn6cCE4sm2milmo2T4qD2MJ0iL8Es
         gdxhlXGn+yM+Lp1h4XB/anMSlFNO+o/GyoIfF7BfHta7+AQ0OEEtOeTsLF9xVvd3oMUB
         RByQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=za5L9TH7RfVFEUEVo+b+Xe+/+fVMc7D24YekrWmKylM=;
        b=NwLWv/vVf0xddT5ek78MyHEr54sMgj/SqbcPCvRDsWjwxUNvvyfJXUudNspOubEXDX
         2CsRqqW+Fym5g7LQfQaLeviw3OgwmsYiUqi65CjYtTDSTwxvAGU+U2jYWP5IrbJhTjUQ
         OR8NaN/90mxP5J9jJTe86rc75ci8CJoqXHJGTmKu45UUVQmTQAfIsAUk8egqp6jCAlmv
         yaHx7UiH0XFwuToTJ5PWEiy3K6dPnCrnTvkd2Qr2SOc1EvFhaGUJqn0QWlEXk7S27hU3
         5Vr6FALY1IbXbC/JoGuP3ZZ3AW0/QDo837N6D1EHzUXj2u01HgQt2zB8WCpqbaP71fLT
         X/pw==
X-Gm-Message-State: APjAAAXw8wxzWu3yfnM3lakmTRJWZgw3VWUK2WetoCqi+3QS6QsiTbjC
        qd/jzZzrZqMBc1mmcIEiBTYuTQ==
X-Google-Smtp-Source: APXvYqx8RGU+BbxHTEkhKwnbWli0aNRX8OVkO9X2sD8pXe5tI9nrbVtkzkIzCU3DqyO2yjTvtrKPig==
X-Received: by 2002:a17:902:1103:: with SMTP id d3mr17956465pla.247.1556440370534;
        Sun, 28 Apr 2019 01:32:50 -0700 (PDT)
Received: from localhost.localdomain (li990-117.members.linode.com. [45.33.40.117])
        by smtp.gmail.com with ESMTPSA id a12sm31960518pgq.21.2019.04.28.01.32.46
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 28 Apr 2019 01:32:49 -0700 (PDT)
From:   Leo Yan <leo.yan@linaro.org>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Robert Walker <robert.walker@arm.com>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Mike Leach <mike.leach@linaro.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     Leo Yan <leo.yan@linaro.org>
Subject: [PATCH v1 2/2] perf cs-etm: Don't check cs_etm_queue::prev_packet validity
Date:   Sun, 28 Apr 2019 16:32:28 +0800
Message-Id: <20190428083228.20246-2-leo.yan@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190428083228.20246-1-leo.yan@linaro.org>
References: <20190428083228.20246-1-leo.yan@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Since cs_etm_queue::prev_packet is allocated for all cases, it will
never be NULL pointer; now validity checking prev_packet is pointless,
remove all of them.

Signed-off-by: Leo Yan <leo.yan@linaro.org>
---
 tools/perf/util/cs-etm.c | 6 +-----
 1 file changed, 1 insertion(+), 5 deletions(-)

diff --git a/tools/perf/util/cs-etm.c b/tools/perf/util/cs-etm.c
index 054b480aab04..de488b43f440 100644
--- a/tools/perf/util/cs-etm.c
+++ b/tools/perf/util/cs-etm.c
@@ -979,7 +979,6 @@ static int cs_etm__sample(struct cs_etm_queue *etmq)
 	 * PREV_PACKET is a branch.
 	 */
 	if (etm->synth_opts.last_branch &&
-	    etmq->prev_packet &&
 	    etmq->prev_packet->sample_type == CS_ETM_RANGE &&
 	    etmq->prev_packet->last_instr_taken_branch)
 		cs_etm__update_last_branch_rb(etmq);
@@ -1012,7 +1011,7 @@ static int cs_etm__sample(struct cs_etm_queue *etmq)
 		etmq->period_instructions = instrs_over;
 	}
 
-	if (etm->sample_branches && etmq->prev_packet) {
+	if (etm->sample_branches) {
 		bool generate_sample = false;
 
 		/* Generate sample for tracing on packet */
@@ -1069,9 +1068,6 @@ static int cs_etm__flush(struct cs_etm_queue *etmq)
 	struct cs_etm_auxtrace *etm = etmq->etm;
 	struct cs_etm_packet *tmp;
 
-	if (!etmq->prev_packet)
-		return 0;
-
 	/* Handle start tracing packet */
 	if (etmq->prev_packet->sample_type == CS_ETM_EMPTY)
 		goto swap_packet;
-- 
2.17.1


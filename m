Return-Path: <SRS0=eolO=2I=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7E57DC43603
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Dec 2019 13:24:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 50548227BF
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Dec 2019 13:24:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="qaUdXdAy"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727458AbfLRNYt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 18 Dec 2019 08:24:49 -0500
Received: from mail-lj1-f195.google.com ([209.85.208.195]:34597 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727067AbfLRNYA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Dec 2019 08:24:00 -0500
Received: by mail-lj1-f195.google.com with SMTP id k1so1476456ljg.1
        for <linux-kernel@vger.kernel.org>; Wed, 18 Dec 2019 05:23:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=P72Y5udFHhnfLqxUCy8WtY2iwNO/ZT4H/0nL4IC4LCk=;
        b=qaUdXdAye10Dq5hnevMgeDvmMbOoh8JKSNgxzPVy7A9Y/6uTZ23+VFZDrSyyEAXlrs
         zJJa/RFwQdiT5gjyBF/cJwras2oWGcQHBT/DQaGWeZS3FzTLT7O0VG+56nG8bxY7ZAbR
         O3vF0oaBhJsouwkQxP9tgy7bJRMUayLwjzR9XTLb6WnkbJnqEmSyH6rLm6taW/CMeXem
         sBOgq9NCoYNmaKOx+8ZSkq6EEtpf3aKwNLKgB5zThtF8cBkOk7ygCgud1KtEa5nZNMKz
         C0NEyIV4K2brMdbfDeqaUkc3A7dBeJWhoCqPlcWipWIWMnZ5QU/2HDwj28p9gfmaYGov
         v9gg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=P72Y5udFHhnfLqxUCy8WtY2iwNO/ZT4H/0nL4IC4LCk=;
        b=qKW8EmhLtUwMv5YqHUFh4ZcQJkCerX4b3LBfVZ7uUJPgrgiBd7wu+fkcp3CRor07e3
         MfbPBr3ZBf1TtZgOyBEJz453vW6uP7kRA6Mwz3RruKQcA17o9YpYn/VJO6sRIWqIKVBW
         FX6QUvNpBlrRN3eAERqY0DqE+kkaQSxcNHvsN1iLAlkhZ72MaSHmWzQ6fj9ocTOoocLM
         bt+8Sz09472Rc7hs0TuqP2gxazfHOa3f3juBCor6QugDXGJ7fPPwQIX7Ad4RZpvUUvX1
         yaLw2HhoJRkAzGxk/wJGRi3qUbquf5+2EBKuC7ZcSg7+A/v9JPQDc9hTPkmVJaTQGxGX
         4iuA==
X-Gm-Message-State: APjAAAUKQ0MJN8vzi7pLk6wMP7QISBMJrZraQxrhm/xtNh+DSj5jEsa/
        jfhk/sjp02fDCVese3H8cxyMIQ==
X-Google-Smtp-Source: APXvYqzY48Rn4B1tuzxRZ1zlbNZHw3B57oGrSKXIeYp8HoJqXNIfUt2MnFXDomkFsjMLmouPrRCcNA==
X-Received: by 2002:a2e:8797:: with SMTP id n23mr1702904lji.176.1576675438520;
        Wed, 18 Dec 2019 05:23:58 -0800 (PST)
Received: from localhost.localdomain ([37.157.136.193])
        by smtp.gmail.com with ESMTPSA id z7sm1440667lfa.81.2019.12.18.05.23.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Dec 2019 05:23:58 -0800 (PST)
From:   Stanimir Varbanov <stanimir.varbanov@linaro.org>
To:     linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-media@vger.kernel.org, devicetree@vger.kernel.org
Cc:     Vikash Garodia <vgarodia@codeaurora.org>, dikshita@codeaurora.org,
        Stanimir Varbanov <stanimir.varbanov@linaro.org>
Subject: [PATCH v2 03/12] venus: venc: blacklist two encoder properties
Date:   Wed, 18 Dec 2019 15:22:42 +0200
Message-Id: <20191218132251.24161-4-stanimir.varbanov@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20191218132251.24161-1-stanimir.varbanov@linaro.org>
References: <20191218132251.24161-1-stanimir.varbanov@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Those two properties are not implemented for Venus v4 (sdm845),
thus don't set them to firmware.

Signed-off-by: Stanimir Varbanov <stanimir.varbanov@linaro.org>
---
 drivers/media/platform/qcom/venus/hfi_cmds.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/media/platform/qcom/venus/hfi_cmds.c b/drivers/media/platform/qcom/venus/hfi_cmds.c
index 4f645076abfb..c67e412f8201 100644
--- a/drivers/media/platform/qcom/venus/hfi_cmds.c
+++ b/drivers/media/platform/qcom/venus/hfi_cmds.c
@@ -1207,6 +1207,8 @@ pkt_session_set_property_4xx(struct hfi_session_set_property_pkt *pkt,
 	case HFI_PROPERTY_CONFIG_VENC_MAX_BITRATE:
 	case HFI_PROPERTY_CONFIG_VDEC_POST_LOOP_DEBLOCKER:
 	case HFI_PROPERTY_PARAM_BUFFER_ALLOC_MODE:
+	case HFI_PROPERTY_PARAM_VENC_SESSION_QP:
+	case HFI_PROPERTY_PARAM_VENC_SESSION_QP_RANGE:
 		/* not implemented on Venus 4xx */
 		return -ENOTSUPP;
 	default:
-- 
2.17.1


Return-Path: <SRS0=vY9Y=RJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 366A9C43381
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Mar 2019 09:09:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 081FF20840
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Mar 2019 09:09:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="TYePpk5h"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729342AbfCFJJl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 Mar 2019 04:09:41 -0500
Received: from mail-pf1-f193.google.com ([209.85.210.193]:37759 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726391AbfCFJJk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Mar 2019 04:09:40 -0500
Received: by mail-pf1-f193.google.com with SMTP id s22so8074726pfh.4
        for <linux-kernel@vger.kernel.org>; Wed, 06 Mar 2019 01:09:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=79l63kcqXmc25Kzf0CEDnWnX5vnRmUo9Cx6sRC5Sj+4=;
        b=TYePpk5hYtk7u634e/LJ7sQXvPICLPF9fzcwKbTZU4tiTR64l9GwO2qU+Of5hLYNu3
         z6u0Z7chy1GtMQdkwlaXuVLWEaDV61CmPMl0yIxCQJWj+mUvitYwdsuz7wQq3ponzqeo
         3gQxpQd2fLSFoGW4IxFOrEWqTK9/Z4fmKFEYs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=79l63kcqXmc25Kzf0CEDnWnX5vnRmUo9Cx6sRC5Sj+4=;
        b=uNaK34zNoAyqrMILH4A7xBUqbP6/BV0Kki+XhIeAne4c9Vb77fwJaeeAkPW922k7ca
         CzSvJzjGoLW+oHdnATIDSKoMrbMdSGyHQn6VwMj6Bq8RIc+TLe3Mej01zbC0tyYX+kET
         WLiiGaERfDouNpN+u+YvFiiy/nclNUG8YbcO6HVdaRDa4qiiD9hWDQ21vs6xp+wJoT2K
         krzgP9s87VxBOqy8EYm9u3SxFcLC79ERCfbYr83bYVbY2CCHhmeu+Pn49i60qhN+79rd
         IVddfGWkY2OCzxpDc3INGM2aXw8YWo0dWTRwFGeP1X0dM97i4Qiu84GcDflRDuqyXHDp
         pWJA==
X-Gm-Message-State: APjAAAWto266aDqT+vLWgGYQbmNMhFK8o1yQTROJ8VB9VYxtEV+3HpV3
        IV+wdZdSVUbgDkfgxtSxjsX7ng==
X-Google-Smtp-Source: APXvYqw+ibNtiwANtR95jlMMUbQKUNv8L8d6GDRvJrL1uLsWfFLDmb2lgL5HuDjLsz0atLGM09T3zg==
X-Received: by 2002:a62:e0ca:: with SMTP id d71mr6198984pfm.62.1551863379887;
        Wed, 06 Mar 2019 01:09:39 -0800 (PST)
Received: from pihsun-z840.tpe.corp.google.com ([2401:fa00:1:10:7889:7a43:f899:134c])
        by smtp.googlemail.com with ESMTPSA id h65sm1603710pgc.93.2019.03.06.01.09.36
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 06 Mar 2019 01:09:39 -0800 (PST)
From:   Pi-Hsun Shih <pihsun@chromium.org>
Cc:     Pi-Hsun Shih <pihsun@chromium.org>,
        alsa-devel@alsa-project.org (moderated list:SOUND - SOC LAYER / DYNAMIC
        AUDIO POWER MANAGEM...), Garlic Tseng <garlic.tseng@mediatek.com>,
        KaiChieh Chuang <kaichieh.chuang@mediatek.com>,
        Kees Cook <keescook@chromium.org>,
        linux-arm-kernel@lists.infradead.org (moderated list:ARM/Mediatek SoC
        support), linux-kernel@vger.kernel.org (open list),
        linux-mediatek@lists.infradead.org (moderated list:ARM/Mediatek SoC
        support), Mark Brown <broonie@kernel.org>,
        Masanari Iida <standby24x7@gmail.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Rob Herring <robh@kernel.org>,
        Ryder Lee <ryder.lee@mediatek.com>,
        Shunli Wang <shunli.wang@mediatek.com>,
        Wei Yongjun <weiyongjun1@huawei.com>
Subject: [PATCH 0/2] Fix UBSAN warning in mtk-afe-fe-dai
Date:   Wed,  6 Mar 2019 17:09:01 +0800
Message-Id: <20190306090922.117634-1-pihsun@chromium.org>
X-Mailer: git-send-email 2.21.0.352.gf09ad66450-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This fix a UBSAN warning on mediatek mtk-afe-fe-dai, and also clean up
code to prevent new config introduce the UBSAN warning again.

Pi-Hsun Shih (2):
  ASoC: mediatek: Fix UBSAN warning.
  ASoC: mediatek: Reduce repititive code on mtk_regmap_update_bits.

 sound/soc/mediatek/common/mtk-afe-fe-dai.c | 51 +++++++++-------------
 sound/soc/mediatek/mt2701/mt2701-afe-pcm.c | 13 ------
 sound/soc/mediatek/mt6797/mt6797-afe-pcm.c | 16 -------
 sound/soc/mediatek/mt8173/mt8173-afe-pcm.c | 16 -------
 sound/soc/mediatek/mt8183/mt8183-afe-pcm.c | 20 ---------
 5 files changed, 20 insertions(+), 96 deletions(-)

-- 
2.21.0.352.gf09ad66450-goog


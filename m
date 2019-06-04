Return-Path: <SRS0=CtY/=UD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,T_DKIMWL_WL_HIGH,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D93DAC28CC6
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Jun 2019 09:37:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AE5CA243BD
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Jun 2019 09:37:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="TtcFDUOJ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727074AbfFDJhy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Jun 2019 05:37:54 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:36631 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726918AbfFDJhx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Jun 2019 05:37:53 -0400
Received: by mail-pf1-f194.google.com with SMTP id u22so12344287pfm.3
        for <linux-kernel@vger.kernel.org>; Tue, 04 Jun 2019 02:37:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=7TVSYqt0AsB7YJ3Xxm3mitaiZCuCIy+XhLVxFHTQpdU=;
        b=TtcFDUOJBTX4fU2GOjsgZOopz/xtxGVoz+Nwp22m4PeQyBKJ/joM9EAJNiIaRtoJ7H
         oKJ7hUmAgn59md500Nmzbpi8IoyMiB2Iq0+TXblIz4ZaTZKDAJSWjm7DG1PdYmhTUcj/
         j0dio82Tr0LUwlE4i2DbfXKQLb0EWq1oljcJQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=7TVSYqt0AsB7YJ3Xxm3mitaiZCuCIy+XhLVxFHTQpdU=;
        b=mfhZA21jToFYLHVig/lCQrgoNMM5yVMKnXb8pmuT3QYAP8PkYtGfFpw9dgWE+DdZpy
         kAmDkVxvtMaZbbHOzh0howBkBweM32/36dAfDVro2G7x3BPIhWRL/OhO798cL7/2nw4r
         jDwLMsE4T4hL2VXBg23kyA5QpTdd5loRhx7z4O9qum7HOk0c5tQ0G5Ra7a40Ua/QUHJX
         dGzHFgGRbqSQho2+P7kXw45DWk8GjD7s0CpaV4Nx7wOKo4QNwrMWfsQRc2lss71CKFek
         4jTfFh6XHRaH5ojBZGfEzQjqubmqXgxEzAgbT/0jqT5+z7LpTmei2OC6mqx2XeCqD0GT
         eHHA==
X-Gm-Message-State: APjAAAUWLtasJU8Vy7bU3NzsK6+PeDVLCc51ZC7p9fFHpizhYCKT/6qz
        RmGePPsbXdABfW9JNro+nejWlg==
X-Google-Smtp-Source: APXvYqygJscPGYv83kU8NoDlzGvEBMrfVK4hfkmv7ZiRjnzxo6G3Ih+KPMJupDZ/zyViHMve6I+sDg==
X-Received: by 2002:a17:90a:dd42:: with SMTP id u2mr35787654pjv.118.1559641072459;
        Tue, 04 Jun 2019 02:37:52 -0700 (PDT)
Received: from acourbot.tok.corp.google.com ([2401:fa00:4:4:9712:8cf1:d0f:7d33])
        by smtp.gmail.com with ESMTPSA id j7sm17431588pfa.184.2019.06.04.02.37.49
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 04 Jun 2019 02:37:51 -0700 (PDT)
From:   Alexandre Courbot <acourbot@chromium.org>
To:     Tiffany Lin <tiffany.lin@mediatek.com>,
        Andrew-CT Chen <andrew-ct.chen@mediatek.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Yunfei Dong <yunfei.dong@mediatek.com>,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>
Cc:     linux-media@vger.kernel.org, linux-mediatek@lists.infradead.org,
        linux-kernel@vger.kernel.org,
        Alexandre Courbot <acourbot@chromium.org>
Subject: [PATCH 0/5] media: mtk-vcodec: cleanups and fixes
Date:   Tue,  4 Jun 2019 18:37:32 +0900
Message-Id: <20190604093737.172599-1-acourbot@chromium.org>
X-Mailer: git-send-email 2.22.0.rc1.311.g5d7573a151-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This series extracts the cleanup patches from the RFC of MT8183 support [1] as
these patches can already be merged. MT8183 support will be sent separately.

[1] https://patchwork.kernel.org/cover/10963769/

Changes since RFC:

- Replaced all GPLv2 headers with SPDX

- Replaced EXPORT_SYMBOL with EXPORT_SYMBOL_GPL

Alexandre Courbot (4):
  media: mtk-vcodec: replace GPLv2 with SPDX
  media: mtk-vcodec: avoid unneeded pointer-to-long conversions
  media: mtk-vcodec: remove unneeded proxy functions
  media: mtk-vcodec: constify formats

Yunfei Dong (1):
  media: mtk-vcodec: support single-buffer frames

 .../platform/mtk-vcodec/mtk_vcodec_dec.c      | 45 ++++++++-----------
 .../platform/mtk-vcodec/mtk_vcodec_dec.h      | 15 +------
 .../platform/mtk-vcodec/mtk_vcodec_dec_drv.c  | 15 +------
 .../platform/mtk-vcodec/mtk_vcodec_dec_pm.c   | 14 +-----
 .../platform/mtk-vcodec/mtk_vcodec_dec_pm.h   | 14 +-----
 .../platform/mtk-vcodec/mtk_vcodec_drv.h      | 19 ++------
 .../platform/mtk-vcodec/mtk_vcodec_enc.c      | 34 +++++---------
 .../platform/mtk-vcodec/mtk_vcodec_enc.h      | 15 +------
 .../platform/mtk-vcodec/mtk_vcodec_enc_drv.c  | 15 +------
 .../platform/mtk-vcodec/mtk_vcodec_enc_pm.c   | 14 +-----
 .../platform/mtk-vcodec/mtk_vcodec_enc_pm.h   | 14 +-----
 .../platform/mtk-vcodec/mtk_vcodec_intr.c     | 14 +-----
 .../platform/mtk-vcodec/mtk_vcodec_intr.h     | 14 +-----
 .../platform/mtk-vcodec/mtk_vcodec_util.c     | 15 +------
 .../platform/mtk-vcodec/mtk_vcodec_util.h     | 15 +------
 .../platform/mtk-vcodec/vdec/vdec_h264_if.c   | 35 ++++-----------
 .../platform/mtk-vcodec/vdec/vdec_vp8_if.c    | 36 ++++-----------
 .../platform/mtk-vcodec/vdec/vdec_vp9_if.c    | 37 ++++-----------
 .../media/platform/mtk-vcodec/vdec_drv_base.h | 22 +++------
 .../media/platform/mtk-vcodec/vdec_drv_if.c   | 29 ++++--------
 .../media/platform/mtk-vcodec/vdec_drv_if.h   | 15 +------
 .../media/platform/mtk-vcodec/vdec_ipi_msg.h  | 15 +------
 .../media/platform/mtk-vcodec/vdec_vpu_if.c   | 14 +-----
 .../media/platform/mtk-vcodec/vdec_vpu_if.h   | 14 +-----
 .../platform/mtk-vcodec/venc/venc_h264_if.c   | 36 +++------------
 .../platform/mtk-vcodec/venc/venc_vp8_if.c    | 35 +++------------
 .../media/platform/mtk-vcodec/venc_drv_base.h | 25 +++--------
 .../media/platform/mtk-vcodec/venc_drv_if.c   | 27 +++--------
 .../media/platform/mtk-vcodec/venc_drv_if.h   | 17 +------
 .../media/platform/mtk-vcodec/venc_ipi_msg.h  | 17 +------
 .../media/platform/mtk-vcodec/venc_vpu_if.c   | 15 +------
 .../media/platform/mtk-vcodec/venc_vpu_if.h   | 15 +------
 32 files changed, 114 insertions(+), 562 deletions(-)

-- 
2.22.0.rc1.311.g5d7573a151-goog


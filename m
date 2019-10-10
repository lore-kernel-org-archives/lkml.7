Return-Path: <SRS0=5y3R=YD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3C6E7ECE58E
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Oct 2019 13:14:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1581F206B6
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Oct 2019 13:14:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1570713288;
	bh=00oludAatgvPUo94IEAk1ex809k0kRn3C7x5fsmcZkU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=ML7FYYeVr9LQ0TB8z8jhfwlfh+5g5grdmTPSrLE49NmQx01pyl7Wj76mkSBLbkx5o
	 pxMkwzujLB08sq7/ipejFRL8HycVu1g9FeqwKdweiz/DfAPf2lZm8GW3Hb3X5BmNaU
	 WaXFQRw3dbILUeRPfUDX6XOlsxokQnM8yMHZieZo=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388139AbfJJNOk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 10 Oct 2019 09:14:40 -0400
Received: from mail-lf1-f66.google.com ([209.85.167.66]:42514 "EHLO
        mail-lf1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387660AbfJJNOj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Oct 2019 09:14:39 -0400
Received: by mail-lf1-f66.google.com with SMTP id c195so4342341lfg.9;
        Thu, 10 Oct 2019 06:14:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=C0vnKt7A5LqxtaENHa2gtLyhDwSuKtDsHcAbgoX1Zl0=;
        b=mKUro6qI4tkGzji199Sjih+X1LW+5kwSHBybETR5C3Z0BAQuNc1h6ap3yAs+qYM/Fv
         VXiN63Mvmz9COZZls9D0rFBQA8PqxfhAYq8Sh7irvoF1EBibyCsKMKba6TfKXViDjmVc
         4qG/JWnJyj8S5lXKQK+LHhZDKNyY6z+SCBmNQV9TLWKKv3dUsWXyuxr+hpTZgenviQUT
         wbk69NZqWGMFk4SF3TriO1Q8wCzjtEIU7MdGfq0ihX2y3WcGAEgQPaA65uuNWsTjyRSh
         OJCeYod8w2hyoyc+kHGZo18ikV4QCrFRcfepVJc4fiPxX7z5dGGkXg7zwILAMyEPDN1d
         LrBQ==
X-Gm-Message-State: APjAAAWp0bZS/EYDMOM7E0HOZfdnvICS9Yn81amA09sKjneuvLm+8HQW
        aZAETipFsp6O19vs2xfB7sY=
X-Google-Smtp-Source: APXvYqzmken7paFvOEfr/CD2e/T7S2TzQVEBo50hTfTSua/scq6cymNNbisN35TBca4BLqUtqWWS/w==
X-Received: by 2002:a19:c514:: with SMTP id w20mr6058964lfe.135.1570713276057;
        Thu, 10 Oct 2019 06:14:36 -0700 (PDT)
Received: from xi.terra (c-51f1e055.07-184-6d6c6d4.bbcust.telenor.se. [85.224.241.81])
        by smtp.gmail.com with ESMTPSA id w27sm1233549ljd.55.2019.10.10.06.14.34
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 10 Oct 2019 06:14:34 -0700 (PDT)
Received: from johan by xi.terra with local (Exim 4.92.2)
        (envelope-from <johan@xi.terra>)
        id 1iIYHF-0006Ap-GZ; Thu, 10 Oct 2019 15:14:45 +0200
From:   Johan Hovold <johan@kernel.org>
To:     Rob Clark <robdclark@gmail.com>, Sean Paul <sean@poorly.run>,
        Fabien Dessenne <fabien.dessenne@st.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Harald Freudenberger <freude@linux.ibm.com>
Cc:     David Airlie <airlied@linux.ie>, Daniel Vetter <daniel@ffwll.ch>,
        Heiko Carstens <heiko.carstens@de.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Christian Borntraeger <borntraeger@de.ibm.com>,
        linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
        freedreno@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        linux-media@vger.kernel.org, linux-s390@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Johan Hovold <johan@kernel.org>,
        stable <stable@vger.kernel.org>,
        Hans Verkuil <hans.verkuil@cisco.com>,
        Mauro Carvalho Chehab <mchehab@osg.samsung.com>
Subject: [PATCH 2/4] media: bdisp: fix memleak on release
Date:   Thu, 10 Oct 2019 15:13:31 +0200
Message-Id: <20191010131333.23635-3-johan@kernel.org>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20191010131333.23635-1-johan@kernel.org>
References: <20191010131333.23635-1-johan@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If a process is interrupted while accessing the video device and the
device lock is contended, release() could return early and fail to free
related resources.

Note that the return value of the v4l2 release file operation is
ignored.

Fixes: 28ffeebbb7bd ("[media] bdisp: 2D blitter driver using v4l2 mem2mem framework")
Cc: stable <stable@vger.kernel.org>     # 4.2
Cc: Fabien Dessenne <fabien.dessenne@st.com>
Cc: Hans Verkuil <hans.verkuil@cisco.com>
Cc: Mauro Carvalho Chehab <mchehab@osg.samsung.com>
Signed-off-by: Johan Hovold <johan@kernel.org>
---
 drivers/media/platform/sti/bdisp/bdisp-v4l2.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/media/platform/sti/bdisp/bdisp-v4l2.c b/drivers/media/platform/sti/bdisp/bdisp-v4l2.c
index e90f1ba30574..675b5f2b4c2e 100644
--- a/drivers/media/platform/sti/bdisp/bdisp-v4l2.c
+++ b/drivers/media/platform/sti/bdisp/bdisp-v4l2.c
@@ -651,8 +651,7 @@ static int bdisp_release(struct file *file)
 
 	dev_dbg(bdisp->dev, "%s\n", __func__);
 
-	if (mutex_lock_interruptible(&bdisp->lock))
-		return -ERESTARTSYS;
+	mutex_lock(&bdisp->lock);
 
 	v4l2_m2m_ctx_release(ctx->fh.m2m_ctx);
 
-- 
2.23.0


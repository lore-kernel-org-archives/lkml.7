Return-Path: <SRS0=hqT0=XE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 15FC7C00307
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Sep 2019 08:16:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DAB5E206CD
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Sep 2019 08:16:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="l1zbtjlN"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388889AbfIIIQE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 9 Sep 2019 04:16:04 -0400
Received: from mail-pf1-f195.google.com ([209.85.210.195]:41813 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388847AbfIIIQC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Sep 2019 04:16:02 -0400
Received: by mail-pf1-f195.google.com with SMTP id b13so8651527pfo.8;
        Mon, 09 Sep 2019 01:16:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=tM14s0DFQFvn+p08YZ3Gzff4jwLvWMH3sDRP998EEe0=;
        b=l1zbtjlNTcCfGuB2BPlx0CCPS2BgWuciSFZTwah2ar4UzjmoFT+pfeALgQFP20NpH+
         OHYGbcnahax+eAJmN8rVNhrg1uz2R0JhsUzYNN6GnL2DtmREu6iteTHlUUxOrlFqohel
         +e26iuqDBt7rGsyEg7mg3iT5wW62LKDXfbkvjx/l0/4r9vWh87HHrTAJAUh35MrE8jTq
         +h8t31TgHPHCOhy6FdTdaa39SlCPhURrdvwUy/vhaSnpU+zCauMGdl6s7RNLP8PHcC3R
         +iDpS7laxNZSNSq6nA5Wlcg/sfEaH/YBdakfFqnS3KLPK3G3jzBGCcrErkLtHioFmqHu
         cAnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=tM14s0DFQFvn+p08YZ3Gzff4jwLvWMH3sDRP998EEe0=;
        b=h1e3G+CMZMghDooFF81erXnCzTh5S36axR0ycTiIlpEDVp94HTi+WKNQ67HfP+lVwd
         nxW9OYHhdprpSPt0rFNyc1LbOyuqMYelDAAINjsUOihENisTds9MYsnWXV5xlTJZB4nU
         M/qEQ+hEwyUUDLOmFbiXbYqQXXv1I68c/zEL/6Yq4fUHSocdLFlLVCf4vxs02meXt0k8
         QYrWTlHGVSghW6oaNTx7X+YWsTugAOiJk26rba4d7WD5aiODwIiBlTCEIZb5+F3WgiUp
         mgiuZqCBm/BhnRB6GEMq0Iev54jGBl5s4QTD0WTjC5rg3UKsXadUAnpJLsHHwivlNojz
         FPDA==
X-Gm-Message-State: APjAAAU+NqfOxaIRjS+YezO0jBR646HWdzXsgYHi2sosfdcf8f2Z2jqM
        4mulB8MYZCZXMc4gUqMomXw=
X-Google-Smtp-Source: APXvYqzNTki9MhlLJ8oddpZFdewZ2OsUA3erBamP9wTEDCEiHASEGqMYPmX0Psd5OG54iXPO2/5Cpg==
X-Received: by 2002:aa7:9a5b:: with SMTP id x27mr25347691pfj.232.1568016961854;
        Mon, 09 Sep 2019 01:16:01 -0700 (PDT)
Received: from dtor-ws.mtv.corp.google.com ([2620:15c:202:201:3adc:b08c:7acc:b325])
        by smtp.gmail.com with ESMTPSA id u65sm12686669pfu.104.2019.09.09.01.16.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Sep 2019 01:16:01 -0700 (PDT)
From:   Dmitry Torokhov <dmitry.torokhov@gmail.com>
To:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        linux-kernel@vger.kernel.org, platform-driver-x86@vger.kernel.org
Subject: [PATCH v3 01/13] software node: remove DEV_PROP_MAX
Date:   Mon,  9 Sep 2019 01:15:45 -0700
Message-Id: <20190909081557.93766-2-dmitry.torokhov@gmail.com>
X-Mailer: git-send-email 2.23.0.187.g17f5b7556c-goog
In-Reply-To: <20190909081557.93766-1-dmitry.torokhov@gmail.com>
References: <20190909081557.93766-1-dmitry.torokhov@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This definition is not used anywhere, let's remove it.

Suggested-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
---
 include/linux/property.h | 1 -
 1 file changed, 1 deletion(-)

diff --git a/include/linux/property.h b/include/linux/property.h
index 9b3d4ca3a73a..44c1704f7163 100644
--- a/include/linux/property.h
+++ b/include/linux/property.h
@@ -22,7 +22,6 @@ enum dev_prop_type {
 	DEV_PROP_U32,
 	DEV_PROP_U64,
 	DEV_PROP_STRING,
-	DEV_PROP_MAX,
 };
 
 enum dev_dma_attr {
-- 
2.23.0.187.g17f5b7556c-goog


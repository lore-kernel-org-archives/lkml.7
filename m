Return-Path: <SRS0=OzJr=YZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 11DF8CA9ECF
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Nov 2019 11:24:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D41E520656
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Nov 2019 11:24:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1572607447;
	bh=ZlvpnRLtbhTH6bL1jwzyKo1MZMsNDzVu4omY0MnxPvA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=g9vES+KVKefN8jaIJ1uSUUQ/F87R+p918Dpo5J2GWc1BG+qjDAmDXP5Gng2ZNG34n
	 AD11tW3RoRqh6R4awNshvXzjG2IFQs/MTVlvtQ6kd6KhNMDjSXl1lXzsNKPlUddck7
	 zjx93/lLLlQJ+AX+Pvm+7m1Gqi6VabGErooiq3EQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730403AbfKALYG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 1 Nov 2019 07:24:06 -0400
Received: from mail-lf1-f66.google.com ([209.85.167.66]:44435 "EHLO
        mail-lf1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726229AbfKALYF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Nov 2019 07:24:05 -0400
Received: by mail-lf1-f66.google.com with SMTP id v4so6971991lfd.11;
        Fri, 01 Nov 2019 04:24:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=8kcIhL1Cm288cjerDWSwiT3z8kiQdheRmrevoTt/5WM=;
        b=CQrbAAif+xOhKXmVgzNrOCoMQgNfR1e311Oqk2pfH3W0hGUQmuf0weqyZm0x587DvM
         YmrFh2aJAaQYks/pej+dWegUo8qgNZgG0oDxkqoXxCg6wtuj3xqHnXCucLIilh381d1V
         Z5n2pZTS4ahYGkjaJzIPf4lsxFpD65RNV2xwAajnTRc0H3kf2muTJPocT7ejJDA8+xiC
         iOmY43R+wLmK2DrkSEAlAbRa4QivHaiKJjGJg1pCHgL7Z3iGKHdhC1GsFJ4db7eYUwQv
         PROJr+04sV4HgLil30wyxZfZbZC2hCkCrRZvaETN4Fe1/0ONnQOmUNvYwYBNi7+WO6e4
         NmGw==
X-Gm-Message-State: APjAAAUQQnvAeQg5mhchWsP2Ar1XKvuvnXDbu762KlOXEDldchBY1LeP
        NLqH93/6hJjQtn32u6YtOiI=
X-Google-Smtp-Source: APXvYqxPQ5Jb3QDisDNgr2UvNEwFHT2uk3DP0OUCApwyymh3wt9rBZ0zQvgWcIafZ7l+tMzEDTIJyQ==
X-Received: by 2002:a19:520b:: with SMTP id m11mr6898325lfb.77.1572607442877;
        Fri, 01 Nov 2019 04:24:02 -0700 (PDT)
Received: from neopili.qtec.com (cpe.xe-3-0-1-778.vbrnqe10.dk.customer.tdc.net. [80.197.57.18])
        by smtp.gmail.com with ESMTPSA id v1sm2313691lji.89.2019.11.01.04.24.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 Nov 2019 04:24:01 -0700 (PDT)
From:   Ricardo Ribalda Delgado <ribalda@kernel.org>
To:     Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        linux-media@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Ricardo Ribalda Delgado <ribalda@kernel.org>
Subject: [PATCH v3 2/5] media: v4l2_ctrl: Add const pointer to ctrl_ptr
Date:   Fri,  1 Nov 2019 12:23:55 +0100
Message-Id: <20191101112358.29538-2-ribalda@kernel.org>
X-Mailer: git-send-email 2.24.0.rc1
In-Reply-To: <20191101112358.29538-1-ribalda@kernel.org>
References: <20191101112358.29538-1-ribalda@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This pointer is used to point to data that is constant. Thanks to this
we can avoid a lot of casting and we make more clear when the data is
constant or variable.

Suggested-by: Hans Verkuil <hverkuil-cisco@xs4all.nl>
Signed-off-by: Ricardo Ribalda Delgado <ribalda@kernel.org>
---
 include/media/v4l2-ctrls.h | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/include/media/v4l2-ctrls.h b/include/media/v4l2-ctrls.h
index 78a97b10c89e..7db9e719a583 100644
--- a/include/media/v4l2-ctrls.h
+++ b/include/media/v4l2-ctrls.h
@@ -56,6 +56,7 @@ struct poll_table_struct;
  * @p_hevc_slice_params:	Pointer to an HEVC slice parameters structure.
  * @p_area:			Pointer to an area.
  * @p:				Pointer to a compound value.
+ * @p_const:			Pointer to a constant compound value.
  */
 union v4l2_ctrl_ptr {
 	s32 *p_s32;
@@ -78,6 +79,7 @@ union v4l2_ctrl_ptr {
 	struct v4l2_ctrl_hevc_slice_params *p_hevc_slice_params;
 	struct v4l2_area *p_area;
 	void *p;
+	const void *p_const;
 };
 
 /**
-- 
2.24.0.rc1


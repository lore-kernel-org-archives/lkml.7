Return-Path: <SRS0=xa+R=Y4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 586CCCA9EB5
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Nov 2019 13:09:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2119C21E6F
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Nov 2019 13:09:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1572872976;
	bh=ZlvpnRLtbhTH6bL1jwzyKo1MZMsNDzVu4omY0MnxPvA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=ugnXsjsxjqhBCOeFPnQ4TQ/oFJOAZAaBvc5WUOTO5tfAHro6ntbzsLgeGjbHazRPf
	 MvnNv/eL6z5ZBtSemNP7zJ5Xmekf7z+JTdW0CBeB1a9eFMYTBmtlpUX8uI4qUfYFnO
	 ypUYRMiYm/w51tDjrcRtsbV5ciy5TgASp3AjN5zc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729120AbfKDNJe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 Nov 2019 08:09:34 -0500
Received: from mail-lf1-f65.google.com ([209.85.167.65]:44992 "EHLO
        mail-lf1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729089AbfKDNJc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Nov 2019 08:09:32 -0500
Received: by mail-lf1-f65.google.com with SMTP id v4so12190462lfd.11;
        Mon, 04 Nov 2019 05:09:31 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=8kcIhL1Cm288cjerDWSwiT3z8kiQdheRmrevoTt/5WM=;
        b=NbT0jDzVjveQzXwDS1RpqYM/HFccFhB5BeRDnEXJSqEB+7Wm0UYdncTu3uxVZCZPJp
         2L7Z4q8ye8yQlxyc1IhOmisqPyf2uJ+9wrH8zXxKotXFUcuvfAqFcHqfYxyynZGOmLjy
         /HNIt7XehK5dJo4B0UBNIaO8GdEZH6ejn59n2SVn6BK2NGIYsa2YWDefEhfqF6AB8eUf
         fySiXPTTRFPEWA1N7FqZ9TB3LIr6ihhCB20wTwHOD6d98APChPKkNLbBdOOOZegv47Ad
         7zdK0GY2qHo6nUWGhtC0emAtQvh4q+1JZhchtxLG4ADhy6tW/UeqoDWYYcs8uRcTfGq2
         jtMw==
X-Gm-Message-State: APjAAAVt9k6aETOVmJwfAgX6XnmiJOmPbsv7SnERI4vF9Vk296ZLr9EG
        Z6eZA8FJuNX0KEYP1ol/oKzOyTi9Bac=
X-Google-Smtp-Source: APXvYqxcRtuVs0OtY+hHr9NyWwTPx/Wd/rlX4fmZBhyGDxQBbqyePvHf4yQD5AVEK8qMKhIA2RzmFw==
X-Received: by 2002:a19:4848:: with SMTP id v69mr16651712lfa.6.1572872970364;
        Mon, 04 Nov 2019 05:09:30 -0800 (PST)
Received: from neopili.qtec.com (cpe.xe-3-0-1-778.vbrnqe10.dk.customer.tdc.net. [80.197.57.18])
        by smtp.gmail.com with ESMTPSA id q124sm985414ljq.93.2019.11.04.05.09.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Nov 2019 05:09:29 -0800 (PST)
From:   Ricardo Ribalda Delgado <ribalda@kernel.org>
To:     Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        linux-media@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Ricardo Ribalda Delgado <ribalda@kernel.org>
Subject: [PATCH v4 2/6] media: v4l2_ctrl: Add const pointer to ctrl_ptr
Date:   Mon,  4 Nov 2019 14:09:19 +0100
Message-Id: <20191104130923.22184-2-ribalda@kernel.org>
X-Mailer: git-send-email 2.24.0.rc1
In-Reply-To: <20191104130923.22184-1-ribalda@kernel.org>
References: <20191104130923.22184-1-ribalda@kernel.org>
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


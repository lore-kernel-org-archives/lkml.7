Return-Path: <SRS0=OzJr=YZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8D84FCA9ECF
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Nov 2019 11:25:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 576BD217F9
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Nov 2019 11:25:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1572607522;
	bh=RU9q8ka5yatkwB8tYsXYbor8yQ6cjlMn5UspP2r6s5c=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=2KOpoS3EzzUaVihNqmP1y4a0RWgF7euStmav4G+AeGSpliA9Y3CCOdGRSxI1f2HUg
	 PCfEasBeZGpel1QNZz9KiqEidAv/1sukru3hqufLMycAMTLAczNHIOdhfUKbIODEwy
	 FkhbqlB+ULk/68iMexO5oVYgnS3fThKtKgZ8mFhY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730485AbfKALZV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 1 Nov 2019 07:25:21 -0400
Received: from mail-lf1-f41.google.com ([209.85.167.41]:42382 "EHLO
        mail-lf1-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730466AbfKALZT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Nov 2019 07:25:19 -0400
Received: by mail-lf1-f41.google.com with SMTP id z12so6983062lfj.9;
        Fri, 01 Nov 2019 04:25:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=5kOelELcbXNl2QfySB87h5inDfmG0cvnFxe50Mfnt8I=;
        b=BdFeAvn9UjHW1sa0tGN7V7K/SghzgYjlNFB/6LQMlM8R1L9gI0+Q1oWbh7wj79YGOo
         xDmIoeAG6uVQfw3FhmJRLHJiaU6howi2Q2gb2wWbJwNXzKvetRjXqcAvusP6fKXj6vdk
         MUUbrMyYfLvNO1VxJ4TBW8Xa71NN9jrh6A0h8u68/sHhgeUc2EfkU5JHtvQ0/OCCE9Zr
         ByELvkwh6lfqxWfQQ95umIn0q4eKw+wQWYQdEkpJavdwfxNQoBeylKyq7UeupwV4vxZq
         auwyhDfC1b7OiC1GW7+RHmS7eQai41lFJxa3Kv3COl8opHOE+e91PT2ND9iSml8a+cUc
         k32g==
X-Gm-Message-State: APjAAAWo++6lFl7hxIi0rafIQ2crrdY78LFoS6Db5n/FKy0oMB/phfwh
        nFhaJlFGIzCmR31/UOd7pfinft5Q5ao=
X-Google-Smtp-Source: APXvYqzyHO4lw/uDSRxi0ex1uHhQ2LSYh+wW2n6CmhlyTe9rjftXKO3e86KTDS63od8GYoiGwL1z5w==
X-Received: by 2002:ac2:57cb:: with SMTP id k11mr6885656lfo.87.1572607516680;
        Fri, 01 Nov 2019 04:25:16 -0700 (PDT)
Received: from neopili.qtec.com (cpe.xe-3-0-1-778.vbrnqe10.dk.customer.tdc.net. [80.197.57.18])
        by smtp.gmail.com with ESMTPSA id u13sm1851775ljl.71.2019.11.01.04.25.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 Nov 2019 04:25:14 -0700 (PDT)
From:   Ricardo Ribalda Delgado <ribalda@kernel.org>
To:     Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        linux-media@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Ricardo Ribalda Delgado <ribalda@kernel.org>
Subject: [PATCH 4/4] v4l2-ctl: Support setting V4L2_CTRL_TYPE_AREA controls
Date:   Fri,  1 Nov 2019 12:25:09 +0100
Message-Id: <20191101112509.29723-4-ribalda@kernel.org>
X-Mailer: git-send-email 2.24.0.rc1
In-Reply-To: <20191101112509.29723-1-ribalda@kernel.org>
References: <20191101112509.29723-1-ribalda@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

$ v4l2-ctl  -d /dev/video1  -c area=123123x233

Signed-off-by: Ricardo Ribalda Delgado <ribalda@kernel.org>
---
 utils/v4l2-ctl/v4l2-ctl-common.cpp | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/utils/v4l2-ctl/v4l2-ctl-common.cpp b/utils/v4l2-ctl/v4l2-ctl-common.cpp
index 95339561..676b05e0 100644
--- a/utils/v4l2-ctl/v4l2-ctl-common.cpp
+++ b/utils/v4l2-ctl/v4l2-ctl-common.cpp
@@ -973,6 +973,10 @@ void common_set(cv4l_fd &_fd)
 					strncpy(ctrl.string, iter->second.c_str(), qc.maximum);
 					ctrl.string[qc.maximum] = 0;
 					break;
+				case V4L2_CTRL_TYPE_AREA:
+					sscanf(iter->second.c_str(), "%dx%d",
+					       &ctrl.p_area->width, &ctrl.p_area->height);
+					break;
 				default:
 					fprintf(stderr, "%s: unsupported payload type\n",
 							qc.name);
-- 
2.24.0.rc1


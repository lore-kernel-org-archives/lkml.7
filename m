Return-Path: <SRS0=OzJr=YZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 84A5DCA9ECF
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Nov 2019 11:25:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5D2C920656
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Nov 2019 11:25:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1572607525;
	bh=h8Z3AnF7vXRAjXwVMTjLA3c0ADxJJIgEzh9hlBOMfGM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=oXgEQbGp48IzTky2xiz/531/8oRSPPWqrsTYp7WRYUMaLxsZeCHlPiHcTIwoe2m9J
	 sF36AbAomjzr9ZIhrxVSSblcYfiKkl9BUSYhayfpFVrxvoZg5Q8K52R/yuKAmYyPeY
	 DDM2jc41KZRNqXtagaaTjc6FFyb7c/P4UatzT/Mk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730474AbfKALZU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 1 Nov 2019 07:25:20 -0400
Received: from mail-lf1-f49.google.com ([209.85.167.49]:36406 "EHLO
        mail-lf1-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726663AbfKALZR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Nov 2019 07:25:17 -0400
Received: by mail-lf1-f49.google.com with SMTP id a6so3582090lfo.3;
        Fri, 01 Nov 2019 04:25:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=DaGUTMZTPvVQG7pcnt9rSBQcYcHWYKS+V0DM0nxl4Tk=;
        b=Tjsuln41GeTOgFG04574mENjFrqY/q3z7YCR8BplyHC0vLZe99gRZwjydnO3QuSQRp
         XarI/uxLc6+rsmY+w5+fkKBMAQjBDFtlpYS9df1TbcJpatrwDYg8r+Sjngss0tnn4yaU
         7NfKa2StWHVkkNJ6yfRCN5I127X9pBCqkH0KXYWNeTJMawftDajWjwjJHIDxyUAMqTW1
         leajHJ9uDTZwSjU0HaH6Dzcsek5VBh4nyjmG80o9+sLshs2ulal3kw4k9arCtlONh5jL
         2BBt/u08uD2JUQqKCpa5g0keb9Qb0gIRZ2olzgE9xB9QFb7GiSKjHCSPkHeesESIgPPl
         wiww==
X-Gm-Message-State: APjAAAUXW6u8kKgwz0tpDkbzHUWfERyEZGB9XATDsRkEnu1BXFcPKMCn
        CELYc6a/OZfmb+eJ28/Gb+JO/ZAm5YI=
X-Google-Smtp-Source: APXvYqz+YjmninMzPqS69q3MgmriaCnuS7fq6E4ALGEiKcz8M9m2fNDZGYklmVmjEFrlCHMy9/C/+g==
X-Received: by 2002:a19:f811:: with SMTP id a17mr6870785lff.132.1572607514427;
        Fri, 01 Nov 2019 04:25:14 -0700 (PDT)
Received: from neopili.qtec.com (cpe.xe-3-0-1-778.vbrnqe10.dk.customer.tdc.net. [80.197.57.18])
        by smtp.gmail.com with ESMTPSA id u13sm1851775ljl.71.2019.11.01.04.25.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 Nov 2019 04:25:13 -0700 (PDT)
From:   Ricardo Ribalda Delgado <ribalda@kernel.org>
To:     Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        linux-media@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Ricardo Ribalda Delgado <ribalda@kernel.org>
Subject: [PATCH 3/4] v4l2-ctl: Support getting  V4L2_CTRL_TYPE_AREA controls
Date:   Fri,  1 Nov 2019 12:25:08 +0100
Message-Id: <20191101112509.29723-3-ribalda@kernel.org>
X-Mailer: git-send-email 2.24.0.rc1
In-Reply-To: <20191101112509.29723-1-ribalda@kernel.org>
References: <20191101112509.29723-1-ribalda@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Tested with vivid:

v4l2-ctl -C area -d /dev/video1
area: 51966x727837

Signed-off-by: Ricardo Ribalda Delgado <ribalda@kernel.org>
---
 utils/v4l2-ctl/v4l2-ctl-common.cpp | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/utils/v4l2-ctl/v4l2-ctl-common.cpp b/utils/v4l2-ctl/v4l2-ctl-common.cpp
index b1c12b35..95339561 100644
--- a/utils/v4l2-ctl/v4l2-ctl-common.cpp
+++ b/utils/v4l2-ctl/v4l2-ctl-common.cpp
@@ -1150,6 +1150,11 @@ void common_get(cv4l_fd &_fd)
 							printf("%s: '%s'\n", name.c_str(),
 								safename(ctrl.string).c_str());
 							break;
+						case V4L2_CTRL_TYPE_AREA:
+							printf("%s: %dx%d\n", name.c_str(),
+							       ctrl.p_area->width,
+							       ctrl.p_area->height);
+							break;
 						default:
 							fprintf(stderr, "%s: unsupported payload type\n",
 									qc.name);
-- 
2.24.0.rc1


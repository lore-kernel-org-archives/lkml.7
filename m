Return-Path: <SRS0=Y9JJ=T2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2A1CAC282E1
	for <linux-kernel@archiver.kernel.org>; Sun, 26 May 2019 07:45:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E0A5020815
	for <linux-kernel@archiver.kernel.org>; Sun, 26 May 2019 07:45:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FiWGnqRa"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727615AbfEZHpU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 26 May 2019 03:45:20 -0400
Received: from mail-pl1-f193.google.com ([209.85.214.193]:42028 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726455AbfEZHpT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 26 May 2019 03:45:19 -0400
Received: by mail-pl1-f193.google.com with SMTP id go2so5807023plb.9
        for <linux-kernel@vger.kernel.org>; Sun, 26 May 2019 00:45:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=VAt6DbC3uyBoi5PZNxE9OjYXPKcKQXfx3l8tLzBYq0A=;
        b=FiWGnqRaC5yqdshGwYibL2AFl+2M1swCOkLAPTwvquRcU9beRVqKVBmHKQ0jk0DZzp
         pW30AQ3ott+f2zJn/FhyhCiiLD58UEYDCEKyc93IxsTCw94EzezXGOdY7XKIYqHCx7Gg
         Kb/vaBkvpK6D46slJB+tpvZZETF19r5ojI5hp3snaszXqRtQ+1YfVrs1MJu7ghN4WVkU
         IPm6A6XCAlLAx3F8Xsaccdb6bwRJMVy0k0zFhFwkECAIX+i981whj3Mr+fZ6yu+lS1gM
         P8c3FU5ebIaahoVF+cbsII4wwrPiiq0u+1MD0DZisKrscD7EWDCE6DwGx0QZt8evmvKJ
         Gnkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=VAt6DbC3uyBoi5PZNxE9OjYXPKcKQXfx3l8tLzBYq0A=;
        b=WA+UmF+YxHVlsNZT5RR2hx7XdfDpfAPVCznybKBkeaOE4fAdHHHE8mceeLM++1CLKi
         A074R3Fid8UELwUudpU7tjMAbQV77Vn12QUbV55BGj8EsyW4tckl2eS2UOsJK2sQzAzL
         uxUJ3M5KePt4CSIq7Nr/BdvS8oY5Ppc1Ie9jheV/gRVAgbrORReFGidWuHsw6Ac3zNin
         kLSr/UEERMSzS5j2e0kYTKsOa/0AoYYO/mVvUckyNouY66UN+jc8OmhoaT7xfpGh/5Np
         lnDWZVjHeFZsc+wel1YWokkbFhhm2aDFlFvAGanKImVYCR6qHwUzdo87NK1xGFl9Ke3Z
         Fg1Q==
X-Gm-Message-State: APjAAAWpIRA9zKi0dUCtntNHYbGMnF+7tN0dxOX8MaQ4Cd1Ge12sBA98
        gy7+CdwMgs81/b1cm+HG1M1YmJqX7pI=
X-Google-Smtp-Source: APXvYqwF+Idy7jy5iz6AKlK772bSslul00wZ+DlZb0hnUsu3daL1oin71nd1enm5WhMSMNalHw67XA==
X-Received: by 2002:a17:902:a982:: with SMTP id bh2mr14751046plb.224.1558856719110;
        Sun, 26 May 2019 00:45:19 -0700 (PDT)
Received: from hari-Inspiron-1545 ([183.83.92.73])
        by smtp.gmail.com with ESMTPSA id u5sm6243039pgp.19.2019.05.26.00.45.14
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 26 May 2019 00:45:18 -0700 (PDT)
Date:   Sun, 26 May 2019 13:15:12 +0530
From:   Hariprasad Kelam <hariprasad.kelam@gmail.com>
To:     Rex Zhu <rex.zhu@amd.com>, Evan Quan <evan.quan@amd.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        Christian =?iso-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>,
        "David (ChunMing) Zhou" <David1.Zhou@amd.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Hawking Zhang <Hawking.Zhang@amd.com>,
        Hariprasad Kelam <hariprasad.kelam@gmail.com>,
        amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] drm/amdgpu/powerplay: remove duplicate entry of
 nbio_6_1_offset.h
Message-ID: <20190526074512.GA8744@hari-Inspiron-1545>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

asic_reg/nbio/nbio_6_1_offset.h is included twice.

Issue identified by includecheck

Signed-off-by: Hariprasad Kelam <hariprasad.kelam@gmail.com>
---
 drivers/gpu/drm/amd/powerplay/hwmgr/vega12_inc.h | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/powerplay/hwmgr/vega12_inc.h b/drivers/gpu/drm/amd/powerplay/hwmgr/vega12_inc.h
index e6d9e84..0d08c57 100644
--- a/drivers/gpu/drm/amd/powerplay/hwmgr/vega12_inc.h
+++ b/drivers/gpu/drm/amd/powerplay/hwmgr/vega12_inc.h
@@ -35,7 +35,6 @@
 #include "asic_reg/gc/gc_9_2_1_sh_mask.h"
 
 #include "asic_reg/nbio/nbio_6_1_offset.h"
-#include "asic_reg/nbio/nbio_6_1_offset.h"
 #include "asic_reg/nbio/nbio_6_1_sh_mask.h"
 
 #endif
-- 
2.7.4


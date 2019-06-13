Return-Path: <SRS0=5wok=UM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,UNWANTED_LANGUAGE_BODY,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2A57CC31E45
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Jun 2019 16:54:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0175D2080A
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Jun 2019 16:54:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fFaNK8sA"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404302AbfFMQys (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Jun 2019 12:54:48 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:46720 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730043AbfFMCcS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Jun 2019 22:32:18 -0400
Received: by mail-pg1-f196.google.com with SMTP id v9so8280064pgr.13
        for <linux-kernel@vger.kernel.org>; Wed, 12 Jun 2019 19:32:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:subject:message-id:mime-version:content-disposition
         :content-transfer-encoding:user-agent;
        bh=xkZS/4n8OnrgYSMHiWzUE1/UXhjTe20YLD2dQUV8B4c=;
        b=fFaNK8sAY9lLtLBC0qtTWQ9aup0qNgeIKRhfxV791EHyd1t0s/tufYaba/TmNsvU5D
         f0g142WA4UlPtfiy7L90T97GSeovewO5BcptIoyHDSe+hAcnw/jjDMlxrKbjrJ07ZQtY
         KyhgOBGMuvW1z6w2DqxHDrMLxSDk0GSP2njjeHm8FO0IES4FAR5ADiesXyNlssr8bCY/
         aLkasOlhu1onl6ETsQPp84cLESBdpGOKg2vjmY52jkTsq7/eGo3Ud/nG5gA2PI2Rf43g
         BqkC/vEFGPQkbH9VOsKr9I+apvxsWDJFDtFHBN/S+ZgK/rW0ZP31Iov/sjCyJwH68W6N
         NFuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:subject:message-id:mime-version
         :content-disposition:content-transfer-encoding:user-agent;
        bh=xkZS/4n8OnrgYSMHiWzUE1/UXhjTe20YLD2dQUV8B4c=;
        b=PkI6MgLa3kttTX5W2DqFgSxFS8O8kBv/AB/1XCOge0A21P68atkW5C311I67fDWFoG
         iI+X+pdVEMIKdnlY2tvLIYbCl5x5vGZZ7hyMFmc017Ckp8kHmn8LGDgBBqyE39DcOLlu
         ypk6+EOcb26FfKloQ0wBJ4Y6SYu61C7kB+ZZsgRVUa9srfLQC1HpPiqG9fu3uV7cRVT8
         gsE4MpVtMOfSYeGJgsHHtO47QM3IkF1Mwsm/G0VFFv3x86g/XRYEJdJ8jeJSCKYWgMjT
         7Lw6vsC3yALGWQqZZD+9ivRjBais0eLwNy4Qev9m0djNhGwh5w/FSmdrpsmM5UXllzIz
         PdlQ==
X-Gm-Message-State: APjAAAW6tsp2BPITxOOVlnPBj5GaeX+SKUXIxXgmC63LgdPQ2qm8PwiK
        o+ecV2R6ZONBnMaMHGPWhDOSMklW
X-Google-Smtp-Source: APXvYqyzyBy3DZLEzDQ6bGsEY8iDhcE/0Hp2X7J+zhBjxOw3b0aUoNTW3wygUppTkRtvjqARqlhImQ==
X-Received: by 2002:a63:454a:: with SMTP id u10mr26199040pgk.291.1560393137384;
        Wed, 12 Jun 2019 19:32:17 -0700 (PDT)
Received: from hari-Inspiron-1545 ([183.83.89.153])
        by smtp.gmail.com with ESMTPSA id d123sm937199pfc.144.2019.06.12.19.32.11
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 12 Jun 2019 19:32:16 -0700 (PDT)
Date:   Thu, 13 Jun 2019 08:02:08 +0530
From:   Hariprasad Kelam <hariprasad.kelam@gmail.com>
To:     Harry Wentland <harry.wentland@amd.com>,
        Leo Li <sunpeng.li@amd.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        Christian =?iso-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>,
        "David (ChunMing) Zhou" <David1.Zhou@amd.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Dmytro Laktyushkin <Dmytro.Laktyushkin@amd.com>,
        Bhawanpreet Lakha <Bhawanpreet.Lakha@amd.com>,
        Tony Cheng <tony.cheng@amd.com>,
        Anthony Koo <Anthony.Koo@amd.com>,
        Charlene Liu <charlene.liu@amd.com>,
        Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>,
        Yongqiang Sun <yongqiang.sun@amd.com>,
        Gloria Li <geling.li@amd.com>, amd-gfx@lists.freedesktop.org,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: [PATCH] drm/amd/display: fix compilation error
Message-ID: <20190613023208.GA29690@hari-Inspiron-1545>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

this patch fixes below compilation error

drivers/gpu/drm/amd/amdgpu/../display/dc/dcn10/dcn10_hw_sequencer.c: In
function ‘dcn10_apply_ctx_for_surface’:
drivers/gpu/drm/amd/amdgpu/../display/dc/dcn10/dcn10_hw_sequencer.c:2378:3:
error: implicit declaration of function ‘udelay’
[-Werror=implicit-function-declaration]
   udelay(underflow_check_delay_us);

Signed-off-by: Hariprasad Kelam <hariprasad.kelam@gmail.com>
---
 drivers/gpu/drm/amd/display/dc/dcn10/dcn10_hw_sequencer.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_hw_sequencer.c b/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_hw_sequencer.c
index d2352949..1ac9a4f 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_hw_sequencer.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_hw_sequencer.c
@@ -23,6 +23,7 @@
  *
  */
 
+#include <linux/delay.h>
 #include "dm_services.h"
 #include "core_types.h"
 #include "resource.h"
-- 
2.7.4


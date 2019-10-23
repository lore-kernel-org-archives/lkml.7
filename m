Return-Path: <SRS0=OaAC=YQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8E205CA9EB7
	for <linux-kernel@archiver.kernel.org>; Wed, 23 Oct 2019 15:41:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 64AEA2064A
	for <linux-kernel@archiver.kernel.org>; Wed, 23 Oct 2019 15:41:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="irN2kiQL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2406855AbfJWPlA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 23 Oct 2019 11:41:00 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:45787 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2404283AbfJWPk7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Oct 2019 11:40:59 -0400
Received: by mail-wr1-f68.google.com with SMTP id q13so17664830wrs.12
        for <linux-kernel@vger.kernel.org>; Wed, 23 Oct 2019 08:40:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=veaWPcqNKkHO2xesR9++rJ5BEwtFW1XMdldljCUmrk8=;
        b=irN2kiQLBDfDnCbkJkg5TiJ0d5LvrWcrQ5jUW84CdQAxBOp1dChVo9su8AS5uRSXFp
         ryQ+1X1PYcX+WoSysGNEbEJPpc0fpgfTWJoUNywUDNIbqA8mH3ODHwEWSeyCJhLouOeE
         DVHVp69j/ByZgGGQgC+qzhbsjg2qiHrZ2bFtw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=veaWPcqNKkHO2xesR9++rJ5BEwtFW1XMdldljCUmrk8=;
        b=XTL2W3Tyvq3e9wE4PWobZtAO5csa/F7vCknDWopCn3Mt4Yhib83UUstJbpOynQe0+v
         kq7lZcufvrFEr+JLap8X/+wlhPF88dstWG+RK4WWr2CW2j6GN/RLdPlWxm1+kBpgL4j5
         mk/lHY0ZmG0E3FagXU+zEFqjqk2dp0ciqNoWQhbUcWY+khmZ/+4owLSFAG/u1bzLYLpE
         Jza7BUrPj0aO/GN4/m7hC0+deFZYKWkWy04U3qHWhXYoMnk0INy3qQ1KNzIj6YpchYRC
         GPxrcaluUIVmFWYmbscDxAsMbw49VtC0yPz/QSOFaQ3OvFiDqU9Um6hK+V5MFBGvE+/E
         nMQQ==
X-Gm-Message-State: APjAAAUgWo4+mTTLGhHKdfnOu1soOla5r2uIpFCLFt0S/4X5DaPTOYyk
        a6IHvM4TWmrfU4IRCpwhW40edbkovks=
X-Google-Smtp-Source: APXvYqwikxw4MBCiG3jMJl/r6iNmK2oFCpBVjH1jp5K/GYEMf1X3ljOFTScw2qqjSvtT/PV9J5kUBg==
X-Received: by 2002:adf:dc44:: with SMTP id m4mr7923796wrj.203.1571845257764;
        Wed, 23 Oct 2019 08:40:57 -0700 (PDT)
Received: from kpsingh-kernel.localdomain (90.226.197.178.dynamic.wless.zhbmb00p-cgnat.res.cust.swisscom.ch. [178.197.226.90])
        by smtp.gmail.com with ESMTPSA id a186sm21123622wmd.3.2019.10.23.08.40.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Oct 2019 08:40:57 -0700 (PDT)
From:   KP Singh <kpsingh@chromium.org>
To:     linux-kernel@vger.kernel.org, bpf@vger.kernel.org
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Martin KaFai Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
        Florent Revest <revest@chromium.org>
Subject: [PATCH bpf-next v2] libbpf: Fix strncat bounds error in libbpf_prog_type_by_name
Date:   Wed, 23 Oct 2019 17:40:38 +0200
Message-Id: <20191023154038.24075-1-kpsingh@chromium.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: KP Singh <kpsingh@google.com>

On compiling samples with this change, one gets an error:

 error: ‘strncat’ specified bound 118 equals destination size
  [-Werror=stringop-truncation]

    strncat(dst, name + section_names[i].len,
    ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
     sizeof(raw_tp_btf_name) - (dst - raw_tp_btf_name));
     ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

strncat requires the destination to have enough space for the
terminating null byte.

Fixes: f75a697e09137 ("libbpf: Auto-detect btf_id of BTF-based raw_tracepoint")
Signed-off-by: KP Singh <kpsingh@google.com>
---
 tools/lib/bpf/libbpf.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
index 290684b504b7..dc7d493a7d3d 100644
--- a/tools/lib/bpf/libbpf.c
+++ b/tools/lib/bpf/libbpf.c
@@ -4693,7 +4693,7 @@ int libbpf_prog_type_by_name(const char *name, enum bpf_prog_type *prog_type,
 			}
 			/* prepend "btf_trace_" prefix per kernel convention */
 			strncat(dst, name + section_names[i].len,
-				sizeof(raw_tp_btf_name) - (dst - raw_tp_btf_name));
+				sizeof(raw_tp_btf_name) - sizeof("btf_trace_"));
 			ret = btf__find_by_name(btf, raw_tp_btf_name);
 			btf__free(btf);
 			if (ret <= 0) {
-- 
2.20.1


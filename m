Return-Path: <SRS0=embV=XF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 620F7C3A5A2
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Sep 2019 11:56:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 38B002171F
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Sep 2019 11:56:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="fN37gePq"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388469AbfIJL4n (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 10 Sep 2019 07:56:43 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:36866 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1733144AbfIJL4k (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Sep 2019 07:56:40 -0400
Received: by mail-wr1-f68.google.com with SMTP id i1so19028452wro.4
        for <linux-kernel@vger.kernel.org>; Tue, 10 Sep 2019 04:56:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=t15c8HaxO7PieQmaQJo6m5Fa3LC9U0plzJQkm4Wyt4U=;
        b=fN37gePq6j/onKdsWODRjgRB0RSIEAzJkFNsmZsO7Rj/2Ydz5NSbjvpWNzIbAy9pA/
         9oxN0X6e2Zy8DSUr+5l7voWWPCZHxmcHB9aPMViYyGqKV2xJO+fJXtKd2cTvIS+oWUAb
         U/eQ9hzmSg0IgzNvMa+MSbiuuwdf05LgDQSFQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=t15c8HaxO7PieQmaQJo6m5Fa3LC9U0plzJQkm4Wyt4U=;
        b=Qqya+uJOLFYkT4Mv3NBEjyP9kZGYa1dLcvLMNf1yuMlpQuA7P9yEeYsUfOO1eTtL5L
         MMhcq06Y8SQclsw6Gx4RE3fkKK/d4stbJ0VY9E6U5Yu295woYxNiMCW7viVmE4JQxGbr
         EQh9GyGck6Xe+8AYhYOdFIFPmbAZ8qHTiOKhTdjKbsfaTyOF7ZXqmZ4STH+YFI6XD4S5
         2LmmwycMa8rp3p+O5NgJTwaanFAX7rUB4BJXMmGGeAaNgAmGMt6ZJ33xCeEEb0mMd25C
         tZu6sNmYgVdrQedgB+HWXof1e50bbvcgnz7M0ONJBjK/uZLrnT7injBIMnNXGKQTavel
         EPjg==
X-Gm-Message-State: APjAAAVfHz46YgVra6Y8UI5uCP3rrL9X40vVNq7eUcjfupKw5Jzz0U4o
        wNrFmaOIwhEkQc8WuzT/5kD7wlZEkDc=
X-Google-Smtp-Source: APXvYqx5bCZdZM8ig5BWorMuJCs6R0fLGHDD6n+wdFQaD3/uF7xN9UX6qDjEC4Ak4zVX4HLaU+dLvQ==
X-Received: by 2002:adf:dd04:: with SMTP id a4mr26091671wrm.340.1568116598261;
        Tue, 10 Sep 2019 04:56:38 -0700 (PDT)
Received: from kpsingh-kernel.c.hoisthospitality.com (110.8.30.213.rev.vodafone.pt. [213.30.8.110])
        by smtp.gmail.com with ESMTPSA id q19sm23732935wra.89.2019.09.10.04.56.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Sep 2019 04:56:37 -0700 (PDT)
From:   KP Singh <kpsingh@chromium.org>
To:     linux-kernel@vger.kernel.org, bpf@vger.kernel.org,
        linux-security-module@vger.kernel.org
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        James Morris <jmorris@namei.org>,
        Kees Cook <keescook@chromium.org>,
        Thomas Garnier <thgarnie@chromium.org>,
        Michael Halcrow <mhalcrow@google.com>,
        Paul Turner <pjt@google.com>,
        Brendan Gregg <brendan.d.gregg@gmail.com>,
        Jann Horn <jannh@google.com>,
        Matthew Garrett <mjg59@google.com>,
        Christian Brauner <christian@brauner.io>,
        =?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?= <mic@digikod.net>,
        Florent Revest <revest@chromium.org>,
        Martin KaFai Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
        "Serge E. Hallyn" <serge@hallyn.com>,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        Stanislav Fomichev <sdf@google.com>,
        Quentin Monnet <quentin.monnet@netronome.com>,
        Andrey Ignatov <rdna@fb.com>, Joe Stringer <joe@wand.net.nz>
Subject: [RFC v1 09/14] krsi: Add a helper function for bpf_perf_event_output
Date:   Tue, 10 Sep 2019 13:55:22 +0200
Message-Id: <20190910115527.5235-10-kpsingh@chromium.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190910115527.5235-1-kpsingh@chromium.org>
References: <20190910115527.5235-1-kpsingh@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: KP Singh <kpsingh@google.com>

This helper is mapped to the existing operation
BPF_FUNC_perf_event_output.

An example usage of this function would be:

#define BUF_SIZE 64;

struct bpf_map_def SEC("maps") perf_map = {
        .type = BPF_MAP_TYPE_PERF_EVENT_ARRAY,
        .key_size = sizeof(int),
        .value_size = sizeof(u32),
        .max_entries = MAX_CPUS,
};

SEC("krsi")
int bpf_prog1(void *ctx)
{
	char buf[BUF_SIZE];
	int len;
	u64 flags = BPF_F_CURRENT_CPU;

	/* some logic that fills up buf with len data*/
	len = fill_up_buf(buf);
	if (len < 0)
		return len;
	if (len > BU)
		return 0;

	bpf_perf_event_output(ctx, &perf_map, flags, buf len);
	return 0;
}

A sample program that showcases the use of bpf_perf_event_output is
added later.

Signed-off-by: KP Singh <kpsingh@google.com>
---
 security/krsi/ops.c | 22 ++++++++++++++++++++++
 1 file changed, 22 insertions(+)

diff --git a/security/krsi/ops.c b/security/krsi/ops.c
index a61508b7018f..57bd304a03f4 100644
--- a/security/krsi/ops.c
+++ b/security/krsi/ops.c
@@ -111,6 +111,26 @@ static bool krsi_prog_is_valid_access(int off, int size,
 	return false;
 }
 
+BPF_CALL_5(krsi_event_output, void *, log,
+	   struct bpf_map *, map, u64, flags, void *, data, u64, size)
+{
+	if (unlikely(flags & ~(BPF_F_INDEX_MASK)))
+		return -EINVAL;
+
+	return bpf_event_output(map, flags, data, size, NULL, 0, NULL);
+}
+
+static const struct bpf_func_proto krsi_event_output_proto =  {
+	.func		= krsi_event_output,
+	.gpl_only       = true,
+	.ret_type       = RET_INTEGER,
+	.arg1_type      = ARG_PTR_TO_CTX,
+	.arg2_type      = ARG_CONST_MAP_PTR,
+	.arg3_type      = ARG_ANYTHING,
+	.arg4_type      = ARG_PTR_TO_MEM,
+	.arg5_type      = ARG_CONST_SIZE_OR_ZERO,
+};
+
 static const struct bpf_func_proto *krsi_prog_func_proto(enum bpf_func_id
 							 func_id,
 							 const struct bpf_prog
@@ -121,6 +141,8 @@ static const struct bpf_func_proto *krsi_prog_func_proto(enum bpf_func_id
 		return &bpf_map_lookup_elem_proto;
 	case BPF_FUNC_get_current_pid_tgid:
 		return &bpf_get_current_pid_tgid_proto;
+	case BPF_FUNC_perf_event_output:
+		return &krsi_event_output_proto;
 	default:
 		return NULL;
 	}
-- 
2.20.1


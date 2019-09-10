Return-Path: <SRS0=embV=XF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4EEA6C3A5A2
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Sep 2019 11:57:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 269412084D
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Sep 2019 11:57:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="U2yeuy49"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732253AbfIJL4d (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 10 Sep 2019 07:56:33 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:43664 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731924AbfIJL42 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Sep 2019 07:56:28 -0400
Received: by mail-wr1-f65.google.com with SMTP id q17so14903148wrx.10
        for <linux-kernel@vger.kernel.org>; Tue, 10 Sep 2019 04:56:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=erwaox0KQegjEF70k5TnX2qoDQuWlO/oZz7eu2CybDk=;
        b=U2yeuy49oz2xrU00CSc0L8N5m7pK1clPrglgIMpG4rwgHeb78qd5OYUi+5Q7cHdFdC
         XxpH8vL5J5D5B50U8ksPia+n2rOTT3Efl9AwBmd+S3oN5n1wwszlZixPpAUvXef3tmqJ
         lxvRnOTGcuHYY2hfs0yzy76NJ53p+Zmof1EQ8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=erwaox0KQegjEF70k5TnX2qoDQuWlO/oZz7eu2CybDk=;
        b=Nhf6v9jFTsSY8+PV9b+ZY6B1irUYJjzC+NBMwdEqF7MgMVL0JHqYtFWl/3q3u3VINB
         OZ171yXe6r6XBJecQwaXgNXUHifH/7sCHAzeJDKbeeSwnn4fj9dadklj/bfhpvUmrlJ7
         h4zU6MgGrQ6ZtGtxskLH27gHvk9SvFsd/5nSOLuITjl5wVPieWFsomL50LsSvC+f9Lbw
         dY4UhuoBIw/QsAbbeExqd7xkTSVVWnwldfX6wkyXyiihGgNL1z2G/3aWbGybtKBSyG3h
         Q0XpWtZqYjZ84BMA7UnGLwvYQAjYG3c9I12AL+YLAaKbmypKaNYQPSrZi+3SeqDsdkQd
         vzew==
X-Gm-Message-State: APjAAAUa3JCT4u4r6HMfaA4S66IelEXpeFYKyNgShEiR0yhlhoNhaUWH
        XHTHwlYtBygzzML+H/GLRnrCdyxe/Ek=
X-Google-Smtp-Source: APXvYqwezaTQauLlYnnq67hLlLJ4sDXlgLRoqeO6CL/e/dXjtdzUMWZO0oPgM5a7vUghEl33WTHJVw==
X-Received: by 2002:adf:e947:: with SMTP id m7mr26845791wrn.178.1568116586919;
        Tue, 10 Sep 2019 04:56:26 -0700 (PDT)
Received: from kpsingh-kernel.c.hoisthospitality.com (110.8.30.213.rev.vodafone.pt. [213.30.8.110])
        by smtp.gmail.com with ESMTPSA id q19sm23732935wra.89.2019.09.10.04.56.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Sep 2019 04:56:26 -0700 (PDT)
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
Subject: [RFC v1 03/14] bpf: krsi: sync BPF UAPI header with tools
Date:   Tue, 10 Sep 2019 13:55:16 +0200
Message-Id: <20190910115527.5235-4-kpsingh@chromium.org>
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

Signed-off-by: KP Singh <kpsingh@google.com>
---
 tools/include/uapi/linux/bpf.h | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/tools/include/uapi/linux/bpf.h b/tools/include/uapi/linux/bpf.h
index a5aa7d3ac6a1..32ab38f1a2fe 100644
--- a/tools/include/uapi/linux/bpf.h
+++ b/tools/include/uapi/linux/bpf.h
@@ -171,6 +171,7 @@ enum bpf_prog_type {
 	BPF_PROG_TYPE_CGROUP_SYSCTL,
 	BPF_PROG_TYPE_RAW_TRACEPOINT_WRITABLE,
 	BPF_PROG_TYPE_CGROUP_SOCKOPT,
+	BPF_PROG_TYPE_KRSI,
 };
 
 enum bpf_attach_type {
@@ -197,6 +198,7 @@ enum bpf_attach_type {
 	BPF_CGROUP_UDP6_RECVMSG,
 	BPF_CGROUP_GETSOCKOPT,
 	BPF_CGROUP_SETSOCKOPT,
+	BPF_KRSI,
 	__MAX_BPF_ATTACH_TYPE
 };
 
-- 
2.20.1


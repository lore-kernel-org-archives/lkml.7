Return-Path: <SRS0=a4+J=26=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CA317C282DD
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Jan 2020 16:03:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9FD8620721
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Jan 2020 16:03:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="DwCnLZNP"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732858AbgAIQD2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 Jan 2020 11:03:28 -0500
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:26357 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1731296AbgAIQDX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Jan 2020 11:03:23 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1578585802;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=+U+nGKdjMx0B4G/fm6acyvjMMXdjwiUkB11cChVUwvw=;
        b=DwCnLZNPUdqRx93VvGsc0D0Hg7SNXi0oOu+yNg6mgkt2NOrdEtJjrwtibqmX40jkDmXksZ
        m0VdFiQbXRRcNXQxBGtrA6CefZ1F8MTMzwMGg4ITdHw6VlWwXzpx79o/qoG/Os7N3BK0rw
        04u/vSBUmaeVCaRd90JoY53A6PCE85k=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-300-VgLJAzLcOvSJ0roM2BW5Kw-1; Thu, 09 Jan 2020 11:03:18 -0500
X-MC-Unique: VgLJAzLcOvSJ0roM2BW5Kw-1
Received: by mail-wm1-f71.google.com with SMTP id p2so1097970wma.3
        for <linux-kernel@vger.kernel.org>; Thu, 09 Jan 2020 08:03:17 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=+U+nGKdjMx0B4G/fm6acyvjMMXdjwiUkB11cChVUwvw=;
        b=Lc6MsJE3EVTpxD25hAB1mhaNT6BjwYT9zRudQHx3tXVcS4eo/9Maj8L7T/pnAnBiaz
         +DZJSPtai+5N2ehtWnmTcYj9UutCwZO7lOEG7eUgUiK3j7By1VtCuAhYcRINlLGJ9Gbo
         3e3/5HD5wT5m4AZfKCftYnH5tfjxzn5bKvMzNvbNHzd1mfXHv6kGSmPZaI3NHu8fSzhv
         8EQGPYWsLe/UxZLeQ21G1y6UqO/7WmC128/joahahaH1i/3ARGXaPa/zwVUj3ccxeBGG
         e8lNocdM9CoQpCZta05B7d5bK3ko9+KJQZoURZqiZqBGeEH8047IuQd3EKqNtY7qsP3E
         7BOA==
X-Gm-Message-State: APjAAAX1Tb3qt8+jruKqTv4h8eHjG3eKlbV0ieLkUhxjWpar7MkRINz4
        TinfwnK+uGKwr2r0qv2b55g298bicoXr7xZrlB8Shpc09Sg5L8hlHKsH9RAjUeyxwvL3MO73yu0
        NH7aWRrrTdChH99ax8Tnq0vHi
X-Received: by 2002:adf:ef0b:: with SMTP id e11mr11689567wro.128.1578585796273;
        Thu, 09 Jan 2020 08:03:16 -0800 (PST)
X-Google-Smtp-Source: APXvYqxcaCDsW9bbAJtdhxvEAdTTp7rkMopW6pzF8N23b9naHbPtWUffbUGHw5DVwkRvjunTIXO26A==
X-Received: by 2002:adf:ef0b:: with SMTP id e11mr11689532wro.128.1578585796043;
        Thu, 09 Jan 2020 08:03:16 -0800 (PST)
Received: from redfedo.redhat.com (host81-140-166-164.range81-140.btcentralplus.com. [81.140.166.164])
        by smtp.gmail.com with ESMTPSA id z21sm3258969wml.5.2020.01.09.08.03.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Jan 2020 08:03:15 -0800 (PST)
From:   Julien Thierry <jthierry@redhat.com>
To:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc:     jpoimboe@redhat.com, peterz@infradead.org, raphael.gault@arm.com,
        catalin.marinas@arm.com, will@kernel.org,
        Julien Thierry <jthierry@redhat.com>
Subject: [RFC v5 04/57] objtool: check: Ignore empty alternative groups
Date:   Thu,  9 Jan 2020 16:02:07 +0000
Message-Id: <20200109160300.26150-5-jthierry@redhat.com>
X-Mailer: git-send-email 2.21.1
In-Reply-To: <20200109160300.26150-1-jthierry@redhat.com>
References: <20200109160300.26150-1-jthierry@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Atlernative section can contain entries for alternatives with no
instructions. Objtool will currently crash when handling such an entry.

Just skip that entry, but still give a warning to discourage useless
entries.

Signed-off-by: Julien Thierry <jthierry@redhat.com>
---
 tools/objtool/check.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/tools/objtool/check.c b/tools/objtool/check.c
index 5968e6f08891..27e5380e0e0b 100644
--- a/tools/objtool/check.c
+++ b/tools/objtool/check.c
@@ -866,6 +866,13 @@ static int add_special_section_alts(struct objtool_file *file)
 		}
 
 		if (special_alt->group) {
+			if (!special_alt->orig_len) {
+				WARN("empty alternative entry at %s+0x%lx",
+				     orig_insn->sec->name,
+				     orig_insn->offset);
+				continue;
+			}
+
 			ret = handle_group_alt(file, special_alt, orig_insn,
 					       &new_insn);
 			if (ret)
-- 
2.21.0


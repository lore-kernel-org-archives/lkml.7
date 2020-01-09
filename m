Return-Path: <SRS0=a4+J=26=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4E841C33CA1
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Jan 2020 16:04:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 254EF2072E
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Jan 2020 16:04:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="evHKl/uT"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732928AbgAIQEk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 Jan 2020 11:04:40 -0500
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:37026 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1732900AbgAIQEg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Jan 2020 11:04:36 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1578585874;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=OPBxE4c44VnYWt99R79o8GTHiHVeNVwB4++Qy9Ykboc=;
        b=evHKl/uT7NRlz7OiTw1eJW/jkyH2ijb1RmZm9foIrQcW8rbfuaHmqB9WhPfKmpJ4BtRvvJ
        M9SEoxFtGZpwBo6hDg1hWTtJHhl6gl9x6pslbzC5p6WEbo7E0mCtkwG0/3RWDPMYDFTyGX
        sVYx+h1OR+YgQRo3H5k36ZZo531JA2k=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-412-UuZZUKgyOE-CXw2_sRXlEQ-1; Thu, 09 Jan 2020 11:04:33 -0500
X-MC-Unique: UuZZUKgyOE-CXw2_sRXlEQ-1
Received: by mail-wm1-f72.google.com with SMTP id t4so1100504wmf.2
        for <linux-kernel@vger.kernel.org>; Thu, 09 Jan 2020 08:04:33 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=OPBxE4c44VnYWt99R79o8GTHiHVeNVwB4++Qy9Ykboc=;
        b=HIh/fZYEQpTlykZwK0AzL1PW4kNu1maFNTxlXGonv3SXrhOB6TX6t1LF6XQ2IBZrqc
         T/7Y61SDV1C4cEJCMM9wFPflO50LDU//0T52F1BFuOgpMLJe4nevAUgu+aBZ4Hakw4+F
         bO5v3ZcqYKo2BMbZaCBehu2VSSj4j3IV4SGGRwpBn7BQxfsv91jFKQs8jBNdiY+NtxLi
         vEgltWph/rKUR9tEuKB0ldysHfc+OpH5H5fyTFqPNuflXQHCdu62zJ5U5iTWIWfLXA3M
         TvLjTr7CUsvK6OsY++6WZT9QQ922m80fQ/I+r5e70M5eMOwaQpYSsBkjUYjG+3Fb6oDL
         g4qg==
X-Gm-Message-State: APjAAAV7Ef57VS6tfyU3WUvI6P+zUz+V3eRJTlxkiYhwZ8RriSyxnhev
        /We7Zx96DqlOMgPVKJ3rFNvnzCUSZlq71OVSXAkT3gDX5sfKAFqNmcn5EjQtLPvWcl1j07NHZyZ
        evN7CJWYPdAsgJ1hsyidGecRA
X-Received: by 2002:adf:d848:: with SMTP id k8mr11316231wrl.328.1578585872139;
        Thu, 09 Jan 2020 08:04:32 -0800 (PST)
X-Google-Smtp-Source: APXvYqyqcNbetrnQcSOK2+QlGeBEYrCj6Gyr3pvipf9Hu3BWAwzBGYNpp4vh/6MRtMDYbRKorqQdHw==
X-Received: by 2002:adf:d848:: with SMTP id k8mr11316210wrl.328.1578585871917;
        Thu, 09 Jan 2020 08:04:31 -0800 (PST)
Received: from redfedo.redhat.com (host81-140-166-164.range81-140.btcentralplus.com. [81.140.166.164])
        by smtp.gmail.com with ESMTPSA id b17sm8615898wrp.49.2020.01.09.08.04.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Jan 2020 08:04:31 -0800 (PST)
From:   Julien Thierry <jthierry@redhat.com>
To:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc:     jpoimboe@redhat.com, peterz@infradead.org, raphael.gault@arm.com,
        catalin.marinas@arm.com, will@kernel.org,
        Julien Thierry <jthierry@redhat.com>
Subject: [RFC v5 14/57] objtool: Do not look for STT_NOTYPE symbols
Date:   Thu,  9 Jan 2020 16:02:17 +0000
Message-Id: <20200109160300.26150-15-jthierry@redhat.com>
X-Mailer: git-send-email 2.21.1
In-Reply-To: <20200109160300.26150-1-jthierry@redhat.com>
References: <20200109160300.26150-1-jthierry@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

ELF symbols can have type STT_NOTYPE which have no standard semantics.

Arm64 objects will contain STT_NOTYPE symbols at the beginning of each
section which aren't of any use to generic objtool code. Those symbols
unfortunately overlap with the first function of the section.

Skip symbols with type STT_NOTYPE when looking up symbols.

Suggested-by: Raphael Gault <raphael.gault@arm.com>
Signed-off-by: Julien Thierry <jthierry@redhat.com>
---
 tools/objtool/elf.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/tools/objtool/elf.c b/tools/objtool/elf.c
index edba4745f25a..c6ac0b771b73 100644
--- a/tools/objtool/elf.c
+++ b/tools/objtool/elf.c
@@ -62,7 +62,8 @@ struct symbol *find_symbol_by_offset(struct section *sec, unsigned long offset)
 	struct symbol *sym;
 
 	list_for_each_entry(sym, &sec->symbol_list, list)
-		if (sym->type != STT_SECTION &&
+		if (sym->type != STT_NOTYPE &&
+		    sym->type != STT_SECTION &&
 		    sym->offset == offset)
 			return sym;
 
-- 
2.21.0


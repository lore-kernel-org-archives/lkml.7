Return-Path: <SRS0=M1fl=TR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7885AC04AB4
	for <linux-kernel@archiver.kernel.org>; Fri, 17 May 2019 14:02:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 30E8D20873
	for <linux-kernel@archiver.kernel.org>; Fri, 17 May 2019 14:02:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lca.pw header.i=@lca.pw header.b="pPOl99vB"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729010AbfEQOCk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 17 May 2019 10:02:40 -0400
Received: from mail-qk1-f196.google.com ([209.85.222.196]:45370 "EHLO
        mail-qk1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728664AbfEQOCk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 May 2019 10:02:40 -0400
Received: by mail-qk1-f196.google.com with SMTP id j1so4458070qkk.12
        for <linux-kernel@vger.kernel.org>; Fri, 17 May 2019 07:02:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lca.pw; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=Tq9pjDbxEOyZ7Iwpy2uNH6b9E86aYZuY86joxZD4zbM=;
        b=pPOl99vB+ZM4fPyrXfhg2Epo7F2Qdzj2WsKmspj5wBIL81kTnikotr3tnzMGATy/WS
         aZvVmA0V5Jb3fwkcjgblpEkjdXSQpSNOpb/X/Y00+u/5ibSNshQ6m6jsXhHp4Sd0WeYM
         gPmVuYOGsg0EYvxIlNIiCT7IGTD7fHuO6708hd0mEgiPoizyGX9jKUr1ymFV3tqE1e9g
         W0hEO5CpY96yJ/ctHkRiLLHpVYlHh00qSv1+ufGaOL2j/5TasAe0uLJfZMUAD1F9vAhs
         B2F0Z25J5UITuwsRFB0oJOMXPpFUozSFdpgJVsplmpooix/zgSfCUYYrtdMS+w7uDEC9
         Yw+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=Tq9pjDbxEOyZ7Iwpy2uNH6b9E86aYZuY86joxZD4zbM=;
        b=OCxdxnhr9Dq7pfsP87ttEGI68JMbczJ2ZKDOTamKh/zlJfJfaIvrENb/ln6whbzT9j
         tofvUJOiHPG8KxD8yqlNqtZYkLoTDVpS3J0oHqjydaF4oVq6L8zE29mxn7EKEXg4tzZ9
         i6YsoSF4e230vNXUKDrOGwGptT/2r152y18HBePynlif52lKsZm2cdhQu7GmEWAqDHV+
         qoj6TYtZsRXS/fF24U5pkt9d7YpfaTI47K3kpoGgPfqOHgKhZ7eMpXsaHkxxZSo71GHG
         Om0S+3LIX5sjAXYvn4pCc9BoVaHoLCiA7/9+nPrfEthaoYqsPJwlsWMsXIeyGvHQ5Mte
         vgbg==
X-Gm-Message-State: APjAAAXM835E1+pEegg6KV16A032UwmOWkammgy88lBQ3Ob3TXa9RF5C
        Lm0DK2roltXgIUyOhWtNbTEAsg==
X-Google-Smtp-Source: APXvYqxpdthmw/ru6DIU4vE9FD7BD+dWymUq02I/FHUxJkYGFGacoBcLSXgUo7AW1EJXLdTZUxtwJA==
X-Received: by 2002:a05:620a:12da:: with SMTP id e26mr3168424qkl.132.1558101758996;
        Fri, 17 May 2019 07:02:38 -0700 (PDT)
Received: from qcai.com (nat-pool-bos-t.redhat.com. [66.187.233.206])
        by smtp.gmail.com with ESMTPSA id g20sm3933764qki.52.2019.05.17.07.02.37
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 17 May 2019 07:02:38 -0700 (PDT)
From:   Qian Cai <cai@lca.pw>
To:     pbonzini@redhat.com, rkrcmar@redhat.com
Cc:     karahmed@amazon.de, konrad.wilk@oracle.com, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org, Qian Cai <cai@lca.pw>
Subject: [PATCH -next] kvm: fix compilation errors with mem[re|un]map()
Date:   Fri, 17 May 2019 10:01:53 -0400
Message-Id: <1558101713-15325-1-git-send-email-cai@lca.pw>
X-Mailer: git-send-email 1.8.3.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The linux-next commit e45adf665a53 ("KVM: Introduce a new guest mapping
API") introduced compilation errors on arm64.

arch/arm64/kvm/../../../virt/kvm/kvm_main.c:1764:9: error: implicit
declaration of function 'memremap'
[-Werror,-Wimplicit-function-declaration]
                hva = memremap(pfn_to_hpa(pfn), PAGE_SIZE, MEMREMAP_WB);
                      ^
arch/arm64/kvm/../../../virt/kvm/kvm_main.c:1764:9: error: this function
declaration is not a prototype [-Werror,-Wstrict-prototypes]
arch/arm64/kvm/../../../virt/kvm/kvm_main.c:1764:46: error: use of
undeclared identifier 'MEMREMAP_WB'
                hva = memremap(pfn_to_hpa(pfn), PAGE_SIZE, MEMREMAP_WB);
                                                           ^
arch/arm64/kvm/../../../virt/kvm/kvm_main.c:1796:3: error: implicit
declaration of function 'memunmap'
[-Werror,-Wimplicit-function-declaration]
                memunmap(map->hva);

Fixed it by including io.h in kvm_main.c.

Signed-off-by: Qian Cai <cai@lca.pw>
---
 virt/kvm/kvm_main.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/virt/kvm/kvm_main.c b/virt/kvm/kvm_main.c
index 8d83a787fd6b..5c5102799c2c 100644
--- a/virt/kvm/kvm_main.c
+++ b/virt/kvm/kvm_main.c
@@ -51,6 +51,7 @@
 #include <linux/slab.h>
 #include <linux/sort.h>
 #include <linux/bsearch.h>
+#include <linux/io.h>
 
 #include <asm/processor.h>
 #include <asm/io.h>
-- 
1.8.3.1


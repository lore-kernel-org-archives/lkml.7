Return-Path: <SRS0=c0gK=S7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0FFEAC43219
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Apr 2019 17:37:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D18B520644
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Apr 2019 17:37:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lca.pw header.i=@lca.pw header.b="ptaO2FS6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729078AbfD2Rhe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Apr 2019 13:37:34 -0400
Received: from mail-qt1-f193.google.com ([209.85.160.193]:42005 "EHLO
        mail-qt1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728748AbfD2Rhb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Apr 2019 13:37:31 -0400
Received: by mail-qt1-f193.google.com with SMTP id p20so12885519qtc.9
        for <linux-kernel@vger.kernel.org>; Mon, 29 Apr 2019 10:37:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lca.pw; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Scl3PSeQx2hTIiqKFeLsOvlDZYPJZC93Bw/i/+ssipk=;
        b=ptaO2FS6ypIWyQztD2x2lutibcWLniDRjyeuKUfWIf1O+X5lxP5eMp4/yYYtuz+pGY
         Ce1XXKV/mauofPq43ANGGo6PE3Kk/SDXnWiQRI+og1/IPlwqZfM6Vq8Ohx+Qd+xe3Cea
         1XliFECnAIIRzb4T3QpixakaHFmr/RZ921PUK1wHvYo6CbSuHBTc3bjjbOBaLe1x3AKr
         LqNHs/SltBfNkLhL6b7nnJnLPK211670F1VVeE8oneNUafHLpj9ZvtGw3ypqtz1pEIJx
         JcDr2aqjt21YG85BglmPhR89KSy7HkMswTGFzEMe1/jlO7ILrDSYmMKxnVU2We8soAVR
         P51A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Scl3PSeQx2hTIiqKFeLsOvlDZYPJZC93Bw/i/+ssipk=;
        b=XtvGTmQP+sPCW+x8W7uM7FC85sZkbPuaVyRMi41Pz+R8sshjAB7AvHXXUPidkL17Iq
         0Hg8TF3op2QEbCtaleQNq69xl+kXjWUah/9+SEZ6SQ1FM66qGTyXd/R+SMZ2uaSwBo59
         ao/zbJMtiL5AQ25n5hFw5WZ2btSF+Oep1aK26nf8egWo10L3i4/FGn2u4pDZzkY+47G/
         ztwCwGnWix4zIgt2jFmM04D/eLyDBJGfNO+GGeJm9XU/9vBcfWoMK2mlByPD0K0sHahb
         TqAT0MtnSvp+HPR22Yn80W7z/1+XmiPui5jtzK6Y6l653f5sh5e6KLjSf9Dr0fRwIo8Z
         NVdg==
X-Gm-Message-State: APjAAAW4yAumiGQn5FPd3brBAtp1rcNOWk8qSYqlaQFBAtmafkeWoVkO
        ycqy6o4zqPp1nAHBR2xph9weag==
X-Google-Smtp-Source: APXvYqxVU8sw20J6Qw/4taFaNGKYpelgEYrGSEY3WYaBH1E6yhmpWrRJFCcKzXbh58XbHGTuCJNX8g==
X-Received: by 2002:ac8:3613:: with SMTP id m19mr27358131qtb.261.1556559435878;
        Mon, 29 Apr 2019 10:37:15 -0700 (PDT)
Received: from ovpn-121-162.rdu2.redhat.com (pool-71-184-117-43.bstnma.fios.verizon.net. [71.184.117.43])
        by smtp.gmail.com with ESMTPSA id 74sm4710182qta.15.2019.04.29.10.37.14
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 29 Apr 2019 10:37:15 -0700 (PDT)
From:   Qian Cai <cai@lca.pw>
To:     catalin.marinas@arm.com, will.deacon@arm.com
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Qian Cai <cai@lca.pw>
Subject: [PATCH 1/2] arm64: fix pte_unmap() -Wunused-but-set-variable
Date:   Mon, 29 Apr 2019 13:37:01 -0400
Message-Id: <20190429173702.31389-1-cai@lca.pw>
X-Mailer: git-send-email 2.20.1 (Apple Git-117)
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Many compilation warnings due to pte_unmap() compiles away. Fixed it by
making it an static inline function.

mm/gup.c: In function 'gup_pte_range':
mm/gup.c:1727:16: warning: variable 'ptem' set but not used
[-Wunused-but-set-variable]
mm/gup.c: At top level:
mm/memory.c: In function 'copy_pte_range':
mm/memory.c:821:24: warning: variable 'orig_dst_pte' set but not used
[-Wunused-but-set-variable]
mm/memory.c:821:9: warning: variable 'orig_src_pte' set but not used
[-Wunused-but-set-variable]
mm/swap_state.c: In function 'swap_ra_info':
mm/swap_state.c:641:15: warning: variable 'orig_pte' set but not used
[-Wunused-but-set-variable]
mm/madvise.c: In function 'madvise_free_pte_range':
mm/madvise.c:318:9: warning: variable 'orig_pte' set but not used
[-Wunused-but-set-variable]

Signed-off-by: Qian Cai <cai@lca.pw>
---
 arch/arm64/include/asm/pgtable.h | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/arch/arm64/include/asm/pgtable.h b/arch/arm64/include/asm/pgtable.h
index de70c1eabf33..74ebe9693714 100644
--- a/arch/arm64/include/asm/pgtable.h
+++ b/arch/arm64/include/asm/pgtable.h
@@ -478,6 +478,8 @@ static inline phys_addr_t pmd_page_paddr(pmd_t pmd)
 	return __pmd_to_phys(pmd);
 }
 
+static inline void pte_unmap(pte_t *pte) { }
+
 /* Find an entry in the third-level page table. */
 #define pte_index(addr)		(((addr) >> PAGE_SHIFT) & (PTRS_PER_PTE - 1))
 
@@ -486,7 +488,6 @@ static inline phys_addr_t pmd_page_paddr(pmd_t pmd)
 
 #define pte_offset_map(dir,addr)	pte_offset_kernel((dir), (addr))
 #define pte_offset_map_nested(dir,addr)	pte_offset_kernel((dir), (addr))
-#define pte_unmap(pte)			do { } while (0)
 #define pte_unmap_nested(pte)		do { } while (0)
 
 #define pte_set_fixmap(addr)		((pte_t *)set_fixmap_offset(FIX_PTE, addr))
-- 
2.20.1 (Apple Git-117)


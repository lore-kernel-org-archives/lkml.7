Return-Path: <SRS0=Exau=WQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8D099C3A589
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Aug 2019 12:45:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5DCF022CF7
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Aug 2019 12:45:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gFoUHKIQ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729833AbfHTMpy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 20 Aug 2019 08:45:54 -0400
Received: from mail-ed1-f67.google.com ([209.85.208.67]:36068 "EHLO
        mail-ed1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727006AbfHTMpx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Aug 2019 08:45:53 -0400
Received: by mail-ed1-f67.google.com with SMTP id p28so6162054edi.3
        for <linux-kernel@vger.kernel.org>; Tue, 20 Aug 2019 05:45:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to;
        bh=Dp5uXH88QRA/bXVLHIjk15umxtR8CFYdI5CdV0MNwiU=;
        b=gFoUHKIQv1yKXibRJwJtvKk+vu+slseNa43EK94DMTMmkCFvaM94wiOT9Fc3I8O3Gp
         owKgx2aOBnNfrrJIxy7o6JQfArYlDZl+w4l8CrLMfEKPnUZW/n1oLE1GJv810IbyH/Tg
         EWI59fzKdH+oZ3wg4nPnVx7hucTJpaTDvZq0MLLPVuCnHMLhj9Bwwg1dW9oe5XVcN7B5
         iHqhVLlTqNa6LT+vn2bK2AFjIb81J3YtEp/elLEafYne4r+9oeKT5VjgMmLrNLGf+Fr0
         VJlHVbrdIy7LeF1Ohjtql16muMJl8w8PLKgqOBHczn/DH6IX9D/Ojt73PoKUegb+iSEB
         rJEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to;
        bh=Dp5uXH88QRA/bXVLHIjk15umxtR8CFYdI5CdV0MNwiU=;
        b=AGvnUPM7v0wmvxblQKj5p1gu3RfBLPq9S09nRIeH3pFzWm984I3RyHHq5w4I0uu5bl
         Gexobn6c7Nf3zYOuDzjPy3/y9zylNDhSjS6trbvt5S8S0btusZ6bE/NKOy8HLOUWg31P
         C1cq8lZpby1ioV+bC1KgoTWdtDGLQFGN5+v9+QZJVvzBhNQ8Cq6qb0/B8k2vA2qg+gpL
         WsRbLpuePsFngEqwJrHb/YMQnoDcAvrHbgxxNt2rE4PhRUK85Iqgcks59ejSqBI2o1rW
         IJDr5dbOyEUBcKOo0oWUf2G+vgNK4RHFt75Iz+7D9WidCZTOXlgwuSKlL+DmwZgYAJwa
         WHLA==
X-Gm-Message-State: APjAAAVB/GTGBBvNUdMvPymxGH7o+66c89TROZz9r67fIf7zzLtkHZAW
        rAW3S3kWtsix74dssswjuJBEc5lrWobSp7Nwrec=
X-Google-Smtp-Source: APXvYqz2KC6i/9M/utwzdHXkbhE4DvqME+AWwIXwyy5hKC7PwIN6/XGeebKHyUNXMq7n78r7Ti1/3/0vw1Jq3UeMjBo=
X-Received: by 2002:a17:906:7c49:: with SMTP id g9mr23466789ejp.262.1566305152072;
 Tue, 20 Aug 2019 05:45:52 -0700 (PDT)
MIME-Version: 1.0
References: <1566179120-5910-1-git-send-email-huangzhaoyang@gmail.com> <1566193808-9153-1-git-send-email-huangzhaoyang@gmail.com>
In-Reply-To: <1566193808-9153-1-git-send-email-huangzhaoyang@gmail.com>
From:   Zhaoyang Huang <huangzhaoyang@gmail.com>
Date:   Tue, 20 Aug 2019 20:45:41 +0800
Message-ID: <CAGWkznG4hiQGb4uYCAiLTgvJ_tZt5s-2h+X_1T3uOmm+U04fTg@mail.gmail.com>
Subject: [Resend PATCH v3] arch : arm : add a criteria for pfn_valid
To:     Andrew Morton <akpm@linux-foundation.org>,
        Zhaoyang Huang <zhaoyang.huang@unisoc.com>,
        Russell King <linux@armlinux.org.uk>,
        Mike Rapoport <rppt@linux.ibm.com>,
        Rob Herring <robh@kernel.org>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Doug Berger <opendmb@gmail.com>,
        LKML <linux-kernel@vger.kernel.org>, chunyan.zhang@unisoc.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Zhaoyang Huang <zhaoyang.huang@unisoc.com>

pfn_valid can be wrong when parsing a invalid pfn whose phys address
exceeds BITS_PER_LONG as the MSB will be trimed when shifted.

The issue originally arise from bellowing call stack, which corresponding to
an access of the /proc/kpageflags from userspace with a invalid pfn parameter
and leads to kernel panic.

[46886.723249] c7 [<c031ff98>] (stable_page_flags) from [<c03203f8>]
[46886.723264] c7 [<c0320368>] (kpageflags_read) from [<c0312030>]
[46886.723280] c7 [<c0311fb0>] (proc_reg_read) from [<c02a6e6c>]
[46886.723290] c7 [<c02a6e24>] (__vfs_read) from [<c02a7018>]
[46886.723301] c7 [<c02a6f74>] (vfs_read) from [<c02a778c>]
[46886.723315] c7 [<c02a770c>] (SyS_pread64) from [<c0108620>]
(ret_fast_syscall+0x0/0x28)

Signed-off-by: Zhaoyang Huang <zhaoyang.huang@unisoc.com>
Reviewed-by: Mike Rapoport <rppt@linux.ibm.com>
---
v2: use __pfn_to_phys/__phys_to_pfn instead of max_pfn as the criteria
v3: update commit message to describe the defection's context
      add Mike Rapoport as reviewer
---
 arch/arm/mm/init.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/arch/arm/mm/init.c b/arch/arm/mm/init.c
index c2daabb..cc769fa 100644
--- a/arch/arm/mm/init.c
+++ b/arch/arm/mm/init.c
@@ -177,6 +177,11 @@ static void __init zone_sizes_init(unsigned long
min, unsigned long max_low,
 #ifdef CONFIG_HAVE_ARCH_PFN_VALID
 int pfn_valid(unsigned long pfn)
 {
+       phys_addr_t addr = __pfn_to_phys(pfn);
+
+       if (__phys_to_pfn(addr) != pfn)
+               return 0;
+
        return memblock_is_map_memory(__pfn_to_phys(pfn));
 }
 EXPORT_SYMBOL(pfn_valid);
-- 
1.9.1

Return-Path: <SRS0=a4+J=26=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 51093C33CA2
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Jan 2020 16:09:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 27397206ED
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Jan 2020 16:09:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="JJCN0t+v"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387460AbgAIQJo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 Jan 2020 11:09:44 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:21198 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S2387437AbgAIQJn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Jan 2020 11:09:43 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1578586181;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=wMGHjJl3e1P107q4BQ6psOhaStZ5a/m6KJ9UhI8WuJA=;
        b=JJCN0t+v/h2CJOyQVEFe68+9mDvf20OIfPX5YPtmZv6lPVWdioRg/Y4PetwrYu0gZAxhJD
        xhq1ZawJ+aIMRBNFhQipDTxoSwp2RTFwf0vMZqfk3o3N95gXFjuth15B+etX19NeAMDxZQ
        w0Qm9dyrBIQlKwkh6+rpDO4BD9Euhhk=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-341-k0OlI9P4MKufFgpWOYhriA-1; Thu, 09 Jan 2020 11:09:39 -0500
X-MC-Unique: k0OlI9P4MKufFgpWOYhriA-1
Received: by mail-wr1-f70.google.com with SMTP id c6so3031059wrm.18
        for <linux-kernel@vger.kernel.org>; Thu, 09 Jan 2020 08:09:39 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=wMGHjJl3e1P107q4BQ6psOhaStZ5a/m6KJ9UhI8WuJA=;
        b=dYJEtgy6PRqHsmRyhrDAaOAyvxPUT+DQbsZjkXkkJbLwlaqA7COX0QNV+0FTs0yKwA
         jf62vPCNvcZhjZKdcrav/f5VcV3JAiBrnG1oC/zzXx1/6t5VMyfFUBXtOpwBE2ArQ+zC
         isvLXIkkrbIPuo9nd7XqWyGdcl1bYI2qNVZ/SMNXGXSwPPBhUEovbhexguVqGboiicbW
         eIzMmVoBHgtp3pwQEp1Q392sv8ugdyB9jcqmil0PdsILnPUuPtBN4clmekiSdiwwal6B
         9G64fQZLPLTvT6Jt9l2AJI7PN3PEjPTGoyUe2orryh7LoUu+LqsjmRIU4WgA0TNu926B
         /rTA==
X-Gm-Message-State: APjAAAXn4hOj8K47DYcend/dYh/fGi3BE/x9e5Fiph3oAewRePlRsW4N
        EzBacfIFJ9TkEYARyEQyFQkeBJSo1srLY8E0cVlb4bhntnLtXgGFIGOI/AWaHROsXq0Id62uvl7
        7bFQ3b68XEO1Tx+YuU5lqbuyf
X-Received: by 2002:a7b:c93a:: with SMTP id h26mr5626267wml.83.1578586178083;
        Thu, 09 Jan 2020 08:09:38 -0800 (PST)
X-Google-Smtp-Source: APXvYqxbW0SbCoj52xkl2G5xsHM6LJP70fkM18f+faXI8eAh4PCwOpImStNR0bRzwb42NSJPmkTJoA==
X-Received: by 2002:a7b:c93a:: with SMTP id h26mr5626254wml.83.1578586177927;
        Thu, 09 Jan 2020 08:09:37 -0800 (PST)
Received: from redfedo.redhat.com (host81-140-166-164.range81-140.btcentralplus.com. [81.140.166.164])
        by smtp.gmail.com with ESMTPSA id e8sm8517707wrt.7.2020.01.09.08.09.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Jan 2020 08:09:37 -0800 (PST)
From:   Julien Thierry <jthierry@redhat.com>
To:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc:     jpoimboe@redhat.com, peterz@infradead.org, raphael.gault@arm.com,
        catalin.marinas@arm.com, will@kernel.org,
        Julien Thierry <jthierry@redhat.com>
Subject: [RFC v5 54/57] arm64: Move constant to rodata
Date:   Thu,  9 Jan 2020 16:02:57 +0000
Message-Id: <20200109160300.26150-55-jthierry@redhat.com>
X-Mailer: git-send-email 2.21.1
In-Reply-To: <20200109160300.26150-1-jthierry@redhat.com>
References: <20200109160300.26150-1-jthierry@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Constant arm64_relocate_new_kernel_size does not need to be in
the same section as the new kernel code/data region.

Move it to ".rodata" section.

Signed-off-by: Julien Thierry <jthierry@redhat.com>
---
 arch/arm64/kernel/relocate_kernel.S | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/arch/arm64/kernel/relocate_kernel.S b/arch/arm64/kernel/relocate_kernel.S
index 5e08845f701a..e7a5fded59e6 100644
--- a/arch/arm64/kernel/relocate_kernel.S
+++ b/arch/arm64/kernel/relocate_kernel.S
@@ -122,10 +122,13 @@ ENDPROC(arm64_relocate_new_kernel)
 /* Ensure we didn't go past the limit */
 .org	KEXEC_CONTROL_PAGE_SIZE
 
+.pushsection ".rodata", "a"
 /*
  * arm64_relocate_new_kernel_size - Number of bytes to copy to the
  * control_code_page.
  */
 .globl arm64_relocate_new_kernel_size
+.align 8
 arm64_relocate_new_kernel_size:
 	.quad	.Lcopy_end - arm64_relocate_new_kernel
+.popsection
-- 
2.21.0


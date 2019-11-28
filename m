Return-Path: <SRS0=QHyQ=ZU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5201CC432C0
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Nov 2019 20:25:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 29C37216F4
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Nov 2019 20:25:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="A4FEa4wn"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726968AbfK1UZs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Nov 2019 15:25:48 -0500
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:27360 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726734AbfK1UZp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Nov 2019 15:25:45 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1574972744;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=41xNMejmkDpiENDKO7RxAxz9cPSeln8z2A1ifqUYAvQ=;
        b=A4FEa4wnQO9HoLDarqjdVRmY3PDV3ZOywcU262ZH2T/RQHnF1ukIr7W5ad8Oabb7uekQrm
        kpDMkXZDiKssxtPIUq0lpBd3UzBENhN0R2Zx4hMlFpzJCMLgPjM+my7fDrIaehmYDwymGW
        6M9xFEg5iLihEZ3Gv90BmkVZDA4KHz0=
Received: from mail-pf1-f200.google.com (mail-pf1-f200.google.com
 [209.85.210.200]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-238-en5Uz7yDNUam-1N3Hc5pcw-1; Thu, 28 Nov 2019 15:25:43 -0500
Received: by mail-pf1-f200.google.com with SMTP id b17so16710566pfb.8
        for <linux-kernel@vger.kernel.org>; Thu, 28 Nov 2019 12:25:42 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=TnU1CF4ydXp0Re/7xQPqByhi17OoIqWu96aUm7ilAL8=;
        b=bT5u8aisii303dxhPIVcNrUEmOBfgG76hIWgqTdYdNB+7zej2zA0KruEDTDhgk5MK8
         sAazQ4q0yNHA/wNN1nRVMwR1084nQvAdHdWAQj3NzI2l4XvydvtVtHxe4+NVnbgvDnzY
         ptHnTjmso1ycvPN8d5FU2m28FGmG/ib66zxmRLB7qOG9anRyFEsSFKq4jm11a3qjTo3X
         ZK+gjPVhM0zWun3H+fLJFMihuEbmFdtFxqnCnjJy6JdiYxq5DG42RKpCiye7+Wu/YbA6
         30x3+k6GhuMu26vp4/WOOoTXe/kLOujAyiEL7LVM3i4qoTjzJscRqVNTfcjvEMVv2z0/
         aZ0w==
X-Gm-Message-State: APjAAAVGRWgJdBk4ZsJIirPTbXZuL/5LUdA2mCuDnRFAvOpjI+bf6+Oo
        3EAWS+DGwd74G8XIS/P0jnj9ZGtKr5C2w5+ZSQP+TeFsGmjCYs3hedfaoizOL5a1gGM1iUgyVE0
        fyTf8Tae30ENjzJ4m8USmfAbO
X-Received: by 2002:a17:90a:3463:: with SMTP id o90mr14440650pjb.4.1574972741097;
        Thu, 28 Nov 2019 12:25:41 -0800 (PST)
X-Google-Smtp-Source: APXvYqw1994kyjpL8nA7jbNA2MDbvleaYMa6ZgrsQMiMtjPLDmyjZ21lIhTP8RXhXz67xc7yDAqxlg==
X-Received: by 2002:a17:90a:3463:: with SMTP id o90mr14440628pjb.4.1574972740900;
        Thu, 28 Nov 2019 12:25:40 -0800 (PST)
Received: from localhost ([122.177.85.74])
        by smtp.gmail.com with ESMTPSA id c184sm22569924pfc.159.2019.11.28.12.25.39
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 28 Nov 2019 12:25:40 -0800 (PST)
From:   Bhupesh Sharma <bhsharma@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     bhsharma@redhat.com, bhupesh.linux@gmail.com, x86@kernel.org,
        linuxppc-dev@lists.ozlabs.org,
        linux-arm-kernel@lists.infradead.org, linux-doc@vger.kernel.org,
        kexec@lists.infradead.org, James Morse <james.morse@arm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Will Deacon <will@kernel.org>,
        Steve Capper <steve.capper@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Dave Anderson <anderson@redhat.com>,
        Kazuhito Hagio <k-hagio@ab.jp.nec.com>
Subject: [PATCH v5 5/5] Documentation/vmcoreinfo: Add documentation for 'TCR_EL1.T1SZ'
Date:   Fri, 29 Nov 2019 01:55:16 +0530
Message-Id: <1574972716-25858-4-git-send-email-bhsharma@redhat.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1574972716-25858-1-git-send-email-bhsharma@redhat.com>
References: <1574972716-25858-1-git-send-email-bhsharma@redhat.com>
X-MC-Unique: en5Uz7yDNUam-1N3Hc5pcw-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add documentation for TCR_EL1.T1SZ variable being added to
vmcoreinfo.

It indicates the size offset of the memory region addressed by TTBR1_EL1
and hence can be used for determining the vabits_actual value.

Cc: James Morse <james.morse@arm.com>
Cc: Mark Rutland <mark.rutland@arm.com>
Cc: Will Deacon <will@kernel.org>
Cc: Steve Capper <steve.capper@arm.com>
Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: Ard Biesheuvel <ard.biesheuvel@linaro.org>
Cc: Dave Anderson <anderson@redhat.com>
Cc: Kazuhito Hagio <k-hagio@ab.jp.nec.com>
Cc: linux-arm-kernel@lists.infradead.org
Cc: linux-kernel@vger.kernel.org
Cc: kexec@lists.infradead.org
Signed-off-by: Bhupesh Sharma <bhsharma@redhat.com>
---
 Documentation/admin-guide/kdump/vmcoreinfo.rst | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/Documentation/admin-guide/kdump/vmcoreinfo.rst b/Documentation=
/admin-guide/kdump/vmcoreinfo.rst
index 447b64314f56..f9349f9d3345 100644
--- a/Documentation/admin-guide/kdump/vmcoreinfo.rst
+++ b/Documentation/admin-guide/kdump/vmcoreinfo.rst
@@ -398,6 +398,12 @@ KERNELOFFSET
 The kernel randomization offset. Used to compute the page offset. If
 KASLR is disabled, this value is zero.
=20
+TCR_EL1.T1SZ
+------------
+
+Indicates the size offset of the memory region addressed by TTBR1_EL1
+and hence can be used for determining the vabits_actual value.
+
 arm
 =3D=3D=3D
=20
--=20
2.7.4


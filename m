Return-Path: <SRS0=nTU8=ZV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5C5F9C432C0
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Nov 2019 20:00:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2CA4F2176D
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Nov 2019 20:00:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="eSnlCUHm"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727239AbfK2T77 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 29 Nov 2019 14:59:59 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:22895 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727192AbfK2T74 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Nov 2019 14:59:56 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1575057595;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=41xNMejmkDpiENDKO7RxAxz9cPSeln8z2A1ifqUYAvQ=;
        b=eSnlCUHmkBomuF/vxFsJ0+fCjkEQ0dZln+XWIQioOtpWacn2lHXNopm44T+Zp6IhF/1uZ5
        SKX1UPhWtNKA23nqtG0/y3CkIh5ZYfBBVE2nj4S8zlR2vMUDOjftKJjQNHn90vXQqJlCIZ
        T1FnP0jJhdqecHf1/eVTI1Xq6iMMZPA=
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com
 [209.85.214.200]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-306-WSDX7vWTONSCkJVys4z3BQ-1; Fri, 29 Nov 2019 14:59:53 -0500
Received: by mail-pl1-f200.google.com with SMTP id p2so13209846plr.20
        for <linux-kernel@vger.kernel.org>; Fri, 29 Nov 2019 11:59:53 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=TnU1CF4ydXp0Re/7xQPqByhi17OoIqWu96aUm7ilAL8=;
        b=QNDrAVNuL8Z/aj5Qaq8nNncSRNKt9JHrKzta73AwrAlnKoaz864ONIrIBafvAMI9P4
         k2l2OJ9sq6V8t2aLdJ5yobsWLyQGjon9G/Sl6Km2fc+0GAjsjo/zWcnCtbHdP/xyRSZM
         xWlvT+KhiQLI9CO2y9IhfRtO2ue4tA2p3Vgl7VJRZnHNgMjTKu2cU/Nh4cTS/J265kZj
         l9g/BfaDFf6vBk0LFSKV1gwOMWkWoUDD5sO/DHkJDjUv4fDKe0J/SUJvr+ZCim/ojKZT
         I6uZJaVmB8Y3SFOWLqWst0BMeMi+dIOUiJR1b5PreDorXDR+77gX3IhOLAFHQ+ND8aaa
         wOUA==
X-Gm-Message-State: APjAAAUZJ8XSnvxMKNCY/6ubJPwXrQzAkyJrfW4x6VAq3eSUxl4nh/0I
        S8q5BOQj5BVN4nBzIrU9uw3Juec1QnlypUCNh4YXU+XWStFrn2HrYuihoYL9TsZ0WpQjolDCqTX
        OSuHZrbPaYvC3bYn0mykIGO9c
X-Received: by 2002:a17:90a:1a8a:: with SMTP id p10mr19841457pjp.6.1575057592018;
        Fri, 29 Nov 2019 11:59:52 -0800 (PST)
X-Google-Smtp-Source: APXvYqxSY3AQtQ2n98lr5W53/GVJZRJxpVnInAVeYWNmyeuMXseeTDPCBIIN9JR01+Ft/5q0+acg9Q==
X-Received: by 2002:a17:90a:1a8a:: with SMTP id p10mr19841443pjp.6.1575057591861;
        Fri, 29 Nov 2019 11:59:51 -0800 (PST)
Received: from localhost ([122.177.85.74])
        by smtp.gmail.com with ESMTPSA id v10sm23928968pgr.37.2019.11.29.11.59.50
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 29 Nov 2019 11:59:51 -0800 (PST)
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
Subject: [RESEND PATCH v5 5/5] Documentation/vmcoreinfo: Add documentation for 'TCR_EL1.T1SZ'
Date:   Sat, 30 Nov 2019 01:29:19 +0530
Message-Id: <1575057559-25496-6-git-send-email-bhsharma@redhat.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1575057559-25496-1-git-send-email-bhsharma@redhat.com>
References: <1575057559-25496-1-git-send-email-bhsharma@redhat.com>
X-MC-Unique: WSDX7vWTONSCkJVys4z3BQ-1
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


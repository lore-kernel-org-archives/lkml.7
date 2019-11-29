Return-Path: <SRS0=nTU8=ZV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 76718C432C3
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Nov 2019 19:59:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4ADE22176D
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Nov 2019 19:59:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Nuz9PtJB"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727219AbfK2T7z (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 29 Nov 2019 14:59:55 -0500
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:28236 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727192AbfK2T7w (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Nov 2019 14:59:52 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1575057591;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=yNq9Cl1u8a4Res9gMqZVglO/lwiENzme0qL73M9MY10=;
        b=Nuz9PtJBk8cMdRpdLhT5f54Svl2GW3tb2FeXS4CLEbVmXoIZP/kimp4C/RJe8VP/OVyz4j
        lSmjrYcTmTVEJlJtgZJZFVWJitOhDOIWEjgPt6CZYXmzfasL1ku+l62AflXt8kerQ0VGhO
        JqdV58Gfvp2lECw9VASy60R96W9Y5W8=
Received: from mail-pg1-f198.google.com (mail-pg1-f198.google.com
 [209.85.215.198]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-295-QmHqfl3gMs-5F3OortSUEg-1; Fri, 29 Nov 2019 14:59:49 -0500
Received: by mail-pg1-f198.google.com with SMTP id m13so17076853pgk.12
        for <linux-kernel@vger.kernel.org>; Fri, 29 Nov 2019 11:59:49 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=EGXp9xk2iujKm5hWzUI7x5fii/ZV0bMMwslmLu+YaOk=;
        b=UY9Tv0X65MqpjKfHdwPVO5GgFszHnq+kKNnr963kFJSHywe1k99xVuB960sTzk/ogp
         KEWaLAmnD4NWBignnaAGQp2uiBXhUjR0ubuKEqCOKWcc0btSM6+Vl/ubylPpn3t50coX
         TZ2TbAkjeAtHzIcHXoLubGXjSFS+G2ymxOhR1YUtWplFSGb2tHbj+3CMIyATvPQrWJ1D
         A5vdEuWOTWHJg+AwfPBlQY6KHbk10F4Cb3iw//JkdWR9QKqoW9qtPVeuw2FC4Ndh+pKO
         5cOuo/n9zLpSjNJ92y33NGn3yJkqRJBqD+OPvxdHxY8W41KteOgQc3tOZdcED3Nyc3we
         wxlA==
X-Gm-Message-State: APjAAAVE0nCmzfwuW1GBjv3MAEVEabmYNT5d9IwcZPfR05wHxBDm/KMu
        j851ixXbVzXOxu6X1ycae16yNszHM63MBikRKgeX1EMFgQ3w+oRSd5eJ7gBC9+SEd4cYy9T9Pqc
        glDIF02WQcfPqbWdLdZVDmJiG
X-Received: by 2002:a17:90a:dc81:: with SMTP id j1mr3729530pjv.29.1575057588119;
        Fri, 29 Nov 2019 11:59:48 -0800 (PST)
X-Google-Smtp-Source: APXvYqxPVcE/XW8sUFbfhtiOj/O3Z62tRbLgdRo5GLkRP1HykyImTD8scVfMGcKn/WmLBQBtuJQ40Q==
X-Received: by 2002:a17:90a:dc81:: with SMTP id j1mr3729508pjv.29.1575057587944;
        Fri, 29 Nov 2019 11:59:47 -0800 (PST)
Received: from localhost ([122.177.85.74])
        by smtp.gmail.com with ESMTPSA id 67sm15725516pfw.82.2019.11.29.11.59.46
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 29 Nov 2019 11:59:47 -0800 (PST)
From:   Bhupesh Sharma <bhsharma@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     bhsharma@redhat.com, bhupesh.linux@gmail.com, x86@kernel.org,
        linuxppc-dev@lists.ozlabs.org,
        linux-arm-kernel@lists.infradead.org, linux-doc@vger.kernel.org,
        kexec@lists.infradead.org, Boris Petkov <bp@alien8.de>,
        Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        James Morse <james.morse@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Paul Mackerras <paulus@samba.org>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Dave Anderson <anderson@redhat.com>,
        Kazuhito Hagio <k-hagio@ab.jp.nec.com>
Subject: [RESEND PATCH v5 4/5] Documentation/vmcoreinfo: Add documentation for 'MAX_PHYSMEM_BITS'
Date:   Sat, 30 Nov 2019 01:29:18 +0530
Message-Id: <1575057559-25496-5-git-send-email-bhsharma@redhat.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1575057559-25496-1-git-send-email-bhsharma@redhat.com>
References: <1575057559-25496-1-git-send-email-bhsharma@redhat.com>
X-MC-Unique: QmHqfl3gMs-5F3OortSUEg-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add documentation for 'MAX_PHYSMEM_BITS' variable being added to
vmcoreinfo.

'MAX_PHYSMEM_BITS' defines the maximum supported physical address
space memory.

Cc: Boris Petkov <bp@alien8.de>
Cc: Ingo Molnar <mingo@kernel.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: James Morse <james.morse@arm.com>
Cc: Will Deacon <will.deacon@arm.com>
Cc: Michael Ellerman <mpe@ellerman.id.au>
Cc: Paul Mackerras <paulus@samba.org>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Dave Anderson <anderson@redhat.com>
Cc: Kazuhito Hagio <k-hagio@ab.jp.nec.com>
Cc: x86@kernel.org
Cc: linuxppc-dev@lists.ozlabs.org
Cc: linux-arm-kernel@lists.infradead.org
Cc: linux-kernel@vger.kernel.org
Cc: kexec@lists.infradead.org
Signed-off-by: Bhupesh Sharma <bhsharma@redhat.com>
---
 Documentation/admin-guide/kdump/vmcoreinfo.rst | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/Documentation/admin-guide/kdump/vmcoreinfo.rst b/Documentation=
/admin-guide/kdump/vmcoreinfo.rst
index 007a6b86e0ee..447b64314f56 100644
--- a/Documentation/admin-guide/kdump/vmcoreinfo.rst
+++ b/Documentation/admin-guide/kdump/vmcoreinfo.rst
@@ -93,6 +93,11 @@ It exists in the sparse memory mapping model, and it is =
also somewhat
 similar to the mem_map variable, both of them are used to translate an
 address.
=20
+MAX_PHYSMEM_BITS
+----------------
+
+Defines the maximum supported physical address space memory.
+
 page
 ----
=20
--=20
2.7.4


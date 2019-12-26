Return-Path: <SRS0=rArk=2Q=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AD0E8C2D0DA
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Dec 2019 11:20:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6C3DC2075E
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Dec 2019 11:20:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RmvBPu3w"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726460AbfLZLUQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 26 Dec 2019 06:20:16 -0500
Received: from mail-pg1-f194.google.com ([209.85.215.194]:43824 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726060AbfLZLUQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Dec 2019 06:20:16 -0500
Received: by mail-pg1-f194.google.com with SMTP id k197so12722446pga.10
        for <linux-kernel@vger.kernel.org>; Thu, 26 Dec 2019 03:20:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=BxoupZSMRE2DTDjIRAiiuu/ngeO3LqFT1wbUZB1u1O0=;
        b=RmvBPu3wJeWRD3ZmdU+EZfuo3fqe8Cb6PAid3nfuvKc9a+CErELWWL6C06dN2kzP/c
         CORU+U62Pynun1srO7BpBbgIzFqWnkY6gTXne/zAmqONUIzxAx5Jb2y8G0arNtGyr6vp
         nT3uhU7OtUjWc1iOhxe1k/U8MpeTC1in+fXa+aMl99bLeKXm0DB5En0dgg8QYZAieeuC
         2f3IJZEyLVqyPEMNBCjjQkzECUtwNBSL9sVJiC039hRg5ygNrC/ykqrXMH0eO4DrGbzH
         WhrmICIih2SU5KbBu/SFvYrI9sapyHFQXq9Quogb4XGoLnBV4mvB5z/6OtFeWnTdnNDA
         /Cdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=BxoupZSMRE2DTDjIRAiiuu/ngeO3LqFT1wbUZB1u1O0=;
        b=o3hO/rUPBzxu+u3XWshQVwwElQjeuFDA2R4XS0LfaOduZGf0erRvvFKqng3FqHlBLL
         oZT4tKdI/l1BY5QvLvqIBFzQdR5P3w/Rgqx7cp3Ib7TOR6wMetcwtZTU7z0kf5AmFSGm
         nbGFxZlwVAXCJb8aR2aysTPzJUpWxCPTWVehtzi3ahMlRbqm4ol/pc/LYJCpYkrBs4UQ
         AOlf/1JMVU2dy34uwxF7tFgE6rKHqMEEP+aSs4Diead5nYe8UGNwTyiBzQvwuHmi9j6E
         4s+eRBnqEhUUd0HoMxNj5K0eUdztzwFrGwaWpfboQv+bFS2RHyRrpCgUBO2V8uc4n/RX
         44sw==
X-Gm-Message-State: APjAAAWcHnE1sONXfD5IbY1SpIUNn9MzKjyxripyMkYomYYby4CiAeE+
        V5uNQ2w9JqqAYjnJLHS+rqEKqoPuj/4=
X-Google-Smtp-Source: APXvYqzD2v97M+XKrvhHamZ3rO080DeZMZorsJSRgqsgwFxVmT+NumZtr7wsuIQwhA3wuVbacKaoTw==
X-Received: by 2002:aa7:9808:: with SMTP id e8mr48989949pfl.32.1577359215570;
        Thu, 26 Dec 2019 03:20:15 -0800 (PST)
Received: from kbp1-lhp-A00636.cisco.com ([195.238.92.77])
        by smtp.gmail.com with ESMTPSA id i3sm34384390pfo.72.2019.12.26.03.20.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Dec 2019 03:20:15 -0800 (PST)
From:   Vasyl Gomonovych <gomonovych@gmail.com>
To:     openembedded-core@lists.openembedded.org, zhe.he@windriver.com,
        ross.burton@intel.com, andrea.adami@gmail.com
Cc:     Vasyl Gomonovych <gomonovych@gmail.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH] kernel: Make symbol link to vmlinux.64 in boot directory
Date:   Thu, 26 Dec 2019 13:19:54 +0200
Message-Id: <20191226111955.8368-1-gomonovych@gmail.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Some mips 64 bit platforms use vmlinux.64 image name
Make a symbol link to vmlinux.64 in arch/mips/boot/
---
 meta/classes/kernel.bbclass | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/meta/classes/kernel.bbclass b/meta/classes/kernel.bbclass
index ebcb79a528..750988f4e5 100644
--- a/meta/classes/kernel.bbclass
+++ b/meta/classes/kernel.bbclass
@@ -613,6 +613,9 @@ do_kernel_link_images() {
 	if [ -f ../../../vmlinuz.bin ]; then
 		ln -sf ../../../vmlinuz.bin
 	fi
+	if [ -f ../../../vmlinux.64 ]; then
+		ln -sf ../../../vmlinux.64
+	fi
 }
 addtask kernel_link_images after do_compile before do_strip
 
-- 
2.17.1


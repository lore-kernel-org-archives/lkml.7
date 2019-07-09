Return-Path: <SRS0=gj9M=VG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 75B7AC73C56
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Jul 2019 20:08:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2DAF42073D
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Jul 2019 20:08:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=eng.ucsd.edu header.i=@eng.ucsd.edu header.b="UyQnBJrg"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729527AbfGIUIA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 9 Jul 2019 16:08:00 -0400
Received: from mail-lj1-f172.google.com ([209.85.208.172]:35498 "EHLO
        mail-lj1-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727056AbfGIUH7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Jul 2019 16:07:59 -0400
Received: by mail-lj1-f172.google.com with SMTP id x25so14068689ljh.2
        for <linux-kernel@vger.kernel.org>; Tue, 09 Jul 2019 13:07:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=eng.ucsd.edu; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=imDI6XxxZbigvuJVTg7Zj+c6lvO9znt1M4Q8D1sKZXo=;
        b=UyQnBJrg2cAj16RzjzbZzHAWdOR+Ik0hRx/UDekKrdx3I8/rCKb1RGSf7BpG9WYPMu
         aePdIBg3uZq+dCyjJfTUpQ9uxBeuni/tiM3KApmgxgqNNz7N2wtwEzvmsZQFyJIsprFO
         4V6tHX1eNaQH0oMZYX9YhVZtkLNnNdL20K9Og=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=imDI6XxxZbigvuJVTg7Zj+c6lvO9znt1M4Q8D1sKZXo=;
        b=QSSMTSk1agKzIyGdo4TiskfkzxzFyym+XbbPrrX95dtS2T0zbLZUozOhbXmC33UBod
         /oxMMnl9Us+m4JzYvGSE2qPAT/jZ9u8LRyFujqm0JOZvlfI6CbHwFs6eN7HjDySf6VXa
         g9APpxCZNBgwwNYmIu0N6Qyftg4vauCfJuPuQXISBRKSaptkw8ws/OJN9cf7wNAVlojS
         jHG3UzYMHuYrk7nxCV4xL2+ckQDSCGRcBOzP21FED+gjsCOzRE8KZCKEhNIz2QijDHev
         n64AaYkvsiZN2h28n4u4H4IiloorH+dzQc2HAzHjQVLPWHuVU1No5tCihQWiGqPD7pSz
         LEhg==
X-Gm-Message-State: APjAAAVjkwMxZWb8MNiCL5gJmOq0WsyfbBpRujyfJKOV29bHcWB05JB3
        2+FDgzDqoyIjgw2URcCzH25FoA==
X-Google-Smtp-Source: APXvYqzojMT6908igxcuCg5ITT3g+dP95o1YpF3NBiLE7whXqBhDa+bwmA72UPPk6prQjOFkHEKbWQ==
X-Received: by 2002:a2e:9b84:: with SMTP id z4mr14976693lji.75.1562702877715;
        Tue, 09 Jul 2019 13:07:57 -0700 (PDT)
Received: from luke-XPS-13.home (159-205-76-204.adsl.inetia.pl. [159.205.76.204])
        by smtp.gmail.com with ESMTPSA id f1sm4489ljk.86.2019.07.09.13.07.56
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Tue, 09 Jul 2019 13:07:57 -0700 (PDT)
From:   Luke Nowakowski-Krijger <lnowakow@eng.ucsd.edu>
X-Google-Original-From: Luke Nowakowski-Krijger <lnowakow@neg.ucsd.edu>
To:     linux-kernel-mentees@lists.linuxfoundation.org
Cc:     Luke Nowakowski-Krijger <lnowakow@eng.ucsd.edu>,
        pbonzini@redhat.com, rkrcmar@redhat.com, corbet@lwn.net,
        kvm@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 0/3] Documentation: virtual: convert .txt to .rst
Date:   Tue,  9 Jul 2019 13:07:18 -0700
Message-Id: <20190709200721.16991-1-lnowakow@neg.ucsd.edu>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Luke Nowakowski-Krijger <lnowakow@eng.ucsd.edu>

Converted a few documents in virtual and virtual/kvm to .rst format.
Also added toctree hooks wherever there were .rst files. Adding hooks to
the main doc tree should be in another patch series once there are more
files in the directory.

After confirming with the appropriate lists that all the
Documentation/virtual/* files are not obsolete I will continue
converting the rest of the .txt files to .rst.

Changes in v2: 
	Documentation: kvm: Convert cpuid.txt to .rst
	+ added updated Author email address
	+ changed table to simpler format
	- removed function bolding from v1
	Documentation: virtual: Add toctree hooks
	- Removed vcpu-request from hooks that was added in v1

Chanes in v1:
	Documentation: kvm: Convert cpuid.txt to .rst
	+ Converted doc to .rst format
	Documentation: virtual: Convert paravirt_ops.txt to .rst
	+ Converted doc to .rst format
	Documentation: virtual: Add toctree hooks
	+ Added index.rst file in virtual directory
	+ Added index.rst file in virtual/kvm directory


Luke Nowakowski-Krijger (3):
  Documentation: kvm: Convert cpuid.txt to .rst
  Documentation: virtual: Convert paravirt_ops.txt to .rst
  Documentation: virtual: Add toctree hooks

 Documentation/virtual/index.rst               | 18 ++++
 Documentation/virtual/kvm/cpuid.rst           | 99 +++++++++++++++++++
 Documentation/virtual/kvm/cpuid.txt           | 83 ----------------
 Documentation/virtual/kvm/index.rst           | 11 +++
 .../{paravirt_ops.txt => paravirt_ops.rst}    | 19 ++--
 5 files changed, 139 insertions(+), 91 deletions(-)
 create mode 100644 Documentation/virtual/index.rst
 create mode 100644 Documentation/virtual/kvm/cpuid.rst
 delete mode 100644 Documentation/virtual/kvm/cpuid.txt
 create mode 100644 Documentation/virtual/kvm/index.rst
 rename Documentation/virtual/{paravirt_ops.txt => paravirt_ops.rst} (65%)

-- 
2.20.1


Return-Path: <SRS0=CMjL=VD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 109CEC48BD5
	for <linux-kernel@archiver.kernel.org>; Sat,  6 Jul 2019 21:38:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C2F1020838
	for <linux-kernel@archiver.kernel.org>; Sat,  6 Jul 2019 21:38:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=eng.ucsd.edu header.i=@eng.ucsd.edu header.b="gcNScJKA"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726992AbfGFVik (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 6 Jul 2019 17:38:40 -0400
Received: from mail-lf1-f53.google.com ([209.85.167.53]:45677 "EHLO
        mail-lf1-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726731AbfGFVik (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 6 Jul 2019 17:38:40 -0400
Received: by mail-lf1-f53.google.com with SMTP id u10so8382382lfm.12
        for <linux-kernel@vger.kernel.org>; Sat, 06 Jul 2019 14:38:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=eng.ucsd.edu; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=klb+7J069cJ1+W8hoxNmMJE/f3+e7sMU5jQjfpO6ZKA=;
        b=gcNScJKAmpy1kf8vVcMzN+g1N9MS6ViUZVLp5nOG/S28mbRuaiwE0Uf6o3frgKibOB
         v8swGHCOOVm5EdfB6Upb1A21DDOHapT3yw2xMYFr1tpLDFuBO70BnCV47hV7jb+Tvry2
         8oqpD1UGNgUMKeAl+KHGVDlRN2er2rqQqR/5Q=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=klb+7J069cJ1+W8hoxNmMJE/f3+e7sMU5jQjfpO6ZKA=;
        b=ppJUMIVfP4z3jLO0Mqu7+aSQ6A5EvgBT+tWlB4dLawARqApDP2zmXM0ODPv6xVo9Jc
         sxQi8K24Q7W+Jpca6PxidfkpeCn+s4ud294FMTBVmY0iNyU9bTOON0OUDfP+pv/fQwAo
         T8IT19b/W9DEF0wr9n7Ha3XpXRAHiKVcx50XlUqKrSucxYe9P8err6LgDTnSTWvj/den
         2FwBTSLEYu/KX5gIGo9kMlfypBfX6UsMzd2wfWUyKCql0HQKaTOz5GHvhF/sIJoBUlv8
         IB/1ymIuEGIJ3Htr/41uQsdGI1Wx2Kbt9KUOvyMy+3afn2FsAR1nLfTxGFPPZid1PolZ
         29VQ==
X-Gm-Message-State: APjAAAXK9W8UTTnUgd0XfDtINSjKIMp1toXM2LqUHbmwh7ttYL0K/z3g
        2yIWZelj5diQ/mcHnZVFYaBPmQ==
X-Google-Smtp-Source: APXvYqwRcsj1CJEmIMUMPbBTnuoCBgtBVHN4Fk94h3PaTJLuEU3Zn3Xy7JrHphpeqZ2n3ekNC1yvSw==
X-Received: by 2002:a19:ccc6:: with SMTP id c189mr4895103lfg.160.1562449117840;
        Sat, 06 Jul 2019 14:38:37 -0700 (PDT)
Received: from luke-XPS-13.home (77-255-206-190.adsl.inetia.pl. [77.255.206.190])
        by smtp.gmail.com with ESMTPSA id j3sm1322449lfp.34.2019.07.06.14.38.34
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Sat, 06 Jul 2019 14:38:36 -0700 (PDT)
From:   Luke Nowakowski-Krijger <lnowakow@eng.ucsd.edu>
X-Google-Original-From: Luke Nowakowski-Krijger <lnowakow@neg.ucsd.edu>
To:     linux-kernel-mentees@lists.linuxfoundation.org
Cc:     Luke Nowakowski-Krijger <lnowakow@eng.ucsd.edu>,
        pbonzini@redhat.com, rkrcmar@redhat.com, corbet@lwn.net,
        kvm@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 0/3] [PATCH 0/3] Documentation: virtual: convert files from .txt to
Date:   Sat,  6 Jul 2019 14:38:12 -0700
Message-Id: <cover.1562448500.git.lnowakow@eng.ucsd.edu>
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

Luke Nowakowski-Krijger (3):
  Documentation: virtual: Add toctree hooks
  Documentation: kvm: Convert cpuid.txt to .rst
  Documentation: virtual: Convert paravirt_ops.txt to .rst

 Documentation/virtual/index.rst               | 18 ++++
 Documentation/virtual/kvm/cpuid.rst           | 99 +++++++++++++++++++
 Documentation/virtual/kvm/cpuid.txt           | 83 ----------------
 Documentation/virtual/kvm/index.rst           | 12 +++
 .../{paravirt_ops.txt => paravirt_ops.rst}    | 19 ++--
 5 files changed, 140 insertions(+), 91 deletions(-)
 create mode 100644 Documentation/virtual/index.rst
 create mode 100644 Documentation/virtual/kvm/cpuid.rst
 delete mode 100644 Documentation/virtual/kvm/cpuid.txt
 create mode 100644 Documentation/virtual/kvm/index.rst
 rename Documentation/virtual/{paravirt_ops.txt => paravirt_ops.rst} (65%)

-- 
2.20.1


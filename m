Return-Path: <SRS0=zem1=X3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E29F0C352AA
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Oct 2019 11:46:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AE3C121929
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Oct 2019 11:46:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="G43M5ZYc"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727416AbfJBLqT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 2 Oct 2019 07:46:19 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:27468 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727341AbfJBLqT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Oct 2019 07:46:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1570016778;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=762mtTpnCQsyhb18P9hGkjh9Mayz7zJWnTgeQV9YN0s=;
        b=G43M5ZYcBdeAe3QImo1w/6r+eE5lare8icEoOG+KeyndocI4Dist/Hz/AP7TkDdnfDzNRE
        Ce00Bv9yC15DKtniea22PuVT+VTiR8H/xCi1UB59BOKnrB/T/UN97UuSnf1Ihb878gszzJ
        u8eEwUI/+u09ZnC32io245HXa2W+iGM=
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-207-SE_rAm5SN1-S_ijla2eTNQ-1; Wed, 02 Oct 2019 07:46:14 -0400
Received: by mail-qk1-f197.google.com with SMTP id z128so17992071qke.8
        for <linux-kernel@vger.kernel.org>; Wed, 02 Oct 2019 04:46:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=iPnrtxcMFYT2pK/VNRGmKzTUq5c6yp/d1Koj5uCJ6Ak=;
        b=ksJVyQivZxBaZYQqNAa8ViwHHBgdF5qmHqpExXiBMjf6wy9+v6+K9FtWGcC8NprbTr
         U6PR//YYV9NukZwW7Qm/9Ps8f1XaQF/Tt6KTa2N37BDxJ89+Vf6xEp3CMAXA4mmOwg77
         9LNme5kwWppp3WFkk7+PBb4+B9SRQI2t3IqFEfGOjJ7QV3nXoAPjTyckqKTR5d6h4A/A
         nr6aKgB2Ibqs5oZw74SJUef+KgfnpUJ1kLdKQGVKUtstVfXt/QLmA8HQJi0YRMs/31RK
         JsdHnTFlipL3d3tZsg+49cRdWGnZsDfounCDShh+Rbn5kJ4t7nW247EHWlhDoVmRFcHG
         DIOA==
X-Gm-Message-State: APjAAAWfmeWQ5Y0umN5HAd4X5qoHXjPs8uPa/TNTEcVHJZK8/LSdzn1S
        B/j/bOjzxSuqKJybYYVMoOIe7XixMB0EfuyDGkzeFuNH5IHMxKNTBd7LlKFvoPggxDichFVRGCN
        fNfqAB8azLxiBRFdY9LQ8O3tl
X-Received: by 2002:ac8:36b0:: with SMTP id a45mr3492050qtc.105.1570016773078;
        Wed, 02 Oct 2019 04:46:13 -0700 (PDT)
X-Google-Smtp-Source: APXvYqxfz6C44SmKvHKMSK3sJ3WQjDsSK0uX8wFh9gkKYrWpvYVM6iNjfTJfY398ByzvL7rOZ4A8DQ==
X-Received: by 2002:ac8:36b0:: with SMTP id a45mr3492029qtc.105.1570016772829;
        Wed, 02 Oct 2019 04:46:12 -0700 (PDT)
Received: from localhost (nat-pool-brq-t.redhat.com. [213.175.37.10])
        by smtp.gmail.com with ESMTPSA id 199sm9279435qkk.112.2019.10.02.04.46.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Oct 2019 04:46:11 -0700 (PDT)
From:   Oleksandr Natalenko <oleksandr@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     linux-doc@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Ingo Molnar <mingo@kernel.org>,
        Heiko Carstens <heiko.carstens@de.ibm.com>,
        Thorsten Leemhuis <linux@leemhuis.info>,
        Quentin Perret <qperret@qperret.net>
Subject: [PATCH] docs: admin-guide: fix printk_ratelimit explanation
Date:   Wed,  2 Oct 2019 13:46:10 +0200
Message-Id: <20191002114610.5773-1-oleksandr@redhat.com>
X-Mailer: git-send-email 2.23.0
MIME-Version: 1.0
X-MC-Unique: SE_rAm5SN1-S_ijla2eTNQ-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=WINDOWS-1252
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The printk_ratelimit value accepts seconds, not jiffies (though it is
converted into jiffies internally). Update documentation to reflect
this.

Also, remove the statement about allowing 1 message in 5 seconds since
bursts up to 10 messages are allowed by default.

Finally, while we are here, mention default value for
printk_ratelimit_burst too.

Signed-off-by: Oleksandr Natalenko <oleksandr@redhat.com>
---
 Documentation/admin-guide/sysctl/kernel.rst | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/Documentation/admin-guide/sysctl/kernel.rst b/Documentation/ad=
min-guide/sysctl/kernel.rst
index 032c7cd3cede..6e0da29e55f1 100644
--- a/Documentation/admin-guide/sysctl/kernel.rst
+++ b/Documentation/admin-guide/sysctl/kernel.rst
@@ -831,8 +831,8 @@ printk_ratelimit:
 =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
=20
 Some warning messages are rate limited. printk_ratelimit specifies
-the minimum length of time between these messages (in jiffies), by
-default we allow one every 5 seconds.
+the minimum length of time between these messages (in seconds).
+The default value is 5 seconds.
=20
 A value of 0 will disable rate limiting.
=20
@@ -845,6 +845,8 @@ seconds, we do allow a burst of messages to pass throug=
h.
 printk_ratelimit_burst specifies the number of messages we can
 send before ratelimiting kicks in.
=20
+The default value is 10 messages.
+
=20
 printk_devkmsg:
 =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--=20
2.23.0


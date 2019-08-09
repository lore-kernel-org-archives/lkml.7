Return-Path: <SRS0=0SVE=WF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 38DDCC433FF
	for <linux-kernel@archiver.kernel.org>; Fri,  9 Aug 2019 07:19:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 00FCF208C4
	for <linux-kernel@archiver.kernel.org>; Fri,  9 Aug 2019 07:19:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fZhSoo2X"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405745AbfHIHTX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 9 Aug 2019 03:19:23 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:38016 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2405664AbfHIHTW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Aug 2019 03:19:22 -0400
Received: by mail-wm1-f68.google.com with SMTP id m125so602670wmm.3;
        Fri, 09 Aug 2019 00:19:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id;
        bh=Vz75i2RTvhUJa5g/9yEomMKKQAza1FcKyAdc6BXdIz4=;
        b=fZhSoo2XgAJGnYA6RXKxk4XccYB41qWDwO4vKG5SPzL1nXWjkbLKgG2uFeCc+RGqVg
         mhA+oa47b3Ed2IckmD+yW7mtLuyPikQ9DU0oCykKzO986yOa+zguNyR+B+Oyzfpq6a9T
         fJ4TRjHNcPgfKcU51GuEj0u8q8h9BAyMFSPW6INMYczY1repivftEu3pH4ESGPi42Vna
         Eg/188GV3vJqjOL5b54dT88PnU5MdOZ+avjFdXbJlE/T1HFx5DR8+P3svAFV+gK0mN/f
         FS0SCEx6WxZW5Hy90DNjcKRbuyuifyZxmRI0Fs/YbeaJIQZxdZpkar2VKORU/kbQZfHC
         kj+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id;
        bh=Vz75i2RTvhUJa5g/9yEomMKKQAza1FcKyAdc6BXdIz4=;
        b=G/EiDw4Qa+yFmOkrpulzHAfcjRagjUmICAYfTbSyp9xDsS5X8TTkto9D1qHBuCVTvz
         y6IjdGJ+OoyXxC9kul40Gx4myvLra3fEbVSysinxEDxFap65yBUEAqz+62BdSBhFevoX
         svbxAx+T5mqcgLKi7fcoyp4tz9Q3+8Yo/61Z2O/FFebGP7VWFifQlzqxRJr+DwYKjXeH
         UZm5/FGOvUl3p0I7u3feuTKfR62EarF8IIKNhIQGBwYnRhkL8iGb/DwMASyCayA7GuI6
         3X0NJJg7j/lHUM3TmaoXFttfxm+OKt4W2ShSuxYtk4mT6dxuWU2/nzp+adZjb1/574Cj
         bywA==
X-Gm-Message-State: APjAAAURiWFBykifJ1f0hrtQjQVaLAqSrCR5Ba7HnRnbDKveoMoltqBQ
        N1GmoQtsHxVEMCVpw9HOTvUNdT40
X-Google-Smtp-Source: APXvYqwp+9XJ5xl3RIvMkHOPPPYbtfw6fOO//jyrZnMBeqMEUI2L5Nput20D3n5kUIOlj9sAQ4u13Q==
X-Received: by 2002:a1c:c706:: with SMTP id x6mr7402591wmf.104.1565335160191;
        Fri, 09 Aug 2019 00:19:20 -0700 (PDT)
Received: from 640k.localdomain.com ([93.56.166.5])
        by smtp.gmail.com with ESMTPSA id f10sm1503270wrm.31.2019.08.09.00.19.19
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 09 Aug 2019 00:19:19 -0700 (PDT)
From:   Paolo Bonzini <pbonzini@redhat.com>
To:     linux-kernel@vger.kernel.org, kvm@vger.kernel.org
Cc:     frankja@linux.ibm.com,
        Christian Borntraeger <borntraeger@de.ibm.com>
Subject: [PATCH] MAINTAINERS: change list for KVM/s390
Date:   Fri,  9 Aug 2019 09:19:16 +0200
Message-Id: <1565335156-28660-1-git-send-email-pbonzini@redhat.com>
X-Mailer: git-send-email 1.8.3.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

KVM/s390 does not have a list of its own, and linux-s390 is in the
loop anyway thanks to the generic arch/s390 match.  So use the generic
KVM list for s390 patches.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 MAINTAINERS | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 1aec93695040..6498ebaca2f6 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -8788,7 +8788,7 @@ M:	Christian Borntraeger <borntraeger@de.ibm.com>
 M:	Janosch Frank <frankja@linux.ibm.com>
 R:	David Hildenbrand <david@redhat.com>
 R:	Cornelia Huck <cohuck@redhat.com>
-L:	linux-s390@vger.kernel.org
+L:	kvm@vger.kernel.org
 W:	http://www.ibm.com/developerworks/linux/linux390/
 T:	git git://git.kernel.org/pub/scm/linux/kernel/git/kvms390/linux.git
 S:	Supported
-- 
1.8.3.1


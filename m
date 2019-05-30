Return-Path: <SRS0=Dgga=T6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9F0E0C28CC0
	for <linux-kernel@archiver.kernel.org>; Thu, 30 May 2019 01:10:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6E501243E0
	for <linux-kernel@archiver.kernel.org>; Thu, 30 May 2019 01:10:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kUVyJwmS"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727281AbfE3BKz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 May 2019 21:10:55 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:43482 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726527AbfE3BKz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 May 2019 21:10:55 -0400
Received: by mail-pg1-f193.google.com with SMTP id f25so922419pgv.10;
        Wed, 29 May 2019 18:10:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=9q3n6/Atan/BZx1c7DELwhCkfQhZCdsRzVyU+FH+w8E=;
        b=kUVyJwmSi9HfWvdvfbVdt5vH1mMxcA8Sio6yz3d2YqSTPgJCoxRQVYWakSZsk8/bnx
         klALrwxz3k9VRfeqFpqkdInMF3aI7iS4DATYpm3v1Aw0q1JQuw1jBcWfPXavpDDhVx7a
         GNq45ww6ueUZbKHuA071AMYqZsDCZ9XN7pttbpnTvOoiCQbKVME/DuOeCw9xqQPjLKpw
         rKtOICQFiygbSrO4z2qPaTwZH1bCIXpDjM0CyDo7qs9v3wqNODnQVjTRzTr+EqRZmAmZ
         UccWq2bDhqHydbAQrJ2b9RvTDuUQT3/z9F6xHMlj6gcKQUf0RYPxmQwhisf7xTMv4mEn
         fGwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=9q3n6/Atan/BZx1c7DELwhCkfQhZCdsRzVyU+FH+w8E=;
        b=cnH+WXRO+z1OIdKkwYTL1NHderVm92lfZMuoEJyevjyGSPwcUcxAZ0Hu1frzDI4Gre
         9c8Yn4xJfRna0uk8zCuXcwTYt4pBrmgm0xCI6smlTAe56WcDsby5SL/2HSToiEy382Cz
         x2yuk+lEc1xLKnheb3aNrkkOcMxcL4C+Rw1V2g/sR0HUeiuvMEnPiAyB1ks9N0mh7FIf
         Q5I6wJi4iQc1PdnAPhq6iXoAeXqBHeBQvnq4GNj9+GkrNxdrQDsRF+ck4UdD0ttiUSza
         DwVxO2NSuT+7Lg+z4mJswrYKWcPmKLm93va6lz/bRXge2p6reHbjwgNU1PSmqqlaVO4X
         ayWw==
X-Gm-Message-State: APjAAAX8BSHRJCPT9TYBwJvRyloFxnDQoLJbyVcio/88Kap90z7i/gVv
        wgo1zwyPkbnwtvujDUC5s1Q=
X-Google-Smtp-Source: APXvYqxt86dxGzN3ZWm9yu9CjEHxpW6lyXo6EdYMJskIILsFaDt25aud9T1smPRolla3NA18/q5zhw==
X-Received: by 2002:a65:6382:: with SMTP id h2mr990283pgv.355.1559178654745;
        Wed, 29 May 2019 18:10:54 -0700 (PDT)
Received: from zhanggen-UX430UQ ([66.42.35.75])
        by smtp.gmail.com with ESMTPSA id l8sm510250pgb.76.2019.05.29.18.10.42
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 29 May 2019 18:10:53 -0700 (PDT)
Date:   Thu, 30 May 2019 09:10:30 +0800
From:   Gen Zhang <blackgod016574@gmail.com>
To:     sathya.prakash@broadcom.com, chaitra.basappa@broadcom.com,
        jejb@linux.ibm.com, martin.petersen@oracle.com
Cc:     suganath-prabu.subramani@broadcom.com,
        MPT-FusionLinux.pdl@broadcom.com, linux-scsi@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] mpt3sas_ctl: fix double-fetch bug in _ctl_ioctl_main()
Message-ID: <20190530011030.GA6314@zhanggen-UX430UQ>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In _ctl_ioctl_main(), 'ioctl_header' is fetched the first time from 
userspace. 'ioctl_header.ioc_number' is then checked. The legal result 
is saved to 'ioc'. Then, in condition MPT3COMMAND, the whole struct is
fetched again from the userspace. Then _ctl_do_mpt_command() is called,
'ioc' and 'karg' as inputs.

However, a malicious user can change the 'ioc_number' between the two 
fetches, which will cause a potential security issues.  Moreover, a 
malicious user can provide a valid 'ioc_number' to pass the check in 
first fetch, and then modify it in the second fetch.

To fix this, we need to recheck the 'ioc_number' in the second fetch.

Signed-off-by: Gen Zhang <blackgod016574@gmail.com>
Ack-by: Suganath Prabu S <suganath-prabu.subramani@broadcom.com>
---
diff --git a/drivers/scsi/mpt3sas/mpt3sas_ctl.c b/drivers/scsi/mpt3sas/mpt3sas_ctl.c
index b2bb47c..5181c03 100644
--- a/drivers/scsi/mpt3sas/mpt3sas_ctl.c
+++ b/drivers/scsi/mpt3sas/mpt3sas_ctl.c
@@ -2319,6 +2319,10 @@ _ctl_ioctl_main(struct file *file, unsigned int cmd, void __user *arg,
 			break;
 		}
 
+		if (karg.hdr.ioc_number != ioctl_header.ioc_number) {
+			ret = -EINVAL;
+			break;
+		}
 		if (_IOC_SIZE(cmd) == sizeof(struct mpt3_ioctl_command)) {
 			uarg = arg;
 			ret = _ctl_do_mpt_command(ioc, karg, &uarg->mf);

Return-Path: <SRS0=8QAT=T3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 51851C282E3
	for <linux-kernel@archiver.kernel.org>; Mon, 27 May 2019 01:04:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1CF7B2075C
	for <linux-kernel@archiver.kernel.org>; Mon, 27 May 2019 01:04:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kmIxUgfb"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726106AbfE0BD7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 26 May 2019 21:03:59 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:42733 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725863AbfE0BD7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 26 May 2019 21:03:59 -0400
Received: by mail-pg1-f193.google.com with SMTP id 33so5136754pgv.9;
        Sun, 26 May 2019 18:03:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=XeFlFWw61JofilTs9ih/NQ02dCASKl1n6cWqz6/+ogs=;
        b=kmIxUgfbcXGdte3ABphF/qsvQiMkACCDe0wg1GW8GyR11bYBSO7I92dgg1vme/7qk6
         yFVENvySyu3QhE2j+qqtM/DxAmMjPclUmZV+ojRKPqT4YA6a4uz+IWEZqQTPtfM+U+Jv
         SOl2OVClT4+NxbCJp17XmWLLGKAUOnFCZ2AMTSvzn2kcNXS9+CnZ6z2T6eKQLl0Slmk9
         SwNXO2ovmyGBbIgcTBOS+ogJKSe1q6UapsRGsD2uYVASQiUDPW5VPyntaIKuRpyO9ESu
         eAJ5jheU5VTUMqbfJ/YSqSvPEpSO5/R+Nj790Mh6aTrQ550w6vPdnlXNE/zHXXT3zRRG
         m2eQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=XeFlFWw61JofilTs9ih/NQ02dCASKl1n6cWqz6/+ogs=;
        b=cFLCrjML9O1YIj+HIr1qACm9va2w2Cbb15wn+DIp7SXYSblgw+eHwSisgwSxxpt9+a
         LMY2VxbIfLATkxb4GeCXdFmWyFxoEzdUIr0MpgSYy7a+aC9Gdo+M2zuUL4IXL4GAjwkH
         ZgLTXgxjWGGJNBKed8T1J1kKZ0oz/wkwqqAs4M5mR2KivRTJ+ljehTS6RYnhw4XVjVCl
         8kUTECP5yWFTpUiyikyIAF0stDn8UNlNLuNRLdScQrzG6HKc56+NlJE8pfONYdMMR+8H
         lX2Olx3T0NeE+3FD+34o78fF8YLoyj4P+AsxBkczV6DXAbyCFNvW4Kw2xI6E7o4MG4nl
         8poA==
X-Gm-Message-State: APjAAAUntNGiU++HgW32a4qfBiDuuMcc6yKhjyif8pKXJ53oQi5U+iXU
        N2KxSuEgyxp+9S94HXva7co=
X-Google-Smtp-Source: APXvYqwcAH+bJJvvNEX8UjojepZ+SYlsK5QbsoQJwQfnzLjooS5Z4Nn1D+Cv9tqCIpMc+49kgDVmRg==
X-Received: by 2002:a17:90a:b00c:: with SMTP id x12mr27628236pjq.64.1558919038505;
        Sun, 26 May 2019 18:03:58 -0700 (PDT)
Received: from zhanggen-UX430UQ ([66.42.35.75])
        by smtp.gmail.com with ESMTPSA id l141sm10904953pfd.24.2019.05.26.18.03.50
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 26 May 2019 18:03:57 -0700 (PDT)
Date:   Mon, 27 May 2019 09:03:38 +0800
From:   Gen Zhang <blackgod016574@gmail.com>
To:     dgilbert@interlog.com, jejb@linux.ibm.com,
        martin.petersen@oracle.com
Cc:     linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] sg: fix a double-fetch bug in sg_write()
Message-ID: <20190527010338.GA17170@zhanggen-UX430UQ>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In sg_write(), the opcode of the command is fetched the first time from 
the userspace by __get_user(). Then the whole command, the opcode 
included, is fetched again from userspace by __copy_from_user(). 
However, a malicious user can change the opcode between the two fetches.
This can cause inconsistent data and potential errors as cmnd is used in
the following codes.

Thus we should check opcode between the two fetches to prevent this.

Signed-off-by: Gen Zhang <blackgod016574@gmail.com>
---
diff --git a/drivers/scsi/sg.c b/drivers/scsi/sg.c
index d3f1531..a2971b8 100644
--- a/drivers/scsi/sg.c
+++ b/drivers/scsi/sg.c
@@ -694,6 +694,8 @@ sg_write(struct file *filp, const char __user *buf, size_t count, loff_t * ppos)
 	hp->flags = input_size;	/* structure abuse ... */
 	hp->pack_id = old_hdr.pack_id;
 	hp->usr_ptr = NULL;
+	if (opcode != cmnd[0])
+		return -EINVAL;
 	if (__copy_from_user(cmnd, buf, cmd_size))
 		return -EFAULT;
 	/*
---

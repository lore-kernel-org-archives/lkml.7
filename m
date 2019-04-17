Return-Path: <SRS0=uTOJ=ST=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6ABBAC282DA
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Apr 2019 21:31:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2DA602183E
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Apr 2019 21:31:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="njlU1ILK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733302AbfDQVbz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Apr 2019 17:31:55 -0400
Received: from mail-wr1-f54.google.com ([209.85.221.54]:44760 "EHLO
        mail-wr1-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725848AbfDQVbz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Apr 2019 17:31:55 -0400
Received: by mail-wr1-f54.google.com with SMTP id w18so184686wrv.11
        for <linux-kernel@vger.kernel.org>; Wed, 17 Apr 2019 14:31:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=sYW8lwz4YkKdb66JKELKl8FrmGviUYgvoOuvSaDD9Kk=;
        b=njlU1ILKiYIQzfJ2I9kWI8kUgw1n/MNjml+x6V2Qmco0a26RASwolTf8iZ0Ea//gbc
         Wy+W4n/ZZT3c7lbKkh320nXyNoAH0zFlHcAjW0DZ9SW6CQbe6dupnhvvq91af0BNBnbd
         nREHyXoFJQJk5xCkEI6n01INGs2tygqEEp8XCLCn0e5X0BwcKMzRQdXrrC3KsWVBVVY8
         vjXMDSshWTl1QDSjZVgYnh75twcsXvZwrF9LZZrLu9cNX/I6jLolhP3Pu/sbF+ko9phK
         Swg2hpqz5TSquUn0KB61ptpCHL+1ypRRBfVKzWMJnfi9KgqBuPsHn5fIjA3Govn7/xm4
         B0Vw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=sYW8lwz4YkKdb66JKELKl8FrmGviUYgvoOuvSaDD9Kk=;
        b=uVmhzGed6LVe4ct5f8GDkccSm/laS4i5g5gG0/pSU4iRavErrGqgqQZ7VPbZKOkLm1
         m8HKb+MxbydEPNb7aNgg+i0QFPz2er7FBbRvtMkvP7iKr+zk/zC3kCMTu1vFUGgMzpfL
         SOSCLA18AcD61JBz8YFsNpN5dmMRfZB+ZCtrtXZWZzvRq/f1k/ky39q+1gCbLdKR7s3i
         tTbWQxyQsGyauO5XdRxrTGxoxs+KvDQyYrgME5nhkmPucN/9MNoAU3QpHtLtDZhEGu/F
         AI02kCnHCtTXLNFLk3gWvJSk+K2NUYKcooMFaRMgITAOT/pnNjbOSd0Tf92XkoHbGNZk
         A46w==
X-Gm-Message-State: APjAAAXNPGV7Yujbg7equ9NBwfP0qnJ6fgwGQmiANj5nV3rOTez4JWi+
        IYdedxd2itSn3Y3argr13Tcbxyw=
X-Google-Smtp-Source: APXvYqzVHnKwf21ESyAt9lwSkD1mlm1hm9xnfEnM4L+SnozNsh28dK4AhL3suOl3CHopDfS3SUUcyA==
X-Received: by 2002:adf:fec3:: with SMTP id q3mr59393229wrs.173.1555536713268;
        Wed, 17 Apr 2019 14:31:53 -0700 (PDT)
Received: from avx2 ([46.53.244.117])
        by smtp.gmail.com with ESMTPSA id l20sm74276wme.20.2019.04.17.14.31.51
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 17 Apr 2019 14:31:52 -0700 (PDT)
Date:   Thu, 18 Apr 2019 00:31:50 +0300
From:   Alexey Dobriyan <adobriyan@gmail.com>
To:     akpm@linux-foundation.org
Cc:     linux-kernel@vger.kernel.org
Subject: [PATCH] exec: move ->recursion_depth out of critical sections
Message-ID: <20190417213150.GA26474@avx2>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

->recursion_depth is changed only by current, therefore decrementing can be
done without taking any locks.

Signed-off-by: Alexey Dobriyan <adobriyan@gmail.com>
---

 fs/exec.c |    4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

--- a/fs/exec.c
+++ b/fs/exec.c
@@ -1652,11 +1652,13 @@ int search_binary_handler(struct linux_binprm *bprm)
 		if (!try_module_get(fmt->module))
 			continue;
 		read_unlock(&binfmt_lock);
+
 		bprm->recursion_depth++;
 		retval = fmt->load_binary(bprm);
+		bprm->recursion_depth--;
+
 		read_lock(&binfmt_lock);
 		put_binfmt(fmt);
-		bprm->recursion_depth--;
 		if (retval < 0 && !bprm->mm) {
 			/* we got to flush_old_exec() and failed after it */
 			read_unlock(&binfmt_lock);

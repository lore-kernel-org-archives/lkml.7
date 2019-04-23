Return-Path: <SRS0=LehB=SZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6BE5BC10F14
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Apr 2019 09:01:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3698E20843
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Apr 2019 09:01:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Hr88N8Lj"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726960AbfDWJBZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Apr 2019 05:01:25 -0400
Received: from mail-pl1-f194.google.com ([209.85.214.194]:36838 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725955AbfDWJBZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Apr 2019 05:01:25 -0400
Received: by mail-pl1-f194.google.com with SMTP id ck15so7203956plb.3
        for <linux-kernel@vger.kernel.org>; Tue, 23 Apr 2019 02:01:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=Dt3Mzn5HD8CZa/kd7tOM1C1AFgcQA+PcPjqbOCzO3EU=;
        b=Hr88N8LjuWgS2kEILcgX1PXYZbgVY1bt6wjOmw8cs8cM+bpdI+JKDFa85cL/jYkzHx
         UnT0+BTSj7Yw8D2zBiM8/7NkCJxKui4s+j21W383sXtUIMjNnBgEmNDls5CSYmEWsRy+
         EscKYzQgkZsu3jZbISg4v3YMl1fTDcSHquwXnMvhV+FBbLeMQnXZvsa5CCNAMv9FnKio
         4PR8v8i7LK3+MZpQAkYMw04/vZhUgqSkVta8S8zMIaTVgKMf7LrAsCf3Sa5aCezDacKX
         9kFJduOeA6Qacbo6EZVi88TmUfGX4kZJv20tCc+f/dQeVaCKPrxa1I0t3uAPwm3Z8gJe
         GSxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=Dt3Mzn5HD8CZa/kd7tOM1C1AFgcQA+PcPjqbOCzO3EU=;
        b=LTtOGLwH6ovcMYNBOcSsWD1W7P+xv7rKby1gy1GX5pIEsm9AlIwkH0VcszJcEPvdEH
         cWLAU1s6LPf+MiIwYHzQmXbi9jQOgEVfCjdJlV09RxI7EqFLA65AyGsECvOEdLJzpL/P
         IZsZAAHAwt8Yooc//ovEiRdXntnL233+8E3Nh+mD2M7MAGxS5CIhNX4SpBRnX8NLvUkN
         +/uM3hAyTASFcLKhXekRmaK9f32QQpaSsRbBGuIrOBiukAXQZjpiYwN/0V2i+mXp1I9t
         CMJvdopJwJsS5oYw4Z3GXx7rDsnf/6+S2HO/9G/HP4z23abDub+LbRQ98QIthZCeFL36
         EAqA==
X-Gm-Message-State: APjAAAUQ44h2tiDKvp5qP8crvzWGt9vuwSI3ALUSLihVPl9AByqZ2IMQ
        DaatPbWV8valabz56hEEAGc=
X-Google-Smtp-Source: APXvYqyARogfshyEPKNTiihWIb8n2dkU8H5phz6BWx/s2IIeRUiBkMKpUqy50xVPVz003sYUSFPBYA==
X-Received: by 2002:a17:902:1681:: with SMTP id h1mr24996733plh.102.1556010085030;
        Tue, 23 Apr 2019 02:01:25 -0700 (PDT)
Received: from bharath12345-Inspiron-5559 ([103.110.42.34])
        by smtp.gmail.com with ESMTPSA id b15sm28294921pgg.90.2019.04.23.02.01.22
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 23 Apr 2019 02:01:24 -0700 (PDT)
Date:   Tue, 23 Apr 2019 14:31:18 +0530
From:   Bharath Vedartham <linux.bhar@gmail.com>
To:     dushistov@mail.ru
Cc:     linux.bhar@gmail.com, linux-kernel@vger.kernel.org
Subject: [PATCH] fs/ufs: Force type conversion from __fs16 to u16
Message-ID: <20190423090118.GA465@bharath12345-Inspiron-5559>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch fixes the sparse warning:
warning: restricted __fs16 degrades to integer

inode->ui_u1.oldids.ui_suid is of type __fs16, a restricted integer.
0XFFFF is a 16 bit unsigned integer. Use __force to fix the sparse
warning.

Signed-off-by: Bharath Vedartham <linux.bhar@gmail.com>
---
 fs/ufs/util.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/fs/ufs/util.h b/fs/ufs/util.h
index 1fd3011..b03143f 100644
--- a/fs/ufs/util.h
+++ b/fs/ufs/util.h
@@ -195,7 +195,7 @@ ufs_get_inode_uid(struct super_block *sb, struct ufs_inode *inode)
 	case UFS_UID_44BSD:
 		return fs32_to_cpu(sb, inode->ui_u3.ui_44.ui_uid);
 	case UFS_UID_EFT:
-		if (inode->ui_u1.oldids.ui_suid == 0xFFFF)
+		if ((__force u16)inode->ui_u1.oldids.ui_suid == 0xFFFF)
 			return fs32_to_cpu(sb, inode->ui_u3.ui_sun.ui_uid);
 		/* Fall through */
 	default:
@@ -229,7 +229,7 @@ ufs_get_inode_gid(struct super_block *sb, struct ufs_inode *inode)
 	case UFS_UID_44BSD:
 		return fs32_to_cpu(sb, inode->ui_u3.ui_44.ui_gid);
 	case UFS_UID_EFT:
-		if (inode->ui_u1.oldids.ui_suid == 0xFFFF)
+		if ((__force u16)inode->ui_u1.oldids.ui_suid == 0xFFFF)
 			return fs32_to_cpu(sb, inode->ui_u3.ui_sun.ui_gid);
 		/* Fall through */
 	default:
-- 
2.7.4


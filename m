Return-Path: <SRS0=aq1k=VU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 02343C7618E
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jul 2019 11:48:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CF421218A0
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jul 2019 11:48:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IXZxYn9+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387521AbfGWLsv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Jul 2019 07:48:51 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:35090 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726575AbfGWLsv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Jul 2019 07:48:51 -0400
Received: by mail-wr1-f65.google.com with SMTP id y4so42863925wrm.2;
        Tue, 23 Jul 2019 04:48:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=fJgbCuAECmv3kfB4MA6EgJmQcyRpzLZ4WuJAsybRjN8=;
        b=IXZxYn9+ieSSYpeUvVY9HWV6aAp4pnGX23WWtA+twgbNwkKd0+xWFFIDsbwwF26qQX
         zV/RzGFEvQm5/Gh+Owh4JG5WCZE1biu3oviwFD6eEN8jho2ZOR2eG/QN1NwuwL47Js5i
         7snXOm/JLAphzo9tdC95e1KugwXNkGuoINV1IDTEVFTXCQSZUSOEtVbMvvXUEOEqnUlF
         GNEGbzitBtfJLKHDtX6Kd4+6LnQ7qPjeUynQ9/GJS1eAzOrRXY6RRaZsZSoV/CYIZl32
         +WNfe9hUGfa/rTllPuVMaBB6O6jRQsybv9arprjTRhA0+ZnqKg0DTqrTkjr6pNb/0wO2
         S9sQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=fJgbCuAECmv3kfB4MA6EgJmQcyRpzLZ4WuJAsybRjN8=;
        b=uHI06XAAMyKYLrks7hpAkO1ERaYBGf0t2iiCc7iZGLKgB2FJm69L4rxOyGsN2PP7jy
         nfm1N+Wc8z+xM16jpWZHZZ1noWeSS5AjeZf8eZWoaAQXdMmc+0sbIjXQtOvisvOqPopR
         SYiyd6iFDNhuP+92zjaTEPDAHyzvTxBr2aZbJUj3JTsR7bo6w5sKUBudenNj3zPRQDUk
         Ed6gjxxhau/5Yu4psU/bhT5fltP0olYTmlvMVZSeB7c8U5MnYANG1te2bASq+tX3T4Kg
         XyheKOLreAkvY9GwWZ53ihw+r7FRvYzkCjJFcsXngyHlQJxan+Cabt6XitVquFNP4Nsn
         Z23w==
X-Gm-Message-State: APjAAAVaADg9Hpa99qoQWLsizXIUqMAX3hkfKEJpDnvTQ3gtVqZbbt2U
        64U5v036UNzm415Ztcfj3fs=
X-Google-Smtp-Source: APXvYqxGFcsX+jy3UaXiECbiKtL2HyzZ/SRO1lDL026dTTt95dLrxJ5olHBLNWL0nrgT+rNx43T3fw==
X-Received: by 2002:a5d:6287:: with SMTP id k7mr31068920wru.108.1563882528872;
        Tue, 23 Jul 2019 04:48:48 -0700 (PDT)
Received: from localhost ([197.211.57.129])
        by smtp.gmail.com with ESMTPSA id g11sm42585476wru.24.2019.07.23.04.48.23
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Tue, 23 Jul 2019 04:48:47 -0700 (PDT)
Date:   Tue, 23 Jul 2019 12:48:13 +0100
From:   Sheriff Esseson <sheriffesseson@gmail.com>
To:     skhan@linuxfoundation.org
Cc:     linux-kernel-mentees@lists.linuxfoundation.org,
        "Darrick J. Wong" <darrick.wong@oracle.com>,
        linux-xfs@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>,
        "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>
Subject: [PATCH] Documentation: filesystem: fix "Removed Sysctls" table
Message-ID: <20190723114813.GA14870@localhost>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

the "Removed Sysctls" section is a table - bring it alive with ReST.

Signed-off-by: Sheriff Esseson <sheriffesseson@gmail.com>
---
 Documentation/admin-guide/xfs.rst | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/Documentation/admin-guide/xfs.rst b/Documentation/admin-guide/xfs.rst
index e76665a8f2f2..fb5b39f73059 100644
--- a/Documentation/admin-guide/xfs.rst
+++ b/Documentation/admin-guide/xfs.rst
@@ -337,11 +337,12 @@ None at present.
 Removed Sysctls
 ===============
 
+=============================	=======
   Name				Removed
-  ----				-------
+=============================	=======
   fs.xfs.xfsbufd_centisec	v4.0
   fs.xfs.age_buffer_centisecs	v4.0
-
+=============================	=======
 
 Error handling
 ==============
-- 
2.22.0


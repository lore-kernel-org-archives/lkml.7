Return-Path: <SRS0=Osat=YE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9CA4EC4360C
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Oct 2019 01:52:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 60B3B20B7C
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Oct 2019 01:52:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eE4slVkd"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727935AbfJKBwe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 10 Oct 2019 21:52:34 -0400
Received: from mail-pf1-f174.google.com ([209.85.210.174]:33224 "EHLO
        mail-pf1-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727588AbfJKBwd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Oct 2019 21:52:33 -0400
Received: by mail-pf1-f174.google.com with SMTP id q10so5097669pfl.0
        for <linux-kernel@vger.kernel.org>; Thu, 10 Oct 2019 18:52:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=0D9kDWFAtk322Iw2N8/OoCkWVljQqtRC6srP+BJypzs=;
        b=eE4slVkd/xAN7grlQNv6VFKdnXV965x+0gZEyh3+6J32wyYZA9pqFlaVRKIiOGYzYz
         uzyor5dTSo/pJbQW66TniwPjtbgv+znbv5Kz2oGyzS4OS0QbWQogqlWen76A50acddxL
         o4p2hfyi8La+uyMoJfXl8KwlCfgnIQyr/WEq0SHx3h0j1IqMywhHU2X/T5xv7LTaDYav
         MWjMcCpBdpbH8iXlJMRPHU4nWu47AUWdWw110ufN/K/1xmgMT3cJ3Mw46V60+dMKojXL
         lKg5yWq973OWE1Qay/Q0u7oOkyL6IiMkG5r43SEOvWxa59DKmkhNzjpP2g+4jaUIwRfT
         PGIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=0D9kDWFAtk322Iw2N8/OoCkWVljQqtRC6srP+BJypzs=;
        b=Rl5Fygb8vzN1Y3wkGDI+3HEGRMAp7tVc1d4l+daH8j5RLzh6ILoN/wtCbmX3Yv5eMX
         ShlsQhLdYc7eyHMCQVV/uSh+GXiyTWt/2qC/xi85pC4pg8rGZCve7O4VoO1XPixtb0c7
         ZXxJtESvdjk9KutbiEzpc5oJvxI/fRIcviaD5kGRhjZHlpxdFE2G8b8Tm3RmuEF+CXR1
         lkF/Wdcrpiu+vqBU1d0XITt/O9ZQydFbZ9rdrm0k22Xen4QvkIKxgGbfTjNbJWfFdT/2
         dR90R17XqsRUAn3Og1YRf6c3qRfRKbliykz50zaVccVe0TGZLWZqwpRRrX34g1TApxxq
         zVBw==
X-Gm-Message-State: APjAAAVauTn/ITzp89AmAtK/BQHbrcImvxNoNl47y+S30qMaBWAC0CdN
        pq+BScc/zdhywmGauPsX/Mk=
X-Google-Smtp-Source: APXvYqx+f96q8bbjm6dXM/ccAZXPMzs79WLm1idu7rjvEuI9g4C3aQA5JGqpUbiJO6Od8lbwxrrRaw==
X-Received: by 2002:a62:ee01:: with SMTP id e1mr13956221pfi.3.1570758751626;
        Thu, 10 Oct 2019 18:52:31 -0700 (PDT)
Received: from localhost ([2001:e60:3034:6131:3055:27ff:fe5a:5b5c])
        by smtp.gmail.com with ESMTPSA id h1sm6546486pfk.124.2019.10.10.18.52.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Oct 2019 18:52:30 -0700 (PDT)
Date:   Fri, 11 Oct 2019 10:52:25 +0900
From:   Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>
To:     Joe Perches <joe@perches.com>
Cc:     Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        linux-kernel@vger.kernel.org
Subject: checkpatch: comparisons with a constant on the left
Message-ID: <20191011015225.GA27495@jagdpanzerIV>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.12.2 (2019-09-21)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Joe,

I noticed that this code

	#if LINUX_VERSION_CODE >= KERNEL_VERSION(4, 18, 0)

triggers checkpatch's warning:

	"WARNING: Comparisons should place the constant on
		  the right side of the test"

Both LINUX_VERSION_CODE and KERNEL_VERSION are constants, so
I'm wondering if it's worth it to improve that check a tiny
bit.

E.g. something utterly trivial:

---
diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
index cf7543a9d1b2..8a1964c3d9a5 100755
--- a/scripts/checkpatch.pl
+++ b/scripts/checkpatch.pl
@@ -4855,6 +4855,7 @@ sub process {
 			my $to = $4;
 			my $newcomp = $comp;
 			if ($lead !~ /(?:$Operators|\.)\s*$/ &&
+			    $to !~ /^KERNEL_VERSION.*/ &&
 			    $to !~ /^(?:Constant|[A-Z_][A-Z0-9_]*)$/ &&
 			    WARN("CONSTANT_COMPARISON",
 				 "Comparisons should place the constant on the right side of the test\n" . $herecurr) &&
---

I'm sure you'll have a better idea.

	-ss

Return-Path: <SRS0=xpJL=2P=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 43B40C2D0D2
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Dec 2019 00:07:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1A5F9206CB
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Dec 2019 00:07:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=generalsoftwareinc-com.20150623.gappssmtp.com header.i=@generalsoftwareinc-com.20150623.gappssmtp.com header.b="nuhXrToY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726920AbfLYAHA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 24 Dec 2019 19:07:00 -0500
Received: from mail-vs1-f68.google.com ([209.85.217.68]:43223 "EHLO
        mail-vs1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726322AbfLYAHA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Dec 2019 19:07:00 -0500
Received: by mail-vs1-f68.google.com with SMTP id s16so11690635vsc.10
        for <linux-kernel@vger.kernel.org>; Tue, 24 Dec 2019 16:06:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=generalsoftwareinc-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=4E/2wqIKz28ubvLgIUjPVPO4AakvBg1lZqS8m4r8eSs=;
        b=nuhXrToYH2l1mEXzplPPqfL6jwJrwy9KF80nJRH5RWc4AU31fHL/OGAHHUR/NHNM3w
         J3r9UTPegPr47BrebbAJlRXOKMkdvuk0EmPKAnUrCprtSuvFLpjaw6wvdR9o3k+K2Zc5
         1lvFoV84SnxPC1O7qr8i8ze4i195NU92/OUxvIxK2uB6CN7r+6hw1/53IVVt6h2X/lbx
         Xpl9OHwhvtGjWg0kXKA5ORBfc1EOK1SaWg8LBA21yLABF8Hc+xgxUaDNdSD14x26HoBM
         lJcGkTrA3DoW4veW18jEr9IT7TkXHaSzLQBEjdrnIMTRHQ11aqhZkqPpGSEeeQnIOg43
         +1bQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=4E/2wqIKz28ubvLgIUjPVPO4AakvBg1lZqS8m4r8eSs=;
        b=lHtaumcq3EEoYpG4TRSJSDtImOoJ+Npz6CSkYC8+qwxpbj13TKT24Eb0jk9c/rmyiQ
         hRTFIepXGkuYtA1xPbQPJuAza5TeOWir0DWSyWMTDJ/BS3dIPzIjITqxltGIWrIx5kfp
         IHA7Z/mI1Fbkkq7tFiFpvQqtVFOeSf8LZD9BzGCTfc7EF/WogXZKd8qt/vnyLi/o12Hm
         VVntYfb1H0isY6QXJxasYCWYilI2qqsJDa1x033Uq18381mfmJbpxGtOCm++LRDKEWXJ
         +XVcGSs7Bk8XU6A5tfLJ2CaHpFbczNwtW1h/7VjIiTghsgkhNqkshkCYWQ5Wh9sh7R7N
         mR7A==
X-Gm-Message-State: APjAAAUKXnWWeQqZ+FjSZRDKQ915vJteOIiTB19i7QHcLyA2qu1ejXFi
        NhBPnSqWewOeNovCFT3RtNFDsA==
X-Google-Smtp-Source: APXvYqxgrDJsBlsG+ACW6Z1O/nWXxOCl2c1kv0M06tZGE8UbMCYqsjLof1+9MoxDj8wgV636kHbmpg==
X-Received: by 2002:a67:6282:: with SMTP id w124mr17314621vsb.191.1577232418899;
        Tue, 24 Dec 2019 16:06:58 -0800 (PST)
Received: from frank-laptop ([172.97.41.74])
        by smtp.gmail.com with ESMTPSA id o132sm3627487vke.2.2019.12.24.16.06.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Dec 2019 16:06:58 -0800 (PST)
Date:   Tue, 24 Dec 2019 19:06:57 -0500
From:   "Frank A. Cancio Bello" <frank@generalsoftwareinc.com>
To:     Steven Rostedt <rostedt@goodmis.org>,
        Ingo Molnar <mingo@redhat.com>,
        Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     joel@joelfernandes.org, saiprakash.ranjan@codeaurora.org,
        nachukannan@gmail.com, rdunlap@infradead.org
Subject: [PATCH v3 3/3] docs: ftrace: Fix small notation mistake
Message-ID: <22f9a98a972c3155c7b478247a087a5efafde774.1577231751.git.frank@generalsoftwareinc.com>
References: <cover.1577231751.git.frank@generalsoftwareinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1577231751.git.frank@generalsoftwareinc.com>
User-Agent: NeoMutt/20171215
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The use of iff ("if and only if") notation is not accurate in this case.

Suggested-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
Signed-off-by: Frank A. Cancio Bello <frank@generalsoftwareinc.com>
---
 Documentation/trace/ring-buffer-design.txt | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/trace/ring-buffer-design.txt b/Documentation/trace/ring-buffer-design.txt
index ff747b6fa39b..2d53c6f25b91 100644
--- a/Documentation/trace/ring-buffer-design.txt
+++ b/Documentation/trace/ring-buffer-design.txt
@@ -37,7 +37,7 @@ commit_page - a pointer to the page with the last finished non-nested write.
 
 cmpxchg - hardware-assisted atomic transaction that performs the following:
 
-   A = B iff previous A == C
+   A = B if previous A == C
 
    R = cmpxchg(A, C, B) is saying that we replace A with B if and only if
       current A is equal to C, and we put the old (current) A into R
-- 
2.17.1


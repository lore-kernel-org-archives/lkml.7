Return-Path: <SRS0=HQPa=VE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 55C5AC5B578
	for <linux-kernel@archiver.kernel.org>; Sun,  7 Jul 2019 01:40:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1B07820838
	for <linux-kernel@archiver.kernel.org>; Sun,  7 Jul 2019 01:40:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="n2JgFU2a"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727147AbfGGBjy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 6 Jul 2019 21:39:54 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:33525 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726927AbfGGBjx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 6 Jul 2019 21:39:53 -0400
Received: by mail-pf1-f196.google.com with SMTP id g2so1096125pfq.0;
        Sat, 06 Jul 2019 18:39:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=RAReVEOZmlivAeYvp7txSpBTLyvirIUwwGJli98Rrx0=;
        b=n2JgFU2aAq3X2tvy6uw/KC2BIMGm/8irRzy4dan+oJPPCGJ7JuHekluzEZJluazsWQ
         Dl9WE92bSWDxzA3dcnCM238p6ZW0HyJLYKmM36mUdJKh2eWWU0fQg1RvzrA/wfm19lr5
         LsK7IFMUJANbnpE38SA9fRlM0o5WAiugwTG6joGoE4bw17KOJB5zREbzqnm+22yNLAXB
         c6RiBq4NKbBrhYP6lonBz36bxxd5AdssNg17IJT2kzXcQ+puleL8o9K3XpfihethJfi7
         Rl8I5tcEyBNQjxHeNcPpOTJ9dy/8puLM7iMxcp3W39cKoDmmWKuCexF8kbWcMHDrpE3t
         4KkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=RAReVEOZmlivAeYvp7txSpBTLyvirIUwwGJli98Rrx0=;
        b=NVzC0+wzRPf49go6KfLT1594gHX1XA8upGpGakIUApg3fmmpgun4jWllfYrcPnz4GF
         GO3opz6pJ4fvnhEsYvYF9S6l8001tvdvajJHdEC1Xatm5xVYj33fzgYkwCHI98pAOEqL
         IebATX7mQI5RhAg9VMT2bZmGPt6CwfbwLJp5Q0ibMmdjBI7JWQunr3N7b4SFBH/W7LOm
         m5kgqb0CTTaJI4t9bI5G6c3eex9V6gs4D5jPvQs8nZz3LEa1yxQe4o+G3l2Z2cbaAYGr
         hQ9auiVGtuQlCWay8+/NDKGUmsAmjd5cgrsXGcMyXrYzEIA1ZRr2sq362xVXBOQyIu/3
         1Www==
X-Gm-Message-State: APjAAAVXWWDzqtJAeVTEhMN7+8nrRYF+/LLdxDgklP5o7rq6RcEzWX/8
        iB3lBW82qDzsQn06Dh3rTz4=
X-Google-Smtp-Source: APXvYqwnz0yH7ZUrlCoDE5ejIsOIBtUON6v3scy19wq+Hr2seQiZ/3GBRaRBPjnkBrDZuM+N/gM1EQ==
X-Received: by 2002:a17:90a:8c18:: with SMTP id a24mr14189130pjo.111.1562463592643;
        Sat, 06 Jul 2019 18:39:52 -0700 (PDT)
Received: from t-1000 (c-98-210-58-162.hsd1.ca.comcast.net. [98.210.58.162])
        by smtp.gmail.com with ESMTPSA id r27sm22320962pgn.25.2019.07.06.18.39.51
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 06 Jul 2019 18:39:52 -0700 (PDT)
Date:   Sat, 6 Jul 2019 18:39:50 -0700
From:   Shobhit Kukreti <shobhitkukreti@gmail.com>
To:     Jonathan Corbet <corbet@lwn.net>, skhan@linuxfoundation.org,
        linux-kernel-mentees@lists.linuxfoundation.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     shobhitkukreti@gmail.com
Subject: [Linux-kernel-mentees] [PATCH] Documentation: filesystems: Convert
 ufs.txt to reStructuredText format
Message-ID: <20190707013947.GA10663@t-1000>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This converts the plain text documentation of ufs.txt to reStructuredText format.
Added to documentation build process and verified with make htmldocs

Signed-off-by: Shobhit Kukreti <shobhitkukreti@gmail.com>
---
 Documentation/filesystems/index.rst |  1 +
 Documentation/filesystems/ufs.rst   | 65 +++++++++++++++++++++++++++++++++++++
 Documentation/filesystems/ufs.txt   | 60 ----------------------------------
 3 files changed, 66 insertions(+), 60 deletions(-)
 create mode 100644 Documentation/filesystems/ufs.rst
 delete mode 100644 Documentation/filesystems/ufs.txt

diff --git a/Documentation/filesystems/index.rst b/Documentation/filesystems/index.rst
index d700330..2b4f870 100644
--- a/Documentation/filesystems/index.rst
+++ b/Documentation/filesystems/index.rst
@@ -42,3 +42,4 @@ Documentation for individual filesystem types can be found here.
 
    binderfs.rst
    jfs
+   ufs
diff --git a/Documentation/filesystems/ufs.rst b/Documentation/filesystems/ufs.rst
new file mode 100644
index 0000000..d6aeef0
--- /dev/null
+++ b/Documentation/filesystems/ufs.rst
@@ -0,0 +1,65 @@
+=========
+USING UFS
+=========
+
+mount -t ufs -o ufstype=type_of_ufs device dir
+
+UFS OPTIONS
+===========
+
+.. tabularcolumns:: |p{0.5cm}|p{0.5cm}|p{8.0cm}|
+
+.. cssclass:: longtable
+
+.. flat-table::   
+   :header-rows:  0
+   :stub-columns: 0
+
+   * - :rspan:`10` ufstype
+     - =type_of_ufs
+     - UFS is a file system widely used in different operating systems. The problem are differences among implementations. Features of some implementations 
+       are undocumented, so its hard to recognize type of ufs automatically. That's why user must specify type of ufs manually by mount option ufstype.
+       Possible values are below.
+
+   * - old 
+     - old format of ufs default value, supported as read-only
+   
+   * - 44bsd	
+     - used in FreeBSD, NetBSD, OpenBSD supported as read-write
+   
+   * - ufs2
+     - used in FreeBSD 5.x supported as read-write
+
+   * - 5xbsd	
+     - synonym for ufs2
+
+   * - sun
+     - used in SunOS (Solaris) supported as read-write
+
+   * - sunx86	
+     - used in SunOS for Intel (Solarisx86) supported as read-write
+
+   * - hp	
+     - used in HP-UX 	supported as read-only
+
+   * - nextstep
+     - used in NextStep supported as read-only
+
+   * - nextstep-cd
+     - used for NextStep CDROMs (block_size == 2048) supported as read-only
+
+   * - openstep
+     - used in OpenStep supported as read-only
+
+
+POSSIBLE PROBLEMS
+-----------------
+
+See next section, if you have any.
+
+
+BUG REPORTS
+-----------
+
+Any ufs bug report you can send to daniel.pirkl@email.cz or
+to dushistov@mail.ru (do not send partition tables bug reports).
diff --git a/Documentation/filesystems/ufs.txt b/Documentation/filesystems/ufs.txt
deleted file mode 100644
index 7a602ad..0000000
--- a/Documentation/filesystems/ufs.txt
+++ /dev/null
@@ -1,60 +0,0 @@
-USING UFS
-=========
-
-mount -t ufs -o ufstype=type_of_ufs device dir
-
-
-UFS OPTIONS
-===========
-
-ufstype=type_of_ufs
-	UFS is a file system widely used in different operating systems.
-	The problem are differences among implementations. Features of
-	some implementations are undocumented, so its hard to recognize
-	type of ufs automatically. That's why user must specify type of 
-	ufs manually by mount option ufstype. Possible values are:
-
-	old	old format of ufs
-		default value, supported as read-only
-
-	44bsd	used in FreeBSD, NetBSD, OpenBSD
-		supported as read-write
-
-	ufs2    used in FreeBSD 5.x
-		supported as read-write
-
-	5xbsd	synonym for ufs2
-
-	sun	used in SunOS (Solaris)
-		supported as read-write
-
-	sunx86	used in SunOS for Intel (Solarisx86)
-		supported as read-write
-
-	hp	used in HP-UX
-		supported as read-only
-
-	nextstep
-		used in NextStep
-		supported as read-only
-
-	nextstep-cd
-		used for NextStep CDROMs (block_size == 2048)
-		supported as read-only
-
-	openstep
-		used in OpenStep
-		supported as read-only
-
-
-POSSIBLE PROBLEMS
-=================
-
-See next section, if you have any.
-
-
-BUG REPORTS
-===========
-
-Any ufs bug report you can send to daniel.pirkl@email.cz or
-to dushistov@mail.ru (do not send partition tables bug reports).
-- 
2.7.4


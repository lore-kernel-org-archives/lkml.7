Return-Path: <SRS0=E66v=2U=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0D286C2D0D1
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Dec 2019 05:05:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D56F520663
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Dec 2019 05:05:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="a4NIpEw5"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727200AbfL3FFI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 30 Dec 2019 00:05:08 -0500
Received: from mail-pj1-f66.google.com ([209.85.216.66]:38729 "EHLO
        mail-pj1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726775AbfL3FFH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Dec 2019 00:05:07 -0500
Received: by mail-pj1-f66.google.com with SMTP id l35so7613478pje.3;
        Sun, 29 Dec 2019 21:05:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=dv0gPEJpw1DwGP6Ytsqpfok/vsNxEo1QlHlYHyDkSVE=;
        b=a4NIpEw5OUkiOZHEJ2p94OEkLOazuVzl39soh04GBzQn5THlohfN7fkk45af3qNk1E
         GaqMGmZSqpcPrkOx568+/BdoxnELySHHMjqyu/W0ADc0UtsA/UrGQfna62ZmRaQii1Ml
         g6IvebMp2ypmJpDIlyN4w6uXsFpxFO+Bq8f/BV3Pzrr1Afwt1iOCRm9G8eGDNlzKTTc7
         yRabqQA2YqswNFs1TAVcVizHlF5yzz9NtigY9ciVjV+wK+o6LkmBRvKTGslDZX/RaWCe
         /02p3gJVf7Wtf+/Ub7eBEjbbMawyjeoopDaLBJvOmJ6EG/WUdLkWWrM6YJdB/KVK0GHw
         480A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=dv0gPEJpw1DwGP6Ytsqpfok/vsNxEo1QlHlYHyDkSVE=;
        b=jeVhHufzP8rgRwKupZdDnAPOa7Wb6/2LMy+gEODuS/4Ge69ZX/Pr66QLngjLLUTSVA
         sDD2GtftyjEoK3LXH0SXO6OMf90IsKscYALguYb3vIa58+x32HenpflCLUqJA1/pwIEw
         8oRgSMA1TpjaahHud06JpS8fkMLfI+w7hD6M1fCqStQq/6iXkIjetA1nCyqIT0lPI1lR
         jPpX7b3qj2faC8qKnelrhRsTKWsBdoDgLtdEkm8v1VxFnKaausiGoq+dTVgbBMq+NvzV
         IUTd6EB1L3IMs0++0p+mwtAvNnJ/sn8RWpTizcE8zE24C6HowwDCt4uFLj+WRgVxSVj+
         xarg==
X-Gm-Message-State: APjAAAVKaNXtyfGGzExO67Lcswn0J34I4Z+fenySDNfpnAbXtWqxhHPT
        Xme1KYMJ5GP/XiGyThCT0WM=
X-Google-Smtp-Source: APXvYqz2rR8K/u96NeXzLEGMjpcOl1Btke0JiXlwnlhxQvDuGm/X2pL990jkWRFSNwU0qnLnNB7NWw==
X-Received: by 2002:a17:902:d694:: with SMTP id v20mr26699724ply.127.1577682305975;
        Sun, 29 Dec 2019 21:05:05 -0800 (PST)
Received: from localhost.localdomain ([2804:14d:72b1:8920:da15:c0bd:33c1:e2ad])
        by smtp.gmail.com with ESMTPSA id r2sm45054727pgv.16.2019.12.29.21.05.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 29 Dec 2019 21:05:05 -0800 (PST)
From:   "Daniel W. S. Almeida" <dwlsalmeida@gmail.com>
X-Google-Original-From: Daniel W. S. Almeida
To:     corbet@lwn.net, mchehab+samsung@kernel.org
Cc:     "Daniel W. S. Almeida" <dwlsalmeida@gmail.com>,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        skhan@linuxfoundation.org,
        linux-kernel-mentees@lists.linuxfoundation.org
Subject: [PATCH 3/5] Documentation: nfs: rpc-server-gss: convert to ReST
Date:   Mon, 30 Dec 2019 02:04:45 -0300
Message-Id: <a86269bc495edfc827e7c80ffe038f410315f028.1577681894.git.dwlsalmeida@gmail.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <cover.1577681894.git.dwlsalmeida@gmail.com>
References: <cover.1577681894.git.dwlsalmeida@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Daniel W. S. Almeida" <dwlsalmeida@gmail.com>

Convert rpc-server-gss.txt to ReST. Content remains mostly unchanged.

Signed-off-by: Daniel W. S. Almeida <dwlsalmeida@gmail.com>
---
 Documentation/filesystems/nfs/index.rst       |  1 +
 ...{rpc-server-gss.txt => rpc-server-gss.rst} | 19 +++++++++++--------
 2 files changed, 12 insertions(+), 8 deletions(-)
 rename Documentation/filesystems/nfs/{rpc-server-gss.txt => rpc-server-gss.rst} (92%)

diff --git a/Documentation/filesystems/nfs/index.rst b/Documentation/filesystems/nfs/index.rst
index 52f4956e7770..9d5365cbe2c3 100644
--- a/Documentation/filesystems/nfs/index.rst
+++ b/Documentation/filesystems/nfs/index.rst
@@ -8,3 +8,4 @@ NFS
 
    pnfs
    rpc-cache
+   rpc-server-gss
diff --git a/Documentation/filesystems/nfs/rpc-server-gss.txt b/Documentation/filesystems/nfs/rpc-server-gss.rst
similarity index 92%
rename from Documentation/filesystems/nfs/rpc-server-gss.txt
rename to Documentation/filesystems/nfs/rpc-server-gss.rst
index 310bbbaf9080..812754576845 100644
--- a/Documentation/filesystems/nfs/rpc-server-gss.txt
+++ b/Documentation/filesystems/nfs/rpc-server-gss.rst
@@ -1,4 +1,4 @@
-
+=========================================
 rpcsec_gss support for kernel RPC servers
 =========================================
 
@@ -9,14 +9,17 @@ NFSv4.1 and higher don't require the client to act as a server for the
 purposes of authentication.)
 
 RPCGSS is specified in a few IETF documents:
+
  - RFC2203 v1: http://tools.ietf.org/rfc/rfc2203.txt
  - RFC5403 v2: http://tools.ietf.org/rfc/rfc5403.txt
+
 and there is a 3rd version  being proposed:
+
  - http://tools.ietf.org/id/draft-williams-rpcsecgssv3.txt
    (At draft n. 02 at the time of writing)
 
 Background
-----------
+==========
 
 The RPCGSS Authentication method describes a way to perform GSSAPI
 Authentication for NFS.  Although GSSAPI is itself completely mechanism
@@ -29,6 +32,7 @@ depends on GSSAPI extensions that are KRB5 specific.
 GSSAPI is a complex library, and implementing it completely in kernel is
 unwarranted. However GSSAPI operations are fundementally separable in 2
 parts:
+
 - initial context establishment
 - integrity/privacy protection (signing and encrypting of individual
   packets)
@@ -41,7 +45,7 @@ kernel, but leave the initial context establishment to userspace.  We
 need upcalls to request userspace to perform context establishment.
 
 NFS Server Legacy Upcall Mechanism
-----------------------------------
+==================================
 
 The classic upcall mechanism uses a custom text based upcall mechanism
 to talk to a custom daemon called rpc.svcgssd that is provide by the
@@ -62,21 +66,20 @@ groups) due to limitation on the size of the buffer that can be send
 back to the kernel (4KiB).
 
 NFS Server New RPC Upcall Mechanism
------------------------------------
+===================================
 
 The newer upcall mechanism uses RPC over a unix socket to a daemon
 called gss-proxy, implemented by a userspace program called Gssproxy.
 
-The gss_proxy RPC protocol is currently documented here:
-
-	https://fedorahosted.org/gss-proxy/wiki/ProtocolDocumentation
+The gss_proxy RPC protocol is currently documented `here
+<https://fedorahosted.org/gss-proxy/wiki/ProtocolDocumentation>`_.
 
 This upcall mechanism uses the kernel rpc client and connects to the gssproxy
 userspace program over a regular unix socket. The gssproxy protocol does not
 suffer from the size limitations of the legacy protocol.
 
 Negotiating Upcall Mechanisms
------------------------------
+=============================
 
 To provide backward compatibility, the kernel defaults to using the
 legacy mechanism.  To switch to the new mechanism, gss-proxy must bind
-- 
2.24.1


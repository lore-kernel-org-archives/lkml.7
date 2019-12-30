Return-Path: <SRS0=E66v=2U=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BE58DC2D0C3
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Dec 2019 05:05:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7697F20748
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Dec 2019 05:05:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WehwM/dA"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727226AbfL3FFM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 30 Dec 2019 00:05:12 -0500
Received: from mail-pf1-f193.google.com ([209.85.210.193]:45609 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726775AbfL3FFL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Dec 2019 00:05:11 -0500
Received: by mail-pf1-f193.google.com with SMTP id 2so17689589pfg.12;
        Sun, 29 Dec 2019 21:05:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=9wG3B56mFaZQZJLeS0bRdj9c2w1Lk+MjODegFMa9Tsw=;
        b=WehwM/dAD+p0ItFyI3MYE39QVUrdAfrXGBwg+edUhS2c5mDGNY0qMOP3KOmS91fiKL
         Y6JWPjC0WHn4L7clDqkvi3IMFyqQbBXNUDyaSJmOlJWYX0P23A+4w/2DufJZ6w94epa5
         DtfyYTtTkpL3WhkDvp/jtpkUzE6T/cJS/EkohwM/wp4s46MKnqF5LqQD8AM6u7qtYPg3
         k8fp2Wz2qGQEYYJCgCbko4zGikkGNpDgPcNEMoyR9WFH550z8ghlno+gxOG0zO6m0vSB
         PcpTOm+EXc9E3WKEWU6Ojy5E833sIB9dqP4HllV6ZEI7XrwXNwMOST7VSqvf1uU8mux0
         j+pA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=9wG3B56mFaZQZJLeS0bRdj9c2w1Lk+MjODegFMa9Tsw=;
        b=FPtC93nTVbb4ezxNvNlXqviJnti9McYrm7a1bKOT75Die5pNP9iA+ep5SVrcnJ0/Rr
         kj4cAMngKkAIxikGG7lh+/tV98OTu1xncHS5vL2+lioPeZUUcWUxsYnGuUS9o3+i0pPH
         JA5nHBDPqC9/xWhOGgNuSi6FitvbWiZbVFb2xtA492q7rDGrPlEa19uOkljcxYhbo0UC
         PW+GnH6JMQUoqj4UlnyHbFBWyNtYAu9wQ2/ORLInEauCJInL4sOH10EZu/YGGhroJPko
         pP1Ya4QZzeGKkknMt69OPmai3oGRy2D5vWvZEFfzYyTfMAmn3vJN9ChzPYOVpmfC3z/4
         jzxg==
X-Gm-Message-State: APjAAAWdWCG3WQjngFeRXwyv7K2QT+kz6Y4wAPQZipRPj+LDxTjVj01s
        PoJu4I4x7z17XSbBnKlkrt0=
X-Google-Smtp-Source: APXvYqyG1Xg3ySuCMy63XhZNRHPkWF3aiijaj0wqhJcHJZymfHo6OBBCcsjUQTsFLdHjIKOQDiOHng==
X-Received: by 2002:a05:6a00:11:: with SMTP id h17mr68125791pfk.209.1577682309863;
        Sun, 29 Dec 2019 21:05:09 -0800 (PST)
Received: from localhost.localdomain ([2804:14d:72b1:8920:da15:c0bd:33c1:e2ad])
        by smtp.gmail.com with ESMTPSA id r2sm45054727pgv.16.2019.12.29.21.05.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 29 Dec 2019 21:05:09 -0800 (PST)
From:   "Daniel W. S. Almeida" <dwlsalmeida@gmail.com>
X-Google-Original-From: Daniel W. S. Almeida
To:     corbet@lwn.net, mchehab+samsung@kernel.org
Cc:     "Daniel W. S. Almeida" <dwlsalmeida@gmail.com>,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        skhan@linuxfoundation.org,
        linux-kernel-mentees@lists.linuxfoundation.org
Subject: [PATCH 4/5] Documentation: nfs: nfs41-server: convert to ReST
Date:   Mon, 30 Dec 2019 02:04:46 -0300
Message-Id: <5523e5ad8da2c9b7af16c26e368f17804e8841cc.1577681894.git.dwlsalmeida@gmail.com>
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

Convert nfs41-server.txt to ReST. The ASCII tables were converted to
csv-tables and not list-tables because the former is easier to export
from spreadsheets.

Signed-off-by: Daniel W. S. Almeida <dwlsalmeida@gmail.com>
---
 Documentation/filesystems/nfs/index.rst       |   1 +
 .../filesystems/nfs/nfs41-server.rst          | 181 ++++++++++++++++++
 .../filesystems/nfs/nfs41-server.txt          | 173 -----------------
 3 files changed, 182 insertions(+), 173 deletions(-)
 create mode 100644 Documentation/filesystems/nfs/nfs41-server.rst
 delete mode 100644 Documentation/filesystems/nfs/nfs41-server.txt

diff --git a/Documentation/filesystems/nfs/index.rst b/Documentation/filesystems/nfs/index.rst
index 9d5365cbe2c3..a0a678af921b 100644
--- a/Documentation/filesystems/nfs/index.rst
+++ b/Documentation/filesystems/nfs/index.rst
@@ -9,3 +9,4 @@ NFS
    pnfs
    rpc-cache
    rpc-server-gss
+   nfs41-server
diff --git a/Documentation/filesystems/nfs/nfs41-server.rst b/Documentation/filesystems/nfs/nfs41-server.rst
new file mode 100644
index 000000000000..e1e818ec3571
--- /dev/null
+++ b/Documentation/filesystems/nfs/nfs41-server.rst
@@ -0,0 +1,181 @@
+=============================
+NFSv4.1 Server Implementation
+=============================
+
+Server support for minorversion 1 can be controlled using the
+/proc/fs/nfsd/versions control file.  The string output returned
+by reading this file will contain either "+4.1" or "-4.1"
+correspondingly.
+
+Currently, server support for minorversion 1 is enabled by default.
+It can be disabled at run time by writing the string "-4.1" to
+the /proc/fs/nfsd/versions control file.  Note that to write this
+control file, the nfsd service must be taken down.  You can use rpc.nfsd
+for this; see rpc.nfsd(8).
+
+(Warning: older servers will interpret "+4.1" and "-4.1" as "+4" and
+"-4", respectively.  Therefore, code meant to work on both new and old
+kernels must turn 4.1 on or off *before* turning support for version 4
+on or off; rpc.nfsd does this correctly.)
+
+The NFSv4 minorversion 1 (NFSv4.1) implementation in nfsd is based
+on RFC 5661.
+
+From the many new features in NFSv4.1 the current implementation
+focuses on the mandatory-to-implement NFSv4.1 Sessions, providing
+"exactly once" semantics and better control and throttling of the
+resources allocated for each client.
+
+The table below, taken from the NFSv4.1 document, lists
+the operations that are mandatory to implement (REQ), optional
+(OPT), and NFSv4.0 operations that are required not to implement (MNI)
+in minor version 1.  The first column indicates the operations that
+are not supported yet by the linux server implementation.
+
+The OPTIONAL features identified and their abbreviations are as follows:
+
+- **pNFS**	Parallel NFS
+- **FDELG**	File Delegations
+- **DDELG**	Directory Delegations
+
+The following abbreviations indicate the linux server implementation status.
+
+- **I**	Implemented NFSv4.1 operations.
+- **NS**	Not Supported.
+- **NS\***	Unimplemented optional feature.
+
+Operations
+==========
+
+.. csv-table::
+   :header: "Implementation status", "Operation", "REQ, REC, OPT or NMI", "Feature (REQ, REC or OPT)", "Definition"
+   :widths: auto
+   :delim: ;
+
+   ;"ACCESS";"REQ";;"Section 18.1"
+   "I";"BACKCHANNEL_CTL";"REQ";;"Section 18.33"
+   "I";"BIND_CONN_TO_SESSION";"REQ";;"Section 18.34"
+   ;"CLOSE";"REQ";;"Section 18.2"
+   ;"COMMIT";"REQ";;"Section 18.3"
+   ;"CREATE";"REQ";;"Section 18.4"
+   "I";"CREATE_SESSION";"REQ";;"Section 18.36"
+   "NS*";"DELEGPURGE";"OPT";"FDELG (REQ)";"Section 18.5"
+   ;"DELEGRETURN";"OPT";"FDELG,";"Section 18.6"
+   ;;;"DDELG, pNFS";
+   ;;;"(REQ)";
+   "I";"DESTROY_CLIENTID";"REQ";;"Section 18.50"
+   "I";"DESTROY_SESSION";"REQ";;"Section 18.37"
+   "I";"EXCHANGE_ID";"REQ";;"Section 18.35"
+   "I";"FREE_STATEID";"REQ";;"Section 18.38"
+   ;"GETATTR";"REQ";;"Section 18.7"
+   "I";"GETDEVICEINFO";"OPT";"pNFS (REQ)";"Section 18.40"
+   "NS*";"GETDEVICELIST";"OPT";"pNFS (OPT)";"Section 18.41"
+   ;"GETFH";"REQ";;"Section 18.8"
+   "NS*";"GET_DIR_DELEGATION";"OPT";"DDELG (REQ)";"Section 18.39"
+   "I";"LAYOUTCOMMIT";"OPT";"pNFS (REQ)";"Section 18.42"
+   "I";"LAYOUTGET";"OPT";"pNFS (REQ)";"Section 18.43"
+   "I";"LAYOUTRETURN";"OPT";"pNFS (REQ)";"Section 18.44"
+   ;"LINK";"OPT";;"Section 18.9"
+   ;"LOCK";"REQ";;"Section 18.10"
+   ;"LOCKT";"REQ";;"Section 18.11"
+   ;"LOCKU";"REQ";;"Section 18.12"
+   ;"LOOKUP";"REQ";;"Section 18.13"
+   ;"LOOKUPP";"REQ";;"Section 18.14"
+   ;"NVERIFY";"REQ";;"Section 18.15"
+   ;"OPEN";"REQ";;"Section 18.16"
+   "NS*";"OPENATTR";"OPT";;"Section 18.17"
+   ;"OPEN_CONFIRM";"MNI";;"N/A"
+   ;"OPEN_DOWNGRADE";"REQ";;"Section 18.18"
+   ;"PUTFH";"REQ";;"Section 18.19"
+   ;"PUTPUBFH";"REQ";;"Section 18.20"
+   ;"PUTROOTFH";"REQ";;"Section 18.21"
+   ;"READ";"REQ";;"Section 18.22"
+   ;"READDIR";"REQ";;"Section 18.23"
+   ;"READLINK";"OPT";;"Section 18.24"
+   ;"RECLAIM_COMPLETE";"REQ";;"Section 18.51"
+   ;"RELEASE_LOCKOWNER";"MNI";;"N/A"
+   ;"REMOVE";"REQ";;"Section 18.25"
+   ;"RENAME";"REQ";;"Section 18.26"
+   ;"RENEW";"MNI";;"N/A"
+   ;"RESTOREFH";"REQ";;"Section 18.27"
+   ;"SAVEFH";"REQ";;"Section 18.28"
+   ;"SECINFO";"REQ";;"Section 18.29"
+   "I";"SECINFO_NO_NAME";"REC";"pNFS files";"Section 18.45,"
+   ;;;"layout (REQ)";"Section 13.12"
+   "I";"SEQUENCE";"REQ";;"Section 18.46"
+   ;"SETATTR";"REQ";;"Section 18.30"
+   ;"SETCLIENTID";"MNI";;"N/A"
+   ;"SETCLIENTID_CONFIRM";"MNI";;"N/A"
+   "NS";"SET_SSV";"REQ";;"Section 18.47"
+   "I";"TEST_STATEID";"REQ";;"Section 18.48"
+   ;"VERIFY";"REQ";;"Section 18.31"
+   "NS*";"WANT_DELEGATION";"OPT";"FDELG (OPT)";"Section 18.49"
+   ;"WRITE";"REQ";;"Section 18.32"
+
+
+Callback Operations
+===================
+
+.. csv-table::
+   :header: "Implementation status", "Operation", "REQ, REC, OPT or NMI", "Feature (REQ, REC or OPT)", "Definition"
+   :widths: auto
+   :delim: ;
+
+   ;"CB_GETATTR";"OPT";"FDELG (REQ)";"Section 20.1"
+   "I";"CB_LAYOUTRECALL";"OPT";"pNFS (REQ)";"Section 20.3"
+   "NS*";"CB_NOTIFY";"OPT";"DDELG (REQ)";"Section 20.4"
+   "NS*";"CB_NOTIFY_DEVICEID";"OPT";"pNFS (OPT)";"Section 20.12"
+   "NS*";"CB_NOTIFY_LOCK";"OPT";;"Section 20.11"
+   "NS*";"CB_PUSH_DELEG";"OPT";"FDELG (OPT)";"Section 20.5"
+   ;"CB_RECALL";"OPT";"FDELG,";"Section 20.2"
+   ;;;"DDELG, pNFS";
+   ;;;"(REQ)";
+   "NS*";"CB_RECALL_ANY";"OPT";"FDELG,";"Section 20.6"
+   ;;;"DDELG, pNFS";
+   ;;;"(REQ)";
+   "NS";"CB_RECALL_SLOT";"REQ";;"Section 20.8"
+   "NS*";"CB_RECALLABLE_OBJ_AVAIL";"OPT";"DDELG, pNFS";"Section 20.7"
+   ;;;"(REQ)";
+   "I";"CB_SEQUENCE";"OPT";"FDELG,";"Section 20.9"
+   ;;;"DDELG, pNFS";
+   ;;;"(REQ)";
+   "NS*";"CB_WANTS_CANCELLED";"OPT";"FDELG,";"Section 20.10"
+   ;;;"DDELG, pNFS";
+   ;;;"(REQ)";
+
+
+Implementation notes:
+=====================
+
+SSV:
+  The spec claims this is mandatory, but we don't actually know of any
+  implementations, so we're ignoring it for now.  The server returns
+  NFS4ERR_ENCR_ALG_UNSUPP on EXCHANGE_ID, which should be future-proof.
+
+GSS on the backchannel:
+  Again, theoretically required but not widely implemented (in
+  particular, the current Linux client doesn't request it).  We return
+  NFS4ERR_ENCR_ALG_UNSUPP on CREATE_SESSION.
+
+DELEGPURGE:
+  mandatory only for servers that support CLAIM_DELEGATE_PREV and/or
+  CLAIM_DELEG_PREV_FH (which allows clients to keep delegations that
+  persist across client reboots).  Thus we need not implement this for
+  now.
+
+EXCHANGE_ID:
+  implementation ids are ignored
+
+CREATE_SESSION:
+  backchannel attributes are ignored
+
+SEQUENCE:
+  no support for dynamic slot table renegotiation (optional)
+
+Nonstandard compound limitations:
+  No support for a sessions fore channel RPC compound that requires both a
+  ca_maxrequestsize request and a ca_maxresponsesize reply, so we may
+  fail to live up to the promise we made in CREATE_SESSION fore channel
+  negotiation.
+
+See also http://wiki.linux-nfs.org/wiki/index.php/Server_4.0_and_4.1_issues.
diff --git a/Documentation/filesystems/nfs/nfs41-server.txt b/Documentation/filesystems/nfs/nfs41-server.txt
deleted file mode 100644
index 682a59fabe3f..000000000000
--- a/Documentation/filesystems/nfs/nfs41-server.txt
+++ /dev/null
@@ -1,173 +0,0 @@
-NFSv4.1 Server Implementation
-
-Server support for minorversion 1 can be controlled using the
-/proc/fs/nfsd/versions control file.  The string output returned
-by reading this file will contain either "+4.1" or "-4.1"
-correspondingly.
-
-Currently, server support for minorversion 1 is enabled by default.
-It can be disabled at run time by writing the string "-4.1" to
-the /proc/fs/nfsd/versions control file.  Note that to write this
-control file, the nfsd service must be taken down.  You can use rpc.nfsd
-for this; see rpc.nfsd(8).
-
-(Warning: older servers will interpret "+4.1" and "-4.1" as "+4" and
-"-4", respectively.  Therefore, code meant to work on both new and old
-kernels must turn 4.1 on or off *before* turning support for version 4
-on or off; rpc.nfsd does this correctly.)
-
-The NFSv4 minorversion 1 (NFSv4.1) implementation in nfsd is based
-on RFC 5661.
-
-From the many new features in NFSv4.1 the current implementation
-focuses on the mandatory-to-implement NFSv4.1 Sessions, providing
-"exactly once" semantics and better control and throttling of the
-resources allocated for each client.
-
-The table below, taken from the NFSv4.1 document, lists
-the operations that are mandatory to implement (REQ), optional
-(OPT), and NFSv4.0 operations that are required not to implement (MNI)
-in minor version 1.  The first column indicates the operations that
-are not supported yet by the linux server implementation.
-
-The OPTIONAL features identified and their abbreviations are as follows:
-	pNFS	Parallel NFS
-	FDELG	File Delegations
-	DDELG	Directory Delegations
-
-The following abbreviations indicate the linux server implementation status.
-	I	Implemented NFSv4.1 operations.
-	NS	Not Supported.
-	NS*	Unimplemented optional feature.
-
-Operations
-
-   +----------------------+------------+--------------+----------------+
-   | Operation            | REQ, REC,  | Feature      | Definition     |
-   |                      | OPT, or    | (REQ, REC,   |                |
-   |                      | MNI        | or OPT)      |                |
-   +----------------------+------------+--------------+----------------+
-   | ACCESS               | REQ        |              | Section 18.1   |
-I  | BACKCHANNEL_CTL      | REQ        |              | Section 18.33  |
-I  | BIND_CONN_TO_SESSION | REQ        |              | Section 18.34  |
-   | CLOSE                | REQ        |              | Section 18.2   |
-   | COMMIT               | REQ        |              | Section 18.3   |
-   | CREATE               | REQ        |              | Section 18.4   |
-I  | CREATE_SESSION       | REQ        |              | Section 18.36  |
-NS*| DELEGPURGE           | OPT        | FDELG (REQ)  | Section 18.5   |
-   | DELEGRETURN          | OPT        | FDELG,       | Section 18.6   |
-   |                      |            | DDELG, pNFS  |                |
-   |                      |            | (REQ)        |                |
-I  | DESTROY_CLIENTID     | REQ        |              | Section 18.50  |
-I  | DESTROY_SESSION      | REQ        |              | Section 18.37  |
-I  | EXCHANGE_ID          | REQ        |              | Section 18.35  |
-I  | FREE_STATEID         | REQ        |              | Section 18.38  |
-   | GETATTR              | REQ        |              | Section 18.7   |
-I  | GETDEVICEINFO        | OPT        | pNFS (REQ)   | Section 18.40  |
-NS*| GETDEVICELIST        | OPT        | pNFS (OPT)   | Section 18.41  |
-   | GETFH                | REQ        |              | Section 18.8   |
-NS*| GET_DIR_DELEGATION   | OPT        | DDELG (REQ)  | Section 18.39  |
-I  | LAYOUTCOMMIT         | OPT        | pNFS (REQ)   | Section 18.42  |
-I  | LAYOUTGET            | OPT        | pNFS (REQ)   | Section 18.43  |
-I  | LAYOUTRETURN         | OPT        | pNFS (REQ)   | Section 18.44  |
-   | LINK                 | OPT        |              | Section 18.9   |
-   | LOCK                 | REQ        |              | Section 18.10  |
-   | LOCKT                | REQ        |              | Section 18.11  |
-   | LOCKU                | REQ        |              | Section 18.12  |
-   | LOOKUP               | REQ        |              | Section 18.13  |
-   | LOOKUPP              | REQ        |              | Section 18.14  |
-   | NVERIFY              | REQ        |              | Section 18.15  |
-   | OPEN                 | REQ        |              | Section 18.16  |
-NS*| OPENATTR             | OPT        |              | Section 18.17  |
-   | OPEN_CONFIRM         | MNI        |              | N/A            |
-   | OPEN_DOWNGRADE       | REQ        |              | Section 18.18  |
-   | PUTFH                | REQ        |              | Section 18.19  |
-   | PUTPUBFH             | REQ        |              | Section 18.20  |
-   | PUTROOTFH            | REQ        |              | Section 18.21  |
-   | READ                 | REQ        |              | Section 18.22  |
-   | READDIR              | REQ        |              | Section 18.23  |
-   | READLINK             | OPT        |              | Section 18.24  |
-   | RECLAIM_COMPLETE     | REQ        |              | Section 18.51  |
-   | RELEASE_LOCKOWNER    | MNI        |              | N/A            |
-   | REMOVE               | REQ        |              | Section 18.25  |
-   | RENAME               | REQ        |              | Section 18.26  |
-   | RENEW                | MNI        |              | N/A            |
-   | RESTOREFH            | REQ        |              | Section 18.27  |
-   | SAVEFH               | REQ        |              | Section 18.28  |
-   | SECINFO              | REQ        |              | Section 18.29  |
-I  | SECINFO_NO_NAME      | REC        | pNFS files   | Section 18.45, |
-   |                      |            | layout (REQ) | Section 13.12  |
-I  | SEQUENCE             | REQ        |              | Section 18.46  |
-   | SETATTR              | REQ        |              | Section 18.30  |
-   | SETCLIENTID          | MNI        |              | N/A            |
-   | SETCLIENTID_CONFIRM  | MNI        |              | N/A            |
-NS | SET_SSV              | REQ        |              | Section 18.47  |
-I  | TEST_STATEID         | REQ        |              | Section 18.48  |
-   | VERIFY               | REQ        |              | Section 18.31  |
-NS*| WANT_DELEGATION      | OPT        | FDELG (OPT)  | Section 18.49  |
-   | WRITE                | REQ        |              | Section 18.32  |
-
-Callback Operations
-
-   +-------------------------+-----------+-------------+---------------+
-   | Operation               | REQ, REC, | Feature     | Definition    |
-   |                         | OPT, or   | (REQ, REC,  |               |
-   |                         | MNI       | or OPT)     |               |
-   +-------------------------+-----------+-------------+---------------+
-   | CB_GETATTR              | OPT       | FDELG (REQ) | Section 20.1  |
-I  | CB_LAYOUTRECALL         | OPT       | pNFS (REQ)  | Section 20.3  |
-NS*| CB_NOTIFY               | OPT       | DDELG (REQ) | Section 20.4  |
-NS*| CB_NOTIFY_DEVICEID      | OPT       | pNFS (OPT)  | Section 20.12 |
-NS*| CB_NOTIFY_LOCK          | OPT       |             | Section 20.11 |
-NS*| CB_PUSH_DELEG           | OPT       | FDELG (OPT) | Section 20.5  |
-   | CB_RECALL               | OPT       | FDELG,      | Section 20.2  |
-   |                         |           | DDELG, pNFS |               |
-   |                         |           | (REQ)       |               |
-NS*| CB_RECALL_ANY           | OPT       | FDELG,      | Section 20.6  |
-   |                         |           | DDELG, pNFS |               |
-   |                         |           | (REQ)       |               |
-NS | CB_RECALL_SLOT          | REQ       |             | Section 20.8  |
-NS*| CB_RECALLABLE_OBJ_AVAIL | OPT       | DDELG, pNFS | Section 20.7  |
-   |                         |           | (REQ)       |               |
-I  | CB_SEQUENCE             | OPT       | FDELG,      | Section 20.9  |
-   |                         |           | DDELG, pNFS |               |
-   |                         |           | (REQ)       |               |
-NS*| CB_WANTS_CANCELLED      | OPT       | FDELG,      | Section 20.10 |
-   |                         |           | DDELG, pNFS |               |
-   |                         |           | (REQ)       |               |
-   +-------------------------+-----------+-------------+---------------+
-
-Implementation notes:
-
-SSV:
-* The spec claims this is mandatory, but we don't actually know of any
-  implementations, so we're ignoring it for now.  The server returns
-  NFS4ERR_ENCR_ALG_UNSUPP on EXCHANGE_ID, which should be future-proof.
-
-GSS on the backchannel:
-* Again, theoretically required but not widely implemented (in
-  particular, the current Linux client doesn't request it).  We return
-  NFS4ERR_ENCR_ALG_UNSUPP on CREATE_SESSION.
-
-DELEGPURGE:
-* mandatory only for servers that support CLAIM_DELEGATE_PREV and/or
-  CLAIM_DELEG_PREV_FH (which allows clients to keep delegations that
-  persist across client reboots).  Thus we need not implement this for
-  now.
-
-EXCHANGE_ID:
-* implementation ids are ignored
-
-CREATE_SESSION:
-* backchannel attributes are ignored
-
-SEQUENCE:
-* no support for dynamic slot table renegotiation (optional)
-
-Nonstandard compound limitations:
-* No support for a sessions fore channel RPC compound that requires both a
-  ca_maxrequestsize request and a ca_maxresponsesize reply, so we may
-  fail to live up to the promise we made in CREATE_SESSION fore channel
-  negotiation.
-
-See also http://wiki.linux-nfs.org/wiki/index.php/Server_4.0_and_4.1_issues.
-- 
2.24.1


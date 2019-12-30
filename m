Return-Path: <SRS0=E66v=2U=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 70850C2D0C3
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Dec 2019 05:04:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 488AC2071E
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Dec 2019 05:04:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SsJhNicN"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727136AbfL3FEz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 30 Dec 2019 00:04:55 -0500
Received: from mail-pl1-f177.google.com ([209.85.214.177]:38874 "EHLO
        mail-pl1-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726775AbfL3FEz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Dec 2019 00:04:55 -0500
Received: by mail-pl1-f177.google.com with SMTP id f20so14188079plj.5;
        Sun, 29 Dec 2019 21:04:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=5wS2IrMaQZTiI9oJtmOwRkQukdb+P4omdMqN1yhWXY0=;
        b=SsJhNicNBuR0+0m1WCqa3TOIKJdbehKSJ+OcgZ+UNMdRswGsKau5fPieyPoN6otn7e
         UvbNom9oZ4ijzIIB+lO3Iu1XcVnAJ1BoIUWFzC6Xo9gBG3/iWplqvMoAvFeJFZRj+9yB
         T5t1Df4TFiA2tja6hiSjO6KIQbIBFGwxa2AvWh/wCYkqKEnzAOX/ONzKbGwoyhlN2kiW
         pYHC3dtJ0EesYBVsKI4Glwq/zOos/H2zBpJhp+UN3QDypFCXfJBdulUEXvh4Rb8AtVEy
         Jmk5oYAYDspe+P43S+OJszBAx2HAiY3afziP65UWMpPclQ+TRIack/CCcEcoD8rEZFPS
         KVyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=5wS2IrMaQZTiI9oJtmOwRkQukdb+P4omdMqN1yhWXY0=;
        b=PgX1PspXNsHB1P4Ey9ZieCIKgvPsvG9v++ZifkWdICphS3erN3ygo4AqNnUH3A2N3l
         zEZqbbcPDdEgegny9e3gufM/u22OW6zNT/Xt4eiJHUiCL56p/iUXrUo1qn6f+ZHajkE9
         Dsi4o1WyBqO9vrqkfpLy4Bydz2buaq9z46DhFK1bw3cMP/KpPs+3jzBwWDqZ/GZbNxXt
         KdIJrizfA52p7AmKwld7wr7wyVybQPuPdepM4/0SIJbvpPtmCb+nt+7vaAhtlXARY/Vc
         tcep2qVojIm/hIHQ7yXWf1jR0e3Egm97l3AOSeEhKs7QbHST758tvZNtzbIcn5jdWxtP
         OQLQ==
X-Gm-Message-State: APjAAAVQKn4E8R4kTObOrZ0LJ8d3odOPVx8Bum87J9P2AqBDSLlFVrJ7
        exbWpyqZlDOuurkSB/djVv8=
X-Google-Smtp-Source: APXvYqwCNL+eGFhE9EXNh11lwrXcCRKTQPaNUiZYwK7Fwvolj1nrhVaq5BkIHlAckfQuu8AHr5p1xQ==
X-Received: by 2002:a17:902:407:: with SMTP id 7mr11012274ple.226.1577682294245;
        Sun, 29 Dec 2019 21:04:54 -0800 (PST)
Received: from localhost.localdomain ([2804:14d:72b1:8920:da15:c0bd:33c1:e2ad])
        by smtp.gmail.com with ESMTPSA id r2sm45054727pgv.16.2019.12.29.21.04.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 29 Dec 2019 21:04:53 -0800 (PST)
From:   "Daniel W. S. Almeida" <dwlsalmeida@gmail.com>
X-Google-Original-From: Daniel W. S. Almeida
To:     corbet@lwn.net, mchehab+samsung@kernel.org
Cc:     "Daniel W. S. Almeida" <dwlsalmeida@gmail.com>,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        skhan@linuxfoundation.org,
        linux-kernel-mentees@lists.linuxfoundation.org
Subject: [PATCH 0/5] Documentation: nfs: convert remaining files to ReST.
Date:   Mon, 30 Dec 2019 02:04:42 -0300
Message-Id: <cover.1577681894.git.dwlsalmeida@gmail.com>
X-Mailer: git-send-email 2.24.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Daniel W. S. Almeida" <dwlsalmeida@gmail.com>

This series completes the conversion of Documentation/filesystems/nfs to ReST.

Note that I chose csv-table over list-table because csv files are easier
to export from other software. 

I did not think these rst files were supposed to be
in admin-guide, so I left them where they are.

Daniel W. S. Almeida (5):
  Documentation: nfs: convert pnfs.txt to ReST
  Documentation: nfs: rpc-cache: convert to ReST
  Documentation: nfs: rpc-server-gss: convert to ReST
  Documentation: nfs: nfs41-server: convert to ReST
  Documentation: nfs: knfsd-stats: convert to ReST

 Documentation/filesystems/index.rst           |   1 +
 Documentation/filesystems/nfs/index.rst       |  13 ++
 .../nfs/{knfsd-stats.txt => knfsd-stats.rst}  |  17 +-
 .../filesystems/nfs/nfs41-server.rst          | 181 ++++++++++++++++++
 .../filesystems/nfs/nfs41-server.txt          | 173 -----------------
 .../filesystems/nfs/{pnfs.txt => pnfs.rst}    |  25 ++-
 .../nfs/{rpc-cache.txt => rpc-cache.rst}      | 136 +++++++------
 ...{rpc-server-gss.txt => rpc-server-gss.rst} |  19 +-
 8 files changed, 306 insertions(+), 259 deletions(-)
 create mode 100644 Documentation/filesystems/nfs/index.rst
 rename Documentation/filesystems/nfs/{knfsd-stats.txt => knfsd-stats.rst} (95%)
 create mode 100644 Documentation/filesystems/nfs/nfs41-server.rst
 delete mode 100644 Documentation/filesystems/nfs/nfs41-server.txt
 rename Documentation/filesystems/nfs/{pnfs.txt => pnfs.rst} (87%)
 rename Documentation/filesystems/nfs/{rpc-cache.txt => rpc-cache.rst} (66%)
 rename Documentation/filesystems/nfs/{rpc-server-gss.txt => rpc-server-gss.rst} (92%)

-- 
2.24.1


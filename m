Return-Path: <SRS0=G0tX=VI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3FD4DC74A3F
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Jul 2019 00:16:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1E4F321019
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Jul 2019 00:16:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727903AbfGKAQq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 10 Jul 2019 20:16:46 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:45350 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727325AbfGKAQq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Jul 2019 20:16:46 -0400
Received: by mail-wr1-f68.google.com with SMTP id f9so4214858wre.12
        for <linux-kernel@vger.kernel.org>; Wed, 10 Jul 2019 17:16:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=4Ln9nVykDM3G9+NApDYWTsuMwlFmxobEqFjXeHD5P6Y=;
        b=iZv+sdQ0WQVKjiHbKa3z9rwoow5tGd77xpRc6BgjuVT7Hb7+HulWrhXNHTBqM6vwhi
         py1mfnAsRJAnVfZW3uGPB6vZg/xsfxl+qLyz0QQUD5beLFbGzy9LAhA3QxyBsagWUMJc
         T2hbN3zqLhqMll0U4/t/q4M6V4KDnwRtgWeMZDBWscTbeEgeQvxUpmEyx3yt9rwvzkn9
         zeyDHCUL8Sg2PODUrtMO0ACeBEU462e6W83CSg6TDahBrTsxEExZSBeV5lx6bpW0RqOZ
         4318cz1phGAVP9moE3d5HN0vfz9ixtuOtdlQLt6YU0DUcp/WwyMIky5JZJe/G/7UZ5FH
         Y1bw==
X-Gm-Message-State: APjAAAVN97dYDqlytMNbw72CyPKPs6Q6l1h7NRUFRUTVqGE/tXqiXud/
        KPpqjPilKI25woTMQvIlj1/Rz7721xg=
X-Google-Smtp-Source: APXvYqz52rK7q88C8t7FBSe+iJIoTj/N8tG/DpLuvfHMJeRqAjOygNsNnsdXhie+kIPIP/5GEAtLJQ==
X-Received: by 2002:a05:6000:1189:: with SMTP id g9mr329001wrx.51.1562804204148;
        Wed, 10 Jul 2019 17:16:44 -0700 (PDT)
Received: from raver.teknoraver.net (net-47-53-105-184.cust.vodafonedsl.it. [47.53.105.184])
        by smtp.gmail.com with ESMTPSA id g2sm3723009wmh.0.2019.07.10.17.16.43
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Wed, 10 Jul 2019 17:16:43 -0700 (PDT)
From:   Matteo Croce <mcroce@redhat.com>
To:     Joe Perches <joe@perches.com>, LKML <linux-kernel@vger.kernel.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Andy Whitcroft <apw@canonical.com>
Subject: [PATCH v2] checkpatch.pl: warn on invalid commit id
Date:   Thu, 11 Jul 2019 02:16:40 +0200
Message-Id: <20190711001640.13398-1-mcroce@redhat.com>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

It can happen that a commit message refers to an invalid commit id, because
the referenced hash changed following a rebase, or simply by mistake.
Add a check in checkpatch.pl which checks that an hash referenced by
a Fixes tag, or just cited in the commit message, is a valid commit id.

    $ scripts/checkpatch.pl <<'EOF'
    Subject: [PATCH] test commit

    Sample test commit to test checkpatch.pl
    Commit 1da177e4c3f4 ("Linux-2.6.12-rc2") really exists,
    commit 0bba044c4ce7 ("tree") is valid but not a commit,
    while commit b4cc0b1c0cca ("unknown") is invalid.

    Fixes: f0cacc14cade ("unknown")
    Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
    EOF
    WARNING: Unknown commit id '0bba044c4ce7', maybe rebased or not pulled?
    #8:
    commit 0bba044c4ce7 ("tree") is valid but not a commit,

    WARNING: Unknown commit id 'b4cc0b1c0cca', maybe rebased or not pulled?
    #9:
    while commit b4cc0b1c0cca ("unknown") is invalid.

    WARNING: Unknown commit id 'f0cacc14cade', maybe rebased or not pulled?
    #11:
    Fixes: f0cacc14cade ("unknown")

    total: 0 errors, 3 warnings, 4 lines checked

Signed-off-by: Matteo Croce <mcroce@redhat.com>
---
 scripts/checkpatch.pl | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
index a6d436809bf5..3b77279df13b 100755
--- a/scripts/checkpatch.pl
+++ b/scripts/checkpatch.pl
@@ -2898,6 +2898,17 @@ sub process {
 			}
 		}
 
+# check for invalid commit id
+		if ($in_commit_log && $line =~ /(^fixes:|\bcommit)\s+([0-9a-f]{6,40})\b/i) {
+			my $id;
+			my $description;
+			($id, $description) = git_commit_info($2, undef, undef);
+			if (!defined($id)) {
+				WARN("UNKNOWN_COMMIT_ID",
+				     "Unknown commit id '$2', maybe rebased or not pulled?\n" . $herecurr);
+			}
+		}
+
 # ignore non-hunk lines and lines being removed
 		next if (!$hunk_line || $line =~ /^-/);
 
-- 
2.21.0


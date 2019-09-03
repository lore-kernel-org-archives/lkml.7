Return-Path: <SRS0=TDKO=W6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 99A35C3A5A7
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Sep 2019 15:49:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 664A123431
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Sep 2019 15:49:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=android.com header.i=@android.com header.b="W5Fu6uYZ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729357AbfICPtN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 Sep 2019 11:49:13 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:45905 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727107AbfICPtN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Sep 2019 11:49:13 -0400
Received: by mail-wr1-f66.google.com with SMTP id q12so18001822wrj.12
        for <linux-kernel@vger.kernel.org>; Tue, 03 Sep 2019 08:49:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=android.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=KMrvGG+6F24s5MC7Y6IaVq8vPUJTYFOsulQL5TO7Nqk=;
        b=W5Fu6uYZZO+WduaX+O8aGUyvxrCbbRzcS4ahAS8IU6Gyw7Nf9+iTO97dFzlY4Yl1LW
         Nx0JlQXGgpMlk4nwHJHAowYo7tY2Y10Fr3U2Upx8tWVhgtnNbdj7KUPp7xNRPjMqSy9C
         LETM4kUAYpOWdm6oxcPunqHERPtaAxIugnY/15he9PE1t6aurBTj19DonY81W2MBA7dn
         DmnWKQMb4wAD2cD3yULH3wcYIcelNwJrGav+xR7o7f1uGD/aDnubSOltk6yrYD+BRx0e
         GIT7jxXAkO9wefk2XBKcW05k+gVaxQ59ZPVgpvLxUH8tZAf05aMykR4rEGMlSmQnHQO+
         V02A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=KMrvGG+6F24s5MC7Y6IaVq8vPUJTYFOsulQL5TO7Nqk=;
        b=ZXJDBRsb2hqeOsyLX9Ls86gg7SmPBTGRtjQ5XS4pHslKiyVpuHdpbvFExmuVMeB7gg
         x1weATEo8wt2ij4fZ2eAsP14cnlUtfhhmA+jOxvncFPOw9VMTwpiOlTBQYG4TNEdQFBw
         9gFntI3eCmyey40n7LBQyqPg/g7QAVOFqaYtMfMCI86wezt5qySeAV7CnhIutEGUvqL/
         CZFX3JwHpsUdSDheWzBHqQaeSwtfSbGQJ1J2J3QXd6yZfTDK39FJZJl1DwSHiC3L9x6x
         fJn7qj8o6eGn8MmzyDJbw8DuU7oEMpptiv9H7yS91wTocMTBhpCFyKW0tvAAU+TUgh+M
         3bng==
X-Gm-Message-State: APjAAAWbmj0owZtFHkTGMBj4wsu0xcSxul274SG0N3niqMNAViau3UDO
        F+TGmUelQRBmWq4hpH5K0X66QCLxGrvMOQ==
X-Google-Smtp-Source: APXvYqwlH3Sd7NdJ7XNxdAeQ39tZTraTn+v19KlesBg1LQ0Sq1H877gVVSvaAxc91mJw1yGhA7W2YA==
X-Received: by 2002:adf:e947:: with SMTP id m7mr30125985wrn.178.1567525750995;
        Tue, 03 Sep 2019 08:49:10 -0700 (PDT)
Received: from balsini.lon.corp.google.com ([2a00:79e0:d:210:e751:37a0:1e95:e65d])
        by smtp.gmail.com with ESMTPSA id f143sm11634889wme.40.2019.09.03.08.49.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Sep 2019 08:49:10 -0700 (PDT)
From:   Alessio Balsini <balsini@android.com>
To:     linux-kernel@vger.kernel.org
Cc:     linux-fsdevel@vger.kernel.org, kernel-team@android.com,
        Alessio Balsini <balsini@android.com>,
        Luis Chamberlain <mcgrof@kernel.org>,
        Kees Cook <keescook@chromium.org>
Subject: [PATCH] sysctl: Inline braces for ctl_table and ctl_table_header
Date:   Tue,  3 Sep 2019 16:49:06 +0100
Message-Id: <20190903154906.188651-1-balsini@android.com>
X-Mailer: git-send-email 2.23.0.187.g17f5b7556c-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix coding style of "struct ctl_table" and "struct ctl_table_header" to
have inline brances.
Before:

struct ctl_table
{
	...

After:

struct ctl_table {
	...

Besides the wide use of this proposed cose style, this change helps to
find at a glance the struct definition when navigating the code.

Signed-off-by: Alessio Balsini <balsini@android.com>
Cc: Luis Chamberlain <mcgrof@kernel.org>
Cc: Kees Cook <keescook@chromium.org>
---
 include/linux/sysctl.h | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/include/linux/sysctl.h b/include/linux/sysctl.h
index 6df477329b76e..02fa84493f237 100644
--- a/include/linux/sysctl.h
+++ b/include/linux/sysctl.h
@@ -120,8 +120,7 @@ static inline void *proc_sys_poll_event(struct ctl_table_poll *poll)
 	struct ctl_table_poll name = __CTL_TABLE_POLL_INITIALIZER(name)
 
 /* A sysctl table is an array of struct ctl_table: */
-struct ctl_table 
-{
+struct ctl_table {
 	const char *procname;		/* Text ID for /proc/sys, or zero */
 	void *data;
 	int maxlen;
@@ -140,8 +139,7 @@ struct ctl_node {
 
 /* struct ctl_table_header is used to maintain dynamic lists of
    struct ctl_table trees. */
-struct ctl_table_header
-{
+struct ctl_table_header {
 	union {
 		struct {
 			struct ctl_table *ctl_table;
-- 
2.23.0.187.g17f5b7556c-goog


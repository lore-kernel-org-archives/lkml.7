Return-Path: <SRS0=91bA=RH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6E095C43381
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Mar 2019 08:33:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3F23F208E4
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Mar 2019 08:33:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1551688386;
	bh=mWD5U+0mVrMC3GRndAsbljhYa9TCEJvHZKL+KZAl7FY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=xus+sLhL6Sg0nGeF0rjHf5Sgdx5KubEn/0lEEHvu0vb03Zp8t9Npri+iYuBfHik9t
	 BqGs31sdzxf+WxaxUU9uNScqN/S9nxVjL+Fa8St0eWHotj2/5Uys814ybrjFxVtD2A
	 SkdqD4qhtLW4GAKxtU7qYhBZPBMlFiLaeMytt17w=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727670AbfCDIdF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 Mar 2019 03:33:05 -0500
Received: from mail.kernel.org ([198.145.29.99]:37244 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728143AbfCDIdD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Mar 2019 03:33:03 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E8ACC21019;
        Mon,  4 Mar 2019 08:33:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1551688382;
        bh=mWD5U+0mVrMC3GRndAsbljhYa9TCEJvHZKL+KZAl7FY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=I8soHJdNtkGHLRg5M415rMuXo/+26xaAtmeu2+Y8+llM4GjYxUF9u2SFHzOdUGj4L
         Avquq0fLG/Ie4feDxBfx6VaX7+PhnNVR+wcejvN0Ia2xd0VIXIsWDmGjIi7MD2Qwvu
         B5RYaL5QYkN75176l8CkTXM7QkLywmum3fKI1tmU=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Shuah Khan <shuah@kernel.org>, Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.20 28/88] selftests: gpio-mockup-chardev: Check asprintf() for error
Date:   Mon,  4 Mar 2019 09:22:11 +0100
Message-Id: <20190304081631.718723847@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190304081630.610632175@linuxfoundation.org>
References: <20190304081630.610632175@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.20-stable review patch.  If anyone has any objections, please let me know.

------------------

[ Upstream commit 508cacd7da6659ae7b7bdd0a335f675422277758 ]

With gcc 7.3.0:

    gpio-mockup-chardev.c: In function ‘get_debugfs’:
    gpio-mockup-chardev.c:62:3: warning: ignoring return value of ‘asprintf’, declared with attribute warn_unused_result [-Wunused-result]
       asprintf(path, "%s/gpio", mnt_fs_get_target(fs));
       ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

Handle asprintf() failures to fix this.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Shuah Khan <shuah@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 tools/testing/selftests/gpio/gpio-mockup-chardev.c | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/tools/testing/selftests/gpio/gpio-mockup-chardev.c b/tools/testing/selftests/gpio/gpio-mockup-chardev.c
index f8d468f54e986..aaa1e9f083c37 100644
--- a/tools/testing/selftests/gpio/gpio-mockup-chardev.c
+++ b/tools/testing/selftests/gpio/gpio-mockup-chardev.c
@@ -37,7 +37,7 @@ static int get_debugfs(char **path)
 	struct libmnt_table *tb;
 	struct libmnt_iter *itr = NULL;
 	struct libmnt_fs *fs;
-	int found = 0;
+	int found = 0, ret;
 
 	cxt = mnt_new_context();
 	if (!cxt)
@@ -58,8 +58,11 @@ static int get_debugfs(char **path)
 			break;
 		}
 	}
-	if (found)
-		asprintf(path, "%s/gpio", mnt_fs_get_target(fs));
+	if (found) {
+		ret = asprintf(path, "%s/gpio", mnt_fs_get_target(fs));
+		if (ret < 0)
+			err(EXIT_FAILURE, "failed to format string");
+	}
 
 	mnt_free_iter(itr);
 	mnt_free_context(cxt);
-- 
2.19.1




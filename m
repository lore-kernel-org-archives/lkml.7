Return-Path: <SRS0=wAGj=US=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 24B43C31E5B
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Jun 2019 00:38:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E9B2620B1F
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Jun 2019 00:38:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WKAkZRSH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729163AbfFSAiC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Jun 2019 20:38:02 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:43951 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726023AbfFSAiC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Jun 2019 20:38:02 -0400
Received: by mail-pg1-f194.google.com with SMTP id f25so8581457pgv.10
        for <linux-kernel@vger.kernel.org>; Tue, 18 Jun 2019 17:38:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=agM/b/1RXAjKiubWTAZW6LuccQyVOpmmqDojN/lnWHE=;
        b=WKAkZRSHI/AYhiwsXzthvjH70oaW1GrtTg9KwScp9VvvHfezdwUwCfHZ3yqN0t7prL
         C/Py1NdsppCl/rcHWzyYMO8zs2RCObT4NGgo6iC5XJ2KmpJ5hqjTOdSFZ3n7vw1UW1B4
         MUaUclRzueAjOudiXzD5JHNzjhoxZYhzEQQ48voP8/4cEvoy7PwboB/ZkkcQXumJN1qa
         EUfid+NhIJ1/01j4fZJvd34HOur9tovNhwBUEdtnMLp9P3izEkd4us74wSKjCQ0ta1MP
         qnY2JIDaafCD9liBFTBJ3QFP1QzoHVl+nh2Q2VoACynOHOEBAv+1mCH206toANQySwxt
         FKcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=agM/b/1RXAjKiubWTAZW6LuccQyVOpmmqDojN/lnWHE=;
        b=fcILqJYBwZV6qjQw40dEo2q60+9r340QTst0JXWWY23Xun1qzCZnwnS9bFFxiFF5Ji
         FcOYfw5PylfmfTmFf6UZx+jJUCti4xHKPtobNGQi74mn6mQIJkSQhiBMn8pi2bAhmxFs
         fBQgC+gnwzhANILaEqcpHk+clWhF3SPmiIgnv/fjbY6zb6BwAwWyWCWIZuRcVolGusrA
         N0Cm1/bgVJmPL3CLRuWKFVQQrBan0qR+9K24UcbA4uxKYA4fV54Oo4qaRqLzPf/r6tq1
         aKCaBy+q5z/nM9oDg44ANLVqJi22GqNiOBCv4i7AkSO6WCE6iP5x1gKmIqBZ/FFrnSGe
         AMeA==
X-Gm-Message-State: APjAAAUxCx7k+H+Xd3mQ7xLZHBClC6k08LsvIIMFTTxfO/qn/lKlMcJ1
        gr1ZnjszzIwVVOdKXW2ArW4=
X-Google-Smtp-Source: APXvYqwco0n5stGzjoAENRb7ii/UzIYN4bk44cmg5+NkYLemziHhT4Bc78SnhsI3lcZ5mJhko1s8aA==
X-Received: by 2002:a17:90a:2567:: with SMTP id j94mr8108665pje.121.1560904681349;
        Tue, 18 Jun 2019 17:38:01 -0700 (PDT)
Received: from localhost.localdomain (c-98-210-58-162.hsd1.ca.comcast.net. [98.210.58.162])
        by smtp.gmail.com with ESMTPSA id x26sm14217860pfq.69.2019.06.18.17.37.59
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 18 Jun 2019 17:38:00 -0700 (PDT)
From:   Shobhit Kukreti <shobhitkukreti@gmail.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Bastien Nocera <hadess@hadess.net>,
        Hans de Goede <hdegoede@redhat.com>,
        Larry Finger <Larry.Finger@lwfinger.net>,
        Joe Perches <joe@perches.com>, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org,
        Shobhit Kukreti <shobhitkukreti@gmail.com>
Subject: [PATCH v4 0/3] Resolve if/else brace-style errors
Date:   Tue, 18 Jun 2019 17:37:31 -0700
Message-Id: <cover.1560903975.git.shobhitkukreti@gmail.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <20190618070019.GA20601@kroah.com>
References: <20190618070019.GA20601@kroah.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patchset fixes the following errors reported by checkpatch in the 
staging/rtl8723bs driver.

Patch[1/3]: Fix check patch error "that open brace { should be on the 
previous line"

Patch[2/3]: Fix the error else should follow close brace '}' 

Patch[3/3]: Fix Indentation Error

The patch should be applied in the sequence of 1-3. 
Each patch performs one clean up operation.

version 4 changes:
	- Moved comments to a new line
	- Removed an extra blank line

version 3 changes:
	- Converted the patch to a patchset
	- Resolve checkpatch errors:
		else should follow  close brace '}'
		Fixed Indentation Error to use tabs
	- Compiles and builds, untested on real hardware.
	
version 2 changes:
	- Removed Trailing whitespace introduced in the previous patch
        - Moved comments to a new line in the else statement

Shobhit Kukreti (3):
  staging: rtl8723bs: Resolve checkpatch error "that open brace { should
    be on the previous line" in the rtl8723 driver
  staging: rtl8723bs: Resolve the checkpatch error: else should follow
    close brace '}'
  staging: rtl8723bs: Fix Indentation Error: code indent should use tabs
    where possible

 drivers/staging/rtl8723bs/os_dep/mlme_linux.c     | 18 ++---
 drivers/staging/rtl8723bs/os_dep/recv_linux.c     | 89 ++++++++---------------
 drivers/staging/rtl8723bs/os_dep/rtw_proc.c       |  6 +-
 drivers/staging/rtl8723bs/os_dep/sdio_intf.c      | 54 ++++++--------
 drivers/staging/rtl8723bs/os_dep/sdio_ops_linux.c | 24 ++----
 5 files changed, 69 insertions(+), 122 deletions(-)

-- 
2.7.4


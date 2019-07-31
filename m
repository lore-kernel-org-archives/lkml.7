Return-Path: <SRS0=cgli=V4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 62DE3C32751
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Jul 2019 18:00:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2572E2067D
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Jul 2019 18:00:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gu1U/Sf5"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728593AbfGaSAl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 31 Jul 2019 14:00:41 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:42331 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726079AbfGaSAk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Jul 2019 14:00:40 -0400
Received: by mail-pg1-f195.google.com with SMTP id t132so32416689pgb.9;
        Wed, 31 Jul 2019 11:00:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=FRx+uLUc3KZyCAuddc+oPKsXnjik76gQN/gmEXW9OR0=;
        b=gu1U/Sf5wItTquYMTsWGjxOpKbFvX6G8j8vnPQfr8dIrUzAEdFWOp/doTNqUe/yH4x
         lmj4cyGkaJpkdDym4wZD2eekDodpvCTLSjn2vvUhsgi8UGbrXHzR9IWpTnynB+LzXllJ
         S1tuqczMFGVaEGAi89Ij8RpOSUdvbEL7NfV5XoeczdLtgevPRi3EC7tIc6ClAecSVO3X
         YL0zt7IWfXzCa81eFvv6ZUqQsATbv5UMvlXSw8g1m3HbBOIhM7LfgP4a+jknbGdGeGe5
         5TsQHmX3Xw+/qPV/I7N4NKJwn0TazchFtfm4ob7IrpasKm+NvGl9Co7GmFphAtMCh5aT
         hnIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=FRx+uLUc3KZyCAuddc+oPKsXnjik76gQN/gmEXW9OR0=;
        b=eIIdW9+se99t7aW0ilxNwzO40hCye53haNaCbdH8dgSgUdOccmFWB8n071wUlyTjVT
         qS+g9zP2Nd5JYdhtoZFCDrV6xMtzmRrMfD2a0L27iea20qZnQk1+MtSNn2n2eR6cPG6z
         KVKlOfRcHDGo42wKss9KXoo4BaO+mJ0FiuS+B24NjwNAEW1y3S4YvNrNDRRMjcZAhwlx
         JvyQnm1P84PREZ7vqvFMmnvLbWmtQWSQIreDv1I5O9cNADx9y0YKdkia8dc2cxyTw5Mb
         99Z5kENEmiMnvgLNjdyRPT9N4sHA2upZxMEpHmv6/cMRJw160H/WA9vvDFFiIdu4zNPQ
         8LdA==
X-Gm-Message-State: APjAAAVWIj/6HIan4xUmNRWQJPKVPeODhpcE2eJoyxryEKmB+HLbaHB8
        mK9r+zDfD2Z8JJ7m7d7y3r+qYnVn5Dk=
X-Google-Smtp-Source: APXvYqwZuHT7YK4tM/LtFJdXWvQ1Gru+TpgeeJWZcFRMPf9EjVmIuiH5DPpHS3XrbLf0PXy1ORaxqg==
X-Received: by 2002:a62:e910:: with SMTP id j16mr50018305pfh.123.1564596039923;
        Wed, 31 Jul 2019 11:00:39 -0700 (PDT)
Received: from host ([183.101.165.200])
        by smtp.gmail.com with ESMTPSA id e13sm86252413pff.45.2019.07.31.11.00.37
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 31 Jul 2019 11:00:39 -0700 (PDT)
Date:   Thu, 1 Aug 2019 03:00:27 +0900
From:   Joonwon Kang <kjw1627@gmail.com>
To:     keescook@chromium.org
Cc:     re.emese@gmail.com, kernel-hardening@lists.openwall.com,
        linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org,
        jinb.park7@gmail.com
Subject: [PATCH 0/2] fix is_pure_ops_struct()
Message-ID: <cover.1564595346.git.kjw1627@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

This series fixes unreachable code bug and removes dead code in
is_pure_ops_struct().

Thanks.

Joonwon Kang (2):
  randstruct: fix a bug in is_pure_ops_struct()
  randstruct: remove dead code in is_pure_ops_struct()

 scripts/gcc-plugins/randomize_layout_plugin.c | 11 ++++-------
 1 file changed, 4 insertions(+), 7 deletions(-)

-- 
2.17.1


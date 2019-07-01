Return-Path: <SRS0=3QRk=U6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1E8A5C0650E
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Jul 2019 16:18:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E718E21479
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Jul 2019 16:18:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=brauner.io header.i=@brauner.io header.b="Qh2SanT6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730281AbfGAQSN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Jul 2019 12:18:13 -0400
Received: from mail-wm1-f67.google.com ([209.85.128.67]:52291 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726863AbfGAQSN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Jul 2019 12:18:13 -0400
Received: by mail-wm1-f67.google.com with SMTP id s3so120024wms.2
        for <linux-kernel@vger.kernel.org>; Mon, 01 Jul 2019 09:18:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=brauner.io; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=d0HyjLFqpz9AWkWYsHlacSFouR7h8Dt4U9XzrYCAXZE=;
        b=Qh2SanT69fpWH1FNwV6NxjULLL62fZus+usRyKBaUUJzNzFKpmMEXwMt5zzc9RSJKD
         3n2bXJXXyrhjMZIXfoPY89kgo+PoHfvu/hvO9nVWO37nyy9fkxzmkjqBHTEURuIpYYDh
         kR4iYMY8z8iGI53pELnISjRyZb/sm1y+vscKtR8nQi071MfHTA5hi54raAbQmL0kMnlP
         OB2hfHjFCk9cfqKp1ebNAlqdE0w+hcZN3NEvmVrda7HKcOorECeHpn1TUI+BDCe0pN4C
         mHqK3M2W/x4s5DQ1YiyZsYQ3w3sPg0tixaxGw73NjwjYyf+GqzGyEpbMo8Fr94dKfDgr
         upKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=d0HyjLFqpz9AWkWYsHlacSFouR7h8Dt4U9XzrYCAXZE=;
        b=XImT/QVL4c/cU4DPcBZ7LRctuGEw0UyN1mt0tWeOsukdVGPyTSNnohFQ4feSMJHEyg
         qSxcH60tSxPs7B8S2Is4VIeq3TRY1tM9pU6u1wNR4R4vtE5jC4BpVaTBhIodwqx4jj5C
         QP7TAcvM58xGP4QnU7zwUx9xJ75htMrwLpmaMik3OOQt9Mp1M64LzRF456GZw9BsHu3s
         GUyiYzQnOX6Zy9CpV4O7lK8LhkZq13bcqaF2nLAOMX2EYBonYNtuSbax0+6ITcjs4dc5
         XM1pFFZg35sVg7xhXMDriPozAYitje/462GCcx+KjchzauanGx2ndnmFeGlPXLzDwePF
         FHVA==
X-Gm-Message-State: APjAAAUNpO4/z64KTquqDBtwUuYk0/UFQJ1dGyl/mV1Qs/G1Bx2V2URm
        Vtd0GfhZYfFGP+96B/7Lm2fRsz6K4aVLwg==
X-Google-Smtp-Source: APXvYqwjZbygo/2eQXfFWZsv3F+zfUyNoYq5phRnXb/qN3ixWwBICZ+TP81jcRVApe/jSIiw1QxsnQ==
X-Received: by 2002:a1c:e109:: with SMTP id y9mr61578wmg.35.1561997889946;
        Mon, 01 Jul 2019 09:18:09 -0700 (PDT)
Received: from localhost.localdomain (p4FC0A2B8.dip0.t-ipconnect.de. [79.192.162.184])
        by smtp.gmail.com with ESMTPSA id f7sm13654776wrv.38.2019.07.01.09.18.08
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Mon, 01 Jul 2019 09:18:09 -0700 (PDT)
From:   Christian Brauner <christian@brauner.io>
To:     torvalds@linux-foundation.org
Cc:     linux-kernel@vger.kernel.org, viro@zeniv.linux.org.uk,
        jannh@google.com
Subject: [GIT PULL] fixes for v5.2-rc8
Date:   Mon,  1 Jul 2019 18:15:03 +0200
Message-Id: <20190701161503.15254-1-christian@brauner.io>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <000000000000e0dc0d058c9e7142@google.com>
References: 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

This contains a single urgent fix for copy_process() in kernel/fork.c:

The following changes since commit 6fbc7275c7a9ba97877050335f290341a1fd8dbf:

  Linux 5.2-rc7 (2019-06-30 11:25:36 +0800)

are available in the Git repository at:

  git@gitolite.kernel.org:pub/scm/linux/kernel/git/brauner/linux tags/for-linus-20190701

for you to fetch changes up to 28dd29c06d0dede4b32b2c559cff21955a830928:

  fork: return proper negative error code (2019-07-01 16:43:30 +0200)

With Al's removal of ksys_close() from cleanup paths in copy_process() a
bug was introduced. When anon_inode_getfile() failed the cleanup was
correctly performed but the error code was not propagated to callers of
copy_process() causing them to operate on a nonsensical pointer. The fix is
a simple on-liner which makes sure that a proper negative error code is
returned from copy_process().
syzkaller has also verified that the bug is not reproducible with the patch
in this branch.

Please consider pulling these changes from the signed for-linus-20190701 tag.

Thanks!
Christian

----------------------------------------------------------------
for-linus-20190701

----------------------------------------------------------------
Christian Brauner (1):
      fork: return proper negative error code

 kernel/fork.c | 1 +
 1 file changed, 1 insertion(+)

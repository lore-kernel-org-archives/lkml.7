Return-Path: <SRS0=TxL2=YH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0D5FBECE587
	for <linux-kernel@archiver.kernel.org>; Mon, 14 Oct 2019 15:46:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D8D5B2133F
	for <linux-kernel@archiver.kernel.org>; Mon, 14 Oct 2019 15:46:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="JnB1O5Qm"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387726AbfJNPqc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 14 Oct 2019 11:46:32 -0400
Received: from mail-wm1-f67.google.com ([209.85.128.67]:37992 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729930AbfJNPqc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Oct 2019 11:46:32 -0400
Received: by mail-wm1-f67.google.com with SMTP id 3so17256754wmi.3
        for <linux-kernel@vger.kernel.org>; Mon, 14 Oct 2019 08:46:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=gqnH5u+Rmz2NG69129OK2vF9yH2mCkTespyQ46VZaP8=;
        b=JnB1O5QmG2avz0u1r/tYNyNtqVV3ZL9hHVUvFV60SIzhrPzy9leC5ZvDm19z/f4bcO
         0gRaKyu4pgOPEzDnNkaJL6I/DjcFznx8QzRIGuWuWYTY6H5XWW6Quh7P5DtfDTmACNVs
         +0MKKHGZlzVbW4Tsdmzk1TAK/wWE9YRc/JElqor1Q62XSKgfOphUyhi0KdpoPx8ExNvF
         /E+RrbHctSrcNpffZ9br7HF4gDXO+Ey38oQjG3Lv2bzfEQhKyNlOFb1522zQt4FLRiIr
         slZAZdK0wW9bxM8C7TQYVJ9TFwqG1uoMCYYkbsmbZ3pOjwuLxBe1wtaCE00K3rLOOwbA
         MsYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=gqnH5u+Rmz2NG69129OK2vF9yH2mCkTespyQ46VZaP8=;
        b=Bb0hX7i+R3QAjz/AIvx9vUoTPaa8mVYUOZCisxyI9UB/QOEPU/ZUhe+rkAzqShzd3p
         fNowxmZ/FJqu/hq/+aQ5QRVUN8/q88sb2Bp1aC1qbkuLe6rJUGF1dxe4L2zibsmlDjU0
         FNuW3lSHVcY0DDpiaKmSpa+rb7UvM+OsJxP/NtdZbWuar1Dv+JMDdUAn7UQsC5dJmkIW
         MIw8FkPpfDjZ6drh3RMH+66aAnReIXi+OkZzfcgpp9ChIiN/bz49tR4qxw6jLwClLOhK
         wDoZLPU/TaBfNnjEk+yCfhTAnhoeYnnbduRhxZJBS6HXgbiirlFIcQt0rfpBT3U5Tz7d
         bJpQ==
X-Gm-Message-State: APjAAAV8oHBhpaXS4ef4fJLq+DsSku/Tov6pd3iSUi/lZTPWNhD+b6wz
        YFsj2+hGr76T3hS+VSR+bpFFuw==
X-Google-Smtp-Source: APXvYqwGT4KOZXWes00rIf6fjnXihAP+4JZg25EojQh4Euuu0pxswSBdYFr1OfRcypxedl5j8+hG4w==
X-Received: by 2002:a7b:c7d3:: with SMTP id z19mr12069411wmk.83.1571067990478;
        Mon, 14 Oct 2019 08:46:30 -0700 (PDT)
Received: from wychelm.lan (cpc141214-aztw34-2-0-cust773.18-1.cable.virginm.net. [86.9.19.6])
        by smtp.gmail.com with ESMTPSA id q22sm16539738wmj.5.2019.10.14.08.46.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Oct 2019 08:46:29 -0700 (PDT)
From:   Daniel Thompson <daniel.thompson@linaro.org>
To:     Jason Wessel <jason.wessel@windriver.com>,
        Douglas Anderson <dianders@chromium.org>
Cc:     Daniel Thompson <daniel.thompson@linaro.org>,
        kgdb-bugreport@lists.sourceforge.net, linux-kernel@vger.kernel.org,
        patches@linaro.org
Subject: [PATCH v3 0/5] kdb: Cleanup code to read user input and handle escape sequences
Date:   Mon, 14 Oct 2019 16:46:21 +0100
Message-Id: <20191014154626.351-1-daniel.thompson@linaro.org>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

I've been meaning to repost this for some time, and inspired by
having someone keen to review it, I dug it out again!

I split this as carefully as I could into small pieces but the original
code was complex so even in small bits it doesn't make for light
reading.  Things do make more sense once you realize/remember that
escape_delay is a count down timer that expires the escape sequences!

Most of the patches are simple tidy ups although patches 4 and 5
introduce new behaviours. Patch 4 shouldn't be controversial but
perhaps patch 5 is (although hopefully not ;-) ).

Mostly this is auto tested, see here:
https://github.com/daniel-thompson/kgdbtest/commit/c65e28d99357c2df6dac2cebe195574e634d04dc

Changes in v3:

 - Accepted all review comments from Doug (except the return type
   of kdb_getchar() as discussed in the mail threads). In particular
   this fixes a bug in the handling of the btaprompt.
 - Added Doug's reviewed-by to patches 1 and 2.

Changes in v2:

 - Improve comment in patch 4 to better describe what is happening
 - Rebase on v5.4-rc2

Daniel Thompson (5):
  kdb: Tidy up code to handle escape sequences
  kdb: Simplify code to fetch characters from console
  kdb: Remove special case logic from kdb_read()
  kdb: Improve handling of characters from different input sources
  kdb: Tweak escape handling for vi users

 kernel/debug/kdb/kdb_bt.c      |  22 ++--
 kernel/debug/kdb/kdb_io.c      | 229 ++++++++++++++++-----------------
 kernel/debug/kdb/kdb_private.h |   1 +
 3 files changed, 123 insertions(+), 129 deletions(-)

--
2.21.0


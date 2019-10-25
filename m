Return-Path: <SRS0=54v9=YS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 00FABCA9EA0
	for <linux-kernel@archiver.kernel.org>; Fri, 25 Oct 2019 07:33:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CA7A621929
	for <linux-kernel@archiver.kernel.org>; Fri, 25 Oct 2019 07:33:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="cPO878sF"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2394302AbfJYHdo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 25 Oct 2019 03:33:44 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:36810 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726479AbfJYHdo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Oct 2019 03:33:44 -0400
Received: by mail-wm1-f66.google.com with SMTP id c22so914940wmd.1
        for <linux-kernel@vger.kernel.org>; Fri, 25 Oct 2019 00:33:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=AZwaHL4zUXAc+2jSAvKzwc1oPJbnq12fm9YvyXEq80U=;
        b=cPO878sFxyYN1EKPeQuJv1STDEUAJr98GQYzetFPL6WpyIB18hWX4V2ABvwFcm3jRn
         HnsZNFrinwvAzLvxMZzvJIpL1roUaOWPV5b/KsxP6gfH+Dl3YNr1GRdHpvn/qFhYbEKP
         j+mbqHQgGiGNDiADkDClK/N/Z0uDKefzLlDFpWXaO+sxM7Q4Et5kPiGde42pJYOoXypk
         Lgt12VLvP/SNW2jZe3+Ci+yoJ9bVwpfWIv4y0+g6n7FBThRxYpwPDTk9Ne09WY20+dEi
         eqnRECEquGCOjH+OuJa5aecfkdXeh5LuwxOuudonI1xS1tg+J8bW+GPItBtz4rm5zdjc
         kpYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=AZwaHL4zUXAc+2jSAvKzwc1oPJbnq12fm9YvyXEq80U=;
        b=a4gOyD3qBC0xWwYf9sfp4pGBKjXjOZ2fUN9R6Hesf29Tr2zWj8FQFs3r4WTna95T8w
         toN0DFxMoD/B/Psop5XgDTv9vWLguy2VstEFiGNRgFO/it93Rat0oqBzeHdnmymeaNGl
         POz4cb35Tc3W8B99JuBGGD7sNXd3EMrApp1294wkjV6gs1hEl2cJM21ZJ5t1WEGTT7Rk
         bqdI8yKZ/jc9vhMZCXE0diTkPja2xaiNuNzIZ9PuP4WJEGgpkX0efhOHBISLAWMueKE7
         4xKNAkawN9phzlvugB3HUSmGJTiU1/cWQdFdMv0KiExJg2to84Mjc8KcmTCR9nBQMIf2
         KDFA==
X-Gm-Message-State: APjAAAU5auvKDeisYaKxDiSuZa4lupAFQnQi/rKpgRyNSFEeNDLJoY1D
        EFbdFrdTMIyHwlPzHEo040rd/g==
X-Google-Smtp-Source: APXvYqyHtw1To5nIiVgf+IJKA3aSW6xtEhJEmCS+qT03yi8R7IUoUo5PIOyYFa+izhGvlsOZA/ldGw==
X-Received: by 2002:a1c:730e:: with SMTP id d14mr2113496wmb.165.1571988822284;
        Fri, 25 Oct 2019 00:33:42 -0700 (PDT)
Received: from wychelm.lan (cpc141214-aztw34-2-0-cust773.18-1.cable.virginm.net. [86.9.19.6])
        by smtp.gmail.com with ESMTPSA id a11sm1586602wmh.40.2019.10.25.00.33.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Oct 2019 00:33:41 -0700 (PDT)
From:   Daniel Thompson <daniel.thompson@linaro.org>
To:     Douglas Anderson <dianders@chromium.org>,
        Jason Wessel <jason.wessel@windriver.com>
Cc:     Daniel Thompson <daniel.thompson@linaro.org>,
        kgdb-bugreport@lists.sourceforge.net, linux-kernel@vger.kernel.org,
        patches@linaro.org
Subject: [PATCH v4 0/5] kdb: Cleanup code to read user input and handle escape sequences
Date:   Fri, 25 Oct 2019 08:33:23 +0100
Message-Id: <20191025073328.643-1-daniel.thompson@linaro.org>
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

Changes in v4:

 - Sorry this is late. Looks like I got so distracted by testing the
   series I forgot to post it to the lists.
 - Introduced kdb_handle_escape() in patch 1 (instead of renaming it
   in the middle of the patch series) and documented it in kernel doc
   format.
 - Adopted do {} while for the character fetch loop in kdb_bt.c
 - Added Doug's reviewed-by to the remaining patches. The kept them
   despite the subtle internal reorg w.r.t. kdb_handle_escape() since
   the whole patchset has changed little since he last saw it (beyond
   fixing his review comments).

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
 kernel/debug/kdb/kdb_io.c      | 231 ++++++++++++++++-----------------
 kernel/debug/kdb/kdb_private.h |   1 +
 3 files changed, 125 insertions(+), 129 deletions(-)

--
2.21.0


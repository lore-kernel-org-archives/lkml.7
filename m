Return-Path: <SRS0=XKeO=YB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3E210C4360C
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Oct 2019 13:21:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0F928206C0
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Oct 2019 13:21:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="cNq1Ed5G"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730751AbfJHNVA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 8 Oct 2019 09:21:00 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:45128 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730316AbfJHNVA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Oct 2019 09:21:00 -0400
Received: by mail-wr1-f66.google.com with SMTP id r5so19320763wrm.12
        for <linux-kernel@vger.kernel.org>; Tue, 08 Oct 2019 06:20:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=6RWTxHt7zKzXfYPhwl9vO4EuXYxc6AyULIB2uI0LmfM=;
        b=cNq1Ed5GzasuMH1y9ug9vDcF22n6vlCP/1FO1m7fvDDoOLyWcX78rM8DONBByZA2Zb
         Gskb17VHPu1a9HWj7EH6TUDdxGVoicMlQ8W4qJXy+KRz5k4fm4PhFv4GHsHPJIQZ0Jqv
         GP5fDn3k5yyZUj3xjRbO/gO9AhSkqWdcKF8oS8v1uoaZ/BGUMHbum5nXQMcC40RhxHlV
         w+ByZ3LHXh9535tKnWf0DaHjjJT+4kf2nE6JHLzzUkIjNOrTvmony6bF22PctzqqJVoh
         vD50IGmZjnoAJS+P767MtqDmVQhDU1LXnjxuuDiKemFKb5wqjt1PLxlzpNFpd6KwOSji
         f6TA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=6RWTxHt7zKzXfYPhwl9vO4EuXYxc6AyULIB2uI0LmfM=;
        b=XkN7sKsUc/7JjF6zPiyXCKBYn2xLFuMIEkgm62H4VXUtTk5KY9fq2YEQkejMPePhb4
         PTIXSzCLMmejKdhWoKZluslS7qKo1cYEzIpzWtWqL3tZZkSTBO+Po+RFqmXWjrf+kwrO
         42yODFn7ULRMdiztPaD1k00Pkdzg8CA5rJiculq3I0mem6BcUFBMDaOK8yM7OFokNR06
         uO8iC8sV1Pj9+RrWdNYQUu4eWOiY2DeFMrNvnSq0AdXn33EaOgIWQCdeCa0Viytxf+Mo
         fvvh83+2YMSvds4pEExpb7nhIsbm3jyuxbO3D82MzDuvWUk1aJu4XDSm8vS87Qwp3oZu
         vfOw==
X-Gm-Message-State: APjAAAUEuvyryDlGeL68cuTKDdiFNIHTNiaJmYkyAlLpYSyn7n8Nc+/X
        DRMGc5aCCKg8p+/dyNxuSlNf8w==
X-Google-Smtp-Source: APXvYqyCXe2mCxlJgegBeQiMsMW/DceUIxnKsxEr5RLMHNcvj7L1A4ab4Pzav+WZ/SrQVlRdEVrk/g==
X-Received: by 2002:a05:6000:1204:: with SMTP id e4mr20944912wrx.5.1570540857894;
        Tue, 08 Oct 2019 06:20:57 -0700 (PDT)
Received: from wychelm.lan (cpc141214-aztw34-2-0-cust773.18-1.cable.virginm.net. [86.9.19.6])
        by smtp.gmail.com with ESMTPSA id t8sm18237214wrx.76.2019.10.08.06.20.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Oct 2019 06:20:57 -0700 (PDT)
From:   Daniel Thompson <daniel.thompson@linaro.org>
To:     Jason Wessel <jason.wessel@windriver.com>,
        Douglas Anderson <dianders@chromium.org>
Cc:     Daniel Thompson <daniel.thompson@linaro.org>,
        kgdb-bugreport@lists.sourceforge.net, linux-kernel@vger.kernel.org,
        patches@linaro.org
Subject: [PATCH v2 0/5] kdb: Cleanup code to read user input and handle escape sequences
Date:   Tue,  8 Oct 2019 14:20:38 +0100
Message-Id: <20191008132043.7966-1-daniel.thompson@linaro.org>
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

Changes in v2:

 - Improve comment in patch 4 to better describe what is happening
 - Rebase on v5.4-rc2

Daniel Thompson (5):
  kdb: Tidy up code to handle escape sequences
  kdb: Simplify code to fetch characters from console
  kdb: Remove special case logic from kdb_read()
  kdb: Improve handling of characters from different input sources
  kdb: Tweak escape handling for vi users

 kernel/debug/kdb/kdb_io.c | 222 ++++++++++++++++++--------------------
 1 file changed, 103 insertions(+), 119 deletions(-)

--
2.21.0


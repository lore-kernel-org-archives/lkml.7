Return-Path: <SRS0=FrXW=TP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EAAD2C04E53
	for <linux-kernel@archiver.kernel.org>; Wed, 15 May 2019 21:36:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BA4532084F
	for <linux-kernel@archiver.kernel.org>; Wed, 15 May 2019 21:36:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=joelfernandes.org header.i=@joelfernandes.org header.b="pLODJpLN"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726995AbfEOVgG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 15 May 2019 17:36:06 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:39575 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726642AbfEOVgG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 May 2019 17:36:06 -0400
Received: by mail-pg1-f193.google.com with SMTP id w22so427351pgi.6
        for <linux-kernel@vger.kernel.org>; Wed, 15 May 2019 14:36:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Lj20BWGa/SSqkCUWhiNbUp+2jcIFFr5rWtfoPrCsSoQ=;
        b=pLODJpLNTPnjKZE6jiCeKVcXugMyLtlONq+lmg6tPOtTzJj46GJOU6Cf+nCpBKO8Gl
         QuPx22/EvuL7Mr6XG7dpT5RWwvPsfXc8SjNKuFgXNwGZ+VH8P/PM3RgZU3YOnnasoalh
         bPKxFuh4a8fB5IVVNP9Jhftas1hXtKt5gUvik=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Lj20BWGa/SSqkCUWhiNbUp+2jcIFFr5rWtfoPrCsSoQ=;
        b=UK/0VXhDV+BQ6jh0mmdH6Od0GQLHmniQPiSrZ8yz/45YEL/qRa0haU+6R5bA8WzQmn
         UlynFD2SGc18icVmpCRmqhP50ydtxPrLlhBmCtqNUufPC+idqnilx5GXpQESYWhjoJZ3
         aYGtIj47STunGwvEdYCUDE4APsHPIMQlLa2XF8bFkWAY0ehgv0N9lWdM4wPZrxug4v0O
         2yCMbEPNuxAsksOSzmzVpURRHKMWqeoN2DbLXldDtEEkECrGfTMGqAkskDc9N9vHvJdk
         pAX0v1nwQcnzTMrqMXNlKEvRnfDqsuUEvtZlK5hI6FYuw8kyijuAb3aylJ6uCMtjMZwJ
         LDoA==
X-Gm-Message-State: APjAAAW2mX/7Texb15/MMfnBDsmD5pr05nHS0WrR1CXSJvtxxPsBhRZm
        VDjz/WJtEWESWO9kclfCLEaYTeQixn8=
X-Google-Smtp-Source: APXvYqyBnOgRxt8JiSmMw1XdoLOfLDNy0r57NqMlPQGJOPaLskNz2bSXh1R4oaRAS8sq2GtwOuxxpQ==
X-Received: by 2002:a63:f410:: with SMTP id g16mr15243189pgi.428.1557956165115;
        Wed, 15 May 2019 14:36:05 -0700 (PDT)
Received: from joelaf.cam.corp.google.com ([2620:15c:6:12:9c46:e0da:efbf:69cc])
        by smtp.gmail.com with ESMTPSA id q4sm3695279pgb.39.2019.05.15.14.36.00
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Wed, 15 May 2019 14:36:03 -0700 (PDT)
From:   "Joel Fernandes (Google)" <joel@joelfernandes.org>
To:     linux-kernel@vger.kernel.org
Cc:     "Joel Fernandes (Google)" <joel@joelfernandes.org>,
        Adrian Ratiu <adrian.ratiu@collabora.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>, atishp04@gmail.com,
        bpf@vger.kernel.org, Brendan Gregg <bgregg@netflix.com>,
        Brendan Gregg <brendan.d.gregg@gmail.com>, dancol@google.com,
        Daniel Borkmann <daniel@iogearbox.net>,
        Dan Williams <dan.j.williams@intel.com>,
        dietmar.eggemann@arm.com, duyuchao <yuchao.du@unisoc.com>,
        gregkh@linuxfoundation.org, Guenter Roeck <groeck@chromium.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Karim Yaghmour <karim.yaghmour@opersys.com>,
        Kees Cook <keescook@chromium.org>, kernel-team@android.com,
        linux-doc@vger.kernel.org, linux-kselftest@vger.kernel.org,
        linux-trace-devel@vger.kernel.org,
        Manjo Raja Rao <linux@manojrajarao.com>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        =?UTF-8?q?Micha=C5=82=20Gregorczyk?= <michalgr@fb.com>,
        Michal Gregorczyk <michalgr@live.com>,
        Mohammad Husain <russoue@gmail.com>,
        Olof Johansson <olof@lixom.net>, qais.yousef@arm.com,
        rdunlap@infradead.org, rostedt@goodmis.org,
        Shuah Khan <shuah@kernel.org>,
        Srinivas Ramana <sramana@codeaurora.org>,
        Tamir Carmeli <carmeli.tamir@gmail.com>, yhs@fb.com
Subject: [PATCH v4 0/2] kheaders fixes for -rc
Date:   Wed, 15 May 2019 17:35:50 -0400
Message-Id: <20190515213552.203737-1-joel@joelfernandes.org>
X-Mailer: git-send-email 2.21.0.1020.gf2820cf01a-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Linus, Greg, Masahiro, Here are some simple fixes for the kheaders feature.
Please consider these patches for an rc release. They are based on Linus's
master branch. The only difference between the last series [1] and this one is
I squashed 1/3 and 3/3 and rebased.  Thanks!

[1] https://patchwork.kernel.org/cover/10939557/

Joel Fernandes (Google) (2):
kheaders: Move from proc to sysfs
kheaders: Do not regenerate archive if config is not changed

init/Kconfig                                | 17 +++++----
kernel/Makefile                             |  4 +--
kernel/{gen_ikh_data.sh => gen_kheaders.sh} | 17 ++++++---
kernel/kheaders.c                           | 40 +++++++++------------
4 files changed, 38 insertions(+), 40 deletions(-)
rename kernel/{gen_ikh_data.sh => gen_kheaders.sh} (82%)

--
2.21.0.1020.gf2820cf01a-goog


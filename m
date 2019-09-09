Return-Path: <SRS0=hqT0=XE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 05765C433EF
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Sep 2019 08:16:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C24E620678
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Sep 2019 08:16:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hjToWIKM"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388867AbfIIIQC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 9 Sep 2019 04:16:02 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:33236 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388846AbfIIIQC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Sep 2019 04:16:02 -0400
Received: by mail-pg1-f196.google.com with SMTP id n190so7395966pgn.0;
        Mon, 09 Sep 2019 01:16:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=xo9CxSyoQ0CHZmaLVWqyldkLf50Cga4Ofde0KKklV7g=;
        b=hjToWIKMAkWAdQ6XG7oGmxIUUPnR8XGvUY8guWwxiq8ntqBNw2MeAGwBjEZ699mMJj
         fuRjtR6n5zXAYj9I5uDxsMrnypirEXuBtcjA682dMwipAuuNJoi1yqwOpONmnmHNVR6/
         P5BKSrGkdPFbmULh0Ce70eXBZ3sx/88lZZxOpdJNk20Dmqyee2aMLERlbQmg2Ci5lq4k
         Bl4HZhyUVq7WHXxI5zTdEQQPDu3kz4bUst8oUpwSykGTnk9fDLb1LxJ9VmMW5ejyDZ1G
         m9oj+FFlk7HSx2F8SfSIhaEup5SK03sEwZEEeCGsl8eO7LLnvhG7LOuCpu3aT85Cbjdr
         x26A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=xo9CxSyoQ0CHZmaLVWqyldkLf50Cga4Ofde0KKklV7g=;
        b=LGGeJWBky9+LX0L7++Vtzn0pcE4rk+pQSFIuVpIGQldPjZIh5Il+67YL2AomRWw/fJ
         +2PtYbLFKLd1sGkhkSoi0apyNrc/5kS7/c7jMi8hK4lp6VoOb/73WnZqz2YMcP8Mw9QX
         yT6DPr4U2PWbLViI4megbmK/PNFw7oPd5nzc+a2s08KCwqh4ztdGm3jEXvMLRkmiq+Cw
         d7cu9ZSDkuS+3nisSiAJl+FG6xfOXyNI2+vxMDiUsxGxAKOYBoV2k02j5RUr10klPKfV
         DAqGpolB0T2WPxbyr52/aLD1e5Lz1GQCNvfsITbGXs29zY7NeeRwZpXDt8yQSSKgq7Nb
         ycIA==
X-Gm-Message-State: APjAAAVhs6Qw2CkU4uhos7FyFT34GK4hd+JeonbMJCATaqZdgckgZGn2
        6SY5EEkanwjwppo1ZNS0kU0=
X-Google-Smtp-Source: APXvYqxgJwJLbLbYzmC+ON7eAhJZPRv0vKs96O3fOZpekEMnckh9v2nh5rhT/ro60HkaFONusIpEqw==
X-Received: by 2002:aa7:8592:: with SMTP id w18mr26574825pfn.237.1568016960833;
        Mon, 09 Sep 2019 01:16:00 -0700 (PDT)
Received: from dtor-ws.mtv.corp.google.com ([2620:15c:202:201:3adc:b08c:7acc:b325])
        by smtp.gmail.com with ESMTPSA id u65sm12686669pfu.104.2019.09.09.01.15.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Sep 2019 01:16:00 -0700 (PDT)
From:   Dmitry Torokhov <dmitry.torokhov@gmail.com>
To:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        linux-kernel@vger.kernel.org, platform-driver-x86@vger.kernel.org
Subject: [PATCH v3 00/13] software node: add support for reference properties
Date:   Mon,  9 Sep 2019 01:15:44 -0700
Message-Id: <20190909081557.93766-1-dmitry.torokhov@gmail.com>
X-Mailer: git-send-email 2.23.0.187.g17f5b7556c-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

These series implement "references" properties for software nodes as true
properties, instead of managing them completely separately.

The first 10 patches are generic cleanups and consolidation and unification
of the existing code; patch #11 implements PROPERTY_EMTRY_REF() and friends;
patch #12 converts the user of references to the property syntax, and patch
#13 removes the remains of references as entities that are managed
separately.

Changes in v3:
- added various cleanups before implementing reference properties

Changes in v2:
- reworked code so that even single-entry reference properties are
  stored as arrays (i.e. the software_node_ref_args instances are
  not part of property_entry structure) to avoid size increase.
  From user's POV nothing is changed, one can still use PROPERTY_ENTRY_REF
  macro to define reference "inline".
- dropped unused DEV_PROP_MAX
- rebased on linux-next

Dmitry Torokhov (13):
  software node: remove DEV_PROP_MAX
  software node: clean up property_copy_string_array()
  software node: get rid of property_set_pointer()
  software node: simplify property_get_pointer()
  software node: remove property_entry_read_uNN_array functions
  software node: unify PROPERTY_ENTRY_XXX macros
  software node: simplify property_entry_read_string_array()
  software node: introduce PROPERTY_ENTRY_ARRAY_XXX_LEN()
  efi/apple-properties: use PROPERTY_ENTRY_U8_ARRAY_LEN
  software node: rename is_array to is_inline
  software node: implement reference properties
  platform/x86: intel_cht_int33fe: use inline reference properties
  software node: remove separate handling of references

 drivers/base/swnode.c                    | 243 +++++++----------------
 drivers/firmware/efi/apple-properties.c  |   8 +-
 drivers/platform/x86/intel_cht_int33fe.c |  81 ++++----
 include/linux/property.h                 | 154 +++++++-------
 4 files changed, 198 insertions(+), 288 deletions(-)

-- 
2.23.0.187.g17f5b7556c-goog


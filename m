Return-Path: <SRS0=Kqgt=XG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0AFC6ECDE20
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Sep 2019 05:12:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CC7E321A4C
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Sep 2019 05:12:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jdl4R9OB"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726719AbfIKFMg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 11 Sep 2019 01:12:36 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:39090 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725379AbfIKFMg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Sep 2019 01:12:36 -0400
Received: by mail-pf1-f196.google.com with SMTP id i1so4042060pfa.6;
        Tue, 10 Sep 2019 22:12:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=rZNyXpEzQutbsjHDJX6LxKD82IhI48MXw89jA3LWwJE=;
        b=jdl4R9OBzj7aWR/izSqAkbCbWSpLJODhZk2KGhuRZnIqmhTthemF/w1NuCaMaKgBHH
         yWHBf6YvZJAe1IpqWE4A1JEKy7Y7SR0T7zA4QSS3dZgyk8Ub6oWUgfgAcwSK3+n7u0o4
         dD4878tb8oWqG02VbMkEwjhj53aOK7Wng/6LTfRFFqB5aJq/Mvs+YTZFXlsAXSQvmVFc
         zMeD1upHa5/E7pdjid2b+7g73F6YDgfBeeVkmMLOHgXRpPQ00IWBTj9n3Pu31gxRXEOO
         eym569kfS9zaIalGzTu/xMGetWFwkiifyMUh9/FeNdm6GWbIK9iR5RMB37L10JFj+Fn7
         f97w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=rZNyXpEzQutbsjHDJX6LxKD82IhI48MXw89jA3LWwJE=;
        b=N8nyRN/DuGuUTgQC0tLCdP2vH+u8xTnVPRQDMNidx8ov4aqwDWRtDOCRLRhOFSLML+
         AFAup0VpSncllik3oBMldbtXNsfV/Pf+QQo+1cDjamMdtnyJzXMNPPb0+/FSVBsHEau4
         NdPoXxSqKPc/Ws65PKZ4G+aImFCz4VHeThn1WGkszs0gVRv5kVIVk8YSabihwSOLg6W4
         S3RNLOuMc0Bth5Bf9pebrsSCuoDhQG35Plcej5FOEPmcfpX71ea4myzU/eyku7FLTsT3
         BdqwH7aNJOf3RBbEb4CvuVNvWsms3EFbppJ36hfBaTLqIvNeMlz63qS3lU+1xqHck0B8
         Dy7A==
X-Gm-Message-State: APjAAAUcq9DljX2reHn7xr1n0DjC05EpoqvfHFGZNIJaW8aGBd6Ol+Th
        6KAjtbTMdm8YhlSMS4FMFWo=
X-Google-Smtp-Source: APXvYqxtjHuUPFRSWw3me57nzF0FGN7Skq2i2yaEdj3wEWAnSTCdr4sNuEPWu0m+4PkQDuLEnWsYwQ==
X-Received: by 2002:a63:5920:: with SMTP id n32mr25475307pgb.352.1568178755371;
        Tue, 10 Sep 2019 22:12:35 -0700 (PDT)
Received: from dtor-ws.mtv.corp.google.com ([2620:15c:202:201:3adc:b08c:7acc:b325])
        by smtp.gmail.com with ESMTPSA id p11sm22011149pff.136.2019.09.10.22.12.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Sep 2019 22:12:34 -0700 (PDT)
From:   Dmitry Torokhov <dmitry.torokhov@gmail.com>
To:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        linux-kernel@vger.kernel.org, platform-driver-x86@vger.kernel.org
Subject: [PATCH v4 00/14] software node: add support for reference properties
Date:   Tue, 10 Sep 2019 22:12:17 -0700
Message-Id: <20190911051231.148032-1-dmitry.torokhov@gmail.com>
X-Mailer: git-send-email 2.23.0.162.g0b9fbb3734-goog
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

Changes in v4:
- dealt with union aliasing concerns
- inline small properties on copy

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


Dmitry Torokhov (14):
  software node: remove DEV_PROP_MAX
  software node: introduce PROPERTY_ENTRY_ARRAY_XXX_LEN()
  efi/apple-properties: use PROPERTY_ENTRY_U8_ARRAY_LEN
  software node: mark internal macros with double underscores
  software node: clean up property_copy_string_array()
  software node: get rid of property_set_pointer()
  software node: remove property_entry_read_uNN_array functions
  software node: unify PROPERTY_ENTRY_XXX macros
  software node: simplify property_entry_read_string_array()
  software node: rename is_array to is_inline
  software node: move small properties inline when copying
  software node: implement reference properties
  platform/x86: intel_cht_int33fe: use inline reference properties
  software node: remove separate handling of references

 drivers/base/swnode.c                    | 266 ++++++++---------------
 drivers/firmware/efi/apple-properties.c  |  18 +-
 drivers/platform/x86/intel_cht_int33fe.c |  81 +++----
 include/linux/property.h                 | 177 +++++++--------
 4 files changed, 230 insertions(+), 312 deletions(-)

-- 
2.23.0.162.g0b9fbb3734-goog


Return-Path: <SRS0=zem1=X3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 18BC5C352AA
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Oct 2019 07:20:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E00842246E
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Oct 2019 07:20:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20150623.gappssmtp.com header.i=@bgdev-pl.20150623.gappssmtp.com header.b="GmwYcG1x"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726434AbfJBHUy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 2 Oct 2019 03:20:54 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:46772 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726010AbfJBHUy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Oct 2019 03:20:54 -0400
Received: by mail-wr1-f65.google.com with SMTP id o18so18263612wrv.13
        for <linux-kernel@vger.kernel.org>; Wed, 02 Oct 2019 00:20:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=I5mMX5EtUi8CNbu12Q9es5bMrtSxH0QcA+G46hT8nEk=;
        b=GmwYcG1xRM7oCgwZMxdz8kS0k/HgCjChHWiSixwcSHU7CE/xVd6kYvQAHnXPxauChG
         gzgIrnoxWDzc0w6XQu9JbpYPY0gEKwRCO3iaGyK5yS/jPzSMvWWPHfC3qa1PqmlmrkCk
         I56oxAHzTAMHUJePLW667evPLYYV0+jd14mPyzBW5WBQR8pMuyn5qpaCAx2/z+g8abec
         eZOba+wk9l/pUXanDazIhzt1ljlV9P/YOWEOlfruaxublHe0QvkNHon6ufhaDHzUJ4Hk
         oPZTnE9dgs8qaY/jhIbsRzjSLEAeRDXyMAbgzQo+xZWbMi6um2NuahWs36OKVpC6wSiP
         F9bg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=I5mMX5EtUi8CNbu12Q9es5bMrtSxH0QcA+G46hT8nEk=;
        b=fdusua5MyQspLrvt+gXxA2noJNjHG8ak9R80006Tr73SbbFh9E48PE1eB8gQa+QigF
         pwbMPxM9EXI/fU9H/TBStwp2i0MUTRYVowdRDf31J3Zzx9zXA+zOE/sQe6YxyGmoM6ln
         idMzJ0w7k51Ca8HUiOMZpRgNsPne1WW32wKR1+YN1hJDr439bqdpQghOJplFL3urF009
         KoCxLyUxU/V23oCDH5G8B8/i7Lfrhpz4z3Xvp+4pfZcVL78Ld20jzsuhjtpy+oZOlW09
         wiwgZB7BtGyEFucnrxNhM5kpyLUcng9Pr0Nn2Lio9CFei26jBvUAZ4FjvL4gJ7r2w/vn
         4+Hg==
X-Gm-Message-State: APjAAAV26VBX3OS+uJBF4vQJJEuNgk5Zq08OVKdAZIuBxag5CywLc+UL
        2DcxW5HxCh5LpMGWgQdiaoyX8Q==
X-Google-Smtp-Source: APXvYqyLndtFY5nV6iky84P19MJ6vsM4+DVhKRevPzYk9ocz+Ooq2niL0Ty+HsoJ4cGaRyJJSlrZtA==
X-Received: by 2002:a5d:490f:: with SMTP id x15mr1337565wrq.375.1570000851693;
        Wed, 02 Oct 2019 00:20:51 -0700 (PDT)
Received: from debian-brgl.home ([2a01:cb1d:af:5b00:6d6c:8493:1ab5:dad7])
        by smtp.gmail.com with ESMTPSA id n18sm3850640wmi.20.2019.10.02.00.20.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Oct 2019 00:20:51 -0700 (PDT)
From:   Bartosz Golaszewski <brgl@bgdev.pl>
To:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Peter Rosin <peda@axentia.se>
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-i2c@vger.kernel.org,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>
Subject: [PATCH v6 0/2] at24: convert the binding document to yaml
Date:   Wed,  2 Oct 2019 09:20:45 +0200
Message-Id: <20191002072047.20895-1-brgl@bgdev.pl>
X-Mailer: git-send-email 2.23.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Bartosz Golaszewski <bgolaszewski@baylibre.com>

The first patch converts the at24 DT binding to yaml. The second adds a new
compatible special case that's being used undocumented currently.

v1 -> v2:
- modified the compatible property: we now list all possible combinations and
  non-standard types with appropriate fallbacks to be as strict as possible
- minor changes to other properties: added constraints, converted to enums
  where applicable and referenced the types from schema

v2 -> v3:
(Rob Herring:)
- Here's my reworking of compatible schema and all the other fixes I
  found. The inner 'oneOf' is probably a little excessive given the number
  of lines. All it does is ensure both compatible strings have the same
  part number.

v3 -> v4:
- Add a $nodename definition
- Turns out the compatible schema is too complex for generating a 'select'
  schema and only a small subset where getting validated. So we need a
  custom 'select' schema. This in turn fixes the issue with the nxp,se97b
  binding.

v4 -> v5:
- added a new patch extending the list of special cases of the compatible
  property
- added comments explaining the schema for the compatible property
- dropped redundant information from property descriptions (for instance:
  there's no need to say "This parameterless property" where it's obvious
  from the type that the property is a flag)

v5 -> v6:
- common 'compatible' schema prevents non-unique compatible items, so remove
  that part of the comment
- add missing cs and mac variants to the list of patterns

Bartosz Golaszewski (2):
  dt-bindings: at24: convert the binding document to yaml
  dt-bindings: at24: add new compatible

 .../devicetree/bindings/eeprom/at24.txt       |  90 +--------
 .../devicetree/bindings/eeprom/at24.yaml      | 188 ++++++++++++++++++
 MAINTAINERS                                   |   2 +-
 3 files changed, 190 insertions(+), 90 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/eeprom/at24.yaml

-- 
2.23.0


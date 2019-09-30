Return-Path: <SRS0=rUXN=XZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 151C8C4360C
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Sep 2019 09:00:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DAED72190F
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Sep 2019 09:00:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20150623.gappssmtp.com header.i=@bgdev-pl.20150623.gappssmtp.com header.b="Lyn76f9v"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730338AbfI3JAE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 30 Sep 2019 05:00:04 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:39060 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729913AbfI3JAD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Sep 2019 05:00:03 -0400
Received: by mail-wr1-f67.google.com with SMTP id r3so10294310wrj.6
        for <linux-kernel@vger.kernel.org>; Mon, 30 Sep 2019 02:00:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=zZOeGM5g/Vz9YvHwPN9vC5aUhVnW5UBfYl9eXafNvf4=;
        b=Lyn76f9vD1MZGZC0CloZWBFzuZYEgPQGHGJSrCqM8zunxYseXKWs1vbWY6X8A+vmJW
         vS1HOMDwoPjsLB13IMwWC7DlI3jNHxuHpuAxz/MtsdnVQ34iPjbQcPwKXHhsR+wRj6D1
         /H/zZaSDfNVJq2CUJea5tlZaaimiGB/0ag8+AyWPpW7lMwIz5FUy54sXSOxkbY1dHipL
         Oxt5fyySLlL1axoxnkurOoDbGAygEfcXbayskuydVoi6+vTjR4rcPjQE9xsye0LjD6F2
         /SUPKvUCM4GSeZ5BwxBJ5rITYUpEIxtNfgWScobQC2v38UlIk7AbMykuX9BdXkbh7VFt
         ELiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=zZOeGM5g/Vz9YvHwPN9vC5aUhVnW5UBfYl9eXafNvf4=;
        b=rl93zxAzKRLjz6BJrBGGLw5EeMdJa+45uN+0B7I6MvYSyRJg7td1GEUzoUW7D57W9E
         9hDr+xAa82cZW13QWQ7q7ofrJoKRVzLBLtTgticnD6dTP4KDRppdjrAtFzcef9lkM++W
         lRgCaWu1w+5GCy37ywg4gXaMX7SBQ7houhBVLS0XnlQGDFeqG0ruAZPL6HC4oAw34IcW
         kZPmRVxG6dbsgon8voWhnrjBrpjAeZx+3LNrfyqfp28KraH+eFoBoaK9za4sO8q4xmeL
         Kmp2TmU5P7TLPwWDt5aoviIUgBVT8+5DD+i9HOWRTWSKs08V37feqmGvOKoblXbJ6XKh
         mZ+A==
X-Gm-Message-State: APjAAAURHbsOmuARfDnGPHopJEjkE3rMpDCQoq3Y5kby6GNHSz6xhP+J
        06ed64d27zKzVUWItLS/IcrrYQ==
X-Google-Smtp-Source: APXvYqzgCmHxkg3EEizdZWBORXV/wp7zumSABBrw5OtQ2GXhrX25c7fTmSGeo5QBXPfJGTITe3vDhQ==
X-Received: by 2002:adf:9029:: with SMTP id h38mr12058351wrh.155.1569834001777;
        Mon, 30 Sep 2019 02:00:01 -0700 (PDT)
Received: from localhost.localdomain (amontpellier-652-1-281-69.w109-210.abo.wanadoo.fr. [109.210.96.69])
        by smtp.gmail.com with ESMTPSA id m18sm12665723wrg.97.2019.09.30.02.00.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Sep 2019 02:00:01 -0700 (PDT)
From:   Bartosz Golaszewski <brgl@bgdev.pl>
To:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Peter Rosin <peda@axentia.se>
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-i2c@vger.kernel.org,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>
Subject: [PATCH v5 0/2] at24: convert the binding document to yaml
Date:   Mon, 30 Sep 2019 10:59:55 +0200
Message-Id: <20190930085957.2779-1-brgl@bgdev.pl>
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

Bartosz Golaszewski (2):
  dt-bindings: at24: convert the binding document to yaml
  dt-bindings: at24: add new compatible

 .../devicetree/bindings/eeprom/at24.txt       |  90 +--------
 .../devicetree/bindings/eeprom/at24.yaml      | 182 ++++++++++++++++++
 MAINTAINERS                                   |   2 +-
 3 files changed, 184 insertions(+), 90 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/eeprom/at24.yaml

-- 
2.23.0


Return-Path: <SRS0=BIzH=UB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9F1ECC282DC
	for <linux-kernel@archiver.kernel.org>; Sun,  2 Jun 2019 14:13:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7350F2793B
	for <linux-kernel@archiver.kernel.org>; Sun,  2 Jun 2019 14:13:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ci5MFymq"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726776AbfFBONc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 2 Jun 2019 10:13:32 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:39309 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726084AbfFBONc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 2 Jun 2019 10:13:32 -0400
Received: by mail-pg1-f193.google.com with SMTP id 196so6739542pgc.6
        for <linux-kernel@vger.kernel.org>; Sun, 02 Jun 2019 07:13:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=SaAxieWedSqrCsn1eZtk8frpM0Ozx5cj9+gtVFSLioA=;
        b=ci5MFymqmwyE1FbHvEUfTWoN9KfK0OOI8NC4x1fak7yQ+UO43KiT5st644PeuhVHSR
         RnM5tB9j97yPVNtOAWf8Wd0gRoHtOuZirqjmcAWexxhFIlVbLAEAgMqJlH3RfUrbSxbe
         fKwUpyDq8w1UkKUJkqMLT70YFv+sonJx8y3O53sQgJTpH4t1j53mN6pXq9vGPNohEU2l
         AS9J8HkBwPAGhe1hu6VpdwEkz3OPvSHiYhIAiyn7CX0CHHv+jXkBP77TsVSpHePYFK6t
         OvGHIr3m7lcg8amxRuXA3TXkqqxdIBsmn+7uBlaFvMPX5bWLbIFi9YgHU3ddP6j+FfD3
         DDXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=SaAxieWedSqrCsn1eZtk8frpM0Ozx5cj9+gtVFSLioA=;
        b=aFhj04SDVMGAR2wsH12jZCN3G6f0Ifq9IP9JWNGreOBx+WwQlsziJJ/FiOOUqk4KFr
         /vThc2UQzl7R3+TFvTlz+Hcrkt9D9FRTmdxMi3QoSc6GA29VlSR3ew91Jy7UwkzPLgSe
         id1+acJBWJYqpgwOF/ueGUO5frtTkEEkYVDOC721ILYQTyGbaUzHzbdS9HHtAnQfwQwr
         cvw/cwKhN+HouoYEDKe82nXJN04LcjsvSmBe+jQYWVhTN12qGNa1nEwDGoGaQxjDF9xw
         Lg5Pqaqd7kDTagry8WlPZwVhDMicDxVtKbjm8Gek5+NN9C+1g6C3k84t5nYQQQlIY3TO
         c44A==
X-Gm-Message-State: APjAAAX3h8wKsH1viRmNqnB26SBrWkcufwbCBiz5JJ/mooX2VsRosaNY
        ZtmLyYGfTyUssO0QR5gbJfw=
X-Google-Smtp-Source: APXvYqwpOneLZKkuOl7f486zM64Y/OQvcykbdFN1AY/pSfx4mQUe+lKV76ssomb8gqFClbHS4hrnNw==
X-Received: by 2002:a17:90a:a608:: with SMTP id c8mr22499038pjq.37.1559484811356;
        Sun, 02 Jun 2019 07:13:31 -0700 (PDT)
Received: from localhost.localdomain (119-18-21-111.771215.syd.nbn.aussiebb.net. [119.18.21.111])
        by smtp.gmail.com with ESMTPSA id x66sm12533278pfx.139.2019.06.02.07.13.26
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 02 Jun 2019 07:13:30 -0700 (PDT)
From:   Rhys Kidd <rhyskidd@gmail.com>
To:     Ben Skeggs <bskeggs@redhat.com>, David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        dri-devel@lists.freedesktop.org, nouveau@lists.freedesktop.org,
        linux-kernel@vger.kernel.org, Karol Herbst <kherbst@redhat.com>,
        Lyude Paul <lyude@redhat.com>,
        Ilia Mirkin <imirkin@alum.mit.edu>
Cc:     Rhys Kidd <rhyskidd@gmail.com>
Subject: [PATCH 0/2] drm/nouveau/bios/init: Improve pre-PMU devinit opcode coverage
Date:   Mon,  3 Jun 2019 00:13:13 +1000
Message-Id: <20190602141315.6197-1-rhyskidd@gmail.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

NVIDIA GPUs include a common scripting language (devinit) that can be
interpreted by a number of "engines", e.g. within a kernel-mode software
driver, the VGA BIOS or an on-board small microcontroller which provides
certain security assertions (the 'PMU').

This system allows a GPU programming sequence to be shared by multiple
entities that would not otherwise be able to execute common code.

This series adds support to nouveau for two opcodes seen on VBIOSes prior
to the locked-down PMU taking over responsibility for executing devinit
scripts.

Documentation for these two opcodes can be found at:

  https://github.com/envytools/envytools/pull/189

Rhys Kidd (2):
  drm/nouveau/bios/init: handle INIT_RESET_BEGUN devinit opcode
  drm/nouveau/bios/init: handle INIT_RESET_END devinit opcode

 .../gpu/drm/nouveau/nvkm/subdev/bios/init.c   | 26 +++++++++++++++++--
 1 file changed, 24 insertions(+), 2 deletions(-)

-- 
2.20.1


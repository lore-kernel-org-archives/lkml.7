Return-Path: <SRS0=oopU=Z2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,USER_IN_DEF_DKIM_WL autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3208EC2D0B1
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Dec 2019 21:56:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E135B2073C
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Dec 2019 21:56:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="HQpsnJV1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728313AbfLDV4X (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 4 Dec 2019 16:56:23 -0500
Received: from mail-pl1-f202.google.com ([209.85.214.202]:49570 "EHLO
        mail-pl1-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728031AbfLDV4X (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Dec 2019 16:56:23 -0500
Received: by mail-pl1-f202.google.com with SMTP id y8so382743plk.16
        for <linux-kernel@vger.kernel.org>; Wed, 04 Dec 2019 13:56:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:cc;
        bh=pLFKaWBxg3G91fQPN27XvAEs6sumdPZLqfrYTLin87M=;
        b=HQpsnJV1F1F54ZMj+I2hsZyKO+lpwzLTbCEQDfkrgLSTYB3gmAS+k+2sz1Y1Pc+Aza
         mlwhuCYAhP5z1K1dNLu9bjyHasUdLlKeFLo69o/PGvkRdY33Ww+Mv/lPyrRw1rQyHQ2L
         cCtoZRdp7zGcz8EotAMMvpgUw+p8UAYvYdGGHz3Zof9aGYeJG7EUsJtkiu8x5a6FACrz
         9STLb4KN0CEEiOQ9dkex5iMD+tHgM3Uy2hyYFleQPWmx7vE4OwhswmQUX4qtDkT2yeuR
         IFj4GRdRaZWEoeo0gLagaBVz7GCdkwncP2uCRkJE69t6dR7PSQhHjbDgo3R7CTkjyN+W
         DYag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:cc;
        bh=pLFKaWBxg3G91fQPN27XvAEs6sumdPZLqfrYTLin87M=;
        b=BZHLJ4uA45GGcVeiQAaM5+5VD45AztlpS17TkpfELTDvMHw7onlqUxeIfR8mLyE6eC
         lSOLuKKUNDEtdoYS78YmpS9mE7n77auBCPMoJABNrQBBkDSP483LjRCcfzTZESYiXkzR
         mlh1azgAVRuAccpxf5GWHjDjf+s9Wo5xHnsY71N/N+MfGoNUyc/jGNGehvy/PbANpeo4
         Jx9Rx/Dki1gwr4E6iNMySYQWfyvFIagBfA+f7DfdgDKwVkFSaZEtwvAIGe7G7uEafXVD
         qiiBUCcSnUkk/or6wBc+JX0uXBRPllHLTxmYCLEsQLTyOhuhENsNkKAxR4YKpNDb2AAK
         7E8A==
X-Gm-Message-State: APjAAAWAZhNDeVvuml0xBy49Q7X8xt++HX8QSEieoFJ5/b4qGQpS+dD2
        6zODnTzs81QecIlSICRwne09TW4=
X-Google-Smtp-Source: APXvYqxVhdDK3bnCACGmbkS3gGGhN+JPPXEpzuCvBE5GWgaY0BrOdygx6lhAUTBfUSazl9ozGRJyc2A=
X-Received: by 2002:a63:5d06:: with SMTP id r6mr5679994pgb.249.1575496582323;
 Wed, 04 Dec 2019 13:56:22 -0800 (PST)
Date:   Wed,  4 Dec 2019 13:56:16 -0800
In-Reply-To: <CAHLCerOD2wOJq7QNGBOcLvkMz4wvc1+6Hk2+ZD__NFged3tLcw@mail.gmail.com>
Message-Id: <20191204215618.125826-1-wvw@google.com>
Mime-Version: 1.0
References: <CAHLCerOD2wOJq7QNGBOcLvkMz4wvc1+6Hk2+ZD__NFged3tLcw@mail.gmail.com>
X-Mailer: git-send-email 2.24.0.393.g34dc348eaf-goog
Subject: [PATCH v2 0/2] thermal: introduce by-name softlink
From:   Wei Wang <wvw@google.com>
Cc:     wei.vince.wang@gmail.com, Wei Wang <wvw@google.com>,
        Zhang Rui <rui.zhang@intel.com>,
        Eduardo Valentin <edubezval@gmail.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Amit Kucheria <amit.kucheria@verdurent.com>,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The paths thermal_zone%d and cooling_device%d are not intuitive and the
numbers are subject to change due to device tree change. This usually
leads to tree traversal in userspace code.
The patch creates `tz-by-name' and `cdev-by-name' for thermal zone and
cooling_device respectively.

Changes since v1 [1]:
 * Split cooling device registration into a seperate patch

[1]: v1: https://lore.kernel.org/patchwork/patch/1139450/

Wei Wang (2):
  thermal: fix and clean up tz and cdev registration
  thermal: create softlink by name for thermal_zone and cooling_device

 drivers/thermal/thermal_core.c | 37 +++++++++++++++++++++++++++++-----
 1 file changed, 32 insertions(+), 5 deletions(-)

-- 
2.24.0.393.g34dc348eaf-goog


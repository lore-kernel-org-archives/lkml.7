Return-Path: <SRS0=Yun1=YR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5B7EECA9EAF
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Oct 2019 16:38:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 247AB21906
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Oct 2019 16:38:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="adQ5Otol"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2503594AbfJXQiy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 24 Oct 2019 12:38:54 -0400
Received: from mail-qt1-f195.google.com ([209.85.160.195]:36170 "EHLO
        mail-qt1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2503548AbfJXQis (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Oct 2019 12:38:48 -0400
Received: by mail-qt1-f195.google.com with SMTP id d17so24184993qto.3;
        Thu, 24 Oct 2019 09:38:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=l2yusJk1T2eAi0Mq1ot9gMKxrwCuHF+Xt6FpV+s1S4E=;
        b=adQ5Otolw+zTWgesd6OwBpQcFllS/xFs0LJdZLldoprFN9NEqkJSjKteCzmP/uH1mL
         ZZwMZ8844zT4GyV8jjYBoHDKWXUrrnnbdUwdyy/+Gavs9Y8mAiO1jE4tNy+tIfchX5BA
         mVZgWcQRSKvmJVIedrdoLUgQhXccIPBMQYV/A57ds6OSNCYfeNMkSGyuFj7fgqUDEQW/
         m4//xCZIo9igPHVDuUVBP33XJK6C/B350WGqzj7Ki2KupN5cbWfCLZ1kp7ftYLY7+paX
         o4dhuRaNHGqtyP6nGwGgwJQLIcWx6CNF4diBPAjJtvkRqRVOkeznmah7k/mhTsYgLjSi
         U/JQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=l2yusJk1T2eAi0Mq1ot9gMKxrwCuHF+Xt6FpV+s1S4E=;
        b=okgtRr7GDeNWT+EV3XEepUqTZkBjNJTniXFYa63cj6kmDqPNQcONiiW15IWo+cH+Gv
         l1w+zeGVkBnMqH3NS7h2SPvYPBgHIMy158IxmyyFpPEMLrfgQupEyV1lDn4KYAG00m5k
         3ozlmMHKmsu4VrSk3ow36z/RKAVF2wA4U88lCtskC3cmEb5m3w4yDiMO4+sCjlhPWcQb
         1PIoZ5wcwQQLO0RvAgqbW42vRmbrhfGNy6ZC53DgPzNNIQatufRyHWtkDNSkJh5ciSnG
         j6Go9K/JAoMZpTRoOnzHuMvGtnZ5UwiGWY3/fqDD6C6oJjoUEvqNV98So/Ooy9vpVEV7
         6xfw==
X-Gm-Message-State: APjAAAVlRnAuX1UqOf2GLOUlAIf9AJswwsYKUz0Ir6jCxnlKG54dEMHn
        1CieNF/8vEhZwbXFDu6ZEbA=
X-Google-Smtp-Source: APXvYqwcOTQnK4VI4aF5LMdX1mcHPNqv+ofYq0/XfCoQ2fgyR9QnN8h06JdtfvT/czFStdoCgBG9QA==
X-Received: by 2002:aed:21c4:: with SMTP id m4mr3562060qtc.342.1571935126820;
        Thu, 24 Oct 2019 09:38:46 -0700 (PDT)
Received: from localhost.localdomain ([201.53.210.37])
        by smtp.gmail.com with ESMTPSA id l15sm14660121qkj.16.2019.10.24.09.38.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Oct 2019 09:38:46 -0700 (PDT)
From:   Gabriela Bittencourt <gabrielabittencourt00@gmail.com>
To:     outreachy-kernel@googlegroups.com, sudipm.mukherjee@gmail.com,
        teddy.wang@siliconmotion.com, gregkh@linuxfoundation.org,
        linux-fbdev@vger.kernel.org, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org, lkcamp@lists.libreplanetbr.org,
        trivial@kernel.org
Cc:     Gabriela Bittencourt <gabrielabittencourt00@gmail.com>
Subject: [PATCH 0/3] staging: sm750fb: align arguments with open parenthesis
Date:   Thu, 24 Oct 2019 13:38:19 -0300
Message-Id: <20191024163822.7157-1-gabrielabittencourt00@gmail.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Cleans up checks of "Alignment should match open parenthesis"
in tree sm750fb

Gabriela Bittencourt (3):
  staging: sm750fb: align arguments with open parenthesis in
    ddk750_sii164.c
  staging: sm750fb: align arguments with open parenthesis in file
    sm750_accel.h
  staging: sm750fb: align arguments with open parenthesis in file
    sm750_cursor.h

 drivers/staging/sm750fb/ddk750_sii164.c |  2 +-
 drivers/staging/sm750fb/sm750_accel.h   |  6 +++---
 drivers/staging/sm750fb/sm750_cursor.h  | 17 +++++++----------
 3 files changed, 11 insertions(+), 14 deletions(-)

-- 
2.20.1


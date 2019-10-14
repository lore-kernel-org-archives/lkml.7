Return-Path: <SRS0=TxL2=YH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,FROM_LOCAL_NOVOWEL,
	HEADER_FROM_DIFFERENT_DOMAINS,HK_RANDOM_FROM,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 50BE1C4CECE
	for <linux-kernel@archiver.kernel.org>; Mon, 14 Oct 2019 21:25:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1DBD220650
	for <linux-kernel@archiver.kernel.org>; Mon, 14 Oct 2019 21:25:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XvlM80LD"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731054AbfJNVZi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 14 Oct 2019 17:25:38 -0400
Received: from mail-lj1-f195.google.com ([209.85.208.195]:36404 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729930AbfJNVZi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Oct 2019 17:25:38 -0400
Received: by mail-lj1-f195.google.com with SMTP id v24so18041645ljj.3
        for <linux-kernel@vger.kernel.org>; Mon, 14 Oct 2019 14:25:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=wJ7ap/mJ4LnJlcvrkffAc0aZKRdl3/lTtd2w5VVgMTc=;
        b=XvlM80LDSXmna1BJMSr5a/bmzis83k48RX5xlT4Z9K98g8V5GLTTt8PvAwFY5M687C
         PLBSSyOO5XIVomNz6DBKoWIwuu4cbQ2Nnq0ApENs0GgqowU/HaeG33u+lJOl56QUkUWX
         T8z4L6EcQT6iT+9nWO4ttuxmwCWZJioPwud8oVqdCrIaq4xHbrDmmtW3ceMiM0OKQ5c7
         MnyIVoLoN/Dc8/SdqXiiuTAXx0AjFg3O7lT60uXtcnt1grLBjkn95fwsckLX27KEtyfo
         9Bl1PkjY3WMRmrdu/bx2vA1Ix9fN955h0yXVUDq6tIv41l0/DY5c70ttDk03gvPkr4Qg
         eBIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=wJ7ap/mJ4LnJlcvrkffAc0aZKRdl3/lTtd2w5VVgMTc=;
        b=LUOhFNtLX2h8EzBgHgIxwx4aMZ9BoauyIamd+rv5ybltIvgk0AdrVX67ky6cKYmBYP
         TnIaDgxevz5t3Fe5CnnDCiJFpLOiR/Cc+/kmyhEDrWS5zbYOj+WOuilmKXwdG7VvQebK
         Jtz0AQdWgVnsWafEHU6+U+B+m67zEKSZa4Q6r8atwNuANAi41fZEP/Apo7T0inMQaQwW
         x3Phv8QEJBlp5LYl00x4tEOtOYaVtkzbLfv3BQGj4ggpjUZJFkUdIfpAdMk04AtiFXmo
         nSKnKasfILarh2nvlVqHa2opDCwtNDvc3pmAP+eWaWEUKdGgaDX24tbVkCC5Nf5sZ3v6
         vCHQ==
X-Gm-Message-State: APjAAAVTf26fruyXltBb/xww7ch3KreM1MZftzywAMC5twNNToAnwnDJ
        USf8IlxzhXy9qSX0KclpHh4=
X-Google-Smtp-Source: APXvYqwrn/wHJNPs+Z3jEe7EFcLkK+LStFk07lBcqoiLWtIOcwAWjmYTRHgxAOvVccvdGxBdPJ9T7w==
X-Received: by 2002:a2e:9b8a:: with SMTP id z10mr20223163lji.80.1571088336158;
        Mon, 14 Oct 2019 14:25:36 -0700 (PDT)
Received: from octofox.cadence.com (jcmvbkbc-1-pt.tunnel.tserv24.sto1.ipv6.he.net. [2001:470:27:1fa::2])
        by smtp.gmail.com with ESMTPSA id m15sm4429434ljh.50.2019.10.14.14.25.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Oct 2019 14:25:35 -0700 (PDT)
From:   Max Filippov <jcmvbkbc@gmail.com>
To:     linux-xtensa@linux-xtensa.org, Al Viro <viro@zeniv.linux.org.uk>
Cc:     Chris Zankel <chris@zankel.net>, linux-kernel@vger.kernel.org,
        Max Filippov <jcmvbkbc@gmail.com>
Subject: [PATCH v3 0/3] xtensa: fix {get,put}_user() for 64bit values
Date:   Mon, 14 Oct 2019 14:25:10 -0700
Message-Id: <20191014212513.17661-1-jcmvbkbc@gmail.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

this series fixes return value, out-of-bound stack access and value
truncation in xtensa implementation of {get,put}_user() for 64bit
values. It also cleans up naming of assembly parameters in
__{get,put}_user_asm and __check_align_{1,2,4}.

Changes v2->v3:
- fix assembly argument constraint for error code
- rearrange result zero-initialization for error paths in __get_user_asm

Changes v1->v2:
- initialize result when access_ok check fails in __get_user_check
- initialize result in __get_user_asm for unaligned access

Al Viro (1):
  xtensa: fix {get,put}_user() for 64bit values

Max Filippov (2):
  xtensa: clean up assembly arguments in uaccess macros
  xtensa: fix type conversion in __get_user_[no]check

 arch/xtensa/include/asm/uaccess.h | 94 +++++++++++++++++--------------
 1 file changed, 53 insertions(+), 41 deletions(-)

-- 
2.20.1


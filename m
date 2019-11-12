Return-Path: <SRS0=WT+Y=ZE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,FROM_LOCAL_NOVOWEL,
	HEADER_FROM_DIFFERENT_DOMAINS,HK_RANDOM_FROM,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2A373C43331
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Nov 2019 22:45:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EA80D21872
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Nov 2019 22:45:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jAt3rJLf"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727181AbfKLWpO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Nov 2019 17:45:14 -0500
Received: from mail-lj1-f194.google.com ([209.85.208.194]:41239 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726923AbfKLWpN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Nov 2019 17:45:13 -0500
Received: by mail-lj1-f194.google.com with SMTP id d22so263168lji.8
        for <linux-kernel@vger.kernel.org>; Tue, 12 Nov 2019 14:45:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=4Wtk0Nm+D8hYP3oekilrGeRCItYzeICLDQ94WChp85w=;
        b=jAt3rJLfDyeXZiW8yRJ97FcoUdVCvpD5RjRsSd1+3Jk7r1+WjvJOlEn2Ny9o8oHGyI
         j0D/pGowaVvvRsNzW+n3VFNfV1hXCa0IRmAE+kEgKxXj8/GzH7fv0t+HwBjq+KAuZfyh
         mrCSbNTUktOsA1ixh/z+G63o5xkZP6d2CMPyZZHllKNBCrcIPgkKOCFhTPIT12i4c161
         lg28FnNzypgsQtp/Hs/HjT0jKmOxtVq9RGyUn/syjqK0yW32pRlQQZaN+3zs38tNbaoi
         NWoRy4CirPu+18EQ2A2dr8Xktpu3s+hiFUTvKMbGrN09ghn/mayjQOz9WB01ajo3ijOe
         DZ6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=4Wtk0Nm+D8hYP3oekilrGeRCItYzeICLDQ94WChp85w=;
        b=NjdM0SEKU1AcbATyd9ZoBE+qCP+8w00Fod3HgchXuBfVK9DmvMwkQynN77HuG0hY2M
         fcTOJ5biFzg8cFjAAultwI0bEJId53PH9hcA16LpdFiTE/k8Dz2Y0n3lEW0N1ZnLgBnE
         H/67+r1yv02/WwggAzEEC2+Y6KD6+zIkip6wlbuPb/8//z4AM4Kv8joWETWlyiYWvX4w
         1wTsGdZigfaTuHeEOWGrcK1CN7Qh0Qu1RnRUzh4Al4em1YhfjvWhjSSTJp4jdDV2Vf8u
         HvDUJA2fPhrNomonTKV6sZyc8bcYjzb8VRnB6dXmqAkAzjvaQnBm8lndoUOC2kKPleb7
         TRNg==
X-Gm-Message-State: APjAAAXXupOpSS3Hr7Z/tthzgPLYAafhS+xNTSVKapj9Dx/v9dWLlCuV
        vpXOpkGjXipqj1v8oPckj/o=
X-Google-Smtp-Source: APXvYqyY8AKQOWp9omhOEkGuuGcANKP4PIIGPttrIFp0Hj7E9Q3BdYb/wOBTZxJOj1Mkdv4FHOvNvw==
X-Received: by 2002:a2e:8183:: with SMTP id e3mr104062ljg.111.1573598711442;
        Tue, 12 Nov 2019 14:45:11 -0800 (PST)
Received: from octofox.cadence.com (jcmvbkbc-1-pt.tunnel.tserv24.sto1.ipv6.he.net. [2001:470:27:1fa::2])
        by smtp.gmail.com with ESMTPSA id x16sm38677ljd.69.2019.11.12.14.45.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Nov 2019 14:45:10 -0800 (PST)
From:   Max Filippov <jcmvbkbc@gmail.com>
To:     linux-xtensa@linux-xtensa.org
Cc:     Chris Zankel <chris@zankel.net>, linux-kernel@vger.kernel.org,
        Dmitry Safonov <dima@arista.com>,
        Petr Mladek <pmladek@suse.com>, Joe Perches <joe@perches.com>,
        Max Filippov <jcmvbkbc@gmail.com>
Subject: [PATCH v3 0/2] xtensa: improve stack dumping
Date:   Tue, 12 Nov 2019 14:44:41 -0800
Message-Id: <20191112224443.12267-1-jcmvbkbc@gmail.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

this series cleans up code around stack_dump and makes dump size
configurable.

Changes v2->v3:
- split Kconfig change into separate patch
- use symbolic names instead of hardcoded numbers

Changes v1->v2:
- use print_hex_dump.

Max Filippov (2):
  xtensa: improve stack dumping
  xtensa: make stack dump size configurable

 arch/xtensa/Kconfig.debug  |  7 +++++++
 arch/xtensa/kernel/traps.c | 27 +++++++++++----------------
 2 files changed, 18 insertions(+), 16 deletions(-)

-- 
2.20.1


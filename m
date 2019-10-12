Return-Path: <SRS0=7jSw=YF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,FROM_LOCAL_NOVOWEL,
	HEADER_FROM_DIFFERENT_DOMAINS,HK_RANDOM_FROM,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ECDEEC47404
	for <linux-kernel@archiver.kernel.org>; Sat, 12 Oct 2019 00:07:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C0D6C2089F
	for <linux-kernel@archiver.kernel.org>; Sat, 12 Oct 2019 00:07:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Q7kTfk7M"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728515AbfJLAH3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 11 Oct 2019 20:07:29 -0400
Received: from mail-lj1-f194.google.com ([209.85.208.194]:39447 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726458AbfJLAH3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Oct 2019 20:07:29 -0400
Received: by mail-lj1-f194.google.com with SMTP id y3so11408879ljj.6
        for <linux-kernel@vger.kernel.org>; Fri, 11 Oct 2019 17:07:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=DP/pIZ7Dk1r0Q1hAF8O62ASZwsVKnOksJciqBlvU9ik=;
        b=Q7kTfk7MSE6QawaFDXeSSzLymvp4F8fw5HDlXIrhbSMRYSOL2Bs/kBZY6CvwwBktap
         pQEhlW3IqjqiVmd9yzYIUpEPMypBT5AIhmcsnyYzd1ZBaah/uVjt9FmJN3wQ6Y/mu1vV
         9cmWtcLBuoMIKagHz3hrlORigpkYyNJnx+bND7R/O9A2GdkTli3uLg+/6QnDihRTKqTK
         vZ7cYwZjqkZlG4JDUb1aG4D2sSZZ4Fqc0m0BzMvbhDV3BUTeT8qeO6oSDJ+wyP/0lGp8
         tMVmz33GbIh6e7WFkI2cjOubo4mVEG3jul7rs0ZFkn1wPFtS1bGqsXjIMuDVzXCanSfa
         KKhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=DP/pIZ7Dk1r0Q1hAF8O62ASZwsVKnOksJciqBlvU9ik=;
        b=N2Y8tMneBvo7FmbMWj92p2xnvBKDSp8Wn9X88CdHISKwv9WxDgDQ1u5NfdqxJ7sarh
         Wu0eAiP8B7OJObr2rrMcm0oP0Db/Cz92SqZBgLJOfguYvwiArehmIgYKu+eoebJtM8KF
         2UMgJdUB89JyBTKQksZR9y7ny/Aq38A4gDoJOlGp0KIuHRUSu6Ishb6jph3WPoZrNI52
         UTj+pPVo5Xgen84/bQ2AEwC8jz81s8MqNy8VupvnboFXWyGktEDjELnk71lXBTWYW7Xs
         vM+UkHB+ghOQu2+VjjYwDl+7XSXwn+7RPV/uF5wuZ4M0Wuoa5yJklubT9euLrRXIU8Ap
         fgVA==
X-Gm-Message-State: APjAAAV8/vNsW+bpV6QhklQ6GxJ1tr1vlmhFn6SSIV03n8e00WiCBWVw
        mKSb+/P3Cw1MA909Moyb7Kc=
X-Google-Smtp-Source: APXvYqyG4EQRdcZnPtOacNPj+2wtZVQmew6gNw/unYbzGH39NbH2j7vfVUco9+sdZYdF9zjlSBVZJg==
X-Received: by 2002:a05:651c:1b9:: with SMTP id c25mr10299063ljn.163.1570838847064;
        Fri, 11 Oct 2019 17:07:27 -0700 (PDT)
Received: from octofox.cadence.com (jcmvbkbc-1-pt.tunnel.tserv24.sto1.ipv6.he.net. [2001:470:27:1fa::2])
        by smtp.gmail.com with ESMTPSA id x17sm2215705lji.62.2019.10.11.17.07.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Oct 2019 17:07:25 -0700 (PDT)
From:   Max Filippov <jcmvbkbc@gmail.com>
To:     linux-xtensa@linux-xtensa.org, Al Viro <viro@zeniv.linux.org.uk>
Cc:     Chris Zankel <chris@zankel.net>, linux-kernel@vger.kernel.org,
        Max Filippov <jcmvbkbc@gmail.com>
Subject: [PATCH 0/3] xtensa: fix {get,put}_user() for 64bit values
Date:   Fri, 11 Oct 2019 17:07:08 -0700
Message-Id: <20191012000711.3775-1-jcmvbkbc@gmail.com>
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

Al Viro (1):
  xtensa: fix {get,put}_user() for 64bit values

Max Filippov (2):
  xtensa: clean up assembly arguments in uaccess macros
  xtensa: fix type conversion in __get_user_[no]check

 arch/xtensa/include/asm/uaccess.h | 93 +++++++++++++++++--------------
 1 file changed, 52 insertions(+), 41 deletions(-)

-- 
2.20.1


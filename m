Return-Path: <SRS0=GgR0=RR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B4B6DC43381
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Mar 2019 20:46:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 74ADE21872
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Mar 2019 20:46:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RzjdWE/W"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727963AbfCNUqR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Mar 2019 16:46:17 -0400
Received: from mail-qk1-f193.google.com ([209.85.222.193]:35994 "EHLO
        mail-qk1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726444AbfCNUqQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Mar 2019 16:46:16 -0400
Received: by mail-qk1-f193.google.com with SMTP id k130so4237416qke.3
        for <linux-kernel@vger.kernel.org>; Thu, 14 Mar 2019 13:46:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=WVeg1aZd3ymhaUnAk067l4PYGxtt96WuEwv9u0W0cKc=;
        b=RzjdWE/WkINQ6UYEgZn5xw2SaKSTPy8nWIyNYJWezF3UIpN5SWGN/K249XOyWl/0/Q
         qaFJbgWHNRm3RVn9YdPWtHjWBIiPPqJPenYylLxvtrPyXzhThSBZe22Y721tw8iKJmTS
         Kq4SH9WREhoEU6AHRyPvpfhVmDwYfGiBIk4tQ2lH7u3wUo7Kd8C9Mc+XSGumiMnys70A
         GxOh2sTxr8cLWEZpf1bfC04zkxytbBp/yblWy0DOPe8jKyYh7eZSL1lVLDeuLkebqkX+
         zIBC1yCYwC1WgCqYJNEjkCE2qDUOD7F3YDejRlq/Sjw15aNMM9bWBLt3z4KNUR2HgUFb
         +Qvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=WVeg1aZd3ymhaUnAk067l4PYGxtt96WuEwv9u0W0cKc=;
        b=q/XePIq6DtSLWMvj5pBnBsTxG4z5iKnxwBJJQGp77xfNVFqEduNIqkWzvEcnLWJTwq
         0BrBZcZIH364F7ef8f6uNnST9nucr2IpN5YN4YDJFzXFpJfH6oVftt7JMIW8Io9BdPcV
         mVm7bZ3gVw/P8cFWej96i5/wM6Ri138uFsDoQPIERYgSOQmTF3a/8IofSRq9w5ZjZH9r
         AjNVynqsSzHA9Z8nTjp0O9X3xHnvaYYJ8ufPHO8oQiOz2v+2nK5NQ7/26WT1jF+tuBIb
         oGve33RkSK5MPxJOoFTUK02qWOk1HeEBY/MFjmk9zXK5Lp9leHGMslTGG9Myi6eUHx0G
         H5vg==
X-Gm-Message-State: APjAAAWLVuBBodOXepr+SPuXdASUbb0pMBIs84+lrZbr9peqA682IJBv
        KcMqLTiIpWacFtMVceRQpGLvnlI=
X-Google-Smtp-Source: APXvYqy3X00pSG1ZCFLX9r/pV2buKtWWTujSc3sIpxPQrsfJarg2n1GtpEaV1Zw2EY55pjEt0rKsxw==
X-Received: by 2002:a05:620a:1372:: with SMTP id d18mr191966qkl.310.1552596375439;
        Thu, 14 Mar 2019 13:46:15 -0700 (PDT)
Received: from mwhitehe.remote.csb (ip-107-51-47-37.nymnny.spcsdns.net. [107.51.47.37])
        by smtp.gmail.com with ESMTPSA id j188sm16460qkc.55.2019.03.14.13.46.13
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 14 Mar 2019 13:46:14 -0700 (PDT)
From:   Matthew Whitehead <tedheadster@gmail.com>
To:     linux-kernel@vger.kernel.org, tglx@linutronix.de, mingo@kernel.org,
        luto@kernel.org
Cc:     Matthew Whitehead <tedheadster@gmail.com>
Subject: [PATCH 0/2] x86/CPU: Use correct Cyrix-specific macros
Date:   Thu, 14 Mar 2019 16:45:59 -0400
Message-Id: <1552596361-8967-1-git-send-email-tedheadster@gmail.com>
X-Mailer: git-send-email 1.8.3.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Replace the incorrect Cyrix-specific macro calls with the correct
setCx86() and getCx86() calls. Also remove the unused setCx86_old(),
getCx86_old() and their related comments in the code.

Matthew Whitehead (2):
  x86/CPU: Use correct macros for Cyrix calls on Geode processors
  x86/CPU: Remove {get,set}Cx86_old macros used for Cyrix processors

 arch/x86/include/asm/processor-cyrix.h | 21 ---------------------
 arch/x86/kernel/cpu/cyrix.c            | 14 +++++++-------
 2 files changed, 7 insertions(+), 28 deletions(-)

-- 
1.8.3.1


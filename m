Return-Path: <SRS0=Kqgt=XG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E5342C49ED6
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Sep 2019 18:21:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BD94C20838
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Sep 2019 18:21:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="K7xqlKEd"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729963AbfIKSVa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 11 Sep 2019 14:21:30 -0400
Received: from mail-wm1-f67.google.com ([209.85.128.67]:52549 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729758AbfIKSVa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Sep 2019 14:21:30 -0400
Received: by mail-wm1-f67.google.com with SMTP id t17so4616345wmi.2
        for <linux-kernel@vger.kernel.org>; Wed, 11 Sep 2019 11:21:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=5oTS8CESIdf2+fECzEqNsvb0NTpwnzCnNyq2GZVcr2Q=;
        b=K7xqlKEdOnfS0O9XRqb/0q0HY6V3p5QTtuFnmr0KhOwXtXTdrIo7XOMQjBPTztjdBv
         P2BkfFDusrYB3nUQH6LdVxrOILhGLcKVTvrwT0KVabE4tZPcmTOH+z27YSkrp56n/CPV
         I7tD8H8NX3WnSaIqV1wrz/S8P133nyn3cQZ9bTI0KlK5VXDAlwEdTrw3+xAn/nRxigzX
         oQFENDOvL6cAPWMpPTKZYx2roioydtwSveTu4Db+InkEQ552rK+aSTmjkAsDH6geR0fD
         TJRmFWw54E4ZULc2TLubi7PPT14jWff0OJuAZ6yo0rpSts5mEOMLrgoLLKQOIrILv8WI
         2TMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=5oTS8CESIdf2+fECzEqNsvb0NTpwnzCnNyq2GZVcr2Q=;
        b=Bppg/kMzubnoOsL6Kh9OsePf1OHqNdj/Nu3mVUUS59asYpKMFRO4GDhmpQBbtLtZtY
         GGg4Or2O+5iVxvdQl7iMJc8asyYkDeYwSbeC+j+gHYaKYg6hxhiYXlg9kLp4c6FRaFKa
         boYSBhYpTfoiWLEfJbN4zZdz3u2DTHJjeS6gjTq7isebjPmzYxEQ70XHUCdNnx3/JQVp
         /sL7WvaqrGHe9e5uOBoTaO66RwQOFABukh1mVtt0snmBzHNImTwsVZCY5eT04UblJKGU
         IDOMuLVnbLKQS0optm4B88kwMN11Uy5/ZOCt8RFImL7UHb0FX681l3ma2vpdQsVMgA7t
         XpEA==
X-Gm-Message-State: APjAAAUugoSe5M+Vj5O+aeUkwyayoCxSgfpQP8GY/F7Rrb7gxzniS9XG
        +Y1NBnguTmaaOwGdo4uz++B3iwg877w=
X-Google-Smtp-Source: APXvYqzgU/fRnLbtz6RgedmNuEbJtbEeTdDWGVaZDP3OGyWMCl1pe8N23aR5qWBVV1G9Z0Q/VHcoyA==
X-Received: by 2002:a05:600c:2152:: with SMTP id v18mr5188852wml.177.1568226088230;
        Wed, 11 Sep 2019 11:21:28 -0700 (PDT)
Received: from localhost.localdomain ([2a01:4f8:222:2f1b::2])
        by smtp.gmail.com with ESMTPSA id q9sm2356753wmq.15.2019.09.11.11.21.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Sep 2019 11:21:27 -0700 (PDT)
From:   Nathan Chancellor <natechancellor@gmail.com>
To:     Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>
Cc:     linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
        clang-built-linux@googlegroups.com,
        Nick Desaulniers <ndesaulniers@google.com>
Subject: [PATCH v3 0/3] LLVM/Clang fixes for pseries_defconfig
Date:   Wed, 11 Sep 2019 11:20:47 -0700
Message-Id: <20190911182049.77853-1-natechancellor@gmail.com>
X-Mailer: git-send-email 2.23.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,

This series includes a set of fixes for LLVM/Clang when building
pseries_defconfig. These have been floating around as standalone patches
so I decided to gather them up as a series so it was easier to
review/apply them. The versioning is a bit wonky because of this reason,
I have included the previous versions of the patches below as well as
added an explanation on each patch. Please let me know if there are any
comments or concerns.

Previous postings:

https://lore.kernel.org/lkml/20190818191321.58185-1-natechancellor@gmail.com/
https://lore.kernel.org/lkml/20190820232921.102673-1-natechancellor@gmail.com/
https://lore.kernel.org/lkml/20190812023214.107817-1-natechancellor@gmail.com/

Cheers,
Nathan

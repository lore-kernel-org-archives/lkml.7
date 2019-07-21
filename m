Return-Path: <SRS0=KmSF=VS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9A8BCC76191
	for <linux-kernel@archiver.kernel.org>; Sun, 21 Jul 2019 15:58:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 57CDA2083B
	for <linux-kernel@archiver.kernel.org>; Sun, 21 Jul 2019 15:58:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WVSiCWvN"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726721AbfGUP6T (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 21 Jul 2019 11:58:19 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:39452 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726441AbfGUP6S (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 21 Jul 2019 11:58:18 -0400
Received: by mail-pg1-f194.google.com with SMTP id u17so16466385pgi.6
        for <linux-kernel@vger.kernel.org>; Sun, 21 Jul 2019 08:58:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=DDH0NhE6n6ta7EYCQyM5rU/FRAaVDyWq9ScZ3NSNGqI=;
        b=WVSiCWvN4Myy+QbG5zDlacgHt8OFkZAobDbyEG2NtCptrqKyxBXkLzeAvEcndlSzhv
         IvqnL+fkctBEMDb8Xy9Gl9WTBwpmRbs1nbFeFi3PZJ3dosmh8U32mR+Srw8bUUCejuIh
         WpS1r7VN/MSnITGRvwwYs9yd/ceeoVTyv2G0UhJiMycDTpWQjvOlBZmL0raPXDkNdhEt
         xFVhzZpjxxFlreExaKYDYNgGXEosh9bD5S8lpPPhUIFuhgJDu/2zd1PMqSc+jVJjW2io
         EbL+owYYNnvARuc7fmsD4zgLnlu43qPiWhdTZAvv+jF/Owbw/3mvF0efs61ayErxxo3N
         BU0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=DDH0NhE6n6ta7EYCQyM5rU/FRAaVDyWq9ScZ3NSNGqI=;
        b=YnSJWykjKhPcwrdisl6fcv6z0EuaXRY843+TJNX3bjHsHVIiL/5TScPnyxTcSs5urS
         ShEXgIj5Y3K4R+5mUePLhI0wUpYwvGa3Pi1cNxoS/ZTOwcQna+e6vPCpb1/tGM3p+cY5
         a8D3zSEenGj1UuSKL1z3SA6DNRd9VbIKGyywoEmwpuHHdsCVang2YVSaqoOOc13qxdAX
         FUuYeBdgFE2RHpVzxGYjkcyQZ/90M06mr6dHZoGYVAXUoLXCbfY3vinZRhOY38isYV25
         Nw9mQ6d9Kdt8gkTQE3sp5F/gaLqow/aQukFve53704+aHtaD6kH5dnS/x9CzDt/ecEV/
         ntqA==
X-Gm-Message-State: APjAAAWxL4oqs1iZaqfNzEFLOWfxxbD5b9guoy+uX/OSiBo4HZinXUff
        LjBSKHb0Rvhcz0mA8RmX12A=
X-Google-Smtp-Source: APXvYqyHZp5mS+lTbi7oHxO2epL8R4NOTNAiFsqbAXeHsoAardI7S/ru4DZLvBbeyI1nBk/ngZYE4g==
X-Received: by 2002:a17:90a:30e4:: with SMTP id h91mr69268220pjb.37.1563724698104;
        Sun, 21 Jul 2019 08:58:18 -0700 (PDT)
Received: from bharath12345-Inspiron-5559 ([103.110.42.34])
        by smtp.gmail.com with ESMTPSA id v27sm48568911pgn.76.2019.07.21.08.58.16
        (version=TLS1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sun, 21 Jul 2019 08:58:17 -0700 (PDT)
From:   Bharath Vedartham <linux.bhar@gmail.com>
To:     arnd@arndb.de, sivanich@sgi.com, gregkh@linuxfoundation.org
Cc:     ira.weiny@intel.com, jhubbard@nvidia.com, jglisse@redhat.com,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        Bharath Vedartham <linux.bhar@gmail.com>
Subject: [PATCH 0/3] sgi-gru: get_user_page changes 
Date:   Sun, 21 Jul 2019 21:28:02 +0530
Message-Id: <1563724685-6540-1-git-send-email-linux.bhar@gmail.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch series incorporates a few changes in the get_user_page usage 
of sgi-gru.

The main change is the first patch, which is a trivial one line change to 
convert put_page to put_user_page to enable tracking of get_user_pages.

The second patch removes an uneccessary ifdef of CONFIG_HUGETLB.

The third patch adds __get_user_pages_fast in atomic_pte_lookup to retrive
a physical user page in an atomic context instead of manually walking up
the page tables like the current code does. This patch should be subject to 
more review from the gup people.

drivers/misc/sgi-gru/* builds after this patch series. But I do not have the 
hardware to verify these changes. 

The first patch implements gup tracking in the current code. This is to be tested
as to check whether gup tracking works properly. Currently, in the upstream kernels
put_user_page simply calls put_page. But that is to change in the future. 
Any suggestions as to how to test this code?

The implementation of gup tracking is in:
https://github.com/johnhubbard/linux/tree/gup_dma_core

We could test it by applying the first patch to the above tree and test it.

More details are in the individual changelogs.

Bharath Vedartham (3):
  sgi-gru: Convert put_page() to get_user_page*()
  sgi-gru: Remove CONFIG_HUGETLB_PAGE ifdef
  sgi-gru: Use __get_user_pages_fast in atomic_pte_lookup

 drivers/misc/sgi-gru/grufault.c | 50 +++++++----------------------------------
 1 file changed, 8 insertions(+), 42 deletions(-)

-- 
2.7.4


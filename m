Return-Path: <SRS0=f7FU=UJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 37FEBC282DD
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Jun 2019 08:18:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0433020861
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Jun 2019 08:18:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OJysVsS4"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388387AbfFJISM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Jun 2019 04:18:12 -0400
Received: from mail-pl1-f195.google.com ([209.85.214.195]:42105 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387825AbfFJISL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Jun 2019 04:18:11 -0400
Received: by mail-pl1-f195.google.com with SMTP id go2so3326243plb.9
        for <linux-kernel@vger.kernel.org>; Mon, 10 Jun 2019 01:18:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id;
        bh=wZDIYtcBm6YBkeyQZrwF6W6HfPYDVvweCiUtUBQSDhE=;
        b=OJysVsS4wUoxpTrYPZCzSuUr4dVnQwKGoNVhbBMASOTHgAReWykQJuWYzmunROa2Uv
         LeuumQ3UqH2lSV3lSkc5h0Wk39Q5j/HGV8RyT2xj8Ets+MCl6cegN3FhhZM1Rt2vtlIS
         lORjLczZVJ4kIrgl5Ixgg7a12Vkafcy9uWxPvhKI2gXHiIPHnBbTXk/5K6oYl5wDH1HQ
         /NIQzsGHcNkaPqUd5RAfNI2U6YbCVQ3EsiPK3ymyy73AyzxteL8LeW+M6YIjF+B+l7QD
         zvWQ95bE26Q6Jq4th4uSyvPXP5w8eXYSecAHYUnagWW2JLrwhKLLJIf/4/UycO/xZvdc
         mDkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id;
        bh=wZDIYtcBm6YBkeyQZrwF6W6HfPYDVvweCiUtUBQSDhE=;
        b=npTUYm3XUuyYugOiDZTye3hJb/+hdljiIazRXGb4CRwX2EoMaR9ae6fIgBT9DEaV45
         Z0H6CyDcGU2Bg9p0QDGdEdI8BM2qduT2EYiwkmZ3CY5rZakx0wfohp375305ivDMBxU0
         mCHRXEuYUiS6oy+gIfsjVjV+VE1Eeb8pTxEP1UcQNR5b64TYzncWxaiD2WODEt3PmZuj
         Fv1wSzOYThorN3TrHujOAWfx+eKv7SR89PoGwhnPZzGdtMBPueI4tI7hLWeYLwTZyGTj
         cbdYfmTpvhwtPhD7iGK1HbaSne3AVky6Gro7T/f0b/FA5/XFMtS2ETAtBkf2DMULVu9e
         zr1Q==
X-Gm-Message-State: APjAAAWTVrIcuaD7TcjDpItm//KrxJx1PHGs6zwtpo+cDmrNvY/iX5TX
        fXYzou+Z2PG6GcGxYfZqgw==
X-Google-Smtp-Source: APXvYqwZP/N/nuah30nBCi60qQxwirzSlklAIR0pdCjT3zNj8/gP2jcnz1KC411PHNZJZcjQfFwdAA==
X-Received: by 2002:a17:902:4181:: with SMTP id f1mr66838981pld.22.1560154690983;
        Mon, 10 Jun 2019 01:18:10 -0700 (PDT)
Received: from www9186uo.sakura.ne.jp (www9186uo.sakura.ne.jp. [153.121.56.200])
        by smtp.gmail.com with ESMTPSA id j7sm9525014pfa.184.2019.06.10.01.18.08
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 10 Jun 2019 01:18:10 -0700 (PDT)
From:   Naoya Horiguchi <n-horiguchi@ah.jp.nec.com>
To:     linux-mm@kvack.org
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Michal Hocko <mhocko@kernel.org>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        xishi.qiuxishi@alibaba-inc.com,
        "Chen, Jerry T" <jerry.t.chen@intel.com>,
        "Zhuo, Qiuxu" <qiuxu.zhuo@intel.com>, linux-kernel@vger.kernel.org
Subject: [PATCH v2 00/02] fix return value issue of soft offlining hugepages
Date:   Mon, 10 Jun 2019 17:18:04 +0900
Message-Id: <1560154686-18497-1-git-send-email-n-horiguchi@ah.jp.nec.com>
X-Mailer: git-send-email 2.7.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi everyone,

This is an update of the fix of return value issue of hugepage soft-offlining
(v1: https://patchwork.kernel.org/patch/10962135/).

The code itself has no change since v1 but I updated the description.
Jerry helped testing and finally confirmed that the patch is OK.

In previous discussion, it's pointed out by Mike that this problem contained
two separate issues (a problem of dissolve_free_huge_page() and a problem of
soft_offline_huge_page() itself) and I agree with it (althouth I stated
differently at v1). So I separated the patch.

Hopefully this will help finishing the issue.

Thanks,
Naoya Horiguchi

Return-Path: <SRS0=SZ1Q=SM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,USER_AGENT_GIT,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C906AC10F11
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Apr 2019 22:21:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 820B720818
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Apr 2019 22:21:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=indeed.com header.i=@indeed.com header.b="BTGUiLPE"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726739AbfDJWVC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 10 Apr 2019 18:21:02 -0400
Received: from mail-ot1-f54.google.com ([209.85.210.54]:44434 "EHLO
        mail-ot1-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726038AbfDJWVB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Apr 2019 18:21:01 -0400
Received: by mail-ot1-f54.google.com with SMTP id d24so3401717otl.11
        for <linux-kernel@vger.kernel.org>; Wed, 10 Apr 2019 15:21:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=indeed.com; s=google;
        h=from:to:subject:date:message-id:in-reply-to:references;
        bh=jt+tlrlxq1U99mUFvJJ0Clgx8Lqjonh9gtRs1JZIcgo=;
        b=BTGUiLPEhvIkVNwbVz1FOvJqbxiUmqLK+F38mxsYWq2yoiPTu7AW8BAhc04MUfklVk
         1e6fv0zScY2voVzys1UHN0Po9AHABPU8TWL2dH8PZUVCSOPjaJPtV2d3VDxSdj8dmdPt
         z7fmwdZZGTUeomGxRYAPUChDDglRb2RnCOKxA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references;
        bh=jt+tlrlxq1U99mUFvJJ0Clgx8Lqjonh9gtRs1JZIcgo=;
        b=OUoXvlqTNC2v/jbAc4PESIAOAGMjd5UrpLHSA3pzmQNHvAfSQyIwiFR1cGyrrdMAYY
         0j9w2fuO9s9uM94ZtKBmUAnjWvbC/nA7hCEz8P2fZvCFdD/UIwo+M1ICjkXcg59CbpXR
         3PZwMtig5OnqSxesvdpqiCPpasm6EHnRgBB8B/AL3aUDvfPCxxdbcQ/EOJLrB538qSQ8
         XFaWpAzC/D5rDwaySY31UJQ1iq2MgqeUgPzXA3SOXUJeswoEDVZlxOxj3IkESIhgMygz
         BXFtCO8BIEM9GliCakA4AaVcqLj/8wmnCVsbgtR8p7o51R0NGEoTxUPOs4QmeM3g8yoQ
         SELQ==
X-Gm-Message-State: APjAAAXkerXn0Q3yrz6xXuyHE1nRRJ2xhfoGc8ChJnvWkVx2yWFlUqwp
        pluyKcQu6lRQmWfopZEwyocSKA==
X-Google-Smtp-Source: APXvYqy51GiaGFXTWZkrIABZp+0GhimjOFC7YP4qCOVK5kKmU+Uvy9T2HE+PqTAVfJtYreO6N4/CNA==
X-Received: by 2002:a9d:7399:: with SMTP id j25mr2118700otk.88.1554934860920;
        Wed, 10 Apr 2019 15:21:00 -0700 (PDT)
Received: from cando.ausoff.indeed.net ([97.105.47.162])
        by smtp.gmail.com with ESMTPSA id n3sm14294941oia.46.2019.04.10.15.20.59
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 10 Apr 2019 15:21:00 -0700 (PDT)
From:   Dave Chiluk <chiluk+linux@indeed.com>
To:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>, cgroups@vger.kernel.org,
        linux-kernel@vger.kernel.org, Brendan Gregg <bgregg@netflix.com>,
        Kyle Anderson <kwa@yelp.com>,
        Gabriel Munos <gmunoz@netflix.com>,
        John Hammond <jhammond@indeed.com>,
        Cong Wang <xiyou.wangcong@gmail.com>
Subject: [PATCH 0/1] cgroup: Fix low cpu usage with high throttling by removing slice expiration
Date:   Wed, 10 Apr 2019 17:20:49 -0500
Message-Id: <1554934850-7002-1-git-send-email-chiluk+linux@indeed.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <CAC=E7cV_2QtXQ-mx4-GfHLyAWxW+7Ub75UmMvOLxLXzot47TWw@mail.gmail.com>
References: <CAC=E7cV_2QtXQ-mx4-GfHLyAWxW+7Ub75UmMvOLxLXzot47TWw@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


The following patch is an implementation of option 2 from my earlier e-mail.
Option #2 was the removal of all runtime_expires and related slice expiration
logic.

This is a very early iteration of this patch, and testing/comments are very
appreciated.

Thanks,
Dave.

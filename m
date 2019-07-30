Return-Path: <SRS0=Iew4=V3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BD8BDC0650F
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jul 2019 15:40:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8E1782089E
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jul 2019 15:40:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bE9C7hLQ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730901AbfG3PkB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 30 Jul 2019 11:40:01 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:39745 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726941AbfG3PkB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Jul 2019 11:40:01 -0400
Received: by mail-pg1-f194.google.com with SMTP id u17so30259977pgi.6
        for <linux-kernel@vger.kernel.org>; Tue, 30 Jul 2019 08:40:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Vne3d3TA+jWKXpZqNUGuJSIWUSkOrA0rq1xIX/cTwsA=;
        b=bE9C7hLQeEeAAUDM9brsj+v0BgqdDlJPXOYFfQA7UDpv0VvD6Y/2S6ZhkRIIv8T8rm
         cYWT7A4X3TCY2CBLDcVhBdroKpeZX41WVhh9pQs712L6JAkZ0anqmNse11vvfVLKO9H+
         gGpskm2MFw1lBkTjETkNw0/kMirfacfyYcHAEYs9iZ9qZmSeBk4MbyvV+6QGa4KFhjva
         eYNdgMH6IRAVJ+iA3fFlrC7+gBzqn4n+3Qo5XGj3+u/0SK8QQ6DGloJosb3XnYtqMnVk
         QwmhLsMCc4b+NtQXC5oZp/DzXRN1pP2f4egg6OayFiWdQzVcONmDUnBpZCx46fSa4QkU
         yRSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Vne3d3TA+jWKXpZqNUGuJSIWUSkOrA0rq1xIX/cTwsA=;
        b=P1Feu50fHvr9V0/ZqvDQT7/cZmTct5Eic9P1gulEnHluY4hQUZoMYiDZVqWVt8Wk/a
         BKdcy/9KK2TXHdSazgn4EhKPpTUaC1tu7qbnPS405mgseDMvTOTH+0gLR4X+IqM1v2oR
         kFPgrGu5SyOkQLJ8lpR3ztl7yjtludaB+PKx48nTcycIDzPbAnKahZHEKx6dS9iSo3nO
         4hKVlqTxC7O5SrP09l3HjvO6wcyuO+fqf6iJP+XG6+w4rUpq3PloyP47KP7NSRTF5+6G
         kG5GDFWMIX83mlnUzBQHil87e5lEG3tVJZwLNSiuV84VEdcNADbHxNWcfME/CP+9CYWn
         JFnQ==
X-Gm-Message-State: APjAAAWuzpdCH5OLM2JOOlFnAARWmblIsrRei635cvNd++HRMNy+CadK
        9oIni6QsSYuBP0VbXQcMzEI=
X-Google-Smtp-Source: APXvYqxiu60GFSJUeLiGhpCpiZDxJDDoQkgaNaRHTO3YbWFhXNhaHvi/EHcY5z1AkeZb2VKnQlMA7w==
X-Received: by 2002:a63:cb4b:: with SMTP id m11mr35668140pgi.49.1564501200236;
        Tue, 30 Jul 2019 08:40:00 -0700 (PDT)
Received: from bharath12345-Inspiron-5559 ([103.110.42.33])
        by smtp.gmail.com with ESMTPSA id 195sm108148638pfu.75.2019.07.30.08.39.58
        (version=TLS1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 30 Jul 2019 08:39:59 -0700 (PDT)
From:   Bharath Vedartham <linux.bhar@gmail.com>
To:     sivanich@sgi.com, arnd@arndb.de
Cc:     ira.weiny@intel.com, jhubbard@nvidia.com, jglisse@redhat.com,
        gregkh@linuxfoundation.org, william.kucharski@oracle.com,
        hch@lst.de, linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel-mentees@lists.linuxfoundation.org,
        Bharath Vedartham <linux.bhar@gmail.com>
Subject: [Linux-kernel-mentees][PATCH v4 0/1] get_user_pages changes 
Date:   Tue, 30 Jul 2019 21:09:29 +0530
Message-Id: <1564501170-6830-1-git-send-email-linux.bhar@gmail.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In this 4th version of the patch series, I have compressed the patches
of the v2 patch series into one patch. This was suggested by Christoph Hellwig.
The suggestion was to remove the pte_lookup functions and use the 
get_user_pages* functions directly instead of the pte_lookup functions.

There is nothing different in this series compared to the previous
series, It essentially compresses the 3 patches of the original series
into one patch.

Bharath Vedartham (1):
  sgi-gru: Remove *pte_lookup functions

 drivers/misc/sgi-gru/grufault.c | 112 +++++++++-------------------------------
 1 file changed, 24 insertions(+), 88 deletions(-)

-- 
2.7.4


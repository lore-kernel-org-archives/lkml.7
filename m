Return-Path: <SRS0=cgli=V4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,USER_IN_DEF_DKIM_WL autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EC249C32751
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Jul 2019 22:16:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BC30F206B8
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Jul 2019 22:16:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="TyMnOqTf"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731135AbfGaWQ1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 31 Jul 2019 18:16:27 -0400
Received: from mail-vs1-f73.google.com ([209.85.217.73]:55462 "EHLO
        mail-vs1-f73.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730378AbfGaWQ1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Jul 2019 18:16:27 -0400
Received: by mail-vs1-f73.google.com with SMTP id w23so18211747vsj.22
        for <linux-kernel@vger.kernel.org>; Wed, 31 Jul 2019 15:16:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=TNCYnHbae6Y+N46P+S/g9B2AO0ZpO70oB34sI5UpqOY=;
        b=TyMnOqTfGDABMXlcAwuv7T7jhu8BpLlOWDHO+zQGLa2ChBB8hEfFDP2zhJDEWRTed8
         itU6v2ZiJqe+i4EJYdCebruEriH2qsaxLRmEy+kII/wQA9nxDVVThu+714riM4DLr2wa
         dqNTFiVHcyLg/3anICNNZ0z666Wb7mh4oSLXpDkYPn0h5F2Y4A8+gQ6+2rah8LfVxzdw
         wZk7voII1+P+C6cSmHkgvcjwDjd0+a8PBbI14aVS+ru20lzThtzn2Q+5rBbeX4KOfgVX
         Y+u/dMRJpKtkgAr10pS4pFCWlgp1Sc3M72BYDfVV2i67o7THjKqSYGuetlXj4bVuOX+i
         Lp4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=TNCYnHbae6Y+N46P+S/g9B2AO0ZpO70oB34sI5UpqOY=;
        b=VNRqM1iFjmiaRP6rHDGUX6OsHfnmaGSAWaPSOcs7r8nnMibPMs/ImYZ6e9T+FWobGD
         kk0w8lvWfWQtGL8c7W6PL5/IijHoggIDzwdQnC/kYojmqvzvGMNSyE/hKnoUjsKHk5Zm
         zgSuZZ4eKkw+zN1yH3HakKmhshYQq/+2/NHK5OAVOHEQrpHznV2YQFnGldcjxQsDnQ7W
         JhU2Z3YV0rPqIDWx+ZHanyIgClmgonhzBCXAbQ1vThX5XfLGLl12hyd6XROxj3/Bo0Im
         1gNT7xxUwrvyIumd9Ng5lcKrNpA86yiL64P28qZqtgiHSERSj2RP450F47PpzOI8M3Hm
         UK0w==
X-Gm-Message-State: APjAAAU82QFS6dpH1rYN4SYl/nsvr05yOdV9DrmbWfZmw05LTiRswgq1
        1BJ69WYCO/Cf7z+JyUBGbeDcr36u9US/KNIfQ5RTNg==
X-Google-Smtp-Source: APXvYqwL9R2qHS/bl6BRUfgtjSoZ19607pzRI+aH/FxR+XimjEIv8tRaHjP3z6oMrbxKSWMVwlTwG43uv60sooxKe6omwQ==
X-Received: by 2002:a67:fc19:: with SMTP id o25mr8573319vsq.106.1564611385933;
 Wed, 31 Jul 2019 15:16:25 -0700 (PDT)
Date:   Wed, 31 Jul 2019 15:15:48 -0700
Message-Id: <20190731221617.234725-1-matthewgarrett@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.22.0.770.g0f2c4a37fd-goog
Subject: [PATCH V37 00/29] security: Add support for locking down the kernel
From:   Matthew Garrett <matthewgarrett@google.com>
To:     jmorris@namei.org
Cc:     linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-api@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

A minor fix to the tracefs patch, some Acks and reviews added to the SOB
chain, and rebased on next/master (there were a couple of minor fixes needed to
align that).



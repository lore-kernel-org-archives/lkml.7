Return-Path: <SRS0=maO4=XY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	SUBJ_ALL_CAPS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3EAA6C4360C
	for <linux-kernel@archiver.kernel.org>; Sun, 29 Sep 2019 19:39:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1042E20815
	for <linux-kernel@archiver.kernel.org>; Sun, 29 Sep 2019 19:39:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XjC1F+Xw"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729334AbfI2TjG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 29 Sep 2019 15:39:06 -0400
Received: from mail-yw1-f44.google.com ([209.85.161.44]:45779 "EHLO
        mail-yw1-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729282AbfI2TjF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 29 Sep 2019 15:39:05 -0400
Received: by mail-yw1-f44.google.com with SMTP id x65so2760073ywf.12
        for <linux-kernel@vger.kernel.org>; Sun, 29 Sep 2019 12:39:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to;
        bh=sjjmHYskLGnUTaSNKzxAN7d60gYr6PnVTn37gw3DkEk=;
        b=XjC1F+XwRs5QIkIg31sDPZX0Xcp0U0s1BjLBEkBbCylL5UU0ulYxDnIJLKTWySjFSo
         +F8QTWjtyiRfVbIltZZSaUfQqSfqeV71bUIyQ3hL7ZlsxWg5QXgtm6hJyvSE4jRYjU3v
         LalnbJN4T2ZGc1k7KBbiXH+x2+x5/8U3fuKMh3Qvdk7fUL8ps93K37QtSHQmvXEOS246
         Bl/qPes9rekVSipnsQg7VaRZMeCAmKFE+gntkWm6DuOr+Gx1YXGufIjGbIW/rcsOdWvH
         QWiS7e7QDI1ULxV66gviSGl1/IC1lN4OpqnxWNM4zIHG5ThMkxDfUOLEtbhiG8zyQon4
         vltw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to;
        bh=sjjmHYskLGnUTaSNKzxAN7d60gYr6PnVTn37gw3DkEk=;
        b=EqnptYlfL885lzAbU8UqBSX7bz903vwInvYHDCZ+PcDlwH8BvJJwKvJM6z+9fScwLz
         7L4ozmQEJ+MaezUEb50nRImMmmAb4hjVHBvvlN/aLCJDBHSPZ67NQEzUx+uBsklW6bFw
         S+vGrqxgYf2WZ5J17xhd5xzAsW9tt48/faccYWwQaVjpIBNslijIvfYYntafHq0nJtif
         BXBCA22ZdbYfNOj4F7Mp+OcuUVkxkz4UlLHmJ/8CJnOXyoE1fiQcnB4nsFcXojnVfB5k
         KDj0stummUzQaEc5sQhPFbuB1sOADooGOE75Yvq6M7hMhr3u3NtbYakd9TvqYPeb6cfN
         WPCg==
X-Gm-Message-State: APjAAAW8Hu8CwyCPyFJQV7fk4SWTXzdKspms9VYHbSws0rZVRAemDFfH
        72ZwxEhdWnpgbebfhPJhzutftPaAaWxMYiPjVruKY0QJ
X-Google-Smtp-Source: APXvYqxg/dwOvBLYtP8Ujux1AzANJDjyOQiY81tGaJUB56LXVdtVcj++v4dwoh99X6I1Fm/XbWMRPP8mQ5ufeAHQ1o4=
X-Received: by 2002:a81:de41:: with SMTP id o1mr9357843ywl.53.1569785945022;
 Sun, 29 Sep 2019 12:39:05 -0700 (PDT)
MIME-Version: 1.0
References: <3f74e79546aff3e2f77e94361685d53f4e44fa7b.1569181001.git.agriveaux@deutnet.info>
 <201909231038.WLeaU93z%lkp@intel.com>
In-Reply-To: <201909231038.WLeaU93z%lkp@intel.com>
From:   Carlo Pisani <carlojpisani@gmail.com>
Date:   Sun, 29 Sep 2019 21:39:04 +0200
Message-ID: <CA+QBN9A2pHpy+F4Xkbk1=GrxkLaSkqhD_-8XJUFctYbMmsDpqQ@mail.gmail.com>
Subject: MIPS SGI IP30
To:     linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

hi guys
any news about the kernel?
I still have a lot of trouble with the PCI.

Carlo

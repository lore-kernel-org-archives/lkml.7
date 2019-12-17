Return-Path: <SRS0=vnTL=2H=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C4E56C43603
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Dec 2019 05:18:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 970302072D
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Dec 2019 05:18:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="U3GzqEIW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726980AbfLQFSr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 17 Dec 2019 00:18:47 -0500
Received: from mail-pl1-f195.google.com ([209.85.214.195]:37258 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726143AbfLQFSr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Dec 2019 00:18:47 -0500
Received: by mail-pl1-f195.google.com with SMTP id c23so5543634plz.4
        for <linux-kernel@vger.kernel.org>; Mon, 16 Dec 2019 21:18:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=uBQX+wvsPbLaiUS1zyynw0jvBJQmpOApGSy++FgD+D4=;
        b=U3GzqEIWEGa4OHOdIVygDEojbTbLZh1XQ2gEV2EcpAFBFQkKJr9ZxsB6R+3lPqq4pX
         znFtxDHYtEJwUlgWp29ucI4XGte4kD96mWpRQlGJA/jvC6qdFusv642Dg8qG7b+qlr5j
         Hgp5VcB7N37R/XFA5YbMv2bVG+Ib5MBHUtAZi+UvtgqK1TA+YINqWHX3NzzKe/y7uWgY
         EekYTTjUj6EX37pasv+0bhh7UaMK4ipmMV+4rfe0SxvqzVGEcw/y6H3SorT+qqpxf9Tv
         hXi+eBdHopGyvYVaemCivi0GjrnsMYgJEtpe3t2wsDz7C43QFZBtWDx3C7pGvwMdzodf
         FWqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=uBQX+wvsPbLaiUS1zyynw0jvBJQmpOApGSy++FgD+D4=;
        b=sowx4aU73bctulTyRAUe5pdNwQrK/ortTH1fnPOIEQGZnggXOp5mODUR1Ea5iwIH0w
         f+PawG4AHPJWH2IzkN2autl4EZgmwuWc0fkRmd6Hy3kGiuE3MwzSa7rHLm1PEmKO0mpU
         nCFSWe58MOzGrZFzLtW6OzPuK2p2LkrZzQYrcn4oEq+Y99DFXrkXlKhm9J6vmTSuiIg3
         DN4NpEUc0QniMgwdPo/CV2KIPd8mxSIyWPC9Rjbn7YICU+p5+a9TTbeQMsW4Kpgyr9Eh
         eXdRd8d0HCqDQW/TA/ahTHX3FS+wFvoqCtU7Cyr86lz41ruB2AQh3VyRBMkygv5K+0nd
         xNWQ==
X-Gm-Message-State: APjAAAXZZYeNwS8F/5WPeWaowdeNiExtT/XbMq3QqRXWpswbJ7Qb9AbQ
        yQ0Mz6HGyP3ZKD8TxrKLxi8=
X-Google-Smtp-Source: APXvYqxur3DLLtcfzqXoeUKO7snYdyrMm0EK+BpxBiv+v6MXjld32TSUbmQfknza+eC9EcsaB9h+Xg==
X-Received: by 2002:a17:90a:b318:: with SMTP id d24mr3990001pjr.142.1576559926619;
        Mon, 16 Dec 2019 21:18:46 -0800 (PST)
Received: from localhost.localdomain ([2408:821b:3c17:cb30:1977:b0f8:1014:66a0])
        by smtp.gmail.com with ESMTPSA id w12sm24678960pfd.58.2019.12.16.21.18.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Dec 2019 21:18:46 -0800 (PST)
From:   youling257 <youling257@gmail.com>
To:     linux@dominikbrodowski.net
Cc:     viro@zeniv.linux.org.uk, torvalds@linux-foundation.org,
        gregkh@linuxfoundation.org, rafael@kernel.org,
        akpm@linux-foundation.org, mingo@kernel.org,
        linux-kernel@vger.kernel.org, youling257 <youling257@gmail.com>
Subject: Re: [PATCH 4/5] init: unify opening /dev/console as stdin/stdout/stderr
Date:   Tue, 17 Dec 2019 13:17:51 +0800
Message-Id: <20191217051751.7998-1-youling257@gmail.com>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <20191212181422.31033-1-linux@dominikbrodowski.net>
References: <20191212181422.31033-1-linux@dominikbrodowski.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

it caused Androidx86 /system/bin/sh: No controlling tty: open /dev/tty: No such device or address
/system/bin/sh: warning: won't have full job control

Androidx86 alt+f1 root on tmpfs, alt+f2/f3 root on rootfs.

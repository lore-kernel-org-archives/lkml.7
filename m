Return-Path: <SRS0=TLrx=2G=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,USER_IN_DEF_DKIM_WL autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8EA1AC43603
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Dec 2019 21:12:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5BED921739
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Dec 2019 21:12:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="cYa9EI27"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726855AbfLPVMc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 16 Dec 2019 16:12:32 -0500
Received: from mail-pg1-f201.google.com ([209.85.215.201]:44474 "EHLO
        mail-pg1-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726275AbfLPVMc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Dec 2019 16:12:32 -0500
Received: by mail-pg1-f201.google.com with SMTP id o21so4712053pgm.11
        for <linux-kernel@vger.kernel.org>; Mon, 16 Dec 2019 13:12:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=9y78Nkgcr0rFazEi3lkzksbWvy3PwZ64nocKC8qyZAo=;
        b=cYa9EI274JIRQVbIgi3maMgKVcS+usMKroHNF+v6wrxHGyZjvfzKlpTkLFSAHsVZuU
         mu1Imsuic3lrLqfSw7GgejFmc0YlJwv2NSfjtTpc0Ms2KKD42uJI5QJFyVovMlzCIw7e
         jpEj2EqAbp+YBRYJe6tkj7tq6vrC79ddedqgneklA5rzKh1aD3D50VZcsNN+N0hrVGzl
         Mg/5sK50a9U7hTr3NMp0NaBlb2znTdFR392MnuOhJEoetQQ3k8I/tg3Vz0TzsEXVdxfF
         4E475LBNK+Bo3YVzCDlwWT3ra1+z8EdakdER6Lhg0adCeq1nTPmU2m+hoIAd0TJWdHZ/
         5A5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=9y78Nkgcr0rFazEi3lkzksbWvy3PwZ64nocKC8qyZAo=;
        b=WabRKmUqJQT8w/rojfnus5blrJc0fdsIBhQJAF1NnmzbWe2J/VOUDOsqAakeXjjP/T
         3aftsOGDUyibAtUfMDqlf8uI806VhdKfr1rFT8NgzSKWTDIZzZ2HSPeAn2uKzIrnG3nU
         DBEybxjWCS/x5t3dO/KX0xoIvZUHkGn+x7Qzs6cig8x+Hq48oec67k4ThxBb46XJyzhz
         AznVr60r60JY+RqaK6vak5lCVpmC6JQWtaIsmZrRiLNXaM05uiKtXiAUS7Uw7cNcIyOT
         O3VGfaujV1BBI61HLVUXQrrmWw+bSEbl+eoPWJ0XzNkGMIlAMfn+Pbq8IhE9auIwa/Q3
         /BAQ==
X-Gm-Message-State: APjAAAWM3NGdm1+Y8zIr+E/LgJwzWFMBLfwvXAZ6ym4GbTxK6HgE9yK6
        NTeEVemLeylxE6y0WZlDN7hG/+/AZsXGdDQoJ5U=
X-Google-Smtp-Source: APXvYqzM6OEojY4VCiFd1sv/7bsVMZYLRqU+GCmZI8SZ+41MiloF4U9reK02kVuWF1zkYsIn/8n8u+A8EOwCZ5AYzrk=
X-Received: by 2002:a63:5b0e:: with SMTP id p14mr21436286pgb.315.1576530751321;
 Mon, 16 Dec 2019 13:12:31 -0800 (PST)
Date:   Mon, 16 Dec 2019 13:12:28 -0800
In-Reply-To: <20191212135724.331342-4-linux@dominikbrodowski.net>
Message-Id: <20191216211228.153485-1-ndesaulniers@google.com>
Mime-Version: 1.0
References: <20191212135724.331342-4-linux@dominikbrodowski.net>
X-Mailer: git-send-email 2.24.1.735.g03f4e72817-goog
Subject: Re: [PATCH 3/3] init: use do_mount() instead of ksys_mount()
From:   Nick Desaulniers <ndesaulniers@google.com>
To:     linux@dominikbrodowski.net
Cc:     akpm@linux-foundation.org, gregkh@linuxfoundation.org,
        linux-kernel@vger.kernel.org, mingo@kernel.org, rafael@kernel.org,
        torvalds@linux-foundation.org, viro@zeniv.linux.org.uk,
        clang-built-linux@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Shouldn't patches bake for a while in -next? (That way we catch regressions
before they hit mainline?)

This lit up our CI this morning.

https://travis-ci.com/ClangBuiltLinux/continuous-integration/builds

(Apologies for missing context, replying via lore.kernel.org directions.)
https://lore.kernel.org/lkml/20191212135724.331342-4-linux@dominikbrodowski.net/

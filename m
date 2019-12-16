Return-Path: <SRS0=TLrx=2G=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9DF88C43603
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Dec 2019 10:35:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 67EF720725
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Dec 2019 10:35:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qBC68jjJ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727431AbfLPKfe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 16 Dec 2019 05:35:34 -0500
Received: from mail-ed1-f68.google.com ([209.85.208.68]:43244 "EHLO
        mail-ed1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727099AbfLPKfe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Dec 2019 05:35:34 -0500
Received: by mail-ed1-f68.google.com with SMTP id dc19so4542047edb.10;
        Mon, 16 Dec 2019 02:35:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=TeIkQ7z7qybAupiPPl64fND/maLNJXlkx+NsGT115tg=;
        b=qBC68jjJrXzlLPmkC9BdLk5QDfErJAbpx9TWjTJegzGtit754Odn4gUmB5tXyXQ9MV
         NWM4pfGT6mtA3TDGIhwh1tsiCcpJtYj7pvWxLEmjT/8Lxr1M6IWabHLDetm49zeJGtab
         zrflNPs9/+YQCAJrmyMONUB9+MXjprlOfA7MChG6vJ4jWhnUtmNEz8NC5zri3z+BztzC
         5OHigzlXXO6B0loCN0Qy0/4YYCWlyJ6zbZ3e2qIFO0B1xkEgt/XzbFqpw7Y2mZQb9rgc
         mK2YTqNGGv4UfhjYaaQVpp7ua7gsTxxRknMJGHYivTRYz48j4kx01IhNNgVPu76Ztvoj
         lWqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=TeIkQ7z7qybAupiPPl64fND/maLNJXlkx+NsGT115tg=;
        b=fUc9BLCJFl6yXRlMoQvDRpcCUx8bZXX1oDi+QVoBiGgl71nDY2//4zVjN9YCdixL7l
         duZL3jk4kUw/Dn4kvHWwtytNVPNH+VsGGxIFs6+tUVRFVOPT1rKITlXIAuWEri3DhjlW
         ZA7l3ZDmEaCPIGeDopOnYvl82wk5qWwMNzSjkaSx6J5lEE1Cv0W0nbBEJm+V8+9/yLBm
         +VZ8vuAXl7oynoCUWKbtP5TJHW93GSZCF4OaDWbVXRBPHgkE1AxwWU4cIomi60mqgK8O
         ywd9Y1U+wyihmlf2kcx2CFoeqqkUW6fVsqxU1wwVNOliuOSkXv9cF6JhBnml7bFyFalb
         c4qA==
X-Gm-Message-State: APjAAAWU2VP90jmh4M2q/dlkm4IiDVoTfMXvOuOEVHJh1AgL6K5y3RrY
        Diwq/csaWOF8bvnK8LCxBYk=
X-Google-Smtp-Source: APXvYqx0LwqMVlZ6eOiMsX6InbuTzF7YtcARL8JZbcrOPsRj4NMnesm1YwHKAVIphyvOkS7P7xQc1g==
X-Received: by 2002:a17:906:3486:: with SMTP id g6mr32428778ejb.50.1576492532038;
        Mon, 16 Dec 2019 02:35:32 -0800 (PST)
Received: from localhost.localdomain ([46.114.39.109])
        by smtp.googlemail.com with ESMTPSA id n24sm504191edr.30.2019.12.16.02.35.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Dec 2019 02:35:30 -0800 (PST)
From:   Gon Solo <gonsolo@gmail.com>
To:     Yoshinori Sato <ysato@users.sourceforge.jp>,
        Rich Felker <dalias@libc.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Mike Rapoport <rppt@linux.ibm.com>,
        Nicholas Piggin <npiggin@gmail.com>,
        Gon Solo <gonsolo@gmail.com>, linux-sh@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 0/1] Fix SH config error.
Date:   Mon, 16 Dec 2019 11:35:21 +0100
Message-Id: <20191216103522.32215-1-gonsolo@gmail.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This fixes an error reported at 
http://kisskb.ellerman.id.au/kisskb/buildresult/14067948.

On SH4 it was possible to configure NUMA without SMP.

Gon Solo (1):
  Fix undefined reference to 'node_reclaim_distance'.

 arch/sh/mm/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

-- 
2.20.1


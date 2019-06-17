Return-Path: <SRS0=xALZ=UQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BBE02C31E57
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Jun 2019 10:34:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 90B672084D
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Jun 2019 10:34:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="LAo19ge0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726511AbfFQKed (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Jun 2019 06:34:33 -0400
Received: from mail-ed1-f43.google.com ([209.85.208.43]:46545 "EHLO
        mail-ed1-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726091AbfFQKec (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jun 2019 06:34:32 -0400
Received: by mail-ed1-f43.google.com with SMTP id d4so15405499edr.13
        for <linux-kernel@vger.kernel.org>; Mon, 17 Jun 2019 03:34:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google;
        h=date:from:to:cc:subject:message-id:user-agent:mime-version;
        bh=IQHiXQJSyaAV5xE4fH6nTw8aRdfXeN7Ir4DZSrsaBRs=;
        b=LAo19ge0oueK7Pb9Mh6fY6g9xhXPlzhpzg00PvvOQNEOJlKM5dmIGkp5dKoHJFzPhY
         pkEg+I3vfPjhenjxfJE8Zv7ReGrAO+aX0Zm7O5opNWIMsvzLCyeX+0U3q9xlGhc6Bqgh
         6AeVHADWajHUXo7Eylkx8Jpk8RSifjvomQmYiWuS1rY7HZudFs5G76U3hB/nynncyhZ4
         gO57tqu3rM/qam5Qva9y5VXwZ7YmWaMTgxMtWJG9+GTgwR1c20z9sQf6Q2nX0hJOuorU
         ekklCgeIzBkLJ+/c88SPXiUN79UsgVWde3MF2fUhMILmCBXSRuKgDdo3vWtkejG+fUl6
         odyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:user-agent
         :mime-version;
        bh=IQHiXQJSyaAV5xE4fH6nTw8aRdfXeN7Ir4DZSrsaBRs=;
        b=nbIKAc8r5s/XZYOr9zj+8N+NCGxxe7G+RpoIiZlQ+0gYi5Zj0fdscSBWpM2cLPveJa
         ALLUaw6j54YJp9Ln7MvUt4lY0UWryZ1EORhe3B2y6gSmyVsmDpPdgVm7vWwVSuZtUO3/
         B8BP01BMmZU0AfullI2dtllV+olfWekKSZDn4pSvwf8QD5Ncra8+zKBubxmG9klzeTPh
         Vosvx6dzWbRcd86HqVZui+pD66egyt6FshbL5jq1Xa6QFpM1ELJh2r1qv7E5eIZz6G5/
         ghyJZ89MFSI0mRjfLm30Ylta+LIZDmS2bh8PvkgiNDsr42F0bWaQeZwWjOmoeZg8NDns
         BnMQ==
X-Gm-Message-State: APjAAAXxkVx6jmIKobEJPC5APlFLfYrCjtaS37Qef8pDwA6stM6eWdff
        LbxYIF+Q+yStBm2L8I0Kn8FT6Q==
X-Google-Smtp-Source: APXvYqy3d1iaa6HtQHTLE3Kz4tHzeC9MSqQO02NQlJ09h02lhoTJpjm8sgugnb/hG2KbYLb5z1o4SQ==
X-Received: by 2002:aa7:c486:: with SMTP id m6mr53013807edq.298.1560767671139;
        Mon, 17 Jun 2019 03:34:31 -0700 (PDT)
Received: from localhost ([81.92.102.43])
        by smtp.gmail.com with ESMTPSA id x30sm3581943edc.53.2019.06.17.03.34.30
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Mon, 17 Jun 2019 03:34:30 -0700 (PDT)
Date:   Mon, 17 Jun 2019 03:34:30 -0700 (PDT)
From:   Paul Walmsley <paul.walmsley@sifive.com>
X-X-Sender: paulw@viisi.sifive.com
To:     linux-riscv@lists.infradead.org
cc:     linux-kernel@vger.kernel.org, palmer@sifive.com
Subject: New shared upstream Linux tree for arch/riscv
Message-ID: <alpine.DEB.2.21.9999.1906170320300.19994@viisi.sifive.com>
User-Agent: Alpine 2.21.9999 (DEB 301 2018-08-15)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Palmer, with Konstantin's help, recently set up a shared tree for 
arch/riscv patches at:

git://git.kernel.org/pub/scm/linux/kernel/git/riscv/linux.git

As with other kernel.org git trees, it can be browsed via HTTPS at:

https://git.kernel.org/pub/scm/linux/kernel/git/riscv/linux.git/


This tree is what we'll use for upstream-bound patches going forward.


- Paul

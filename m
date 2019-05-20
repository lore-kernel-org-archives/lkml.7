Return-Path: <SRS0=lq4r=TU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4D940C04AAC
	for <linux-kernel@archiver.kernel.org>; Mon, 20 May 2019 17:21:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1141B20675
	for <linux-kernel@archiver.kernel.org>; Mon, 20 May 2019 17:21:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="BF/jOVKx"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392841AbfETRVy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 May 2019 13:21:54 -0400
Received: from mail-it1-f182.google.com ([209.85.166.182]:52800 "EHLO
        mail-it1-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390855AbfETRVx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 May 2019 13:21:53 -0400
Received: by mail-it1-f182.google.com with SMTP id t184so298183itf.2
        for <linux-kernel@vger.kernel.org>; Mon, 20 May 2019 10:21:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google;
        h=date:from:to:cc:subject:message-id:user-agent:mime-version;
        bh=U1mBWkntXkHe1OCaEZa+jzt5Ip0fm+Wb1DlBjW6XVX0=;
        b=BF/jOVKxDvMpDHjMQlvokcMXOadG/5ViD73TuHUBrB9dtvRdjbDQVHTNnHaLJLJUs9
         WOwTsOZdjbTpyhpmzN6oT4uSumOGxigzKYt3SFVUC6R9qG8WVYh2ln5esDW1/l4nFnOv
         aRLJWCRooneNAi5N7rznzcbzXww4/UcK2zs/bZji4izYgVB3QpA4L5oAT5XMtpTLvrUE
         7WYw4NGYujkC90KXN/TWEW+eKrVe9N4MhhfaaDOwsKkC5hQ7HS9C5/Ysgc8Hcz0GvKAd
         boKSsky9t/eTRN/jK3tFfywGkm0u9yAbsPK/vvhTcYKJJMjUkSlmZEIihH9YL/hKVPFS
         qsRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:user-agent
         :mime-version;
        bh=U1mBWkntXkHe1OCaEZa+jzt5Ip0fm+Wb1DlBjW6XVX0=;
        b=i0jGj2TaU0bubxZWReNfOGJyrM3N2/nfNlSvXsjLzZLEzW2hHS9PY0SSM4oqbZa8M7
         qSyVZjas+ywgMoSTzCwzvVSnjyvxlkUJWL2HTAlutnR01UI0z5o5WkwAG7NicZYU13fE
         keuNNkrSfkuvlActNLRvc70YAtWGQAsdbwNSv2l9kowL2PcB+j8CFVHqBtXlkHnNdPc0
         3V4ae7VlBgTa9y7lUDeYy079aBH55lYKdfUOJnRIsbnsjqBrhFUmyfj7RSFZlvd50OIO
         xZzECuhvi931Bf6vE0KEI/Vq7EPxCgwaKH8F89SUOoAsX2eTmrxMndlBDYrzAnMh8uOi
         53XA==
X-Gm-Message-State: APjAAAWFrRd/inRyKbmIBWQsgZyWDFl0v4EcdQrXSwEUb7YJtAw2eBU7
        RGQktObERH2z0kloUHGYD8wE8Q==
X-Google-Smtp-Source: APXvYqzm9lzmDOXN1zutvigb7Iph9iyTT4n+F+YUyQlvjbxbo+bmPjFo5lSuHBq42ujfRuR40BSwvg==
X-Received: by 2002:a24:56d1:: with SMTP id o200mr115019itb.93.1558372913090;
        Mon, 20 May 2019 10:21:53 -0700 (PDT)
Received: from localhost (c-73-95-159-87.hsd1.co.comcast.net. [73.95.159.87])
        by smtp.gmail.com with ESMTPSA id v134sm56488ita.16.2019.05.20.10.21.52
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 20 May 2019 10:21:52 -0700 (PDT)
Date:   Mon, 20 May 2019 10:21:51 -0700 (PDT)
From:   Paul Walmsley <paul.walmsley@sifive.com>
X-X-Sender: paulw@viisi.sifive.com
To:     linux-riscv@lists.infradead.org
cc:     linux-kernel@vger.kernel.org, palmer@sifive.com
Subject: Patches for v5.2-rc and v5.3 merge window
Message-ID: <alpine.DEB.2.21.9999.1905201019010.15580@viisi.sifive.com>
User-Agent: Alpine 2.21.9999 (DEB 301 2018-08-15)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Folks,

Palmer has asked me to collect patches for the v5.2-rc releases and v5.3 
merge window, so I'll be doing so.  This is just a heads-up so no one is 
surprised to see 'patch queued' responses from me.


- Paul 

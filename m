Return-Path: <SRS0=RThv=TD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CC7ACC43219
	for <linux-kernel@archiver.kernel.org>; Fri,  3 May 2019 03:33:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 951442075E
	for <linux-kernel@archiver.kernel.org>; Fri,  3 May 2019 03:33:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="sBotVlkf"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726304AbfECDdq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 May 2019 23:33:46 -0400
Received: from mail-ed1-f67.google.com ([209.85.208.67]:42518 "EHLO
        mail-ed1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726114AbfECDdp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 May 2019 23:33:45 -0400
Received: by mail-ed1-f67.google.com with SMTP id l25so4348830eda.9
        for <linux-kernel@vger.kernel.org>; Thu, 02 May 2019 20:33:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=RdojDANAJ6rzclEPLAA4FdcSP1GiFYCSI8+a3mJzXmI=;
        b=sBotVlkfKKZhxUaYy9XvO+EUUTHs8VDdZ9d2b8+7Yu8V+9yfbQjMmQfIVL46zxU35N
         CIyqpEit6G/j5dqs20bTv8PB6UYJmiEpyn379hyP63eOmsh7BRJv3pxXN9HCnWzs76MU
         GSOw4PV1v2wwKP3COFu3mZZzMa3iJWwQzczQ8SO1jp4GD48+lyNnt4txrqpJDyVo7hNP
         jLEFyEMhQ71v7Dfk8i9nazI6dgcPNDMbYkImEVUL/PD+XW/W1SpgmrwP2YGwin/QdTES
         r9Lrvb33kLOfYwX2/tSZmE5R4az/pFs/xdCsQR9Vathyz36YesXZFJDzLkKoOlJ4hEny
         6r0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=RdojDANAJ6rzclEPLAA4FdcSP1GiFYCSI8+a3mJzXmI=;
        b=O1QI/NKbNSryk20rls+PYsKKVjlbw41fQyQTScI0T7w6UBsTdccPQ8CN3PPmkSYDeC
         ayhKp0FCGArN2cv7/z92FVafQl4C6pbAabacRzDc1QM3NOywL9r0xjlEkK3pmmNzrvs5
         kdESK3PcFMsXUijywwVOUsMxleAnNwxCuf4fLv8UGbBAL0H4re7DwnDaBPly9X4o5Yfj
         OONPfKeEolN1O9IjMSi4ZjUoRzA7lyHkuc5bHI7mI8wjs5Dv4E19t0WDL5SVr12LIw2+
         UzmINcqXMoZMMzA0mQIwuuQ+7gye0ijQ1vHxxmEvnIR6NExIcLcvOhC2oqBwVAvaBl9y
         0ZrQ==
X-Gm-Message-State: APjAAAUNoMkJ+sGnw1KMEw0Y0YN8xrfC/WwYC45H2a35uUmFIdDqtr7I
        znPK49YTD3tANWXPX9DEfOE=
X-Google-Smtp-Source: APXvYqxoOBfWgFA3QZ5YcV5wYRnq9lz5at6L+Nl0JyBStbS6YGlUx5uUsozDEn1Jy8a3c7kAKW5S5w==
X-Received: by 2002:a50:8c03:: with SMTP id p3mr5401146edp.267.1556854423921;
        Thu, 02 May 2019 20:33:43 -0700 (PDT)
Received: from archlinux-i9 ([2a01:4f9:2b:2b84::2])
        by smtp.gmail.com with ESMTPSA id g32sm258988ede.88.2019.05.02.20.33.42
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Thu, 02 May 2019 20:33:42 -0700 (PDT)
Date:   Thu, 2 May 2019 20:33:40 -0700
From:   Nathan Chancellor <natechancellor@gmail.com>
To:     Cliff Whickman <cpw@sgi.com>, Robin Holt <robinmholt@gmail.com>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org,
        Nick Desaulniers <ndesaulniers@google.com>,
        clang-built-linux@googlegroups.com
Subject: -Wuninitialized warning in drivers/misc/sgi-xp/xpc_partition.c
Message-ID: <20190503033340.GA7980@archlinux-i9>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,

When building with -Wuninitialized, Clang warns:

drivers/misc/sgi-xp/xpc_partition.c:73:14: warning: variable 'buf' is uninitialized when used within its own initialization [-Wuninitialized]
        void *buf = buf;
              ~~~   ^~~
1 warning generated.

I am not really sure how to properly initialize buf in this instance.
I would assume it would involve xpc_kmalloc_cacheline_aligned like
further down in the function but maybe not, this function isn't entirely
clear. Could we get your input, this is one of the last warnings I see
in a few allyesconfig builds.

Thanks,
Nathan

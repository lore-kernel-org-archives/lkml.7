Return-Path: <SRS0=X8En=XO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_2 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9BA95C3A5A6
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Sep 2019 13:06:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6E42620640
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Sep 2019 13:06:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lca.pw header.i=@lca.pw header.b="bX/AXmcF"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732233AbfISNGU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 19 Sep 2019 09:06:20 -0400
Received: from mail-qt1-f172.google.com ([209.85.160.172]:46908 "EHLO
        mail-qt1-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732211AbfISNGU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Sep 2019 09:06:20 -0400
Received: by mail-qt1-f172.google.com with SMTP id u22so4031183qtq.13
        for <linux-kernel@vger.kernel.org>; Thu, 19 Sep 2019 06:06:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lca.pw; s=google;
        h=message-id:subject:from:to:cc:date:mime-version
         :content-transfer-encoding;
        bh=IsqRTG9caaUhIK42xkXjoF6FO3aLA3ZmBQE/WyKykk4=;
        b=bX/AXmcFaVfglElnWxWB7XeLoIyuIUuRKwnBOcGM8irKFzDRRnerNcio0q3i5A4QrZ
         cfFzUyk/XPWkTKIGmie6qNNsLqV3OjcAW21aEtGGX5BW7Vqb7/nIiFfi5NvzNi5UMBCl
         vFTUFcnYZ6/7As8USO7Ch8DcS8WfbQzYIxx8Hqiu05tQ3XGoQaOdcXJG7Jt5dpfpHyVR
         3aHQeoHgD5Izv4STeOm35bEQ90niIoP/7YpU/COMAvtqXjRIfuVTVdlEFaOguucjrf3P
         lx5c4aT8F2WZq20vqoSn59Mec7fzVcOEhrBwWS5b0+SCHG0DiWNihwNhgs7u8wkBJIRK
         Ooiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:mime-version
         :content-transfer-encoding;
        bh=IsqRTG9caaUhIK42xkXjoF6FO3aLA3ZmBQE/WyKykk4=;
        b=hughggLuawO2ah79lzSDddmP85DlisYzm+hClc6CjMVHEZlyHGPFPEhjpK8vDg3j3q
         8HjbtKNandqZSbfm1xsRyCuydPfIrZpWHTnmeGPlUdtb9MyYAAglkKGMg6+FiJCHUr3s
         hJ6it7geCVqfKM0fhgq36q/e2WmY6+4p2ajg1QofhaU+6d/jCn6BZVRU9+YFcknnLBYN
         sbHmqdbgS89WqU87J1qZR8K1VYbtc/T/bQ8eIIpSweBkf/qrYFdgaXoy+8tP3o67rAAD
         gwt2y7ZgmUpvmS7LHzy1tJewsFV/+MM4PVFeFZXnLCjW8Uf9AYiK/T33OWky9u+xhhZe
         dI0A==
X-Gm-Message-State: APjAAAUkdUxd5m6/h4FZKVIJFUPNFicdL4CK85QPlq72JCL5bB9r2qil
        G9B0LIXCRbdV16cSnmgzwJGS3g==
X-Google-Smtp-Source: APXvYqzasIZpl9AANzlifB7I5Xk/YzI5eRwkZmoUJoB3pNCXKoD51RWkv6AWvvdUe41/RXWOpLAw6A==
X-Received: by 2002:ac8:7502:: with SMTP id u2mr2829778qtq.216.1568898379188;
        Thu, 19 Sep 2019 06:06:19 -0700 (PDT)
Received: from dhcp-41-57.bos.redhat.com (nat-pool-bos-t.redhat.com. [66.187.233.206])
        by smtp.gmail.com with ESMTPSA id u132sm4708482qka.50.2019.09.19.06.06.17
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 19 Sep 2019 06:06:18 -0700 (PDT)
Message-ID: <1568898377.5576.186.camel@lca.pw>
Subject: "arm64: use asm-generic/dma-mapping.h" introduced a kbuild warning
From:   Qian Cai <cai@lca.pw>
To:     Christoph Hellwig <hch@lst.de>
Cc:     Will Deacon <will@kernel.org>,
        Stefano Stabellini <sstabellini@kernel.org>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Michal Marek <michal.lkml@markovi.net>,
        linux-kbuild@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Date:   Thu, 19 Sep 2019 09:06:17 -0400
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.22.6 (3.22.6-10.el7) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The commit 5489c8e0cf03 ("arm64: use asm-generic/dma-mapping.h") introduced a
kbuild warning,

scripts/Makefile.asm-generic:25: redundant generic-y found in
arch/arm64/include/asm/Kbuild: dma-mapping.h



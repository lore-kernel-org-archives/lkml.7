Return-Path: <SRS0=SA5R=SA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BA289C43381
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Mar 2019 06:18:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7D0C02173C
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Mar 2019 06:18:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="R5HTzTyD"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728729AbfC2GSo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 29 Mar 2019 02:18:44 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:46068 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726251AbfC2GSn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Mar 2019 02:18:43 -0400
Received: by mail-pf1-f194.google.com with SMTP id e24so532387pfi.12
        for <linux-kernel@vger.kernel.org>; Thu, 28 Mar 2019 23:18:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google;
        h=date:subject:in-reply-to:cc:from:to:message-id:mime-version
         :content-transfer-encoding;
        bh=1l5JI+ZvP4zqZKbBPfvQEpr5z6b0/ApcBAe3hBUDHXc=;
        b=R5HTzTyDk169QZTZJ1fjlYeJqh2sGvCWhWKJcRAKU8hP6QJymWU4k5BT4BzC9qIyUC
         Dvac+6ytrPeA00pQUKkzqjeXQ1RC8UcmH2qYJjRT9zTTABQbcWl7wK9OlDGUoP1stWiv
         zbmmiqdR8xfJo4tkNOIq7PBIknz3zIVmrR7/HNLSzBCaifsLggPrehqUsJ8y9GxbuJqF
         Tinp3mkS3BRdnL8cMHuzGOoe7K58/wPZDKFmxmgxJ+yz4R1VkoIOqbcdKUnnR99jr8NT
         QzPWLlkSFGEEGkooMlhGXTxslSgJ788H9MIhfybBfAyal+VO9c/12D+g67YuFrseIqqi
         uzcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:subject:in-reply-to:cc:from:to:message-id
         :mime-version:content-transfer-encoding;
        bh=1l5JI+ZvP4zqZKbBPfvQEpr5z6b0/ApcBAe3hBUDHXc=;
        b=kQJ6j7ffh2McOUZ2RJi9NlzNVnfH+2siFN8MtvTuR6rc0JPJlVQN6AXra3lQrTno9n
         S4+orsyl07F+Qa26fmPXdo0nybnn5ZuLD3KfDPn6PxB0FT0sMp+vKPmz4I637G8gPTsc
         zngdbtqZNaomdeyCMbsr6DJ3bhEs9ygPiE1z4pIlnOmM+0UsTkhXbt2GDagY/dJC00sY
         /t07RIqNsqWorJgrpc2XchT/ndO9UxBLIJciYo66R8elydLu2tHaw2kgQYFd/JH4K+ph
         rEg+bEk5xuHsxbGHh7VAhmhur/2JQrCC+whwlUtEZuaPbi8q/adq0Q4Et3TsOHSdckvG
         jXOA==
X-Gm-Message-State: APjAAAVW0+ACavgotIBTeNXyir1+lWB1XYQHli0nvbYEmWx6QReYGYlK
        B+LiY1MYd0svezMm9iVJxgZHwg==
X-Google-Smtp-Source: APXvYqzbG6H1PfNnNYQIdyca0sEFVnS/c7cEhnyimF6SqaqO2FnSCJk3sNjrRKfbUPdD31KyNRqYuA==
X-Received: by 2002:a65:6098:: with SMTP id t24mr5942417pgu.57.1553840323372;
        Thu, 28 Mar 2019 23:18:43 -0700 (PDT)
Received: from localhost ([64.62.193.194])
        by smtp.gmail.com with ESMTPSA id 71sm2500849pfs.36.2019.03.28.23.18.41
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 28 Mar 2019 23:18:42 -0700 (PDT)
Date:   Thu, 28 Mar 2019 23:18:42 -0700 (PDT)
X-Google-Original-Date: Thu, 28 Mar 2019 23:17:34 PDT (-0700)
Subject:     Re: [PATCH] RISC-V: Fix FIXMAP_TOP to avoid overlap with VMALLOC area
In-Reply-To: <20190322132509.GA19263@infradead.org>
CC:     Anup Patel <Anup.Patel@wdc.com>, aou@eecs.berkeley.edu,
        Atish Patra <Atish.Patra@wdc.com>,
        Christoph Hellwig <hch@infradead.org>,
        Paul Walmsley <paul.walmsley@sifive.com>, rppt@linux.ibm.com,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
From:   Palmer Dabbelt <palmer@sifive.com>
To:     Christoph Hellwig <hch@infradead.org>
Message-ID: <mhng-05d2bbbf-c808-408e-8fc3-14c00ac167b6@palmer-si-x1c4>
Mime-Version: 1.0 (MHng)
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 22 Mar 2019 06:25:09 PDT (-0700), Christoph Hellwig wrote:
> Looks good,
>
> Reviewed-by: Christoph Hellwig <hch@lst.de>

Thanks.  I've added this to my fixes list for the next RC.

>
> Btw, what is the 32-bit test vehicle of choice?  qemu with the
> virt machine?

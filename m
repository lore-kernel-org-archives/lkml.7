Return-Path: <SRS0=SA5R=SA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 40906C43381
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Mar 2019 07:41:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0BCF72082F
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Mar 2019 07:41:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="FdcQOxmq"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728933AbfC2Hl5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 29 Mar 2019 03:41:57 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:35350 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728857AbfC2Hl4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Mar 2019 03:41:56 -0400
Received: by mail-pf1-f193.google.com with SMTP id t21so657411pfe.2
        for <linux-kernel@vger.kernel.org>; Fri, 29 Mar 2019 00:41:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google;
        h=date:subject:in-reply-to:cc:from:to:message-id:mime-version
         :content-transfer-encoding;
        bh=87AKfepmg1YBU60XI47JClmDBJwrH1U9K1JCCxH1FIA=;
        b=FdcQOxmqgkufzB+tIMV+9tIAVevjyvHuEl1tI7ZedgTO+wmgMfQoe7wxbZo0sNPYpA
         TQuIAwzVeFx4aPtz9qcqnDGUdvtbGcC2WdF32Jcnyg1VQl0jb4V6EqbwPxMbKF+KM7/n
         Hj9O8I5KA1aqIq4cQF3+2Xb38n9N59QwoLnren8ib6uTgGE7tmYWkGVwS4TJiXy2LrTW
         XnNApn38hUgWy1vBFboT9VyCFBp4BXk1eFhferM84XewHAaaQHljofVmUVj7GgOtPfU1
         t4wRUjsV/tKxBG04Tdzp0nInA2qDfE1sVeFcXqFjq/J+SVpWBz2M7aNTF/mjKDizFDwp
         gpEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:subject:in-reply-to:cc:from:to:message-id
         :mime-version:content-transfer-encoding;
        bh=87AKfepmg1YBU60XI47JClmDBJwrH1U9K1JCCxH1FIA=;
        b=SWqHlUijtSPtnVsgNiC581/GullYCQHhfDtZXCXmk7Hjiwfj4ddhZA43yncMKwB0k9
         9wIFKHkMtUp8Sle46RVidSlJd0k533smXmYKmGsumPThsfuitoYwC4OkzzDqNf390aMO
         AD1tKfgFRkK5zoM1WkYsNEGJ9Q+s8pC48ElMxUxfZ2RYHl3du9mqS0kkxW4Krdh6eYiT
         IpSNyvBcAaTuXMRCg6u01dTOGvhu1AlI4+kUu8GIim/LIS+/qKirk+N7uvA0ueM6hJgV
         Sp5MPXoIZ7FuqP9ccpCbDgiZEWB/Y18yvxrIe0WbtccBeIlYLt8L3MPbIsApTjMA7JmJ
         fuig==
X-Gm-Message-State: APjAAAUVBIaG8XMcNoeJPkCGBpmq1NnhIRGpzA70lHXImcTffFOzJz7C
        gPJF63kzep+/RXWyX7i++kkU4g==
X-Google-Smtp-Source: APXvYqwmtf5zEewvs8sK1oWcllagagYPnj9wLGSYUC/XDbHLXNvIvx7rAjCRBOwTNZfs+XnT4/6u2Q==
X-Received: by 2002:a63:c104:: with SMTP id w4mr16958115pgf.409.1553845315988;
        Fri, 29 Mar 2019 00:41:55 -0700 (PDT)
Received: from localhost ([64.62.193.194])
        by smtp.gmail.com with ESMTPSA id l74sm1846305pfi.174.2019.03.29.00.41.47
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 29 Mar 2019 00:41:55 -0700 (PDT)
Date:   Fri, 29 Mar 2019 00:41:55 -0700 (PDT)
X-Google-Original-Date: Fri, 29 Mar 2019 00:15:55 PDT (-0700)
Subject:     Re: [PATCH] RISC-V: Use IS_ENABLED(CONFIG_CMODEL_MEDLOW)
In-Reply-To: <20190308145302.GA13397@infradead.org>
CC:     joe@perches.com, aou@eecs.berkeley.edu,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
From:   Palmer Dabbelt <palmer@sifive.com>
To:     Christoph Hellwig <hch@infradead.org>
Message-ID: <mhng-3944e622-92e2-433a-8965-c7b3d2de072a@palmer-si-x1c4>
Mime-Version: 1.0 (MHng)
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 08 Mar 2019 06:53:02 PST (-0800), Christoph Hellwig wrote:
> On Thu, Mar 07, 2019 at 03:56:34PM -0800, Joe Perches wrote:
>> IS_ENABLED should generally use CONFIG_ prefaced symbols and
>> it doesn't appear as if there is a CMODEL_MEDLOW define.
>>
>> Signed-off-by: Joe Perches <joe@perches.com>
>
> Looks good,
>
> Reviewed-by: Christoph Hellwig <hch@lst.de>

Thanks.  This one is also in the list for the next RC.

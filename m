Return-Path: <SRS0=lTpO=2Z=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 01467C32767
	for <linux-kernel@archiver.kernel.org>; Sat,  4 Jan 2020 00:11:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CB2AE222C3
	for <linux-kernel@archiver.kernel.org>; Sat,  4 Jan 2020 00:11:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="cKfo4acM"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727183AbgADALx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 3 Jan 2020 19:11:53 -0500
Received: from mail-il1-f195.google.com ([209.85.166.195]:45819 "EHLO
        mail-il1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726229AbgADALx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Jan 2020 19:11:53 -0500
Received: by mail-il1-f195.google.com with SMTP id p8so37972003iln.12
        for <linux-kernel@vger.kernel.org>; Fri, 03 Jan 2020 16:11:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google;
        h=date:from:to:cc:subject:in-reply-to:message-id:references
         :user-agent:mime-version;
        bh=xKt2PPmd3ZVH3skLSMZLWe5gk5gPeWTzpSDIkOKvuyM=;
        b=cKfo4acMI290WcTrTV19qCiykdAdniIGYGGE5KiHM30OB8SfCxIKpuBwAxJY7vY7qO
         kIj6AwP6PnhvGoW/3ywmR+3axhct15ptkRvqRDHXLasYSfLjMiwvvIzNGeUdRalDi4XU
         mzABFHWUnfDK3qqqm8hGD8Nznxroh9Jsd09lwY0uXpmpisrTrxDWWilImmPtM/NXqMsk
         GxoJYdrrfA1Wq+9fwSEmbkbVOjOlYbwnNinq54Gs21jSzuLxD5VPYBhL+4G8OvVAJuXa
         58bt4kvQueCv8DPcwkWjK+tY73qS0073Ij8wtWR76qvpDQT2pLcdPR79vgE/nmIj+nTS
         O1Yg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:in-reply-to:message-id
         :references:user-agent:mime-version;
        bh=xKt2PPmd3ZVH3skLSMZLWe5gk5gPeWTzpSDIkOKvuyM=;
        b=PEVblkOxtB+3zTwpfa0K1IunozFxfHofnKMOtTGDqEazr+rHzHYsShyn9fVXlPdFXA
         yBhayrYZPAO1tS9/Bbp5+jzrEsh6VvnfVg45kcRSakxJGC/kPkBUeP9y/Lf3KLoJIMal
         VrLCCQtE5EBJ/pRyDyCehUsyVmYmroP8INYjbIk4msWJS7TxP+KAnLZkt98nQWSh1bt7
         KTJeylBo+DWX6/msrGSGs19UnmtN3jXEGb8raMwzBboWiLgJGd5+exNyg/dXe3e171YR
         06TsT6SOsWYKb8HOLuJ2ywRT2sMvS8OSop6KkNLRXQsRmyTUUlErmplEIhjFEGINW3wR
         Ki+A==
X-Gm-Message-State: APjAAAXBHSbnZjsA80ZHuONIrAItBTiX9FpRAvZqy01Ulc6309l6ZTic
        O4O6TmrX4rl2e7QW9ANmUQQYWQ==
X-Google-Smtp-Source: APXvYqzYxki3BWxfIgAXwBHFoYf19/w9nt614PRZ+UMaMbO8xOSp+wTCGb8tjR09++TXHdu+cm5iRw==
X-Received: by 2002:a92:d308:: with SMTP id x8mr79828277ila.42.1578096712752;
        Fri, 03 Jan 2020 16:11:52 -0800 (PST)
Received: from localhost ([64.62.168.194])
        by smtp.gmail.com with ESMTPSA id v10sm15220324iot.12.2020.01.03.16.11.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Jan 2020 16:11:52 -0800 (PST)
Date:   Fri, 3 Jan 2020 16:11:50 -0800 (PST)
From:   Paul Walmsley <paul.walmsley@sifive.com>
X-X-Sender: paulw@viisi.sifive.com
To:     Zong Li <zong.li@sifive.com>
cc:     corbet@lwn.net, palmer@dabbelt.com, aou@eecs.berkeley.edu,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-riscv@lists.infradead.org
Subject: Re: [PATCH] riscv: gcov: enable gcov for RISC-V
In-Reply-To: <20200102030954.41225-1-zong.li@sifive.com>
Message-ID: <alpine.DEB.2.21.9999.2001031611430.283180@viisi.sifive.com>
References: <20200102030954.41225-1-zong.li@sifive.com>
User-Agent: Alpine 2.21.9999 (DEB 301 2018-08-15)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2 Jan 2020, Zong Li wrote:

> This patch enables GCOV code coverage measurement on RISC-V.
> Lightly tested on QEMU and Hifive Unleashed board, seems to work as
> expected.
> 
> Signed-off-by: Zong Li <zong.li@sifive.com>

Thanks, queued for v5.5-rc.


- Paul

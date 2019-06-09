Return-Path: <SRS0=y5Xy=UI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9F586C28CC5
	for <linux-kernel@archiver.kernel.org>; Sun,  9 Jun 2019 01:49:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 65E0F214AE
	for <linux-kernel@archiver.kernel.org>; Sun,  9 Jun 2019 01:49:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="huqAGmgR"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727903AbfFIBtS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 8 Jun 2019 21:49:18 -0400
Received: from mail-it1-f195.google.com ([209.85.166.195]:52682 "EHLO
        mail-it1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727444AbfFIBtR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 8 Jun 2019 21:49:17 -0400
Received: by mail-it1-f195.google.com with SMTP id l21so8356132ita.2
        for <linux-kernel@vger.kernel.org>; Sat, 08 Jun 2019 18:49:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google;
        h=date:from:to:cc:subject:in-reply-to:message-id:references
         :user-agent:mime-version;
        bh=gezvdrCCB1eFoVy4rTrBVmFiPugXcg77UnQ5Qbf7MCs=;
        b=huqAGmgRp/IMJ6IItXSuWcUGce0kAPYhAgld1VYkhBCxbq9jYWtGHv0VVxR4mtjtFj
         Pje56U+SCbwv7t17169G02j548woO0ZfGQhzG3gFA0ctipdR407PB1HbX595NdmtloBP
         uU1Cf+ilslY90HYbeyGdAFvZfdfgU+NjJ+99xeriSV0dZbLcnlRLfvmyGV+2unAaes07
         BGle8Q+qJmtuEsXdFbTUSGMxqIAYI82nXg6cVxO/EGEeX7NoPvzmyYIMUzILYCqz0bVR
         j2jncswh1KptTGcPwlSwss4HqKSKGUTXZ6jIUaYz6uajNDzHlisY5tHYugVJBid2NlWQ
         6EUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:in-reply-to:message-id
         :references:user-agent:mime-version;
        bh=gezvdrCCB1eFoVy4rTrBVmFiPugXcg77UnQ5Qbf7MCs=;
        b=m6e3HfWiwu+HEyYMXhhilPZ1wMl1aR5ECO5BRBpW0otHqIzO3f2OQuAsIt41nwZok6
         ZYfxg7Lks1BeV76uehQG4w6fP6AK32PBivQCPbmLawyH9E+mprPl+HhSBelh7yhQWpAu
         Drg8Q1Xk12AmeVdIgQuw+b+nK1n4bi1LEGoMfwK/+OaNiDAZ0HvbELYVmg02Szlf3joY
         fxaT4Ysz8ASE0ej+/Je2mRv5lsbKwXOjBMiEpyym9/Sped5KyzTHrfd6LYiFvszhpf5q
         TRB6RI8oynKACwHM2Zi09Tf4G1Qp5y8CRN6eN19PM9zNKyreE/K3dIfv1fArRwBmcSBn
         ZTbw==
X-Gm-Message-State: APjAAAVt94Gy+4f0Aq+sqqr2c/JYTNIE3cRa6MH0kekjaDc7Odn6sR1t
        EeqKYMS5K9Q3v4iBZvOMfoWF0w==
X-Google-Smtp-Source: APXvYqzhnLgdvut8Sw31mC+3id4EyC0GRJRfrCSBlSx1/cpNZwMxjofbGkBFHK4zP7Mf+HeG3Pnhfg==
X-Received: by 2002:a24:dc05:: with SMTP id q5mr9924544itg.123.1560044957125;
        Sat, 08 Jun 2019 18:49:17 -0700 (PDT)
Received: from localhost (219.sub-174-221-130.myvzw.com. [174.221.130.219])
        by smtp.gmail.com with ESMTPSA id j9sm2929924itk.23.2019.06.08.18.49.14
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Sat, 08 Jun 2019 18:49:16 -0700 (PDT)
Date:   Sat, 8 Jun 2019 18:49:09 -0700 (PDT)
From:   Paul Walmsley <paul.walmsley@sifive.com>
X-X-Sender: paulw@viisi.sifive.com
To:     Kevin Hilman <khilman@baylibre.com>
cc:     linux-riscv@lists.infradead.org,
        Christoph Hellwig <hch@infradead.org>,
        Palmer Dabbelt <palmer@sifive.com>,
        Atish Patra <atish.patra@wdc.com>,
        Loys Ollivier <lollivier@baylibre.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] RISC-V: defconfig: enable clocks, serial console
In-Reply-To: <20190605175042.13719-1-khilman@baylibre.com>
Message-ID: <alpine.DEB.2.21.9999.1906081848410.720@viisi.sifive.com>
References: <20190605175042.13719-1-khilman@baylibre.com>
User-Agent: Alpine 2.21.9999 (DEB 301 2018-08-15)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 5 Jun 2019, Kevin Hilman wrote:

> Enable PRCI clock driver and serial console by default, so the default
> upstream defconfig is bootable to a serial console.
> 
> Signed-off-by: Kevin Hilman <khilman@baylibre.com>

Thanks, queued for v5.2-rc with Christoph's Reviewed-by:.


- Paul

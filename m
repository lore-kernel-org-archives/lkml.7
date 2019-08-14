Return-Path: <SRS0=cDsG=WK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8B972C433FF
	for <linux-kernel@archiver.kernel.org>; Wed, 14 Aug 2019 02:24:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 55FF62085A
	for <linux-kernel@archiver.kernel.org>; Wed, 14 Aug 2019 02:24:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="aUTYvZKE"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730161AbfHNCYe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 13 Aug 2019 22:24:34 -0400
Received: from mail-ot1-f67.google.com ([209.85.210.67]:39622 "EHLO
        mail-ot1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730139AbfHNCYb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Aug 2019 22:24:31 -0400
Received: by mail-ot1-f67.google.com with SMTP id b1so10764123otp.6
        for <linux-kernel@vger.kernel.org>; Tue, 13 Aug 2019 19:24:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google;
        h=date:from:to:cc:subject:in-reply-to:message-id:references
         :user-agent:mime-version;
        bh=djwbOoU5ileobHGHzugslDxkoFaMGMiR2MOTUznWvvE=;
        b=aUTYvZKENV7jx2SUF1Rt71AnU/eAfEOkOw82G9L2RA4jgcGrfvsbDozKAy/0Jd7xzj
         dEZxsN1WCqx+vRxpE+2VZIaqHXxgGM5SLtGhQuB5JOJH7Was1RG0JSZPOdWVRH17vJD2
         dLbkqTIpgKpxrzt66K9NiV9wke8kgqU+WNqLwmY0uSzAoZ4hWXbAQ1/JcyQuQltNiudT
         cyh2KV2Q8y2+x1/+ytCHsMqZ5V79Njok7qu20FaXuZBg3e0SSQXi+Cu3Kj0Bt/XuAY6n
         aVa9W6MzOIQuxeTLAO8rfrpJRidlychF7eKk1l6HDENnpfX0EUMfkwik3TNXY4v+tciy
         a7Vw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:in-reply-to:message-id
         :references:user-agent:mime-version;
        bh=djwbOoU5ileobHGHzugslDxkoFaMGMiR2MOTUznWvvE=;
        b=HrPqve3Ib3ZM5MhmC/UpLfhHC+kDcMB0IGKMhWlNvq19LIzN5sbKerlrMl/m7+bTiv
         9FKigqhE+TfnP0FSn9QsA/aNM2T9N2ChHVbfuUA4wteubJTlREhDMzw76/1nGcrPZgB7
         Hu0ylRUC9FoVX+y91OB7Ga6gILNNJ8iK3UADwKE2NWG1hRnb8RlchVdm1sUfmfC+dZgv
         PNLXbUko4RqXQrZcy+Xju1DNrOlAWko+JxIs2Fg4k+aKJtrd+h/KlARj1eFQfKXBcowP
         kvoPWXdI3+1cKVCmIB46syeyDCVEQxAjKNUSem29+kKkf5xyOFhl3DlIcpr2v0dOLN0Q
         Gndw==
X-Gm-Message-State: APjAAAUVhus/QqzN/uLkl1wojvlIbpD+H+Jsb+3OKvTHPz9iBdRNz5b0
        P9CR5+ownRpIpZcipcLXBjQEgw==
X-Google-Smtp-Source: APXvYqx+xLwy91cVwpgk6Jxu4j6BEJ3bP1Um+itheAYr7zgJCtQf5lOwrktHCYRgtlFyKi9r/5/W+g==
X-Received: by 2002:a5d:9453:: with SMTP id x19mr2569033ior.183.1565749470857;
        Tue, 13 Aug 2019 19:24:30 -0700 (PDT)
Received: from localhost (c-73-95-159-87.hsd1.co.comcast.net. [73.95.159.87])
        by smtp.gmail.com with ESMTPSA id a8sm79125353ioh.29.2019.08.13.19.24.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Aug 2019 19:24:30 -0700 (PDT)
Date:   Tue, 13 Aug 2019 19:24:30 -0700 (PDT)
From:   Paul Walmsley <paul.walmsley@sifive.com>
X-X-Sender: paulw@viisi.sifive.com
To:     Alistair Francis <alistair.francis@wdc.com>
cc:     linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org,
        alistair23@gmail.com
Subject: Re: [PATCH 2/2] riscv: defconfig: Update the defconfig
In-Reply-To: <20190813233230.21804-2-alistair.francis@wdc.com>
Message-ID: <alpine.DEB.2.21.9999.1908131924210.19217@viisi.sifive.com>
References: <20190813233230.21804-1-alistair.francis@wdc.com> <20190813233230.21804-2-alistair.francis@wdc.com>
User-Agent: Alpine 2.21.9999 (DEB 301 2018-08-15)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 13 Aug 2019, Alistair Francis wrote:

> Update the defconfig:
>  - Add CONFIG_HW_RANDOM=y and CONFIG_HW_RANDOM_VIRTIO=y to enable
>    VirtIORNG when running on QEMU
> 
> Signed-off-by: Alistair Francis <alistair.francis@wdc.com>

Thanks, queued for v5.3-rc.


- Paul

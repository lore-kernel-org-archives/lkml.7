Return-Path: <SRS0=z8wE=YA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AB6C0ECE58C
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Oct 2019 15:58:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 79D3020684
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Oct 2019 15:58:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=netronome-com.20150623.gappssmtp.com header.i=@netronome-com.20150623.gappssmtp.com header.b="L2UEzrQN"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728581AbfJGP6h (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 7 Oct 2019 11:58:37 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:39520 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727791AbfJGP6f (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Oct 2019 11:58:35 -0400
Received: by mail-pg1-f196.google.com with SMTP id e1so8474984pgj.6
        for <linux-kernel@vger.kernel.org>; Mon, 07 Oct 2019 08:58:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=netronome-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:in-reply-to:references
         :organization:mime-version:content-transfer-encoding;
        bh=Q7rtzjnFJDzgl/cFLK/ImgYohSqUsKxMtww2iZ3LFxI=;
        b=L2UEzrQNyW4qR/63zw8zkgy4pyfPvUqJc191PUYuwqqFBzcRgHsTNjOtcz6sShZIPb
         dA/SN5iqkK380QeTr1TMQyMEyXWItFVoOPj0BTJNHvHvuYLm8lwTdbOSUuFCTyIH59hE
         pzW6qE93mQZcysE7SxfrOnzobpeM0RpPQZ9ky1GwjbHD6Kd1PNsjg2bdQ46qNOywYScA
         hRSrZvH5pu1GKgAXwZ2wpS+5O5gmxXTtnvm6JIiCE+/vjMomuawzyr7sRW5LQh9nYmYF
         2X+6u2WLm9hpqjydnIc+4dnn/LIoudKifm2BFrmEQJ8LHa46ej0iFH/IjS8BvBCylDv5
         4zkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:in-reply-to
         :references:organization:mime-version:content-transfer-encoding;
        bh=Q7rtzjnFJDzgl/cFLK/ImgYohSqUsKxMtww2iZ3LFxI=;
        b=QMIF0tbz6XFWavEQDauBk0lnMSveSZmNv49OPyGsJQ0a3OcQQujR0Q94/op0nkoHr4
         r2wglDI/k8eaa1ScWaIQ+2UklwBzLf7OjTaRIg7lhpYP6MVXZy9e2B2q9iXt5sbVgGyZ
         xmcKKMWE5t2VfgtInkLD696Qo1yS/Mc8hIEu3dKZQboTCHwk7NWrUMHf91Xls/KA6P80
         TxI9EsTRmagTBXymhW5XR2NRHPo64NwFg6ynoY66/uWHHTdWkUHoiQ18OQ1drSys/4Vl
         itUlVxDEl3Ukte7ZrotHoBtdLQymOVm8je637nC5Dpyz+BZtyB4ig4dnSjMITW7Gifj1
         uXag==
X-Gm-Message-State: APjAAAXF71TPECk+o5/mNvPBdr7MdAbG5vh0r9t7OPV2hGxT9G4k+Im4
        1gw0YIe0OWQAqzVNgUDAITgP7w==
X-Google-Smtp-Source: APXvYqyhi32l/kmuUlMffnp2RlvNzUjYV7K3wiMTR7LXwgMxFjOP7LmfHSTRyJu+7lqWRtUm/ypu7w==
X-Received: by 2002:a63:f915:: with SMTP id h21mr31135096pgi.269.1570463914153;
        Mon, 07 Oct 2019 08:58:34 -0700 (PDT)
Received: from cakuba.netronome.com (c-73-202-202-92.hsd1.ca.comcast.net. [73.202.202.92])
        by smtp.gmail.com with ESMTPSA id y2sm17266224pfe.126.2019.10.07.08.58.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Oct 2019 08:58:33 -0700 (PDT)
Date:   Mon, 7 Oct 2019 08:58:24 -0700
From:   Jakub Kicinski <jakub.kicinski@netronome.com>
To:     Colin King <colin.king@canonical.com>
Cc:     "David S . Miller" <davem@davemloft.net>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Martin KaFai Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
        netdev@vger.kernel.org, bpf@vger.kernel.org,
        oss-drivers@netronome.com, kernel-janitors@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] nfp: bpf: make array exp_mask static, makes object
 smaller
Message-ID: <20191007085824.64c89788@cakuba.netronome.com>
In-Reply-To: <20191007115239.1742-1-colin.king@canonical.com>
References: <20191007115239.1742-1-colin.king@canonical.com>
Organization: Netronome Systems, Ltd.
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon,  7 Oct 2019 12:52:39 +0100, Colin King wrote:
> From: Colin Ian King <colin.king@canonical.com>
> 
> Don't populate the array exp_mask on the stack but instead make it
> static. Makes the object code smaller by 224 bytes.
> 
> Before:
>    text	   data	    bss	    dec	    hex	filename
>   77832	   2290	      0	  80122	  138fa	ethernet/netronome/nfp/bpf/jit.o
> 
> After:
>    text	   data	    bss	    dec	    hex	filename
>   77544	   2354	      0	  79898	  1381a	ethernet/netronome/nfp/bpf/jit.o
> 
> (gcc version 9.2.1, amd64)
> 
> Signed-off-by: Colin Ian King <colin.king@canonical.com>

Acked-by: Jakub Kicinski <jakub.kicinski@netronome.com>

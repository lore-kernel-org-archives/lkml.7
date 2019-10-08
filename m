Return-Path: <SRS0=XKeO=YB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9200EC4360C
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Oct 2019 19:13:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 684B321871
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Oct 2019 19:13:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=netronome-com.20150623.gappssmtp.com header.i=@netronome-com.20150623.gappssmtp.com header.b="LOXRHIcZ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729876AbfJHTNX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 8 Oct 2019 15:13:23 -0400
Received: from mail-qt1-f196.google.com ([209.85.160.196]:33644 "EHLO
        mail-qt1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727220AbfJHTNW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Oct 2019 15:13:22 -0400
Received: by mail-qt1-f196.google.com with SMTP id r5so26974242qtd.0
        for <linux-kernel@vger.kernel.org>; Tue, 08 Oct 2019 12:13:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=netronome-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:in-reply-to:references
         :organization:mime-version:content-transfer-encoding;
        bh=B9rf+VBuWjx1PPlnlyQtG5L/QPp7gUPZolyg4GuyibI=;
        b=LOXRHIcZeA6ePEYLSqol3MkRA+IsiTAYOlNbx58hWKKoEQD9iUJEttMhPRV+DkYrJk
         8fNZOXJxUvymRqrDYBLAcZbRqKDzhPncxFmN29JojvA/J7CKicUtq8537UO3cgclRY+7
         XYZfdLow19wUcwG1UarnuVql5wgbRYO9i5uie8nERCIJ7gsXrfHe/fmQHyCgrCy0Kha2
         yu3GCGW7hn81vC8O7h/hyLo17hevn6ehYVjhqi2Lk1FfMSTjX8OMw1D+Gc64RNuIMnm1
         AaZW9UqaFoah6rkyRNMS1x7tt720Z5ImScaUBTCKvS9TShc88MvcmcnQ1tq9U3GWLkxw
         UPAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:in-reply-to
         :references:organization:mime-version:content-transfer-encoding;
        bh=B9rf+VBuWjx1PPlnlyQtG5L/QPp7gUPZolyg4GuyibI=;
        b=szzuF4OoviTw3Ra/hdlRP243hyumcw8+WHqeInA4NMUSnC2KhUyMA9KqrW/FZTwUBV
         Fhtik1IFJ8DIMelBf4dyRb2Qg46u9m0Zuzafi/ncP01wdKcTio8P+0v9+M1MCHdXnuYL
         c8oJUp5SXWKdhccZtSYaVnE/s6UGnOBYAeKow4oAntbB9fmEXa/x50cqws1D8eV2ygzO
         TI280aIDA0hkSkMZ5H1Zgoz6L22VOxa3SWobBJHS91NfRsYFh+mX2JAXzUQIv7pWq+Ns
         eXfON5I6HVmoZEQWT1CBP6yarhb1AeGBP3wC4lwbAYyHw/4t3VAP4TZPw+1P4iUeWT5T
         5Nww==
X-Gm-Message-State: APjAAAXHCalale+cenT2L2MjvCHBguEVd9OnIkn8kyuoDEx8BE4h3dxs
        gBdYNB5zGGvh0j0mKvt/38nNmw==
X-Google-Smtp-Source: APXvYqxZYBoQmp2JX9+sjZaGwUNjG/XJ53dm/PlE8/teJVUjUIwQMnfn776A15fICR/1WALAiztJwQ==
X-Received: by 2002:a05:6214:2e4:: with SMTP id h4mr35227322qvu.127.1570561999863;
        Tue, 08 Oct 2019 12:13:19 -0700 (PDT)
Received: from cakuba.netronome.com ([66.60.152.14])
        by smtp.gmail.com with ESMTPSA id z46sm12187717qth.62.2019.10.08.12.13.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Oct 2019 12:13:19 -0700 (PDT)
Date:   Tue, 8 Oct 2019 12:13:08 -0700
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
Message-ID: <20191008121308.121c2748@cakuba.netronome.com>
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

Applied to net-next, thanks.

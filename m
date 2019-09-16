Return-Path: <SRS0=w+Kb=XL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 776DBC49ED7
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Sep 2019 10:21:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3D7D8206C2
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Sep 2019 10:21:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="lU3fehKz"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730055AbfIPKVJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 16 Sep 2019 06:21:09 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:33256 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725853AbfIPKVJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Sep 2019 06:21:09 -0400
Received: by mail-wm1-f66.google.com with SMTP id r17so6982006wme.0
        for <linux-kernel@vger.kernel.org>; Mon, 16 Sep 2019 03:21:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google;
        h=date:from:to:cc:subject:in-reply-to:message-id:references
         :user-agent:mime-version;
        bh=s8jNMO99LalgIB0MNN5n8ucLI6Yy712UQYizzmnW3WM=;
        b=lU3fehKz5Rq4X9MmWZdW0i8qsX0bulnAdihulOyBBydleMItW3OD2SAcjI594gFSyn
         mlkqBfaGmUHStfoK/330byFtNFjOBKYek4XrcO7r7O2rHY9ayeFhesnGctcLaa0jj0Yy
         PQWoHRAcxSWd+qu1T/odVdmLosyOzTPOQQ6CS0Pe2zJDSTHBp2oIhdv+us1lQIyC3h8n
         tpWXIioy84lYoFWX/kfil+rO6lq3d1Hc8dbM+BSEN3y6vd4yEAb3Hx/sKS4GL8WxqrUU
         Kdvt9vfjfAE0eO1nsh8eHNO6zqQOzK/9CuG0kmqDMpJoY5TihNO2jSPhc5DlDsCRNWhi
         hxmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:in-reply-to:message-id
         :references:user-agent:mime-version;
        bh=s8jNMO99LalgIB0MNN5n8ucLI6Yy712UQYizzmnW3WM=;
        b=HdmjRGqEmnJXBWqs2BwM0BaRsAiS4HFAzEoJ6JRoEFI+1gB4eIRdX3+vyEZJmJXmfF
         EZmJ/r/PCGHS9wg/0umTNbJMU/oKf1yIXyynYIt1FPVZOq/g8pfowzfs/ucnkx1p3RL9
         MeShB4oDktAFBUGnWVWV3nD37ukg8rbz+dkn7f7b5EyF6co8rhKPCM5kSQtEySVbNi7L
         tUjG7RA34C2ZZp32ocHOk4PdPWypXXF716firS6d3WPXONdzv3H4Fd1vwHknoKSTPm38
         pk+SExoxU2u+2v6y3hlsjH3FcPFAyRRcAMK302ap6KDAZs3QK53HpYwxL22UgaxtzcOI
         NGvw==
X-Gm-Message-State: APjAAAU/YTdeFfSNNxd4lFhWtlx9imhgnl+m7D2uQ6DU6Y71b2r2Va1r
        GXJoC6rnamewYZ1VO6FyYU5x1g==
X-Google-Smtp-Source: APXvYqzsTu55mbfMPQKaK1c0o/x2N47IuQtcU2zQuc6VY5VF1h0PhASxZpXnGQ9FqoBFF5/LJP04VQ==
X-Received: by 2002:a7b:c8c3:: with SMTP id f3mr13024512wml.157.1568629267100;
        Mon, 16 Sep 2019 03:21:07 -0700 (PDT)
Received: from localhost ([195.200.173.126])
        by smtp.gmail.com with ESMTPSA id a7sm43545756wra.43.2019.09.16.03.21.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Sep 2019 03:21:06 -0700 (PDT)
Date:   Mon, 16 Sep 2019 03:21:05 -0700 (PDT)
From:   Paul Walmsley <paul.walmsley@sifive.com>
X-X-Sender: paulw@viisi.sifive.com
To:     Christoph Hellwig <hch@lst.de>
cc:     gregkh@linuxfoundation.org, jslaby@suse.com,
        linux-serial@vger.kernel.org, linux-riscv@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] serial/sifive: select SERIAL_EARLYCON
In-Reply-To: <20190910055923.28384-1-hch@lst.de>
Message-ID: <alpine.DEB.2.21.9999.1909160320540.9917@viisi.sifive.com>
References: <20190910055923.28384-1-hch@lst.de>
User-Agent: Alpine 2.21.9999 (DEB 301 2018-08-15)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 10 Sep 2019, Christoph Hellwig wrote:

> The sifive serial driver implements earlycon support, but unless
> another driver is built in that supports earlycon support it won't
> be usable.  Explicitly select SERIAL_EARLYCON instead.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>

Reviewed-by: Paul Walmsley <paul.walmsley@sifive.com>

- Paul

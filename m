Return-Path: <SRS0=Ecng=WJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1E4D8C433FF
	for <linux-kernel@archiver.kernel.org>; Tue, 13 Aug 2019 16:36:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D5AF820679
	for <linux-kernel@archiver.kernel.org>; Tue, 13 Aug 2019 16:36:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="YLDa8zTc"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727857AbfHMQgZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 13 Aug 2019 12:36:25 -0400
Received: from mail-ot1-f65.google.com ([209.85.210.65]:42441 "EHLO
        mail-ot1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726705AbfHMQgZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Aug 2019 12:36:25 -0400
Received: by mail-ot1-f65.google.com with SMTP id j7so30137116ota.9
        for <linux-kernel@vger.kernel.org>; Tue, 13 Aug 2019 09:36:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google;
        h=date:from:to:cc:subject:in-reply-to:message-id:references
         :user-agent:mime-version;
        bh=nzIFZxpgTOrHzoDpd2G5FzNkubzvfPIuc6yEw8G7BmA=;
        b=YLDa8zTc0lMabSPfPnPyZ0Uq3MXBxFfVq3W0rnm9CWqtCfiW2j5ZXTMa0hhx0f5dG0
         tAbA1PReKM1FoAwACpzQNOm2MnAlGkElqIJ4E7j3s3GZoHCRdB6UDaOGqWKDoOzY3WHU
         FFKgiCFgMGfnCknHZNdOSo+bj0cIf5Vwr/YJxETPJiWpNlLp5obpYsLBLa5Wh71KPbbo
         0oONwPtr9V+Bs8gwwgDDMcW/ldmn9u3oHXPVYNt/kW29GR+pyxB5tVdOHWEXQNfeOv4f
         rskKnNXrn4ioZCqNTmSxy+vgzx66hSF67J996hy0YurGPzbUiDhwHvHuZWZ9n4JruGNG
         PkWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:in-reply-to:message-id
         :references:user-agent:mime-version;
        bh=nzIFZxpgTOrHzoDpd2G5FzNkubzvfPIuc6yEw8G7BmA=;
        b=OoT9ASPp7D/P/5WuE6HHxPZNisfKwR9JZEA9on+so5swTHAuw+zMFS3eYdx+eyaAZm
         MJJvONpEpNuBrdRNKIjIDMyHKJD0ePmft7Nu1hKsvzBthm5gKNiqzfNFbG/+MAmFrkjb
         FFLMvpPw+dmgkimx1CatbeVfZGHDXTiOpuNd/1cc8wdi0+0UDkHtpWE3f6BftAZfqknM
         kGe1xQ7XkD6tnHNyGegDbP7INVfiJdDG7H3bD1YTaM/ziczGJVqNm13pEBpnDYPBwi+t
         yXp9PO31j4c3XD8P5aQMKxVaU3zne66RD1++Cxsiad3F0uCsEv68klj+ICHuRRS7dytR
         CKmQ==
X-Gm-Message-State: APjAAAW4S5SJFFOZx0FKW07nYL5pDMDTLpUZEEnfx8ut9thiVgN3Sbyw
        URGCzbVPX3eTEFj/2XdpFVJIkA==
X-Google-Smtp-Source: APXvYqxWTCKcmwyOePhsYHxNukukVZ+TAhWXA9SlNdoFNlMhOQDzB0lG1yr09iXM57H+HscejKx/TA==
X-Received: by 2002:a5e:8e08:: with SMTP id a8mr7840104ion.94.1565714184761;
        Tue, 13 Aug 2019 09:36:24 -0700 (PDT)
Received: from localhost (c-73-95-159-87.hsd1.co.comcast.net. [73.95.159.87])
        by smtp.gmail.com with ESMTPSA id p12sm2479550ioh.72.2019.08.13.09.36.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Aug 2019 09:36:24 -0700 (PDT)
Date:   Tue, 13 Aug 2019 09:36:23 -0700 (PDT)
From:   Paul Walmsley <paul.walmsley@sifive.com>
X-X-Sender: paulw@viisi.sifive.com
To:     Christoph Hellwig <hch@lst.de>
cc:     Palmer Dabbelt <palmer@sifive.com>,
        Damien Le Moal <damien.lemoal@wdc.com>,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        Atish Patra <atish.patra@wdc.com>
Subject: Re: [PATCH 02/15] riscv: use CSR_SATP instead of the legacy sptbr
 name in switch_mm
In-Reply-To: <20190813154747.24256-3-hch@lst.de>
Message-ID: <alpine.DEB.2.21.9999.1908130935310.30024@viisi.sifive.com>
References: <20190813154747.24256-1-hch@lst.de> <20190813154747.24256-3-hch@lst.de>
User-Agent: Alpine 2.21.9999 (DEB 301 2018-08-15)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 13 Aug 2019, Christoph Hellwig wrote:

> Switch to our own constant for the satp register instead of using
> the old name from a legacy version of the privileged spec.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> Reviewed-by: Atish Patra <atish.patra@wdc.com>

Didn't you want us to replace this with Bin Meng's patch?

https://lore.kernel.org/linux-riscv/20190807151316.GB16432@infradead.org/

If so, probably best just to drop this one and state a dependency.


- Paul

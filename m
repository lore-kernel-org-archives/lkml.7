Return-Path: <SRS0=RWM+=ZG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 83F0AC432C3
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Nov 2019 07:30:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 593AC206E1
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Nov 2019 07:30:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="lv1yhYsv"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726682AbfKNHaK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Nov 2019 02:30:10 -0500
Received: from mail-oi1-f195.google.com ([209.85.167.195]:38980 "EHLO
        mail-oi1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725920AbfKNHaJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Nov 2019 02:30:09 -0500
Received: by mail-oi1-f195.google.com with SMTP id v138so4393359oif.6
        for <linux-kernel@vger.kernel.org>; Wed, 13 Nov 2019 23:30:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google;
        h=date:from:to:cc:subject:in-reply-to:message-id:references
         :user-agent:mime-version;
        bh=HIIuvkQenEP+WcnaiKlQlzfXKrHJDN5EaxUKaCsjEHY=;
        b=lv1yhYsvhI7zDkXS4eyf8jAZxKkKjow1QVM8r5wlHCxqgOnKJExYLxrVoxOYWyI54q
         VTDpF7C7KbIRF3SZa1+PT7TEvbphDLDpYO6Gcyu3u+HbURk+p0ekm28YgrXv8zQc2VVZ
         F2aBdXBY5K5zUKl4H4tGZuwBWhOhvfg19ezgaGAnqY2Ibp6666E2Iv9WSKPCg0ODjsfS
         Jt+ylVXzf0/wAMZml1NSdLbwXqbaTLV15gUNpSyJDM2tm1yRdAfX93zOBemdxlqViI2e
         Ju7uKdaOB8PQW49Z57dCegMVqWpzuEZod85kiwhHjEvf++m3xUms+OJxvoZCQuYbIXib
         nlXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:in-reply-to:message-id
         :references:user-agent:mime-version;
        bh=HIIuvkQenEP+WcnaiKlQlzfXKrHJDN5EaxUKaCsjEHY=;
        b=XOZFOp5DfGnyh+RsMWaLZMnE9ZdmF/n98tAzaCfrZNO2NjshGtqag7r/+OthQCRWGV
         TKga3iqk+8/eW/NldajKn7htDUG9RQWN9KtbUCjWjtXyJQnDioIq2/NgN5fa5fZ2X4k0
         gahjXvWHeFawO6w5jSRXrnRJAXzRy3stbZx02DCITyeJtF2eMqtsMcnerBwUDG8Cw/Q9
         37tvBnpvVuBcPZOw9bV6EVAdad8qjvW70q7nU1ncXm8npaHzdj8ysVvtg+dhe5Kqe1K2
         yERW2kUdT6O0kxOgziMx/I/uOixE6Fbvgrle1/lZhuVYhjiuyvyYGjs7nRLDGNcNI+l8
         Z56Q==
X-Gm-Message-State: APjAAAVLmhw2Epocq6mv01lcnF61lweETW+aDeVeoquwqCXEMhUi1rYI
        NEpb8k1wNGB4tYrOQRScYe7gEETudwo=
X-Google-Smtp-Source: APXvYqyjtdR7f9RE76oYylDsDA0DXihv5z14pSKtKEBOB37FaL6mRyPyvWd3E+p0l1Sbjjeru4WjIg==
X-Received: by 2002:aca:4c14:: with SMTP id z20mr2460753oia.76.1573716608800;
        Wed, 13 Nov 2019 23:30:08 -0800 (PST)
Received: from localhost (wsip-98-172-187-222.no.no.cox.net. [98.172.187.222])
        by smtp.gmail.com with ESMTPSA id m11sm1556274otp.15.2019.11.13.23.30.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Nov 2019 23:30:08 -0800 (PST)
Date:   Wed, 13 Nov 2019 23:30:07 -0800 (PST)
From:   Paul Walmsley <paul.walmsley@sifive.com>
X-X-Sender: paulw@viisi.sifive.com
To:     Christoph Hellwig <hch@lst.de>
cc:     Palmer Dabbelt <palmer@sifive.com>,
        Damien Le Moal <damien.lemoal@wdc.com>,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 01/12] riscv: abstract out CSR names for supervisor vs
 machine mode
In-Reply-To: <20191028121043.22934-2-hch@lst.de>
Message-ID: <alpine.DEB.2.21.9999.1911132328220.11342@viisi.sifive.com>
References: <20191028121043.22934-1-hch@lst.de> <20191028121043.22934-2-hch@lst.de>
User-Agent: Alpine 2.21.9999 (DEB 301 2018-08-15)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 28 Oct 2019, Christoph Hellwig wrote:

> Many of the privileged CSRs exist in a supervisor and machine version
> that are used very similarly.  Provide versions of the CSR names and
> fields that map to either the S-mode or M-mode variant depending on
> a new CONFIG_RISCV_M_MODE kconfig symbol.
> 
> Contains contributions from Damien Le Moal <Damien.LeMoal@wdc.com>
> and Paul Walmsley <paul.walmsley@sifive.com>.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>

Thanks, queued for v5.5-rc1.


- Paul

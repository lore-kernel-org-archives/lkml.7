Return-Path: <SRS0=E/6H=U3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E5F9EC4321A
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Jun 2019 03:11:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ADBF3206A2
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Jun 2019 03:11:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="JrDwtixM"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726816AbfF1DLB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Jun 2019 23:11:01 -0400
Received: from mail-io1-f66.google.com ([209.85.166.66]:36442 "EHLO
        mail-io1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726542AbfF1DLB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Jun 2019 23:11:01 -0400
Received: by mail-io1-f66.google.com with SMTP id h6so9484927ioh.3
        for <linux-kernel@vger.kernel.org>; Thu, 27 Jun 2019 20:11:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google;
        h=date:from:to:cc:subject:in-reply-to:message-id:references
         :user-agent:mime-version;
        bh=3an8xkdD/hzVPbbvgTnxXA33dOKRmSHUjpIJuQZqGvA=;
        b=JrDwtixMw/3IlOWIM41ySM9lxTxda7b5hi8+7ZSQSKlOM0qEsMmefPmS6lnIukM792
         rJLcpnxJPLBtyHdBTKEU95fMJyoTW6j4QVsPsrKb9+NdQdGHv53Y6VhcjdkHaMtGrfL3
         lB6U7omhyz445enMU2nMTV10DZ1ybovtuMYUlxBYFgoEZ3eDbK197yh16Yke5NZaRysG
         cJi/9IhaybCnP4SVuDjSeNurFbQS1LOiIB8jSb0swifI1V2dCqmBMSXPHm2iDX6as/UI
         a+tuuakpmXoGaF5jHPHtk25VaOpP9wD9bbaDBXRo258SCCQMvPo5Qn2d7huyxS0vY9Ri
         /7HQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:in-reply-to:message-id
         :references:user-agent:mime-version;
        bh=3an8xkdD/hzVPbbvgTnxXA33dOKRmSHUjpIJuQZqGvA=;
        b=OMPkd5zl5TUvIuvbEPK150gmA4TiTKwr1H0hOOesRn3nX5ieKNpd3bXMcn1kxBoOcH
         ry8wVUcCJqKBnfOU/O3AdsCerSP2nGujjqNacoVoCwHkG9KzXPbVrJe6sV4wyYOPGXwv
         tDLtpp8tawoOQ19Lm89jbw9f1objzK5lWfFB+r7scnOPafV8AI8Fmtv+YY9rz1COORPg
         Oz/nvLJhAMHBTbRRk4CRO+8VsYWc/a0lX8Xxi7twMt2pWr68FLCfLz2XKqC84njEy6SG
         BMxjfLzstjuM6QhO33nCTIHFuxePcBKPKtz6A/Hrx15P/jNqeiDgdMcCdZL3yOPjDPk1
         qh2w==
X-Gm-Message-State: APjAAAVMlIYy3eiRCzYEl2qXnmPUYrYYpwC6HuAkcXiQsUpi7+EdBGUs
        72EfYOEUiaGaACdxX7TP0t4G+bEC47c=
X-Google-Smtp-Source: APXvYqzzedYsmPMz6paqYM6clmX/4PiLCsiEE/jsoyj1Qo/J8MkgXEwQvtF7zSVFKDSYWMZk7TrDDQ==
X-Received: by 2002:a02:9a0f:: with SMTP id b15mr8932363jal.32.1561691460545;
        Thu, 27 Jun 2019 20:11:00 -0700 (PDT)
Received: from localhost (c-73-95-159-87.hsd1.co.comcast.net. [73.95.159.87])
        by smtp.gmail.com with ESMTPSA id a15sm813161ioc.27.2019.06.27.20.10.59
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Thu, 27 Jun 2019 20:11:00 -0700 (PDT)
Date:   Thu, 27 Jun 2019 20:10:59 -0700 (PDT)
From:   Paul Walmsley <paul.walmsley@sifive.com>
X-X-Sender: paulw@viisi.sifive.com
To:     Loys Ollivier <lollivier@baylibre.com>
cc:     Palmer Dabbelt <palmer@sifive.com>,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, Kevin Hilman <khilman@baylibre.com>
Subject: Re: [PATCH 0/3] riscv: add SOC_SIFIVE config for SiFive specific
 resource
In-Reply-To: <1560799790-20287-1-git-send-email-lollivier@baylibre.com>
Message-ID: <alpine.DEB.2.21.9999.1906272006410.3867@viisi.sifive.com>
References: <1560799790-20287-1-git-send-email-lollivier@baylibre.com>
User-Agent: Alpine 2.21.9999 (DEB 301 2018-08-15)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Loys,

On Mon, 17 Jun 2019, Loys Ollivier wrote:

> Following is a patch series that adds a SOC_SIFIVE config.
> The purpose of this config is to group all the code specific to the SiFive
> architecture such as device tree and platform drivers.
> 
> The initial thought/discussion came from [0].
> 
> [0] https://lore.kernel.org/linux-riscv/20190602080500.31700-1-paul.walmsley@sifive.com/

Thanks for giving us a good start here.  Queued for v5.3 with Palmer's 
Reviewed-by:s.


- Paul

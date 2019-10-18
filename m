Return-Path: <SRS0=6OEZ=YL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 45997CA9EA2
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Oct 2019 06:08:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 186F721925
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Oct 2019 06:08:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="FCqTGYJL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405849AbfJRGIW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 18 Oct 2019 02:08:22 -0400
Received: from mail-il1-f193.google.com ([209.85.166.193]:40115 "EHLO
        mail-il1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732869AbfJRGIW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Oct 2019 02:08:22 -0400
Received: by mail-il1-f193.google.com with SMTP id o16so4475462ilq.7
        for <linux-kernel@vger.kernel.org>; Thu, 17 Oct 2019 23:08:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google;
        h=date:from:to:cc:subject:in-reply-to:message-id:references
         :user-agent:mime-version;
        bh=7e+V7TaWRTvEWCyZ3TIBozn+C5eqQAWMSVjzjswVInM=;
        b=FCqTGYJL4pcSf09mUXTCjzzD/tN3GA+pmkhsswPDoSW9RMSfp1NX0HlpWVZVFKaJsO
         yOkJo6TaA8Njus7B3/phczPKLgPYZRo557wLrJb1n9FXSxOkwU8EuxO7aqwU4tyTH/o8
         9dOlTKITXaZxpxg9rjDfI6S86wzzPy/La/9b7g0Yvo8u3ahiXsJul2DBCLR1zF5OekAL
         HLJ/AoD6Zsn62pDmSaL9kV5Ofc0jKiR2gUwHTh3+Z3uBSMh/l4cWDAJ+56JWYTBAC6q+
         Hsj02s7BERuahGOWHyGcT+SayLq5wSAoUD12NIR/1RWM4X7uX3UTUsaRsGqvjbTrlOJp
         X8Qg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:in-reply-to:message-id
         :references:user-agent:mime-version;
        bh=7e+V7TaWRTvEWCyZ3TIBozn+C5eqQAWMSVjzjswVInM=;
        b=T8fF+F7kv8LrAez2BQeMkcJ4hdVCwAo73xPgRP924Sk9S8zwogmO6BSFFCFpmdYsH3
         vUSr/GfLm5/mPr+reMODWxpmnvZw2htBSDc05twLCAPJzmnmgP3uPR0e2eJmtmZ8X10L
         FWlbDkC9t+sksllM6h22MDMBj//xY8O02uO+e+q+FefsLCDHeIpmEhDIfG6XfDqG4OR+
         B9MfP+/xS0/r4Qi1AgImkG7ICY95BwIV2SEvczrJZujhh2iOAxTPajyIq3i+l3NkM2hn
         hfrjpOn/gYd/EQT0JYraIAUq9d0/j52cOWz6qfB5U0NmTz+vdRmMG2J3JBoliHgDsEKL
         zh6g==
X-Gm-Message-State: APjAAAVjF4KRWm1i0OgwAmBuTRegisT9ZlfyafIZtkLJs1/oFROdwyy4
        tzFcrTlT+/211TkffxpnDbvsrQ==
X-Google-Smtp-Source: APXvYqy6cRVxQ8WFikS9agdaOHvo061IYTxDdIlT0KRlw+j2DvEynitlghuOY1kiVGqMrBOfmsWx7g==
X-Received: by 2002:a92:7982:: with SMTP id u124mr8515068ilc.161.1571378901624;
        Thu, 17 Oct 2019 23:08:21 -0700 (PDT)
Received: from localhost ([64.62.168.194])
        by smtp.gmail.com with ESMTPSA id t24sm1478227ioi.44.2019.10.17.23.08.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Oct 2019 23:08:21 -0700 (PDT)
Date:   Thu, 17 Oct 2019 23:08:19 -0700 (PDT)
From:   Paul Walmsley <paul.walmsley@sifive.com>
X-X-Sender: paulw@viisi.sifive.com
To:     Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
cc:     linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/8] riscv: init: merge split string literals in preprocessor
 directive
In-Reply-To: <20191018054701.sjueyb3agoaopnla@ltop.local>
Message-ID: <alpine.DEB.2.21.9999.1910172307260.7801@viisi.sifive.com>
References: <20191018004929.3445-1-paul.walmsley@sifive.com> <20191018004929.3445-4-paul.walmsley@sifive.com> <20191018040237.3eyrfrty72r63pkz@ltop.local> <alpine.DEB.2.21.9999.1910172127220.3026@viisi.sifive.com>
 <20191018054701.sjueyb3agoaopnla@ltop.local>
User-Agent: Alpine 2.21.9999 (DEB 301 2018-08-15)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 18 Oct 2019, Luc Van Oostenryck wrote:

> I quickly checked and gcc also complain about the second line:
> 	$ cat y.c 
> #ifndef __riscv_cmodel_medany
> #error "setup_vm() is called from head.S before relocate so it should "
>        "not use absolute addressing."
> #endif
> 
> 	$ gcc -c y.c
> y.c:2:2: error: #error "setup_vm() is called from head.S before relocate so it should "
>  #error "setup_vm() is called from head.S before relocate so it should "
>   ^~~~~
> y.c:3:8: error: expected identifier or '(' before string constant
>         "not use absolute addressing."
>         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> 
> So it seems that gcc doesn't join these lines.

I guess that's what I get for assuming that the original code was tested.  
Thanks for doing that, and sorry for the noise.

> Fell free to add my:
> Reviewed-by: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>

Done.


- Paul

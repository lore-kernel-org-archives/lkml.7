Return-Path: <SRS0=BZT9=SS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5B686C10F14
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Apr 2019 22:17:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1D4FB20880
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Apr 2019 22:17:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="vdd7jRD6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730545AbfDPWRz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Apr 2019 18:17:55 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:33556 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726287AbfDPWRz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Apr 2019 18:17:55 -0400
Received: by mail-pg1-f193.google.com with SMTP id k19so11019104pgh.0;
        Tue, 16 Apr 2019 15:17:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=lRkSL0Epqr8Lch/5CD0qs9ndWY/xWxVaA6wLXekyTcU=;
        b=vdd7jRD66rsEy7Fk/4sFDUdbsr4aHn+UcALZ70+sAqpdOxdWeLHHVuq0MgO1PWscG/
         sQFZV0/j/b6hZbD8RMv5RCvTqcHQVTw57eF1Q9osbuSyIzBDRZbXG7i93m7E/J6GQDkv
         iEIf72Z1ZprIGT47DWxTmng8fl0O7Wbgc18VenNf9n5j4stJOZXCtHCzuF21jKaDtZcU
         Vx04URPBYoEO2bFhQas3roIxcthqPqjSknczsjLQGD77TpzabZs3iJ7Vn5ILEvSKTwiq
         exWIlxAjORaBED9qktRgHOXWGTjQKbZedLwkS4BBzGAQbJvM5cMS9VXnxldjcMXGwW0L
         WC4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=lRkSL0Epqr8Lch/5CD0qs9ndWY/xWxVaA6wLXekyTcU=;
        b=MELZAHIzMBTtdgebMu3XMCsTnqFtWOuEd9+0nHsk35kPwEFx22bjXGitsOXU8fKCNe
         gxADr9qBtn7+Miu8rj4+X67yy5403u3Pptttrw9TbxwMNUQdP48qE1Q18hlkaEKux3Tm
         8Xjp1kai1eEzj0pduEeWsrk8J2mtbBclIxlUCp7xdTlVXNdx72YWQMwLxwo6qierASJd
         alzEG3kBSDBGo6t7KzD+koaVwrR+aExBdxaskKD6o1gK/lW+ohrW8Mj5Pl++pnQqg+IR
         Utyq97JEvf8KHr+J7h8A/iKV08pUl8nYUTrwuTAcOcUhKXj/6ugtL5yVT/QtTD4KIfW1
         XWgA==
X-Gm-Message-State: APjAAAVdmTQx+Y5ABO+eh4jnl+zUKx5mDtgOwr0kkmxnpr0GMaMXkEF5
        L84C3nDXP+4j4ptzbMqVaPg=
X-Google-Smtp-Source: APXvYqylZzXtafrenFAnxUZC2bJ8zLMZKTIdoHITEtRCX88DXY/9FkffYBtyPbHwHWLM+E9MWzfMJA==
X-Received: by 2002:a65:6295:: with SMTP id f21mr73426111pgv.129.1555453074836;
        Tue, 16 Apr 2019 15:17:54 -0700 (PDT)
Received: from bharath12345-Inspiron-5559 ([103.110.42.31])
        by smtp.gmail.com with ESMTPSA id b72sm96710078pga.86.2019.04.16.15.17.49
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 16 Apr 2019 15:17:54 -0700 (PDT)
Date:   Wed, 17 Apr 2019 03:47:45 +0530
From:   Bharath Vedartham <linux.bhar@gmail.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
        akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org,
        patches@kernelci.org, ben.hutchings@codethink.co.uk,
        lkft-triage@lists.linaro.org, stable@vger.kernel.org
Subject: Re: [PATCH 4.14 00/69] 4.14.112-stable review
Message-ID: <20190416221745.GC3502@bharath12345-Inspiron-5559>
References: <20190415183726.036654568@linuxfoundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190415183726.036654568@linuxfoundation.org>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Compiled(defconfig) and booted on my x86 machine. No dmesg regressions
observed.

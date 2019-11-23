Return-Path: <SRS0=E2Zf=ZP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AECFFC432C0
	for <linux-kernel@archiver.kernel.org>; Sat, 23 Nov 2019 02:54:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7B9AD2070E
	for <linux-kernel@archiver.kernel.org>; Sat, 23 Nov 2019 02:54:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="OEVUvHct"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726752AbfKWCyc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Nov 2019 21:54:32 -0500
Received: from mail-il1-f194.google.com ([209.85.166.194]:34482 "EHLO
        mail-il1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726089AbfKWCyc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Nov 2019 21:54:32 -0500
Received: by mail-il1-f194.google.com with SMTP id p6so9100783ilp.1
        for <linux-kernel@vger.kernel.org>; Fri, 22 Nov 2019 18:54:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google;
        h=date:from:to:cc:subject:in-reply-to:message-id:references
         :user-agent:mime-version;
        bh=MC3L3+g4fE2SdGIULrCY9R6WE7khneKCXnJPq/KxUlA=;
        b=OEVUvHctm96oZYkLh8AQ27k4G5vrhpBaWHWF+5bZqFtSHED9KWOBdQFIu1qH4rS05d
         5SHmCtE7+IrSy8tUpHyOLsRmS0jPFmDpl3B/d/C/WlNPyIs7woMy+LaDchiqBJQe462C
         0V74fLDiKWGF+jmID3rqVCB/osqNhqEkBUGgCvAPGAD16E9KKJgDddhO1l8hl5pfi7bl
         LFwcvfY4SFRhS/DyZSJNOd35wkeJHQXJ9o4yyDINGMTBwif28UypY07J/Vq9gQeAPO4P
         +RBI2Zho7FXyNCnUg9T6aRBsi/ALhmt0PdyDC20RhCB9rIVW+jfFOipnM7gwdBrPjyyI
         aOOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:in-reply-to:message-id
         :references:user-agent:mime-version;
        bh=MC3L3+g4fE2SdGIULrCY9R6WE7khneKCXnJPq/KxUlA=;
        b=NcCbE0lXpLv81b1bHkATFMrvLec88mlZ/jjtBNAbYGX8fp4pliaUCDZZxX5Fi71HnP
         YCjxpx+m82dLwnLbUYIGSQgHkN9yKty9ScgbT1+LsxynTzj2APCiw/dbW5I43f26nDOf
         kLVBkeXJQJg50NQALlBvE4YQSy5dnOIjBCT9UolYNTRAAV1QxhQPSdUXiu+NG3qvQApJ
         r10SvwnxdS9PHV+pf1uRdX1nRhLkOTqxdAi41lcjesYe4+vTpg7vSS2HEDwVzYLvMyMa
         xm0XQQvIK2G4021jtMQv0MlTR4in0qcbwPLm20Hm6bLiXysvOb8VI7yNDv0lFipcUvks
         H2BA==
X-Gm-Message-State: APjAAAWIdQd85mNWki6tW3vt9xZ+wL60E1DaApr9YjOaV5YmFQJQz7cW
        Joz040an/CJ77FlSlFcwcwhDQA==
X-Google-Smtp-Source: APXvYqy3HVaSl20zc1qqbqMRrnhYCX7IWgu8LVF1nBLwGAVHoyxX5ZpUhuQQBFFD6IU9TZmK6AzqpA==
X-Received: by 2002:a02:1d04:: with SMTP id 4mr17858910jaj.48.1574477670042;
        Fri, 22 Nov 2019 18:54:30 -0800 (PST)
Received: from localhost ([64.62.168.194])
        by smtp.gmail.com with ESMTPSA id 25sm2763492ioe.6.2019.11.22.18.54.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 Nov 2019 18:54:29 -0800 (PST)
Date:   Fri, 22 Nov 2019 18:54:28 -0800 (PST)
From:   Paul Walmsley <paul.walmsley@sifive.com>
X-X-Sender: paulw@viisi.sifive.com
To:     Krzysztof Kozlowski <krzk@kernel.org>
cc:     linux-kernel@vger.kernel.org, Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        linux-riscv@lists.infradead.org
Subject: Re: [PATCH v2] riscv: Fix Kconfig indentation
In-Reply-To: <1574306457-6251-1-git-send-email-krzk@kernel.org>
Message-ID: <alpine.DEB.2.21.9999.1911221853330.14532@viisi.sifive.com>
References: <1574306457-6251-1-git-send-email-krzk@kernel.org>
User-Agent: Alpine 2.21.9999 (DEB 301 2018-08-15)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 21 Nov 2019, Krzysztof Kozlowski wrote:

> Adjust indentation from spaces to tab (+optional two spaces) as in
> coding style with command like:
> 	$ sed -e 's/^        /\t/' -i */Kconfig
> 
> Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>

Thanks, queued with Palmer's Reviewed-by: (which I believe would apply 
equally to this version)


- Paul

Return-Path: <SRS0=Ncac=VO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4FFBCC7618F
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Jul 2019 19:30:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 06A8A21743
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Jul 2019 19:30:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="NJcT4ReH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727402AbfGQTaM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Jul 2019 15:30:12 -0400
Received: from mail-io1-f68.google.com ([209.85.166.68]:36543 "EHLO
        mail-io1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726917AbfGQTaM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Jul 2019 15:30:12 -0400
Received: by mail-io1-f68.google.com with SMTP id o9so47668858iom.3
        for <linux-kernel@vger.kernel.org>; Wed, 17 Jul 2019 12:30:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google;
        h=date:from:to:cc:subject:in-reply-to:message-id:references
         :user-agent:mime-version;
        bh=m+aYfYk3qqQFGYyIVUXqsjPB9Z++/CqoIZvcXZFm3io=;
        b=NJcT4ReHcQvNMVZLMGPaZHK9eIDuuQdneBHhUpijosU4l0tZrd8F1G6YEvtqk2ueyi
         ab1b1YjwcBKcTGWxeivJOOfmix6JaiRG0BR9tHga+fndXXM0hr+gs4SyrTWDVjI5fVGO
         gghtcNGqRteT6wrHv4pRZLL+6qVEHLLDHbnV7njAfX4NdhGXmRAI1fqW5JYPRGRWDP0j
         JARewp2Favgi9oXSi9PW9R61lRbyPMIvrMt+NZ+VbLzOVodM/REUULreUB03nEjs+Re5
         8YIfejH0GL6sMcGo0GH4RrAnp7lwelNfWuMTgP/cEASY1Ecqq6iNP9z6EJNJMghFmDzH
         TPsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:in-reply-to:message-id
         :references:user-agent:mime-version;
        bh=m+aYfYk3qqQFGYyIVUXqsjPB9Z++/CqoIZvcXZFm3io=;
        b=X60cnDi7l4JwJKvIJaV688MtSzhLgv3tlhU7bCIcb2KmfB2QDmqfn8IjtCpqpCRqx1
         Gut7MBcrz2k1NIsfl96Kf0AMEHvqZdcg0VrruAN4fXUKSngMyCUpuz9DIRIEPAIHgZbB
         Bhn3k90+jLymmgnBRxD5c0nnVmx/H9H729Xu7kHcv8J5iMhNn1MvX/1HHLfknNgcPr4F
         S+4pDgzf4RJ98IJs2mHcBSs/Brw8QJ31DapoSfO11ZusCmzgAiWDR/7VBi/yQTbEyZOe
         6V5tYcmW7G24XsD+JnNC88mJimMT01RAoscm4DayC3epYM3GGkistAN6BsBTCaTaORVn
         dfWg==
X-Gm-Message-State: APjAAAVw97VyWlm2iQvBfJjr9e7yIh9QB6rULeRVv/GfupMmKwDkwU/I
        iXIjdRaomiNA7Kl/vSqQuAfemQ==
X-Google-Smtp-Source: APXvYqzwcmx1BCDmjWpt1tOLywaYXaCeovXL+ydA1c7dOKNeaGYAADnZWQbu/jN5GlJF+0Dyzy9HYA==
X-Received: by 2002:a02:8816:: with SMTP id r22mr43623986jai.60.1563391811445;
        Wed, 17 Jul 2019 12:30:11 -0700 (PDT)
Received: from localhost (67-0-62-24.albq.qwest.net. [67.0.62.24])
        by smtp.gmail.com with ESMTPSA id l2sm17528673ioh.20.2019.07.17.12.30.10
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Wed, 17 Jul 2019 12:30:10 -0700 (PDT)
Date:   Wed, 17 Jul 2019 12:30:10 -0700 (PDT)
From:   Paul Walmsley <paul.walmsley@sifive.com>
X-X-Sender: paulw@viisi.sifive.com
To:     Yash Shah <yash.shah@sifive.com>
cc:     robh+dt@kernel.org, devicetree@vger.kernel.org,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        mark.rutland@arm.com, palmer@sifive.com, aou@eecs.berkeley.edu,
        sachin.ghadi@sifive.com
Subject: Re: [PATCH] riscv: dts: Add DT node for SiFive FU540 Ethernet
 controller driver
In-Reply-To: <1561097422-25130-2-git-send-email-yash.shah@sifive.com>
Message-ID: <alpine.DEB.2.21.9999.1907171228560.22190@viisi.sifive.com>
References: <1561097422-25130-1-git-send-email-yash.shah@sifive.com> <1561097422-25130-2-git-send-email-yash.shah@sifive.com>
User-Agent: Alpine 2.21.9999 (DEB 301 2018-08-15)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 21 Jun 2019, Yash Shah wrote:

> DT node for SiFive FU540-C000 GEMGXL Ethernet controller driver added
> 
> Signed-off-by: Yash Shah <yash.shah@sifive.com>

Dropping this one until it's updated to align with whatever you pick for 
the new driver DT compatible string, per

https://lore.kernel.org/linux-riscv/1558611952-13295-1-git-send-email-yash.shah@sifive.com/T/#me298e16b2feeb481116cca61b94e014433cf2977

Please send an updated DT patch at your earliest convenience so we can get 
it into the v5.3-rc series.


- Paul

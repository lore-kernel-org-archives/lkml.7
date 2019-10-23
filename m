Return-Path: <SRS0=OaAC=YQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 54782CA9EB9
	for <linux-kernel@archiver.kernel.org>; Wed, 23 Oct 2019 22:05:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 256E22084C
	for <linux-kernel@archiver.kernel.org>; Wed, 23 Oct 2019 22:05:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="CvPPc+ni"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2436671AbfJWWFg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 23 Oct 2019 18:05:36 -0400
Received: from mail-il1-f193.google.com ([209.85.166.193]:35893 "EHLO
        mail-il1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731301AbfJWWFf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Oct 2019 18:05:35 -0400
Received: by mail-il1-f193.google.com with SMTP id s75so10680352ilc.3
        for <linux-kernel@vger.kernel.org>; Wed, 23 Oct 2019 15:05:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google;
        h=date:from:to:cc:subject:in-reply-to:message-id:references
         :user-agent:mime-version;
        bh=6nNENVA+itqkpIQzusrAU/yenbBYQKj6dV7c1bpwXz0=;
        b=CvPPc+ni++8l/tgBZsJga/63Afatp4dAhBpkHiaekonYGAecYw9T+FrpwLyAKbMYvr
         dnuorpGtZ+7lXI5RuZ/15abvyX51iXf9ZgLmu0AFhVW2tdYjzn0uw80DXlANBcSZn1hC
         rqQioWQsnDVncQhMDIYUJDzAuYb4xBdRMOOReiaRWSKOp0dlc3hHV/W3gAwL9GgvLCXN
         Hk0wI8BtHEuhqHHpZWpJ65iR9TJ2uaC2K/atx2qowegeUp0X0o+MG0Mvs2Nyw9N5pfOx
         AxC7H+4jCU2zfM0NvdLkZyK12X8oJ/F536QdB/y/lTrDjJfTk3QeKyXsZkPcY4I91pQe
         jy8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:in-reply-to:message-id
         :references:user-agent:mime-version;
        bh=6nNENVA+itqkpIQzusrAU/yenbBYQKj6dV7c1bpwXz0=;
        b=WUiFUNQNGTIyclWKFmx95GnENhqX802XTC5jQprayQuSFqe4DbTjp+/H4o4jz8ilrX
         l520xHqeVt0bpsndyO1KP8xoi+ZqjoqkeCgZ7hEv8py2wy1++fIFZhm0he7L0N6A9Cs7
         bJv16V8LsNVwei3OQpfYQlvJca07o19CXCNjBth8IYbg4GdlAiAIK8FcHwAT8Irz658P
         gN2Dygxh8X/zl73DbMN76o6sR5M26G0BSi0LaTG4g2/JKkezVWK86iCTizorTJMRvCeD
         RdFUUSRrkj4kuvpvnJcEAEuELVriVNAwPziDBC7mjNT82Qrdf46Fbu5m12HzX9ZAUrZZ
         Gm3g==
X-Gm-Message-State: APjAAAUk0E0MB6GFqdRJPqMc1+YiDvAMnnqDEUuk3EamHcj24GYrfbMx
        Dwu1YELNga91kbyI0pfuyTtuCg==
X-Google-Smtp-Source: APXvYqzCVL6/ED1XfSU6ZwasV1fopkH1VvPNO4zpWZ5VdnWQoKnpy32UtyRduLuAvPAODzzp6WeAug==
X-Received: by 2002:a92:d3c9:: with SMTP id c9mr24486179ilh.259.1571868333002;
        Wed, 23 Oct 2019 15:05:33 -0700 (PDT)
Received: from localhost ([64.62.168.194])
        by smtp.gmail.com with ESMTPSA id j21sm4998581ioj.86.2019.10.23.15.05.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Oct 2019 15:05:32 -0700 (PDT)
Date:   Wed, 23 Oct 2019 15:05:30 -0700 (PDT)
From:   Paul Walmsley <paul.walmsley@sifive.com>
X-X-Sender: paulw@viisi.sifive.com
To:     Christoph Hellwig <hch@lst.de>
cc:     Palmer Dabbelt <palmer@sifive.com>,
        Damien Le Moal <damien.lemoal@wdc.com>,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 02/15] riscv: cleanup do_trap_break
In-Reply-To: <20191017173743.5430-3-hch@lst.de>
Message-ID: <alpine.DEB.2.21.9999.1910231505140.16536@viisi.sifive.com>
References: <20191017173743.5430-1-hch@lst.de> <20191017173743.5430-3-hch@lst.de>
User-Agent: Alpine 2.21.9999 (DEB 301 2018-08-15)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 17 Oct 2019, Christoph Hellwig wrote:

> If we always compile the get_break_insn_length inline function we can
> remove the ifdefs and let dead code elimination take care of the warn
> branch that is now unreadable because the report_bug stub always
> returns BUG_TRAP_TYPE_BUG.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>

Thanks, queued for v5.4-rc.


- Paul

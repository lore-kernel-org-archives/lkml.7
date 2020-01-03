Return-Path: <SRS0=3Pgh=2Y=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 14FA6C2D0C2
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Jan 2020 17:17:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CD57F20866
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Jan 2020 17:17:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jrkSRbCQ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728120AbgACRRi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 3 Jan 2020 12:17:38 -0500
Received: from mail-qv1-f66.google.com ([209.85.219.66]:41332 "EHLO
        mail-qv1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727952AbgACRRi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Jan 2020 12:17:38 -0500
Received: by mail-qv1-f66.google.com with SMTP id x1so16473280qvr.8
        for <linux-kernel@vger.kernel.org>; Fri, 03 Jan 2020 09:17:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=JAQ9XzTinm2DVqzapCNnXi/zMEgMhpMOb4nhGt9yK/0=;
        b=jrkSRbCQZT28oTMBH6aPlyPA5WcHNROE19klYmWmmPFh75cbw2SfrK+8dw9nOe/68W
         q6cCE043+1MyRpDRvfUjKM1NTjoTAUr9eWDM2unobZMCBjlO87cr8I+0WToauYkxGzxf
         /4V+8O8YKB432b6jMoOOl3vtyzigmLv4rK/jZF05B4lLcBguwQdRNhM5T60FEt0E5XLS
         tXVI6diBchn5spzo9Jn1kPiDmo53Yl3M+QfF3tzMGVw86CGJMwu3aEL18fymtecvuaH/
         sX0cTvfCRC3YqGT9kzypOl66TmfC/UAvNMq72v8inx/RXGYDsqUZcgcGRY70OiOMPaE/
         it7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:date:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=JAQ9XzTinm2DVqzapCNnXi/zMEgMhpMOb4nhGt9yK/0=;
        b=RwXt7NT5aFA/VMzzyWrCQPlje/mc5OvMgAH7Nh4oIAUd1TgjbvQ8EX4ALlfMLtqhUG
         TUOf3GCM4scAa+MM3GmTxcCSeqyQwbh/Qc7VoOdJKqns8Xti1s3mJIDgrWCzvxyzfc/E
         BsY07hq8icE+jxsrEDDxSkWnFWNgKcUUQs2hPWS1uFRxlk3JxBPV+BJaKP+rkosEDq2X
         2Ulrh3vmbXOoLDKY8HwZW3WejLf9EbVqwn5qeTEI1WPXCWxOlIQXw1XtxJ0I6AfPh8+C
         RWQ9XCMllWdPYR1BOlTDMPys4yS6msgulgmFMwdxpMI9Fq6SrK/iptJtDeS0jYE0vpJN
         WWCg==
X-Gm-Message-State: APjAAAUpZysSVOT/myf58n3sh1Qc7EDYn6L43C7oLwDvbR1ePaCrd1QM
        VJ4srlsSvst79i+wyqauUZQ/7+0YR5Q=
X-Google-Smtp-Source: APXvYqxBZEqr41xTPmKc44NLKT4LwNjwR1m0ZnAV3dEqJQRB4s5sopAgiKeFR1w7raO5ybdLSb1bGg==
X-Received: by 2002:a05:6214:4f0:: with SMTP id cl16mr69773683qvb.213.1578071857186;
        Fri, 03 Jan 2020 09:17:37 -0800 (PST)
Received: from rani.riverdale.lan ([2001:470:1f07:5f3::b55f])
        by smtp.gmail.com with ESMTPSA id 17sm18999293qtz.85.2020.01.03.09.17.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Jan 2020 09:17:37 -0800 (PST)
From:   Arvind Sankar <nivedita@alum.mit.edu>
X-Google-Original-From: Arvind Sankar <arvind@rani.riverdale.lan>
Date:   Fri, 3 Jan 2020 12:17:35 -0500
To:     Arvind Sankar <nivedita@alum.mit.edu>
Cc:     "David S . Miller" <davem@davemloft.net>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] sparc/console: kill off obsolete declarations
Message-ID: <20200103171735.GB1308999@rani.riverdale.lan>
References: <20191216221004.3476562-1-nivedita@alum.mit.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20191216221004.3476562-1-nivedita@alum.mit.edu>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 16, 2019 at 05:10:04PM -0500, Arvind Sankar wrote:
> commit 09d3f3f0e02c ("sparc: Kill PROM console driver.") missed removing
> the declarations of the deleted prom_con structure and prom_con_init
> function from console.h. Kill them off now.
> 

Hi David, happy new year!

Reminder for the following small cleanup patch.

https://lore.kernel.org/lkml/20191216221004.3476562-1-nivedita@alum.mit.edu/

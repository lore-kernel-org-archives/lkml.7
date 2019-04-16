Return-Path: <SRS0=BZT9=SS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 56541C10F13
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Apr 2019 14:55:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1A7372077C
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Apr 2019 14:55:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="pCz+2X8O"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729683AbfDPOzX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Apr 2019 10:55:23 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:36756 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726751AbfDPOzW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Apr 2019 10:55:22 -0400
Received: by mail-pg1-f194.google.com with SMTP id 85so10477056pgc.3;
        Tue, 16 Apr 2019 07:55:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=h5lj1gghN6sLzB8P8PsOd/8lnM1lSwrScwwzcgsBFOw=;
        b=pCz+2X8ORA0fAd5nUseqMAAc9lxUBn0sZvkyN38GmYew8mjAIw+7jqTa+xiYR1hP6v
         6/9kvDbg2V8TaljcUSR8T22xSOW0U9IQumqAMGVsipzxYi5bmzEeReHKHGEXAuePfX1B
         Gtc8TKl2RVx/R+GmUQCzQwtvw0kUR/GVFwUCSpQPYU8LFv+6tUtui7lI2fCtzYPR6xrq
         F4fWCbn9fDwZf6nMvMft2glCyd4+7KKzN3sCL8PkDv1za6KNPzkSCdkWTBSPrLL33X/c
         y1vP+F+nVrFPpNOQEqYiAuljeIaVpccNdR+uokGHhzV9IVqOAmg2YBQcyvuCCaX/KP9s
         JQyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=h5lj1gghN6sLzB8P8PsOd/8lnM1lSwrScwwzcgsBFOw=;
        b=AJiV+Qlyf1UOkT5OjIdtdYJE3V+C49yU6pbNpvag9njTnklzURlbk3VhuWsu2gNYoc
         ZD5E120rsB/LyKXYfMNQvDZOcADuHswduYcCtIM5Y7sAIyvpVoRWoz4DghL/UCdqimiC
         oQvVcUobWZ/jKvGMw/qghAxaenLFnAsQywj2qmOUE7GXUSXCxvcFtSu2S62Qs0FaW+6g
         Lxy9wQztGMDXA+SalV39yfHlhsp+M4n67PBUud9G/Sov8liBTwtkZcj+fHqHYpdQ1uEK
         NBjHQdtqCxwnSTJBjUaXGQDaA9GCrGDQOE1v0YjQnj5NG3HvR9ITsMxereUPl++Jo/1j
         8z5g==
X-Gm-Message-State: APjAAAWjFio47dzD5bZl186B3UlyWt+uXOr0PLpZjmuh9h1Lckd4ufNi
        Hs3HBXLgDM0fM+2DtgXWaeM=
X-Google-Smtp-Source: APXvYqxeWtbapT2u2GF2ntnqZTAq1Ax39Q3nJiPgpPse0X/k+7MdHqGHJTijrBnlTJsLTx3UWSbSoQ==
X-Received: by 2002:a62:61c2:: with SMTP id v185mr83648369pfb.117.1555426521601;
        Tue, 16 Apr 2019 07:55:21 -0700 (PDT)
Received: from mail.google.com ([104.238.181.70])
        by smtp.gmail.com with ESMTPSA id l4sm36189479pgh.17.2019.04.16.07.55.20
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 16 Apr 2019 07:55:20 -0700 (PDT)
Date:   Tue, 16 Apr 2019 14:55:19 +0000
From:   Changbin Du <changbin.du@gmail.com>
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        Linux Doc Mailing List <linux-doc@vger.kernel.org>,
        Mauro Carvalho Chehab <mchehab@infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Jonathan Corbet <corbet@lwn.net>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Len Brown <lenb@kernel.org>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        Changbin Du <changbin.du@gmail.com>
Subject: Re: [PATCH 02/57] docs: acpi: convert text files to ReST
Message-ID: <20190416145518.xigzqsawvbrospir@mail.google.com>
References: <cover.1555382110.git.mchehab+samsung@kernel.org>
 <10802a7ac16958a2786c2fc083fb5cb50eb7ebb9.1555382110.git.mchehab+samsung@kernel.org>
 <CAJZ5v0hZK07zQzmD6J0J5dBUAecpE_31_W5Ade5UpWrsWBeU+Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJZ5v0hZK07zQzmD6J0J5dBUAecpE_31_W5Ade5UpWrsWBeU+Q@mail.gmail.com>
User-Agent: NeoMutt/20180716-508-7c9a6d
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 16, 2019 at 10:17:11AM +0200, Rafael J. Wysocki wrote:
> On Tue, Apr 16, 2019 at 5:02 AM Mauro Carvalho Chehab
> <mchehab+samsung@kernel.org> wrote:
> >
> > Most of the files are already in good shape, making easier to
> > convert them to ReST by adding proper title markups and
> > addressing some identation and markups to properly format the
> > document.
> 
> There is concurrent work on this under way, please see
> https://marc.info/?t=155381845300002&r=2&w=2
> 
I will update the serias asap. I am just a little busy these days. My
conversion includes pci, acpi and x86, others are not touched.

> I'd prefer that one to continue, honestly.
> 
> Thanks,
> Rafael

-- 
Cheers,
Changbin Du

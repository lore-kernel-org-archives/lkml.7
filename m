Return-Path: <SRS0=X8En=XO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C8C40C4CEC9
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Sep 2019 00:05:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9A290218AF
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Sep 2019 00:05:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="F7fu/kCd"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730500AbfISAFi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 18 Sep 2019 20:05:38 -0400
Received: from mail-qt1-f196.google.com ([209.85.160.196]:39852 "EHLO
        mail-qt1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727273AbfISAFi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Sep 2019 20:05:38 -0400
Received: by mail-qt1-f196.google.com with SMTP id n7so1991752qtb.6
        for <linux-kernel@vger.kernel.org>; Wed, 18 Sep 2019 17:05:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=NBGDkciQM96PlADwiS6Ecn8jjQWg9GBn83vtaVwDbH4=;
        b=F7fu/kCdJpx4U0F7B82qRuisn7vshNg319dix7xkITNkq8ZJUHoY78k/2wG8bc5a0p
         2rsBNZ2L2VcRGViAUVMaIlCWStcCG+MSZtQBmMnix7zq0P3NbDWk++QjZsGwLmWnSMdU
         hiaI0toddG/o78kORuJVD07nhuKEctHF7MhFajLYZykQUfzz4Pq+aFVRUPPKab5deUYR
         JYyd9VBoIhk1GHu3Gz/h2/HH7yZV2ItCpEp+M4HHH/SLlM8V9vrNeNI2Eg7fb8lN+54Y
         WqAqVHRDXBIhcR0pHOuxJSSvdQIkEnuL/8+PzmsmxP1Ih8LEeKDDFMmj7LH8O5Cq7mKM
         InQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=NBGDkciQM96PlADwiS6Ecn8jjQWg9GBn83vtaVwDbH4=;
        b=mZOe4VJQZkPwU78+wZJJGTnhnhYIOCzRivmVBP7FtSSDAktO6bGSsS4u0+4/5aDZfS
         ORKnP6wmA4s4eKi0OH1CPve0Mrbor8DPUW09D4dCbrVo9BiB2o58euUjtJvjJV4dZ/dP
         PGnxojfh+nzPapKW935f78FFV2ypj4qBKHz1NM83ZpGy7vlPgltnRyNiHaOXk07kciq5
         grlcufu+QlGcigVo4hjm2ekbzjVY4yPrKRt6UiAuSSrNdmddSEVxMuLrF0KxzJifJt/i
         wGwSZnz3vouAlFbctyR7Fua67qbmThlVOn39Fb02ABNC3hTH04w95ImpvEOytD873cDz
         yNpw==
X-Gm-Message-State: APjAAAU97LJxdYQhqOj78qrzUbYL7r2JGKf5hwclCIYRKqDTRQXkdYj6
        odGt4ljpVTGeT/uEcAnV39wbfw0o
X-Google-Smtp-Source: APXvYqwwvzYOGL92W3RbDuk2kMUHSwL/Jadn9bIMbGiMngW0Upv5wZjaWKRWMI3xC8w2fPTrEQy11g==
X-Received: by 2002:aed:3f7d:: with SMTP id q58mr433021qtf.347.1568851536003;
        Wed, 18 Sep 2019 17:05:36 -0700 (PDT)
Received: from quaco.ghostprotocols.net ([179.97.35.50])
        by smtp.gmail.com with ESMTPSA id g3sm3655700qkb.117.2019.09.18.17.05.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Sep 2019 17:05:35 -0700 (PDT)
From:   Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>
X-Google-Original-From: Arnaldo Carvalho de Melo <acme@kernel.org>
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 8A55C40340; Wed, 18 Sep 2019 21:05:32 -0300 (-03)
Date:   Wed, 18 Sep 2019 21:05:32 -0300
To:     Ravi Bangoria <ravi.bangoria@linux.ibm.com>
Cc:     Anju T Sudhakar <anju@linux.vnet.ibm.com>, mpe@ellerman.id.au,
        jolsa@redhat.com, namhyung@kernel.org, peterz@infradead.org,
        alexander.shishkin@linux.intel.com, linux-kernel@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org, maddy@linux.vnet.ibm.com
Subject: Re: [PATCH v2 1/3] tools/perf: Move kvm-stat header file from
 conditional inclusion to common include section
Message-ID: <20190919000532.GE32051@kernel.org>
References: <20190718181749.30612-1-anju@linux.vnet.ibm.com>
 <1afefd12-b9c5-77b6-c371-bef9fd6f788b@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1afefd12-b9c5-77b6-c371-bef9fd6f788b@linux.ibm.com>
X-Url:  http://acmel.wordpress.com
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Fri, Jul 19, 2019 at 10:58:37AM +0530, Ravi Bangoria escreveu:
> 
> LGTM. For the series,
> 
> Reviewed-By: Ravi Bangoria <ravi.bangoria@linux.ibm.com>


Thanks, applied.

- Arnaldo

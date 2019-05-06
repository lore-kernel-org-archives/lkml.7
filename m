Return-Path: <SRS0=ecL9=TG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,T_DKIMWL_WL_HIGH,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 724C0C04A6B
	for <linux-kernel@archiver.kernel.org>; Mon,  6 May 2019 15:46:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4255720B7C
	for <linux-kernel@archiver.kernel.org>; Mon,  6 May 2019 15:46:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1557157601;
	bh=O3MvupIqAlBznwADna4riHwFUtDysvOaBP2ZD8ubpjg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=k5DyaiZ75g8JDC+J8Myi+HMFH2PBaalUgu+jt9VpCpwbH7UlNwOcphGettuTnBIfO
	 ehm/Vjoit6YugC6Ndb1MZOuZr+C699b+uouhE3GYddWM/QIIyMNU2YCRDvwNXRfYAU
	 fQP/LEtTHKyfY4xiEeiDRWDkNO4T9NSimjehjtaM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726909AbfEFPqk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 May 2019 11:46:40 -0400
Received: from mail-qt1-f193.google.com ([209.85.160.193]:35233 "EHLO
        mail-qt1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726321AbfEFPqj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 May 2019 11:46:39 -0400
Received: by mail-qt1-f193.google.com with SMTP id d20so5180421qto.2;
        Mon, 06 May 2019 08:46:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=lXQvw+zp+N33bb9guBw4WQqWlonXTLii4rMWOOFeOIg=;
        b=dU2NZXWQ7YnYb9ycqqTB+h49uzgmVKDADAwnHw9iWFp9wip3Tc0RdRVxac66mNuTgk
         4bim278kH1u2eNKoD84smILsRZONvqoTibhBF40u9Qw2YnorGSrAeRc7fcbbv9zQKR1q
         pnExSVmOitOgU3ppFENP6TS4v4e2pJ/ptx073lkTQIUcDrgRLkipVT4ho50UrV1cQqzh
         J82vr7UysGFU4nYFWfgR9i7QGIHYc7BzHhiDLyn+4oFiCFbTdCoFIMnlNIrJvjvPgR/0
         423pRGLqM6++O18qV1iWgBk6nekzRNwMKL/oGk5kOaB0h64Wq5pg8o2uhlOzZX9kLtZE
         dqSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=lXQvw+zp+N33bb9guBw4WQqWlonXTLii4rMWOOFeOIg=;
        b=nbrzqrmf8ChtGHKe2oBtWYR3NUHNwf60LmeeFnm2dvyap17LxBPeHYBac0Ngzg0Bhr
         DbUBcSljNtw3VQ6+Q2n4Z0Bnp3QYBILaieaxmLU1GGNHOxgVl0Te5nSjWVKHa2lXt/6h
         4Fgv+9v4dyuS9vwTiy+vgTBcDACe8pvNOuxSH+efkWu5n0smvapl74nhCyuRUnYPoNPv
         6uYEsfWXuSh/o9Ed4oPyWoSdoqClHRybCxpTi+eaDnsiANlVvnvM5Td5eoPVn2kstjdA
         bHjFpchDx387Rz6oRu/lTnLGpL5nSSphemVRaulLWLJiGPo1ux5CHU9VB8UEeTgK5NSv
         aILw==
X-Gm-Message-State: APjAAAWl49Rm9u6+yQfps0PLZrsjF3gmaV2cNTIjKjqKtw1MxBpZBTen
        zIQjHjo8RIjq1vgQepwYreo=
X-Google-Smtp-Source: APXvYqwlYjdf8YiRCcig1E6Ez6k+nVomC4ZqNryrQkv+jSvm3asHmuW0t59t8u53R2q519Gj7l8D0w==
X-Received: by 2002:a0c:b505:: with SMTP id d5mr21475765qve.62.1557157598572;
        Mon, 06 May 2019 08:46:38 -0700 (PDT)
Received: from localhost ([2620:10d:c091:500::3:34f3])
        by smtp.gmail.com with ESMTPSA id p63sm645310qkd.1.2019.05.06.08.46.37
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 06 May 2019 08:46:37 -0700 (PDT)
Date:   Mon, 6 May 2019 08:46:36 -0700
From:   Tejun Heo <tj@kernel.org>
To:     Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
Cc:     Linux Doc Mailing List <linux-doc@vger.kernel.org>,
        Mauro Carvalho Chehab <mchehab@infradead.org>,
        linux-kernel@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>,
        Balbir Singh <bsingharora@gmail.com>,
        Li Zefan <lizefan@huawei.com>,
        Johannes Weiner <hannes@cmpxchg.org>, cgroups@vger.kernel.org
Subject: Re: [PATCH v2 57/79] docs: accounting: convert to ReST
Message-ID: <20190506154636.GR374014@devbig004.ftw2.facebook.com>
References: <cover.1555938375.git.mchehab+samsung@kernel.org>
 <13b52516ab787b9a9637e6b9adfec88ec1931b99.1555938376.git.mchehab+samsung@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <13b52516ab787b9a9637e6b9adfec88ec1931b99.1555938376.git.mchehab+samsung@kernel.org>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 22, 2019 at 10:27:46AM -0300, Mauro Carvalho Chehab wrote:
> Rename the accounting documentation files to ReST, add an
> index for them and adjust in order to produce a nice html
> output via the Sphinx build system.
> 
> At its new index.rst, let's add a :orphan: while this is not linked to
> the main index.rst file, in order to avoid build warnings.
> 
> Signed-off-by: Mauro Carvalho Chehab <mchehab+samsung@kernel.org>

Acked-by: Tejun Heo <tj@kernel.org>

Thanks.

-- 
tejun

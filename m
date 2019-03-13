Return-Path: <SRS0=dUEL=RQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BF560C43381
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Mar 2019 19:40:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8F3D620693
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Mar 2019 19:40:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="O7xVoJzW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727145AbfCMTkJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Mar 2019 15:40:09 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:38906 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726711AbfCMTkI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Mar 2019 15:40:08 -0400
Received: by mail-pf1-f193.google.com with SMTP id n125so2094365pfn.5
        for <linux-kernel@vger.kernel.org>; Wed, 13 Mar 2019 12:40:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=snc6Ork/CbnW4aA+r4q79osqVivb9WQcalZI9jap9gg=;
        b=O7xVoJzWE1v+zkAKfm6mI3UNTFfkHJZ5INYqgJkoN0ngJb/KOHAhTfJ4WLcKi4tydE
         HmIfV/EWx+4OSZLqjZys++/4XRo8wDdYG0KFcWS8neMu0z1C28tfsDqZ7wc3T4Ixg9Fp
         t/InlYoObDlv+ANWezKsPx+BigM/t5gphefKWS5GH4LrKlpAD3YaxV89Gpf5j6SWcDp8
         m7G51OY9kyZl+HSPbHCFDHS0hzjjSfShJ+trSc/CoyLSP16jNoNWdmG2sAc97cxts+gt
         xgLBvyMo9r5sXbbD58unycsZBMP0lL7TGiD6CxRYxC3vp7w0WddOuRef0yZOEnOHgHvn
         ir7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=snc6Ork/CbnW4aA+r4q79osqVivb9WQcalZI9jap9gg=;
        b=ci0lVjIt6/9cZz1XVBjcT46PUHpeOyfUEK53OmdGhJOEBhWc7eLtAyuq4n04Nh2g9p
         TuVv7tDpujyTxI1K2+UN/zpTckSStOnwbvmxuDXumZivYxePxu1qbURw0e4T8vxV9IwW
         fiuwl8gRr0DG4FM3HfB+r77bOii5pDT+QRfsce9hgTv1CqgY5ErCIXMUyjSDgDw3zK2H
         0kxaWKZr8Jkao7KME+WMHME3I4cl/lwKd2GkrKEplFZs9oeNb8ltZY5zhbzhNAMYuW/S
         MbirSF6+hXVHU0OuycFUgc6n2IXZTCW3eY2SvMseu0WmTkcschS2dH8oBxF4rBcMvgsy
         ckPw==
X-Gm-Message-State: APjAAAU3vCwq7IQL/1sa+trIowd3071Bv0jVFj2Da/31NDOcJ2N5fQQl
        7toKpD1VIy38IFu7diu1O1A/Ig==
X-Google-Smtp-Source: APXvYqxDmArVyp8k+FmTaBseTMT9ZD2T2Y4XtWqxT59tGvT0RaBPdteJaIsXLmkmPW8Md7hauqJMWw==
X-Received: by 2002:a63:fb0b:: with SMTP id o11mr24119027pgh.222.1552506007745;
        Wed, 13 Mar 2019 12:40:07 -0700 (PDT)
Received: from gnomeregan.cam.corp.google.com ([2620:15c:6:14:ad22:1cbb:d8fa:7d55])
        by smtp.googlemail.com with ESMTPSA id c19sm11427006pgc.45.2019.03.13.12.40.05
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 13 Mar 2019 12:40:06 -0700 (PDT)
Subject: Re: [PATCH] percpu/module resevation: change resevation size iff
 X86_VSMP is set
To:     Christopher Lameter <cl@linux.com>
Cc:     Dennis Zhou <dennis@kernel.org>, Eial Czerwacki <eial@scalemp.com>,
        tj@kernel.org, linux-kernel@vger.kernel.org,
        Shai Fultheim <shai@scalemp.com>,
        Oren Twaig <oren@scalemp.com>,
        "Paul E. McKenney" <paulmck@linux.ibm.com>
References: <1548071251-1849-1-git-send-email-eial@scalemp.com>
 <a7eff2ed-0e80-edae-2a97-a3fdab2d05f5@google.com>
 <20190301203455.GA97188@dennisz-mbp.dhcp.thefacebook.com>
 <c72402f2-967e-cd56-99d8-9139c9e7f267@google.com>
 <010001693b404440-248fa987-624c-4587-940b-56e2ed4226d9-000000@email.amazonses.com>
From:   Barret Rhoden <brho@google.com>
Message-ID: <85726648-82f3-6b6b-a749-03c4159e78f3@google.com>
Date:   Wed, 13 Mar 2019 15:40:04 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <010001693b404440-248fa987-624c-4587-940b-56e2ed4226d9-000000@email.amazonses.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi -

On 03/01/2019 04:54 PM, Christopher Lameter wrote:
> On Fri, 1 Mar 2019, Barret Rhoden wrote:
> 
>> I'm not familiar with VSMP - how bad is it to use L1 cache alignment instead
>> of 4K page alignment?  Maybe some structures can use the smaller alignment?
>> Or maybe have VSMP require SRCU-using modules to be built-in?
> 
> It is very expensive. VMSP exchanges 4K segments via RDMA between servers
> to build a large address space and run a kernel in the large address
> space. Using smaller segments can cause a lot of
> "cacheline" bouncing (meaning transfers of 4K segments back and forth
> between servers).
> 

Given that these are large machines, would it be OK to statically 
reserve 64K on them for modules' percpu data?

The bug that led me to here was from someone running on a non-VSMP 
machine but had that config set.  Perhaps we make it more clear in the 
Kconfig option to not set it on other machines.  That might make it less 
likely anyone on a non-VSMP machine pays the 64K overhead.

Are there any other alternatives?  Not using static SRCU in any code 
that could be built as a module seems a little harsh.

Thanks,

Barret


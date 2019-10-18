Return-Path: <SRS0=6OEZ=YL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 778EBCA9ED1
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Oct 2019 05:01:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 43792222C3
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Oct 2019 05:01:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FZ0tEDaK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2409574AbfJRFBM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 18 Oct 2019 01:01:12 -0400
Received: from mail-pl1-f194.google.com ([209.85.214.194]:36436 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2407184AbfJRFBM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Oct 2019 01:01:12 -0400
Received: by mail-pl1-f194.google.com with SMTP id j11so2256918plk.3;
        Thu, 17 Oct 2019 22:01:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=wpJfPZmMYz1gHLTNi+cKJTn1LIoYcx1Zone10S78hMg=;
        b=FZ0tEDaKSb1fjZ35ji80nGBEkLxkXPIXJ2FvWbrkcMTHJwnnbaOejUCN23Q2cfSp7G
         a7iRe4brGFHMvYqxelgkcTNRPK22hSf8NEaUxvPvNabN9WcB7jUijIgIlDZ2JHj0Roiu
         p4+P+kEoqzv/73jmaP3gRXUkHTOXN5rXd/uiS8b+WphgcEU4zkHXzjtZOvDwIR+7W41V
         WJxIBek3fEIO+i+u7AAhsDfy5UOXgdrJxiuVJ6gzALiWuHWdIK3zkT/slxgCkweStRkr
         gbOrWYsJ4MojCeGdlm51kVCrSD0cEqz1g70jncmaD2Xn0KWjig8Yto64REnBiVZqrJ19
         CRPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=wpJfPZmMYz1gHLTNi+cKJTn1LIoYcx1Zone10S78hMg=;
        b=kkFcHpMDYhX+7ugzXM/NJmmbU/bCUbaC8S7p8IoJRE+xVS+z+wYUGRSJmI7HgQsgdF
         MQo5/tjDCC6SrqOJEUxTCUAlmZwuLiBxIEPh82PHHYSlTVoSzVF7MZJ4OUQO+JLWqyQz
         WJnofjjwOmSlo3HSM5GR2hgolILxcoUbORxQ73YBMIVg5vSTGSSaWGt2LU1i8jXxsNxz
         Cv3XGmUoGLdgjVNZA+HdGjZcZHKEWwrF8IOegQn8+OqQG1vPIpvQOScveq2r70cSQHbB
         h9WVrMl2jNBNuERS6d/dCPl01lCmmJUPev9tlSvilDeAYeltH0SeollwTOLAruOYryhZ
         82lA==
X-Gm-Message-State: APjAAAVQ5ofgOtxXC8lAO9We2RyXRGiMYZSo40FbtekJT2oRw1YtAutG
        QlnyTBj+frn/CisViK0/WlDD8gvB
X-Google-Smtp-Source: APXvYqyyRC3rRWHEdU/4ehIqVTyMDDP6d3MBshcdRrCKVsJhdcNuojXErnWWf00fZs7sEBIVI05X/w==
X-Received: by 2002:a17:902:b94b:: with SMTP id h11mr7840953pls.21.1571374871038;
        Thu, 17 Oct 2019 22:01:11 -0700 (PDT)
Received: from ast-mbp ([2620:10d:c090:180::cfd0])
        by smtp.gmail.com with ESMTPSA id s141sm5721197pfs.13.2019.10.17.22.01.09
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 17 Oct 2019 22:01:10 -0700 (PDT)
Date:   Thu, 17 Oct 2019 22:01:08 -0700
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
To:     Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     Daniel Borkmann <daniel@iogearbox.net>,
        Alexei Starovoitov <ast@kernel.org>,
        Networking <netdev@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        ppc-dev <linuxppc-dev@lists.ozlabs.org>
Subject: Re: linux-next: build warning after merge of the bpf-next tree
Message-ID: <20191018050107.dsnt4ukq6n6l6luy@ast-mbp>
References: <20191018105657.4584ec67@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191018105657.4584ec67@canb.auug.org.au>
User-Agent: NeoMutt/20180223
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 18, 2019 at 10:56:57AM +1100, Stephen Rothwell wrote:
> Hi all,
> 
> After merging the bpf-next tree, today's linux-next build (powerpc
> ppc64_defconfig) produced this warning:
> 
> WARNING: 2 bad relocations
> c000000001998a48 R_PPC64_ADDR64    _binary__btf_vmlinux_bin_start
> c000000001998a50 R_PPC64_ADDR64    _binary__btf_vmlinux_bin_end

Can ppc folks help me figure out what this warning means?


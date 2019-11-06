Return-Path: <SRS0=fWiu=Y6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6159EC5DF62
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Nov 2019 04:32:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 107242075C
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Nov 2019 04:32:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="XoBmyDfv"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731249AbfKFEcu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 5 Nov 2019 23:32:50 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:50662 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726368AbfKFEct (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Nov 2019 23:32:49 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        Content-Type:In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:
        Subject:Sender:Reply-To:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=PMimL9+oB2bOWW84I/hNElf9NkYqwMaoxNkbiyzsGX0=; b=XoBmyDfvf+NlaUhoQ/dYQZsuv
        8G7aO9Tbcnx8GuOPcDblc4JFz6Te0esLvcMIUF9/WrFUXtjDAQx/zp5/7hcSsEIogFDQQVlN+gsNI
        iyrkl3yb+6ulq/y9BGAGCyNVPNIYp4n28s4uaEnmhZ87K1Ot5mlbXNQJ2cwDAuUd+iBVPbAkW2E++
        Bsb5T1U0xRhxozcUBCNUBHEZRcbh38lxhmguipZL31FpxDCfENxWDYy+RJV3FhIz6TJenTMD0/dAx
        ncO/x/R0UKwkUPQGPxc2Whf/tvYG1gWcqwHaImfobHd+fjaPLi7YOAyABqzR6RGnR8GmeBwtOLhLA
        SbpoNhdcQ==;
Received: from [2601:1c0:6280:3f0::4ba1]
        by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1iSCzw-0005ec-M2; Wed, 06 Nov 2019 04:32:48 +0000
Subject: Re: [PATCH] scripts:prune-kernel:remove old kernels and modules dir
 from system
To:     "J. Bruce Fields" <bfields@fieldses.org>,
        Masahiro Yamada <yamada.masahiro@socionext.com>
Cc:     Bhaskar Chowdhury <unixbhaskar@gmail.com>,
        Michal Marek <michal.lkml@markovi.net>,
        Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <20191102063036.28601-1-unixbhaskar@gmail.com>
 <50680c37-9e85-0050-c1e1-700260a0471c@infradead.org>
 <20191105023243.GA16635@fieldses.org>
 <CAK7LNARAgOEnMRYAyzbvJ-xZzFfwOMckxb=bW0-E+P1HYu5nhA@mail.gmail.com>
 <20191106043120.GB6355@fieldses.org>
From:   Randy Dunlap <rdunlap@infradead.org>
Message-ID: <2754bf80-2653-5d94-6b1e-f33a34914b77@infradead.org>
Date:   Tue, 5 Nov 2019 20:32:47 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
MIME-Version: 1.0
In-Reply-To: <20191106043120.GB6355@fieldses.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/5/19 8:31 PM, J. Bruce Fields wrote:
> On Wed, Nov 06, 2019 at 11:53:28AM +0900, Masahiro Yamada wrote:
>> BTW.
>> Bruce,
>> Does the current script expect RHEL or something?
>> I do not see 'new-kernel-pkg' on my Ubuntu machine.
> 
> I test on Fedora.  Looks like on recent Fedora that's only provided by
> an rpm "grubby-deprecated", which is an inauspicious name....
> 
> I think maybe you're supposed to use "grubby" itself now.  Do you have
> that?
> 
>> It would still work with 'new-kernel-pkg: command not found'
>> warning.
>>
>> We could bypass it if we like.
>>
>> command -v new-kernel-pkg && new-kernel-pkg --remove $f
> 
> Looks like it's what updates the grub configuration, which is probably a
> nice thing to do if you can.

on openSUSE, I don't have new-kernel-pkg or grubby.

-- 
~Randy

